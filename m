Return-Path: <linux-kernel+bounces-723765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF5AFEAE2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32CD54808D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744E2E62BF;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSegm2pR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CCB2C3247;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=OKb1SWzdB8GJbmqGEs64Yn1cZeaOefCVF+oKyeHhARnNr9LWNB3vBVGXUVD9O9sxWSKi3tkV33XmLsLjRT6WZt4z6kO9vyOE44nAdcCQNofrdR/7ZBuJ2lDIqfuTQoI2uXD1hWPs1mexRRoqo+fFVstdEfNRmnSg5VOiNxAf2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=QZ8qIGEhIaRkTGuQPr4EFUzjS7Cqh7Eui7qNYAGIDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUDf/sq/I3/VmeWVdI8kOiTEm4rQwS4U39XvDbnhUwVUJejZ6ICNLZXg3LN2bd1xaD7doIe5yvHLrJ2BhuI+WtvdbbmNMDSnV1AxEENkv0LCscjuQNmQe+OVUETjtqFaajT5F9zX/Y1sTe3ZSRZ86kHckw8eQx5jgyMifFsc5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSegm2pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C7BC4CEF1;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=QZ8qIGEhIaRkTGuQPr4EFUzjS7Cqh7Eui7qNYAGIDWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSegm2pRG/HBr/JlZJO44ixqZ+wo6FTzjGrLPlRFscaxJVGff3BZ2ZyEccFoLF/pi
	 0X7tzrTZZP2TPzXdcU7zGCI7mo/jwIbHz13ajFLPyv4Cv0nsQH1gQtYsdIz2wqf/8W
	 0dnIl8vFYQ8PHy2f4UwI9rIJojP2/4LUP8WETp3CKAYr1fPcu7WO9k0uQiGPwvdQ/e
	 RlATIe8RTSFSvrBtX1YL5z5catcKgHSp5zVYGtEfsUGq5y4Gq0jUuM1vm9am5h7/nz
	 yN29Zw3ncQajmNncxYMaLh5vo57kWXD9IKvL7AYGpVSUol+tAAX0b6KCBSPhs0zXg9
	 u3o4Eyd67AvQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECI-0z4V;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/39] scripts: sphinx-pre-install: Make it compatible with Python 3.6
Date: Wed,  9 Jul 2025 15:51:36 +0200
Message-ID: <d31dc0c11c1d0600c190237f12a4098aad77a1ca.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

The minimal version requirements we have is 3.9. Yet, the
script which detects it is this one. So, let's try supporting
an old version here, as we may want to suggest to upgrade
Python version to build the docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index dcee2181b72f..71d86b230b22 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -115,7 +115,8 @@ class SphinxDependencyChecker:
     def find_python_no_venv():
         # FIXME: does it makes sense now that this script is in Python?
 
-        result = subprocess.run(["pwd"], capture_output=True, text=True)
+        result = SphinxDependencyChecker.run(["pwd"], capture_output=True,
+                                             text=True)
         cur_dir = result.stdout.strip()
 
         python_names = ["python3", "python"]
@@ -135,12 +136,23 @@ class SphinxDependencyChecker:
     def run(*args, **kwargs):
         """Excecute a command, hiding its output by default"""
 
-        if not kwargs.get('capture_output', False):
+        capture_output = kwargs.pop('capture_output', False)
+
+        if capture_output:
+            if 'stdout' not in kwargs:
+                kwargs['stdout'] = subprocess.PIPE
+            if 'stderr' not in kwargs:
+                kwargs['stderr'] = subprocess.PIPE
+        else:
             if 'stdout' not in kwargs:
                 kwargs['stdout'] = subprocess.DEVNULL
             if 'stderr' not in kwargs:
                 kwargs['stderr'] = subprocess.DEVNULL
 
+        # Don't break with older Python versions
+        if 'text' in kwargs and sys.version_info < (3, 7):
+            kwargs['universal_newlines'] = kwargs.pop('text')
+
         return subprocess.run(*args, **kwargs)
 
     #
-- 
2.49.0


