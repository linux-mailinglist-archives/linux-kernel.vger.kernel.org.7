Return-Path: <linux-kernel+bounces-820634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BFB7D16C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48056204BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175522FBDFD;
	Wed, 17 Sep 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqPa1XqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF432341B;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111356; cv=none; b=LQEg5F3Az9IFPIakyUxHGjV9enDD0MeREtUBk9A9r8QDa8wHo/Mv99JzA4abQbH2LpyCoUcJW7wtZborjtoOrdWiNqTV2jr0LMtOWFPLiE9gJvQ42Lq2LdEXBICZaAdl+nCURH8C9aUT1shGbUwIFDG6LbQV+njmXZyJ0X7GtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111356; c=relaxed/simple;
	bh=WDtXWJRYNGux0wtm1BAyWaADemyId01OLfJz/YWYDuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIHyb9Mdv/6+uV26z7EuGroBjBVPF5cDIQ/jzS2BIh3NtMvYsOyGN6gGcaPWYtiiwTGpQTjAputPXtYu4dx57lTsVCkz9LoqyF8ngR3lGDNCf0tabAdEJi3goNDFH0cg15B3SbCAMd+XIP5qADymH7sLXg2Vm39aH58JsAKcRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqPa1XqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51268C4CEFC;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111356;
	bh=WDtXWJRYNGux0wtm1BAyWaADemyId01OLfJz/YWYDuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqPa1XqKkyijLM33gHHnyuHrp6uL06ePBXnhbbFsRFGRAM49LcdJXSyAbYKF3IqQi
	 KD35INfB/senKvC/4XEkvTJZQp/GkI7sKAAJOKVy86YJObGdNdHzBADd4DHFMc7t3W
	 3T2aELdY9Gv0c4wxxMtXjHJfuj57QmyePs3M0VtLK+y2IsYxpjaIxwwzz3GveUFQUW
	 5F4XANT6TddfiIBRl6DokTHEJv4Myt3n8aNsvvPlU1qFJnixUh69MJMaAkvGk6gB/O
	 lOt46OA1BjXk9sQfV15k76rumVHA0rXJgJZCtjOhuaqO8D07G/FrI2bPuzNiwVa3d9
	 q+F4vGLqy7RlQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGeG-24Q9;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 17/24] tools/docs,scripts: sphinx-*: prevent sphinx-build crashes
Date: Wed, 17 Sep 2025 14:15:11 +0200
Message-ID: <deeac8424879882162a34e23500a827ccd350d41.1758111077.git.mchehab+huawei@kernel.org>
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

On a properly set system, LANG and LC_ALL is always defined.
However, some distros like Debian, Gentoo and their variants
start with those undefioned.

When Sphinx tries to set a locale with:

	locale.setlocale(locale.LC_ALL, '')

It raises an exception, making Sphinx fail. This is more likely
to happen with test containers.

Add a logic to detect and workaround such issue by setting
locale to C.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 11 +++++++++++
 tools/docs/sphinx-pre-install   | 14 +++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 0fe21b343e7a..6c2580303e8e 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -45,6 +45,7 @@ the newer version.
 """
 
 import argparse
+import locale
 import os
 import shlex
 import shutil
@@ -565,6 +566,16 @@ class SphinxBuilder:
         if not sphinxdirs:
             sphinxdirs = os.environ.get("SPHINXDIRS", ".")
 
+        #
+        # The sphinx-build tool has a bug: internally, it tries to set
+        # locale with locale.setlocale(locale.LC_ALL, ''). This causes a
+        # crash if language is not set. Detect and fix it.
+        #
+        try:
+            locale.setlocale(locale.LC_ALL, '')
+        except locale.Error:
+            self.env["LC_ALL"] = "C"
+
         #
         # sphinxdirs can be a list or a whitespace-separated string
         #
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index d6d673b7945c..663d4e2a3f57 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -26,6 +26,7 @@ system pacage install is recommended.
 """
 
 import argparse
+import locale
 import os
 import re
 import subprocess
@@ -422,8 +423,19 @@ class MissingCheckers(AncillaryMethods):
         """
         Gets sphinx-build version.
         """
+        env = os.environ.copy()
+
+        # The sphinx-build tool has a bug: internally, it tries to set
+        # locale with locale.setlocale(locale.LC_ALL, ''). This causes a
+        # crash if language is not set. Detect and fix it.
         try:
-            result = self.run([cmd, "--version"],
+            locale.setlocale(locale.LC_ALL, '')
+        except Exception:
+            env["LC_ALL"] = "C"
+            env["LANG"] = "C"
+
+        try:
+            result = self.run([cmd, "--version"], env=env,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT,
                               text=True, check=True)
-- 
2.51.0


