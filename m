Return-Path: <linux-kernel+bounces-770845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEAB27F99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AF76228AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB38303CB1;
	Fri, 15 Aug 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+M+Tq/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50A2D7389;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=ROlVZNsmqE/4vpS2kbUhgLJNQsXpSBP4H8hwGvV8og/epzwdaNxKimefu4VPRy9FNMKTfiKBuQ0hKAgtaiVdgqj41tGkccwkZOKHjQbIwpwp7arY0Wfd9aDD+WrBhA76ciwwcY4GWosme2XwN6Wc+xoT+Khl5LBhzcfFOOgVyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=gQ6kk5WPc72Dq2AQd/n6nSscjReWsPfB0/s1IlVKE+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeL2IGo6R9Xgrvzo1RMsY3+Ps4jpqbA11WZ95uwakfhwgVD+mf6tGfPvAXw/l8mB67dS3ns7ccYXhNlv/lSqFhbWLNnhW7QpFsjgzPtVXhGi0cJLIDC2iQzOBE3xnzLo4VaC712uqSiddgEwiyF+Ao2maVGWpntr174l/uhwvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+M+Tq/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F193AC113CF;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258666;
	bh=gQ6kk5WPc72Dq2AQd/n6nSscjReWsPfB0/s1IlVKE+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+M+Tq/d+hBeMlPVTjHZo2vkzeO1qLH30Cde8nS9nSbkTp19fczQNfeHW2yUt503f
	 2aI7K0JnvENo9IK8lO9CY990Erpn8d0X4FcIzKy7Wl5oO0iB3JgFLl/lsoE03bUAi2
	 EBPYYo+YR6jifsd6/lqxUx4LjYjA+vTWkWF/SRtGOtPtByWUNPWsI586XoLmAkTCEg
	 PJOXbsHFgvSuwx4gBO/cB524XswwN5Pv5Qr9JI6vpJZVwXfawEyBOIuYlRRN19cOPL
	 LL7vkfgSeB42lDhXLBysGkJWdM+wpCRfjwC26z8kn9EKvYHmYJS/8xFB27Qnc+Fk0O
	 z8F5YOQadHx1w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042oq-0zxq;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] scripts: sphinx-*: prevent sphinx-build crashes
Date: Fri, 15 Aug 2025 13:50:38 +0200
Message-ID: <461e00fe7ce75eaac90d98572bb93910b39361e2.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
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
 scripts/sphinx-build-wrapper | 10 ++++++++++
 scripts/sphinx-pre-install   | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
index f6fec766c3e6..f21701d34552 100755
--- a/scripts/sphinx-build-wrapper
+++ b/scripts/sphinx-build-wrapper
@@ -45,6 +45,7 @@ the newer version.
 """
 
 import argparse
+import locale
 import os
 import re
 import shlex
@@ -495,6 +496,15 @@ class SphinxBuilder:
         if not sphinxdirs:
             sphinxdirs = os.environ.get("SPHINXDIRS", ".")
 
+        # The sphinx-build tool has a bug: internally, it tries to set
+        # locale with locale.setlocale(locale.LC_ALL, ''). This causes a
+        # crash if language is not set. Detect and fix it.
+        try:
+            locale.setlocale(locale.LC_ALL, '')
+        except Exception:
+            self.env["LC_ALL"] = "C"
+            self.env["LANG"] = "C"
+
         # sphinxdirs can be a list or a whitespace-separated string
         sphinxdirs_list = []
         for sphinxdir in sphinxdirs:
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index c46d7b76f93c..50ae9cfcb3d7 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -26,6 +26,7 @@ system pacage install is recommended.
 """
 
 import argparse
+import locale
 import os
 import re
 import subprocess
@@ -516,8 +517,19 @@ class MissingCheckers(AncillaryMethods):
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
2.50.1


