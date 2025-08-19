Return-Path: <linux-kernel+bounces-774658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE8B2B5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42CBD4E10D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E764176ADB;
	Tue, 19 Aug 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMX9BzjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2D1CA81;
	Tue, 19 Aug 2025 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565364; cv=none; b=NEjLLVIXmuH9kyo/xnnRjBQEz8Vg4Ki4KdywaoMh1WEsaWqDXErKROSIl4dAbGYgT9fXKUCHDIyG5YvS8aIi9LIjltwumt8j2AuEwHPIDQgLKlQ017jqCewfxZMvG30U32LfompaxrKf2dA9Thql7aWrrb/XF7ytzkxi0TTATzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565364; c=relaxed/simple;
	bh=YaDOaaTEUOeeBcM1XyuKNmtaW3o7dnaiEAL/Toz1Xs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhZq5RJ3KZP3grQIKFZaxtAa8aiq6C5gYhH15zLbSAQrHmW6119UcPTzqVHZc1a2m7x7X9cUME2MoNiOXGJia7dEFh3mI+kONcYJ6EYEqYxELeqKqbckoTQa6xozDZse/bv6bMns7dlxrrcYLxTgc4x9ku9djKh8DK2ZblaTd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMX9BzjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A2EC113D0;
	Tue, 19 Aug 2025 01:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565363;
	bh=YaDOaaTEUOeeBcM1XyuKNmtaW3o7dnaiEAL/Toz1Xs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMX9BzjEnAYG6Ny7Yr3vkMiJ61BmtFAFMytXHp5yHV2IL0RqDiYDs2YlQcoEPtuDM
	 ILRzj1qC8ceRqc9f4VDKA7a3YwjDQqnIJl98VSSdJtwqiem7elvg2Gi/4wyMfdLY99
	 96OmanYeLsnA2Q529Jyxa/gPZmilgosvSBHBjRGSrHYC1Rhf9Cy8Ba2KLyE8+iOsBu
	 f4AtWuWSRheV2InQeCwYoYMgGgGO0G2wHCejjuOGjiN6g/biQtgGFIFmDhFI8s2pEc
	 nbnHMW5L3bTbUBcpbctHDxiJFwXfLEQMyU36KKm8ImvtXoPOmE+C64TWc/AUc1O+dD
	 hTQzaThM4jbWw==
Date: Tue, 19 Aug 2025 03:02:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250819030239.41a2e97f@foz.lan>
In-Reply-To: <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
	<20250816135538.733b80d3@foz.lan>
	<acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
	<20250817133606.79d968ed@sal.lan>
	<b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
	<20250817154544.78d61029@foz.lan>
	<b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
	<87y0rg7e35.fsf@trenco.lwn.net>
	<16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 19 Aug 2025 08:26:31 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Mon, 18 Aug 2025 11:07:58 -0600, Jonathan Corbet wrote:
> > Akira Yokosawa <akiyks@gmail.com> writes:
> >  =20
> >> Ah, I have finally understood what 5/11 is trying to do.
> >>
> >> Its changelog mainly talks about an issue you saw after adding options
> >> to xindy in that same commit, and you added
> >>
> >>    \newfontfamily\headingfont{DejaVu Serif}
> >>
> >> to resolve it.
> >>
> >> Current changelog didn't make sense at all for me.
> >>
> >> Can you please reword it and make it easier to follow?
> >>
> >> With that, feel free to add my
> >>
> >> Reviewed-by: Akira Yokosawa <akiyks@gmail.com> =20
> >=20
> > So, if I have managed to understand this conversation, this reword is
> > all we need to get this series merged..? =20
>=20
> Well, after some thoughts on the conversation took place on xindy,
> I think I have to withdraw my Reviewed-by: tag.
>=20
> I was the one who was totally confused.
>=20
> Please disregard it.
>=20
> Mauro, I can't review on 5/11 unless you provide me exact steps to reprod=
uce
> the font discovery issue you said you have observed under debian at 4/11 =
of
> this series.  That is, without assuming your other series of build-wrappe=
r.

See below.

> The build-wrapper should be upper compatible with the current way of
> running sub-make, without any change in conf.py.

The build-wrapper series doesn't make any changes on conf.py:

	 $ git diff pdfdocs..sphinx-build-wrapper --stat

	 .pylintrc                                |   2 +-
	 Documentation/Makefile                   | 142 +++-------
	 Documentation/sphinx/parallel-wrapper.sh |  33 ---
	 scripts/jobserver-exec                   |  88 ++-----
	 scripts/lib/jobserver.py                 | 149 +++++++++++
	 scripts/sphinx-build-wrapper             | 767 ++++++++++++++++++++++++++=
++++++++++++++++++++++++++++
	 scripts/sphinx-pre-install               |  14 +-
	 7 files changed, 994 insertions(+), 201 deletions(-)

It also doesn't change the build logic: it just moves it to the
script. The only difference was with regards to serializing the build,
as I forgot to take it into account when I wrote it. However, I sent
already a patch addressing it.

In summary, all the sphinx-build-wrapper series do is:

- move code from Documentation/Makefile into a python script;
- get rid of a shell script;
- split scripts/jobserver-exec into an exec and a library;
- change the output of doc build to produce a summary at the end,
  returning an error code only if one or more PDF files were not
  built;
- allow calling the script directly without requiring a makefile;
- add a couple of optional command line parameters to help debugging.

On the other hand, the pdf series diffstat is:

$ git diff netlink_v10..pdfdocs --stat
 Documentation/Makefile     |   4 ++--
 Documentation/conf.py      | 106 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++--------------------------------------------
 scripts/sphinx-pre-install |  41 ++++++++++++++++++++++++++++++++---------
 3 files changed, 96 insertions(+), 55 deletions(-)

The Makefile change is actually a fix:

	diff --git a/Documentation/Makefile b/Documentation/Makefile
	index 820f07e0afe6..2ed334971acd 100644
	--- a/Documentation/Makefile
	+++ b/Documentation/Makefile
	@@ -63,2 +63,2 @@ endif #HAVE_LATEXMK
	-PAPEROPT_a4     =3D -D latex_paper_size=3Da4
	-PAPEROPT_letter =3D -D latex_paper_size=3Dletter
	+PAPEROPT_a4     =3D -D latex_elements.papersize=3Da4paper
	+PAPEROPT_letter =3D -D latex_elements.papersize=3Dletterpaper

So, the entire series do:

1. Fix paper size define, as latex_paper_size doesn=C2=B4t exist since
   Sphinx 1.x. It got replaced by latex_elements.papersize;

2. Broken package dependencies related to PDF builds on several
   distros inside sphinx-pre-install;

3. It properly construct the name of pdfdocs to be built when
   SPHINXDIRS is used;

4. It prevents the usage of T1 fontenc fonts, which could be
   caused by either one of those two reasons:

	a) \sphinxhyphen{}
	b) index build

I got those when checking what packages were required on some
distros (Debian, Ubuntu, Mageia, openMandriva, Gentoo).

Depending on the distro, the Sphinx version and the installed
packages, the *.tex file ends adding:

	\usepackage[T1]{fontenc}

This is incompatible with xelatex with utf-8 fonts as T1 is not UTF-8
ready.

with (a), \sphinxhyphen{} logic - together with babel, ends
requiring pzdr.tfm.

To do the conf.py, I did some changes for it to better align
with:

	https://www.sphinx-doc.org/en/master/latex.html#module-latex

As the original settings were written for Sphinx 1.4.1 and
had very little fixes since then.

The changes are:

1. Added:
	"fontenc": ""

   to prevent a possible default of having:
	r'\usepackage[T1]{fontenc}'

2. Place font settings at the right place for more modern Spinx versions.
   If you look there, font specs shall be under "fontpkg", not under
   "preamble":

+    'fontpkg': dedent(r'''
+        \usepackage{fontspec}
+        \setmainfont{DejaVu Serif}
+        \setsansfont{DejaVu Sans}
+        \setmonofont{DejaVu Sans Mono}

-    # Additional stuff for the LaTeX preamble.
-    "preamble": """
-        % Use some font with UTF-8 support with XeLaTeX
-        \\usepackage{fontspec}
-        \\setsansfont{DejaVu Sans}
-        \\setromanfont{DejaVu Serif}
-        \\setmonofont{DejaVu Sans Mono}
-    """,
 }

3. Added a fix where some LaTeX modules were trying to use T1 fontenc:

        \newfontfamily\headingfont{DejaVu Serif}

4. I used dedent() to remove weird whitespaces at the beginning inside
   .tex files - no functional changes - this is just cosmetic at the
   output;

5. I moved preamble from a separate part of conf.py:

+    "preamble": dedent(r"""
+        % Load kerneldoc specific LaTeX settings
+        \input{kerneldoc-preamble.sty}
+    """),

-# Load kerneldoc specific LaTeX settings
-latex_elements["preamble"] +=3D """
-        % Load kerneldoc specific LaTeX settings
-        \\input{kerneldoc-preamble.sty}
-"""

6. I solved an issue were xindy was trying to include T1 fontenc.
   while here, I also added a parameter recommended at sphinx Latex
   configuration doc:

+    "passoptionstopackages": dedent(r"""
+        \PassOptionsToPackage{svgnames}{xcolor}
+        % Avoid encoding troubles when creating indexes
+        \PassOptionsToPackage{xindy}{language=3Denglish,codepage=3Dutf8,no=
automatic}
+    """),

(the xcolor came from the documentation)

The above doesn't load xindy; it just ensures that codepage=3Dutf8 is used
if it is used;

7. some distros didn't build pdf due to the lack of an index file.
   So, I added this:

+    'printindex': r'\footnotesize\raggedright\printindex',

which is also suggested at
	 https://www.sphinx-doc.org/en/master/latex.html#module-latex

So, basically, the changes at conf.py better align it with Sphinx
documentation, and were experimentally tested: I didn't find
any regressions on it, and it fixed PDF builds for several distros.

Did you find any regressions?

> I don't think this is too much to ask.=20

Actually, it is... finding a way for you to reproduce it would=20
require me to start from scratch and redo everything again,
hoping that I'll do exactly the same way. It took me 2 entire
weeks to do it the first time.=20

I very much prefer dropping patch 05/11 and keep PDF broken
than spending 2 weeks redoing it.

> Moving both the goal post

What do you mean by "goal post"?

The pdfdocs series is there just to make sure that pdf builds
will work on most distros, as currently they don't build on
several of them.

> and the build script at the same time is the wrong thing to do
> in my opinion.

Well, we can postpone the PDF series - or at least the patches
you find problematic.

The build script cleanup is important, though as it affects
a series I have afterwards addressing some build issues=20
affecting only the media subsystem, which is the only user
of kernel-include tag.

Thanks,
Mauro

