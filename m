Return-Path: <linux-kernel+bounces-825055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FBDB8AD08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61C15863A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D33323F7E;
	Fri, 19 Sep 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gM1fSlBS"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E235326D76
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304127; cv=none; b=EaCBekVZdfjJkvQw+r3IEZoxuKba/GSlqyIp1HmVqVVrUhs5nD7c1Vwr/TchwEy0ViWHFrVWUMXTZ3dkX1V27Qm8VbrTn40uxdjIXy24tl+Vk3jS+zkNXfMLIiwJITfCn/4TEutPmBqlUBPVq99yHM5zFUl+Ua6pWKiOY8Q9/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304127; c=relaxed/simple;
	bh=4ySHLREyUAtWjLh82gQtAIXKkbuM/Pq0RWplAHVjlNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMVkzQL2nFoZGWoFfs8weauNTnAfeqOLwEiG+EMR0j3uMvtIOGHzQmvun2mJikDusgNpmqxa2C9H1NcixKus4HoVTnQOfzJtUFyesaSkZ/p8wBec7YPyaa09JOSBxCZ7GYt7ZqefRXtNJctlJGyxT0bTpjo+BHZycQWHQ33xG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gM1fSlBS; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-42403719c73so23577015ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304124; x=1758908924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iQIDq5dTw5x1Y6mcj+DSZeu2XXA5UkkoVmQGpR+sJs=;
        b=lC0Oe/u/GlJ1tt+PWWJIUxgJuBWc/2xmObI0BdGccYhrxmrGs37uz6IjVgEwXSRToy
         9lRKLtQWFK0JdWuYhTcwYKiKf61nYlOUaosbGI4eHzP9kWXMTQuM+NDBJX2jiCqYnMmU
         W9pOJ2o6j2ZU7L58SR05jC0ymFXouk/96UvGcFSImDg1x8z6OPnT73IfBuI0wWQAMcvi
         08uJ55zs/hoD48Mz4ERH5Y6zBZTKobsTL6tOi1wELFedbZozV0rUuYeiYh2nQLwHixU+
         /hiH4RWereDYPhB41YXBM2HGKz6pdEojvmZTy88tkshd+/NfnFQBQMK7g1oSjmc4DGRU
         d4WA==
X-Forwarded-Encrypted: i=1; AJvYcCWshO1CjolNqDBQ6Lq3p9ygqkIw5isJ/NNVWh5ocxUaRJY+d2YrcKGMDfZMKgasy4CoQ1mMe/MJp0yjc9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQjWUHcY/cp5rFl3x6J55ImBSanaWbVuwTZH1P5RgRtfCRYLk
	AS7oRfVTeDv5fYby5vmhT5qJaTqwXswvCnAFc+Rtp7HjyR72XdayHDqgcvTz6WcQR1uc8wNYOfd
	QHAfyDPyEc6eLN2ULxkTUf05vhE2FfcxmWSAEu3Qm1gfMN/bhQyKWbXbgdekJ36wNKagwfoDpCp
	z4dxCOJVNXPhfB5PBhtdDcnohkFN4nB7I9FOOfFKdxCiKo0UlH7tnkR/c/D8apSwSX5HqKHIVoO
	nLmcGU+J9WGq3kl69rJ8nB34pJP
X-Gm-Gg: ASbGnctYZAxxqSWp6jRWSdiEWxrZmVq08sASLkDXqv8Cngi/a3uRAxCdRQ7TPDjjBaz
	j/JB/b0x7kri9cAaiUR67vk0xh68dsCZ0NOdcGg6D+t+zm0gd6V+v4fqYDI8NUZOzhJDqm5g2rk
	hqcm3BvLwyOiWV5pbIH4tg2f4L8Cmb94unx8O+ELrpLtlJ6wEXVZ/tgQzvxxOx3nCBlO2fALPEo
	xKlpKewNju8vlkzx54Jiz+DUqYZg6NH+9lzrzJ47HcNg2gFDTxeDhoOpMbEQr+G8cfGCdgIYRcb
	uu5hh23+DBL6UiTSSb8j9GQ+MQIF5xg2BE6YQ2K19YkxxCG8uop/psFsanoUrB5DDrzQ4lOPVFk
	qNJF2HzOW0Hk12EyNy7jjEYEJ/W7gcPGmWwpqyf9R97kTE/IJEwLC3n+I0kGtH4VJ4ujPWErgn9
	+bAsQ8fbWS
X-Google-Smtp-Source: AGHT+IFYqlPkwPz5DOUO7GCVqibVex6pKBsEKuKKU9G/BAIwPxeh1de/KRSHAVeFwH46YMqPAPEtmQWr6ymQ
X-Received: by 2002:a05:6e02:2192:b0:423:fb44:e8c9 with SMTP id e9e14a558f8ab-42481911752mr60423425ab.11.1758304123972;
        Fri, 19 Sep 2025 10:48:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d535be444sm347909173.33.2025.09.19.10.48.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5527f0d39bso623858a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304122; x=1758908922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iQIDq5dTw5x1Y6mcj+DSZeu2XXA5UkkoVmQGpR+sJs=;
        b=gM1fSlBSWRw9g1bmkALPC5Qd+VzRzY2hpUkQrKC6JRrdtPcreRjAB6kKl+DKwZocUF
         jtQLg5Sn/p7NpFiMR5CsOYdks2bcLxYnsDdp1TIgN86l45uPHqnhFeNuQZsZG5r40smU
         MkKM9I8m+nsgPPL7BC+FHGn8tGA0w/sKX/9es=
X-Forwarded-Encrypted: i=1; AJvYcCU8oPx+il/KrltmIivqQC/RD7ZYyiMjHJ+GMknf37GUoxTHigC1ml/5LbgR0dOVvIkMyR0xPaOzUZVXDPk=@vger.kernel.org
X-Received: by 2002:a05:6a20:7483:b0:262:c083:bb2e with SMTP id adf61e73a8af0-2925991ad89mr6111965637.8.1758304122186;
        Fri, 19 Sep 2025 10:48:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:7483:b0:262:c083:bb2e with SMTP id adf61e73a8af0-2925991ad89mr6111935637.8.1758304121763;
        Fri, 19 Sep 2025 10:48:41 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:41 -0700 (PDT)
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
Subject: [v8, net-next 07/10] bng_en: Allocate stat contexts
Date: Fri, 19 Sep 2025 23:17:38 +0530
Message-ID: <20250919174742.24969-8-bhargava.marreddy@broadcom.com>
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

Allocate the hardware statistics context with the firmware and
register DMA memory required for ring statistics. This helps the
driver to collect ring statistics provided by the firmware.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  56 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 104 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 ++
 4 files changed, 174 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 5c178fade06..8f20b880c11 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -701,3 +701,59 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
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
index 6c03923eb55..1c3fd02d7e0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -24,4 +24,6 @@ int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
 int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
+void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
+int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 1ccc027c021..9f1deb60dd2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -30,6 +30,73 @@
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
+			goto err_free_ring_stats;
+
+		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
+	}
+	return 0;
+
+err_free_ring_stats:
+	bnge_free_ring_stats(bn);
+	return rc;
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -651,6 +718,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -739,6 +807,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1189,6 +1261,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
 }
 
+static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
+{
+	bnge_hwrm_stat_ctx_free(bn);
+}
+
 static void bnge_free_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1256,6 +1333,25 @@ static int bnge_request_irq(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_init_chip(struct bnge_net *bn)
+{
+	int rc;
+
+#define BNGE_DEF_STATS_COAL_TICKS	 1000000
+	bn->stats_coal_ticks = BNGE_DEF_STATS_COAL_TICKS;
+
+	rc = bnge_hwrm_stat_ctx_alloc(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm stat ctx alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
+	return 0;
+
+err_out:
+	bnge_hwrm_resource_free(bn, 0);
+	return rc;
+}
+
 static int bnge_napi_poll(struct napi_struct *napi, int budget)
 {
 	int work_done = 0;
@@ -1317,6 +1413,14 @@ static int bnge_init_nic(struct bnge_net *bn)
 		goto err_free_rx_ring_pair_bufs;
 
 	bnge_init_vnics(bn);
+
+	rc = bnge_init_chip(bn);
+	if (rc)
+		goto err_free_ring_grps;
+	return rc;
+
+err_free_ring_grps:
+	bnge_free_ring_grps(bn);
 	return rc;
 
 err_free_rx_ring_pair_bufs:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 10bd29a833e..55497c4e7fb 100644
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


