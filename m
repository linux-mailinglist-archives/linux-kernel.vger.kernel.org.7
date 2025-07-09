Return-Path: <linux-kernel+bounces-723773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23506AFEB01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE7A4A3098
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DD92E8E02;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPYVZqDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA32E3B0E;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=BHZQ3Sxvr/NDxY/7uD3Swt2/RAgIdsPixEj0tMCaLNPbxySEAwCiB7L1n+0J79XXLIjLsEWh0pDaN2ftoTv0OtRkCKc4F4630xyuxzDDUu6hikyQ7YmeEa46Rj0CpQK5TuHGFlwCTFrXi/4Tiao6t7wq65k3ht1pgG40PPSHEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=75GiMI5XCY8qjELRgZ3Vc7ro1BQ9wVlsucAKGUjaS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5ncATvIllZf+QVxaLygym32ZIC35PfdxT0TbBXzvHBzukMLrf0jXs9cT11ja0HuOWcZbqGC/MmbdaCf9RuSd5Z2Frl43Avrj7lhnnR+JCNUCs1P/C7XZlALsqSa7/V40tMbdT1KxozkV1gHw/KwCbHq2YiBjRChyRkYpBvZBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPYVZqDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142E6C2BCB7;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=75GiMI5XCY8qjELRgZ3Vc7ro1BQ9wVlsucAKGUjaS/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPYVZqDFm9gN+x+ZwMlAmFVXp4qhoBrYrQqtJur70myQmPcZ6mH6ClpvjNkgfy3fW
	 4ESJe+YyjUlXz68Bz6FAl1IW312OpD7VRUuqUo8DEVFOBmeL3Z99wdF000yCpkSmHv
	 2vQmwRWbeb6CWPUVq4VXYK4hgk0XUhUtI2CkqxNRYL3V3zb9cZhqx2Wh3iJ6SbVY60
	 +Gu0EfSEXhB8JcWA4OeotC07jfUQwTaf9V49UQdcgiRidytQZKICE4dR76DXyR+JnZ
	 P9bcT1tvEYQuKyHlVTvXXB42hIqNv4q4hoGPMf9VraaMHD32OK3s+hw5kiA9LLBQek
	 upmdaK8UmP8Bw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDy-3s32;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/39] docs: Makefile: switch to the new scripts/sphinx-pre-install.py
Date: Wed,  9 Jul 2025 15:52:10 +0200
Message-ID: <10acb9930e6505c52d89a649bc89601fef116cda.1752067814.git.mchehab+huawei@kernel.org>
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

Now that we have a better, improved Python script, use it when
checking for documentation build dependencies.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile                             | 14 +++++++-------
 .../{sphinx-pre-install.py => sphinx-pre-install}  |  0
 2 files changed, 7 insertions(+), 7 deletions(-)
 rename scripts/{sphinx-pre-install.py => sphinx-pre-install} (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c486fe3cc5e1..b98477df5ddf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -46,7 +46,7 @@ ifeq ($(HAVE_SPHINX),0)
 .DEFAULT:
 	$(warning The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the '$(SPHINXBUILD)' executable.)
 	@echo
-	@$(srctree)/scripts/sphinx-pre-install.pl
+	@$(srctree)/scripts/sphinx-pre-install
 	@echo "  SKIP    Sphinx $@ target."
 
 else # HAVE_SPHINX
@@ -121,7 +121,7 @@ $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
 htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
 
 htmldocs:
-	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
+	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 # If Rust support is available and .config exists, add rustdoc generated contents.
@@ -135,7 +135,7 @@ endif
 endif
 
 texinfodocs:
-	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
+	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
 
 # Note: the 'info' Make target is generated by sphinx itself when
@@ -147,7 +147,7 @@ linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
 
 latexdocs:
-	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
+	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
 
 ifeq ($(HAVE_PDFLATEX),0)
@@ -160,7 +160,7 @@ else # HAVE_PDFLATEX
 
 pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
-	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
+	@$(srctree)/scripts/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), \
 	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
@@ -170,11 +170,11 @@ pdfdocs: latexdocs
 endif # HAVE_PDFLATEX
 
 epubdocs:
-	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
+	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
 
 xmldocs:
-	@$(srctree)/scripts/sphinx-pre-install.pl --version-check
+	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
 
 endif # HAVE_SPHINX
diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install
similarity index 100%
rename from scripts/sphinx-pre-install.py
rename to scripts/sphinx-pre-install
-- 
2.49.0


