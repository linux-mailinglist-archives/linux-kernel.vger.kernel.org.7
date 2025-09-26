Return-Path: <linux-kernel+bounces-833905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0DBA3520
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A9B189DCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13D2EC086;
	Fri, 26 Sep 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHU4CKYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDAB2EB87B;
	Fri, 26 Sep 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881791; cv=none; b=ss0eUmVJVYZc1MxcFM2rtzuyBAyxHVR9RJRyPPfZDvISuW/m3wmgVYaQnoVTDIY/+l1xSJFEt2VWtncXlRA5cb1cffROkK53v1jMv9WG1/Z4dWDh7YH/qHVi4fHRbQbSvovqKhC7R7JhRdvuBWmPKrUEmlea9AACYDqf4nRBa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881791; c=relaxed/simple;
	bh=qmAx3BU5iYpF0BhCqjMwryZ9h4swiPNSkQhkpvI834A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1qVzUXXt+QHsry6GBuzuopmikdJvS6W4tCd8MS6fzG5euELmCyxPNMJmEFcetH2NG50yRaeEtVuEKYe63DrvUjjkL13PEdxdxITnUBUf56CFILbK0tg/qhlmPtEKhBwzcenJ1MkzjOo7VUklL/ZomCcwAEYTTQEJCwlStLZOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHU4CKYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DD7C4CEF7;
	Fri, 26 Sep 2025 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758881791;
	bh=qmAx3BU5iYpF0BhCqjMwryZ9h4swiPNSkQhkpvI834A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHU4CKYcKEJrNeZpNzhUfnHeMgRON0t7giyIYvluFOB0MulNggBwnCXb5jdOp3mB/
	 Oj6YsxL68tV08KGwtlwMFWG53JottQXEeQZzVTlzPPhHHm8QhUzodNB8JCkh8wWdBh
	 kcvGm1g4jDsNfcMup8D6jzV0xugfYB9doCoYAKoTaGsw1a2D3Tb44yv0z3d/dCxOWC
	 pYMEAXglJjvOVhH8Xd+abi/O9QDkVHjaOlY4idD3gGWqHCnhygejR07FIoqz90Zsi+
	 mmCTvotO6566A7NlNLgbSSZWRc/vOs6laIGNQunkxKNcmoXtGBTkqqP7zw0HXSuKjz
	 AzFIPRQzHHk7w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v25V7-00000005Xoq-1LRq;
	Fri, 26 Sep 2025 12:16:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: Makefile: avoid a warning when using without texlive
Date: Fri, 26 Sep 2025 12:16:19 +0200
Message-ID: <e23e03dd41e044d55e4ae24ffd9e1b49e3f2515a.1758881658.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758881658.git.mchehab+huawei@kernel.org>
References: <cover.1758881658.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Randy, running make htmldocs on a machine
without textlive now produce warnings:

    $ make O=DOCS htmldocs
    ../Documentation/Makefile:70: warning: overriding recipe for target 'pdfdocs'
    ../Documentation/Makefile:61: warning: ignoring old recipe for target 'pdfdocs'

That's because the code has now two definitions for pdfdocs in
case $PDFLATEX command is not found. With the new script, such
special case is not needed anymore, as the script checks it.

Drop the special case. Even after dropping it, on a machine
without LaTeX, it will still produce an error as expected,
as running:

    $ ./tools/docs/sphinx-build-wrapper pdfdocs
    Error: pdflatex or latexmk required for PDF generation

does the check. After applying the patch we have:

    $ make SPHINXDIRS=peci htmldocs
    Using alabaster theme
    Using Python kernel-doc

    $ make SPHINXDIRS=peci pdfdocs
    Error: pdflatex or latexmk required for PDF generation
    make[2]: *** [Documentation/Makefile:64: pdfdocs] Error 1
    make[1]: *** [/root/Makefile:1808: pdfdocs] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

Which is the expected behavior.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/linux-doc/e7c29532-71de-496b-a89f-743cef28736e@infradead.org/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c60db1038c9c..f764604fa1ac 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -66,20 +66,15 @@ htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkche
 		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
 		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
 
-# Special handling for pdfdocs
-ifneq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)
-pdfdocs:
-	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
-	@echo "  SKIP    Sphinx $@ target."
-endif
 
-htmldocs-redirects: $(srctree)/Documentation/.renames.txt
-	@tools/docs/gen-redirects.py --output $(BUILDDIR) < $<
-endif # HAVE_SPHINX
+endif
 
 # The following targets are independent of HAVE_SPHINX, and the rules should
 # work or silently pass without Sphinx.
 
+htmldocs-redirects: $(srctree)/Documentation/.renames.txt
+	@tools/docs/gen-redirects.py --output $(BUILDDIR) < $<
+
 refcheckdocs:
 	$(Q)cd $(srctree);scripts/documentation-file-ref-check
 
-- 
2.51.0


