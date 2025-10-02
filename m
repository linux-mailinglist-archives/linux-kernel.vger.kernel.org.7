Return-Path: <linux-kernel+bounces-840411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DC0BB4537
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B529B7B1CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF91F181F;
	Thu,  2 Oct 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvWg1S5G"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5B1EDA09
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418813; cv=none; b=u996pQSeTX3YbF93Pcm29Vd3WMhxWTntLVsj9RdY/RxHEqXb+9Sei+XaisOiSabgPYBK7UqLJ5P76q9ujhjgbB44YjFS+CDeK1WPk4YG2jhBc/NZi+hsBImMve9VDd+86k9NlEZY5bwswXnwk5mtqKrKiy7LT5BmyGkTTpd8doI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418813; c=relaxed/simple;
	bh=y+65hYrYIaWHVoTgELiJ1RdDrOEMiSFF9ry/3VNg7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBR50SXwsyVTe2ZQnnEZowH5q/UWcplN4qPAlPlPqg5G4Bc6BB4CdigdOs/htQOGTzkZ0hoV8A3J/nAhtkvBOuiAFlViQo4unmSanyb8cMmwatxA7Ee7Oq1gEQjsDk31CwPyFl/kvCMFetMLejFqMsOxaXMIMriRb1UUSwRjBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvWg1S5G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-267facf9b58so7069885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759418811; x=1760023611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQJrUlVfBkMRiq+RoyZz0BqubRT3pqUe/XqlC5WCMZ8=;
        b=OvWg1S5GRy8v58/s2gH3x/xydcL6ALFGA76DDRN1m/qvfRQZZrdn6/kskTZAJSGjoW
         XVmu/A2CkzpK+/6S5Jmwrkw69J5UEIWLRpZzlccugs8RgFFlznArrrMaTuBEKKDFvWq2
         OS7P1EVftSbWpgEv48exDEtWuWrkmc2i82BVOHQDtnL92YPM5sapN/5/CJut1VrfGSFx
         DINyhx77scD8wgP0bpe3o7Azm9lvVGzebBjxah8V0lrnb7yDvEak59xJ5HVW2GUpQC5f
         qopM0nuaZ3+GHEYj2/s8gXRicWoHk9tH5j6RFQiNx1QziqBRgMIOXG1PdKGC4Dakqacj
         m9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418811; x=1760023611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQJrUlVfBkMRiq+RoyZz0BqubRT3pqUe/XqlC5WCMZ8=;
        b=S4IMs9n/Oww4aPvXP5VNUFEZZfrP8mCY6O6etC28lh4J+bPUZlllFCHQbjmJwp3zt1
         gM8ivGBC1/cUXHtKrmrsARA70u3BYJSjo4KEFGa+Rak1m45HjpKCmHKGciA2C2S9xggf
         aveI7y8Ukq64fn/VJj4tiC+GWx/qL0tib8UcPESl/qg8esuB3OkMKi+iVYfS1cZTccaA
         1A4ByyEbprb/L+p4oyR5IoFFkepmJI0FSB5GgnsdOSIwjti/NF7JwkBB2TNKtKA4qLOK
         nk/wMMb23l2C4aG1pbK89fSJnRWh7v2QulZ0u0XWFR8G0EZWAdjN2WuzzXwUoNkWLeAW
         gl9A==
X-Forwarded-Encrypted: i=1; AJvYcCWXUdHzfSLUIScQPMJS5ScS2wqAaGiJ4laTJYqGn8AgFtqdJG9w0DZGjURjlsQXM4oecTeEguebr6YK44E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZU50xvKfVOZ28oONWNMTBi7Ph4vDUIeYUXaAV6JQKx8CW+L2c
	pBRp/EVBEJIblZ+N35WTOT2rjW8qcV+qRbDF8sQKyYZ7Ewr7UQmtqbCv
X-Gm-Gg: ASbGnct0J2wZKzqJnVxocPAkXVhrKHxJ1AePqaD5p3gkp7Q0YxB3zHsLVQrImj7BPc9
	e/hCp7CU0obm71oO4Tjl25Oy/5n80DhyleUleAHppYywUwv5rkDEyI/bn04fjnXTdoTSFxTJXlV
	erNtYmvo54s+vIVC3WzqWNulVHCdvd7WQzJc9kX6HFBzfrgrbAtgE+DS4CumTKU0e06kjlIpJGl
	dEwWf1AruAA3eCkAoICN+qHx7BBQTSSkev/zfOp1Zyb2jeOQmL1lsnB7Oq0cbIW/LtplKYXYGi5
	YZ59B5xvXSC7rMUxlVKwz6P/LhpHst22ixEwzJN2zrz+2WFxbM7rjpAk0J9tTZMztKyzI8Px0z3
	FqKNUzCGb1a/DB0YkHsiXqTJayELslQ28G5qJbZSoB9WGVkU=
X-Google-Smtp-Source: AGHT+IHranjbyb4YEuGAJFDc+X+dnQAiIaVTrIAMeQdBADBspQ0b+xaGar2PfT40nlwyi7dQ4ZgNQg==
X-Received: by 2002:a17:903:190d:b0:262:4878:9dff with SMTP id d9443c01a7336-28e7f26f32fmr113038245ad.12.1759418809416;
        Thu, 02 Oct 2025 08:26:49 -0700 (PDT)
Received: from mythos-cloud ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11080csm24776565ad.1.2025.10.02.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:49 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net] net: dlink: handle dma_map_single() failure properly
Date: Fri,  3 Oct 2025 00:26:38 +0900
Message-ID: <20251002152638.1165-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error handling by checking `dma_mapping_error()` and cleaning up
the `skb` using the appropriate `dev_kfree_skb*()` variant.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Tested-on: D-Link DGE-550T Rev-A3
---
 drivers/net/ethernet/dlink/dl2k.c | 49 ++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..a821c9921745 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -508,6 +508,7 @@ static int alloc_list(struct net_device *dev)
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		/* Allocated fixed size of skbuff */
 		struct sk_buff *skb;
+		dma_addr_t addr;
 
 		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
@@ -516,13 +517,19 @@ static int alloc_list(struct net_device *dev)
 			return -ENOMEM;
 		}
 
+		addr = dma_map_single(&np->pdev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pdev->dev, addr)) {
+			dev_kfree_skb(skb);
+			np->rx_skbuff[i] = NULL;
+			free_list(dev);
+			return -ENOMEM;
+		}
 		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
 						((i + 1) % RX_RING_SIZE) *
 						sizeof(struct netdev_desc));
 		/* Rubicon now supports 40 bits of addressing space. */
-		np->rx_ring[i].fraginfo =
-		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-					       np->rx_buf_sz, DMA_FROM_DEVICE));
+		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
 		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
 	}
 
@@ -674,6 +681,7 @@ rio_timer (struct timer_list *t)
 		/* Re-allocate skbuffs to fill the descriptor ring */
 		for (; np->cur_rx - np->old_rx > 0; np->old_rx++) {
 			struct sk_buff *skb;
+			dma_addr_t addr;
 			entry = np->old_rx % RX_RING_SIZE;
 			/* Dropped packets don't need to re-allocate */
 			if (np->rx_skbuff[entry] == NULL) {
@@ -686,10 +694,16 @@ rio_timer (struct timer_list *t)
 						dev->name, entry);
 					break;
 				}
+				addr = dma_map_single(&np->pdev->dev, skb->data,
+						      np->rx_buf_sz,
+						      DMA_FROM_DEVICE);
+				if (dma_mapping_error(&np->pdev->dev, addr)) {
+					dev_kfree_skb_irq(skb);
+					np->rx_ring[entry].fraginfo = 0;
+					break;
+				}
 				np->rx_skbuff[entry] = skb;
-				np->rx_ring[entry].fraginfo =
-				    cpu_to_le64 (dma_map_single(&np->pdev->dev, skb->data,
-								np->rx_buf_sz, DMA_FROM_DEVICE));
+				np->rx_ring[entry].fraginfo = cpu_to_le64(addr);
 			}
 			np->rx_ring[entry].fraginfo |=
 			    cpu_to_le64((u64)np->rx_buf_sz << 48);
@@ -720,6 +734,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
 	struct netdev_desc *txdesc;
+	dma_addr_t addr;
 	unsigned entry;
 	u64 tfc_vlan_tag = 0;
 
@@ -743,8 +758,14 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 		    ((u64)np->vlan << 32) |
 		    ((u64)skb->priority << 45);
 	}
-	txdesc->fraginfo = cpu_to_le64 (dma_map_single(&np->pdev->dev, skb->data,
-						       skb->len, DMA_TO_DEVICE));
+	addr = dma_map_single(&np->pdev->dev, skb->data, skb->len,
+			      DMA_TO_DEVICE);
+	if (dma_mapping_error(&np->pdev->dev, addr)) {
+		dev_kfree_skb_any(skb);
+		np->tx_skbuff[entry] = NULL;
+		return NETDEV_TX_OK;
+	}
+	txdesc->fraginfo = cpu_to_le64(addr);
 	txdesc->fraginfo |= cpu_to_le64((u64)skb->len << 48);
 
 	/* DL2K bug: DMA fails to get next descriptor ptr in 10Mbps mode
@@ -1007,6 +1028,7 @@ receive_packet (struct net_device *dev)
 	entry = np->old_rx;
 	while (entry != np->cur_rx) {
 		struct sk_buff *skb;
+		dma_addr_t addr;
 		/* Dropped packets don't need to re-allocate */
 		if (np->rx_skbuff[entry] == NULL) {
 			skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
@@ -1018,10 +1040,15 @@ receive_packet (struct net_device *dev)
 					dev->name, entry);
 				break;
 			}
+			addr = dma_map_single(&np->pdev->dev, skb->data,
+					      np->rx_buf_sz, DMA_FROM_DEVICE);
+			if (dma_mapping_error(&np->pdev->dev, addr)) {
+				dev_kfree_skb_irq(skb);
+				np->rx_ring[entry].fraginfo = 0;
+				break;
+			}
 			np->rx_skbuff[entry] = skb;
-			np->rx_ring[entry].fraginfo =
-			    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-						       np->rx_buf_sz, DMA_FROM_DEVICE));
+			np->rx_ring[entry].fraginfo = cpu_to_le64(addr);
 		}
 		np->rx_ring[entry].fraginfo |=
 		    cpu_to_le64((u64)np->rx_buf_sz << 48);
-- 
2.51.0


