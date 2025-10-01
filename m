Return-Path: <linux-kernel+bounces-839028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AD4BB0AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165B87AC71C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8513C254AF5;
	Wed,  1 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYnKIJGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C048CFC;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328136; cv=none; b=HPukxYFt2ZcDQOwVaDAOl3DnewZWrgaiTMo3YRT0ISiszA5+J4PfvEGKQcmIhl3ziexQPwKjmxoIZFtZIS13MXP/FWchOCaPo9P/I6p198eqGIhL2dj6YvDqJwq2+h1cunAftBdj+J6osH2dil+Z5yCrVMLfTZGqqpSd7ZrF1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328136; c=relaxed/simple;
	bh=qmAx3BU5iYpF0BhCqjMwryZ9h4swiPNSkQhkpvI834A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAW5MqtsT92ymlH5wO6v4qvq5Zai/3clQ2hiJZ25+8i8VggBJ9lSKYp2qS2nOWgqta8nzkpB2Ac9LdguhIwYkRBG3nfz3PIS3GcdNDdFMRBnp6O7bfuInoSnt/PDZhukfan/hXuHV3mO2hwyuwZu/+3Ni73GhPS6mW+bCsAykkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYnKIJGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBABC4CEF5;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328136;
	bh=qmAx3BU5iYpF0BhCqjMwryZ9h4swiPNSkQhkpvI834A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYnKIJGZV2kdgcDaXkRkUeELPfwyrroADbIE9SFPuGFRJpQDhw+jcZD3YimmlEb9S
	 StAlb6xbUC4ESEnTMWHFGBZH3k/SYpI1xkah6GHHKpP5gZpziac9jCW2cMKy1rZ4un
	 Y4jvqxt1MWnlnkwRCGD8dGGXobn9+pJ+LoJh1hMuPKXi2OKBBrBcxmj3G1awzORt2u
	 XPb5kjhoaWAv3Y6ztp/bYYv4/4O79wJRsd9v6r2BUWlJ+2LpRRWV51nzH+HFlxZ6Ja
	 hSeEJJCIt91vdM9gv1qxxcTRGbvtCmsE5/zUr8qutmjuAymK/hdatm9LylGf9qQgnG
	 ywYe8aZHX+G2w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3xcE-0000000BJ9N-38G3;
	Wed, 01 Oct 2025 16:15:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] docs: Makefile: avoid a warning when using without texlive
Date: Wed,  1 Oct 2025 16:15:24 +0200
Message-ID: <cd16a7436a510116ef87cd4abbb1f3cfe358012f.1759328070.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759328070.git.mchehab+huawei@kernel.org>
References: <cover.1759328070.git.mchehab+huawei@kernel.org>
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


