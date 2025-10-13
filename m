Return-Path: <linux-kernel+bounces-850906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B941FBD514F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BFB486FED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337930E84B;
	Mon, 13 Oct 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCA3zVJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163530C36C;
	Mon, 13 Oct 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369660; cv=none; b=mXaZUNfVBas2KDJO79V3gajxoRe6Ldg8No0XYA12aC3oIGsmlzoYDycztWh8jePtzD+abRka/vYQgboniz5MYcxf8Jw0021fWgqhDrAbx0rpeep9OucY5ARiCpQ7OF1W8/DWzsTzNuD7Ux6FLLifdoI6PgRyLycmioKFmYwEZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369660; c=relaxed/simple;
	bh=PRFLXFpda4njnxhl0lQayxdFizo+kwRd6yiTUvOdd7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxQSAF47pbs3XemC4nN1lziihUmfHoJ3KCMxQifjn4cWiXYndgnqdSXPVBM0U1I7dwxdCSoHW1lpEDY73P3X1hlDOnbuDNAR8uJHGRVLj8BVUhvoPsN3TBHOpIZYZJ1uMSLHnVHAbrwUldXglOKMk+LBNfB1TOZf8QplIl0As3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCA3zVJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0256FC4CEFE;
	Mon, 13 Oct 2025 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369660;
	bh=PRFLXFpda4njnxhl0lQayxdFizo+kwRd6yiTUvOdd7c=;
	h=From:To:Cc:Subject:Date:From;
	b=NCA3zVJyyGgDjREB++TJQDBF9C48uL2utB84JAMAZ+5526+kP9oBibWvDKO94g2dR
	 Sbif4yn+JXkiuetm40aux2cbf8HsOrNdWF7+MSx5eY5MxszJ7mdldP8iV1K1xHlIMO
	 xrabJuLKcMpOkXJCjiRg7BBXr1MlUf58ugWDzeYK8GoodxPTzF6VbZiShBDUt1GIYI
	 EmNHrhCuVIqHZQzjqCdckhkVNvcHwUpvrF00mUyUtqrDcs+mIGI51pDMo1R118EoQE
	 fiaxyg/Dd831rEvjydqrtUD6l6oSObENVWpBQOmhdD/uKgu3Eb2N22+vPFmVOrGioI
	 oJfNF3FxaLTnw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/4] Properly take MMIO path
Date: Mon, 13 Oct 2025 18:34:08 +0300
Message-ID: <cover.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is NVMe and block specific patches from my DMA series [1] which
improved DMA physical API to properly support MMIO memory.

Thanks

[1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/

Leon Romanovsky (4):
  blk-mq-dma: migrate to dma_map_phys instead of map_page
  blk-mq-dma: unify DMA unmap routine
  block-dma: properly take MMIO path
  nvme-pci: unmap MMIO pages with appropriate interface

 block/blk-mq-dma.c            | 52 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/pci.c       | 18 ++++++++----
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h |  3 +-
 include/linux/blk-mq-dma.h    | 35 ++---------------------
 include/linux/blk_types.h     |  2 ++
 6 files changed, 68 insertions(+), 43 deletions(-)

-- 
2.51.0


