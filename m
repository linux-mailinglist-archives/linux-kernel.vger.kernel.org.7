Return-Path: <linux-kernel+bounces-812764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49876B53C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09278AA7DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66036934E;
	Thu, 11 Sep 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iE0YQHpf"
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57153680AF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619342; cv=none; b=rU6AhO9PQ9SCn9JoCBmFPJLNfZ9DjyAcDQ6YQR25YFiSzWuSDKyokbOqx1CWS7bFuZd+kfTDaM23AhbsRaiyhyFJBjzV8WiRnZAkzhPq1J3ungcjscEkjtQfiyUZwv14xAV8Tl0FJfvPYd9OZNRMUJznW4z2cf2m3rd64jDDU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619342; c=relaxed/simple;
	bh=L6tIgEx/MCVx319fx57U40bBW1wG3FCU6bChrvaYdT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGLAZvVadK8IOGj2qpxT8W15LDzPIHB3dcF1/tnV7gHwfkeHpuI6WZzN3/h6bNlRUy3TzH5qwXnd8mxN0iEP6VbqXuT7kfHiC5TuB+/zmwxz74dK5/uBBkMm1QDqXG+rF3UDnhJKIWNGwAv5ylI0OSm3BCDNKCe0QA+Y2wPczfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iE0YQHpf; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7742adc1f25so787286b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619340; x=1758224140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7bXnrdBFhD9jlD7jd+pgJ0HwtePtGZ00MytlnQt1xY=;
        b=liwVv32fvh+WUy0FSDuWAUXT13wEnOcMtbnF2qXkIboqieQm0rLXCdlF4/bGdAnTcc
         7lR8uojf4QMuzF0oy7+vUkdSLylj5Sd5Y9S5hpZkkOvZo5fpCsH9LjDQ3P6Qbx+YusGV
         1GNM5LqZGSZQCU8FLTGv3apTBr6qsRA/3nkFJEKvUoauTK6Rd3yZvJmwGOD/qPxHcc47
         JA4/ObVimHn00J9pui3cKzLqvJpVBjAdCh6EySpWEnvI5YsaxbFREYOwpyH4nlSYXj/J
         GrSVaZgj1wstT4d3Qxi6kSwhACHctViSDl/KAJlxtQ2zbWfWNkj8HlnVirEfpyIbJv5b
         G0yw==
X-Forwarded-Encrypted: i=1; AJvYcCV49Sx0J+yrUHkNU9hsTdmM8wqriIFxVUKiwap6LrmAwc+dydyNkl35TWniPDocq/K5UfIXWH15pBYHOfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5c+VqWmaYNI6DwEBBdY2lq8XllMjb1B8lJlUJlXdmaHt/tEzW
	KqD+/jL/aO8rto7HTo46eYS49yREnmoD478S58CiWlfTgZOXVVRPVObV+TYUtaoh22vPjpwuGn9
	70PsuaBwXSg04eatQgnKBxlcqn6/W8Ze/9E3fHIMSGRHFWgtbMk/z0OAXX/FMR8uV2A0lqbMcNT
	UYgUANxo4mxvPss3xfctlO93aL9/emEe6SFQLofd80gaD7O1+/OjRjf0Zool1TzvmFbTj92gvaq
	wGY4xEWWjbGiKbA3S3FLwEvyqxP
X-Gm-Gg: ASbGnctgA8ztR2qIe0DkX5xZCrzXrq5ivOcU0Yl1jCm5GgbCYljDRC7F75yqGigRQgX
	C4oV7q9+ZjjQlQeiAJ1V9/o1m07nvhKRf60YArc9ZbKoOv126JlLcYbN0C+tQgTiawyCMVKztEV
	E+TpWret8MMW7KrrRD1JxfsBa6/j3k5lOTjpJTHTzsQ7fMZU2abXD4p9kXwujaXccnZZ5jhtKHo
	vMz7z/wDOxZ9BzIBG52J6wVhJhCgDaTNr7njoaoAktfLYIhFRr81dr0uvJVzxAH8NhxyRIZMTEv
	TfX/klr55WkapEY+dT53fGoGQiJ/PlOLDBNpTDpkK+tEEqQLwDMRoW8t/jfAHSUtvDe3f1Mo8Yl
	M0gIC/z8/wGA6SlHI6JnIOjU9mzhq7ylXoAU7X5YjJB5jNpIbSxmYvQFrj4xmyeCi1y1HshsOSd
	BkeKV6cMC9
X-Google-Smtp-Source: AGHT+IHzaRxvAQV4Oruijh4f0s1HDxDzmpZuALT5bPjM7p4Yneo45yRhCkPFQiRUqBi63M3umyCP63nchMbt
X-Received: by 2002:a05:6a20:7f87:b0:250:f80d:b355 with SMTP id adf61e73a8af0-2602bb59d29mr524409637.33.1757619339815;
        Thu, 11 Sep 2025 12:35:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b54a3885c1dsm160960a12.17.2025.09.11.12.35.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f59889so13056445ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619338; x=1758224138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7bXnrdBFhD9jlD7jd+pgJ0HwtePtGZ00MytlnQt1xY=;
        b=iE0YQHpfMCLslSLWmlMi6jQxhpPIBsDBVaaTDDbalS9t9t4Arv3evJxyINjQjqJxRD
         nsdaxIwiCu1ZGQDiedNF30UgM53Wi0jC2lltzRHGlYOF89vA/HUU6vCrkvsPtPkxvKlO
         33EnhYyWyS3JEU6UQYhal3pXbPWxh7fdmkJ0Q=
X-Forwarded-Encrypted: i=1; AJvYcCWE23FLvYM6gLJmvPkZuH9sFc/4lIS/uxOQfF6vPsl9DKKM16e1IBFrXW3M5HjtITIoFaUTkpnCz76yhe0=@vger.kernel.org
X-Received: by 2002:a17:902:d490:b0:24c:c57d:36a2 with SMTP id d9443c01a7336-25d249c3596mr5928985ad.13.1757619337943;
        Thu, 11 Sep 2025 12:35:37 -0700 (PDT)
X-Received: by 2002:a17:902:d490:b0:24c:c57d:36a2 with SMTP id d9443c01a7336-25d249c3596mr5928695ad.13.1757619337455;
        Thu, 11 Sep 2025 12:35:37 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:36 -0700 (PDT)
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
Subject: [v7, net-next 04/10] bng_en: Introduce VNIC
Date: Fri, 12 Sep 2025 01:04:59 +0530
Message-ID: <20250911193505.24068-5-bhargava.marreddy@broadcom.com>
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

Add the VNIC-specific structures and DMA memory necessary to support
UC/MC and RSS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 121 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  30 +++++
 2 files changed, 151 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 615f9452725..34b0c9d6cce 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -437,12 +437,122 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
 	return rc;
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
+	int i, size;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		vnic = &bn->vnic_info[i];
+
+		if (vnic->flags & BNGE_VNIC_UCAST_FLAG) {
+			int mem_size = (BNGE_MAX_UC_ADDRS - 1) * ETH_ALEN;
+
+			vnic->uc_list = kmalloc(mem_size, GFP_KERNEL);
+			if (!vnic->uc_list)
+				goto err_free_vnic_attributes;
+		}
+
+		if (vnic->flags & BNGE_VNIC_MCAST_FLAG) {
+			vnic->mc_list_size = BNGE_MAX_MC_ADDRS * ETH_ALEN;
+			vnic->mc_list =
+				dma_alloc_coherent(bd->dev,
+						   vnic->mc_list_size,
+						   &vnic->mc_list_mapping,
+						   GFP_KERNEL);
+			if (!vnic->mc_list)
+				goto err_free_vnic_attributes;
+		}
+
+		/* Allocate rss table and hash key */
+		size = L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
+
+		vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
+		vnic->rss_table = dma_alloc_coherent(bd->dev,
+						     vnic->rss_table_size,
+						     &vnic->rss_table_dma_addr,
+						     GFP_KERNEL);
+		if (!vnic->rss_table)
+			goto err_free_vnic_attributes;
+
+		vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+		vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	}
+	return 0;
+
+err_free_vnic_attributes:
+	bnge_free_vnic_attributes(bn);
+	return -ENOMEM;
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
 static void bnge_free_core(struct bnge_net *bn)
 {
+	bnge_free_vnic_attributes(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -529,6 +639,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -544,6 +658,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		goto err_free_core;
 
 	rc = bnge_alloc_nq_tree(bn);
+	if (rc)
+		goto err_free_core;
+
+	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
+						  BNGE_VNIC_MCAST_FLAG |
+						  BNGE_VNIC_UCAST_FLAG;
+	rc = bnge_alloc_vnic_attributes(bn);
 	if (rc)
 		goto err_free_core;
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index bccddae09fa..115297dd82c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -176,6 +176,8 @@ struct bnge_net {
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
 
+	struct bnge_vnic_info		*vnic_info;
+	int				nr_vnics;
 	int				total_irqs;
 };
 
@@ -300,4 +302,32 @@ struct bnge_napi {
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


