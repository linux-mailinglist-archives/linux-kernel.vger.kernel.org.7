Return-Path: <linux-kernel+bounces-825056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A170EB8AD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263BF588D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC75327A06;
	Fri, 19 Sep 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="acLClCK6"
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCE327A0F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304132; cv=none; b=mVFoZ3wEz95vUvJIlnuf2Meg8Li4xK/YZImdGPup++EMiYV4tbPg9R1LLOn84DTzuO0UzSAZw4gbatSSzda6o2lznBCKtrwFpXPKFQf1Ug6R57J4mPC4lwf4aRD8yu687TGmDNy6qSSTEc4CNnUpobnrydMmnv6QryUCHfs8apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304132; c=relaxed/simple;
	bh=Bvsa44P5TyVrfE0QtAPtXnbUfjcSuyB8KosdicgP5F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn2at2C4TQ0E0JFFTQrrGAeH1KjxVVKwH6hCpJ+HObMYzIfgxieduyPAmmNse0fFEgyWT90S27KyHFky+K6R8gh8M2FrhuFM6M8NWRUU7UY3TNR+Alg+wM3wi7WRii9r9E+f76OoGnhDZTVAe5qXKY20shZhAbV0Hfs0Bko0ryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=acLClCK6; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-30ccec59b4bso1723439fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304129; x=1758908929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bn7TJKsAJbyeAqEEgCqe6vra+522uaYdimbrjAXEOfc=;
        b=kWzq9TsnBhkKZyaAN0cfYGQb8hgOOQcNiXx9IIQCjMGUkAvfR1w7iKDcDVDnYHLIJA
         h2EfoCjOBbmDRKG75/NmLV8jlIagPWEmuGFzq4EB2icVde5S6D9XaCVWxVuUwVjqfvVE
         2Pj+F3i2xVcCRPUvgvX0rOeDBmV+rTOvyYYmjxQf34/hDhc1kguJzG7ccfltNHmWVtSb
         G0dxbMR/ZDsYF6IodjlCGjFDm0g7FWRmivi6OCm6PpeM/LWtDBXGdkmZhh2ze2p+0oF5
         iO/dRQoF8/EAwLT0kSjvxn6B4Jp5xc6xgTOQrC+IWTqj6ViEktHOAPerFU5Y/ALEAGo8
         aMng==
X-Forwarded-Encrypted: i=1; AJvYcCXIhM+kfQepDbF73BzVCaCyLCtfdooSftyZPZXGUs9eRBJwSNVBBpAAHTZfeDtb5uqmHHRL7Wr/j4/vKJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQ75U5l+gnNhppdfS2h7AMGK9xJPzijMnTGUdPO1wwvewRsM5
	VV+zB4JDSCG+ddOeC39TAEmyX3KLc3G6N88qetwQzs4QRTSGS4AjVJsKviM3Trv7D3GBD3gubkt
	iyh1oS1UiZqk0rtMB3fjz7Hj/it5X31h74lfokwoKuWWni3ugg67ZvItB97LlpI14vuclMCyUq0
	dbelj0UfTAs7xJSkyk3LJATOVCcSQmgHuacF4XEG63G1wNaKVUqa46CExVVKlcLePPGGCR38cQQ
	TPlqXb9fJUp4iGEXQplyh3gSP26
X-Gm-Gg: ASbGncv+PBm9CC4Mlwu1HYdDFtout3N6Zh/r03Jm4fsV4dYprq0ETEyv+1W8JKWNWGh
	BCD+cR7qRaf3wJFHye4WDP03qi6bQDmyr4HZURecLfSw+N79Gl+Z3Pkl6SZVZOutBsjNsvGnODa
	r5nvD9pIG9X3GGRbvu/RuMYQgBgWxZ2xG3TO9g96u/E/jkijUi4nnUAws6GRzzwKGHJRaylAOYF
	wRC7QkSQ6B+CLcreo4pWhBP9FPVkERGghxfemVmVRzz6PjWcusAHyebq4t8ZkAzMYw9iJXMWfvl
	4BJmA60CkzxRBveudaEGNKJKOJTt4IqGtmReoQHzQXlBmggx6hOCPOoWMXoXdMOBHQmrQGzxGOy
	9JYsJ6Y/yiljY0JmWTbPaVJ/FwjSEAl9+UaSdqlF8kow8SB0fymiLgyQPhzOdNN0Pls5hZ0a+nf
	hhzMBdEVeH
X-Google-Smtp-Source: AGHT+IF9lC2R27L/xU/1hOiD3/ZVZllBcssUNn9YAXdXc1mZjQoslmEOBk2I+bEUhrMONejNc5dYpIsLcq/F
X-Received: by 2002:a05:6870:9a22:b0:316:8c45:3959 with SMTP id 586e51a60fabf-33bb3aa4f75mr1992919fac.7.1758304128680;
        Fri, 19 Sep 2025 10:48:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6eb0af3sm549231fac.25.2025.09.19.10.48.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77e5a77a25aso1586370b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304127; x=1758908927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn7TJKsAJbyeAqEEgCqe6vra+522uaYdimbrjAXEOfc=;
        b=acLClCK640ekBgJd1Ceb4r+BFdMIQSqABIGRKwurkqjR+xEPrYvUouQVOezPv5R2ea
         bJWJEfU4prE7cx7+YDkND3+KtlIPS8cTtHiGi3cg9cbDLvrD6a9zS05v7GNyrhJmh/gU
         jwGoB2/BuRiDMug1uMImaxapZ4EVVAV1ccsTc=
X-Forwarded-Encrypted: i=1; AJvYcCX+XfovwPfkkSFvx80vaOqMCzj2bsSH/1pQF3UPlfp+25H35DeuAUuIK5W5wkXS9zmCdERLn+H0G41bGEk=@vger.kernel.org
X-Received: by 2002:a05:6a21:999a:b0:245:ff00:5332 with SMTP id adf61e73a8af0-2925991ad72mr6183449637.7.1758304126813;
        Fri, 19 Sep 2025 10:48:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:999a:b0:245:ff00:5332 with SMTP id adf61e73a8af0-2925991ad72mr6183422637.7.1758304126348;
        Fri, 19 Sep 2025 10:48:46 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:45 -0700 (PDT)
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
Subject: [v8, net-next 08/10] bng_en: Register rings with the firmware
Date: Fri, 19 Sep 2025 23:17:39 +0530
Message-ID: <20250919174742.24969-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Enable ring functionality by registering RX, AGG, TX, CMPL, and
NQ rings with the firmware. Initialise the doorbells associated
with the rings.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  24 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   4 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h  |  34 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 147 ++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   6 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 349 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  16 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
 8 files changed, 581 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index c536c0cc66e..aee65a6c980 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -102,6 +102,10 @@ struct bnge_dev {
 	u16		chip_num;
 	u8		chip_rev;
 
+#if BITS_PER_LONG == 32
+	/* ensure atomic 64-bit doorbell writes on 32-bit systems. */
+	spinlock_t	db_lock;
+#endif
 	int		db_offset; /* db_offset within db_size */
 	int		db_size;
 
@@ -214,6 +218,26 @@ static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 	return true;
 }
 
+static inline void bnge_writeq(struct bnge_dev *bd, u64 val,
+			       void __iomem *addr)
+{
+#if BITS_PER_LONG == 32
+	spin_lock(&bd->db_lock);
+	lo_hi_writeq(val, addr);
+	spin_unlock(&bd->db_lock);
+#else
+	writeq(val, addr);
+#endif
+}
+
+/* For TX and RX ring doorbells */
+static inline void bnge_db_write(struct bnge_dev *bd, struct bnge_db_info *db,
+				 u32 idx)
+{
+	bnge_writeq(bd, db->db_key64 | DB_RING_IDX(db, idx),
+		    db->doorbell);
+}
+
 bool bnge_aux_registered(struct bnge_dev *bd);
 u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 68da656f289..304b1e4d5a0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -296,6 +296,10 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_config_uninit;
 	}
 
+#if BITS_PER_LONG == 32
+	spin_lock_init(&bd->db_lock);
+#endif
+
 	rc = bnge_alloc_irqs(bd);
 	if (rc) {
 		dev_err(&pdev->dev, "Error IRQ allocation rc = %d\n", rc);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_db.h b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
new file mode 100644
index 00000000000..950ed582f1d
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_DB_H_
+#define _BNGE_DB_H_
+
+/* 64-bit doorbell */
+#define DBR_EPOCH_SFT					24
+#define DBR_TOGGLE_SFT					25
+#define DBR_XID_SFT					32
+#define DBR_PATH_L2					(0x1ULL << 56)
+#define DBR_VALID					(0x1ULL << 58)
+#define DBR_TYPE_SQ					(0x0ULL << 60)
+#define DBR_TYPE_SRQ					(0x2ULL << 60)
+#define DBR_TYPE_CQ					(0x4ULL << 60)
+#define DBR_TYPE_CQ_ARMALL				(0x6ULL << 60)
+#define DBR_TYPE_NQ					(0xaULL << 60)
+#define DBR_TYPE_NQ_ARM					(0xbULL << 60)
+#define DBR_TYPE_NQ_MASK				(0xeULL << 60)
+
+struct bnge_db_info {
+	void __iomem		*doorbell;
+	u64			db_key64;
+	u32			db_ring_mask;
+	u32			db_epoch_mask;
+	u8			db_epoch_shift;
+};
+
+#define DB_EPOCH(db, idx)	(((idx) & (db)->db_epoch_mask) <<	\
+				 ((db)->db_epoch_shift))
+#define DB_RING_IDX(db, idx)	(((idx) & (db)->db_ring_mask) |		\
+				 DB_EPOCH(db, idx))
+
+#endif /* _BNGE_DB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 8f20b880c11..b44e0f4ed7c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -757,3 +757,150 @@ int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn)
 	bnge_hwrm_req_drop(bd, req);
 	return rc;
 }
+
+int hwrm_ring_free_send_msg(struct bnge_net *bn,
+			    struct bnge_ring_struct *ring,
+			    u32 ring_type, int cmpl_ring_id)
+{
+	struct hwrm_ring_free_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_RING_FREE);
+	if (rc)
+		goto exit;
+
+	req->cmpl_ring = cpu_to_le16(cmpl_ring_id);
+	req->ring_type = ring_type;
+	req->ring_id = cpu_to_le16(ring->fw_ring_id);
+
+	bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	bnge_hwrm_req_drop(bd, req);
+exit:
+	if (rc) {
+		netdev_err(bd->netdev, "hwrm_ring_free type %d failed. rc:%d\n", ring_type, rc);
+		return -EIO;
+	}
+	return 0;
+}
+
+int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
+			     struct bnge_ring_struct *ring,
+			     u32 ring_type, u32 map_index)
+{
+	struct bnge_ring_mem_info *rmem = &ring->ring_mem;
+	struct bnge_ring_grp_info *grp_info;
+	struct hwrm_ring_alloc_output *resp;
+	struct hwrm_ring_alloc_input *req;
+	struct bnge_dev *bd = bn->bd;
+	u16 ring_id, flags = 0;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_RING_ALLOC);
+	if (rc)
+		goto exit;
+
+	req->enables = 0;
+	if (rmem->nr_pages > 1) {
+		req->page_tbl_addr = cpu_to_le64(rmem->dma_pg_tbl);
+		/* Page size is in log2 units */
+		req->page_size = BNGE_PAGE_SHIFT;
+		req->page_tbl_depth = 1;
+	} else {
+		req->page_tbl_addr =  cpu_to_le64(rmem->dma_arr[0]);
+	}
+	req->fbo = 0;
+	/* Association of ring index with doorbell index and MSIX number */
+	req->logical_id = cpu_to_le16(map_index);
+
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX: {
+		struct bnge_tx_ring_info *txr;
+
+		txr = container_of(ring, struct bnge_tx_ring_info,
+				   tx_ring_struct);
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_TX;
+		/* Association of transmit ring with completion ring */
+		grp_info = &bn->grp_info[ring->grp_idx];
+		req->cmpl_ring_id = cpu_to_le16(bnge_cp_ring_for_tx(txr));
+		req->length = cpu_to_le32(bn->tx_ring_mask + 1);
+		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+		req->queue_id = cpu_to_le16(ring->queue_id);
+		req->flags = cpu_to_le16(flags);
+		break;
+	}
+	case HWRM_RING_ALLOC_RX:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
+		req->length = cpu_to_le32(bn->rx_ring_mask + 1);
+
+		/* Association of rx ring with stats context */
+		grp_info = &bn->grp_info[ring->grp_idx];
+		req->rx_buf_size = cpu_to_le16(bn->rx_buf_use_size);
+		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+		req->enables |=
+			cpu_to_le32(RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
+		if (NET_IP_ALIGN == 2)
+			flags = RING_ALLOC_REQ_FLAGS_RX_SOP_PAD;
+		req->flags = cpu_to_le16(flags);
+		break;
+	case HWRM_RING_ALLOC_AGG:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
+		/* Association of agg ring with rx ring */
+		grp_info = &bn->grp_info[ring->grp_idx];
+		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
+		req->rx_buf_size = cpu_to_le16(BNGE_RX_PAGE_SIZE);
+		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+		req->enables |=
+			cpu_to_le32(RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID |
+				    RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
+		req->length = cpu_to_le32(bn->rx_agg_ring_mask + 1);
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
+		req->length = cpu_to_le32(bn->cp_ring_mask + 1);
+		/* Association of cp ring with nq */
+		grp_info = &bn->grp_info[map_index];
+		req->nq_ring_id = cpu_to_le16(grp_info->nq_fw_ring_id);
+		req->cq_handle = cpu_to_le64(ring->handle);
+		req->enables |=
+			cpu_to_le32(RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID);
+		break;
+	case HWRM_RING_ALLOC_NQ:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_NQ;
+		req->length = cpu_to_le32(bn->cp_ring_mask + 1);
+		req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+		break;
+	default:
+		netdev_err(bn->netdev, "hwrm alloc invalid ring type %d\n", ring_type);
+		return -EINVAL;
+	}
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	ring_id = le16_to_cpu(resp->ring_id);
+	bnge_hwrm_req_drop(bd, req);
+
+exit:
+	if (rc) {
+		netdev_err(bd->netdev, "hwrm_ring_alloc type %d failed. rc:%d\n", ring_type, rc);
+		return -EIO;
+	}
+	ring->fw_ring_id = ring_id;
+	return rc;
+}
+
+int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx)
+{
+	struct hwrm_func_cfg_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_CFG);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	req->enables = cpu_to_le32(FUNC_CFG_REQ_ENABLES_ASYNC_EVENT_CR);
+	req->async_event_cr = cpu_to_le16(idx);
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 1c3fd02d7e0..b2e2ec47be2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -26,4 +26,10 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
 int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
+int hwrm_ring_free_send_msg(struct bnge_net *bn, struct bnge_ring_struct *ring,
+			    u32 ring_type, int cmpl_ring_id);
+int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
+			     struct bnge_ring_struct *ring,
+			     u32 ring_type, u32 map_index);
+int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9f1deb60dd2..af9e25f0384 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -846,6 +846,28 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	return rc;
 }
 
+u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
+{
+	return rxr->rx_cpr->ring_struct.fw_ring_id;
+}
+
+u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
+{
+	return txr->tx_cpr->ring_struct.fw_ring_id;
+}
+
+static void bnge_db_nq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_MASK |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
+static void bnge_db_cq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_CQ_ARMALL |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
 static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
 {
 	struct bnge_napi *bnapi = bn->bnapi[n];
@@ -1227,6 +1249,326 @@ static void bnge_init_vnics(struct bnge_net *bn)
 	}
 }
 
+static void bnge_set_db_mask(struct bnge_net *bn, struct bnge_db_info *db,
+			     u32 ring_type)
+{
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX:
+		db->db_ring_mask = bn->tx_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_RX:
+		db->db_ring_mask = bn->rx_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_AGG:
+		db->db_ring_mask = bn->rx_agg_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+	case HWRM_RING_ALLOC_NQ:
+		db->db_ring_mask = bn->cp_ring_mask;
+		break;
+	}
+	db->db_epoch_mask = db->db_ring_mask + 1;
+	db->db_epoch_shift = DBR_EPOCH_SFT - ilog2(db->db_epoch_mask);
+}
+
+static void bnge_set_db(struct bnge_net *bn, struct bnge_db_info *db,
+			u32 ring_type, u32 map_idx, u32 xid)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX:
+		db->db_key64 = DBR_PATH_L2 | DBR_TYPE_SQ;
+		break;
+	case HWRM_RING_ALLOC_RX:
+	case HWRM_RING_ALLOC_AGG:
+		db->db_key64 = DBR_PATH_L2 | DBR_TYPE_SRQ;
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+		db->db_key64 = DBR_PATH_L2;
+		break;
+	case HWRM_RING_ALLOC_NQ:
+		db->db_key64 = DBR_PATH_L2;
+		break;
+	}
+	db->db_key64 |= ((u64)xid << DBR_XID_SFT) | DBR_VALID;
+
+	db->doorbell = bd->bar1 + bd->db_offset;
+	bnge_set_db_mask(bn, db, ring_type);
+}
+
+static int bnge_hwrm_cp_ring_alloc(struct bnge_net *bn,
+				   struct bnge_cp_ring_info *cpr)
+{
+	const u32 type = HWRM_RING_ALLOC_CMPL;
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct bnge_ring_struct *ring;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	ring = &cpr->ring_struct;
+	ring->handle = BNGE_SET_NQ_HDL(cpr);
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
+	bnge_db_cq(bn, &cpr->cp_db, cpr->cp_raw_cons);
+
+	return 0;
+}
+
+static int bnge_hwrm_tx_ring_alloc(struct bnge_net *bn,
+				   struct bnge_tx_ring_info *txr, u32 tx_idx)
+{
+	struct bnge_ring_struct *ring = &txr->tx_ring_struct;
+	const u32 type = HWRM_RING_ALLOC_TX;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, tx_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
+
+	return 0;
+}
+
+static int bnge_hwrm_rx_agg_ring_alloc(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_agg_ring_struct;
+	u32 type = HWRM_RING_ALLOC_AGG;
+	struct bnge_dev *bd = bn->bd;
+	u32 grp_idx = ring->grp_idx;
+	u32 map_idx;
+	int rc;
+
+	map_idx = grp_idx + bd->rx_nr_rings;
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &rxr->rx_agg_db, type, map_idx,
+		    ring->fw_ring_id);
+	bnge_db_write(bn->bd, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
+	bn->grp_info[grp_idx].agg_fw_ring_id = ring->fw_ring_id;
+
+	return 0;
+}
+
+static int bnge_hwrm_rx_ring_alloc(struct bnge_net *bn,
+				   struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_ring_struct;
+	struct bnge_napi *bnapi = rxr->bnapi;
+	u32 type = HWRM_RING_ALLOC_RX;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &rxr->rx_db, type, map_idx, ring->fw_ring_id);
+	bn->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
+
+	return 0;
+}
+
+static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	bool agg_rings;
+	int i, rc = 0;
+
+	agg_rings = !!(bnge_is_agg_reqd(bd));
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		struct bnge_ring_struct *ring = &nqr->ring_struct;
+		u32 type = HWRM_RING_ALLOC_NQ;
+		u32 map_idx = ring->map_idx;
+		unsigned int vector;
+
+		vector = bd->irq_tbl[map_idx].vector;
+		disable_irq_nosync(vector);
+		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+		if (rc) {
+			enable_irq(vector);
+			goto err_out;
+		}
+		bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
+		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+		enable_irq(vector);
+		bn->grp_info[i].nq_fw_ring_id = ring->fw_ring_id;
+
+		if (!i) {
+			rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
+			if (rc)
+				netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
+		}
+	}
+
+	for (i = 0; i < bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+
+		rc = bnge_hwrm_cp_ring_alloc(bn, txr->tx_cpr);
+		if (rc)
+			goto err_out;
+		rc = bnge_hwrm_tx_ring_alloc(bn, txr, i);
+		if (rc)
+			goto err_out;
+	}
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+		struct bnge_cp_ring_info *cpr;
+		struct bnge_ring_struct *ring;
+		struct bnge_napi *bnapi;
+		u32 map_idx, type;
+
+		rc = bnge_hwrm_rx_ring_alloc(bn, rxr);
+		if (rc)
+			goto err_out;
+		/* If we have agg rings, post agg buffers first. */
+		if (!agg_rings)
+			bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
+
+		cpr = rxr->rx_cpr;
+		bnapi = rxr->bnapi;
+		type = HWRM_RING_ALLOC_CMPL;
+		map_idx = bnapi->index;
+
+		ring = &cpr->ring_struct;
+		ring->handle = BNGE_SET_NQ_HDL(cpr);
+		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+		if (rc)
+			goto err_out;
+		bnge_set_db(bn, &cpr->cp_db, type, map_idx,
+			    ring->fw_ring_id);
+		bnge_db_cq(bn, &cpr->cp_db, cpr->cp_raw_cons);
+	}
+
+	if (agg_rings) {
+		for (i = 0; i < bd->rx_nr_rings; i++) {
+			rc = bnge_hwrm_rx_agg_ring_alloc(bn, &bn->rx_ring[i]);
+			if (rc)
+				goto err_out;
+		}
+	}
+err_out:
+	return rc;
+}
+
+static void bnge_hwrm_rx_ring_free(struct bnge_net *bn,
+				   struct bnge_rx_ring_info *rxr,
+				   bool close_path)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_ring_struct;
+	u32 grp_idx = rxr->bnapi->index;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = bnge_cp_ring_for_rx(rxr);
+	hwrm_ring_free_send_msg(bn, ring,
+				RING_FREE_REQ_RING_TYPE_RX,
+				close_path ? cmpl_ring_id :
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bn->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_rx_agg_ring_free(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr,
+				       bool close_path)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_agg_ring_struct;
+	u32 grp_idx = rxr->bnapi->index;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = bnge_cp_ring_for_rx(rxr);
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_RX_AGG,
+				close_path ? cmpl_ring_id :
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bn->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_tx_ring_free(struct bnge_net *bn,
+				   struct bnge_tx_ring_info *txr,
+				   bool close_path)
+{
+	struct bnge_ring_struct *ring = &txr->tx_ring_struct;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = close_path ? bnge_cp_ring_for_tx(txr) :
+		       INVALID_HW_RING_ID;
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_TX,
+				cmpl_ring_id);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_cp_ring_free(struct bnge_net *bn,
+				   struct bnge_cp_ring_info *cpr)
+{
+	struct bnge_ring_struct *ring;
+
+	ring = &cpr->ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->tx_nr_rings; i++)
+		bnge_hwrm_tx_ring_free(bn, &bn->tx_ring[i], close_path);
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		bnge_hwrm_rx_ring_free(bn, &bn->rx_ring[i], close_path);
+		bnge_hwrm_rx_agg_ring_free(bn, &bn->rx_ring[i], close_path);
+	}
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_ring_struct *ring;
+		int j;
+
+		nqr = &bnapi->nq_ring;
+		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
+			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
+
+		ring = &nqr->ring_struct;
+		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
+			hwrm_ring_free_send_msg(bn, ring,
+						RING_FREE_REQ_RING_TYPE_NQ,
+						INVALID_HW_RING_ID);
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+			bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
 static void bnge_setup_msix(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
@@ -1263,6 +1605,7 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 {
+	bnge_hwrm_ring_free(bn, close_path);
 	bnge_hwrm_stat_ctx_free(bn);
 }
 
@@ -1345,6 +1688,12 @@ static int bnge_init_chip(struct bnge_net *bn)
 		netdev_err(bn->netdev, "hwrm stat ctx alloc failure rc: %d\n", rc);
 		goto err_out;
 	}
+
+	rc = bnge_hwrm_ring_alloc(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm ring alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
 	return 0;
 
 err_out:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 55497c4e7fb..a5d6b808d75 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -5,6 +5,8 @@
 #define _BNGE_NETDEV_H_
 
 #include <linux/bnxt/hsi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include "bnge_db.h"
 
 struct tx_bd {
 	__le32 tx_bd_len_flags_type;
@@ -169,6 +171,7 @@ enum {
 #define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
 #define NEXT_RX_AGG(idx)	((idx) + 1)
 
+#define BNGE_NQ_HDL_TYPE_SHIFT	24
 #define BNGE_NQ_HDL_TYPE_RX	0x00
 #define BNGE_NQ_HDL_TYPE_TX	0x01
 
@@ -272,6 +275,9 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
 	     (bnapi)->tx_ring[++iter] : NULL)
 
+#define BNGE_SET_NQ_HDL(cpr)						\
+	(((cpr)->cp_ring_type << BNGE_NQ_HDL_TYPE_SHIFT) | (cpr)->cp_idx)
+
 struct bnge_stats_mem {
 	u64		*sw_stats;
 	u64		*hw_masks;
@@ -287,6 +293,8 @@ struct bnge_cp_ring_info {
 	struct bnge_ring_struct	ring_struct;
 	u8			cp_ring_type;
 	u8			cp_idx;
+	u32			cp_raw_cons;
+	struct bnge_db_info	cp_db;
 };
 
 struct bnge_nq_ring_info {
@@ -294,6 +302,8 @@ struct bnge_nq_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct nqe_cn		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+	u32			nq_raw_cons;
+	struct bnge_db_info	nq_db;
 
 	struct bnge_stats_mem	stats;
 	u32			hw_stats_ctx_id;
@@ -309,6 +319,8 @@ struct bnge_rx_ring_info {
 	u16			rx_agg_prod;
 	u16			rx_sw_agg_prod;
 	u16			rx_next_cons;
+	struct bnge_db_info	rx_db;
+	struct bnge_db_info	rx_agg_db;
 
 	struct rx_bd		*rx_desc_ring[MAX_RX_PAGES];
 	struct bnge_sw_rx_bd	*rx_buf_ring;
@@ -338,6 +350,7 @@ struct bnge_tx_ring_info {
 	u16			txq_index;
 	u8			tx_napi_idx;
 	u8			kick_pending;
+	struct bnge_db_info	tx_db;
 
 	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
 	struct bnge_sw_tx_bd	*tx_buf_ring;
@@ -392,4 +405,7 @@ struct bnge_vnic_info {
 #define BNGE_VNIC_UCAST_FLAG	8
 	u32		vnic_id;
 };
+
+u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
+u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 0e7684e2071..341c7f81ed0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -189,6 +189,7 @@ struct bnge_ring_struct {
 		u16		grp_idx;
 		u16		map_idx; /* Used by NQs */
 	};
+	u32			handle;
 	u8			queue_id;
 };
 
-- 
2.47.3


