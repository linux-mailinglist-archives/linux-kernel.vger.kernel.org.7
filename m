Return-Path: <linux-kernel+bounces-767522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFFB25598
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8481B66240
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882E302CC4;
	Wed, 13 Aug 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OFm9wmCp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D33093D9;
	Wed, 13 Aug 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120758; cv=none; b=MkStagalTgRFhbwy4sdb8fqhAKeoWWS5spGnsRBr6lBDpbCyk5X2KCRJkrTDwH+Rgf0yioI70P5H5sApBP1S9WEUmrR/obDsz4Tu2SSdpEWm9R+XxPq9sYcq1XIZ3Nw17NxM45SAupeAcZ8ixFN5GcdtLtw8eAiX32/bXhS0ppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120758; c=relaxed/simple;
	bh=EhNf0jiEtdDWAQPcaEI9GyJeZ6PI01pY8P9MzP0ffXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA9zK3PqU1gYC/FfpLs//9NGI+n2c9Jbm61DRl9SySrwRRvQKJdv9qnQTYFiH5aeWNcJnm16eZVyaQCOgNrQ/cooZs+b29Jf9eUmqN885PlXlAl8KW46Wm3yMz4NkUy73lsTEhU5jXk1yFtOtEIMJA6z59s+DanbNKQ3VTnhQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OFm9wmCp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6ED7A40AFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120751; bh=jUgpkfrm8XLsvgYXsY28qPmnnuIaoJZxaMVlOOoZBdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFm9wmCp9vjZFfQTqIyViyS0j9mkr7RsADNIt4/9qID0crcrJ1hL3z834zAI0iAKl
	 RKA1uD84evJQjsQ0bwhTJNLQf2jimZjKPTppmnENFCb1mwJsA7FP+PspodzvwYMe6b
	 jJjjuBT7FyHPbzQeLqLcEA8Oqbr9F73edaCEpJWgppnt6pytKxwn/5joQ74zKd8N+9
	 pWjg5whpukHcqtU58MwXP+RcYtkVq7hLHYwca6g94uggtIkacL9TOBCN9aoe8yYdEN
	 tTtvi5y2Y6Gs2YVu7FlPgsGBEzyLfB4MX4FtTGzPrFLn6DRhVX58ikWyksUtWJzTcC
	 XjUQUCmgD6Mig==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 6ED7A40AFA;
	Wed, 13 Aug 2025 21:32:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
Date: Wed, 13 Aug 2025 15:32:06 -0600
Message-ID: <20250813213218.198582-8-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Put this tool with the other documentation-related scripts.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Makefile                             | 14 +++++++-------
 Documentation/doc-guide/sphinx.rst                 |  4 ++--
 Documentation/sphinx/kerneldoc-preamble.sty        |  2 +-
 .../translations/it_IT/doc-guide/sphinx.rst        |  4 ++--
 .../translations/zh_CN/doc-guide/sphinx.rst        |  4 ++--
 Documentation/translations/zh_CN/how-to.rst        |  2 +-
 MAINTAINERS                                        |  2 --
 {scripts => tools/doc}/sphinx-pre-install          |  0
 8 files changed, 15 insertions(+), 17 deletions(-)
 rename {scripts => tools/doc}/sphinx-pre-install (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index eef5decb79b8..818d866756b0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,7 +46,7 @@ ifeq ($(HAVE_SPHINX),0)
 .DEFAULT:
 	$(warning The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the '$(SPHINXBUILD)' executable.)
 	@echo
-	@$(srctree)/scripts/sphinx-pre-install
+	@$(srctree)/tools/doc/sphinx-pre-install
 	@echo "  SKIP    Sphinx $@ target."
 
 else # HAVE_SPHINX
@@ -105,7 +105,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	fi
 
 htmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/doc/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 # If Rust support is available and .config exists, add rustdoc generated contents.
@@ -119,7 +119,7 @@ endif
 endif
 
 texinfodocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/doc/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
 
 # Note: the 'info' Make target is generated by sphinx itself when
@@ -131,7 +131,7 @@ linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
 
 latexdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/doc/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
 
 ifeq ($(HAVE_PDFLATEX),0)
@@ -144,7 +144,7 @@ else # HAVE_PDFLATEX
 
 pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/doc/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), \
 	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/tools/doc/check-variable-fonts.sh || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
@@ -154,11 +154,11 @@ pdfdocs: latexdocs
 endif # HAVE_PDFLATEX
 
 epubdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/doc/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
 
 xmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/tools/doc/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
 
 endif # HAVE_SPHINX
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 607589592bfb..2a0fc6c39cf4 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -106,7 +106,7 @@ There's a script that automatically checks for Sphinx dependencies. If it can
 recognize your distribution, it will also give a hint about the install
 command line options for your distro::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/doc/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -116,7 +116,7 @@ command line options for your distro::
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/doc/sphinx-pre-install line 468.
 
 By default, it checks all the requirements for both html and PDF, including
 the requirements for images, math expressions and LaTeX build, and assumes
diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/sphinx/kerneldoc-preamble.sty
index 5d68395539fe..736c2568377e 100644
--- a/Documentation/sphinx/kerneldoc-preamble.sty
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -220,7 +220,7 @@
 	    If you want them, please install non-variable ``Noto Sans CJK''
 	    font families along with the texlive-xecjk package by following
 	    instructions from
-	    \sphinxcode{./scripts/sphinx-pre-install}.
+	    \sphinxcode{./tools/doc/sphinx-pre-install}.
 	    Having optional non-variable ``Noto Serif CJK'' font families will
 	    improve the looks of those translations.
 	\end{sphinxadmonition}}
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 1f513bc33618..104aa159c1ce 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -109,7 +109,7 @@ Sphinx. Se lo script riesce a riconoscere la vostra distribuzione, allora
 sarà in grado di darvi dei suggerimenti su come procedere per completare
 l'installazione::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/doc/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -119,7 +119,7 @@ l'installazione::
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/doc/sphinx-pre-install line 468.
 
 L'impostazione predefinita prevede il controllo dei requisiti per la generazione
 di documenti html e PDF, includendo anche il supporto per le immagini, le
diff --git a/Documentation/translations/zh_CN/doc-guide/sphinx.rst b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
index 23eac67fbc30..3d2c4e262bb5 100644
--- a/Documentation/translations/zh_CN/doc-guide/sphinx.rst
+++ b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
@@ -84,7 +84,7 @@ PDF和LaTeX构建
 这有一个脚本可以自动检查Sphinx依赖项。如果它认得您的发行版，还会提示您所用发行
 版的安装命令::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/doc/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -94,7 +94,7 @@ PDF和LaTeX构建
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/doc/sphinx-pre-install line 468.
 
 默认情况下，它会检查html和PDF的所有依赖项，包括图像、数学表达式和LaTeX构建的
 需求，并假设将使用虚拟Python环境。html构建所需的依赖项被认为是必需的，其他依
diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/translations/zh_CN/how-to.rst
index cf66c72ee0c5..77da507d29cf 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -64,7 +64,7 @@ Linux 发行版和简单地使用 Linux 命令行，那么可以迅速开始了
 ::
 
 	cd linux
-	./scripts/sphinx-pre-install
+	./tools/doc/sphinx-pre-install
 
 以 Fedora 为例，它的输出是这样的::
 
diff --git a/MAINTAINERS b/MAINTAINERS
index b41b78215035..2f1374130240 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7306,7 +7306,6 @@ F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
-F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
 X:	Documentation/devicetree/
@@ -7341,7 +7340,6 @@ L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/sphinx/parse-headers.pl
 F:	tools/doc/
-F:	scripts/sphinx-pre-install
 
 DOCUMENTATION/ITALIAN
 M:	Federico Vaga <federico.vaga@vaga.pv.it>
diff --git a/scripts/sphinx-pre-install b/tools/doc/sphinx-pre-install
similarity index 100%
rename from scripts/sphinx-pre-install
rename to tools/doc/sphinx-pre-install
-- 
2.50.1


