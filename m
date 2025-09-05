Return-Path: <linux-kernel+bounces-803451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04EDB45FEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794B61C2186C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE32313290;
	Fri,  5 Sep 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bo2tuZuL"
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6727A12B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092847; cv=none; b=Eq1uI/ysFWcCmBAlz1So0oIeqNZHSW7k6AbqjV8L5eQ7BkWJ1VOaT9Hu9HuKqVrJoj8mjpZ7jBbJvHausgHQuR3owe8oqb2htuZynFt1f4pyzu18xnK+B3WnXJYMCp6v6V8xoSGHKvGXpQ/pkOGuyDdLReHO/6TFClqWeBlDsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092847; c=relaxed/simple;
	bh=0uWL6KK8WN1zORbkeBOaGVywt7EirR6BpCTggXYgWzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+VpE5UTJnQGndBLPw0jx+IhCHrk0RvwVCe1EhGvQxF2MEsmwHqSwhYqGCScrIBeXeQoDk3Wlk+9a8gepJUbwbUbzMUKm8KgFj9vESkKiTV4UZirwzYkNKRp1HzaixV5bYTX/LJnhUcWAdZFGs1YzCqIYPwxU32zF3AktMEwT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bo2tuZuL; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-8988b982245so1616846241.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092845; x=1757697645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLbk+VDIaBG3NrhNiwtkW7qI5ZnuEsuQOZ7XBwBTtd0=;
        b=VfmsazZxydyUpuilfaRKG0WV+f1U1ejEhGmCL0AFdkt0OFoau+VyCKhmJmXQ5w+Pnc
         XE+di6wvYU1ArSGlUJorqBNglvcCGAeIApYCt1QVQKJRC1A3Q2bI3ja43lgnB50VLzsf
         7X4ghMhVixfOy8xa/0BS7LQemy+pwDnel5EWRHbc20cbzPx0+tZGatTswnqG0BfbCLhL
         D/AzYAi4gdBAlZ08XPnrLDwBM6m5y4Oo/wwhuliz4X1Yy/4Ha1NnSC2dXnKM+Y9Q/7vh
         1rmN85i/9c3u1wOW8CJCg6SXVO06daUj4oHA++upZcPSGurUMcjasvH8/7gpLpTQtMz4
         mAjA==
X-Forwarded-Encrypted: i=1; AJvYcCWRlDPYRJcL/3iEac1Jx4SPFa7ArRfoudLEk+qJWG2bj/4op7BJD+5sh+L9xe/8gOvKfQpHks9x14I1xAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYq32BarBsXGsabK5Qi9Y3CSORE0QBGBIRPnTePxKj7a9JmK+
	zSu8RDPt0xeBuhT7OlWraWQPa3OdaHl6fWcE3+q7ZrWOaE+jlgmB3zYb+b11U3vGvwJXXUYyKki
	ztIffc4MmHWSwZMPnONTr9792VVIC068V6YtW8XwIpkEU0Cif4xGmwYQVAd7jUMRWDwHvBGTdJZ
	GrZo8iUfoe0GVH496C9djNXyx6CYNzpDP2Z9ke5mE8tPx8mQ0rOSgHj1TtBkO/riWcmB/NfZH1Y
	TWIP8hSBEmGIm+SR+xeAR3vSiBv
X-Gm-Gg: ASbGncsv1fNJ/9Pbgo3+HNV4U3fjgTmasCXwksQXQWaOqp/5pZ4dl9cMruUfFGbVaiZ
	ef95aAlhZtZh0Px0dvj6MZFc25GFtY1mFhUG0lVjaJxXirRU1y+5ddMB8U5BH8MS9rBYylcLuRR
	qkfx2OxOqNZNxBy94GGGLvoe5J1BuFxvc5Sg3re4mVRBGpmrzV+QXa2P9yOK5C+655Z5Opm8ZMS
	aA+FrxoImjTGc9WwsExwSpyren/VFceUF/qhHh5nAcYECn3MeuVcUjYNw/fODScD51RUjXAolBw
	fOm98AoJxrMWHKq4Yy6/L5+olc1MCi7N4Gqwux73abgn/tDtEXUOssO43dziVfwsiuTbGcYwlzY
	7BeJ8W9xVrP8JD+RQUm4/BQHOYSgW1uRLjcg9jh55jHOS7bXiLY94rlJxwRCZy/ad/LhdEwQ9he
	ehDigVIclN
X-Google-Smtp-Source: AGHT+IEC3cVo7Lj+iiMBH5GcQXf923AksC3tE1m82Gltps1E28vWASF00mNLCF5H2wRKrHJgeXStallUtRhI
X-Received: by 2002:a67:ce91:0:b0:522:255d:4d2e with SMTP id ada2fe7eead31-52f8326fed3mr5727627137.7.1757092844879;
        Fri, 05 Sep 2025 10:20:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-52aef56bf6dsm1914867137.2.2025.09.05.10.20.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724877cd7cso2932242b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092844; x=1757697644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLbk+VDIaBG3NrhNiwtkW7qI5ZnuEsuQOZ7XBwBTtd0=;
        b=Bo2tuZuLpqxF6Hqx1Z+hpDnKTjZMPAUweMHOHVnIeeN6vN8D6xzAvQ+za0mk1WMdYU
         sZ0jUg6dDWu3/xYj2ISMshuh9PlICXOR5kmlYuwyy6F1QtRjfc942+KaiUYgf54tc/96
         1hPrjmQgwbD2AholUmO0fnKSazZUarEfzeA0w=
X-Forwarded-Encrypted: i=1; AJvYcCVd6D48+2lZbvaahP5lz39Hiy6s3/Pu8x14RiYZzn2W6ywi8Jsk1KqSpBp/aBuSdM2lcWo35iG1HDsqkls=@vger.kernel.org
X-Received: by 2002:a05:6a00:3d4a:b0:774:20f9:63c5 with SMTP id d2e1a72fcca58-77420f965a5mr3326592b3a.0.1757092843670;
        Fri, 05 Sep 2025 10:20:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4a:b0:774:20f9:63c5 with SMTP id d2e1a72fcca58-77420f965a5mr3326562b3a.0.1757092843195;
        Fri, 05 Sep 2025 10:20:43 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:42 -0700 (PDT)
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
Subject: [v6, net-next 07/10] bng_en: Allocate stat contexts
Date: Fri,  5 Sep 2025 22:46:49 +0000
Message-ID: <20250905224652.48692-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  59 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 101 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  12 +++
 4 files changed, 174 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 5c178fade06..eb72b7ec555 100644
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
index a9fd5b242cb..5465c07d317 100644
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
@@ -643,6 +707,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -731,6 +796,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
 	return rc;
 }
 
+static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
+{
+	bnge_hwrm_stat_ctx_free(bn);
+}
+
 static int bnge_request_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1221,6 +1295,25 @@ static int bnge_request_irq(struct bnge_net *bn)
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
@@ -1304,6 +1397,14 @@ static int bnge_init_nic(struct bnge_net *bn)
 	if (rc)
 		return rc;
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
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 234c0523547..56df0765bf0 100644
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


