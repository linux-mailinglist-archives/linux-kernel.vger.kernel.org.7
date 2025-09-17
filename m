Return-Path: <linux-kernel+bounces-820646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07EB7D3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E831890F70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB89337E8A;
	Wed, 17 Sep 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX5OBAUP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2F3728B6;
	Wed, 17 Sep 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111366; cv=none; b=TyNdT0louXDpvCPGRIrLlkzjVoxQ4Dz98c3YnnThihkXLyrOX0jQHqqoghaAwt9IYkde5XJJAbendzAbkAOFm0p12tEcso3rAwQd2o21/POEZ+Op5oWpI/XNbOyL/sU4Kxmqm6daw7QDt22CeiD1agz0nhsQtbnYdIigjCS9qWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111366; c=relaxed/simple;
	bh=A/mf0CcSEJehu2LuWr/6DS5gyCiq40ED/oENXVKsyyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPhqCjbRO/XsY6SQmoA5Om/DcaOQi1UcJC89fnV9+XStPQhzxXdCPyW+PoxROSyBHWaKuKXq1GPePWYa592CEGoD9/h6EVsFrjD5rwwhURMRwfRrHYKnG+D3UGyKWcB9CRqIgwdqVcbLz3OWd/8MILOktCMY45ldXHqQYJEifvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX5OBAUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2998C4CEF7;
	Wed, 17 Sep 2025 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111365;
	bh=A/mf0CcSEJehu2LuWr/6DS5gyCiq40ED/oENXVKsyyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pX5OBAUPlIkX5kaDxF1ugGX2UqYv04/liVXoIYRCjCya45IS43F20lZ3JljqXq4in
	 DjaaO4dgSKVnauKWctItiPHSbJloFfwkwdc3PbTzcDjSwjlAsUw5tsnemGIUvQZybT
	 ulVgD0394hbwlysJAdWIgWpkPtlMLdjLyPz0fbhFK8w0ZggPYIcUZIImSIjAtRqd1m
	 KyPeYdBAalAOSvNoLpCQwDWdpbbmxoPxUWTrlZ+CFUduEIIamgWNqhqN/09Iqp1z5a
	 W1BnHE7saKCRaUcDqfCrGO+UFcgpPFXdr9DJCC5fcYQ5VsjuRxC4uMmmuqYPn3gKzi
	 bFzV5Kq0ziF7A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGdY-0ogy;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/24] check-variable-fonts.py: add a helper to display instructions
Date: Wed, 17 Sep 2025 14:15:00 +0200
Message-ID: <32f8ebfaf2062dda9c23ac9744b66e782ea989eb.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Use lib docstring to output the comments via --help/-h. With
that, update the default instructions to recomment it instead
of asking the user to read the source code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/check-variable-fonts.py | 7 +++++++
 tools/docs/lib/latex_fonts.py      | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/docs/check-variable-fonts.py b/tools/docs/check-variable-fonts.py
index 79b28f0f7d85..ae274e7fbbb7 100755
--- a/tools/docs/check-variable-fonts.py
+++ b/tools/docs/check-variable-fonts.py
@@ -12,10 +12,17 @@ Detect problematic Noto CJK variable fonts.
 or more details, see lib/latex_fonts.py.
 """
 
+import argparse
 import sys
 
 from lib.latex_fonts import LatexFontChecker
 
+checker = LatexFontChecker()
+
+parser=argparse.ArgumentParser(description=checker.description(),
+                               formatter_class=argparse.RawTextHelpFormatter)
+_=parser.parse_args()
+
 msg = LatexFontChecker().check()
 if msg:
     print(msg)
diff --git a/tools/docs/lib/latex_fonts.py b/tools/docs/lib/latex_fonts.py
index e03412e3947e..0a3ad4995e79 100755
--- a/tools/docs/lib/latex_fonts.py
+++ b/tools/docs/lib/latex_fonts.py
@@ -113,6 +113,9 @@ class LatexFontChecker:
 
         self.re_cjk = re.compile(r"([^:]+):\s*Noto\s+(Sans|Sans Mono|Serif) CJK")
 
+    def description(self):
+        return __doc__
+
     def get_noto_cjk_vf_fonts(self):
         """Get Noto CJK fonts"""
 
@@ -154,8 +157,9 @@ class LatexFontChecker:
                 For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
                 Or, CJK pages can be skipped by uninstalling texlive-xecjk.
 
-                For more info on denylisting, other options, and variable font, see header
-                comments of {rel_file}.
+                For more info on denylisting, other options, and variable font, run:
+
+                    tools/docs/check-variable-fonts.py -h
             """)
         msg += "=" * 77
 
-- 
2.51.0


