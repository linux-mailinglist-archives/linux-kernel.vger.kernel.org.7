Return-Path: <linux-kernel+bounces-819432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161BB5A090
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125951C04694
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70C290DBB;
	Tue, 16 Sep 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcji2MQq"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE92DF15D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047609; cv=none; b=Gynazo1R66C1mh2NpPQX843NQBIKiCGrWvRyzXe5fBMJ0w6qGDIrZbW6Cu27ybTTbWpv8DV+ThDL89D4CXwwvcuMUAj9p4VVLZnU0yLn3y68xJGV5MmH8zsqQuyj9XMulSU04CYK1TvHw7tl+diqW7d1tW1BSv3kQCgst+iTsUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047609; c=relaxed/simple;
	bh=ngLz/4Ezk/tubDYx/Lgk6Dje8hW93S4AUSflPV17tVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSqK5shClT/nqiars4NaKs+7NRZozx2ZqbyhL+JY1t8vUcvrJZEQi82yv3bshVfQ+HmZd1COp/McA5d++1R6CltG4jCdJxgsds/LAIKfPL5uVdhZtb8lBKIfwdR3PUClGAedE1iba8PknSAzTjRX62zueFpPHBaxthBik7dCk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcji2MQq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso2050612a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047607; x=1758652407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6Ht+bpIkPjtMXWp9XgtcAPi+mKoELdBIJyuizZRIWY=;
        b=kcji2MQquAD2JVt3OJKRrf1p8vg5M4YNXVvx/2sM60eL32dFKXxY9sAi32XwlFC6Gf
         xUyyBj1T3CueFhlzMzSNXRYYDTbvAaZLyNiru5ePn9r9k8olxyGvoqWvESAQCXLXVE5J
         RiV4OPRX9MlwEgUFB4NwJFtUxXN8mBFEpSJuqV//oFXYe2teuzvo0DBjrOpsRuWMS33m
         UZWgGPujhPQy410EPBa5z8tX+7TpD8iW3/y1fWxWlxoYqjmGnMIrflmwrmD+EHx4rwAs
         EaCcVZcru25bg9LQ5dDL7NzDF2TcyYEdWulvl5uyKvLZPulaCG+6jL16TCNZSBc19tSg
         BgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047607; x=1758652407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6Ht+bpIkPjtMXWp9XgtcAPi+mKoELdBIJyuizZRIWY=;
        b=Xm8OovtbS8bsKbdjc39B0FkVZusVE1GXf2AW9oIsuXHdOqC8JPiuDcdGOhiaIVCc9S
         V/MmuicgMzLZa4wwiAvnz8b+pe+48qSNrYDhFrWULxsZB+jkCGjx5tC6YbPmzu4C1MsE
         duz1kQ90x13WcMKvjIVRas7xxGn33+Yn1rG1Ea7lSaRefEi6LpEqPHzztgwdNOtIPeoP
         dRcKkEtNu4pOOBJWWDYu+1lzMQ7e1Y9QGBkej1F4/mtERO9KtD5ZqN+MHEX32VU6ePky
         EZV/yjPPblzbX/5BEt4/QJZ0WSzv2yiEvSa0iM5vAk4xWld7rnO1B9kgnM3owywMvpIM
         /LPw==
X-Forwarded-Encrypted: i=1; AJvYcCWb9dfwmvYS9zQQQF2F4It4DPNA1n3Xei4NAhnGynMSUAaer9N4/J7wLVNcsmC47aHMbpkiGGJxs6KeZ10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkvl5EFDv17+PxQkw3e0fYPGgg0DOxT/hlpBJPLg9Wo3sUagQb
	oXLG3pgXav7pPiELld0tyKh+2as01USsCJxZPgBeB3TEavZbKtBtqzmr
X-Gm-Gg: ASbGncuZqBU8keXZT1JAKlKyOCximTXiwSNnqXUfWLAWPq8ZtpFaTGUNgdmN5b3df1W
	d+1TypJJcLR2dqRimtVpmfOIRYvL9Lwxkwt95cJtJe2yBBOBMcJ/VRXUGHKIbeLrfpo9Ym30i+M
	y9SRJeEDb/4AuiqTUSlTdrDFGKDVA9rHDMhq0bNb1zjfSAsoGXbALx4MZOPEj5OYxJhpwmIJhwS
	1T/j6I0cjzMgr220K6EDKQ4lH4p8i8qvZwsT16zJZh2SBwmfHg2IrUSt7UVKWtTRv6kVGMU5KzF
	WKmre/KqqDlwUhbJJ11GIturMImGGSpXmO5T1dxpdhf0wATY9wVdCNKyI7IRkruU4UJdZpij/zr
	PxlX8LPywx53wqPjaq5wGcPMWxG1VW4S5uE2FR7CRDK5TWRuiHpBCEZPY
X-Google-Smtp-Source: AGHT+IE60FRNbaIgGLpS7RTlhNopZLjGLrwDqgS+R4ggALxBYN8fkG1Oyxxw7C+bn8mbnje6yiDdYg==
X-Received: by 2002:a17:90b:1fc6:b0:32e:1ff5:5af4 with SMTP id 98e67ed59e1d1-32e20049fbcmr14219148a91.35.1758047606752;
        Tue, 16 Sep 2025 11:33:26 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm14915968a12.33.2025.09.16.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:33:26 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v3 2/2] net: dlink: handle copy_thresh allocation failure
Date: Wed, 17 Sep 2025 03:33:05 +0900
Message-ID: <20250916183305.2808-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916183305.2808-1-yyyynoom@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to a
NULL pointer dereference.

This patch adds proper error handling by falling back to the `else` clause
when the allocation fails.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index faf8a9fc7ed1..cff90417c05c 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -965,14 +965,11 @@ receive_packet (struct net_device *dev)
 			struct sk_buff *skb;
 
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
-				dma_unmap_single(&np->pdev->dev,
-						 desc_to_dma(desc),
-						 np->rx_buf_sz,
-						 DMA_FROM_DEVICE);
-				skb_put(skb = np->rx_skbuff[entry], pkt_len);
-				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			if (pkt_len <= copy_thresh) {
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+				if (!skb)
+					goto fallback_to_normal_path;
+
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
@@ -985,6 +982,14 @@ receive_packet (struct net_device *dev)
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
+			} else {
+fallback_to_normal_path:
+				dma_unmap_single(&np->pdev->dev,
+						 desc_to_dma(desc),
+						 np->rx_buf_sz,
+						 DMA_FROM_DEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				np->rx_skbuff[entry] = NULL;
 			}
 			skb->protocol = eth_type_trans (skb, dev);
 #if 0
-- 
2.51.0


