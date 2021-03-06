(:~
 : This module contains some basic examples for RESTXQ annotations
 : @author BaseX Team
 :)
module namespace page = 'http://basex.org/modules/web-page';
import module namespace parser = "MyParser";

(:~
 : This function generates the welcome page.
 : @return HTML page
 :)
declare
  %rest:path("")
  %output:method("xhtml")
  %output:omit-xml-declaration("no")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
  function page:start()
  as element(Q{http://www.w3.org/1999/xhtml}html)
{
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>BaseX HTTP Services</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <div class="right"><img src="static/basex.svg" width="96"/></div>
      <h2>BaseX HTTP Services</h2>
			<div>Welcome to the BaseX HTTP Services, which allow you to...</div>
			<ul>
				<li>Query and modify databases via <a href="http://docs.basex.org/wiki/REST">REST</a> (try <a href='rest'>here</a>)</li>
				<li>Browse and update resources via <a href="http://docs.basex.org/wiki/WebDAV">WebDAV</a></li>
				<li>Create web applications and services with <a href="http://docs.basex.org/wiki/RESTXQ">RESTXQ</a></li>
			</ul>

      <p>This page was generated by RESTXQ. It facilitates the
      use of XQuery as a server-side processing language for the Web.</p>

      <h3>Example 1</h3>
      <p>The following links return different results.
      Both are generated by the same RESTXQ function:</p>
      <ul>
        <li><a href="hello/World">/hello/World</a></li>
        <li><a href="hello/Universe">/hello/Universe</a></li>
      </ul>

      <h3>Example 2</h3>
      <p>The next example presents how form data is processed via RESTXQ and the POST method:</p>
      <form method="post" action="form">
        <p>Your message:<br />
        <input name="message" size="50"></input>
        <input type="submit" /></p>
      </form>

      <h3>Example 3</h3>
      <p>The source code of the file that created this page
      (<code>{ static-base-uri() }</code>) is shown below:</p>
      <pre>{ unparsed-text(static-base-uri()) }</pre>
    </body>
  </html>
};

(:~
 : This function returns an XML response message.
 : @param $world  string to be included in the response
 : @return response element 
 :)
declare
  %rest:path("/hello/{$world}")
  %rest:GET
  function page:hello(
    $world as xs:string)
    as element(response)
{
  <response>
    <title>Hello { $world }!</title>
    <time>The current time is: { current-time() }</time>
  </response>
};

(:~
 : This function returns the result of a form request.
 : @param  $message  message to be included in the response
 : @param $agent  user agent string
 : @return response element 
 :)
declare
  %rest:path("/form")
  %rest:POST
  %rest:form-param("message","{$message}", "(no message)")
  %rest:header-param("User-Agent", "{$agent}")
  function page:hello-postman(
    $message as xs:string,
    $agent   as xs:string*)
    as element(response)
{
  <response type='form'>
    <message>{ $message }</message>
    <user-agent>{ $agent }</user-agent>
  </response>
};

(:~
 : This function is the entry point of the forum. All databases in the basex database are validated against our schema.
 : If validating succeeds, the database is listed as a category entry.
 : @return index page of forum
 :)
declare
  %rest:path("/index")
  
 function page:hello-index()
    as node()*
{
let $schema := fn:doc("http://localhost:8984/static/forumSchema.xsd")
let $target := 'xml-stylesheet',
$content := 'href="../static/forumstart.xsl" type="text/xsl" '
  let $cats := <forum>{
    for $x in db:list()
	  where
	  $x != "dblp"
			and $x != "dblpdatabase"
	  return 
	  try {
	   validate:xsd(db:open($x), $schema),
	   <kategorie><name>{data($x)}</name></kategorie>
	  }
	  catch * {
		(: in case an exception is thrown :)
		<noValidDatabaseFound/>
	  }
 }</forum>
return document { processing-instruction {$target} {$content}, $cats}
};



(:~
 : Displays all themes of a category
 : @param $kat  name of category
 : @return response element 
 :)
declare
  %rest:path("/forum/{$kat}")
  %rest:GET
  function page:show-thema(
    $kat as xs:string)
    as node()
{
 let $target := 'xml-stylesheet',
$content := 'href="../static/forumkat.xsl" type="text/xsl" '
return document {
   processing-instruction {$target} {$content},
 db:open($kat)
}
};

(:~
 : Displays as entries of a certain theme. 
 : auskat element is used to identify the category of the theme within xsl.
 : @param $kat name of category
 : @param $title name of theme
 : @return response element 
 :)
declare
  %rest:path("/forum/{$kat}/{$title}")
  %rest:GET
  function page:show-entries(
    $kat as xs:string, $title as xs:string)
    as node()

{
 let $target := 'xml-stylesheet',
$content := 'href="http://localhost:8984/static/forumseintrag.xsl" type="text/xsl" '
return document {
   processing-instruction {$target} {$content},
   <auskat kat="{$kat}">
{db:open($kat)/kategorie/thema[@titel=$title]}
</auskat>
}
};


(:~
 : Shows form to add a new category. Permissions are checked later (see form action).
 :)
declare
  %rest:path("/add/kat")
  function page:add-kat()
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Einfuegen einer neuen Kategorie</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="kat/new">
	  	   <p>Username<br /></p>
		<input name="user" size="50"></input>
				<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12"> </input>
        <p>Name der Kategorie:<br />
        <input name="name" size="50"></input>
        <input type="submit" /></p>
      </form>
	</body>
</html>
};


(:~
 : Adds a new theme to a certain category.
 : @param $var category where new theme should be inserted
 :)
declare
  %rest:path("/add/{$var}/thema")
  %rest:GET
  function page:add-thema($var as xs:string)
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Einfuegen eines neuen Themas</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="thema/new">
	  	   <p>Username<br /></p>
		<input name="user" size="50"></input>
				<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
        <p>Name des neuen Themas:<br />
        <input name="name" size="50"></input>
        <input type="submit" /></p>
      </form>
	</body>
	</html>
};

(:~
 : This function adds a new category. 
 : It is checked if the given credentials have sufficient permissions (admin).
 : If user lacks permission, category is not added.
 : @param $name name of category
 : @param $user name of user
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/add/kat/new")
  %rest:POST
  %rest:form-param("name","{$name}", "(no name)")
  %rest:form-param("user","{$user}", "(no user)")
  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:new-kat(
        $name as xs:string,$user as xs:string, $password as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user existiert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="admin") then
 (
 if(db:exists($name) eq false()) then
 (
	let $input := <kategorie name="{$name}"></kategorie>
	return(
    db:create($name,<kategorie name="{$name}"></kategorie>,"xmld.xml"),
	db:output(<restxq:redirect>/forum/{$name}</restxq:redirect>)
	))
	else
 (db:output("Die Kategorie ist schon vorhanden")))
 else
 (db:output(<response> Dieser user ist dafuer nicht berechtigt.</response>)))
 };



(:~
 : This function adds a new theme to existing category. 
 : It is checked if the given credentials have sufficient permissions (user).
 : If user lacks permission, theme is not added.
 : @param $var name of category
 : @param $name name of theme
 : @param $user name of user
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/add/{$var}/thema/new")
  %rest:POST
  %rest:GET
  %rest:form-param("name","{$name}", "(no name)")
   %rest:form-param("user","{$user}", "(no user)")
  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:new-thema(
        $name as xs:string, $var as xs:string, $password as xs:string, $user as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="user") then
 (
  if(empty(db:open($var)/kategorie/thema[@titel=$name])) then
  (
	let $db := db:open($var)
	return (
		insert node <thema titel="{$name}"> </thema> into $db/kategorie,
		 db:output(<restxq:redirect>/forum/{$var}/{$name}/</restxq:redirect>)
	 )
   )
	else
 (db:output("Das Thema ist schon vorhanden")))
  else
 (db:output(<response> Dieser User ist dafuer nicht berechtigt.</response>)))
};

(:~
 : This function adds a new entry to an existing theme. 
 : @param $kat name of category
 : @param $thema name of theme
 : @return response element 
 :)
declare
  %rest:path("/add/eintrag/{$kat}/{$thema}")
  %rest:GET
  function page:add-eintrag($kat as xs:string, $thema as xs:string)
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Einfuegen eines neuen Eintrags</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="new">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
        <p>Text des neuen Eintrages:<br />
        <input name="text" size="50"></input>
		 <input type="hidden" name="thema" value="{$thema}">
</input>
        <input type="submit" /></p>
      </form>
	</body>
	</html>
};


(:~
 : This function adds a new entry to an existing theme. 
 : It is checked if the given credentials have sufficient permissions (user).
 : If user lacks permission, entry is not added.
 : @param $kat name of category
 : @param $text text of entry
 : @param $thema name of theme
 : @param $user name of user
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/add/eintrag/{$kat}/new")
  %rest:POST
  %rest:GET
  %rest:form-param("text","{$text}", "(no text)")
    %rest:form-param("thema","{$thema}", "(no thema)")
	  %rest:form-param("user","{$user}", "(no user)")
  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:new-eintragadd(
        $text as xs:string, $kat as xs:string,$thema as xs:string, $password as xs:string, $user as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="user") then
 (
  
	let $db := db:open($kat)
	let $schema := fn:doc("http://localhost:8984/static/forumSchema.xsd")
	let $id := 
	( if(empty(data($db/kategorie/thema[@titel=$thema]//eintrag/@id))) then (1)
			else
			(max(data($db/kategorie/thema[@titel=$thema]//eintrag/@id))+1)
	)
	let $ttext := if(fn:contains($text,"&lt;eintrRef")) then
		let $anf := substring-before($text, "&lt;eintrRef")
		let $ende := substring-after($text,"/&gt;")
		let $ref := substring-before(substring-after($text, "&lt;eintrRef"),"/&gt;")
		let $eref := substring-before(substring-after($ref,'eintragRef="'),'"')
		let $themref := substring-before(substring-after($ref,'themaRef="'),'"')
		 return
		   <eintrag id="{$id}" autor="{$user}" thema="{$thema}">
		<text> {$anf} <eintrRef eintragRef="{$eref}" themaRef="{$themref}"> </eintrRef> </text>
	   </eintrag>
	   else
	   <eintrag id="{$id}" autor="{$user}" thema="{$thema}">
		<text> {$text}</text>
	   </eintrag>
	return
	(
	  insert node 
	   $ttext
	  into $db/kategorie/thema[@titel=$thema],
			db:output(<restxq:redirect>/forum/{$kat}/{$thema}/checkEintrag</restxq:redirect>)
			  
	)
 ) else
 (db:output(<response> Dieser user ist dafuer nicht berechtigt.</response>))

)
};

(:~
 : This function adds a new entry as answer to an existing entry. 
 : If user lacks permission, entry is not added.
 : @param $kat name of category
 : @param $text text of entry
 : @param $thema name of theme
 : @param $id of entry that is answered
 : @param $user name of user
 : @param $password password of user
 : @return response element 
 :)
declare
  %rest:path("/add/eintrag/{$kat}/{$thema}/{$id}")
  %rest:GET
  function page:add-eintragafter($kat as xs:string, $thema as xs:string, $id as xs:integer)
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Einfuegen eines neuen Eintrags</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="/add/eintrag/new">
		 <p>Username<br /></p>
		<input name="user" size="50"></input>
				<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
        <p>Text des neuen Eintrages nach {$id}:<br />
        <input name="text" size="50"></input>
		<input type="hidden" name="kat" value="{$kat}">
</input>
		 <input type="hidden" name="thema" value="{$thema}">
</input>
<input type="hidden" name="id" value="{$id}">
</input>
        <input type="submit" /></p>
      </form>
	</body>
	</html>
};

(:~
 : This function adds a new entry as answer to an existing entry. 
 : If user lacks permission, entry is not added.
 : @param $kat name of category
 : @param $text text of entry
 : @param $thema name of theme
 : @param $bid of entry that is answered
 : @param $user name of user
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/add/eintrag/new")
  %rest:POST
  %rest:GET
  %rest:form-param("text","{$text}", "(no text)")
   %rest:form-param("user","{$user}", "(no user)")
  	  %rest:form-param("kat","{$kat}", "(no kat)")
    %rest:form-param("thema","{$thema}", "(no thema)")
	    %rest:form-param("id","{$bid}", "(no id)")
		  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:new-eintrag(
        $text as xs:string, $kat as xs:string, $thema as xs:string, $bid as xs:integer, $user as xs:string, $password as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="user") then
 (
  if(db:open($kat)/kategorie/thema[@titel=$thema]//eintrag[@id=$bid]/eintrag[@autor=$user]) then
  (db:output(<response> Man darf nicht auf eien post zweimal antworten.</response>))
  else (
  
    let $db := db:open($kat)
   let $schema := fn:doc("http://localhost:8984/static/forumSchema.xsd")
    let $id := ( if(empty(data($db/kategorie/thema[@titel=$thema]//eintrag/@id))) then (1)
		else
		( max(data($db/kategorie/thema[@titel=$thema]//eintrag/@id))+1))
   let $ttext := if(fn:contains($text,"&lt;eintrRef")) then
    let $anf := substring-before($text, "&lt;eintrRef")
    let $ende := substring-after($text,"/&gt;")
    let $ref := substring-before(substring-after($text, "&lt;eintrRef"),"/&gt;")
    let $eref := substring-before(substring-after($ref,'eintragRef="'),'"')
    let $themref := substring-before(substring-after($ref,'themaRef="'),'"')
     return
       <eintrag id="{$id}" autor="{$user}" thema="{$thema}">
    <text> {$anf} <eintrRef eintragRef="{$eref}" themaRef="{$themref}"> </eintrRef> </text>
   </eintrag>
   else
   <eintrag id="{$id}" autor="{$user}" thema="{$thema}">
    <text> {$text}</text>
   </eintrag>
   
   return
 (
  insert node 
   $ttext
		into $db/kategorie/thema[@titel=$thema]//eintrag[@id=$bid],
		  db:output(<restxq:redirect>/forum/{$kat}/{$thema}/checkEintrag</restxq:redirect>))))
	  else
	  (db:output(<response> Dieser user ist dafuer nicht berechtigt.</response>)))
};


(:~
 : Validates the whole category database against the schema.
 : If validation fails, entry with highest id (latest entry) is removed from database.
 : @param $kat name of category
 : @param $thema name of theme
 : @return response element 
 :)
declare
	%rest:path("forum/{$kat}/{$thema}/checkEintrag")
	%updating
	%rest:GET
	function page:checkEntry($kat as xs:string, $thema as xs:string)
	{
		let $schema := fn:doc("http://localhost:8984/static/forumSchema.xsd")
		let $db := db:open($kat)
		let $id := max(data($db/kategorie/thema[@titel=$thema]//eintrag/@id))
		  return 
			try {
				validate:xsd($db, $schema),
				db:output(<restxq:redirect>/forum/{$kat}/{$thema}</restxq:redirect>)
			}catch * {
				db:output(<response>nicht gueltig! </response>),
				delete node $db//thema[@titel=$thema]//eintrag[@id=$id]
			}
	};


(:~
 : Shows form for deleting a category.
 : @param $kat name of category
 : @return response element 
 :)
declare
  %rest:path("/delete/{$kat}")
  %rest:GET
  function page:delete-kat($kat as xs:string)
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Loeschen der Kategorie</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="del">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
		<input type="hidden" name="kat" value="{$kat}">
</input>
        <p>wirklich löschen:<br />
        <input type="submit" value="loeschen"/></p>
      </form>
	</body>
	</html>
};

(:~
 : Deletes a category.
 : If user lacks permission (admin), category is not deleted.
 : @param $kat name of category
 : @param $user username
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/delete/del")
  %rest:POST
  %rest:GET
   %rest:form-param("user","{$user}", "(no user)")
  	  %rest:form-param("kat","{$kat}", "(no kat)")
		  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:new-eintrag(
       $kat as xs:string, $user as xs:string, $password as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="admin") then
 (
 db:drop($kat),
db:output(<restxq:redirect>/index</restxq:redirect>))
	  else
	  (db:output(<response> Dieser user ist dafuer nicht berechtigt.</response>)))
};

(:~
 : Shows form for deleting a theme.
 : @param $kat name of category
 : @param $thema name of theme
 : @return response element 
 :)
declare
  %rest:path("/delete/{$kat}/{$thema}")
  %rest:GET
  function page:delete-kat($kat as xs:string, $thema as xs:string)
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Löschen eines themas</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="../del1">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
		<input type="hidden" name="kat" value="{$kat}">
</input>
		<input type="hidden" name="thema" value="{$thema}">
</input>
        <p>thema wirklich löschen:<br />
        <input type="submit" value="loeschen"/></p>
      </form>
	</body>
	</html>
};

(:~
 : Deletes a theme.
 : If user lacks permission (admin), theme is not deleted.
 : @param $kat name of category
 : @param $thema name of theme
 : @param $user username
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/delete/del1")
  %rest:POST
  %rest:GET
   %rest:form-param("user","{$user}", "(no user)")
  	  %rest:form-param("kat","{$kat}", "(no kat)")
	    	  %rest:form-param("thema","{$thema}", "(no thema)")
		  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:delete-thema(
       $kat as xs:string, $user as xs:string, $password as xs:string, $thema as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="admin") then
 (
 delete node db:open($kat)//thema[@titel=$thema],
db:output(<restxq:redirect>/forum/{$kat}</restxq:redirect>))
	  else
	  (db:output(<response> Dieser user ist dafuer nicht berechtigt.</response>)))
};

(:~
 : Shows form for deleting an entry.
 : @param $kat name of category
 : @param $thema name of theme
 : @id id of entry
 : @return response element 
 :)
declare
  %rest:path("/delete/{$kat}/{$thema}/{$id}")
  %rest:GET
  function page:delete-kat($kat as xs:string, $thema as xs:string, $id as xs:integer)
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Löschen eines Eintrages und Antworten</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="../../del2">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
		<input type="hidden" name="kat" value="{$kat}">
</input>
		<input type="hidden" name="thema" value="{$thema}">
</input>
		<input type="hidden" name="id" value="{$id}">
</input>
        <p>eintrag wirklich löschen:<br />
        <input type="submit" value="loeschen"/></p>
      </form>
	</body>
	</html>
};

(:~
 : Deletes an entry with given id
 : @param $kat name of category
 : @param $thema name of theme
 : @param $id id of entry
 : @param $user username
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/delete/del2")
  %rest:POST
  %rest:GET
   %rest:form-param("user","{$user}", "(no user)")
  	  %rest:form-param("kat","{$kat}", "(no kat)")
	   	  %rest:form-param("id","{$id}", "(no id)")
	    	  %rest:form-param("thema","{$thema}", "(no thema)")
		  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:delete-thema(
       $kat as xs:string, $user as xs:string, $password as xs:string, $thema as xs:string, $id as xs:integer)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open($kat)/kategorie/thema[@titel=$thema]//eintrag[@id=$id]/@autor = $user) then
 (
 delete node db:open($kat)/kategorie/thema[@titel=$thema]//eintrag[@id=$id],
db:output(<restxq:redirect>/forum/{$kat}/{$thema}</restxq:redirect>))
	  else
	  (db:output(<response>User duerfen nur eigenen Posts loeschen.</response>)))
};

(:~
 : Shows list of links for creating different types of users / deleting users.
 : @return response element 
 :)
declare
  %rest:path("/user")
  function page:user()
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    </head>
    <body>
		<a href="/add/user"> Neuer User</a> <br> </br>
		<a href="/add/admin"> User als Admin</a>  <br> </br>
		<a href="/delete/user"> User löschen</a> <br> </br>
	</body>
	</html>
};

(:~
 : Shows form for creating an user.
 : @return response element 
 :)
declare
  %rest:path("/add/user")
  %rest:GET
  function page:add-user()
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Neuer User</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="user/add">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
        <input type="submit" value="User anlegen"/>
      </form>
	</body>
	</html>
};

(:~
 : Creates an user.
 : @param $user username
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/add/user/add")
  %rest:POST
  %rest:GET
   %rest:form-param("user","{$user}", "(no user)")
  		  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:add-user(
      $password as xs:string, $user as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user])) then
(
	insert node <user name="{$user}" password="{$password}"> <role>user</role></user> into db:open("user")/users,
		 db:output(<restxq:redirect>/user/</restxq:redirect>)
 )
else
(db:output(<response> Dieser user exisitiert bereits</response>))

};

(:~
 : Shows form for creating an admin user.
 : @return response element 
 :)
declare
  %rest:path("/add/admin")
  %rest:GET
  function page:add-admin()
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Neuer User</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="admin/add">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
		<p>Username des neuen Admins<br /></p>
		<input name="admin" size="50"></input>
        <input type="submit" value="Zum admin deklarieren"/>
      </form>
	</body>
	</html>
};

(:~
 : Creates an admin user. 
 : Checks if user has the required permissions - fails if not.
 : @param $user username of user trying to create admin user
 : @param $admin name of admin user to be created
 : @param $password password of user
 : @return response element 
 :)
declare
 %updating
  %rest:path("/add/admin/add")
  %rest:POST
  %rest:GET
   %rest:form-param("user","{$user}", "(no user)")
    %rest:form-param("admin","{$admin}", "(no admin)")
  		  %rest:form-param("kennwort","{$password}", "(no password)")
  function page:add-admin(
      $password as xs:string, $user as xs:string, $admin as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(
	(db:output(<response> Username/ Passwort Falsch</response>))
 )
else
(
if(empty(db:open("user")/users/user[@name=$user and role="admin"])) then
(
	 (db:output(<response> Dieser user ist nicht berechtigt</response>))
)
else
(
if(empty(db:open("user")/users/user[@name=$admin])) then
(
 (db:output(<response> Dieser user exisitiert nicht</response>))
)
else
(

insert node <role>admin</role> into db:open("user")/users/user[@name=$admin],
		 db:output(<restxq:redirect>/user/</restxq:redirect>)
		 )
))
};

(:~
 : Shows form for deleting an user.
 : @return response element 
 :)
declare
  %rest:path("/delete/user")
  %rest:GET
  function page:delete-user()
{
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>Löschen eines themas</title>
      <link rel="stylesheet" type="text/css" href="static/style.css"/>
    </head>
    <body>
      <form method="post" action="user/del">
	   <p>Username<br /></p>
		<input name="user" size="50"></input>
		<p>Passwort<br /></p>
		<input name="kennwort" type="password" size="12" maxlength="12">  </input>
		   <p>zu löschenden user<br /></p>
		<input name="deluser" size="50"></input>
        <p>user wirklich löschen:<br />
        <input type="submit" value="loeschen"/></p>
      </form>
	</body>
	</html>
};

(:~
 : Deletes an user.
 : Checks if user has sufficient permission (admin) to delete user, fails if not.
 : @param $user username
 : @param $password password of user
 : @param $deluser name of user to be deleted.
 : @return response element 
 :)
declare
 %updating
  %rest:path("/delete/user/del")
  %rest:POST
  %rest:GET
   %rest:form-param("user","{$user}", "(no user)")
		  %rest:form-param("kennwort","{$password}", "(no password)")
		   %rest:form-param("deluser","{$deluser}", "(no deluser)")
  function page:delete-user(
       $deluser as xs:string, $user as xs:string, $password as xs:string)
{
if(empty(db:open("user")/users/user[@name=$user and @password=$password])) then
(db:output(<response> dieser user exisitert nicht, oder das Passwort ist falsch</response>))
else
( 
 if(db:open("user")/users/user[@name=$user]/role="admin") then
 (
  delete node db:open("user")/users/user[@name=$deluser],
db:output(<restxq:redirect>/user</restxq:redirect>))
	  else
	  (db:output(<response> Dieser user ist dafuer nicht berechtigt.</response>)))
};

(:
 :
 :)
declare
  %rest:POST
  %rest:path("/upload")
  %rest:form-param("files", "{$files}")
  function page:upload($files)
{
  for $name    in map:keys($files)
  let $content := $files($name)
  let $path    := file:temp-dir() || $name
  return (
  
  <response> {parser:addEntry(convert:binary-to-string($content)) } </response>
	(: parser:addEntry($content)
	
    file:write-binary($path, $content),
    <file name="{ $name }" size="{ file:size($path) }" path="{$path}"/> :)
  )
};

(:
 :
 :)
declare
  %rest:path("/bibtex")
  function page:start1()
{
	let $target := 'xml-stylesheet',
	$content := 'href="../static/bibtex.xsl" type="text/xsl" '
	let $cats := <bibtex> </bibtex>
	return document {
	  processing-instruction {$target} {$content},
	  $cats
	}
};

		