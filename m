Return-Path: <linux-kernel+bounces-727066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D79B01499
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304DF1886A96
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03E1EFF80;
	Fri, 11 Jul 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfnP/8HM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77E1E9915;
	Fri, 11 Jul 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218837; cv=none; b=G+i7ysSf71PwSI5erj66NRA+pcA2r2rVrrptmrdH1z3p/eUgx2BhFPQVz8y9Gxl/ta7cNlbL9HUH3iG8UBXlAruAoUklQ+XeR2vpspei4Tn18jLWCy+5YsimxnlgsZlyD/+hnY3Ta9Znh7tDMYecYrXld0rNXDDXolgXTeF9r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218837; c=relaxed/simple;
	bh=aeJ02hZTUwEfKqzaIBFSu41Svph78iymEyJtqAZNOhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt8pLfI1iGKeD8W4inS4zC28CPVoVfH7D5KaTepPlwPS1rzbvv5es1uop44+iGTxeh0a9g5WArGwZ+egSQVNR+eSOsAtGRPtmyhH9ggv3FBLY833gviNnTIPc7WMWBm1QQGSK0F3+ioF9uiOQyD9GD5XsJSa3xz9G41aV3i2Zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfnP/8HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1255C4CEEF;
	Fri, 11 Jul 2025 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218836;
	bh=aeJ02hZTUwEfKqzaIBFSu41Svph78iymEyJtqAZNOhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfnP/8HMPBFj9BrzwdsN1ENsGmAyqIunJkx1fx99Hz5Rp0bYvPqmN64MHFKuaQhvF
	 E4I9t9DyQao6yTwskYuHwA8oKvry/8zUc2S12njMjUzjLHks66g3GidFy+Wsw4/rHX
	 o7e6UdNnmvudvH+E75CL8JvOcR9e6Q2LTbH9Jc0xS/s9CJg/O2hpbPtBqLsdyEvkPU
	 oGIMr1Q0NMWekQ+t3IqjYivyGfpYChjxydI4HyyAY2J8J3fqA/l66m5O0+mvjVyOIJ
	 LL9uw7sdZSnuOjGP6rUgGCwTSznxz9ZLYngCzif6lS2s9y1W+7oWpUVt6BR0EPc1mj
	 tzglekjCbsACQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ua8A6-0000000FSSr-3OL1;
	Fri, 11 Jul 2025 09:27:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs: kernel-doc: emit warnings for ancient versions of Python
Date: Fri, 11 Jul 2025 09:27:08 +0200
Message-ID: <7d7fa3a3aa1fafa0cc9ea29c889de4c7d377dca6.1752218291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752218291.git.mchehab+huawei@kernel.org>
References: <cover.1752218291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Kernel-doc requires at least version 3.6 to run, as it uses f-string.
Yet, Kernel build currently calls kernel-doc with -none on some places.
Better not to bail out when older versions are found.

Versions of Python prior to 3.7 do not guarantee to remember the insertion
order of dicts; since kernel-doc depends on that guarantee, running with
such older versions could result in output with reordered sections.

Check Python version when called via command line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 12ae66f40bd7..fc3d46ef519f 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -271,6 +271,16 @@ def main():
 
     logger.addHandler(handler)
 
+    python_ver = sys.version_info[:2]
+    if python_ver < (3,6):
+        logger.warning("Python 3.6 or later is required by kernel-doc")
+
+        # Return 0 here to avoid breaking compilation
+        sys.exit(0)
+
+    if python_ver < (3,7):
+        logger.warning("Python 3.7 or later is required for correct results")
+
     if args.man:
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
-- 
2.50.0


