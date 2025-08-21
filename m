Return-Path: <linux-kernel+bounces-780250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E28B2FF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3AF1BA0452
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAAF2DEA7E;
	Thu, 21 Aug 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fN1g1Bit"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C752DEA64
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791346; cv=none; b=fYrY71+T73jNrYXtUk7b0xYQwd6rYSvJ3azM4pvTP+kOU5yf0PPgCekXIkvE/7QDAgsBCfoPD0rJzUUG/dw6RV9ze4mKN9eZu+lyjsUNKuYMdOGg6lpOIZeyqCBqdWNOd1/Naws0tu5NXz3aiDA525hsMB+Ide28drQALsKtdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791346; c=relaxed/simple;
	bh=SLgwdJPCml5SEteq1QtjDP3gBpVWEzTDRQoYhchZqTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f83T+oNrbcfXY2LxKQ1AerF+8fM0L04VzK0yEch4SZOT5yIXmv09i4LAsNEN4DBfakP67w9wsqWeU9avchedB9ZCXHafUwpavyZLD9uSKUZS9OE4y1wbB4P6bBE5+rLTLgE/+DdpPn0sidB/tuJg7eJY63/h7Gu5q/RMQLuoe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fN1g1Bit; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2445824dc27so11549375ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791344; x=1756396144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDAUK/BRJ3xkVPDivw+kDGYaPU8l51c9YPN1dmd3w2Q=;
        b=A/dRJ+n3NJNv329Mxtc3yGV1g+p22zrRWTPMAAaq7CQG8PyZ9d1f1br4p6xLlL+eEu
         JGmHPb+MlbX0qg2y8dGtXkcpZL541rg53Uu4qEpzG8tko0aTzO0/QWvl0YosKhU4EJ7y
         lfPKy+oyHOEJAnXUc2KmrY25Cou1TTutEDgCAdQgX602k7DkYpPHHYgRgg743alItOlW
         qebf+LuOVcNAbtDPPHLNp6HpSrQzbLO5HYpcaCEfcDoLMrQdnLeFaASJdcH2smRJKjv0
         zyXjOPs25RO9JYjV5az0TFKGNBkyGjUX68h2QNu5VlQHTXlf286EreuxKjnssmbFUrj+
         YPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXessoRF/Ti7e2fr8QV2igVCnmG59P3r9wM+PV6wI3fpGY93pq+mGcH/MqkkinnzjXggrPf4wKufO22aKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJy0TRg0U+Z7LZ6h4xMIczWgF2g9jRQ7uTQP0k0E1h8DV4LGW
	NP1IHLduMJcLieqjXo8KEH/glEFRClrzwf0dgqWsa3hpFtepqbjsNu3ytYGjbjSAzSP8U0EgvU8
	6BdKbVSpqfWzxaaRLUGdqYtKygsFqx9D6gSYIf93jkLpLS+NIraMtGVF6uyV519MDPG4UCzG/OL
	LOgr9TgcETQq4OYoa6YHHU25npQjIm+KubMd5gl/6hay+pXATuaWC0dbv/XEGHDACpJkYyxBWXN
	O4YIaCW8Q5Z20A1B9C5KUgzzvv7
X-Gm-Gg: ASbGncvvq11fgzE6LgsOBmavt5FVhBfC5VPps1N/BeuCTgoQWBDrMbXTeIMV/ce8Jcr
	P8tJMTwHWoGRyOohZNDgfs47RvhT2epkQbbrv6UKjZL7GytBPR3drW4+9pWF0SWTrjssCW0AWIk
	jh4Y8b/RrsqnM38k4ie2oyaBjGtb2LyCY4PTtpljO1bDkLwxduwRTZA268ENow4JcYlvpGYdS/s
	k8MDxa/NKR1fmr0u/BnKLOOaxNcEV93+XGOkAn42/TNpO9xGCo+yDMtrY8cq/GFursIQXP1BpuN
	MEZfnJSQRA/5VY3XA4IWxtCPSdt+MKUfuUYqBkOzJF9fpYB6AiBwZWhuREuJGPEv3VQEQh6a6CF
	xTL2HlF8WCqejhxWYrthLE5Jm8y307LsFD0vLQgQJbHzUPOM45olT45gD7dQ9d1PBqrEGVwwMsX
	6L2Z9bLw==
X-Google-Smtp-Source: AGHT+IHppIq9tj7iuUYhSV+CRSA9VvWB8M1o5rhPTs/rq1bjnR+PHdshA1+xe7Zl0RYZVWphUMM9zf9d5SOf
X-Received: by 2002:a17:903:1b4e:b0:243:b39:285f with SMTP id d9443c01a7336-245febf6c3bmr35818435ad.13.1755791344001;
        Thu, 21 Aug 2025 08:49:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed350176sm5313205ad.19.2025.08.21.08.49.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:49:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4761f281a8so918661a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791342; x=1756396142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDAUK/BRJ3xkVPDivw+kDGYaPU8l51c9YPN1dmd3w2Q=;
        b=fN1g1BitWucw6QVyoiXzQMTL1n7kWpXVkzyjPuuEcSzr3HUBD9GM4Qemx35oh3nbZA
         BsZVwndmVrBepEn/9PG2CRawSaGOyuVf3vdp29WrpxSY0TYJ0xNPBTmDxcB+R2pvLjCZ
         gJpwvYWn+M/VZlmXWW+iKtkfJc49dS2gs8i6A=
X-Forwarded-Encrypted: i=1; AJvYcCXmpcahduUQyNsg147sBC4TQI6LbmIV6n19xUDH3dhc1fhJjtKSxYKC5byrdzN7nofiqrve7pUssAFsfTo=@vger.kernel.org
X-Received: by 2002:a05:6a20:6a08:b0:240:e327:d7a1 with SMTP id adf61e73a8af0-2433074ea52mr4270553637.1.1755791342116;
        Thu, 21 Aug 2025 08:49:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a08:b0:240:e327:d7a1 with SMTP id adf61e73a8af0-2433074ea52mr4270524637.1.1755791341612;
        Thu, 21 Aug 2025 08:49:01 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:49:01 -0700 (PDT)
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
Subject: [v3, net-next 6/9] bng_en: Allocate stat contexts
Date: Thu, 21 Aug 2025 21:15:14 +0000
Message-ID: <20250821211517.16578-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
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
index d1674408d6aa..046219c11f91 100644
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
@@ -628,6 +692,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
@@ -717,6 +782,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_ring_stats(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -1164,6 +1233,11 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
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
@@ -1205,6 +1279,27 @@ static int bnge_request_irq(struct bnge_net *bn)
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
@@ -1285,7 +1380,7 @@ static int bnge_init_nic(struct bnge_net *bn)
 	bnge_init_ring_grps(bn);
 	bnge_init_vnics(bn);
 
-	return 0;
+	return bnge_init_chip(bn);
 }
 
 static int bnge_open_core(struct bnge_net *bn)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 0859f500b3f4..387f68d24a4e 100644
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


