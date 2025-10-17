Return-Path: <linux-kernel+bounces-858294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F2BE9DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 687825854A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1592F332EDB;
	Fri, 17 Oct 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEB+lmEg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071E33290A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714353; cv=none; b=tuii0s1PX0bCzYNKR2KmYPfqJGSaYkKSTjqBjY18w7Ux6DtHb0aHTM3wskiTc8/HT53Ckdp05/JfQhVExcmgQz/hHIlQB+xJYEcX/+iLY6sVrz7AL/rS587S/DC02XDqJ+uD+cQ0tY7eN3wgkZANMwCEp/6IFdL7Q3P9krgdwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714353; c=relaxed/simple;
	bh=Y3zs+7EWEpEspMjXG/tv7lz3qsoFqxSawHyRTh14OuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogcYmYYDAk6SQFCDF6PfamvQWw0b6Yi0K++aKI4CZ8GZxhEsNMjyBuxCT684F+i1vtSS7Q2F8/SAGC5rPIKmNce06ldE2yKzbYXAVwPE+n2LGVTQaRNtL8/SUC4lH5mFW84EiV/xS6iI+3avspYXRjGkyk9gX5qhVkHoSTTsFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEB+lmEg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7835321bc98so1999666b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714351; x=1761319151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJTkF6pHkRbGTiu8sME46LOjNVi5j+piyfVUn5/1Bzo=;
        b=cEB+lmEg8kNIvbXTdD56Ue+49eRAmYxVRZToWjjebKvwZzhm3ViLKMyMM/XmZmtiQO
         QgNw7MSXaCSvokm6j8FkU0rrYH2llMjyHCubBPnkTx6wNZ45iMQwwpH0/EUyOogHPVeA
         rPB7BZB+EjGFdVzi/vVxZuGtojcYDJCCLsZhUgZvrrAJd4Aom7H54lBvistq1o4Ba1CO
         TNDf18lKqjatfmKnQtxGekDrtDgT6o3lsL1an0rTaN0NOJoRw7cNDpgPwJxKVjEYkdYL
         VhrLxOayJIflwyjLEAf/dlKzFq34rzwgMF00mGN9jli0oJVk9CQAP8tYXQVrosxd+Hdr
         F7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714351; x=1761319151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJTkF6pHkRbGTiu8sME46LOjNVi5j+piyfVUn5/1Bzo=;
        b=CnE3g7ZURg88N6s8LsKTFgs4QwgEiP3pU6byEPdgrernmmEEC6wP4YirnR6ocUAHzK
         Ztp+u30ET/stXPcVwmsyJVeAxdwDhxn70Wv9oMfvvSLJDRT/e9nsa9SW5y5Jha7q5yO9
         7/cHdJgQ+fiOvVHW7Nb1/1a79f5VCa56LahvDm9h75LA1FKsQoltgUbWWqNF3oV5ZZmY
         u1AQMy/maiSizWAaNyyLAxICmZAdAm7/Sso98UQYXaY8VcJLKdmMtaj06LFW35Dahl3M
         uZhtUyaxbmMFPHKufGBxWuFCWKMwlhcBNIeyG5GNEHwIXRpLGWBlwNX+Kxnc4VI1dzCq
         aPoA==
X-Forwarded-Encrypted: i=1; AJvYcCUZNnvM+rUlVcx43LfLS65YR3fFoHCnT6Y98ny6GJX2I0qE3rWf//NMVvtZ8lAfBeJGvn2NoMmGHd/31/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQ5ENTVFJ73t8HxcYYF4Ygt1MEKH4au4YoHzqbOM/8iGg9q83
	xVLvhFqe/mbkoSyg8v7Lw7k/f4lw3CAH1hwg63pS3NtWzCubR7xqZLYS
X-Gm-Gg: ASbGnct1RjzzH/IJLtQQ7WAKH0NejRYVeGcUsjym/EtoMsvYkk0jn8VGZnzBzfGl/Og
	y8/rNJPdvGsQbdhzNHgR6Dcpv+jW0SgDweFDlJmEHUmVrORSAv5zUupWrmGWv5kvdTmEJ/gGCkv
	c4TGc7JNqn/YMwase5f0aSVmK5u+I/KeARtotqrI3dHS4qEUKK8By3IlR5yx+rMrjKO7hPvx8rA
	luw4SEwHrxpTF8t+CbCm6Ueu5dyXsQ3y/ck1Q8yBmFB8qBPq/80Xr/z/zJkitCKu6QYX2zxbvW5
	G8UTeI5FXkfsw9rpuLEGruKkvJAYGYJpwO71CJO7jwGjvV56FVWeKmGsseVGKE6qiHmutQE1Cbb
	cVsxOAoRmBuN4bOJHe8lwWeepoU59M9eM1Pwo1hKOQe+m1tHgrXnZypjBwuXnMBmfT6TIkFYE+9
	exSClTaGMESuZYTZ51MxOG8w==
X-Google-Smtp-Source: AGHT+IHOFgRPcJ1MQt4p4gojjUhnLxP/yD+ItR7pcwk09VIMA1XE/ri3q0HvKCSg10K8XvkIfs+w3w==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr52578495ad.0.1760714350743;
        Fri, 17 Oct 2025 08:19:10 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:19:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 1/4] net: ravb: Make DBAT entry count configurable per-SoC
Date: Fri, 17 Oct 2025 16:18:27 +0100
Message-ID: <20251017151830.171062-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The number of CDARq (Current Descriptor Address Register) registers is not
fixed to 22 across all SoC variants. For example, the GBETH implementation
uses only two entries. Hardcoding the value leads to incorrect resource
allocation on such platforms.

Pass the DBAT entry count through the per-SoC hardware info struct and use
it during probe instead of relying on a fixed constant. This ensures
correct descriptor table sizing and initialization across different SoCs.

Fixes: feab85c7ccea ("ravb: Add support for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v1->v2:
- Added Reviewed-by tag from Niklas.
---
 drivers/net/ethernet/renesas/ravb.h      | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 7b48060c250b..d65cd83ddd16 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1017,7 +1017,6 @@ enum CSR2_BIT {
 #define CSR2_CSUM_ENABLE (CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4 | \
 			  CSR2_RTCP6 | CSR2_RUDP6 | CSR2_RICMP6)
 
-#define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
 #define NUM_TX_QUEUE	2
@@ -1062,6 +1061,7 @@ struct ravb_hw_info {
 	u32 rx_max_frame_size;
 	u32 rx_buffer_size;
 	u32 rx_desc_size;
+	u32 dbat_entry_num;
 	unsigned aligned_tx: 1;
 	unsigned coalesce_irqs:1;	/* Needs software IRQ coalescing */
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9d3bd65b85ff..69d382e8757d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2694,6 +2694,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.rx_buffer_size = SZ_2K +
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
+	.dbat_entry_num = 22,
 	.aligned_tx = 1,
 	.gptp = 1,
 	.nc_queues = 1,
@@ -2717,6 +2718,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.rx_buffer_size = SZ_2K +
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
+	.dbat_entry_num = 22,
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
@@ -2743,6 +2745,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.rx_buffer_size = SZ_2K +
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
+	.dbat_entry_num = 22,
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
@@ -2769,6 +2772,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.rx_buffer_size = SZ_2K +
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
+	.dbat_entry_num = 22,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
 	.gptp = 1,
@@ -2794,6 +2798,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.rx_max_frame_size = SZ_8K,
 	.rx_buffer_size = SZ_2K,
 	.rx_desc_size = sizeof(struct ravb_rx_desc),
+	.dbat_entry_num = 2,
 	.aligned_tx = 1,
 	.coalesce_irqs = 1,
 	.tx_counters = 1,
@@ -3025,7 +3030,7 @@ static int ravb_probe(struct platform_device *pdev)
 	ravb_parse_delay_mode(np, ndev);
 
 	/* Allocate descriptor base address table */
-	priv->desc_bat_size = sizeof(struct ravb_desc) * DBAT_ENTRY_NUM;
+	priv->desc_bat_size = sizeof(struct ravb_desc) * info->dbat_entry_num;
 	priv->desc_bat = dma_alloc_coherent(ndev->dev.parent, priv->desc_bat_size,
 					    &priv->desc_bat_dma, GFP_KERNEL);
 	if (!priv->desc_bat) {
@@ -3035,7 +3040,7 @@ static int ravb_probe(struct platform_device *pdev)
 		error = -ENOMEM;
 		goto out_rpm_put;
 	}
-	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
+	for (q = RAVB_BE; q < info->dbat_entry_num; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
 
 	/* Initialise HW timestamp list */
-- 
2.43.0


