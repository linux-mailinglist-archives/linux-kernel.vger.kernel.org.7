Return-Path: <linux-kernel+bounces-845260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A662BC42F8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1119E0BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC928233136;
	Wed,  8 Oct 2025 09:47:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097F221F24
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916842; cv=none; b=qCZE65MIvcue2JXtjhy7NviI7fhj+8XS3gy5L4JjTmH47xF5c+N5GXIJq0seGDBXYnucR34cdENN5lbtvvlxifV5eDgZatr8QHbVhqqOl3DFYwhHL9F/Nsd4lWcoTtwIpfqLc4Yy8dbsUMc6tXrDyCPnIle27p6nOUIU217j048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916842; c=relaxed/simple;
	bh=CaeTSAMNvntLMMC3oASq9vA/Ai4p+SwZncbBJmLvTP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzIZt5TDYrhaYVLA4T50iBbdu50bYl/9XjPvZDxk1Vo4uj1meLK701BrGl5jjKCFpKx+tpcta7MGixtFyKFA1us9H4UjbPElSnIGeEMUoqFZuf2FWjTq7NyV0l7eQwdLmOkcQzfYJiLdmBWxtDclLQjq67i6bBzg0jyhASB0wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C89BC4CEF4;
	Wed,  8 Oct 2025 09:47:19 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mtd: nand: MTD_NAND_ECC_REALTEK should depend on HAS_DMA
Date: Wed,  8 Oct 2025 11:47:15 +0200
Message-ID: <5109cd228940c246d2e1ef4ff01799315601c285.1759916792.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_NO_DMA=y:

    ERROR: modpost: "dma_free_pages" [drivers/mtd/nand/ecc-realtek.ko] undefined!
    ERROR: modpost: "dma_alloc_pages" [drivers/mtd/nand/ecc-realtek.ko] undefined!

The driver cannot function without DMA, hence fix this by adding a
dependency on HAS_DMA.

Fixes: 3148d0e5b1c5733d ("mtd: nand: realtek-ecc: Add Realtek external ECC engine support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 4a17271076bc1c4a..1e57c8de857825d7 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -63,7 +63,7 @@ config MTD_NAND_ECC_MEDIATEK
 
 config MTD_NAND_ECC_REALTEK
         tristate "Realtek RTL93xx hardware ECC engine"
-        depends on HAS_IOMEM
+        depends on HAS_IOMEM && HAS_DMA
         depends on MACH_REALTEK_RTL || COMPILE_TEST
         select MTD_NAND_ECC
         help
-- 
2.43.0


