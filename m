Return-Path: <linux-kernel+bounces-765165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BBB22C61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769AF162884
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EFF2F9461;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH+4l/z5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F82F658F;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=KbfMcWhVqD+rWfuHrNWdhKOduu5Y/Xhr/zbyatkqRBH+2SB/tXkdR0RLMndnrpIvfgissHgOekeNaYrJSF7gU0r237r6f8cui2M1+8aNQSvpeiaQdpbRDB8Cdhcp0UeHuLyHfn+l2zm+Iw+6aZQFnh9EDQI4XM377+eETLMtFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=oCK6WGvw+7PUuHUA0XAEiLZ3Xl9xo2K88VEoJ8LgJJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxt0BmJfbSlKgK8J6t6dbioyrmI7P/jykG0aSJLiWRFzgZ6yblUm+pv+zyiG48zw16mLPJmrXoKcifNeZj83m12h+uhWKzyKdtNYn8Si0KfNOqaEPCdSEaIhLbUQBzrw81Dw+67y9+4gEiV2A868LwYwHqp+lBf6B7LCGGC+Dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH+4l/z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD125C4CEF8;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=oCK6WGvw+7PUuHUA0XAEiLZ3Xl9xo2K88VEoJ8LgJJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JH+4l/z5Ct4Cwi4pgZhQbwRWJEXYJD/k208XqFAD13vlGnP8nSRMF6wvqWqgfaCuY
	 ZW9hjzhb5C4CX8M38WdqbIoBy5s4C7JnnCWmDe4Em0N+5n9faCVIYdQCurU+4oyt6F
	 bNFlmpixwzifAM5BUGypeRH2mdJ09deA0Xkvf0H1pG2WHmmaMVWXwenNH9uWP/53am
	 NxSGkhJDqwcYHMlR+84aylbnqgWhVDI44mA+IZyPN4D5glfvCZB8HYF99ubHdAJZrP
	 4PMIkUOERzAf6WaKTgyeAKI9ZwAWfgKiEmn4ol12A1IUv/1veY0I4InwoEQyA7l8ue
	 UtZOp6ub6/s1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVy-1h5Z;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/39] scripts: sphinx-pre-install: only show portage hints once
Date: Tue, 12 Aug 2025 17:52:29 +0200
Message-ID: <d4e7ef1d5e1f0412eb9f9ae4913dc64c0821e002.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


