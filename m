Return-Path: <linux-kernel+bounces-578359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46DA72E80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 12:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057AF179EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A910211A11;
	Thu, 27 Mar 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK/nszKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01692116F6;
	Thu, 27 Mar 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073660; cv=none; b=o3INqBvV/3ZR4QReWGVr6hUrtjuv2nJXSqS/paBNGCIoYHx4+rglUD23LHpykuwIJ+NrOtQcpnd/DSK6fQgOSkO9IQmMFBnNR0CxupciH7ufW0PtaOY4mRiGXrrxBvrSrEptZ42Wj/F0qdLvXfIfytthnkHj8whWZfihJOK1Uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073660; c=relaxed/simple;
	bh=FbMtkhsM4PEe39tIGPItq+7v4k2UfpBD4FAsk8XjaX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEiKt9GWJWf1stsIxzFB/dSbL0a50ChS2azY6SY0iE38YbencSB7FlRaTqioS/nvt9CY8VDR3/BeUYPV0PTns9mCaYi+PZ5KSmzqQAXY3Ahhwt+rHEqncJF2zsn3VyGD9s4zMoP4eMCO33qKMg/I+OGliYIHsrt/bafpDY5mZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK/nszKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA787C4CEDD;
	Thu, 27 Mar 2025 11:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743073660;
	bh=FbMtkhsM4PEe39tIGPItq+7v4k2UfpBD4FAsk8XjaX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CK/nszKPNstpezxlJ6vsP33DRgLrjAXRU9wzHYMq9d9dyuAG7liRcBMiwgVYlF4w5
	 J1X8SbknLh3+nkYXz+A63rCvk50RV5ViM+vOT4BJm0erNBg4h+xDGrVpHzXZ0RtiPS
	 Z6MVQ0tzkyrzYOJcExGbTuKZDojclPVwUzDR3zaygpXhPsFxH979r068IsQ/wq1pWY
	 A9RcEoKk8421N0ZugstLA8+vQe+KUbzPry2LoWHTvnyEQI9G4/N7hXVzordXYnrVuq
	 cZPO0KXX6gp8uftZMvcVp+pIDnm4RDvRpHGr1Od2aFiiMluxWsAjCJQiW/AWZDQnLw
	 5Aqkc4ZKBs3Ug==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/2] mtip32xx: Remove unnecessary PCI function calls
Date: Thu, 27 Mar 2025 12:07:07 +0100
Message-ID: <20250327110707.20025-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327110707.20025-2-phasta@kernel.org>
References: <20250327110707.20025-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iounmap_regions() is deprecated. Moreover, it is not necessary to
call it in the driver's remove() function or if probe() fails, since it
does cleanup automatically on driver detach.

Remove all calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 95361099a2dc..63b9c41d3c25 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3717,7 +3717,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rv) {
 		dev_warn(&pdev->dev, "64-bit DMA enable failed\n");
-		goto setmask_err;
+		goto iomap_err;
 	}
 
 	/* Copy the info we may need later into the private data structure. */
@@ -3733,7 +3733,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	if (!dd->isr_workq) {
 		dev_warn(&pdev->dev, "Can't create wq %d\n", dd->instance);
 		rv = -ENOMEM;
-		goto setmask_err;
+		goto iomap_err;
 	}
 
 	memset(cpu_list, 0, sizeof(cpu_list));
@@ -3830,8 +3830,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[1].cpu_binding);
 		drop_cpu(dd->work[2].cpu_binding);
 	}
-setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 
 iomap_err:
 	kfree(dd);
@@ -3907,7 +3905,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.48.1


