Return-Path: <linux-kernel+bounces-710240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B69AEE9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 23:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ADB1BC005B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684E28D844;
	Mon, 30 Jun 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpS9xL8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FD23F419;
	Mon, 30 Jun 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320364; cv=none; b=RFpVOKobTseCQ9RDcP6k3+caQLBJclN8KE4vRNWgb/oLiRvP4Iyqvx77DZbzk/cfHHIk3cqNYCDJbKH/KmelvJrZesW0Ngtr+JBxnjWdGTiFKBqRmHMuEeokwR8r/D23Tbna8ALPc0psFsv6deJ+q0GjbUYkt7j8cG1SbSbLiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320364; c=relaxed/simple;
	bh=EbQjzz4Wn2NcXKYSjIXnwavVPRnv6w1AGbo9KYaA4sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgAR4LVq6a9KYG+LjcRTu0pQcLlC0WbihJjDgTYQ50shFARFmBCeuYECHZqYHJ1jVr0GWCBACoWEm6Oskk6JAFxNxS/uSv5Jhfn6juLlHa8487Bg23ER1ZiDuAWWVtkqnBJNFpOeWOeZY0m+et8rtkrsTz2bjuL61sSSVHtNZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpS9xL8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF18C4AF0B;
	Mon, 30 Jun 2025 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751320364;
	bh=EbQjzz4Wn2NcXKYSjIXnwavVPRnv6w1AGbo9KYaA4sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpS9xL8VZqmBUau0mJJbs+N10fHTtsA0roON6F7ZvioLJ2TJna/frWUZgQJZIMcEJ
	 qhpG2xzb+nYypioom7V9Gn/SdhTtfVPK8FJYKbTNwSZHT9V6nvyhZPmlNh3V+iOVFL
	 TisG8wbJ08iP7uA8Kf61ntYHuyXh9qAgjAIdx5LkfFGWoCH+thSqwMLzX/M3BXD5Pu
	 TgDuPnl4qHB8Og5/UsE5huXxR2NJ9KjsYLlgPdHTxoMKBocS318GAPY/Y6vtySD8wu
	 ApgNT6FpCuGLDTaOvnyyT4BE8yC0Lg+dF2aa4yIcimW95jZRJss7qwo0F1Fkr3cFS5
	 mrveNchimSxLg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uWMQc-00000003QWN-1hOm;
	Mon, 30 Jun 2025 23:52:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Sai Vishnu M" <saivishnu725@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] scripts: sphinx-pre-install: rename it to scripts/sphinx-pre-install.pl
Date: Mon, 30 Jun 2025 23:34:50 +0200
Message-ID: <da164dc3ef2e5a0148bb4f86ca0be56263b2a8e5.1751318230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751318230.git.mchehab+huawei@kernel.org>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
2.50.0


