Return-Path: <linux-kernel+bounces-727017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4AB013F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2915A73E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54E1DFE0B;
	Fri, 11 Jul 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b7AX8USq"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA410F2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217288; cv=none; b=mekL01z3M0rYxzeOE20CWlUewvZ9uPbuRgssVwX7ocBZdeOt0wwiuZh2Ed/d6InB3j5zmBNOZ2pu6JiP56w8HSwiaNyJkmZ0mj/vgFa2ZAfOgKKLYAR1KMZcGTHeGQcshwZVhxS/FbSCyN4J738I1SYxH8mutsXmDJqQIIZ3mHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217288; c=relaxed/simple;
	bh=JIOnGgolu/COLOQppNdzEF05M+7NretGhi5gKwNtgYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=f6L19IuLzSrtny9FTSojerYAlfWl7cCbYFqSqxOz59hgYb2aXFrnnCaoMzoMO7dHnE27/Gp6Sxu+FoIqV7A9iFTp9WjrlOAEeESjDsPPpuH4qI4OPm2ktjTyvbgLQBCpjixs1Q7Fh5JCgglRn/jcuiaOxfZlQW/oSQ2552IZOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b7AX8USq; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250711070117euoutp0265debdc604a476dcaba75dea8e96b01c~RIFSnbolN1635216352euoutp02M
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:01:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250711070117euoutp0265debdc604a476dcaba75dea8e96b01c~RIFSnbolN1635216352euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752217278;
	bh=79bKppBldYti/ypqiN2CkZAAnEEIsuoO0YIZOoHX1RE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=b7AX8USqtumNSLOP8u1PYkXn3waXb2WmmaL78O7dcZZYd1rkRSBJbeRF5CxbseFqA
	 cgfgbxCTxcXNSraX4lSmUGs8TpRQXZgiDFjLU7ZYz9FpBU0Q8Kd1nMVN7PFwOpM4Hd
	 otnL8j5msf7FXrCO6mm4yo2R72Eij/9Z8xSJJqWY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb~RIFSTaXKZ1251012510eucas1p2o;
	Fri, 11 Jul 2025 07:01:17 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250711070117eusmtip2a4f965f590b2644d81d83724ea0b249d~RIFR9Ewm80454804548eusmtip2H;
	Fri, 11 Jul 2025 07:01:17 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Feng Tang <feng.tang@linux.alibaba.com>
Subject: [GIT PULL] dma-mapping fix for Linux 6.16
Date: Fri, 11 Jul 2025 09:01:02 +0200
Message-Id: <20250711070102.4071882-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb
X-EPHeader: CA
X-CMS-RootMailID: 20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb
References: <CGME20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb@eucas1p2.samsung.com>

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.16-2025-07-11

for you to fetch changes up to aa807b9f22df2eee28593cbbabba0f93f4aa26c1:

  dma-contiguous: hornor the cma address limit setup by user (2025-06-12 08:38:40 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.16

- small fix relevant to arm64 server and custom CMA configuration
  (Feng Tang)

----------------------------------------------------------------
Feng Tang (1):
      dma-contiguous: hornor the cma address limit setup by user

 kernel/dma/contiguous.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

