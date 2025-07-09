Return-Path: <linux-kernel+bounces-723766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB22AFEADE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D877BCA5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC912E611F;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dany8WAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5128DF1B;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=tZvvq4fO98h94DQf6YlCn5YcbTMLKab8NQ+fjNeqJsv1YyUc7sl06GMTjXUz3hrJtefvJ4w7SQQ7H12oDXEDdi8f6f0e5qt0+35QKu24vXe4vJNCHuZuMIYJBpryR7Wz2GMpOHa9haOzCFSsB8WglOlrhCPhv+yCCtnEOckcHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=X1fFP6aPpObiMQHIfmC5DpMlMrqUycNg3yqWyp/o7aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLAS8yVVIBYXGXKAVtPvBe8eFuG3h6HjCmwgh7nJqiJvM7BJpnCptmIcbx/RyRtbNUDvMqwQa0tqLHxNa7s79T+xHESePBjh83IPttVr/Bbfr+FYRxr5wdsSQiDQwte5+vAmWYQF1wE6dmG84pqMj+nmN97kwKBjCSOlwquvV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dany8WAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0506C4CEF7;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=X1fFP6aPpObiMQHIfmC5DpMlMrqUycNg3yqWyp/o7aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dany8WAX4ThxgQBYtmW0HWQmklFC+2gcMM8IBApiHFHZUvYtl6W9kPlLoiWX1DdtA
	 D+2p0RY8qIoTj+3o7Ra6birrq45sB8OwAVfVZFA27nqZNtBpWEz/BKYqLu0njGsAgU
	 jzwHVdoQU3X5eHQRKVfFfcqXkXmB7zG9Ih7POD3PNyFDur1U7FfWyR/x+7cRlVlBG4
	 Jsa42bHuGRz5LLF0eosUGriv4TipGxvPCisvQi+QGfETUZZFTFttcEuiKrwgxpBrRF
	 fpVJF4NqkkgOqsNT0BgxG5plCyWRkCwvbblt2KWOY7XbAHAVXrUy7I5cxahWltf2G8
	 13nFxXshneHAw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECg-1eWW;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/39] scripts: sphinx-pre-install: only show portage hints once
Date: Wed,  9 Jul 2025 15:51:44 +0200
Message-ID: <f50e027e13f39255f7f0f504b2b8766e2ecf77fa.1752067814.git.mchehab+huawei@kernel.org>
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

On gentoo, doesn't repeat instructions about how to enable
portage.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 0e165ad05fdb..808d31bfa790 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -89,6 +89,9 @@ class SphinxDependencyChecker:
         self.python_cmd = ""
         self.activate_cmd = ""
 
+        # Certain hints are meant to be shown only once
+        self.first_hint = True
+
         self.min_version = (0, 0, 0)
         self.cur_version = (0, 0, 0)
         self.latest_avail_ver = (0, 0, 0)
@@ -714,11 +717,14 @@ class SphinxDependencyChecker:
             "media-gfx/graphviz",
         ]
 
-        for p in portages:
-            result = self.run(["grep", p, "/etc/portage/package.use/*"],
-                               stdout=subprocess.PIPE, text=True)
-            if not result.stdout.strip():
-                print(f"\tsudo emerge -av1 {p}")
+        if self.first_hint:
+            for p in portages:
+                result = self.run(["grep", p, "/etc/portage/package.use/*"],
+                                stdout=subprocess.PIPE, text=True)
+                if not result.stdout.strip():
+                    print(f"\tsudo emerge -av1 {p}")
+
+            self.first_hint = False
 
         print(f"\tsudo emerge --ask {self.install}")
 
-- 
2.49.0


