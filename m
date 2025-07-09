Return-Path: <linux-kernel+bounces-723768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BEAFEAF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85385601B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5932E6D1A;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO/2+0KJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D322DA779;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=snA5sGm8RIkKvwApS/zlVL5qxGZKB2yXdP6n8vP1h0FzLJvgpdux3aWqLAQdxsF+WIYaX3Q8LOyaA7KfoDnim7jjEohf8m+LZ8qA8+CKmq9kfDzUm8c6qUOB//PmM5F7mqNZTfbJEfI/ZQvW6vwbxORtjLkbfbme5/tlHmbHtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=+TBUBYTi9gH91LzPyWP0mDdtOQh95p8itcp7aVTzYYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK43zK4n45x9EH3HLrSmFGrxIPCaWT/LSZuAZfJJV7/7KMbWuR9fnjvCkvVIaDgCuc7zt9A+oiAj6cRFX/edAJfBywgv7uj4PpDxzGQF3KWUA73uFHN9YWIiaAgp7jxDrura2fBW3TsyJI9beA2tW8PsYP6FzwZmsrpboxhMVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO/2+0KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DC4C4CEFC;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=+TBUBYTi9gH91LzPyWP0mDdtOQh95p8itcp7aVTzYYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jO/2+0KJO1brlTstJ02pdAyi21A+L/2VLeZVF3Prjqg9uS84p+zSSOt59U7F52A+D
	 HRfbtp8SugvSKrcLKfa3iPwch9HORH7C+KLSSQPVh0e00yT3LSV7bC2ylo0/PDqSPM
	 6o7sOeSjP4N0XbduNjfWIZY54FF86F85CkRlunYxTOfs159TvMfp9bDVaatv/Q6jDO
	 I4PWWho4cI7YI3GSdeC0ZL6e2jabmyj8POhLbabocqsEfwhicKVE0pxnBfsmEV2gNy
	 X0XPVtM2bt5b2XCvc4Ht1MpFRA6MMPghSE0yI7xWnRQ+JVUFhVxlyfQwdLqlfDCc1Z
	 aEEcYNw2k83ZA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECC-0oPf;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/39] scripts: sphinx-pre-install: rename it to scripts/sphinx-pre-install.pl
Date: Wed,  9 Jul 2025 15:51:34 +0200
Message-ID: <6547c67c1c951b5f49edb4429f76942af215eddd.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

That helps us to later replace the scripts.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile                             | 14 +++++++-------
 .../{sphinx-pre-install => sphinx-pre-install.pl}  |  0
 2 files changed, 7 insertions(+), 7 deletions(-)
 rename scripts/{sphinx-pre-install => sphinx-pre-install.pl} (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b98477df5ddf..c486fe3cc5e1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,7 +46,7 @@ ifeq ($(HAVE_SPHINX),0)
 .DEFAULT:
 	$(warning The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the '$(SPHINXBUILD)' executable.)
 	@echo
-	@$(srctree)/scripts/sphinx-pre-install
+	@$(srctree)/scripts/sphinx-pre-install.pl
 	@echo "  SKIP    Sphinx $@ target."
 
 else # HAVE_SPHINX
@@ -121,7 +121,7 @@ $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
 htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
 
 htmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 # If Rust support is available and .config exists, add rustdoc generated contents.
@@ -135,7 +135,7 @@ endif
 endif
 
 texinfodocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
 
 # Note: the 'info' Make target is generated by sphinx itself when
@@ -147,7 +147,7 @@ linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
 
 latexdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
 
 ifeq ($(HAVE_PDFLATEX),0)
@@ -160,7 +160,7 @@ else # HAVE_PDFLATEX
 
 pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
 	$(foreach var,$(SPHINXDIRS), \
 	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
@@ -170,11 +170,11 @@ pdfdocs: latexdocs
 endif # HAVE_PDFLATEX
 
 epubdocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
 
 xmldocs:
-	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
 
 endif # HAVE_SPHINX
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install.pl
similarity index 100%
rename from scripts/sphinx-pre-install
rename to scripts/sphinx-pre-install.pl
-- 
2.49.0


