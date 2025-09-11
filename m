Return-Path: <linux-kernel+bounces-812763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE47B53C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3236168844
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E321362097;
	Thu, 11 Sep 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ESbHKneC"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63B346A1D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619338; cv=none; b=ao2Tu6B41oP/LTdEyQ2o6UeBDC7U6l5Yc5V0so0I1EzLm+EdUomLXRajzUpAHFVrfapIkSjeLhmN3npr81RydQBeKUbg73IRFSkbklHye9DIDE3kPTlutB67IxUkbfk1uaZB8JUGwOWBSmNProQOpUPlXqUyKKpDi/Wpdm4AM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619338; c=relaxed/simple;
	bh=6AxpIjd5egI1qDY1kS6au4WlLiiz9MD/9XloKZ5D1Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKsxG0aaGVucLuXAF4eLO/kh8GfP/I89/shqcaab/qB40ykaN/EZDT4g+Bg/ByROwTsIIfAc1lY196NfsPOu4gZi9j3q+40obIlAXaLAiIe3NOMIDVI+mHYHTcZ8fB45Jjk4YI20YB9eYcS2wWdThL1aJtFuj8LJph8soRNC4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ESbHKneC; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-24b2de2e427so7808855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619335; x=1758224135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdQ5HXN5N1UwmqDG7E77h1doudt2T/GfzClj2tcmpB0=;
        b=DsZgmMYxsmA9U6ghIpfr3oxzs4634HPxBxiLiAWjw0k4nmnArqf4gcpfCkvoSioCGh
         wpwy9VDI8cSejhdYZVvjjhBKATlpsK/rTnuhrRkhN47/+ubSi5Tv3H7/odcabrQ/D49C
         ohrGcHwQnkLer2RtUO27HgnwnlewXG40KV3uUq60NLOihSFYYbk+JPQ9ebkqmX3UH+dU
         bz83EfvbNX8AZpbmTjrC0viWgc8gMENFnCkIiZm2o8zJKtiSQoRfUcLHXAhukFvn6VyS
         y5NRKVpesluYJ6dbPIw+8BfMuIK9jhUY/WCSn59V3hPmnR1EvgkVnpqnT+9sDoA9au2y
         /lvg==
X-Forwarded-Encrypted: i=1; AJvYcCWdpXsv51V4FudVN6fJLYjX98fDu0qYLbU7EVSixBD+PPX7Qwk3Ni6gAUMDXCACq5yiMNNf6lyItFr+avY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUULeaDcDbWzCbGIp/Wb4T5HB7PA9NsNbLcjkroLWQn964JFFh
	G0ZjiGocLU7JRUgWYjoS1Uew8n1r91eHagTlcC5S5gW+blGpsodYxYHAtobxvAvKAS708Id9pbW
	bN132M6CTKFdcq21cSKGeixOE+6F7j2g+tPRiU22+fRYnqC9STC/NnRu2OYIVDMofMijcf+kj/6
	NoCfJ6Hb37kv4Gp+WxvBa6dR2Pr0LTAoQaNPY5diEvCp8rDN3/J8F5hIEwx9ArpuA1fUzWBFjhz
	XgbsnRDxRk1cNL0c79nA7d+3087
X-Gm-Gg: ASbGncsZH00HNtgcMMjDba+b52bHBjet5h+FTaTePO6DWGlSNYi3KVmEJMr3FZZKozm
	cW7YDIENJeRQP3FOX80m73OlMt7WaEqjQlYz9UptVpSZazmOODIrmKsJ/w5S1xTRdOdhBeJ+Sal
	zOcOs/QSMghkiKy0+hdg5PA80e/Z/MTtFghJwrGWboT+mRx7QwlGY+t8UCgGoQ6Sseg/JzMhk0W
	9zu9oSvQruCBQMlxSOqccug/kpn7ta/SbfPUF0M0E1aISTl8lFK67Kl8mFjNXyY4bh2VqSb8ACo
	zj8QrQLMVQOn4johXgAc6uMlcPqwZdBcexwJ1u6UEacI0OwDTUzAawGUmMKKMMtemMniiGxs0da
	PnxubZ0Mqt9XkelVPp6RNgBU3z/dTqpGhpdN1pZlaQADDo6aobIJTQj9bzfdM8WrLcvrNZ96JcO
	HZe8lTMk5b
X-Google-Smtp-Source: AGHT+IHBar8vy2kZPhs7HsO9PuqfgNafP6p3YomjPgQclY8wGRhWDYLDm5UG9CSXRI6OG2D9u5IuhW9zEesY
X-Received: by 2002:a17:903:1b4d:b0:250:643e:c947 with SMTP id d9443c01a7336-25d26864f83mr5089145ad.28.1757619335435;
        Thu, 11 Sep 2025 12:35:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-25c36bc2c4bsm1975815ad.15.2025.09.11.12.35.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b2b347073so13000165ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619334; x=1758224134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdQ5HXN5N1UwmqDG7E77h1doudt2T/GfzClj2tcmpB0=;
        b=ESbHKneCwRFFeDlchc3bToXQsJkg+P2eXG76g+UhC+6MGwhtlsOuECAxNmC+O+yIYT
         4goNhAEP/ouAUe1iFSCTA22t3aVPKfCtB/lP732sPNsU6KFVlCEyyMKLunhBzM63O5Lp
         MqjSiPB+wctF3Sb+H6yKHgm1yc7xdnOCrlTH0=
X-Forwarded-Encrypted: i=1; AJvYcCUTDQcI44tnZJP0754Yr46njqCKQs34Zq2YATxvbvdxbf3JcEJYAs56rcZvIza4wYcCX9dJGLxcVrGPF/M=@vger.kernel.org
X-Received: by 2002:a17:903:3bc8:b0:246:2ab3:fd7d with SMTP id d9443c01a7336-25d25195f05mr5222105ad.25.1757619333434;
        Thu, 11 Sep 2025 12:35:33 -0700 (PDT)
X-Received: by 2002:a17:903:3bc8:b0:246:2ab3:fd7d with SMTP id d9443c01a7336-25d25195f05mr5221865ad.25.1757619332822;
        Thu, 11 Sep 2025 12:35:32 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:32 -0700 (PDT)
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
Subject: [v7, net-next 03/10] bng_en: Add initial support for CP and NQ rings
Date: Fri, 12 Sep 2025 01:04:58 +0530
Message-ID: <20250911193505.24068-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate CP and NQ related data structures and add support to
associate NQ and CQ rings. Also, add the association of NQ, NAPI,
and interrupts.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 411 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  10 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 4 files changed, 423 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 03e55b931f7..c536c0cc66e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -215,5 +215,6 @@ static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 }
 
 bool bnge_aux_registered(struct bnge_dev *bd);
+u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c25a793b8ae..615f9452725 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -27,6 +27,231 @@
 #define BNGE_RING_TO_TC(bd, tx)		\
 	((tx) / (bd)->tx_nr_rings_per_tc)
 
+#define BNGE_TC_TO_RING_BASE(bd, tc)	\
+	((tc) * (bd)->tx_nr_rings_per_tc)
+
+static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
+{
+	struct bnge_ring_struct *ring = &nqr->ring_struct;
+
+	kfree(nqr->desc_ring);
+	nqr->desc_ring = NULL;
+	ring->ring_mem.pg_arr = NULL;
+	kfree(nqr->desc_mapping);
+	nqr->desc_mapping = NULL;
+	ring->ring_mem.dma_arr = NULL;
+}
+
+static void bnge_free_cp_desc_arr(struct bnge_cp_ring_info *cpr)
+{
+	struct bnge_ring_struct *ring = &cpr->ring_struct;
+
+	kfree(cpr->desc_ring);
+	cpr->desc_ring = NULL;
+	ring->ring_mem.pg_arr = NULL;
+	kfree(cpr->desc_mapping);
+	cpr->desc_mapping = NULL;
+	ring->ring_mem.dma_arr = NULL;
+}
+
+static int bnge_alloc_nq_desc_arr(struct bnge_nq_ring_info *nqr, int n)
+{
+	nqr->desc_ring = kcalloc(n, sizeof(*nqr->desc_ring), GFP_KERNEL);
+	if (!nqr->desc_ring)
+		return -ENOMEM;
+
+	nqr->desc_mapping = kcalloc(n, sizeof(*nqr->desc_mapping), GFP_KERNEL);
+	if (!nqr->desc_mapping)
+		goto err_free_desc_ring;
+	return 0;
+
+err_free_desc_ring:
+	kfree(nqr->desc_ring);
+	nqr->desc_ring = NULL;
+	return -ENOMEM;
+}
+
+static int bnge_alloc_cp_desc_arr(struct bnge_cp_ring_info *cpr, int n)
+{
+	cpr->desc_ring = kcalloc(n, sizeof(*cpr->desc_ring), GFP_KERNEL);
+	if (!cpr->desc_ring)
+		return -ENOMEM;
+
+	cpr->desc_mapping = kcalloc(n, sizeof(*cpr->desc_mapping), GFP_KERNEL);
+	if (!cpr->desc_mapping)
+		goto err_free_desc_ring;
+	return 0;
+
+err_free_desc_ring:
+	kfree(cpr->desc_ring);
+	cpr->desc_ring = NULL;
+	return -ENOMEM;
+}
+
+static void bnge_free_nq_arrays(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		bnge_free_nq_desc_arr(&bnapi->nq_ring);
+	}
+}
+
+static int bnge_alloc_nq_arrays(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, rc;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
+		if (rc)
+			goto err_free_nq_arrays;
+	}
+	return 0;
+
+err_free_nq_arrays:
+	bnge_free_nq_arrays(bn);
+	return rc;
+}
+
+static void bnge_free_nq_tree(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_ring_struct *ring;
+		int j;
+
+		nqr = &bnapi->nq_ring;
+		ring = &nqr->ring_struct;
+
+		bnge_free_ring(bd, &ring->ring_mem);
+
+		if (!nqr->cp_ring_arr)
+			continue;
+
+		for (j = 0; j < nqr->cp_ring_count; j++) {
+			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
+
+			ring = &cpr->ring_struct;
+			bnge_free_ring(bd, &ring->ring_mem);
+			bnge_free_cp_desc_arr(cpr);
+		}
+		kfree(nqr->cp_ring_arr);
+		nqr->cp_ring_arr = NULL;
+		nqr->cp_ring_count = 0;
+	}
+}
+
+static int alloc_one_cp_ring(struct bnge_net *bn,
+			     struct bnge_cp_ring_info *cpr)
+{
+	struct bnge_ring_mem_info *rmem;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_alloc_cp_desc_arr(cpr, bn->cp_nr_pages);
+	if (rc)
+		return -ENOMEM;
+	ring = &cpr->ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bn->cp_nr_pages;
+	rmem->page_size = HW_CMPD_RING_SIZE;
+	rmem->pg_arr = (void **)cpr->desc_ring;
+	rmem->dma_arr = cpr->desc_mapping;
+	rmem->flags = BNGE_RMEM_RING_PTE_FLAG;
+	rc = bnge_alloc_ring(bd, rmem);
+	if (rc)
+		goto err_free_cp_desc_arr;
+	return rc;
+
+err_free_cp_desc_arr:
+	bnge_free_cp_desc_arr(cpr);
+	return rc;
+}
+
+static int bnge_alloc_nq_tree(struct bnge_net *bn)
+{
+	int i, j, ulp_msix, rc = -ENOMEM;
+	struct bnge_dev *bd = bn->bd;
+	int tcs = 1;
+
+	ulp_msix = bnge_aux_get_msix(bd);
+	for (i = 0, j = 0; i < bd->nq_nr_rings; i++) {
+		bool sh = !!(bd->flags & BNGE_EN_SHARED_CHNL);
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_cp_ring_info *cpr;
+		struct bnge_ring_struct *ring;
+		int cp_count = 0, k;
+		int rx = 0, tx = 0;
+
+		nqr = &bnapi->nq_ring;
+		nqr->bnapi = bnapi;
+		ring = &nqr->ring_struct;
+
+		rc = bnge_alloc_ring(bd, &ring->ring_mem);
+		if (rc)
+			goto err_free_nq_tree;
+
+		ring->map_idx = ulp_msix + i;
+
+		if (i < bd->rx_nr_rings) {
+			cp_count++;
+			rx = 1;
+		}
+
+		if ((sh && i < bd->tx_nr_rings) ||
+		    (!sh && i >= bd->rx_nr_rings)) {
+			cp_count += tcs;
+			tx = 1;
+		}
+
+		nqr->cp_ring_arr = kcalloc(cp_count, sizeof(*cpr),
+					   GFP_KERNEL);
+		if (!nqr->cp_ring_arr)
+			goto err_free_nq_tree;
+
+		nqr->cp_ring_count = cp_count;
+
+		for (k = 0; k < cp_count; k++) {
+			cpr = &nqr->cp_ring_arr[k];
+			rc = alloc_one_cp_ring(bn, cpr);
+			if (rc)
+				goto err_free_nq_tree;
+
+			cpr->bnapi = bnapi;
+			cpr->cp_idx = k;
+			if (!k && rx) {
+				bn->rx_ring[i].rx_cpr = cpr;
+				cpr->cp_ring_type = BNGE_NQ_HDL_TYPE_RX;
+			} else {
+				int n, tc = k - rx;
+
+				n = BNGE_TC_TO_RING_BASE(bd, tc) + j;
+				bn->tx_ring[n].tx_cpr = cpr;
+				cpr->cp_ring_type = BNGE_NQ_HDL_TYPE_TX;
+			}
+		}
+		if (tx)
+			j++;
+	}
+	return 0;
+
+err_free_nq_tree:
+	bnge_free_nq_tree(bn);
+	return rc;
+}
+
 static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
 {
 	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
@@ -216,6 +441,8 @@ static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
+	bnge_free_nq_tree(bn);
+	bnge_free_nq_arrays(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -302,6 +529,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_nq_arrays(bn);
+	if (rc)
+		goto err_free_core;
+
 	bnge_init_ring_struct(bn);
 
 	rc = bnge_alloc_rx_rings(bn);
@@ -309,6 +540,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		goto err_free_core;
 
 	rc = bnge_alloc_tx_rings(bn);
+	if (rc)
+		goto err_free_core;
+
+	rc = bnge_alloc_nq_tree(bn);
 	if (rc)
 		goto err_free_core;
 	return 0;
@@ -318,6 +553,166 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	return rc;
 }
 
+static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
+{
+	struct bnge_napi *bnapi = bn->bnapi[n];
+	struct bnge_nq_ring_info *nqr;
+
+	nqr = &bnapi->nq_ring;
+
+	return nqr->ring_struct.map_idx;
+}
+
+static irqreturn_t bnge_msix(int irq, void *dev_instance)
+{
+	/* NAPI scheduling to be added in a future patch */
+	return IRQ_HANDLED;
+}
+
+static void bnge_setup_msix(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+	int len, i;
+
+	len = sizeof(bd->irq_tbl[0].name);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+		char *attr;
+
+		if (bd->flags & BNGE_EN_SHARED_CHNL)
+			attr = "TxRx";
+		else if (i < bd->rx_nr_rings)
+			attr = "rx";
+		else
+			attr = "tx";
+
+		snprintf(bd->irq_tbl[map_idx].name, len, "%s-%s-%d", dev->name,
+			 attr, i);
+		bd->irq_tbl[map_idx].handler = bnge_msix;
+	}
+}
+
+static int bnge_setup_interrupts(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+
+	bnge_setup_msix(bn);
+
+	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+}
+
+static void bnge_free_irq(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_irq *irq;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+
+		irq = &bd->irq_tbl[map_idx];
+		if (irq->requested) {
+			if (irq->have_cpumask) {
+				irq_set_affinity_hint(irq->vector, NULL);
+				free_cpumask_var(irq->cpu_mask);
+				irq->have_cpumask = 0;
+			}
+			free_irq(irq->vector, bn->bnapi[i]);
+		}
+
+		irq->requested = 0;
+	}
+}
+
+static int bnge_request_irq(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, rc;
+
+	rc = bnge_setup_interrupts(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
+		return rc;
+	}
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
+
+		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
+				 bn->bnapi[i]);
+		if (rc)
+			goto err_free_irq;
+
+		netif_napi_set_irq_locked(&bn->bnapi[i]->napi, irq->vector);
+		irq->requested = 1;
+
+		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
+			int numa_node = dev_to_node(&bd->pdev->dev);
+
+			irq->have_cpumask = 1;
+			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
+					irq->cpu_mask);
+			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
+			if (rc) {
+				netdev_warn(bn->netdev,
+					    "Set affinity failed, IRQ = %d\n",
+					    irq->vector);
+				goto err_free_irq;
+			}
+		}
+	}
+	return 0;
+
+err_free_irq:
+	bnge_free_irq(bn);
+	return rc;
+}
+
+static int bnge_napi_poll(struct napi_struct *napi, int budget)
+{
+	int work_done = 0;
+
+	/* defer NAPI implementation to next patch series */
+	napi_complete_done(napi, work_done);
+
+	return work_done;
+}
+
+static void bnge_init_napi(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		bnapi = bn->bnapi[i];
+		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
+					     bnge_napi_poll, bnapi->index);
+	}
+}
+
+static void bnge_del_napi(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->rx_nr_rings; i++)
+		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+	for (i = 0; i < bd->tx_nr_rings; i++)
+		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+
+		__netif_napi_del_locked(&bnapi->napi);
+	}
+
+	/* Wait for RCU grace period after removing NAPI instances */
+	synchronize_net();
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -337,8 +732,20 @@ static int bnge_open_core(struct bnge_net *bn)
 		return rc;
 	}
 
+	bnge_init_napi(bn);
+	rc = bnge_request_irq(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "bnge_request_irq err: %d\n", rc);
+		goto err_del_napi;
+	}
+
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 	return 0;
+
+err_del_napi:
+	bnge_del_napi(bn);
+	bnge_free_core(bn);
+	return rc;
 }
 
 static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -365,6 +772,9 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_irq(bn);
+	bnge_del_napi(bn);
+
 	bnge_free_core(bn);
 }
 
@@ -587,6 +997,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bnge_init_l2_fltr_tbl(bn);
 	bnge_init_mac_addr(bd);
 
+	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 92bae665f59..bccddae09fa 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -133,6 +133,9 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NQ_HDL_TYPE_RX	0x00
+#define BNGE_NQ_HDL_TYPE_TX	0x01
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -172,6 +175,8 @@ struct bnge_net {
 
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
+
+	int				total_irqs;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -223,6 +228,8 @@ struct bnge_cp_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct tx_cmp		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+	u8			cp_ring_type;
+	u8			cp_idx;
 };
 
 struct bnge_nq_ring_info {
@@ -230,6 +237,9 @@ struct bnge_nq_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct nqe_cn		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+
+	int				cp_ring_count;
+	struct bnge_cp_ring_info	*cp_ring_arr;
 };
 
 struct bnge_rx_ring_info {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index c79a3607a1b..5597af1b3b7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -46,7 +46,7 @@ static int bnge_aux_get_dflt_msix(struct bnge_dev *bd)
 	return min_t(int, roce_msix, num_online_cpus() + 1);
 }
 
-static u16 bnge_aux_get_msix(struct bnge_dev *bd)
+u16 bnge_aux_get_msix(struct bnge_dev *bd)
 {
 	if (bnge_is_roce_en(bd))
 		return bd->aux_num_msix;
-- 
2.47.3


