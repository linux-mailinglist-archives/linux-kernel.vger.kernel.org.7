Return-Path: <linux-kernel+bounces-785196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0672B3476C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AD15E7128
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0850C3043DC;
	Mon, 25 Aug 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaigDscE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E13002AC;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139449; cv=none; b=i4cIz1+7Rg1hjPfGT3O7CefcBYNhyim2vUHXrAz2ZxmusjVngw/fU2f0NC2tuOIf4YKz4SFHRd3KoKF00JaCJNHHOYmSp0X4gpvOm8diXPzA8sv37yybPfgw9i2DfOQLEDwy9b+geKYuc+lrSv2CbZ996nJPiE68+zlYYore00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139449; c=relaxed/simple;
	bh=7GnO3HikSmm/j8N04JDdRzA73zbHZ6baYyVkORZ4ge8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqWtWalRnoHHpViRJo5gb5TLh1ZVBbvkckIloksA3tpYIR/VGC6z9oh0XB2VgAU9t/H1CO/OBimbGyfjr0qXu3/thfKzYOCetY3xrC/XjHvrfgjsJr9ioJgRwfU3YNJWFVmARpW5qawrXgTXVevUih7bUQFJmK8Ddur3xDNb4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaigDscE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2800BC4AF0B;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139449;
	bh=7GnO3HikSmm/j8N04JDdRzA73zbHZ6baYyVkORZ4ge8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaigDscE2hufRauQSbUki4a3vg7S8LeZWmD7Ershpweg7tEjOS7CE3FBQRGmGu5aJ
	 EuZxXJGnkYP1oMMQBRBYhv5HLXoO5SguPfF9JAu1HeNPkCXaUGYK4bNv097jMHa7w3
	 hJpGsaWTB9NTyr/dfaBUY0N34FJ6DQmnuBnvtrzRhNt6SGDk+V55+jgaya8Tpw1qSg
	 EbNM272yuLjE15dlL8Ev3C7QnjytpsnYJywjI5G382scD7EhTrL9BCJcvqPh3TNwEy
	 cM+FtiF6dgT3a2k8KmWNSyiuUrEF5s5GvBGh2C8lcA9Ngml6a8xazHFV52B8XYqXHx
	 gGSzH6B1a5d5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqa5n-0000000HALU-11iz;
	Mon, 25 Aug 2025 18:30:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] scripts: sphinx-pre-install: move it to tools/docs
Date: Mon, 25 Aug 2025 18:30:31 +0200
Message-ID: <df90499c5e5a873a843bbad39f8cb659b41908d1.1756138805.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756138805.git.mchehab+huawei@kernel.org>
References: <cover.1756138805.git.mchehab+huawei@kernel.org>
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
 Documentation/Makefile                     | 14 +++++++-------
 {scripts => tools/docs}/sphinx-pre-install |  0
 2 files changed, 7 insertions(+), 7 deletions(-)
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
diff --git a/scripts/sphinx-pre-install b/tools/docs/sphinx-pre-install
similarity index 100%
rename from scripts/sphinx-pre-install
rename to tools/docs/sphinx-pre-install
-- 
2.51.0


