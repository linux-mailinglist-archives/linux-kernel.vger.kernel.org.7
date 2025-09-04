Return-Path: <linux-kernel+bounces-800159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C53B43437
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF377A1469
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F32C032C;
	Thu,  4 Sep 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFHtWIoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6D2BE047;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=o1yRfTCv7HXSOER6kROKj/T+e0gLvWpOUGRkg4ruDvwd/ekZsEv7Typ7RVl6fJhCN4y6BrER1mMy1SiEm4G0OigAhTXP+smLnzeDthwTCDObdbcz/+VLvhdWV0S5HywdUimydoRFE411ZbhY8sWJ0MYBTwTM2Y1tUOA/v7Y5NMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=ZNNE9b19wje69qRgb12NqpyGw7VPdaWJOQjCEXZjJk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8JSRJtfanSt3MFa9vc40A+DhfKrOcP2+uYYX6VCXHAak9q3RGym96Iun6Q1YP7H07s82aSiKB60CVjefNFxDCD1lkef/UAxc0rp4UWObfBUoX85ctGND3AUDOuYcKBQ2mGtyi4b5EGgEuTsR/a6M9Z+X0KO3A2/Zj4RSArxThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFHtWIoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FD7C4CEF7;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=ZNNE9b19wje69qRgb12NqpyGw7VPdaWJOQjCEXZjJk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFHtWIoQnELSsuWk18yCioYqGRCY7pb0GSTNyIyMRf8r1IRrecfC3yj6qTXGnzE2/
	 YUrkzNEMbBEonxMHlD3dHSz8nUhjTVKj6M00zhD7UoMjR/hU/39CF29f9AvuWiI9sN
	 OBv08m21YG933gwg1+pNYp1uAQM+bWCNhgycmq7noPy5Im9/3OyuQ+G281Uuh4Pi2T
	 uxbGtcUIMV1DsLNfRVoYHq/oi3du84nsBj9wG8pKu8nW1lpz5oSRI+yUxuFfVEDkGE
	 J7nj7otrmst6hsUVjJTAsdoYeqR047gr2H8TGQWAy65cUquuitQND1scjYWDS/JKPi
	 OGwbhR2rg8c4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPL-3DfW;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Alex Shi <mchehab+huawei@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/19] scripts: sphinx-pre-install: move it to tools/docs
Date: Thu,  4 Sep 2025 09:33:04 +0200
Message-ID: <68810fc1065bbe8ef1305041fb10fa632bb64dd3.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
 {scripts => tools/docs}/sphinx-pre-install         |  0
 8 files changed, 16 insertions(+), 17 deletions(-)
 rename {scripts => tools/docs}/sphinx-pre-install (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c20c68be89a..deb2029228ed 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,7 +46,7 @@ ifeq ($(HAVE_SPHINX),0)
 .DEFAULT:
 	$(warning The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the '$(SPHINXBUILD)' executable.)
 	@echo
-	@$(srctree)/scripts/sphinx-pre-install
+	@$(srctree)/tools/docs/sphinx-pre-install
 	@echo "  SKIP    Sphinx $@ target."
 
 else # HAVE_SPHINX
@@ -105,7 +105,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	fi
 
 htmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 # If Rust support is available and .config exists, add rustdoc generated contents.
@@ -119,7 +119,7 @@ endif
 endif
 
 texinfodocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
 
 # Note: the 'info' Make target is generated by sphinx itself when
@@ -131,7 +131,7 @@ linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
 
 latexdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
 
 ifeq ($(HAVE_PDFLATEX),0)
@@ -144,7 +144,7 @@ else # HAVE_PDFLATEX
 
 pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), \
 	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
@@ -154,11 +154,11 @@ pdfdocs: latexdocs
 endif # HAVE_PDFLATEX
 
 epubdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
 
 xmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/docs/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
 
 endif # HAVE_SPHINX
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 607589592bfb..932f68c53075 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -106,7 +106,7 @@ There's a script that automatically checks for Sphinx dependencies. If it can
 recognize your distribution, it will also give a hint about the install
 command line options for your distro::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -116,7 +116,7 @@ command line options for your distro::
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-pre-install line 468.
 
 By default, it checks all the requirements for both html and PDF, including
 the requirements for images, math expressions and LaTeX build, and assumes
diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/sphinx/kerneldoc-preamble.sty
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
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 1f513bc33618..a5c5d935febf 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -109,7 +109,7 @@ Sphinx. Se lo script riesce a riconoscere la vostra distribuzione, allora
 sar�� in grado di darvi dei suggerimenti su come procedere per completare
 l'installazione::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -119,7 +119,7 @@ l'installazione::
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-pre-install line 468.
 
 L'impostazione predefinita prevede il controllo dei requisiti per la generazione
 di documenti html e PDF, includendo anche il supporto per le immagini, le
diff --git a/Documentation/translations/zh_CN/doc-guide/sphinx.rst b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
index 23eac67fbc30..3375c6f3a811 100644
--- a/Documentation/translations/zh_CN/doc-guide/sphinx.rst
+++ b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
@@ -84,7 +84,7 @@ PDF���LaTeX������
 ������������������������������������Sphinx������������������������������������������������������������������������
 ������������������::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -94,7 +94,7 @@ PDF���LaTeX������
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-pre-install line 468.
 
 ������������������������������html���PDF������������������������������������������������������LaTeX���������
 ���������������������������������Python���������html���������������������������������������������������������
diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/translations/zh_CN/how-to.rst
index ddd99c0f9b4d..714664fec308 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -64,7 +64,7 @@ Linux ��������������������������� Linux ���������������������������������������
 ::
 
 	cd linux
-	./scripts/sphinx-pre-install
+	./tools/docs/sphinx-pre-install
 
 ��� Fedora ���������������������������������::
 
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
 
 DOCUMENTATION/ITALIAN
 M:	Federico Vaga <federico.vaga@vaga.pv.it>
diff --git a/scripts/sphinx-pre-install b/tools/docs/sphinx-pre-install
similarity index 100%
rename from scripts/sphinx-pre-install
rename to tools/docs/sphinx-pre-install
-- 
2.51.0


