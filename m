Return-Path: <linux-kernel+bounces-779272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE83B2F188
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B0158385D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E82FD1CB;
	Thu, 21 Aug 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArhJONt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA72EB85C;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764224; cv=none; b=aRO7QkIBKcwYu7QB119kHrGo7foURG7vvLe+wuIfN65+q3zRinEFagL67u561KPhrjozjGRLvKnQmYja+y+lkcYqNKco+NDVDYib4T0JydY4ZEB5JPjNo4tbgKoSM3wkrnxsneZPIiEYiXpNAkVEXuytcEnKr8httaDwxjv3Ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764224; c=relaxed/simple;
	bh=HCGgBM0J4x5ZSkA2bXVd4+Dveru9uIKWtG31kDwRdHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hzps09SxXV6w3pECg3YEGtCWCnQ7234ONMF2Pv2OofAU5dhusoPpjfO9aU1a5O4DyyeWbHEnRd7X+e2QGFBtO9yeD3P2bKTulywL/xEh7z/Z+Fl3oEG8yqcTXNszSmewCbPpfgwZdObNxk+8kuOSeTlSe6syj2/ySMn9ohkcPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArhJONt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718FDC116C6;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=HCGgBM0J4x5ZSkA2bXVd4+Dveru9uIKWtG31kDwRdHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArhJONt05WX96QiNYYKM7WO6oLWNsG1jAhUlGD61772x8312GWK87V9EGLflKXltv
	 TdJR/S+zMswUXwsoCvIOXwikGyWyvIz8lx1ESK4uKrqpld4kxpkzUVveKlLQ87Uqbi
	 WCrpYVvg/tkGbSDqysfU4DIZnh93YQGddhfv+u0ReSoyTcF7tgo6RX/qvasHFB6Jrl
	 BQfNJYPstE2HGLPS/9YgdC2NYQOvI7LkCWGBFNJgQ1tElWaLs3okG7AWRnI5cI5Wo/
	 RriFfN2RLHSdE5uz+6omt/ndygF+eFhuZemL94C1a6fDZpLPfPQzc75Uh5fwB4EwmU
	 0BQu2gURGBKDQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgL-2qpD;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] docs: conf.py: use dedent and r-strings for LaTeX macros
Date: Thu, 21 Aug 2025 10:16:41 +0200
Message-ID: <0d245fbd872ab3ec21bd8fe78b01340ba77ce365.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead of adding extra weird indentation at the tex
file, use dedent(). While here, also use r-strings, to make
easier to make its content identical to the .tex output.

While here, also merge "preamble" that was added on two
separate parts of the code (in the past, there were some
version-specific checks).

No functional changes, just cosmetic ones.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 6e12c7d8e07e..628af81e6879 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -9,6 +9,8 @@ import os
 import shutil
 import sys
 
+from  textwrap import dedent
+
 import sphinx
 
 # If extensions (or modules to document with autodoc) are in another directory,
@@ -462,11 +464,11 @@ latex_elements = {
     "inputenc": "",
     "utf8extra": "",
     # Set document margins
-    "sphinxsetup": """
+    "sphinxsetup": dedent(r"""
         hmargin=0.5in, vmargin=1in,
         parsedliteralwraps=true,
         verbatimhintsturnover=false,
-    """,
+    """),
     #
     # Some of our authors are fond of deep nesting; tell latex to
     # cope.
@@ -475,20 +477,16 @@ latex_elements = {
     # For CJK One-half spacing, need to be in front of hyperref
     "extrapackages": r"\usepackage{setspace}",
     # Additional stuff for the LaTeX preamble.
-    "preamble": """
+    "preamble": dedent(r"""
         % Use some font with UTF-8 support with XeLaTeX
-        \\usepackage{fontspec}
-        \\setsansfont{DejaVu Sans}
-        \\setromanfont{DejaVu Serif}
-        \\setmonofont{DejaVu Sans Mono}
-    """,
-}
-
-# Load kerneldoc specific LaTeX settings
-latex_elements["preamble"] += """
+        \usepackage{fontspec}
+        \setsansfont{DejaVu Sans}
+        \setromanfont{DejaVu Serif}
+        \setmonofont{DejaVu Sans Mono}
         % Load kerneldoc specific LaTeX settings
-        \\input{kerneldoc-preamble.sty}
-"""
+        \input{kerneldoc-preamble.sty}
+    """)
+}
 
 # This will be filled up by config-inited event
 latex_documents = []
-- 
2.50.1


