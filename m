Return-Path: <linux-kernel+bounces-765181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C4B22C93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2197ADF46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620972FD1C8;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/RuddMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2992F83A7;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=UYUSJpjBrvLbwSeLbr9LBdeY+n15XlywEj+LkPt+0lNkaFtdTEAm/1ha/KWH4ZJj+4n3Tslw64FfH4ovJaegIa+SPZFECZKAlCb5bA+BLurcY3ID5hZwTReTelqGsz0gb5Qp7ZC+1PRUmNFzAXUFdqGXYqkcZj9XDRottW5qQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=kHHUrzrUzCfISUwvoyyC98eBFz5CP0ST0NUYuTddsmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBlZ73v4k/xWUvTmX1XioDozSFd2YjN3odT71bYmkUS9VMqkYE0P/LEBaWRUweqXWWPfiAeexymfJFhOocgtjlMuopKyTbEL7WND0zrwYOPPN7Nuqbc9sjfHcLUO/6bVxdrVcOtqFRUQlgT1slHc6h+8bo9UIhFl8mPWFcKPVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/RuddMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED01C116B1;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=kHHUrzrUzCfISUwvoyyC98eBFz5CP0ST0NUYuTddsmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/RuddMXj01aFckxdmu1McLsV4wBlfjaWp3dv90LWm+tMd3Gdej/cR0EcJKUGExch
	 Rgwer0d0WLCI6/UN3RAJXA7H3xvVWYXqOF/qB8p9gQRbLt/oEXv9aEnjTRaIEAng7L
	 RCY2in7h8AK3bMWer6J1RU2+JxFPK9AlWiLTaDpXcV/Q/6i+Km6Ye+qoygL+jPGFpr
	 spTUuHo0F+h/4NQGvsxY0CWNP1K8TNVgYgWJmdKX4VRMEXvINRJn0TCACbzE4+n6dI
	 /U9jw4rGcbYXcR+Vn6bWQgU1TwOLc0LUjj+JIoMeMtxFr0E3qRug8FV/d95rAGXnkx
	 1fM2z+i5m+rAA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVS-0ibi;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/39] scripts: sphinx-pre-install: Make it compatible with Python 3.6
Date: Tue, 12 Aug 2025 17:52:21 +0200
Message-ID: <39d6e27a047bc3cc8208ac5e11fe6ba44faff9c4.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
2.50.1


