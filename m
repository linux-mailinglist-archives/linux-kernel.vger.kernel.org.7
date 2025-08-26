Return-Path: <linux-kernel+bounces-786535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D14B35B31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992E81BA0A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22218341653;
	Tue, 26 Aug 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FPJd8+PM"
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714EF340D9E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207076; cv=none; b=co/qQk+zp3yf7KLJVJlo2Q0MWDz7rB8tohLG2VyLIPF5be4Z/HBB/Q7+4PiAkefKC8XxQH+9ntF7gQoUssFhlBSpCdudLAjnuPr4/lhQhdAXRhRJ8wtdwXeAdvDufBZGhaBGi3ZlNsfNU7fd1zMH6dSuiQn/7rxot6fkOAebSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207076; c=relaxed/simple;
	bh=hmZvhkHx+iZBY27BCwzqmNwOGpyLHcDxgnPDKeAdyYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NujW49vUIhRd+t1JqFU+c1j2T7Y/XKQrc1W8r7a/wzzKubXc8UkQI/xtOaNb0DO0Pw3H1uSnp9NmTb7yAHLlgvepx/KukppodCJ48fuBiKvvxWiwDWOL5vV2i3/DTpREwUNYo4NtUl1BSjwHnqA4OfgsUkSmPN/NKuUfrwRVi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FPJd8+PM; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e951bdb16f4so3381135276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207073; x=1756811873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNqiJ07/2anwKGOlDdgP4ThD6rU82LVNPOZWylugZQc=;
        b=p4+7vVjbYMY4GjwbJ4ZJDTC8ro3PlmyIHivzlxPfwssRdmWqhG6apcimajYRARVEQH
         8EzHNZXKYbysSeBoTB/MvTTKUdw+KUP9Va58IJQdhhUnEtf6ZgEvNMvg2LQzvAm3ea2B
         IKKbBbys0ao+0nn5/gIeX8hpOTryjQKkhA30kyG1dQVtjku5hDsIgmc9pYpWb1HzYVEm
         YoEmnnb6E7a6GNt5uF1I27eQrNNPx7Ydh/8752zhvSkLXpfyYue+s38k2DcJIlqnsp8a
         Cf9HHTjRzaxztUloTzCYhLwmTs0jSkNITIWDpxm3FgEHrJFAd0t2gyEVTWIQOTnWXIaV
         aePg==
X-Forwarded-Encrypted: i=1; AJvYcCX8KUzbx3J0mndqwXjkKAh1ZyU2fOpJJRsTKuM7GWac6ihim1Mw7zrm7dlnNytllxgCZCjzoeYV0pQLY2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3H/b1gmWNRAv71a7dBAPLgVfbnyhMJXPMe91uLqBxaUgFhIy
	+NRaZj9NJUejOrI/9Nkjm//Hly6/6v5IDiMQ7+WMWSz8YAJcvoSWLLnKa0BYw6f4jLRjSwCze1i
	2uTIANs/xBl1uOug7RxhjYxxaQ0Gn3ouGmrdLiwmT5WvCQULIbwHX4sxtMxS8WqTkaFt1SuylIS
	J9bG07A6D5NKKrLP0BE5+lUpb1OIRX27EG7GrC+eGB8oPt+Sp059suN7NfSLo2S+3xZtFZI1QFk
	45XwpnhuA+SEu3fwAWAanKcUsNa
X-Gm-Gg: ASbGncu8nYuZV6dqmTpKNotdMrAP9xtn76OsjwFoJRBozNpj5ShmHVvlwu/8Pv65dv9
	7oF2ojhCAIsRuVK7NFlmVcdLVARo6YFLS+gZ7ZtbjEv9p5A8aJH8lHEV0456G5i/LDedw5WFyql
	Jny1T96k7EZc0yvNaXs3wCYNmAe7tWUDYsh/Tf0XyuA6zdptUvrTgoiTFRDG2/V02q8p9ef5f1k
	HuLS9OTCtvGfcZ0HiESET/ICUWZvYm9XmsJ5LIBAZkCWsz5hXFMaAhs9U7GLqrElcKE08WL3aaD
	f73ZvF/PhHbfjw6HOgK/FebTK++C2aDVQuWzZzorclHPUZTebrtdUG4g27AUY/Isc4SP3UWN334
	K9D2mM3bwE3QNth5vAt+NtVuXZ5qU3Ar6nsKkPpCpmsnOcuv4JOW7+oa4HEhga3K0GoXF5cOklw
	DjwEkgMg==
X-Google-Smtp-Source: AGHT+IHri2itjlNTpbN+oDpANrmElNvtjYHJCWCj1n4fR/DLp+pFeBbDMHuDahzkEwJdJcEWPcApIMZZuVjJ
X-Received: by 2002:a05:6902:1029:b0:e96:d443:5884 with SMTP id 3f1490d57ef6-e96d44371e7mr4298429276.41.1756207073070;
        Tue, 26 Aug 2025 04:17:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e952c273855sm723579276.2.2025.08.26.04.17.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-770562b1ed3so4262736b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207072; x=1756811872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNqiJ07/2anwKGOlDdgP4ThD6rU82LVNPOZWylugZQc=;
        b=FPJd8+PM905C2QIaUzFYDdTKKzO/bmzwOyw3e/lGIyiZx7YlTe7UWu5gbRQVZ1P+7+
         MJsFd6IWR6w3VToivn9bhQ6Bi/GIIuJD6T+Zjg7z03P6CSpP23MOBqja91tRSrtpp/ZN
         WwFnIJ7jskVf6vUBHDaBZSDiNJRmZTf+kW7yI=
X-Forwarded-Encrypted: i=1; AJvYcCXvmIq2UpV1FUP0FtbbPH05Rfa6svzsEZXfCgY7ClakEPIY5iuMyLAWmws5s3OUFp73Rh3QeWsdYLaTzGU=@vger.kernel.org
X-Received: by 2002:a05:6a00:2e97:b0:770:3e01:d4b9 with SMTP id d2e1a72fcca58-7703e01d84emr16591151b3a.24.1756207071676;
        Tue, 26 Aug 2025 04:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e97:b0:770:3e01:d4b9 with SMTP id d2e1a72fcca58-7703e01d84emr16591111b3a.24.1756207071165;
        Tue, 26 Aug 2025 04:17:51 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:50 -0700 (PDT)
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
Subject: [v4, net-next 6/9] bng_en: Allocate stat contexts
Date: Tue, 26 Aug 2025 16:44:09 +0000
Message-ID: <20250826164412.220565-7-bhargava.marreddy@broadcom.com>
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

Allocate the hardware statistics context with the firmware and
register DMA memory required for ring statistics. This helps the
driver to collect ring statistics provided by the firmware.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 59 +++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 97 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 12 +++
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 6992066690bd..d77ea5536e7c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -701,3 +701,62 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
 	bnge_hwrm_req_drop(bd, req);
 	return rc;
 }
+
+void bnge_hwrm_stat_ctx_free(struct bnge_net *bn)
+{
+	struct hwrm_stat_ctx_free_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	if (bnge_hwrm_req_init(bd, req, HWRM_STAT_CTX_FREE))
+		return;
+
+	bnge_hwrm_req_hold(bd, req);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		if (nqr->hw_stats_ctx_id != INVALID_STATS_CTX_ID) {
+			req->stat_ctx_id = cpu_to_le32(nqr->hw_stats_ctx_id);
+			bnge_hwrm_req_send(bd, req);
+
+			nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
+		}
+	}
+	bnge_hwrm_req_drop(bd, req);
+}
+
+int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn)
+{
+	struct hwrm_stat_ctx_alloc_output *resp;
+	struct hwrm_stat_ctx_alloc_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc, i;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_STAT_CTX_ALLOC);
+	if (rc)
+		return rc;
+
+	req->stats_dma_length = cpu_to_le16(bd->hw_ring_stats_size);
+	req->update_period_ms = cpu_to_le32(bn->stats_coal_ticks / 1000);
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		req->stats_dma_addr = cpu_to_le64(nqr->stats.hw_stats_map);
+
+		rc = bnge_hwrm_req_send(bd, req);
+		if (rc)
+			break;
+
+		nqr->hw_stats_ctx_id = le32_to_cpu(resp->stat_ctx_id);
+		bn->grp_info[i].fw_stats_ctx = nqr->hw_stats_ctx_id;
+	}
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 6c03923eb559..1c3fd02d7e0a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -24,4 +24,6 @@ int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
 int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
+void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
+int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 7dae3ebfd88d..e827c1ea9226 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -30,6 +30,70 @@
 #define BNGE_TC_TO_RING_BASE(bd, tc)	\
 	((tc) * (bd)->tx_nr_rings_per_tc)
 
+static void bnge_free_stats_mem(struct bnge_net *bn,
+				struct bnge_stats_mem *stats)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	if (stats->hw_stats) {
+		dma_free_coherent(bd->dev, stats->len, stats->hw_stats,
+				  stats->hw_stats_map);
+		stats->hw_stats = NULL;
+	}
+}
+
+static int bnge_alloc_stats_mem(struct bnge_net *bn,
+				struct bnge_stats_mem *stats)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	stats->hw_stats = dma_alloc_coherent(bd->dev, stats->len,
+					     &stats->hw_stats_map, GFP_KERNEL);
+	if (!stats->hw_stats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void bnge_free_ring_stats(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		bnge_free_stats_mem(bn, &nqr->stats);
+	}
+}
+
+static int bnge_alloc_ring_stats(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	u32 size, i;
+	int rc;
+
+	size = bd->hw_ring_stats_size;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+
+		nqr->stats.len = size;
+		rc = bnge_alloc_stats_mem(bn, &nqr->stats);
+		if (rc)
+			return rc;
+
+		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
+	}
+
+	return 0;
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -635,6 +699,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -724,6 +789,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1180,6 +1249,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 	return bnge_set_real_num_queues(bn);
 }
 
+static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
+{
+	bnge_hwrm_stat_ctx_free(bn);
+}
+
 static int bnge_request_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1221,6 +1295,27 @@ static int bnge_request_irq(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_init_chip(struct bnge_net *bn)
+{
+	int rc = 0;
+
+#define BNGE_DEF_STATS_COAL_TICKS	 1000000
+	bn->stats_coal_ticks = BNGE_DEF_STATS_COAL_TICKS;
+
+	rc = bnge_hwrm_stat_ctx_alloc(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm stat ctx alloc failure rc: %d\n",
+			   rc);
+		goto err_out;
+	}
+
+	return 0;
+err_out:
+	bnge_hwrm_resource_free(bn, 0);
+
+	return rc;
+}
+
 static int bnge_napi_poll(struct napi_struct *napi, int budget)
 {
 	int work_done = 0;
@@ -1301,7 +1396,7 @@ static int bnge_init_nic(struct bnge_net *bn)
 	bnge_init_ring_grps(bn);
 	bnge_init_vnics(bn);
 
-	return 0;
+	return bnge_init_chip(bn);
 }
 
 static int bnge_open_core(struct bnge_net *bn)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 234c0523547a..56df0765bf0a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -225,6 +225,7 @@ struct bnge_net {
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
 	u8			rss_hash_key_updated:1;
+	u32			stats_coal_ticks;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -271,6 +272,14 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
 	     (bnapi)->tx_ring[++iter] : NULL)
 
+struct bnge_stats_mem {
+	u64		*sw_stats;
+	u64		*hw_masks;
+	void		*hw_stats;
+	dma_addr_t	hw_stats_map;
+	int		len;
+};
+
 struct bnge_cp_ring_info {
 	struct bnge_napi	*bnapi;
 	dma_addr_t		*desc_mapping;
@@ -286,6 +295,9 @@ struct bnge_nq_ring_info {
 	struct nqe_cn		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
 
+	struct bnge_stats_mem	stats;
+	u32			hw_stats_ctx_id;
+
 	int				cp_ring_count;
 	struct bnge_cp_ring_info	*cp_ring_arr;
 };
-- 
2.47.3


