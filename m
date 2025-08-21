Return-Path: <linux-kernel+bounces-780247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C612B2FF70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF75E1D2545B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1122DA77A;
	Thu, 21 Aug 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TAIONkGf"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6802D8DDF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791333; cv=none; b=kISSt1zglD8mPEcqdwoeI4LL0Z/gFeiVnGmT9ky+xW2F/O73JItxzADFVKQIUPsoANs2jDmwsMPCRtRCd9sd2sDeIlBAzzNtw+ltDaIvOcMTM/VlrhKQCet5i5sf0Gvog5ok+qsSGtEj+jX6ChRG3jlk168PDkxJU4DhR56qfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791333; c=relaxed/simple;
	bh=e8tWfu7XJ/dciEndQxFGX/H1fPrdjqfzM1/VH1I/ynA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4UizzY4MdFNgPzRPZqJGCEFoETMDZwwrm4JXa0tdNV8jxyr9KufklTrooztu8dgXkr3AkreszDWgCKwJTKkntEsf7j7kw+9gNkdKf8KjMHYt/zjugl86NAvPr+m3rCzXXibfMsSV7lxTmlkHPeYG+VrtN/2mysQ/kCEm32bQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TAIONkGf; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3e56ff1c11eso5428255ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791331; x=1756396131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnXY64Xbv47cQNmR9ZiiLeZWxiI1/oDkLLaPlw1U/MA=;
        b=ozv+cD+o7H/b1+4LfEN4tcgYkJxVV8CyVx5mo8LOamsp0iEykXVIRHES42yM0thV3X
         AM57p3CVFZyeIebgDFa8+Rr9PCONws1R2IU3ePSM2oE4bqrDimpuxhQVwTw+wUZVATt2
         S+nqNrLBjhZdUIKcf8O+diqZe/hdPPt/dkwfO2ilbon3mBUuTGF3FV3d3Ypt+/W65XO8
         UR1YNF/bxbzT2oqSLYohGDdHA6GUe64d6wBmXwMTNJzi0RtyPxhc70zUUA7q8pAqgQhH
         yjzHG+UMI2N69MuQJ+njh+3T6cexoauEUEQNPMtggYa3o6g3KCX/iPZnCZhqyxzSpBb0
         RdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLLqkeE2fll7lvzfQqeb9H34IGfvEJQ9qW+taEDjGuFIK0xuMtaK3vhXRIKCdHRlS+coB89xkjq1J9LlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTxNBjY+lWAZju92POYdPqdZ6V5UlQcfVot8ItmMlJ7WzsZDA
	VcNWOPeGHGcVoIzB0or9yCZAc4OdkyIDdVw4hkz8gHPppobVJiUc3CXGv6Q4moXNdzA4NtdIx3g
	UJlVgPiEKwhwuC6kllpK/vxAPE/1vfdfE4Epoi2hKnL3zsagfyMMw8LhslcIm2nYwX45dFoOt5/
	/BDeIYJ0A78sNgyttSgpwTrlVk5YOCoBWW6U8geJp1/O9udNFx3+JkLHnHJUx71jR4x71fvazxB
	JKkMuc9UKFQlR65gXcrQwXdVPC3
X-Gm-Gg: ASbGncvC5s4y6XzlHb5b4tsJ712rCzoRH435FL4Ql/KPF6iwf4ipd2CU7Wug0UmQBje
	N7PkzuUHf7fUklwRGdIew2RyEI6XamW7waFoNoevQ/5SavpnwmZywaRjdCqz3j8wfFkHWfgeyuG
	iI+tRzg2suF8iY3ao1E2pFCZdyfd8UqXIteK67Yn7+RAFpmQwuyRnjbOmFatpMdd51ziXQ3wKW1
	napOVahOu3a3/4ZjSnm8rtL46zG/xk+pn47+mNyOj1mnI5cbLeCCShZTGDQNaxowCZ9eI2hzJ9u
	slSAJscMFk0GAT9vfWfq0Y6ByUfzrI3nYra7yL1ajf4U+aLrLP0Zh3WjXstG7faoMfOadMet8gG
	1Vx7JwgJfxsccIVZPu5kDB4BCWzPA8SxQGEbCKtpC+EWIKd/h0ufbFx5SAVZ/GgX2jlIq77TXtk
	cbuumOOw==
X-Google-Smtp-Source: AGHT+IGYvDTJnHp5uEk4WBnqr7qsKMiDZn+Mx5tlJjtIi9FPcht6jkYOPE9J81wsAC1P0ptOxkj5QWoWOpU/
X-Received: by 2002:a05:6e02:1567:b0:3e8:b64c:105d with SMTP id e9e14a558f8ab-3e8b64c1243mr21640445ab.2.1755791329581;
        Thu, 21 Aug 2025 08:48:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e57e775ccasm12502865ab.50.2025.08.21.08.48.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:48:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47173bb3daso955543a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755791328; x=1756396128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnXY64Xbv47cQNmR9ZiiLeZWxiI1/oDkLLaPlw1U/MA=;
        b=TAIONkGfzDxYHUJhhG75kp91xK9bTPNiqlDtwruHYzBU2EADWu8xYaxlA6qh8fzHMp
         zRzGsO4hHmY1Lwu96f6t0fUgorZTbskpyJ06ElkPyUiCJKZ+XJxLIAwCuG556CcvfqH5
         rMdbGRYYKRJTZ/ZSa/9dH/vOprbAVFnJmjB0c=
X-Forwarded-Encrypted: i=1; AJvYcCVbgfHvLPkWKi8OaSVpd2D3gILc95Y4wj5gLr7dUqikSkt9hTBmmKqWb8NalVfbUTtxv+aZW6Nl5t9Pr0g=@vger.kernel.org
X-Received: by 2002:a05:6a21:339e:b0:243:78a:8289 with SMTP id adf61e73a8af0-24330aaa91cmr4097366637.48.1755791328135;
        Thu, 21 Aug 2025 08:48:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:339e:b0:243:78a:8289 with SMTP id adf61e73a8af0-24330aaa91cmr4097335637.48.1755791327694;
        Thu, 21 Aug 2025 08:48:47 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b2d37sm5046894a12.46.2025.08.21.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:48:47 -0700 (PDT)
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
Subject: [v3, net-next 3/9] bng_en: Introduce VNIC
Date: Thu, 21 Aug 2025 21:15:11 +0000
Message-ID: <20250821211517.16578-4-bhargava.marreddy@broadcom.com>
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
index d8976faabd3c..cc7c2aa59fe6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -428,6 +428,123 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
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
@@ -436,11 +553,13 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 
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
@@ -528,6 +647,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -546,6 +669,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
index 665a20380ded..8bc0d09e0419 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -177,6 +177,8 @@ struct bnge_net {
 
 	/* grp_info indexed by napi/nq index */
 	struct bnge_ring_grp_info	*grp_info;
+	struct bnge_vnic_info		*vnic_info;
+	int				nr_vnics;
 	int				total_irqs;
 };
 
@@ -301,4 +303,32 @@ struct bnge_napi {
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


