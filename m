Return-Path: <linux-kernel+bounces-682849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1758AD656D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 04:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4897917E595
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 02:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB61A5B95;
	Thu, 12 Jun 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IZn/gqQo"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B12A1C9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694471; cv=none; b=VaarVI7yGD3UIsH5qhVsA+lMEcYYiXqti3l1+jPnXuq2Sy43Ywrhon7lr1YUK3oOWsXfl84QrQl4I9we1CjjoG0BJavHNjKQ2eHO++9vgMAKT9/Ifu5o8I7iSOP6l/d8eNrLmeyC8QOyFl/scjS+62dLfZuXXuaEni1T92FcPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694471; c=relaxed/simple;
	bh=EbXWInki+PyyE8fUuUZTQmF76D1Lk5S8/93PksOZ3ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1GF//RuL9z3tcMBrurhf+qAMSBeCn1q9KK5ZTrZvoc77vd5hXIKTglPSA5vVKIN9L65jFHeYFYi685ex9sPVirSc9g6Li0tCJCjMEZVHIar6pOSgAhASN5exSVG6ScaPrJTlFsrqumSRFgz7iU1l++tdSwfQWjVA+TnkX2VMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IZn/gqQo; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749694458; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UNdnWvi0Uoy+eaWdEfSl14TNqMDEHW+OqfIgxD24jTE=;
	b=IZn/gqQoqZWNqmR5nY3XfV51NMnBqvhUpXpVFYwI3AhifAUB1GbHTmmOkuiZSgUgVdxvQgXXRe4mH4Li5nDoX6Gbr4oAVX1VKwnmaCSH3eat5802yUZMO3qXS+iUB/A2n6FEyyw39bFCX0T7Qs31ghQS6NoVHoTOVpxheFzBqGo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wdf0BoH_1749694457 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 10:14:18 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] dma-contiguous: hornor the cma address limit setup by user
Date: Thu, 12 Jun 2025 10:14:17 +0800
Message-Id: <20250612021417.44929-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When porting a cma related usage from x86_64 server to arm64 server,
the "cma=4G@4G" setup failed on arm64. The reason is arm64 and some
other architectures have specific physical address limit for reserved
cma area, like 4GB due to the device's need for 32 bit dma. Actually
lots of platforms of those architectures don't have this device dma
limit, but still have to obey it, and are not able to reserve a huge
cma pool.

This situation could be improved by honoring the user input cma
physical address than the arch limit. As when users specify it, they
already knows what the default is which probably can't suit them.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 kernel/dma/contiguous.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..67af8a55185d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -222,7 +222,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	if (size_cmdline != -1) {
 		selected_size = size_cmdline;
 		selected_base = base_cmdline;
-		selected_limit = min_not_zero(limit_cmdline, limit);
+
+		/* Hornor the user setup dma address limit */
+		selected_limit = limit_cmdline ?: limit;
+
 		if (base_cmdline + size_cmdline == limit_cmdline)
 			fixed = true;
 	} else {
-- 
2.43.5


