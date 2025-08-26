Return-Path: <linux-kernel+bounces-786533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C46B35B35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F293361B13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F997338F36;
	Tue, 26 Aug 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KQwEhgCl"
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C527A917
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207066; cv=none; b=peCMI8tzbJR02n3qQsnJFhHFIIR7r9CsidNMelJMMKhuItYCofCk9Xn7SUyKSMd+i+y59SXwFAfzZiQQ4/mF62LPOs3OkVri/x4HzxVc5DrvW8n7bfmaHUHCstiB4THLxaTdFB12rBw72aXEwnc39Dm5lQj/b4lBqfRrqFvZJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207066; c=relaxed/simple;
	bh=ZETj5ixQFUHgfBI4P0QKlFNjJp7SAE8bT487SS6x1nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5Z+h1SJi/mDhu0mxgjzZ5yCFH5eaKlBl5SgWFs7UoOLZAzZIq21Avj2qwhXSXl4kokDviWAtXpOFmsq59a2kmRX4RLvdVzE5ioVfoxrWmTraYB44gAonuoxOkMXN6ic2Q6R1Tkk1mGQxYX26ZbHn+ALT9xCoX/Cm4qhYmPs0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KQwEhgCl; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-70ba7aa131fso65791346d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207063; x=1756811863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXJtu9XQorKZxDausZvNtKDxqu5jbY/cRDnj/nI8CnQ=;
        b=idz+uD4Z08PtPc8CkP7Q/izRomHFAfBSEsRgRj/YQz8JEdPGwzDjUSmxUopfca1H93
         CfQ3pVqevB4Kjkj1e/Hy1b5MUIlok9V0H3JXw9ICYyr2CkiaVsev/0fcXJvDFAIWhg84
         eO8L9br1a7tMOTAgQFnhX91iDLfpkf8YSnqafetF/zUcM03/m8k58PGv8hnHyzAMUAGZ
         4mCYpMqRUqKnj6rqKIZEOYalZJ9dgmnjYM4h1Ed0aVZTQCsFeMhy9fuGFC9og+YP25Gu
         kW6kytXXhBxUArhBWAWVO7s9u3nFBnmYRhnH+tx9XdLKhOVxIKsXkybjeKjrP4dcdvPT
         Bo/w==
X-Forwarded-Encrypted: i=1; AJvYcCWSqrlj9YnjR6zCK/gqu3jIz3TiydVgX8PIJY991mgsjH5Rcp3iqe/CUrQPJ7xXqODbL4u3IkvpDVbW2vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuG/y8bd15NHIsT0yFn2K5i+4o7KMRCVYARQiP3s2Gt+tncqB0
	LBo+tKHFFTA1NGVny2xlu8uv/loyg5gd0pFpANoCavLnwBt3nJ5QvyPKIx9yMeWx72jtivt5nTR
	8t7EjGESnxnM3LAdYzuegDt2Sw4rr9amBtzK4zp+dV0ZG6/uSdbB3HWOq7ujKDNKqgPYNVUkuno
	4kaBRdIoYFUDJRgMYbC5pNf7xAWCzP2rUcHCrSZd4I7Yw5T68BwvrwfeBalCQIlryYO/na2keE6
	SCzZBMlELa+tE1LK9kvZyu9LCqi
X-Gm-Gg: ASbGncszh9YFTtPiKpbEDtaoN0xRAk1udqdn2b8AnoL+QVG+bfed1VgdeuGye64DSOV
	Ze9Up13d9Vu7c0pBRRfZfVWajubINO36juigZvEawsyMEcK/7oFytbmKAbx68PBYJUXEZBXExxK
	vbAzCTWBurl7Vf4g2Dx5Wev4BnitgmHawZDvvvLuNBMyuHbz2LIjvrA7HS5sIoVwDCZFzg8J0NW
	PZw3m5yAUv1fNWOCuRc0XftgiIoboSPD/Y4QcHQsWZpBODBnlUhRrE1t3YwkY4lKZdk3bqd5Ueb
	Oy3hsSm6LLdEQD7Z0E+arOSabXF98ybtjVTnBfUmplFtetsW2r5QPIaEFQhZCI/OUz0q7JgV8oR
	73t4tMtkX/8gvRB5EriicbtomN01Qzg==
X-Google-Smtp-Source: AGHT+IH1mWmWz7OOe9mFl5vh8eGUYd6XA6hJ329ePlP1PW6mktjR8G5WmsKii0jALkSkOirHG4medD2Y5J5O
X-Received: by 2002:a05:6214:2a89:b0:70d:b653:f4c7 with SMTP id 6a1803df08f44-70db653fe97mr108774976d6.63.1756207063366;
        Tue, 26 Aug 2025 04:17:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70da722ae99sm7308006d6.36.2025.08.26.04.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e55665b05so4736848b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207062; x=1756811862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXJtu9XQorKZxDausZvNtKDxqu5jbY/cRDnj/nI8CnQ=;
        b=KQwEhgClc4UPuPpKmJ5DvMRTTtChfTf9TA/y90yjonaq6I43Hu9qIlM90spc4d4o74
         roAH6ljssN/nZ5r+f8LTAHJGsdbVWNEGMTXYp/C1hQPTnNgEgBWcUYQ0EwlZllaM7O1/
         kqpTQTHM1J3mlaB218ZXXdd20WnANucRD28w4=
X-Forwarded-Encrypted: i=1; AJvYcCWkjvio3oGGYtvBAH77N41a20f3zH905CMFwnuiGHYm2WMm+Ld7GaUqVLvV5zmjWg+rdBz79njq5nsaBts=@vger.kernel.org
X-Received: by 2002:a05:6a00:2e18:b0:771:fc20:45e7 with SMTP id d2e1a72fcca58-771fc204c98mr1804329b3a.17.1756207062018;
        Tue, 26 Aug 2025 04:17:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e18:b0:771:fc20:45e7 with SMTP id d2e1a72fcca58-771fc204c98mr1804292b3a.17.1756207061545;
        Tue, 26 Aug 2025 04:17:41 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:40 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v4, net-next 4/9] bng_en: Initialise core resources
Date: Tue, 26 Aug 2025 16:44:07 +0000
Message-ID: <20250826164412.220565-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add initial settings to all core resources, such as
the RX, AGG, TX, CQ, and NQ rings, as well as the VNIC.
This will help enable these resources in future patches.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 216 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  48 ++++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
 3 files changed, 265 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 4f09c6aecb0d..be068ccda38a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -707,6 +707,204 @@ static irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static void bnge_init_nq_tree(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
+		struct bnge_ring_struct *ring = &nqr->ring_struct;
+
+		ring->fw_ring_id = INVALID_HW_RING_ID;
+		if (!nqr->cp_ring_arr)
+			continue;
+		for (j = 0; j < nqr->cp_ring_count; j++) {
+			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
+
+			ring = &cpr->ring_struct;
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
+static void bnge_init_rxbd_pages(struct bnge_ring_struct *ring, u32 type)
+{
+	struct rx_bd **rx_desc_ring;
+	u32 prod;
+	int i;
+
+	rx_desc_ring = (struct rx_bd **)ring->ring_mem.pg_arr;
+	for (i = 0, prod = 0; i < ring->ring_mem.nr_pages; i++) {
+		struct rx_bd *rxbd;
+		int j;
+
+		rxbd = rx_desc_ring[i];
+		if (!rxbd)
+			continue;
+
+		for (j = 0; j < RX_DESC_CNT; j++, rxbd++, prod++) {
+			rxbd->rx_bd_len_flags_type = cpu_to_le32(type);
+			rxbd->rx_bd_opaque = prod;
+		}
+	}
+}
+
+static void bnge_init_one_rx_ring_rxbd(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring;
+	u32 type;
+
+	type = (bn->rx_buf_use_size << RX_BD_LEN_SHIFT) |
+		RX_BD_TYPE_RX_PACKET_BD | RX_BD_FLAGS_EOP;
+
+	if (NET_IP_ALIGN == 2)
+		type |= RX_BD_FLAGS_SOP;
+
+	ring = &rxr->rx_ring_struct;
+	bnge_init_rxbd_pages(ring, type);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_init_one_rx_agg_ring_rxbd(struct bnge_net *bn,
+					   struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring;
+	u32 type;
+
+	ring = &rxr->rx_agg_ring_struct;
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	if (bnge_is_agg_reqd(bn->bd)) {
+		type = ((u32)BNGE_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
+
+		bnge_init_rxbd_pages(ring, type);
+	}
+}
+
+static int bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr;
+
+	rxr = &bn->rx_ring[ring_nr];
+	bnge_init_one_rx_ring_rxbd(bn, rxr);
+
+	netif_queue_set_napi(bn->netdev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
+	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
+
+	return 0;
+}
+
+static int bnge_init_rx_rings(struct bnge_net *bn)
+{
+	int i, rc = 0;
+
+#define BNGE_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
+#define BNGE_RX_DMA_OFFSET NET_SKB_PAD
+	bn->rx_offset = BNGE_RX_OFFSET;
+	bn->rx_dma_offset = BNGE_RX_DMA_OFFSET;
+
+	for (i = 0; i < bn->bd->rx_nr_rings; i++) {
+		rc = bnge_init_one_rx_ring(bn, i);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+static int bnge_init_tx_rings(struct bnge_net *bn)
+{
+	int i;
+
+	bn->tx_wake_thresh = max_t(int, bn->tx_ring_size / 2,
+				   BNGE_MIN_TX_DESC_CNT);
+
+	for (i = 0; i < bn->bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+		struct bnge_ring_struct *ring = &txr->tx_ring_struct;
+
+		ring->fw_ring_id = INVALID_HW_RING_ID;
+
+		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX,
+				     &txr->bnapi->napi);
+	}
+
+	return 0;
+}
+
+static int bnge_init_ring_grps(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	bn->grp_info = kcalloc(bd->nq_nr_rings,
+			       sizeof(struct bnge_ring_grp_info),
+			       GFP_KERNEL);
+	if (!bn->grp_info)
+		return -ENOMEM;
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
+		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;
+		bn->grp_info[i].rx_fw_ring_id = INVALID_HW_RING_ID;
+		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
+		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
+	}
+
+	return 0;
+}
+
+static void bnge_init_vnics(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic0 = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	int i;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		struct bnge_vnic_info *vnic = &bn->vnic_info[i];
+		int j;
+
+		vnic->fw_vnic_id = INVALID_HW_RING_ID;
+		vnic->vnic_id = i;
+		for (j = 0; j < BNGE_MAX_CTX_PER_VNIC; j++)
+			vnic->fw_rss_cos_lb_ctx[j] = INVALID_HW_RING_ID;
+
+		if (bn->vnic_info[i].rss_hash_key) {
+			if (i == BNGE_VNIC_DEFAULT) {
+				u8 *key = (void *)vnic->rss_hash_key;
+				int k;
+
+				if (!bn->rss_hash_key_valid &&
+				    !bn->rss_hash_key_updated) {
+					get_random_bytes(bn->rss_hash_key,
+							 HW_HASH_KEY_SIZE);
+					bn->rss_hash_key_updated = true;
+				}
+
+				memcpy(vnic->rss_hash_key, bn->rss_hash_key,
+				       HW_HASH_KEY_SIZE);
+
+				if (!bn->rss_hash_key_updated)
+					continue;
+
+				bn->rss_hash_key_updated = false;
+				bn->rss_hash_key_valid = true;
+
+				bn->toeplitz_prefix = 0;
+				for (k = 0; k < 8; k++) {
+					bn->toeplitz_prefix <<= 8;
+					bn->toeplitz_prefix |= key[k];
+				}
+			} else {
+				memcpy(vnic->rss_hash_key, vnic0->rss_hash_key,
+				       HW_HASH_KEY_SIZE);
+			}
+		}
+	}
+}
+
 static void bnge_setup_msix(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
@@ -871,6 +1069,17 @@ static void bnge_free_irq(struct bnge_net *bn)
 	}
 }
 
+static int bnge_init_nic(struct bnge_net *bn)
+{
+	bnge_init_nq_tree(bn);
+	bnge_init_rx_rings(bn);
+	bnge_init_tx_rings(bn);
+	bnge_init_ring_grps(bn);
+	bnge_init_vnics(bn);
+
+	return 0;
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -897,10 +1106,17 @@ static int bnge_open_core(struct bnge_net *bn)
 		goto err_del_napi;
 	}
 
+	rc = bnge_init_nic(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_init_nic err: %d\n", rc);
+		goto err_free_irq;
+	}
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 
 	return 0;
 
+err_free_irq:
+	bnge_free_irq(bn);
 err_del_napi:
 	bnge_del_napi(bn);
 	bnge_free_core(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 7c56786f5a71..234c0523547a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -118,6 +118,20 @@ struct bnge_sw_rx_agg_bd {
 	dma_addr_t		mapping;
 };
 
+#define HWRM_RING_ALLOC_TX	0x1
+#define HWRM_RING_ALLOC_RX	0x2
+#define HWRM_RING_ALLOC_AGG	0x4
+#define HWRM_RING_ALLOC_CMPL	0x8
+#define HWRM_RING_ALLOC_NQ	0x10
+
+struct bnge_ring_grp_info {
+	u16	fw_stats_ctx;
+	u16	fw_grp_id;
+	u16	rx_fw_ring_id;
+	u16	agg_fw_ring_id;
+	u16	nq_fw_ring_id;
+};
+
 #define BNGE_RX_COPY_THRESH     256
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
@@ -133,6 +147,28 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+/* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1. We need one extra
+ * BD because the first TX BD is always a long BD.
+ */
+#define BNGE_MIN_TX_DESC_CNT	(MAX_SKB_FRAGS + 2)
+
+#define RX_RING(bn, x)	(((x) & (bn)->rx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
+#define RX_AGG_RING(bn, x)	(((x) & (bn)->rx_agg_ring_mask) >>	\
+				 (BNGE_PAGE_SHIFT - 4))
+#define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
+
+#define TX_RING(bn, x)	(((x) & (bn)->tx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
+#define TX_IDX(x)	((x) & (TX_DESC_CNT - 1))
+
+#define CP_RING(x)	(((x) & ~(CP_DESC_CNT - 1)) >> (BNGE_PAGE_SHIFT - 4))
+#define CP_IDX(x)	((x) & (CP_DESC_CNT - 1))
+
+#define RING_RX(bn, idx)	((idx) & (bn)->rx_ring_mask)
+#define NEXT_RX(idx)		((idx) + 1)
+
+#define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
+#define NEXT_RX_AGG(idx)	((idx) + 1)
+
 #define BNGE_NQ_HDL_TYPE_RX	0x00
 #define BNGE_NQ_HDL_TYPE_TX	0x01
 
@@ -181,6 +217,14 @@ struct bnge_net {
 	struct bnge_vnic_info		*vnic_info;
 	int				nr_vnics;
 	int				total_irqs;
+
+	int			tx_wake_thresh;
+	u16			rx_offset;
+	u16			rx_dma_offset;
+
+	u8			rss_hash_key[HW_HASH_KEY_SIZE];
+	u8			rss_hash_key_valid:1;
+	u8			rss_hash_key_updated:1;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -309,6 +353,9 @@ struct bnge_napi {
 #define BNGE_MAX_UC_ADDRS	4
 
 struct bnge_vnic_info {
+	u16		fw_vnic_id;
+#define BNGE_MAX_CTX_PER_VNIC	8
+	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
 	__le16		*rss_table;
@@ -331,5 +378,6 @@ struct bnge_vnic_info {
 #define BNGE_VNIC_RSS_FLAG	1
 #define BNGE_VNIC_MCAST_FLAG	4
 #define BNGE_VNIC_UCAST_FLAG	8
+	u32		vnic_id;
 };
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 162a66c79830..0e7684e20714 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -184,6 +184,7 @@ struct bnge_ctx_mem_info {
 struct bnge_ring_struct {
 	struct bnge_ring_mem_info	ring_mem;
 
+	u16			fw_ring_id;
 	union {
 		u16		grp_idx;
 		u16		map_idx; /* Used by NQs */
-- 
2.47.3


