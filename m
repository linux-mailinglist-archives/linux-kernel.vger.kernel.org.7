Return-Path: <linux-kernel+bounces-896151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DEC4FC36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AB13AA68F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765632694A;
	Tue, 11 Nov 2025 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LDNY475t"
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A813A9C1F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894756; cv=none; b=XNfAv4wjgHrC8gMSKqbfp+mbFcH1vaqlB2MYbqvVWO2fgZAS3YYZMooqH2uRd37R6TSqsrZc7TW7931C50m+rY8XA0RKmpF2k2xUzKqjEweK15wP4nHGp2+wNPR0b1Jm6B+Nz7hg7eOJOuIbKZYrSWVRpzyUsZleGESY9I8J3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894756; c=relaxed/simple;
	bh=mrDZkwdQ14Mwae8MarBh0NSIneeIVWIw2Dx2Nr6IlDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W77qTb8WOx2PT1yUcJrGez74oImccpOx3YbUozyxlaTQYdnXWyCpQ9sqrvLrjDakbdOsl4JLFJSdj5zHfAS3gDG0Ia3QBDwHUFGrkYnKcofJJMEqMagBjyL/FaCzM+eKlknMKlDcxZFmrbklrRG+IjAeJPVFoyX+5DDx9Bp/7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LDNY475t; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-87c13813464so1838636d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894750; x=1763499550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyRmhC40tORy7magFBDMbFacme5UfcMblEolAfcxZG8=;
        b=wcN79kzzi9nevs1NcK7MAwY6fU98qDL/sr9Ey/ZzLA88AXW/f8+Ir23bwFRa/5b3UP
         H9iizjN/09jTS0/mVAG0LZD+nUYKFnDfwFgyTHnVeweNU0i/F/3e0eUE+f0T4Bj0VtqS
         /wVkaULcQA8yaNUN08t9BXe/wGm9M3xNaecZ2o/IXCI/1v7CtFcYTk/n5SiBygdPRq4p
         uD9ZlsOcew91K2fnvBsbdj3zJ7juWiL/lX8hj/v8mXy9dML12mQLpTnMrV4M0AV9oS3y
         Pque/aK5KHcPOroF/a++ljg5u8W/SWysQvGkMcKR8396JFr5U8oTmlC7qRVq9QTymshh
         FEZw==
X-Forwarded-Encrypted: i=1; AJvYcCWloEwTx92ddYKxyxhfrUz9PazaNYRa2MzBtMIlcSHmXGT5uI3EOw7xOAC88XFgRjcR5HRoQ0DQgGy021M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYQd3wJDBZQ2uutTc0GbQbhgAbTYV8sNYffnLgX8q8krbLoKd
	neoEATxeCGnLT0wA2f6VU/6efq+5w+0/sNji8jkIyudow0m0XLQVNJEIhStMD8hd6Q9084TcR+k
	jg94/1U2nj2A9ya14hfUNeN3MNBaVr6cmNxT7kvm/nC9y5KrKMYyTfpEM/fpjqJVR1OKND/pGdQ
	/zGO1klrST0jfmEYPB+8jDsGcDR9Qoy1dwzpYnoTU0qvna9IXEmNkCHolHm0YSd0iRNNUleqeMp
	494ZlEOgU0xgV5a8fQPlWQo/3Op
X-Gm-Gg: ASbGncuB9JHj4rDOH7RdP2FfQ2hE7rHCfBrCHiBkxK+hSxcgG2Lzh2TKoyu7TEyK5rV
	rUJ6Ig2aiijcFVmrmmw0c3WJpfalqGuoC3N4Utu6Oag1Kp1NzPKLFCWVHiS2iXcIxBEiUcB74dR
	UI32FVp7zyzNYwNtrUqLZZYfGsX3PXbx7haW2Qx2+0IQG8A7bvu/HWUz5GwgR1zr7pgrt93eDhK
	TQWJrePDsSASNfQ4iUPbT6Fe+OQWHFmEjaSke2Ctdlnr+aT6XbiQYQzj3dhit+KO2FHpxWlTRIS
	raGR4VNfYlW/J1aOrKC5Uv1K9n+lWc09HeLvTcm8oHWPRl3vEA19CDl1skem07T8sU5Jrm3SWas
	bnbAEzxEtnEvZXepl0/9c+P6+kk2CbRL9ZN0DiWQ7XwxIW53Le10nrUYON6mh2+/jPqfXNPBAIB
	TEMg70SVwtl3BZLFr/uM4jgpP3+DgDG/aY5FlyURlfoHk=
X-Google-Smtp-Source: AGHT+IGiZeA5gKKyZlHihNrwUZ8QgbH0o6psNQq1xG1KK+AGgUNupi6V0jXCD1sPBc2bwYCh9J0raIuO07zo
X-Received: by 2002:a05:6214:401b:b0:87f:fecf:17b2 with SMTP id 6a1803df08f44-88271a51ad8mr12855766d6.64.1762894749710;
        Tue, 11 Nov 2025 12:59:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88238992da2sm12571676d6.8.2025.11.11.12.59.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3437f0760daso426584a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894747; x=1763499547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyRmhC40tORy7magFBDMbFacme5UfcMblEolAfcxZG8=;
        b=LDNY475tYiv/8NssCEioU916lIBV+RB9lPBF2NVyK6kt6S+rgqgp7JEbPhvhcEHngt
         KBwjVvk+YoJigW1XK4gzECY4z12insTZtSf84Y3LcagDixqw/BNpH/mv7jNHuBJgt5X0
         D/q+sTnu2hfij/LFQiY/dThVZMXRsKKFvn6+0=
X-Forwarded-Encrypted: i=1; AJvYcCVptzbakGKDuM2XxkvksbwFqYTyUbM0V5jOdWsEWg5byFf6+y5ECpYn5f31KC+ClRj67uuwtiC4KC3BZGs=@vger.kernel.org
X-Received: by 2002:a17:90b:1fc7:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-343ddf0cf34mr670658a91.34.1762894747106;
        Tue, 11 Nov 2025 12:59:07 -0800 (PST)
X-Received: by 2002:a17:90b:1fc7:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-343ddf0cf34mr670643a91.34.1762894746765;
        Tue, 11 Nov 2025 12:59:06 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:06 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next 02/12] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Wed, 12 Nov 2025 02:27:52 +0530
Message-ID: <20251111205829.97579-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add rx-copybreak support in bnge_set_ring_params()

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 19 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  5 +++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 4172278900b..8785bf57d82 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/netdev_queues.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 
@@ -2313,7 +2314,6 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	rx_space = rx_size + ALIGN(NET_SKB_PAD, 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bn->rx_copy_thresh = BNGE_RX_COPY_THRESH;
 	ring_size = bn->rx_ring_size;
 	bn->rx_agg_ring_size = 0;
 	bn->rx_agg_nr_pages = 0;
@@ -2352,7 +2352,10 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 		bn->rx_agg_ring_size = agg_ring_size;
 		bn->rx_agg_ring_mask = (bn->rx_agg_nr_pages * RX_DESC_CNT) - 1;
 
-		rx_size = SKB_DATA_ALIGN(BNGE_RX_COPY_THRESH + NET_IP_ALIGN);
+		rx_size = max3(BNGE_DEFAULT_RX_COPYBREAK,
+			       bn->rx_copybreak,
+			       bn->netdev->cfg_pending->hds_thresh);
+		rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
 		rx_space = rx_size + NET_SKB_PAD +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	}
@@ -2385,6 +2388,17 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	bn->cp_ring_mask = bn->cp_bit - 1;
 }
 
+static void bnge_init_ring_params(struct bnge_net *bn)
+{
+	unsigned int rx_size;
+
+	bn->rx_copybreak = BNGE_DEFAULT_RX_COPYBREAK;
+	/* Try to fit 4 chunks into a 4k page */
+	rx_size = SZ_1K -
+		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -2474,6 +2488,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bn->rx_dir = DMA_FROM_DEVICE;
 
 	bnge_set_tpa_flags(bd);
+	bnge_init_ring_params(bn);
 	bnge_set_ring_params(bd);
 
 	bnge_init_l2_fltr_tbl(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 85c4f6f5371..b267f0b14c1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -136,7 +136,8 @@ struct bnge_ring_grp_info {
 	u16	nq_fw_ring_id;
 };
 
-#define BNGE_RX_COPY_THRESH     256
+#define BNGE_DEFAULT_RX_COPYBREAK	256
+#define BNGE_MAX_RX_COPYBREAK		1024
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
 		(NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)
@@ -187,7 +188,7 @@ struct bnge_net {
 	u32			rx_buf_size;
 	u32			rx_buf_use_size; /* usable size */
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	u16			rx_nr_pages;
-- 
2.47.3


