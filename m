Return-Path: <linux-kernel+bounces-767163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69AB24FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81161C244E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB112BDC13;
	Wed, 13 Aug 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MLiDjou1"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A929CB43
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102596; cv=none; b=Kz1gQtoFGWDT0EFRvb4SNJgvFqaNRZVT/j4dNFO4Htj/Hv5HTfzdyzCZNImDrokCyFwgRV9X2QnXSu3jVn8tWptBbzFOjpC7OZRaQ65HFowiPfx5MjLv/jibr4qPHTkgRtieyngTFfbXLfXcZgKWlx5vj0grLz+tcj+usHXqi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102596; c=relaxed/simple;
	bh=2jKImJ5/n6inK7HeDevPmWx9fg1zHDL2YPwiwyoe52M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5EoW80XRL3jCeN1UCstqXhD+mWaFptox97lToxcWk+I7g+CCbRF+8gIk4Edgj7KbZt2niQjS9kCZOk3tY6MCSzORplSr1IjtjDGrKIJT4k0ERgtfIGBUidp85KsptpqKAmurVhl6rKc9YxQiXN8Bk8H0zyTuOtmyF7H4qkWIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MLiDjou1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso7188794a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755102592; x=1755707392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii9jVqNSDWiAvS8HdOAp4vKRVcoxTgcGumi08cRBjIA=;
        b=MLiDjou1yjMJYhNsIxynThs+kzSfbeq8owMHP/Aba96l05oDJxaqZymYoKuDHkF2EZ
         MYq3v4DczpYgcBsLQP1XX233NlTRhdjojR37WEA1RKTwf3NTTRYaNWcEBC6K5pmFYHyQ
         ZLStSV4VpHHRIg58qx6tOgPt1ATsyyUH4gWJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102592; x=1755707392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii9jVqNSDWiAvS8HdOAp4vKRVcoxTgcGumi08cRBjIA=;
        b=SbYwfqdTkw9Uau4kJA7u34AWduF+FeN6O3/zYEPgteEQu8sRiLCtTzN/osNehqufLs
         Q6rGsQNDqOEMgQsf5/s4cVEdN0isIL6vR4tvTMoKt7f3BKiwQq1fnUW6n/rGHF3Q2i4G
         ERJShWPLSY/L+reQahQFqtgDymJQMT6EWT8Jvgomr3QbYnJRtSB9BPPU/XV9pEd89zzS
         h50wBtXwQsvfXZBgxCckO9uRHH6Dqgc008it5NefiC7BOJdR/AdWjk6zk3pz12dN3L1r
         pz2N7yHbSV3+8H/1nle1Imfea12xCJ5j9fL+MF5PvV2FZ86hMkXCamjlj9Fg+oiCqlCW
         agfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfo0wnBmWXkUIKwXcv+wZ77ndm7PB4YdUBYNxkUOZ/1cZfIlUFcA0cTFs+0qDY6WZLwfgkJZHeuYdIqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ4VKn0PG+SpxT5llmnYlvy62/LuLJztc/rUW2Cl08X/EANXB
	08uvzqSx1cyBONWWyg47zQ6JcxHB7PqAQ7BLSCC9oKnLgQZZN3stdE+vNK2ZYzEAng==
X-Gm-Gg: ASbGncvuRlRVJ8soMj+NjWZTRk5TYGk6QaU3oxohaWAQBbKAx/Afknvriry+rPRPhQx
	5ivENHPmXVKX6I3TO155l5wYQhNguiTR5OxcPJVlZZgrqkVm1II/OLQy+fFmUq36d5Ea3AOhV8F
	L65pG3Neb8m/ikhBhqkHpVDZciBAc6KIaJt64oMm1dyb+LgmFlsFt9F2V0PGYpjsv4NuAEZkmaH
	J3GwfJEKBGP4BuQpnSJbii0B4/5hOu+Aa3WockOErvKfxI7UMmuG8UkiqWe7bsmbCwpRAywooK+
	JaHPQqqUuX1vrNIEg+nUVmmcw9L5fTp6EvxQKhSlnFYFIl6W6UNYwrcg/rJ5GNbwxdDxMLiBzQB
	xVYOGnWGgBfN0/ncNRaFGBYYnsGPtWJgHW7DAf0Ac9KHFGvT4NWAdJcjQudiCiUn7uxpsgLefG1
	+pRPSlUabU11Cdr5jQ9l4ZOuMIrA==
X-Google-Smtp-Source: AGHT+IE1Kl/8MHr6H2eY3YfS8j3rshGchlE/GDkFcV4x0Co4YeMTESRMIDrlFe3oHctRNIf2yhubxQ==
X-Received: by 2002:a17:902:fc50:b0:242:9bbc:c776 with SMTP id d9443c01a7336-2430d226fbcmr52530975ad.57.1755102591788;
        Wed, 13 Aug 2025 09:29:51 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm329311915ad.41.2025.08.13.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:29:51 -0700 (PDT)
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
Subject: [net-next 6/9] bng_en: Allocate stat contexts
Date: Wed, 13 Aug 2025 21:56:00 +0000
Message-ID: <20250813215603.76526-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
References: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the hardware statistics context with the firmware and
register DMA memory required for ring statistics. This helps the
driver to collect ring statistics provided by the firmware.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 59 ++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 95 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 12 +++
 4 files changed, 167 insertions(+), 1 deletion(-)

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
index a998df4a4de..fc84bbd4b72 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -30,6 +30,68 @@
 #define BNGE_TC_TO_RING_BASE(bd, tc)	\
 	((tc) * (bd)->tx_nr_rings_per_tc)
 
+static void bnge_free_stats_mem(struct bnge_net *bn, struct bnge_stats_mem *stats)
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
+static int bnge_alloc_stats_mem(struct bnge_net *bn, struct bnge_stats_mem *stats)
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
@@ -625,6 +687,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -713,6 +776,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1157,6 +1224,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
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
@@ -1198,6 +1270,27 @@ static int bnge_request_irq(struct bnge_net *bn)
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
@@ -1278,7 +1371,7 @@ static int bnge_init_nic(struct bnge_net *bn)
 	bnge_init_ring_grps(bn);
 	bnge_init_vnics(bn);
 
-	return 0;
+	return bnge_init_chip(bn);
 }
 
 static int bnge_open_core(struct bnge_net *bn)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 3a182914e28..d9cae6c4e46 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -224,6 +224,7 @@ struct bnge_net {
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
 	u8			rss_hash_key_updated:1;
+	u32			stats_coal_ticks;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -270,6 +271,14 @@ void bnge_set_ring_params(struct bnge_dev *bd);
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
@@ -285,6 +294,9 @@ struct bnge_nq_ring_info {
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


