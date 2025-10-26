Return-Path: <linux-kernel+bounces-870500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E02C0AFA7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9747C3499EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD62EDD5F;
	Sun, 26 Oct 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXR3HNT3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A226E16E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501321; cv=none; b=b0z6Oh9yBBr1qo+HXtWA7EXFglaUn2Nl6tPCRRfW02FXoaFLvsYJ9BaBt9s9RlT0qQTWHbPVskPo1PgRQXZJrsbZbLkw5yFUJnLCzAaTe9ApILgt9/iDSmTpE6SQrzxy8Ov5PnMvt3dFUqM7ZC0fQPBoOiWfxSpc6EcSYP85Jis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501321; c=relaxed/simple;
	bh=TYqSgjtJTLH69TjVY4P5M4kBe3nBDzdkUzWmul55T9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRhIG6FFFMUU7/b2rm5DJL6x3sZ55zB3S86nT7jdpiJwx0jWM4tNipNDwBcyV7SO5JaZDfsihjzUTgBJuwj/oSuDAuzN2PUxspAY/AtW8Nm1MYA2nJWSKK1LcK85+tIeyFozAMBl8YPYS+OUAVEJdgYXMVHvzHMLirjUWPKwR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXR3HNT3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f898fso63119645ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761501319; x=1762106119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU/OVZkhFNUOoFCHhkl2TNsQ4jyGlF9k1fRMPXpk2ak=;
        b=WXR3HNT31NwM5NodAbb8boYXbDCLNZQxsOCUc4n40UBDHRxJHzLVQMoVHd8T5w8j7G
         UB1fCnqgM+tjfFsTttWHmXm7YVT6MzLP314kJjnjRrPVvcFwhCWSbsBiBUqkHfE93Atq
         VSH3w1DiHRyt3EZzB82MX6P4IKgC/aD8HNB2Xbv9j0GDWvC8cQ5qmqqkvADJuRaVCa9u
         1fOJKmx/41leZcrEkkFOruF89YL1amfyrcKX2ZaWY5sCkFR4fJVZ4JH578cjIw0sH7Df
         caXxnvNw/p2oU2U9LO/1W3FKOkGFgfZNRl/z/xxje7Sjc6GJt15zIfHGxCVWqba/hMtf
         P8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761501319; x=1762106119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU/OVZkhFNUOoFCHhkl2TNsQ4jyGlF9k1fRMPXpk2ak=;
        b=o1PjR13HcN73gX3u4YHOjsu6UYWtz4L8djuo5btyD6kVvythChcYNNrGXhj4srW1Qr
         saK5f+I0eG3B7nY+pFzHsQeSB2iQ6Le57C6mEstDbKkaPUCyaI9D1FIFyDwPUCJPebky
         5KUGfasVUr30UmUKEvHTTYTL30cwJxzPqi4wi+AlT/6Ha2IbTxZHT7eTSt7zAiPYscxx
         +It4xbT/9zhy9cc0beHc7pdRkxd1HP6ELYcLRMJYrqpw55HxuUzwZpaHf67Kia+RdNk8
         Zux+vx0FWyHS1UvshaTXXBnjv9bpESNu5qaUsDH9tmLmPtXQxmqr84n+YV9adg1pFDC5
         q0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWAKaINYAGbJglCnSbbpH2WpKCTIyFaBI/cOFJgLevbAKtsjXiI41w4TsyF5fzvcSqAcN0JGoDCYpTFasI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxueYOc1M8s9ZZZnMz0UDac+B8mJSuV1gW2tdVZ21AvU3Q/uZ/J
	4CsIGtTzEyqvAhu2hVOTVVMgrYXk/+DJzd0sT6Z1CL5VCqcbdnjRiYFk
X-Gm-Gg: ASbGnctlpPqA2t6fZQiVX5sp0LXGZ3xLB47/zK+lHhfQ9pbDTKQ3VvftlOpadTA0jN4
	clnMKzIMC2r5TVrIPM2BzAMf9Hoe5JN/jcnwCZHTA9ejD95SZZnK89rqeIDHHEIJlvGcphGM3Pj
	NBzfl+dJStcKKjlfs4vIxNopl1P+KmmUBoBkgZLGg/y/ZIHCTI7WsIJOvm/I47xmeFnQynUMiJ0
	ZI3vClbrqyOVTvirgN7iF9QTLLJoEeT7cpE6aXYDI0/z3zqH5Ri6ZXsmBAL9LOLIiQI2EGeYHbX
	ofPczyyrA6xidkOGgLwxmqK2lI885r3j4QMUg6hQ0AXet75QAWiUfdWXdCze80F/y22WB/qrr6O
	RnvUXb0efeJnCOGoevb1NL7M0J5x2BDYv9695N2ifz5f1MpcVDp0R4Iyjw4hbDeWkrZapolBm5N
	FkyhpYdpepDNiCYZBVGyK2NFKtYVqdxBcnw50QJ7J1wK0vn3R1nswqZsGR7KukW0jc00Kjccr+2
	sStbQ==
X-Google-Smtp-Source: AGHT+IHtoxrSHSNCI+CS585O+ZJjSo87+gdMzyAlT3jsfOF+kLbMUFYgGNOn1A7r8TyRNijf4nEX9g==
X-Received: by 2002:a17:902:cece:b0:292:fc65:3579 with SMTP id d9443c01a7336-292fc65380cmr248557725ad.17.1761501319468;
        Sun, 26 Oct 2025 10:55:19 -0700 (PDT)
Received: from debian.domain.name ([223.181.110.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm54813845ad.107.2025.10.26.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:55:18 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC PATCH net-next v2 2/2] net: ethernet: Implement ndo_write_rx_config callback for the 8139cp driver
Date: Sun, 26 Oct 2025 23:24:45 +0530
Message-ID: <20251026175445.1519537-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
References: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ndo_write_rx_config for the 8139cp driver

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/ethernet/realtek/8139cp.c | 78 ++++++++++++++++-----------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..3480079361f3 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -319,6 +319,11 @@ struct cp_extra_stats {
 	unsigned long		rx_frags;
 };
 
+struct cp_rx_config {
+	int rx_mode;
+	u32 mc_filter[2];	/* Multicast hash filter */
+};
+
 struct cp_private {
 	void			__iomem *regs;
 	struct net_device	*dev;
@@ -328,7 +333,7 @@ struct cp_private {
 	struct napi_struct	napi;
 
 	struct pci_dev		*pdev;
-	u32			rx_config;
+	struct cp_rx_config	*rx_config;
 	u16			cpcmd;
 
 	struct cp_extra_stats	cp_stats;
@@ -372,7 +377,6 @@ struct cp_private {
 	} while (0)
 
 
-static void __cp_set_rx_mode (struct net_device *dev);
 static void cp_tx (struct cp_private *cp);
 static void cp_clean_rings (struct cp_private *cp);
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -882,55 +886,53 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
 	goto out_unlock;
 }
 
+static void cp_write_rx_config(struct net_device *dev)
+{
+	struct cp_private *cp = netdev_priv(dev);
+	struct cp_rx_config snapshot;
+
+	read_snapshot((&snapshot), struct cp_private);
+
+	/* We can safely update without stopping the chip. */
+	cpw32_f(RxConfig, snapshot.rx_mode);
+
+	cpw32_f(MAR0 + 0, snapshot.mc_filter[0]);
+	cpw32_f(MAR0 + 4, snapshot.mc_filter[1]);
+}Firstly, think whether you have a bug fix or new "next-like" content.
Then once decided, assuming that you use git, use the prefix flag, i.e.
+
 /* Set or clear the multicast filter for this adaptor.
    This routine is not state sensitive and need not be SMP locked. */
 
-static void __cp_set_rx_mode (struct net_device *dev)
+static void cp_set_rx_mode (struct net_device *dev)
 {
-	struct cp_private *cp = netdev_priv(dev);
-	u32 mc_filter[2];	/* Multicast hash filter */
-	int rx_mode;
+	struct cp_rx_config new_config;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
 	if (dev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
-		rx_mode =
+		new_config.rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0xffffffff;
 	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
 		   (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to filter perfectly -- accept all multicasts. */
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		new_config.rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0xffffffff;
 	} else {
 		struct netdev_hw_addr *ha;
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0;
+		new_config.rx_mode = AcceptBroadcast | AcceptMyPhys;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0;
 		netdev_for_each_mc_addr(ha, dev) {
 			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
 
-			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-			rx_mode |= AcceptMulticast;
+			new_config.mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
+			new_config.rx_mode |= AcceptMulticast;
 		}
 	}
 
-	/* We can safely update without stopping the chip. */
-	cp->rx_config = cp_rx_config | rx_mode;
-	cpw32_f(RxConfig, cp->rx_config);
-
-	cpw32_f (MAR0 + 0, mc_filter[0]);
-	cpw32_f (MAR0 + 4, mc_filter[1]);
-}
-
-static void cp_set_rx_mode (struct net_device *dev)
-{
-	unsigned long flags;
-	struct cp_private *cp = netdev_priv(dev);
-
-	spin_lock_irqsave (&cp->lock, flags);
-	__cp_set_rx_mode(dev);
-	spin_unlock_irqrestore (&cp->lock, flags);
+	new_config.rx_mode = cp_rx_config | new_config.rx_mode;
+	update_snapshot(&new_config, struct cp_private);
 }
 
 static void __cp_get_stats(struct cp_private *cp)
@@ -1040,7 +1042,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, true);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1188,6 +1190,12 @@ static int cp_open (struct net_device *dev)
 	if (rc)
 		return rc;
 
+	cp->rx_config = kmalloc(sizeof(*cp->rx_config), GFP_KERNEL);
+	if (!cp->rx_config) {
+		rc = -ENOMEM;
+		goto err_out_rx_config;
+	}
+
 	napi_enable(&cp->napi);
 
 	cp_init_hw(cp);
@@ -1207,6 +1215,9 @@ static int cp_open (struct net_device *dev)
 err_out_hw:
 	napi_disable(&cp->napi);
 	cp_stop_hw(cp);
+	kfree(cp->rx_config);
+
+err_out_rx_config:
 	cp_free_rings(cp);
 	return rc;
 }
@@ -1227,6 +1238,8 @@ static int cp_close (struct net_device *dev)
 
 	cp_stop_hw(cp);
 
+	kfree(cp->rx_config);
+
 	spin_unlock_irqrestore(&cp->lock, flags);
 
 	free_irq(cp->pdev->irq, dev);
@@ -1262,7 +1275,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, false);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1870,6 +1883,7 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
 	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_write_rx_config    = cp_write_rx_config,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
-- 
2.47.3


