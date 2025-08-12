Return-Path: <linux-kernel+bounces-765170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED6B22C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2D4189EEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065F2FA819;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpmT1wJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BE2F28E2;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=HR+ZX7ERCVFHhLHYCnnlIxZmjNYKQ04/Zfk556QxwbMNvYCdos45ylL9BoaCv8DqUzlmzoUPKWaipaxEKwDBu0XLjJxWE0K/3SvECU7ItubfB0xAdC0tjCg1k+65DHjIfepRE+xmd+UtPevNoGl8wo+ox6PqWWOwZp5P+yd1a9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=8zP8NZvDvUvs74ttgmIZZECJykztS2ZwmnhgJaultkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCWrHgwcsh5r0wl7sQwPS4kmj5URfpcR1UWb8WHH93aXhAsY4sKCm4g9F6Pon8z3wiHrgn92bqV6+ybDp1eoLqHPomCg5g7nDUMjII+RoY3uSwtlbE6ycsz1gGAUw5adcd5sy6ebEFYB3h3YON9XltyFWBuOgx4D+EDFVV61rRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpmT1wJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B97C4CEFB;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=8zP8NZvDvUvs74ttgmIZZECJykztS2ZwmnhgJaultkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpmT1wJPOBB0McfHSic7rm7vkIGC7mGedxK4InyrjTYusUS5pYW2aDip4GdakkvBE
	 UFOYNauGqhvMkXHAh0ECEwJ8NHPgD1bDguGu9/BV4rL4tJ3QOyv8cquT+LUSW6xABi
	 fLEQqgj8yFZOPcaq1ulj42+9iqF+W5SdBXzr0be+rhZJvphyIy2QdLpvgWfZLZfwlq
	 9mxWWFPu47SiATrGcwnKMkVnqxWYGeMvAhBweDdNhUBrbPc0u2gaZrKSSUxDSlQL3+
	 a+3eHtDiKvhVCdPSzzPREVhEQWWWnPYdpFkQWAWka86wq7hO1jSRbnS9PIcdimN68f
	 70PBkNf+excTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVK-0SXG;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/39] scripts: sphinx-pre-install: rename it to scripts/sphinx-pre-install.pl
Date: Tue, 12 Aug 2025 17:52:19 +0200
Message-ID: <08d9a32a5aaf3784fef016594efe505d7c5a2697.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


