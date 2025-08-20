Return-Path: <linux-kernel+bounces-777982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78564B2E022
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D18F176150
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59130322775;
	Wed, 20 Aug 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IVLMptdK"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99833203B5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701757; cv=none; b=OMwU5AcwQH+PKAlEDjW1yit1BbTVudhxYBcFkiVudt6D9a46KYe991qZMKUYXwrI9lHJ4ejiUuLWdJ+WBJ6Jt7Ew6SoQ+Y26NBREsHNFg5eyGej2t2KAtGNG+qOuDbZDtWIDsxFkYmn+mUcwelAEIEwHiEY3vK0mei3OuWTIkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701757; c=relaxed/simple;
	bh=bMlWjWqjobDxiLBWkDzWIzpY1xcGuH1rFnWv9puwpSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHL2Aii9qq6RvPbyZ0CTeV4GuoBMoi5EeBeE6zPNmBh2bC+y2qczqtyEzze9pDaNoBQt/Zw+BMewkKj2buJ4K6K03GsLC6H3mqddziYV/URMYCecyULWcla1qxqt/wYLbB8hga9uoruwOQVgIVVTpx/2ayUAHiJLXolTdVC3msE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IVLMptdK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 755E84E40C58;
	Wed, 20 Aug 2025 14:55:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E68B606A0;
	Wed, 20 Aug 2025 14:55:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 614FC1C22862A;
	Wed, 20 Aug 2025 16:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755701753; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sjEQkGkfGGmFcD/QqK94etV1EzeES0FgbJFhn32rCEE=;
	b=IVLMptdKEOmov+bMCCnRSjJXk630u9DdKbBvJQUlUnOFB6kGn0ocedvQuzuq5jpPlY6XjA
	/RrcqyIsXq4FPB0sbhyqPSUGNAGoK/5mRKy8cc5lZA+iGoesDMx9JQF9dB0SAku0VE3i/B
	RbdMhQy8Nuq6/jziHHSlOB10GzmnFo/8KtyNIlzVQ+tfj1S49cdSt2uhB6RBqVY0ixvI71
	yN0EBIQeYUiMgQseZXRN6aUkCmGymNKn15kn5bOVLHYzAcnflG+69fjRqz0oeFyIPe/XVD
	WBdGwUboQwFqfla72A5K1aser+yp7MZrPO3jR1wR6UwjCXWp6IiV7uLA2HgVrg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 20 Aug 2025 16:55:07 +0200
Subject: [PATCH net v4 3/5] net: macb: move ring size computation to
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-macb-fixes-v4-3-23c399429164@bootlin.com>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
In-Reply-To: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The tx/rx ring size calculation is somewhat complex and partially hidden
behind a macro. Move that out of the {RX,TX}_RING_BYTES() macros and
macb_{alloc,free}_consistent() functions into neat separate functions.

In macb_free_consistent(), we drop the size variable and directly call
the size helpers in the arguments list. In macb_alloc_consistent(), we
keep the size variable that is used by netdev_dbg() calls.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 69325665c766927797ca2e1eb1384105bcde3cb5..d413e8bd4977187fd73f7cc48268baf933aab051 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -51,14 +51,10 @@ struct sifive_fu540_macb_mgmt {
 #define DEFAULT_RX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_RX_RING_SIZE	64
 #define MAX_RX_RING_SIZE	8192
-#define RX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
-				 * (bp)->rx_ring_size)
 
 #define DEFAULT_TX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_TX_RING_SIZE	64
 #define MAX_TX_RING_SIZE	4096
-#define TX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
-				 * (bp)->tx_ring_size)
 
 /* level of occupied TX descriptors under which we wake up TX process */
 #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
@@ -2466,11 +2462,20 @@ static void macb_free_rx_buffers(struct macb *bp)
 	}
 }
 
+static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
+{
+	return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_prefetch;
+}
+
+static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
+{
+	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
+}
+
 static void macb_free_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
-	int size;
 
 	if (bp->rx_ring_tieoff) {
 		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
@@ -2484,14 +2489,14 @@ static void macb_free_consistent(struct macb *bp)
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
 		if (queue->tx_ring) {
-			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
-			dma_free_coherent(&bp->pdev->dev, size,
+			dma_free_coherent(&bp->pdev->dev,
+					  macb_tx_ring_size_per_queue(bp),
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
 		if (queue->rx_ring) {
-			size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
-			dma_free_coherent(&bp->pdev->dev, size,
+			dma_free_coherent(&bp->pdev->dev,
+					  macb_rx_ring_size_per_queue(bp),
 					  queue->rx_ring, queue->rx_ring_dma);
 			queue->rx_ring = NULL;
 		}
@@ -2542,7 +2547,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
+		size = macb_tx_ring_size_per_queue(bp);
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
@@ -2560,7 +2565,7 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 
-		size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
+		size = macb_rx_ring_size_per_queue(bp);
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->rx_ring_dma,
 						    GFP_KERNEL);

-- 
2.50.1


