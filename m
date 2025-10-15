Return-Path: <linux-kernel+bounces-854730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA5BDF437
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4439F508546
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147862E2846;
	Wed, 15 Oct 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFolCHif"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0672DF14F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540450; cv=none; b=AqE3lJlkHhmH3nlFr3oEmotYL06tlUSbq2fwT/Lsbenv2i0eXJsOCcR2yGrLAT6S5nd04G9F7EOAZlspccB7hpKf0SYyoYVyS3wKM4JlABdA5w06IG874za9n49YjpMBm7HqqHCBmLIf5v8u5nd5UekScOw6EwMPfacogMTAEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540450; c=relaxed/simple;
	bh=1ShMRdTbyDSVf7pqsdAORgM79J4ZDuzFz1jBYSkMUvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhTQtU6IPp8WtSteHcuuXmvSh54aBr/io32pVFSDDrIVckGZ8LoCZ28hMGdWm1t1D72WHIzdEEvJ4nJR7DMHbe6qVp6oSxdUpQ0bu/7SFhYnmB7hNYUMS306mtJD/ueQIBzBF6QAbVtIoXnK8A+STSIorxmvJuhj2M44XBdyoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFolCHif; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b631b435d59so4309048a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540446; x=1761145246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcN7xHLFQ6AxuefucwRNxxqod6+m4WOOWIEO0t3msa8=;
        b=CFolCHif5jS0keBzaeKZcU89/jwqWYtMUxgc+rz9RhS2zEmC62u6248Dw3sEIYJsNo
         W61wBRanUZBUrhAKK92jC/mu0L1OGdAU2XWbSzK/3uWJ2Tywm/VJWrRhr9fxU/q28kOb
         6GwOiEn5JxJGdAGK2Y41dXYtlE9b400512HTmZz9t6kctKDKwwWf9sGTXIq2mHc3//0Y
         /Q/8FNc0pLFfamMOrxS8EPt/hEUXvJd2mabUQb/wWwnlNpKrAPj9xVI5QFA/VyH+QfEP
         gv2yQSmEEb6OsKtKdyAe9vOSthk86v6pYk22RV3mAIVjKOrQFcWVefUj5EjywVj/+USK
         zYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540446; x=1761145246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcN7xHLFQ6AxuefucwRNxxqod6+m4WOOWIEO0t3msa8=;
        b=ht4ulamdyx6MwFJ168AHhd/NKwzLtrKhKI9iVpa25AXk+pUQ03zzGMZrEsDbYQ9BEH
         KBdWo6e9aO3yWVST+7IA/YA9t6YmFp4mOIRGJxELg0Xo2zH5d6nX+Vws5FAvxCteUcJ6
         MvQAE8BHcGgq045na8GWIQqtCFSLfPDoi+usfUtWA6740g+6vso03/wZRtaMej/+tu4z
         Rs6kGDhjOpTzUtmI9Xrw4caG5mz5aS5PcgvalNqnD+B/B9nyKC1T07D8h8cdOiYz5PHR
         B8dLI9qweR0ELrUW2uU7lzaBOvLdAX/b+vkyruYEJXfoe7nQYjJktMYV94nVTTthPDVR
         r4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUzKyCiM6y+MMsyKB7CWy1w8XJhGLLlUcrC4ju6nvXz6BB3mdZq4dO8hCpYdPt3VxIcW8aCsHXvwkeHea0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcU8yOVWzYXr72yhRe0AbnVCxDIxWwOj5+Cw3jvJ6qsKUyy9HK
	y9eVp8FrUqv3MDPxIRxNH7pbUOKj9P74esVwXQg4Qc2OnJcE2lBeg3vK
X-Gm-Gg: ASbGncuqh2I3MkErJIndS35MOSOMkdlSKpKe75qXfEMU4tpXQWy0zgJTyOIwPwLqEnV
	xHRrUrQ7Gstsnlq7BDHT5vA+KK0i+v8HI8cp1FGFny4R7+5c1AgqEdF1j5RrM5XQ3ztwFJmOfTi
	3+FEru+IpYkV4yprQPF66mAqUfi0Ux/jcOaf80Oq/QGymQCIJ7qnT//hYv0kXQXxS0RkJJrNR8d
	onzKlMht5tl6AKTsyCuRMkgr9J+KMDPETztA7pOoovZ8/RDlH9JRozbJBjWARZGpcTyTEOdyMkJ
	IKKnM9piQrv7PlPHu4sdLXxEKNrdkG417Tj6cxVVAUndVQrNWp7PZ46LMXq1WhuApt9cCSi8MJl
	jHfGH4Uaw42435/GHbVTjTpWGx1jd1fiZNmh0qf4HRh6KeiOsMCMqR9kCKtT8e8E=
X-Google-Smtp-Source: AGHT+IEbg7lRhXatS+GuMWToc+DoO2Ve2zohsoo3Z0vRNjtlax1PilyTGNvxx+/BzXyTA+SajDOrNw==
X-Received: by 2002:a17:903:1b64:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-2902737c7ebmr376277035ad.21.1760540444609;
        Wed, 15 Oct 2025 08:00:44 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36408sm199642265ad.91.2025.10.15.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] net: ravb: Make DBAT entry count configurable per-SoC
Date: Wed, 15 Oct 2025 16:00:24 +0100
Message-ID: <20251015150026.117587-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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


