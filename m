Return-Path: <linux-kernel+bounces-755489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADEB1A6EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F71C18A0A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147517BA1;
	Mon,  4 Aug 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIZzxXiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394C1D5CED;
	Mon,  4 Aug 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323235; cv=none; b=eTV7Wz8mOu+tS+A6Pg70CovMqDEYLHGUDB99dNItPOPj3HttTtkTKvD0Df5xMSG1+E5kUb9HBVR4AylCpNkOa5n8AWhmXOAAT0fKqZSzjDCby44twbawqxrms4mLCRNb7Kl6jx0HxWYcut59JWc2AEjLKq084wy41wm2kyMS9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323235; c=relaxed/simple;
	bh=1w/aU9y4PeDCSnK+5gPtQHjjxVpMkSUDD6zLoXvEwGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUM8l+geeG7jMZGTTwDkF3f36ewuMej18QuVHXRx/BmnZUXofAzaM7e4rBEyFTegfuf2IfzsMFsf0YT1/zv60h56soMRe8di/1D/yQGGXJQigMwRZlBjN5r98ng5svLAh1DF4ur6p3IKVTaPEm0JJnVgirX5V3CHlRynLWQDxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIZzxXiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCFC4CEE7;
	Mon,  4 Aug 2025 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754323234;
	bh=1w/aU9y4PeDCSnK+5gPtQHjjxVpMkSUDD6zLoXvEwGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIZzxXiU3vOTugZBQ6DYOwWBHoF3/90PjJgWfnnU1VYIyklZ+fXwGUEG1wc5OU/tv
	 we6/FpZ6QFRMeXthJjYSBUEQhEfXzchhI2+qavAZVFy0MhGFIfr5ty7EEqYJxpF2k3
	 qd3V9JOYyod/ujxSKl+qFk2umyOxM6+/irye5uQ3EoRVSzjYpLaDxoQSWgWX5JUU/6
	 rCKD1XHaFOfKt0ZlfWKxFRZcm2GuT9acO88ekkrJ4sOjBHMplhMcR85STzNr3HUgCX
	 bx6aVO22kT0zXh1xviTDlhiidlW9wYE38OS489Rn1NfTXiWysRS7kOlv+R5+YoOiJu
	 XPeO3kq/2RlnQ==
Date: Mon, 4 Aug 2025 18:00:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 03/12] docs: kdoc: backslashectomy in kdoc_parser
Message-ID: <20250804180029.11b8c310@sal.lan>
In-Reply-To: <20250804145818.3cc73ca2@foz.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-4-corbet@lwn.net>
	<20250801062710.552dac5a@foz.lan>
	<87h5yrruki.fsf@trenco.lwn.net>
	<20250804145818.3cc73ca2@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 4 Aug 2025 14:58:18 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 01 Aug 2025 08:21:49 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>=20
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >  =20
> > > Em Thu, 31 Jul 2025 18:13:17 -0600
> > > Jonathan Corbet <corbet@lwn.net> escreveu:
> > >   =20
> > >> A lot of the regular expressions in this file have extraneous backsl=
ashes   =20
> > >
> > > This one is a bit scary... It could actually cause issues somewhere. =
  =20
> >=20
> > What kind of issues? =20
>=20
> I caught several issues in the past due to the lack of it. Don't
> recall the specific cases, but using reserved symbols without
> backslashes have giving me enough headaches.
>=20
> Yet, see POSIX rules for some cases:
>=20
> 	https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html=
#tag_09_03
>=20
> like this one:
>=20
> 	"The character sequences "[.", "[=3D", and "[:" shall be special
> 	 inside a bracket expression"
>=20
> Basically, if you don't know exactly what you're doing, and just
> place special characters there without extra case, you may be
> in serious troubles. And see, this is just for BRE (basic regular
> expressions). There are also other weirdness with ERE (extended
> regular expressions):
>=20
> 	"The <period>, <left-square-bracket>, <backslash>, and=20
> 	 <left-parenthesis> shall be special except when used=20
> 	 in a bracket expression"
>=20
> > > Also, IMHO, some expressions look worse on my eyes ;-)   =20
> >=20
> > Here I think we're going to disagree.  The extra backslashes are really
> > just visual noise as far as I'm concerned.
> >  =20
> > >> that may have been needed in Perl, but aren't helpful here.  Take th=
em out
> > >> to reduce slightly the visual noise.   =20
> > >
> > > No idea if Perl actually requires, but, at least for me, I do prefer =
to
> > > see all special characters properly escaped with a backslash. This wa=
y,
> > > it is a lot clearer that what it is expecting is a string, instead of
> > > using something that may affect regex processing.   =20
> >=20
> > I guess my point is that, in the given cases, the characters in question
> > *aren't* special. =20
>=20
> They are special in the sense that we're using characters that
> have meanings in regular expressions and even placing them on
> a random order may cause POSIX violations (and eventually cause
> troubles if, for instance, we need to use "regex" instead of "re",
> or if someone fixes python native "re" to be more POSIX compliant.
>=20
> > >> -        param =3D KernRe(r'[\[\)].*').sub('', param, count=3D1)
> > >> +        param =3D KernRe(r'[)[].*').sub('', param, count=3D1)   =20
> > >
> > > This one, for instance, IMHO looks a lot worse for my eyes to underst=
and
> > > that there is a "[" that it is not an operator, but instead a string.
> > > The open close parenthesis also looks weird. My regex-trained eyes th=
ink
> > > that this would be part of a capture group.   =20
> >=20
> > ...and mine say "that's in [brackets] why are you escaping it?" :) =20
>=20
> Heh, all those years writing and reviewing kernel code, for me
> seeing unmatched parenthesis/brackets really bugs me... perhaps
> it starts some sort of TOC syndrome ;-)
>=20
> Perhaps one alternative would be to have a separate var, like:
>=20
> 	# Before touching this, see:
> 	# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.ht=
ml#tag_09_04
> 	# As some char sequences inside brackets have special meanings
> 	escape_chars =3D ")["
>=20
> 	param =3D KernRe(rf'[{escape_chars}].*').sub('', param, count=3D1) =20
>=20
> or to use re_escape().
>=20
> > >>          if dtype =3D=3D "" and param.endswith("..."):
> > >>              if KernRe(r'\w\.\.\.$').search(param):
> > >> @@ -405,7 +405,7 @@ class KernelDoc:
> > >> =20
> > >>          for arg in args.split(splitter):
> > >>              # Strip comments
> > >> -            arg =3D KernRe(r'\/\*.*\*\/').sub('', arg)
> > >> +            arg =3D KernRe(r'/\*.*\*/').sub('', arg)   =20
> > >
> > > A pattern like /..../ is a standard way to pass search group with Reg=
ex
> > > on many languages and utils that accept regular expressions like the
> > > sed command. Dropping the backslash here IMHO makes it confusing ;-) =
  =20
> >=20
> > ...but it is definitely not any such in Python and never has been, so
> > escaping slashes looks weird and makes the reader wonder what they are
> > missing. =20
>=20
> After re-reading, this specific change is actually ok, but yeah, I
> still need to read it twice or three times, as on sed, perl and other
> languages that are more POSIX compliant, /re/ means a regex delimiter:
>=20
> 	https://en.wikipedia.org/wiki/Regular_expression
>=20
> > > Seriously, IMHO this patch makes a lot worse to understand what brack=
ets,
> > > parenthesis and dots are strings, and which ones are part of the regex
> > > syntax.    =20
> >=20
> > So I guess I won't fight this one to the death, but I really do
> > disagree.  Writing regexes in a non-canonical style just makes it harder
> > for anybody else who comes along to figure out what is going on; it
> > certainly made it harder for me. =20
>=20
> Heh, for me, my main concerns are:
> - unmatched brackets/parenthesis
> - POSIX violations - it may work today, but future Python versions
>   that fix "re" module will cause regressions. It is also annoying
>   to write/understand regex that only works on Python.

In time: I mean *possible* POSIX violations.=20

I very much prefer more backslashs than needed or use re.escape()
than to read thoughtfully POSIX and Python-specific specific rules.

Python, in particular, is not very reliable between versions - each
new version comes with a set of incompatible changes.

Regex in Python for instance had incompatible changes in 3.6, 3.7, 3.11
and 3.13 (according with a LLM query I did). None relevant for our cases,
but there were incompatible changes on 3.6, 3.7 and 3.13 on common=20
patterns like \b (affecting re.split) and \w (affecting utf). The number
of escaped chars on re.escape() also increased on 3.7.

In summary, if you agree with always escape brackets, curly brackets and
parenthesis inside brackets on kernel-doc, we should be free of not
opened/not closed "symbols" with is an annoyance at least for me, and
we should be freed of possible POSIX issues and undefined behavior(*).

On such case, feel free to add my Reviewed-by.

Regards,
Mauro

(*) Python spec:

	https://docs.python.org/3/library/re.html#regular-expression-syntax

    Says:

	"Backslash either escapes characters which have special meaning in=20
	 a set such as '-', ']', '^' and '\\' itself..."

   Here, "such as" is vague: it doesn't say anything about "[[]" or "[\[]".=
=20
   As not escaping "[" is a POSIX violation, I'd say that this is undefined
   behavior that could change with time specially if they want to stick
   with POSIX and/or implement POSIX ERE in the future.

---

Btw, I asked a LLM (*) to generate a list of special chars inside brackets,
listing how such characters are handled. Neither Deepseek nor Chatgpt
considered brackets without escape as valid or good practice.

That's the Deepseek version:

+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
|                  | Python re | Perl      | POSIX ERE | POSIX BRE | grep -=
E   | sed (BRE) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| ] (not first)    | \]        | \]        | \]        | \]        | \]    =
    | \]        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| ] (first)        | ]         | ]         | ]         | ]         | ]     =
    | ]         |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| [                | \[        | \[        | \[        | \[        | \[    =
    | \[        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| - (middle)       | \-, a-z   | \-, a-z   | \-, a-z   | \-, a-z   | \-, a-=
z   | \-        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| - (first/last)   | -         | -         | -         | -         | -     =
    | -         |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| ^ (first)        | ^         | ^         | ^         | ^         | ^     =
    | \^        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| ^ (not first)    | ^         | ^         | \^        | \^        | \^    =
    | \^        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| \                | \\        | \\        | \\        | \\        | \\    =
    | \\        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| POSIX classes    | [:alpha:] | [:alpha:] | [:alpha:] | [:alpha:] | [:alph=
a:] | [:alpha:] |
| (e.g. [:alpha:]) |           |           |           |           |       =
    |           |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| Special POSIX    | -         | -         | [.ch.]    | [.ch.]    | -     =
    | [.ch.]    |
| collating [.ch.] |           |           | [=3Da=3D]     | [=3Da=3D]     =
|           | [=3Da=3D]     |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| *                | *         | *         | *         | \*        | *     =
    | \*        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| $                | $         | $         | $         | \$        | $     =
    | \$        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+
| .                | .         | .         | .         | \.        | .     =
    | \.        |
+------------------+-----------+-----------+-----------+-----------+-------=
----+-----------+

And using the LLM query produced by Deepseek, (see below), that's Chatgpt r=
esults:

+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| Feature                            | Python re  | Perl   | POSIX ERE   | =
POSIX BRE   | grep -E   | sed (BRE)   |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| `]` (first position)               | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `]` (non-first position)           | \]         | \]     | \]          | =
\]          | \]        | \]          |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `[`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `-` (between literals)             | range `a-z`| range  | range       | =
range       | range     | range       |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `-` (start or end)                 | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `^` (first position)               | negation   | negation| negation   | =
negation    | negation  | negation    |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `^` (non-first position)           | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `\`                                | \\         | \\     | \\          | =
\\          | \\        | \\          |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| POSIX class `[:alpha:]`            | literal    | literal| supported   | =
supported   | supported | supported   |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| POSIX special `[.ch.]`             | -          | -      | supported   | =
supported   | supported | supported   |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| POSIX equivalence `[=3Da=3D]`          | -          | -      | supported =
  | supported   | supported | supported   |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `*`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `$`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `.`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+

Yet, Chatgpt original result was wrong. I had to do an extra query
there:

- Please check again for [ inside brackets. POSIX spec mentions some sequen=
ces starting with it that aren't literal. Re-check it and update the table.

Chatgpt now gave a better answer:

You're correct to call this out =E2=80=94 in **POSIX**, an unescaped `[` in=
side a character class can indeed initiate **special bracket expressions** =
(`[:class:]`, `[=3Dequiv=3D]`, `[.collate.]`). This makes it **not always t=
reated as literal**, depending on **context and position**.

Here is the **updated full table** in **strict ReST ASCII format**, reflect=
ing that correction:

```
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| Feature                            | Python re  | Perl   | POSIX ERE   | =
POSIX BRE   | grep -E   | sed (BRE)   |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| `]` (first position)               | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `]` (non-first position)           | \]         | \]     | \]          | =
\]          | \]        | \]          |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `[`                                | literal    | literal| special*    | =
special*    | special*  | special*    |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `-` (between literals)             | range `a-z`| range  | range       | =
range       | range     | range       |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `-` (start or end)                 | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `^` (first position)               | negation   | negation| negation   | =
negation    | negation  | negation    |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `^` (non-first position)           | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `\`                                | \\         | \\     | \\          | =
\\          | \\        | \\          |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| POSIX class `[:alpha:]`            | literal    | literal| supported   | =
supported   | supported | supported   |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| POSIX special `[.ch.]`             | -          | -      | supported   | =
supported   | supported | supported   |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| POSIX equivalence `[=3Da=3D]`          | -          | -      | supported =
  | supported   | supported | supported   |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `*`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `$`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
| `.`                                | literal    | literal| literal     | =
literal     | literal   | literal     |
+------------------------------------+------------+--------+-------------+-=
------------+-----------+-------------+
```

### Footnote:

* \* In **POSIX ERE**, **POSIX BRE**, **`grep -E`**, and **`sed`**, an unes=
caped `[` **immediately followed by `:`, `=3D`, or `.`** at the start of a =
character class (e.g., `[[:`, `[.=3D`, `[=3D=3D`) initiates a **special POS=
IX expression** and is **not a literal**. To match a literal `[`, avoid pla=
cing it in this position or use placement later in the class. Escaping `[` =
(`\[`), while common in practice, is not guaranteed portable in POSIX.

Let me know if you'd like to add more edge cases (e.g., `[[:[:alpha:]:]]` o=
r nested misuse).





-

LLM queries to produce the above result with Deepseek:

- list on an ascii table python changes to re and regex modules that caused=
 backward-compatibility issues.

- for internal "re" module, compare changes for "[]" brakets that contain c=
haracters on it. what chars/sequences of special characters can cause troub=
les on Python? What's the difference in terms of needing backslashes when c=
ompared with POSIX, Perl, sed and grep (with -E)? Ignore unicode. We're int=
erested just in ascii special chars.

- get the table (3) and transpose it. check if different versions do differ=
ent cases. Include both POSIX ERE and BRE. Add special sequences. for insta=
nce, POSIX have special meanings for having "[" followed by some other spec=
ial characters. Show only the table

To allow you to reproduce, I also asked:

- I want to pass to someone else the LLM requests for him to produce exactl=
y the same table.

It produced the following LLM query:


<snip>
Create a comparison table in ReST format showing escaping rules for special=
 ASCII characters inside regex character classes `[]`. Follow these specifi=
cations:

1. **Tools**: Compare Python `re`, Perl, POSIX ERE, POSIX BRE, `grep -E`, a=
nd `sed` (BRE)
2. **Structure**: Transposed layout (features as rows, tools as columns)
3. **Content**: Include all these cases:
   - `]` (first vs. non-first position)
   - `[`, `-`, `^`, `\`=20
   - POSIX classes (`[:alpha:]`)
   - POSIX specials (`[.ch.]`, `[=3Da=3D]`)
   - `*`, `$`, `.`=20
4. **Rules**:
   - Mark required escapes with `\`
   - Show range syntax (`a-z`) where applicable
   - Indicate "literal" when no escape needed
5. **Format**: Strict ReST ASCII table with grid lines
6. **Notes**:
   - Exclude Unicode
   - Highlight version differences in footnotes
   - Keep all tool columns even if identical
   - Use `-` for unsupported features

Provide only the final table with no commentary.
</snip>

