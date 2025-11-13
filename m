Return-Path: <linux-kernel+bounces-899928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA7C59122
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4439345C35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38D36404A;
	Thu, 13 Nov 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="VkVAJciH"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A62D5C76
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053144; cv=none; b=lXTwC6GiCb1AlKLy9RfzLkadVlCjJVOyCpnoyNLEaJ14+kzxObFTQIOAxa9089XFBgyKdlRfmi8AKpK5QV8aWzv3UaD0RxLaYeCsHwHUL9/N1xprNVIYXgfEFmuFYvC+1C6sapJZpcr/4gFQ+C5shJMePAXn0RTKTHDyUHLJvU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053144; c=relaxed/simple;
	bh=a4D/KXYNw/8KDDVIrRVsePn4NnMGqm9FVy4LsiCY7aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGCY0ufjqiWNgdkGyS/2pKCsTPDtpTxJKsXOWluGYlvSWTOr6iBor/YYKyojwyMf9o3ztcYDtov318486K6XmNIxzeyaWV+8UKjmDFx59ZK75M4QT7amNJ5cXeAKUT7tHpD89hgu8UdXNjjG/PAzBuPrLmPJIUtlmol67EdC1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=VkVAJciH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so860213b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763053139; x=1763657939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpAI/e+d+gimI71xP+kZzple2mX6lW+bMxn4vDREkbk=;
        b=VkVAJciHRqQgxapdFThc1hb70loQqwYdcWJNjsa/eLrCdl2He51Ckfjhffa0P81rH3
         spi7q/+7ipdPrafiM0MV29TAlzB7LawwfdpMosAhytxYnxQTF8TotxRo5RoA2vhLnHee
         C0juh06q60g1QoVUA0jURex6UyaCsfzJb5P/Xo7kWi0t/Sk59o9gg7Mqhk8YGgPnaCZ2
         KjuHLj2aue8JnWUaWLC1B+CuUa0XSVdYSsl38D43ONiY0Tl1SCItpl84pMmwKKDIZngp
         D1UQ5YvMGE7ek5bCfY3Sk+aRNzY47PpXdZNi9+DEiXQRSsTrTN/3yVSPkP/tt8sohbRH
         pULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053139; x=1763657939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpAI/e+d+gimI71xP+kZzple2mX6lW+bMxn4vDREkbk=;
        b=GTG0kE6wNKxi4uBEtAYLetmIRr1uZSNdedGPvMzRu9OEAUzoycjqezorgQjp7SWV7z
         WICFvt5+7WMH5NAcSN0k+WIPLwBFXixiZkZ+Zowavwn/yvhP3K03IglEiqFjmqmBFnPd
         t4VrR6QGc0iU/SLl29OjCu1+/q2Xw5839WpBuGtpp0gCly5ypUg70ze76DOr3CRcM+e4
         TLbvir2ArxkKW1RKg/aOlpj7J62qpqOqF22NKpoayppn90072CmFYwOCI+QAXsxgjeei
         or9iGVgBI5Y9zS9dSEQ2Pl8y83DOHp62N9RTVpAobPZDYlCqTmL8peF96Q25JjSdgRiI
         lqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhtlIPnHLC50sBP5DuMKNxnig17WWEZE2fJ92Rxmzd9YdWlG9bjUx0psQqHe1mjUa44RkhVVFEoq8DQik=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrmv21//fAFw4rvG18y930FkFU5ckQxQZhG/wembfAWEqASl3E
	DWDiY+hrJjG7UMl1194ok2+hJ/JUzn0CyAK2hyalrRSxjYT07Ji7JMOh6aeQ/VhCNV8=
X-Gm-Gg: ASbGncv9qTDVLSALrApNmk/uIVA6aUy5WBPu7qpSTNjRBFu+tPI5clsqz6OaGBJ2GdS
	w4Sv/4V6P1GOlIlVsAmH3rn9nGV71PkwSkMEFCB6dSSNELGn32UtEtHQGmKzFl4BN1f8DexRLCD
	cpwhmT1w0RWHYg+esYwKGC0t7c9+NP8rhwXRZfnO67HYG02ZpKVX5HL6SC9VK9yffBD/GVq3tYd
	eAzP4pc+AEIKDX3hOsbGdqBaMrBElb3yy0kmH1iYX9uFbhOT3iyaexFHxhO7y76ESqBOadJDY8J
	1km0YtrPooMO8FR7dZQmmiduzfY17nzCP7FtSfGlEx3un/JpaGb2OQD9BmYWEh6DeOdk58N6+Ai
	zLqs2PTN/gfgA203vDtuOsF4Mfbu0sLuKYcggzb4Pfh6+zVD3VdRpv4sBYoFJqi/o10auuAodmM
	EKuOBPY5HSAnr0yJYd1w6tzEEVFyLzJwY9j3k=
X-Google-Smtp-Source: AGHT+IGajXo8qyfi3TAyAuUGqLr/c/kTCvTSdHx/BDP0w4C2sHDnRL6+WEWKK85bouAnyPxneU8dJQ==
X-Received: by 2002:a05:7301:4303:b0:2a4:3593:6460 with SMTP id 5a478bee46e88-2a4aba9c042mr46555eec.16.1763053138633;
        Thu, 13 Nov 2025 08:58:58 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2a49db102f5sm463857eec.4.2025.11.13.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:58:57 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: linux-wireless@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtl818x_pci: Fix potential memory leaks in rtl8180_init_rx_ring()
Date: Thu, 13 Nov 2025 22:28:49 +0530
Message-ID: <20251113165851.39054-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rtl8180_init_rx_ring(), memory is allocated for skb packets and DMA
allocations in a loop. When an allocation fails, the previously
successful allocations are not freed on exit.

Fixes: f653211197f3 ("Add rtl8180 wireless driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.

 .../wireless/realtek/rtl818x/rtl8180/dev.c    | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 2905baea6239..898611ccb400 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -1023,11 +1023,8 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 		dma_addr_t *mapping;
 		entry = priv->rx_ring + priv->rx_ring_sz*i;
 		if (!skb) {
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
 			wiphy_err(dev->wiphy, "Cannot allocate RX skb\n");
-			return -ENOMEM;
+			goto error;
 		}
 		priv->rx_buf[i] = skb;
 		mapping = (dma_addr_t *)skb->cb;
@@ -1037,11 +1034,9 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 
 		if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
 			kfree_skb(skb);
-			dma_free_coherent(&priv->pdev->dev,
-					  priv->rx_ring_sz * 32,
-					  priv->rx_ring, priv->rx_ring_dma);
+			priv->rx_buf[i] = NULL;
 			wiphy_err(dev->wiphy, "Cannot map DMA for RX skb\n");
-			return -ENOMEM;
+			goto error;
 		}
 
 		entry->rx_buf = cpu_to_le32(*mapping);
@@ -1050,6 +1045,19 @@ static int rtl8180_init_rx_ring(struct ieee80211_hw *dev)
 	}
 	entry->flags |= cpu_to_le32(RTL818X_RX_DESC_FLAG_EOR);
 	return 0;
+error:
+	while (i--) {
+		struct sk_buff *skb = priv->rx_buf[i];
+		priv->rx_buf[i] = NULL;
+		dma_unmap_single(&priv->pdev->dev, *((dma_addr_t *)skb->cb),
+				 MAX_RX_SIZE, DMA_FROM_DEVICE);
+		kfree_skb(skb);
+	}
+	dma_free_coherent(&priv->pdev->dev,
+			  priv->rx_ring_sz * 32,
+			  priv->rx_ring, priv->rx_ring_dma);
+	priv->rx_ring = NULL;
+	return -ENOMEM;
 }
 
 static void rtl8180_free_rx_ring(struct ieee80211_hw *dev)
-- 
2.43.0


