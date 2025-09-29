Return-Path: <linux-kernel+bounces-835969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05481BA8784
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A80189D1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71B2C030E;
	Mon, 29 Sep 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Ln2C9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AC27E04C;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136047; cv=none; b=ZKcEhkfvw1/mgCUJSUegPOJleW1r9+/C9xHgGITZ1wtYJBpN6mR9dVvME+sp0vATGU9Uls6BvlvnBc1X45Cf7zUmlpN5+GCTkvdC/4q7hKiBPYn9ADlNiSsSssvnTG6U29jZITUsuw4zRNVVupQDVSyv6WUM48tiDUsriULMWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136047; c=relaxed/simple;
	bh=qmAx3BU5iYpF0BhCqjMwryZ9h4swiPNSkQhkpvI834A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSy09KhlG5NW10/faDOzwunhhehwVjj5Ix484E9w3/aoCtgewd8XuKF0N3R1UfJ293i53ukG6wLwKmDlQKwgOi3mtpg4aXNaDarOlW2Uw/Ia1T57kEuctkxwLN779ZhQbMBTROWWlRgFSF2ucjB/Gn+CyfN+I+sjow1E87dyTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Ln2C9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673BAC4CEF5;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136047;
	bh=qmAx3BU5iYpF0BhCqjMwryZ9h4swiPNSkQhkpvI834A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2Ln2C9STkQUXU5rWhlWXnGOaW9Uv2XytplcMDqHPGHRIYiNs44j6pI5oCJXK+m3/
	 eo6PbQU9TMD3U8cF2pl0SbG+p2Lsa1be/C4zWtmVLHlTBUfA5oz68w48OGWIVJVGNx
	 e3x8eaASe1+Wm38I5S5xTh6lLP3mG1OD+Xm2zX2Myl0ra9CJHflzniWjDEmn1y4H5s
	 XWtPrHVws4PMPMZJZdfbWMFUgYQqCsoQAdmAXoSXcAU5CCdU6RTh+iNMsy16NGJzbu
	 PkdVQ4tUz1CjcrmrAmuLi111u+bodT7WZdmyEKl5D3vS1kmt4t3etDL5JfRrL9Z/08
	 83sVYBWYTE9Bg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1v39e1-00000009dSF-21WI;
	Mon, 29 Sep 2025 10:54:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/3] docs: Makefile: avoid a warning when using without texlive
Date: Mon, 29 Sep 2025 10:53:28 +0200
Message-ID: <cd16a7436a510116ef87cd4abbb1f3cfe358012f.1759135339.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759135339.git.mchehab+huawei@kernel.org>
References: <cover.1759135339.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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


