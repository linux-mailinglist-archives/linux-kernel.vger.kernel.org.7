Return-Path: <linux-kernel+bounces-807914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C85B4AB07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E897B0462
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4F2ED16D;
	Tue,  9 Sep 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jVWQxhZX"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281413EFE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415729; cv=none; b=kstV0+DO/sV4QBM8VcZsyhrP0vIq3jadIYR28ccLdWb9fkkN/Kh1qTbRsCRnxb+sP4EWHCzhotjwQ/w7O08osIEHzAeDsSHI4RsWz7tfetFnOhdjUMdWuAPYkZB2j/j4CHPzx63HZvEkaAi+fuoNAbiZ95rqXrtK0qfXnmuG0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415729; c=relaxed/simple;
	bh=b4Lg78G73f8fEzMQwzeadswOm1NOisEedPMhkqM64/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=UT2ai8ogU86f2IkmRAzFeABrGp7f5xsKWS+97dp01PAit7BRUDBRNHNtXA8XNoT1Kx4iK6JPUBPbkuTCCPw/KxyP+k5CGFL7yJpY2iHRlL5giRulJ0opjXNVglHzth32J0QYOyemrmR3HfYSXPypWCGHuEdtwpoaXN3/wNBqm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jVWQxhZX; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250909110200euoutp028b76e12780e17d7c62d9fbc23a725df9~jmElOBTVO3027630276euoutp02K
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250909110200euoutp028b76e12780e17d7c62d9fbc23a725df9~jmElOBTVO3027630276euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757415720;
	bh=z7ahKJPszpzQt7DpcFdRo3DoCDjG+H84aRFvs69u80U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jVWQxhZXw/x7uUtAUZE+ZXUM5P6r7H53hjaPFajdg/CERLsEXDsjIR+/Hu6+0k+vN
	 ljwG678+/fXzKOItfpw3o0cINshHgJ1Q5qO9SPiMLYj4Hp0aQjUG72LnRq9fgMphx5
	 gV411hBvM4GTSFhHzpNVNsZBzfzB84T9DIfu27AY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250909110159eucas1p260bd877535b4bc0d8fe6c3101f3dcbca~jmEkpy49h3183831838eucas1p2L;
	Tue,  9 Sep 2025 11:01:59 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250909110159eusmtip1ea8f8d7fded55b24e3a2804e2384ee88~jmEkSbBHn2838828388eusmtip1k;
	Tue,  9 Sep 2025 11:01:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [GIT PULL] dma-mapping fix for Linux 6.17
Date: Tue,  9 Sep 2025 13:01:52 +0200
Message-Id: <20250909110152.1143681-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250909110159eucas1p260bd877535b4bc0d8fe6c3101f3dcbca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250909110159eucas1p260bd877535b4bc0d8fe6c3101f3dcbca
X-EPHeader: CA
X-CMS-RootMailID: 20250909110159eucas1p260bd877535b4bc0d8fe6c3101f3dcbca
References: <CGME20250909110159eucas1p260bd877535b4bc0d8fe6c3101f3dcbca@eucas1p2.samsung.com>

The following changes since commit 89a2d212bdb4bc29bed8e7077abe054b801137ea:

  dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted (2025-08-13 11:02:10 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.17-2025-09-09

for you to fetch changes up to 7e2368a21741e2db542330b32aa6fdd8908e7cff:

  dma-debug: don't enforce dma mapping check on noncoherent allocations (2025-09-02 10:18:16 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.17

- one more fix for DMA API debugging infrastructure (Baochen Qiang)

----------------------------------------------------------------
Baochen Qiang (1):
      dma-debug: don't enforce dma mapping check on noncoherent allocations

 kernel/dma/debug.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/dma/debug.h   | 20 ++++++++++++++++++++
 kernel/dma/mapping.c |  4 ++--
 3 files changed, 69 insertions(+), 3 deletions(-)

