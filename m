Return-Path: <linux-kernel+bounces-802869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F004EB457B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7B47BB2A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637634F468;
	Fri,  5 Sep 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPaSUybL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AEE27461;
	Fri,  5 Sep 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075139; cv=none; b=EPAJaqFadW3C0reR2oOp6W7xWFrfJcI4Q+2CelukZNQevkj4pLiHOeuWX4dvjiC4XzUkrva86AwpI36tyUcgYPbrfwtJQat3WCZUs4zy8czCBEKGMBbBJbX9OsDd20PDORVaKWXlGSccCWbclAFhgoqPfIGP1EVmGu+VTrov/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075139; c=relaxed/simple;
	bh=nv5RsKl3YJphQJdWS9ZAbLSdjNcPBPYU5L++37ZehTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDMsZHW1ottZJa/+QzquJwxYO4r5I2auPy26XH03EbfpUefJUwJofUHsuCZlSomnB6BPpJ84GcpTWdmHHVcuhYac+jMpvc5EE/g8QECLzGh6Zsp6Coj2BACUTfkxq4L5veEgayP+5ilg5qVQBxA70bO5cF/I2n6uC766nURCVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPaSUybL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E2C4CEF7;
	Fri,  5 Sep 2025 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757075138;
	bh=nv5RsKl3YJphQJdWS9ZAbLSdjNcPBPYU5L++37ZehTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZPaSUybLRiPljNVMpaTWJHBsGTCKuSmsf4CZNod9/b/Ai2pol63UlMdRfEUseB0v9
	 gAOVuguQoDsfX/W+z6v1Vkc8J2e6B7dGSP+L1NAykDNpT23rwACFH21xGBI7jP/2YU
	 vBMf+P8MdIzq+BDTIeq4pEJsoMTkrreNbbWXuR6RYN3ghwZIjCbzIxfuUOSfmhnjde
	 LBBeTCLtPitdpyByyp/IjCfVWlT110e3A4D3yX+8pQNtV2fejHCuWJYphhOG4r3FNw
	 S+wavhNqMce2MSdWPPMxAnJj1i9MSZd4KAQvVdFRGHkQ2/KngXL8H746W+GqhtsdFa
	 9Et47XIExihxQ==
Date: Fri, 5 Sep 2025 14:25:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Dongliang Mu <dzm91@hust.edu.cn>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, Yanteng
 Si <si.yanteng@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] scripts: sphinx-pre-install: move it to
 tools/docs
Message-ID: <20250905142534.6eb2cd65@foz.lan>
In-Reply-To: <87ms7amanj.fsf@trenco.lwn.net>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<68810fc1065bbe8ef1305041fb10fa632bb64dd3.1756969623.git.mchehab+huawei@kernel.org>
	<87ms7amanj.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 04 Sep 2025 10:42:56 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > As we're reorganizing the place where doc scripts are located,
> > move this one to tools/docs.
> >
> > No functional changes.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile                             | 14 +++++++-------
> >  Documentation/doc-guide/sphinx.rst                 |  4 ++--
> >  Documentation/sphinx/kerneldoc-preamble.sty        |  2 +-
> >  .../translations/it_IT/doc-guide/sphinx.rst        |  4 ++--
> >  .../translations/zh_CN/doc-guide/sphinx.rst        |  4 ++--
> >  Documentation/translations/zh_CN/how-to.rst        |  2 +- =20
>=20
> This one fails to apply to the translations - it looks like some sort of
> encoding problem...?

Mailbomb script broke it, because Python email parser converts emails
without an explicit charset defined to ascii + invalid utf-8 character,
even when the policy is forcing utf-8.

This is the correct patch:

---

[PATCH v4 04/19] scripts: sphinx-pre-install: move it to tools/docs

As we're reorganizing the place where doc scripts are located,
move this one to tools/docs.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile                             | 14 +++++++-------
 Documentation/doc-guide/sphinx.rst                 |  4 ++--
 Documentation/sphinx/kerneldoc-preamble.sty        |  2 +-
 .../translations/it_IT/doc-guide/sphinx.rst        |  4 ++--
 .../translations/zh_CN/doc-guide/sphinx.rst        |  4 ++--
 Documentation/translations/zh_CN/how-to.rst        |  2 +-
 MAINTAINERS                                        |  3 +--
 {scripts =3D> tools/docs}/sphinx-pre-install         |  0
 8 files changed, 16 insertions(+), 17 deletions(-)
 rename {scripts =3D> tools/docs}/sphinx-pre-install (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c20c68be89a..deb2029228ed 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,7 +46,7 @@ ifeq ($(HAVE_SPHINX),0)
 .DEFAULT:
 	$(warning The '$(SPHINXBUILD)' command was not found. Make sure you have =
Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point=
 to the full path of the '$(SPHINXBUILD)' executable.)
 	@echo
-	@$(srctree)/scripts/sphinx-pre-install
+	@$(srctree)/tools/docs/sphinx-pre-install
 	@echo "  SKIP    Sphinx $@ target."
=20
 else # HAVE_SPHINX
@@ -105,7 +105,7 @@ quiet_cmd_sphinx =3D SPHINX  $@ --> file://$(abspath $(=
BUILDDIR)/$3/$4)
 	fi
=20
 htmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
=20
 # If Rust support is available and .config exists, add rustdoc generated c=
ontents.
@@ -119,7 +119,7 @@ endif
 endif
=20
 texinfodocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texin=
fo,$(var)))
=20
 # Note: the 'info' Make target is generated by sphinx itself when
@@ -131,7 +131,7 @@ linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(v=
ar)))
=20
 latexdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$=
(var)))
=20
 ifeq ($(HAVE_PDFLATEX),0)
@@ -144,7 +144,7 @@ else # HAVE_PDFLATEX
=20
 pdfdocs: DENY_VF =3D XDG_CONFIG_HOME=3D$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS),  	   $(MAKE) PDFLATEX=3D"$(PDFLATEX)" LATEXO=
PTS=3D"$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree=
)/scripts/check-variable-fonts.sh || exit;  	   mkdir -p $(BUILDDIR)/$(var)=
/pdf; @@ -154,11 +154,11 @@ pdfdocs: latexdocs
 endif # HAVE_PDFLATEX
=20
 epubdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(v=
ar)))
=20
 xmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var=
)))
=20
 endif # HAVE_SPHINX
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/s=
phinx.rst
index 607589592bfb..932f68c53075 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -106,7 +106,7 @@ There's a script that automatically checks for Sphinx d=
ependencies. If it can
 recognize your distribution, it will also give a hint about the install
 command line options for your distro::
=20
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are avail=
able
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -116,7 +116,7 @@ command line options for your distro::
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
=20
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-=
install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-p=
re-install line 468.
=20
 By default, it checks all the requirements for both html and PDF, including
 the requirements for images, math expressions and LaTeX build, and assumes
diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/sp=
hinx/kerneldoc-preamble.sty
index 5d68395539fe..16d9ff46fdf6 100644
--- a/Documentation/sphinx/kerneldoc-preamble.sty
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -220,7 +220,7 @@
 	    If you want them, please install non-variable ``Noto Sans CJK''
 	    font families along with the texlive-xecjk package by following
 	    instructions from
-	    \sphinxcode{./scripts/sphinx-pre-install}.
+	    \sphinxcode{./tools/docs/sphinx-pre-install}.
 	    Having optional non-variable ``Noto Serif CJK'' font families will
 	    improve the looks of those translations.
 	\end{sphinxadmonition}}
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Docume=
ntation/translations/it_IT/doc-guide/sphinx.rst
index 1f513bc33618..a5c5d935febf 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -109,7 +109,7 @@ Sphinx. Se lo script riesce a riconoscere la vostra dis=
tribuzione, allora
 sar=C3=AF=C2=BF=C2=BD in grado di darvi dei suggerimenti su come procedere=
 per completare
 l'installazione::
=20
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are avail=
able
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -119,7 +119,7 @@ l'installazione::
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
=20
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-=
install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-p=
re-install line 468.
=20
 L'impostazione predefinita prevede il controllo dei requisiti per la gener=
azione
 di documenti html e PDF, includendo anche il supporto per le immagini, le
diff --git a/Documentation/translations/zh_CN/doc-guide/sphinx.rst b/Docume=
ntation/translations/zh_CN/doc-guide/sphinx.rst
index 23eac67fbc30..3375c6f3a811 100644
--- a/Documentation/translations/zh_CN/doc-guide/sphinx.rst
+++ b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
@@ -84,7 +84,7 @@ PDF=E5=92=8CLaTeX=E6=9E=84=E5=BB=BA
 =E8=BF=99=E6=9C=89=E4=B8=80=E4=B8=AA=E8=84=9A=E6=9C=AC=E5=8F=AF=E4=BB=A5=
=E8=87=AA=E5=8A=A8=E6=A3=80=E6=9F=A5Sphinx=E4=BE=9D=E8=B5=96=E9=A1=B9=E3=80=
=82=E5=A6=82=E6=9E=9C=E5=AE=83=E8=AE=A4=E5=BE=97=E6=82=A8=E7=9A=84=E5=8F=91=
=E8=A1=8C=E7=89=88=EF=BC=8C=E8=BF=98=E4=BC=9A=E6=8F=90=E7=A4=BA=E6=82=A8=E6=
=89=80=E7=94=A8=E5=8F=91=E8=A1=8C
 =E7=89=88=E7=9A=84=E5=AE=89=E8=A3=85=E5=91=BD=E4=BB=A4::
=20
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are avail=
able
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -94,7 +94,7 @@ PDF=E5=92=8CLaTeX=E6=9E=84=E5=BB=BA
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
=20
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-=
install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-p=
re-install line 468.
=20
 =E9=BB=98=E8=AE=A4=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E5=AE=83=E4=BC=9A=
=E6=A3=80=E6=9F=A5html=E5=92=8CPDF=E7=9A=84=E6=89=80=E6=9C=89=E4=BE=9D=E8=
=B5=96=E9=A1=B9=EF=BC=8C=E5=8C=85=E6=8B=AC=E5=9B=BE=E5=83=8F=E3=80=81=E6=95=
=B0=E5=AD=A6=E8=A1=A8=E8=BE=BE=E5=BC=8F=E5=92=8CLaTeX=E6=9E=84=E5=BB=BA=E7=
=9A=84
 =E9=9C=80=E6=B1=82=EF=BC=8C=E5=B9=B6=E5=81=87=E8=AE=BE=E5=B0=86=E4=BD=BF=
=E7=94=A8=E8=99=9A=E6=8B=9FPython=E7=8E=AF=E5=A2=83=E3=80=82html=E6=9E=84=
=E5=BB=BA=E6=89=80=E9=9C=80=E7=9A=84=E4=BE=9D=E8=B5=96=E9=A1=B9=E8=A2=AB=E8=
=AE=A4=E4=B8=BA=E6=98=AF=E5=BF=85=E9=9C=80=E7=9A=84=EF=BC=8C=E5=85=B6=E4=BB=
=96=E4=BE=9D
diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/tr=
anslations/zh_CN/how-to.rst
index ddd99c0f9b4d..714664fec308 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -64,7 +64,7 @@ Linux =E5=8F=91=E8=A1=8C=E7=89=88=E5=92=8C=E7=AE=80=E5=8D=
=95=E5=9C=B0=E4=BD=BF=E7=94=A8 Linux =E5=91=BD=E4=BB=A4=E8=A1=8C=EF=BC=8C=
=E9=82=A3=E4=B9=88=E5=8F=AF=E4=BB=A5=E8=BF=85=E9=80=9F=E5=BC=80=E5=A7=8B=E4=
=BA=86
 ::
=20
 	cd linux
-	./scripts/sphinx-pre-install
+	./tools/docs/sphinx-pre-install
=20
 =E4=BB=A5 Fedora =E4=B8=BA=E4=BE=8B=EF=BC=8C=E5=AE=83=E7=9A=84=E8=BE=93=E5=
=87=BA=E6=98=AF=E8=BF=99=E6=A0=B7=E7=9A=84::
=20
diff --git a/MAINTAINERS b/MAINTAINERS
index ef87548b8f88..06bbed30b788 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7310,7 +7310,6 @@ F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
 F:	tools/docs/*
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
-F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
 X:	Documentation/devicetree/
@@ -7345,7 +7344,7 @@ L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/sphinx/parse-headers.pl
 F:	scripts/documentation-file-ref-check
-F:	scripts/sphinx-pre-install
+F:	tools/docs/sphinx-pre-install
=20
 DOCUMENTATION/ITALIAN
 M:	Federico Vaga <federico.vaga@vaga.pv.it>
diff --git a/scripts/sphinx-pre-install b/tools/docs/sphinx-pre-install
similarity index 100%
rename from scripts/sphinx-pre-install
rename to tools/docs/sphinx-pre-install
--=20
2.51.0







Thanks,
Mauro

