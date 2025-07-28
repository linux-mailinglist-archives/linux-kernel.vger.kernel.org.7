Return-Path: <linux-kernel+bounces-748517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF0B1422B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE973BA591
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5072B27603B;
	Mon, 28 Jul 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b="TloSWYpZ"
Received: from ipo8.cc.utah.edu (ipo8.cc.utah.edu [155.97.144.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E91220F2B;
	Mon, 28 Jul 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.97.144.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728276; cv=none; b=s/rouj3pamO1P+w6/366ewtsnsvbDC4LHYOseQGjFYlBUv9JZsK5la1f85OBngvLKynWxF+sJBLXPaA9GuNxT9SZ+9yigCplPIHYDd/1fkezPYbf6dCprsSFc8Ij1mAsHpnFmjvG2XP0HvT7iEcuVUsxU4Jb3hIXmWgjrvZUUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728276; c=relaxed/simple;
	bh=ZQmdZxYotchKJucmhhEg6EAkbQtdqUmAAUUk5Fctm8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCmt1H+6KIptqQWLj8Xjl0dnQeV02buE5QwtDa98v+twuDlHWt8FTv38hWTH0M5dB0M13WaB/Q1mKWdF1mP2pxhL6AHCk+mot5IqiBv1EOZc1aZLwMHDg6KFerq5+YvN8dCwAltGXEO6X5m4sWWIQqFJ15ZjmyvfD54gkxh8VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu; spf=pass smtp.mailfrom=cs.utah.edu; dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b=TloSWYpZ; arc=none smtp.client-ip=155.97.144.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.utah.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1753728275; x=1785264275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZQmdZxYotchKJucmhhEg6EAkbQtdqUmAAUUk5Fctm8U=;
  b=TloSWYpZBT9ggDkHdkwwbfHYT5n7HGPhB8rdHSUeTSb26mBOYe9nXBxe
   VaIg5BcE8YfzGsz9XUEOUGg6ACT9E67Hbc93aU4xIVflP9J3aET1Pfb1o
   QhWSBdQ9FYC1A4MA+6V4YDqwO35zY4JfYaNkDSjxA+JMjVqi9FSopNVwP
   37e01UzpaUAMz0HiIyw0VjEv5IhTsNrbSg29LXY0bRQJJFymKeQP5GMWs
   hrvTH5JBm17lQuTFO4yRethofviE0euX2I4m2Q8IvshCg+ncHGbf/4aFv
   s1+5oFoVjkTKqFFapP55XxyN6fxj66FeNNB8PPnUtmrIatxZdjt1ZpbjN
   Q==;
X-CSE-ConnectionGUID: Nk14R2r5QbiSUWohi0GGzw==
X-CSE-MsgGUID: A/rCkRQdRFCd9E7CeEuQWw==
X-IronPort-AV: E=Sophos;i="6.16,339,1744092000"; 
   d="scan'208";a="78049462"
Received: from rio.cs.utah.edu (HELO mail-svr1.cs.utah.edu) ([155.98.64.241])
  by ipo8.smtp.cc.utah.edu with ESMTP; 28 Jul 2025 12:43:22 -0600
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 049CF3021AE;
	Mon, 28 Jul 2025 12:41:13 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at cs.utah.edu
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (rio.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJQq1hn-PunM; Mon, 28 Jul 2025 12:41:12 -0600 (MDT)
Received: from memphis.cs.utah.edu (memphis.cs.utah.edu [155.98.65.56])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id B14813020EF;
	Mon, 28 Jul 2025 12:41:12 -0600 (MDT)
Received: by memphis.cs.utah.edu (Postfix, from userid 1628)
	id 58C651A02B5; Mon, 28 Jul 2025 12:43:20 -0600 (MDT)
From: Soham Bagchi <soham.bagchi@utah.edu>
To: dvyukov@google.com,
	andreyknvl@gmail.com,
	elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	glider@google.com,
	sohambagchi@outlook.com,
	arnd@arndb.de,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Soham Bagchi <soham.bagchi@utah.edu>
Subject: [PATCH 2/2] kcov: load acquire coverage count in user-space code
Date: Mon, 28 Jul 2025 12:43:18 -0600
Message-Id: <20250728184318.1839137-2-soham.bagchi@utah.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728184318.1839137-1-soham.bagchi@utah.edu>
References: <20250728184318.1839137-1-soham.bagchi@utah.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the KCOV documentation to use a load-acquire
operation for the first element of the shared memory
buffer between kernel-space and user-space.

The load-acquire pairs with the write memory barrier
used in kcov_move_area()

Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>
---
 Documentation/dev-tools/kcov.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 6611434e2dd..46450fb46fe 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -287,6 +287,11 @@ handle instance id.
 The following program demonstrates using KCOV to collect coverage from both
 local tasks spawned by the process and the global task that handles USB bus #1:
 
+The user-space code for KCOV should also use an acquire to fetch the count
+of coverage entries in the shared buffer. This acquire pairs with the
+corresponding write memory barrier (smp_wmb()) on the kernel-side in
+kcov_move_area().
+
 .. code-block:: c
 
     /* Same includes and defines as above. */
@@ -361,7 +366,7 @@ local tasks spawned by the process and the global task that handles USB bus #1:
 	 */
 	sleep(2);
 
-	n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
+	n = __atomic_load_n(&cover[0], __ATOMIC_ACQUIRE);
 	for (i = 0; i < n; i++)
 		printf("0x%lx\n", cover[i + 1]);
 	if (ioctl(fd, KCOV_DISABLE, 0))
-- 
2.34.1


