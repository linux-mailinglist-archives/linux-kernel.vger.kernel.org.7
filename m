Return-Path: <linux-kernel+bounces-770820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAFB27F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7D1AE696E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA130100E;
	Fri, 15 Aug 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSxNQKfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA62882A1;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=Do9+e1uOF7mlHGrg4wKCnjQ5mHgg7QxM1pjHFMPUg/khfeqfdF4kLkhLQ0J+tBN/A1+JsFhsr3YBnznVrt63tI4d+mmmC3QGdCfDELlWkAvfItg1oSOcO4SS6tcYoGsbxsZJp7uFHAXYPCa5LLmxYRH8NcjjDs2+yucn7jH4PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=PgoMVLECaBOExEXb56ZJhk6niEL59BPqFAalBLW0AT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uln0scuNQm6rpHVFWcBlBXvl1PzJG2TZze53uJaCeXH+jkE3iM6rgdxzC6ikVLHtjJ5NHtI6Zv2zE3g6zKzqWgOpBd57Qa2FlnvitVnR33mwCsRL3Z6CiWgYQlRQWSXbMqU27xLeJcuv2l4EQugPpO9yNGdqvNf1qZ229L89cTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSxNQKfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B4CC4AF0B;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257845;
	bh=PgoMVLECaBOExEXb56ZJhk6niEL59BPqFAalBLW0AT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSxNQKfSH1Vzj91lLyfJbN5JIeU84GyLRPGigVSEhDoTj4NiUYeWb6NwLHTMJrexe
	 L3xlUj6NgYz9QArzHSlpYLGxKviHiUS1t0Uh31PWH+ppV6wxctF0VSgFRn/WQTW/R3
	 704OeQ6pmQQ56rZpjvL4mQWtwpdxgb3tTVy+JwbSNE2TW0aQyVInYUETPUM8wML+Ze
	 NtRsbOnj4VGsKLuPCo/3kHejcQFUWp+j5QzWkFj0sZZAAWw51+F5/1Ai15az//XD2h
	 THJt9Qtvbex3KcDv/4NK7HnWQwHT0roc3/wa1VwzCfxpsuS33QOPdaDVbdYNJowxrk
	 g6QDPwKuS30KQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042TD-0J3P;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] docs: conf.py: fix some troubles for LaTeX output
Date: Fri, 15 Aug 2025 13:36:21 +0200
Message-ID: <ceaa9512336444bd148511a4a3bbc336ca317757.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While PDF docs work fine on RPM-based distros, it causes conflicts
on Debian & friends:

Documentation/output/process/latex/process.log:

	Package: fontenc 2021/04/29 v2.0v Standard LaTeX package
	LaTeX Font Info:    Trying to load font information for T1+lmr on input line 11
	6.
	LaTeX Font Info:    No file T1lmr.fd. on input line 116.

	LaTeX Font Warning: Font shape `T1/lmr/m/n' undefined
	(Font)              using `T1/lmr/m/n' instead on input line 116.

	! Corrupted NFSS tables.
	wrong@fontshape ...message {Corrupted NFSS tables}
                                                  error@fontshape else let f...
	l.116 ...\familydefault\seriesdefault\shapedefault

Change some logic inside latex_elements to avoid such issues,
following the example from Sphinx documentation:

	https://www.sphinx-doc.org/en/master/latex.html

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 6e12c7d8e07e..712e0a016727 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -9,6 +9,8 @@ import os
 import shutil
 import sys
 
+from  textwrap import dedent
+
 import sphinx
 
 # If extensions (or modules to document with autodoc) are in another directory,
@@ -454,19 +456,38 @@ htmlhelp_basename = "TheLinuxKerneldoc"
 latex_elements = {
     # The paper size ('letterpaper' or 'a4paper').
     "papersize": "a4paper",
+    "passoptionstopackages": dedent(r"""
+        \PassOptionsToPackage{svgnames}{xcolor}
+        % Avoid encoding troubles when creating indexes
+        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
+    """),
     # The font size ('10pt', '11pt' or '12pt').
     "pointsize": "11pt",
+    # Needed to generate a .ind file
+    'printindex': r'\footnotesize\raggedright\printindex',
     # Latex figure (float) alignment
     # 'figure_align': 'htbp',
     # Don't mangle with UTF-8 chars
+    "fontenc": "",
     "inputenc": "",
     "utf8extra": "",
+    'fontpkg': dedent(r'''
+        \usepackage{fontspec}
+        \setmainfont{DejaVu Serif}
+        \setsansfont{DejaVu Sans}
+        \setmonofont{DejaVu Sans Mono}
+        \newfontfamily\headingfont{DejaVu Serif}
+    '''),
     # Set document margins
-    "sphinxsetup": """
+    "sphinxsetup": dedent(r"""
         hmargin=0.5in, vmargin=1in,
         parsedliteralwraps=true,
         verbatimhintsturnover=false,
-    """,
+    """),
+    "preamble": dedent(r"""
+        % Load kerneldoc specific LaTeX settings
+        \input{kerneldoc-preamble.sty}
+    """),
     #
     # Some of our authors are fond of deep nesting; tell latex to
     # cope.
@@ -474,22 +495,8 @@ latex_elements = {
     "maxlistdepth": "10",
     # For CJK One-half spacing, need to be in front of hyperref
     "extrapackages": r"\usepackage{setspace}",
-    # Additional stuff for the LaTeX preamble.
-    "preamble": """
-        % Use some font with UTF-8 support with XeLaTeX
-        \\usepackage{fontspec}
-        \\setsansfont{DejaVu Sans}
-        \\setromanfont{DejaVu Serif}
-        \\setmonofont{DejaVu Sans Mono}
-    """,
 }
 
-# Load kerneldoc specific LaTeX settings
-latex_elements["preamble"] += """
-        % Load kerneldoc specific LaTeX settings
-        \\input{kerneldoc-preamble.sty}
-"""
-
 # This will be filled up by config-inited event
 latex_documents = []
 
-- 
2.50.1


