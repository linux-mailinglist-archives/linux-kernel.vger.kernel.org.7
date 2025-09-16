Return-Path: <linux-kernel+bounces-818572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EDEB5938F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA083A25AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F82307AEB;
	Tue, 16 Sep 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI74MxlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBE30506B;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018216; cv=none; b=SllC/iRXe1E9kzBDEtZFzCQvjOotsOmNWlu653C3KVJ5SQTY+oRcrvgRPNzyn69VU9Idi2u2qUki8HT15cMOKo1czB02KpfVGQtOse0Vav9NsCzqkUVnl0CylCAWvsv7bJyD+n3y5sST1yW5eQBzcOeRa0lMn50FurukVgT6T1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018216; c=relaxed/simple;
	bh=RA0/ekzI7CRYoWgGJgL3xHaUnMDzW+byVWgWPtUcfXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sykO03hSufJ7I9UhpDJUQufF7V3d4ky4DCuWthfJmNqYl4G+YqmcYoocLLYYTvULaJsu71hwE1i7ZRfxOxDXRAQfFZd3TdIMI4oGkwts+KOlN6ALGfgx/u/H1nAF7hrHS0gtS3+v1g0Mt7j4hDe5BwUqNhHAIhU4vmXV27QLGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI74MxlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E1C4CEFF;
	Tue, 16 Sep 2025 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018216;
	bh=RA0/ekzI7CRYoWgGJgL3xHaUnMDzW+byVWgWPtUcfXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI74MxlYAnqgcXd6+gS00a/905aEVeBHkE5VMViVYcEKNrAlYT3/FEJ3IY8PbHilO
	 D7YrRwdNaqYKv4MpDByOK8FPWiaY5nF0CbfnaNLt9M1pvjX44SuWwgPSdFERpZGAnR
	 meH7bxSeydYsVExk0eTYhY0R7invIt+pW6Lsr32Faf9oR6biN3DDbZ0u9Wg5r+wL4N
	 D0hXEygxPL2TVVxf6Ywe77VhVzzdZek+t8jXZRKon/ZjuzmGlbRvmEUDiC0UJPrEnM
	 ZUJrpVBDr1BAAssfaxiBGTplxNUEF03T0ef0YVKHsiHS0KFCrIkN1qpqDDhEPTUvfY
	 eoP2HvWf6vyhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBOw-3GuL;
	Tue, 16 Sep 2025 12:23:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Alex Shi <mchehab+huawei@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/21] scripts: sphinx-pre-install: move it to tools/docs
Date: Tue, 16 Sep 2025 12:22:42 +0200
Message-ID: <c924970d3f52e50c8cc61f71021e657aed67a098.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
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
index b630d489b113..7570d4cf3b13 100644
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
 	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/tools/docs/check-variable-fonts.py || exit; \
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
 sar� in grado di darvi dei suggerimenti su come procedere per completare
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
@@ -84,7 +84,7 @@ PDF\u548cLaTeX\u6784\u5efa
 \u8fd9\u6709\u4e00\u4e2a\u811a\u672c\u53ef\u4ee5\u81ea\u52a8\u68c0\u67e5Sphinx\u4f9d\u8d56\u9879\u3002\u5982\u679c\u5b83\u8ba4\u5f97\u60a8\u7684\u53d1\u884c\u7248\uff0c\u8fd8\u4f1a\u63d0\u793a\u60a8\u6240\u7528\u53d1\u884c
 \u7248\u7684\u5b89\u88c5\u547d\u4ee4::
 
-	$ ./scripts/sphinx-pre-install
+	$ ./tools/docs/sphinx-pre-install
 	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
 	Warning: better to also install "texlive-luatex85".
 	You should run:
@@ -94,7 +94,7 @@ PDF\u548cLaTeX\u6784\u5efa
 		. sphinx_2.4.4/bin/activate
 		pip install -r Documentation/sphinx/requirements.txt
 
-	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+	Can't build as 1 mandatory dependency is missing at ./tools/docs/sphinx-pre-install line 468.
 
 \u9ed8\u8ba4\u60c5\u51b5\u4e0b\uff0c\u5b83\u4f1a\u68c0\u67e5html\u548cPDF\u7684\u6240\u6709\u4f9d\u8d56\u9879\uff0c\u5305\u62ec\u56fe\u50cf\u3001\u6570\u5b66\u8868\u8fbe\u5f0f\u548cLaTeX\u6784\u5efa\u7684
 \u9700\u6c42\uff0c\u5e76\u5047\u8bbe\u5c06\u4f7f\u7528\u865a\u62dfPython\u73af\u5883\u3002html\u6784\u5efa\u6240\u9700\u7684\u4f9d\u8d56\u9879\u88ab\u8ba4\u4e3a\u662f\u5fc5\u9700\u7684\uff0c\u5176\u4ed6\u4f9d
diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/translations/zh_CN/how-to.rst
index ddd99c0f9b4d..714664fec308 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -64,7 +64,7 @@ Linux \u53d1\u884c\u7248\u548c\u7b80\u5355\u5730\u4f7f\u7528 Linux \u547d\u4ee4\u884c\uff0c\u90a3\u4e48\u53ef\u4ee5\u8fc5\u901f\u5f00\u59cb\u4e86
 ::
 
 	cd linux
-	./scripts/sphinx-pre-install
+	./tools/docs/sphinx-pre-install
 
 \u4ee5 Fedora \u4e3a\u4f8b\uff0c\u5b83\u7684\u8f93\u51fa\u662f\u8fd9\u6837\u7684::
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 76dd823bfcc4..16a5d6ab627d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7309,7 +7309,6 @@ F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
 F:	tools/docs/*
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
-F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
 X:	Documentation/devicetree/
@@ -7344,7 +7343,7 @@ L:	linux-doc@vger.kernel.org
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


