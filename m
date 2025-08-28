Return-Path: <linux-kernel+bounces-790039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D777B39E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DC718825B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BCA313E0D;
	Thu, 28 Aug 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lsv1tXuJ"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923C3148BE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387155; cv=none; b=nDn4a0Fq39Xplni66fOU++9J7/55cS5rGM49ZW86+icUvxV0feIbxzzMucfInfBJlZBRjZD3NzKhYtf9llTKXvvcNrYmmPUFywLWdBA1ar0tTducv72koMwY+L8Cw8+SvxLAbzPHSGDAEJqJ3zxy9NSZRSEmbjT+ka693z71oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387155; c=relaxed/simple;
	bh=jPWOcq0uY2jfcFrYcRuS+4QQlplzrAUzOuATeKRoPTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqM+zb3iNLPoyc2jYr1a5BtDJR3z7cCuiT+z5XULuHNZB1vwA5MShCVi4Fqk4hibHV0dMq6pZ6lohPB463bfmUqqdEzFy+PMeO7ymnQrCO6CV3mELPDO7y8VMXD6gdhVNmspsxzisqXfB6SQ2dgT/t1oc7ak96IM+8Jq+yp3fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Lsv1tXuJ; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2445826fd9dso11038685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387153; x=1756991953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5oKSPaVTNAuYRh1Yoa1ZYGXCZ+3rfY494xhNj48mzI=;
        b=ft7xTtJjLSsy2mBzb6No2o3+n5rhuDx0eXq3jUmh+kDEcLoBH7aSBqGXDMfevFfe6r
         pwi5bU2VPUhoT3IYfSnZQGHK2KL3cyn4XQHcwoV+Tlz6iU9H7T/sDY2V0wglQ6k7JKxm
         5fTtiQxukIZzGcKLOwvrFfB9o9DkhgS08kKQRCleSXbJhDTsZVuSHf7HAd5YieuJGDOu
         rr7sVG8gndqjH1vIlblb1GpKHEbPdi4kRi8INtiQZo07jZK1q+DMppfFqBUcUjHjGanJ
         r3yVLpkCB0XA9x0WltHhu+0AFaFCu7fqmgYA3EJggfHynDuTV+880TiPuw1/UY0viAsD
         WE/w==
X-Forwarded-Encrypted: i=1; AJvYcCVB17Okc/S8A719k4uQ4kOeRBxjbS99YgQI4Xn5XQdn7JxNNheb/CTUPi/Fir91qEQvpbh+DFGzEK9F1uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWeX9bzfDcT8xGdg37uysjqkj9LE8RDd68JYHj6p3DDuzN/Qz
	noupucP3jSEaM1ucU5AAzOFnW1t/FCqZKbFlj91yRaSFcZ1K3hrQCoARDG07g5nnnLJxKKB63BR
	zCe3QvcCW9W7/sSleqcSl2PVkWc/Tb3C52sdTLVczVwiHTIL1tFr/hs9YHuk121SzqgIfnyF2AY
	xugOQoUQVu1Ccaq2v4/lglEN4gYsCtn7lVvfT8Iy33kwV9JHsqjp5pOXIega4vMTchDJOMZs5dD
	L0sA9EEiojmO61at2h/ECmJXcnc
X-Gm-Gg: ASbGncsNblU8xDYuYVHOwee8Ve6FYKB9N7w03deTw+u7trPlN7tBJOJx3kDP7tlmQi6
	YUI7YQEZ/SAh7Enz82WYdN36e+qwqPYoqxL5ww3iVHzSA/B3pQAeUgvjeabJe77i06MIdZtFyyz
	Ns5HiRpwsED7hfiaepCvxWuqv09qronzIkZjmsNMHoGEus3W7fr+Sc7aAEqUW0B4It+sdSZIARz
	8l08vRKUCaYz7U8S/v+J+SNtqRj5qdHinJGceeU6vwEXOzxRv4KTwFYwTvCF5E3Ej+ar8LLyuoS
	o6fJKnrPWNDvu3NXmSvBbQ0f2o4yIxZDa3v2OpfpLvooqz44lu77JCQCxeXcOm8E2HAlYT/u9nY
	UiQj6idScyRIloqiUjd1e1s4thAU84ZghMcxXXxNje3Lus1QFzeyNAdV6yc8oYWnGTyfQzh4wkp
	PdVV9eGw==
X-Google-Smtp-Source: AGHT+IEMPvUsMaJsdUpnp9W9s3fzriUz2XiKYOcpZF7Jusoka7HATtBKR142WggwMf727PfRdAlUDw8hemE7
X-Received: by 2002:a17:903:384f:b0:246:2b29:71c7 with SMTP id d9443c01a7336-2462ee92ef2mr315509015ad.25.1756387153306;
        Thu, 28 Aug 2025 06:19:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-248f2f27cdbsm591755ad.37.2025.08.28.06.19.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:19:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458274406so18913985ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387152; x=1756991952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5oKSPaVTNAuYRh1Yoa1ZYGXCZ+3rfY494xhNj48mzI=;
        b=Lsv1tXuJ1wThrvB2S3CIkW2tZeSRy5im9EpDDAXVpg4sNrp6YEfD0eB+7Y5Xtzbdgm
         aqMGIfh0jpvGhVpGjL6uSmF3sLh7BhcKjdHl6Ezi8j/MzlvZI4REi1j3xehnXniV2DHU
         sXtV9r5Fr1TmOQk1OOVuRZXURAya7+fK2/XqU=
X-Forwarded-Encrypted: i=1; AJvYcCVRpzrpgbgXC5x0DHVTU1JZkWqoo+MBObr9+oyxdeXaD0TloAkXsnv1/7l9+FsMh/uigrABsWTpzBWxYNI=@vger.kernel.org
X-Received: by 2002:a17:902:c40c:b0:248:b5c1:dbb7 with SMTP id d9443c01a7336-248b5c1e790mr60928785ad.34.1756387151620;
        Thu, 28 Aug 2025 06:19:11 -0700 (PDT)
X-Received: by 2002:a17:902:c40c:b0:248:b5c1:dbb7 with SMTP id d9443c01a7336-248b5c1e790mr60928385ad.34.1756387151107;
        Thu, 28 Aug 2025 06:19:11 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:19:10 -0700 (PDT)
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
Subject: [v5, net-next 4/9] bng_en: Initialise core resources
Date: Thu, 28 Aug 2025 18:45:42 +0000
Message-ID: <20250828184547.242496-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
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
index 59357b89ac29..83419c986ebb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -706,6 +706,204 @@ static irqreturn_t bnge_msix(int irq, void *dev_instance)
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
@@ -870,6 +1068,17 @@ static void bnge_free_irq(struct bnge_net *bn)
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
@@ -896,10 +1105,17 @@ static int bnge_open_core(struct bnge_net *bn)
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


