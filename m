Return-Path: <linux-kernel+bounces-818580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA44B59397
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322271BC750D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E72309F0C;
	Tue, 16 Sep 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMusTQaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E330649A;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018217; cv=none; b=ltI567c/QXmRN7XD/pXULAzvfKk5DB9nagacvWgZp10hUmvb/SX2f0tzy0D5rvjXe9YNpzFlYeYNEA20yJLjBGsr2hv3LhUvPockpPERYJv+qLxv1Ba1xx8YhkaW/Ug3XtLxKz44Lb5EYybhl/Cts9aHpHFk1KqV3YWfnR+Brns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018217; c=relaxed/simple;
	bh=g16JMyLKdDH7hbXVKVhgpa5lgoUGSLSeYBfDxjGikfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOo8ZoiZBndfPnIphzvHD4LE7R5hnuYRpScA/YkjRaQuEgETFLIf8NOsL99fMopfJHaVQAAYoziAIkLannaieAC+YhGr2d9FMiahOMruB4ptpYbyBmKlJlNfI/7L2pYn9iIgQ2OvUREpGBdjNihaVFrci1vVCOiaJu7G8c0lkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMusTQaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E2C4CEFC;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018217;
	bh=g16JMyLKdDH7hbXVKVhgpa5lgoUGSLSeYBfDxjGikfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMusTQaZBNfUbpxG8sADvkCzGSUkKxsNtMirlkgf9qgCE3YjTr0sN9s3X89c2I+xL
	 90NfQ3E3DZItyRYnw4+GMltKKaYpxqRDG6QmZ1KWk3scRioJ4uYAsqsT1VavEGe2kA
	 xYSha43gYi+z1SfqfaLzQyYkGNVeGNeq/FzsQ8HcvWzo09fvqjxxkO7qanwXi4LkPA
	 W42WP9GElxVbzdg9ZeKHBK37ocwjPRJcqZN6WseLa0M3rwdad+FjyM3JdeTZCzXXyC
	 IF13zNrzrcUqOjccEarvnMorQ6H+5G6Nu8DnCn1XZFLk+9LsCCaGlv+Q/g3RSWZBsk
	 E1KUUDnOxIgpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqT-0000000BBPb-0GID;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/21] tools/docs,scripts: sphinx-*: prevent sphinx-build crashes
Date: Tue, 16 Sep 2025 12:22:50 +0200
Message-ID: <d2b15a3387c1de6d4aa7f3c59f3cf6afd78ad584.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
index 413f51575de8..629abb99b9f3 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -45,6 +45,7 @@ the newer version.
 """
 
 import argparse
+import locale
 import os
 import shlex
 import shutil
@@ -457,6 +458,16 @@ class SphinxBuilder:
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


