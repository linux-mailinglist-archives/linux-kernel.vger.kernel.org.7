Return-Path: <linux-kernel+bounces-896923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78EC5188A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3242D1882B81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B02FFDC4;
	Wed, 12 Nov 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TPzg+0qn"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC12FE579
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941591; cv=none; b=nVDAPfhUVM2s7I98c7h0uMmMfmTnf84iH8flcfzDOS9urtjmSYHbFtBXfF3s78o2HQmv8N/iCxhQDCOdFoSrI9FExN6VjPnqHJcGEvwLhJIxCg3G7vmmm+f5MUAOvdRtFMIq52a77/OBisWxZ0FE244sf5Ythp7oceND4LxCXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941591; c=relaxed/simple;
	bh=IB0BDay0zBQmT+faxjzruvanmhRRELmbRKCgqLjkN9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=XVZCZWGnN9m/pNZzZHHGjI/sxHgeG2clscADsYkzmJrcFyPM6+ZVydZeK2suI1uY5MwijWJT9XRc/8tlH0H7GZp2HH+go3N9N/z9QYwqzvbP1Q92kBdmjnVGQYiitv9CNuT95NMDXKqFjdoko+0mz+UqpTsUhKhSAqMANSAjJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TPzg+0qn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251112095941euoutp02cf6da69b8b3d5464913d6f691d581c4d~3OgcloxZA3142031420euoutp02U
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:59:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251112095941euoutp02cf6da69b8b3d5464913d6f691d581c4d~3OgcloxZA3142031420euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762941581;
	bh=thLoqzL6EhsQKoVfFajezgLWEwlk5OOypk7k33hMFwE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TPzg+0qnhE+xO8IsidkkrzEWX61AJOiJ+iko+qNqyailofTc+8IecuM1JaXk/wKSR
	 iua4q1aGUbbOdvDTVbZvSZZSuCf4FuvDOi/pKZwiLluiRCsSYM0lG4AL1JNTUanEkS
	 4ktnopUHn2uR6lIOgoXToyCXPtoAuTpCJdBGpLS4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251112095941eucas1p2e0efc01a697cac1a9d51f5a2ae92b5ae~3OgcLnv192708827088eucas1p2R;
	Wed, 12 Nov 2025 09:59:41 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251112095940eusmtip1a1e320c4c4df1645194d7530bdc9da80~3Ogb3wgbK2550625506eusmtip1O;
	Wed, 12 Nov 2025 09:59:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 6.18
Date: Wed, 12 Nov 2025 10:59:20 +0100
Message-Id: <20251112095920.5802-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251112095941eucas1p2e0efc01a697cac1a9d51f5a2ae92b5ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251112095941eucas1p2e0efc01a697cac1a9d51f5a2ae92b5ae
X-EPHeader: CA
X-CMS-RootMailID: 20251112095941eucas1p2e0efc01a697cac1a9d51f5a2ae92b5ae
References: <CGME20251112095941eucas1p2e0efc01a697cac1a9d51f5a2ae92b5ae@eucas1p2.samsung.com>

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-11-12

for you to fetch changes up to a50f7456f853ec3a6f07cbe1d16ad8a8b2501320:

  dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope (2025-11-05 13:43:41 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.18

- two minor fixes for DMA API infrastructure: restoring proper structure
padding used in benchmark tests (Qinxin Xia) and global DMA_BIT_MASK
macro rework to make it a bit more clang friendly (James Clark)

----------------------------------------------------------------
James Clark (1):
      dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope

Qinxin Xia (1):
      dma-mapping: benchmark: Restore padding to ensure uABI remained consistent

 include/linux/dma-mapping.h   | 2 +-
 include/linux/map_benchmark.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

