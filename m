Return-Path: <linux-kernel+bounces-844389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659DBC1C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C223BBCBD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687042E22BD;
	Tue,  7 Oct 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i9qmK07d"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038922D7DE0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848365; cv=none; b=mNy5TwFWcaFsCB04rrW0vvrYMYrjvpMpuM9pCjYf8bkeGNthEy3PsXKar9k2vfJtZEzVeOqu3AKTbLfNCDHv+wg1M/g/UJfBqxhCPfNsxFDrehy4uXm/Ctagtr7TrcbAnuHc9WWuKXUKDIXZDRF+PfAm1cVl8NVAY/7BTx8qit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848365; c=relaxed/simple;
	bh=WT64jMbxboNxF1xklb8UQhlFPb4NaVD0os9H5GA0bI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cn8PBgvnfN5vTuIe0Jk/RTtKmhpYK4PkhHwARo9nD/g03x5LAb9Et2b7WsbzjdyXtt2RKEC/3uZ4uFSYZ1Xi3D7vNfTOAaEZsNghuiSod6y7yIp8D/3ztADBKlZ3hrwiovPrMoByGRzaC2b+qbHD+MWcKSI4V1ICKZ08eP+V05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i9qmK07d; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251007144600euoutp013cdfbc1d8cc6aa962720bffe5e62498a~sPMKeymfN2145721457euoutp01W
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:46:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251007144600euoutp013cdfbc1d8cc6aa962720bffe5e62498a~sPMKeymfN2145721457euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759848361;
	bh=1HZe7Sqk0ec7oEcOx8zABBkFNcLSTrCaMp8zzpZHjLE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=i9qmK07dlrCNUNLQ+BUBBBx4HUJ3QIFAXCdeAZKssajhQNkw1qWGVSQfJBxUEo4yi
	 hM6QyLeq/OP2ZNixe4zQKcZFFbZwJ+fLVd7x9h1tDWg16ZFYLq9gTuVymQ7k3ytdoS
	 sHS2s++ddxpxXqi39hPUfWequObr8/7j1ePEXDg0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251007144600eucas1p245415d2578628bca535155cf94679cc6~sPMJsp8mE1148311483eucas1p2f;
	Tue,  7 Oct 2025 14:46:00 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251007144559eusmtip17208b5ff74f14525c83800f11e2b3ed3~sPMJNKhpD2554025540eusmtip1j;
	Tue,  7 Oct 2025 14:45:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Petr Tesarik <ptesarik@suse.com>, Shigeru Yoshida
	<syoshida@redhat.com>
Subject: [GIT PULL] more dma-mapping updates for Linux 6.18
Date: Tue,  7 Oct 2025 16:45:45 +0200
Message-Id: <20251007144545.2208636-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251007144600eucas1p245415d2578628bca535155cf94679cc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251007144600eucas1p245415d2578628bca535155cf94679cc6
X-EPHeader: CA
X-CMS-RootMailID: 20251007144600eucas1p245415d2578628bca535155cf94679cc6
References: <CGME20251007144600eucas1p245415d2578628bca535155cf94679cc6@eucas1p2.samsung.com>

The following changes since commit ef3d979b3e270b6a41b6f306bfc442253c41a4cd:

  kmsan: fix missed kmsan_handle_dma() signature conversion (2025-09-17 14:42:36 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-10-07

for you to fetch changes up to 16abbabc004bedeeaa702e11913da9d4fa70e63a:

  dma-mapping: fix direction in dma_alloc direction traces (2025-10-03 08:45:09 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.18:

- two small fixes for the recently performed code refactoring (Shigeru
Yoshida) and missing handling of direction parameter in DMA debug code
(Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      dma-mapping: fix direction in dma_alloc direction traces

Shigeru Yoshida (1):
      kmsan: fix kmsan_handle_dma() to avoid false positives

 include/trace/events/dma.h | 1 +
 mm/kmsan/hooks.c           | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

