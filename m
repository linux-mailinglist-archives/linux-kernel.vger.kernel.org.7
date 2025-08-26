Return-Path: <linux-kernel+bounces-786532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E7FB35B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB103618B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009E33473A;
	Tue, 26 Aug 2025 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F/p0X0gO"
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6E326D62
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207062; cv=none; b=UV5HVrzE5bG67+l1aHb3C0tlCXFp9mcuv4nyjTS+mxN5naX8RK0/Ylvg9ieb5fvB1AHKqA8Bs8yFRolvAmA3Dbtr6dvd1XEWK+CSxGVBmIZWZVVPMA1eP6WIq3jWtwux5Af3JmBB7VdWi7WDZOegZXRkUP5op/b1SYRHrbdVRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207062; c=relaxed/simple;
	bh=XlLyj7rZf5KsGmuhexlk6nMmm7t2yenU56+p7ThNrNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr5orhggQeVPPIMMIxVZIxI1f+HnXjssvuHIv6+HHIZhyCzPSftAhGLO2GA6OfjRR4cA2qSEcWlzHiWWBPivvHsVL9dS5ejVeljxbVMymFfoDX+j4SgIbCahN32PszTjjMPHmm5Cbs+PWfBvaVSqLsSet27lbA+3gEcLWuKuhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F/p0X0gO; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b49dcdf018bso1650911a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207059; x=1756811859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9e3WWDSFnG//VNy6zmZa5SlrYsFAEv8GUUCleCwx38=;
        b=RpjtlLYltlRK+kdpH4Htg9tmb7Z1nk2gZluNROvIQMXPUjRDjNljr5xtj976Okj+v6
         /PIgGs6CR9ANG+J5wqAvZDEQL6fjdL+ynZrOS0BE/82UF3Tk01pk3udmIOuWXBM54HKe
         vHpG2zZIDDi9EdHTBo+SbFgxS7NjDrPwEfWcIQo5mXGizjyIY2RKF+VzsGhK6eSSCN9d
         l2ymqniW5HRDYv3VIIGP56c7/jTQdaP9FQAjMl+IS37hX4PmQouYN8Kus953Xm+jhs4G
         6pGsOXu2w49Q65A4WxTPuuhXh9FJkJLiBP1RgPjbGxZoWXmRa/CRZWKXNO8VdlUk2fNz
         AO2g==
X-Forwarded-Encrypted: i=1; AJvYcCVCmdGkrD9E44myt68S6uxu/MyRpUb7wjz/V+Hj4IL5v8mEa9HYuFFt4maROqTE5DvB6FQPJhDUXzyGAn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShvca1n1n+6h0dHTMvzGgevvbuT6fsmBTbC+bj8sskXvTk4Ae
	SkwGgXciBkl1TgOkBq7zuoNxjNeh4a2S3J1cNlCTbtxtLYttecoo1hZB1JBKqld4j9aRV7q8CiM
	w4IEplxUQAFIoj0a1ZotN/aboyL/KQKoi6bMjOtvvaSKAp0tQbYOUryNQlzVcAMjl2Ri7qE7ojn
	a+BZPe0NKwkA8uktOAfhELTodjT9k2msjogkZSAe7Kq6Da9Efx7EvjrtngWqPqnUbhNTqKNt/GQ
	eocd1LnMzzQkhG7ng+/o+XGeRiI
X-Gm-Gg: ASbGncvSGWGyW4+9GmSTkQMwuKxGM+HDeT0zqp40BOM5f/9DY14pkgfJzZMsMgcAdb+
	alQ2t3PMRp6BoFfUsZQzx5nDUq2KyfmWaENmc06o6QdLDxbO/rMoILCX7OA82zmjKhc3ICKPDMW
	afMPlYCos+t0INs5wzVmShn02nSFzF/Gkb1Kgj7V2rDjpW6SF01PtF3q8lHh73PbOXbf7o/6OOc
	Bw8oQqb+/7u2VdU/znZb37uU4X6DajKp6M/nRiLf88gJCUDmsK3xEdGEe9+1Akdd4W5QQ2cNfM5
	60U6q2ylaOqGCqGq9QbRA0COd9AQs4LSmPpk9ROBXzyOTEB6k2frJVE8iUz17B1CLWkf37GM1cJ
	zugIZIjhZnJGAuVGIIUtDecsXAZl3rA==
X-Google-Smtp-Source: AGHT+IEL4yLQkvKx8/J8pov8gQBpvaq9j3QuIy9/xTNureVplTECZMPfxTfMZ/+01GyQCXbWchpzF8Q9Bkal
X-Received: by 2002:a17:903:24d:b0:243:3fe:4294 with SMTP id d9443c01a7336-2462ee0bf56mr226687895ad.12.1756207059179;
        Tue, 26 Aug 2025 04:17:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-246688ae6c8sm8361105ad.80.2025.08.26.04.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-771b23c098dso1853507b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207057; x=1756811857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9e3WWDSFnG//VNy6zmZa5SlrYsFAEv8GUUCleCwx38=;
        b=F/p0X0gOFZmzfdmJulQ7OzoAOvR3NlCP4iZHXYLm2+UXp8edA308TILlT0nkmpN2gl
         9GCjq02kSaSqeOHkKnm2BUFsvADCAN2tlgiLpzDVp7UphL3n82nEnuOhTwDxpBf7yASs
         toTnnOd5oT9GhQ2ZD8VDPIkYDKIQNb64XVOD4=
X-Forwarded-Encrypted: i=1; AJvYcCURRIWbYvxrP5hrxbmO9O53qvkj7j0BEw9Drzl72jxfNEr7aKr7WVIohCEzMcm5s561xkCNTQ2cE7KthTg=@vger.kernel.org
X-Received: by 2002:a05:6a00:b93:b0:771:ea2e:afe7 with SMTP id d2e1a72fcca58-771ea2eb94bmr5853507b3a.0.1756207057346;
        Tue, 26 Aug 2025 04:17:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:b93:b0:771:ea2e:afe7 with SMTP id d2e1a72fcca58-771ea2eb94bmr5853475b3a.0.1756207056918;
        Tue, 26 Aug 2025 04:17:36 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:36 -0700 (PDT)
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
Subject: [v4, net-next 3/9] bng_en: Introduce VNIC
Date: Tue, 26 Aug 2025 16:44:06 +0000
Message-ID: <20250826164412.220565-4-bhargava.marreddy@broadcom.com>
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

Add the VNIC-specific structures and DMA memory necessary to support
UC/MC and RSS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 130 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  30 ++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dd56e8b5eee9..4f09c6aecb0d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -435,6 +435,123 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_free_vnic_attributes(struct bnge_net *bn)
+{
+	struct pci_dev *pdev = bn->bd->pdev;
+	struct bnge_vnic_info *vnic;
+	int i;
+
+	if (!bn->vnic_info)
+		return;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		vnic = &bn->vnic_info[i];
+
+		kfree(vnic->uc_list);
+		vnic->uc_list = NULL;
+
+		if (vnic->mc_list) {
+			dma_free_coherent(&pdev->dev, vnic->mc_list_size,
+					  vnic->mc_list, vnic->mc_list_mapping);
+			vnic->mc_list = NULL;
+		}
+
+		if (vnic->rss_table) {
+			dma_free_coherent(&pdev->dev, vnic->rss_table_size,
+					  vnic->rss_table,
+					  vnic->rss_table_dma_addr);
+			vnic->rss_table = NULL;
+		}
+
+		vnic->rss_hash_key = NULL;
+		vnic->flags = 0;
+	}
+}
+
+static int bnge_alloc_vnic_attributes(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_vnic_info *vnic;
+	int i, rc = 0, size;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		vnic = &bn->vnic_info[i];
+
+		if (vnic->flags & BNGE_VNIC_UCAST_FLAG) {
+			int mem_size = (BNGE_MAX_UC_ADDRS - 1) * ETH_ALEN;
+
+			if (mem_size > 0) {
+				vnic->uc_list = kmalloc(mem_size, GFP_KERNEL);
+				if (!vnic->uc_list) {
+					rc = -ENOMEM;
+					goto out;
+				}
+			}
+		}
+
+		if (vnic->flags & BNGE_VNIC_MCAST_FLAG) {
+			vnic->mc_list_size = BNGE_MAX_MC_ADDRS * ETH_ALEN;
+			vnic->mc_list =
+				dma_alloc_coherent(bd->dev,
+						   vnic->mc_list_size,
+						   &vnic->mc_list_mapping,
+						   GFP_KERNEL);
+			if (!vnic->mc_list) {
+				rc = -ENOMEM;
+				goto out;
+			}
+		}
+
+		/* Allocate rss table and hash key */
+		size = L1_CACHE_ALIGN(HW_HASH_INDEX_SIZE * sizeof(u16));
+		size = L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
+
+		vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
+		vnic->rss_table = dma_alloc_coherent(bd->dev,
+						     vnic->rss_table_size,
+						     &vnic->rss_table_dma_addr,
+						     GFP_KERNEL);
+		if (!vnic->rss_table) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+		vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	}
+
+	return 0;
+
+out:
+	return rc;
+}
+
+static int bnge_alloc_vnics(struct bnge_net *bn)
+{
+	int num_vnics;
+
+	/* Allocate only 1 VNIC for now
+	 * Additional VNICs will be added based on RFS/NTUPLE in future patches
+	 */
+	num_vnics = 1;
+
+	bn->vnic_info = kcalloc(num_vnics, sizeof(struct bnge_vnic_info),
+				GFP_KERNEL);
+	if (!bn->vnic_info)
+		return -ENOMEM;
+
+	bn->nr_vnics = num_vnics;
+
+	return 0;
+}
+
+static void bnge_free_vnics(struct bnge_net *bn)
+{
+	kfree(bn->vnic_info);
+	bn->vnic_info = NULL;
+	bn->nr_vnics = 0;
+}
+
 static void bnge_free_ring_grps(struct bnge_net *bn)
 {
 	kfree(bn->grp_info);
@@ -443,11 +560,13 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 
 static void bnge_free_core(struct bnge_net *bn)
 {
+	bnge_free_vnic_attributes(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
 	bnge_free_ring_grps(bn);
+	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -535,6 +654,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -553,6 +676,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
+						  BNGE_VNIC_MCAST_FLAG |
+						  BNGE_VNIC_UCAST_FLAG;
+	rc = bnge_alloc_vnic_attributes(bn);
+	if (rc)
+		goto err_free_core;
+
 	return 0;
 
 err_free_core:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 8041951da187..7c56786f5a71 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -178,6 +178,8 @@ struct bnge_net {
 
 	/* grp_info indexed by napi/nq index */
 	struct bnge_ring_grp_info	*grp_info;
+	struct bnge_vnic_info		*vnic_info;
+	int				nr_vnics;
 	int				total_irqs;
 };
 
@@ -302,4 +304,32 @@ struct bnge_napi {
 	struct bnge_tx_ring_info	*tx_ring[BNGE_MAX_TXR_PER_NAPI];
 };
 
+#define INVALID_STATS_CTX_ID	-1
+#define BNGE_VNIC_DEFAULT	0
+#define BNGE_MAX_UC_ADDRS	4
+
+struct bnge_vnic_info {
+	u8		*uc_list;
+	dma_addr_t	rss_table_dma_addr;
+	__le16		*rss_table;
+	dma_addr_t	rss_hash_key_dma_addr;
+	u64		*rss_hash_key;
+	int		rss_table_size;
+#define BNGE_RSS_TABLE_ENTRIES		64
+#define BNGE_RSS_TABLE_SIZE		(BNGE_RSS_TABLE_ENTRIES * 4)
+#define BNGE_RSS_TABLE_MAX_TBL		8
+#define BNGE_MAX_RSS_TABLE_SIZE			\
+	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+
+	u8		*mc_list;
+	int		mc_list_size;
+	int		mc_list_count;
+	dma_addr_t	mc_list_mapping;
+#define BNGE_MAX_MC_ADDRS	16
+
+	u32		flags;
+#define BNGE_VNIC_RSS_FLAG	1
+#define BNGE_VNIC_MCAST_FLAG	4
+#define BNGE_VNIC_UCAST_FLAG	8
+};
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


