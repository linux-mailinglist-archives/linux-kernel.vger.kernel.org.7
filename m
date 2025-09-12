Return-Path: <linux-kernel+bounces-814326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3AAB55273
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA60AC09C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35C3126C8;
	Fri, 12 Sep 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIzKm/Ol"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F631280F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688981; cv=none; b=PxD4ps/m3+QdsVIs1MfGZKtH44G4ZTAw0RxnLTnVmKl4n/0bEjisugtiyYrHDLOZry95z0xiAh/3Exen+U5BmFd6yySQHwQDurKT0bNmfAMzRqmozSuJNBLVeVyIlcbJRA7paHaZZUbCuigC2pAKo4c69m27EEVi0LsipQ3pZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688981; c=relaxed/simple;
	bh=5bychSERzZRu0Ga8fDtteTf82tNnxalxzUdhbU5SWh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2gbsrP3mo7TF+DqEdiDGWNZbcE77f/yGXTq+sNmbZYM99peP2HeOSK4B0ESx/TU31QKHP/TMzfz+HAO5HB9zJAgcbGOP268OlYjtVpdFz52qhRlF+D+r43lr5jXUsAQhKheRb2q0MEHhNQRF4yiSAUUivIhuBkHKBE0ZBEuN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIzKm/Ol; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25669596921so19129965ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757688979; x=1758293779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rg6DF0J93LU8FePNSoWpCTSyon+Ho3xdECyOIRM0Js=;
        b=BIzKm/OllJ8zWi4IW2lD8FnjACcau83CL1SMfh9ZJeSwOK/C5QR+TT2BAXZHMHJrY2
         60f3/lmGBP58K7LpLa+uBD0ug24vv6IclHu/AF9/9M+Si1T2NzQGWVaKmwWXeCRTqW7a
         K+H/jOwi7Vk31+0yzw22EQR63p+XqI6Zd22CpS4cqp067lbo5/AKqEmmnNjbqYl0rVTj
         zRoK49+zG5kyhFq5dNDjhpOuBUWXWXh5RtaeHxVrv6Xfj3OqskcdnIOxhuECaJH1Zgwy
         rDKyrV4uC2o8XrS0bTt76kDJUL5kmJdl//hxSOVt+V3nR7Oj00GFFgTEOKRYY0HSftSG
         VqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688979; x=1758293779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rg6DF0J93LU8FePNSoWpCTSyon+Ho3xdECyOIRM0Js=;
        b=uAE/bGrGjCmlKnkAsTif/ElmWzd2GO3tZQ3IlS2/rSeiFy/UJB6lymGDrPqJfDvF37
         10SCxFyb44sAcJYxTxtYNF5JafeCtAnWKOPrL6ZRt+Y8HL5NwuALHbKfbMbcG2xE2dSt
         gfpy1sHaGM1x0XH5+WD8v0ft6o9FcDIE5394nIH5taLsGcrllz5CpJ79TLp58sT4nLdG
         nfien6ju8LI9rFQW751eruNmyVIMGILu7EiIMStRIhqYHVaa0+aKEYBEV2jQWYds+kku
         sbWCoQ7VRkEpbvZbx1OpAV73Pfw+GekiIyFtmj3wBE1NP+AOyviCHIUSpHDFzOmc274H
         n/yA==
X-Forwarded-Encrypted: i=1; AJvYcCVstL8xf0kXHPkUuW409UQXuLYOoO7fnZdUcIYnVuKxX+mL6cRjFXavVKyaV0On+y4P35Uik3sXGNOu47Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhhppnlQQu02BuYCr0/UwmAXO1SzHT/y/P8Fn7GDoEAIRuJVn
	VyhMStglkLkZxpbi0QrXCgcrK8IXRPJGN+DdyG96uSfA573q+jZK3fPX
X-Gm-Gg: ASbGncsOTNAGANCSXnHSWGHH5eDCDa+vPRjvlUe/A0odIzeF440AAFUvOPXT4qvSpKg
	ofSlZXLxiOLwZwGfH04pBJ1o3oN/iRMVvEJnVFyR54BqHe2HZBtER6+AITH+JWh+HMNOqbCRSfl
	h6Z1VAvhqQf42KCDgEvMSth0nSlPO8YhxWj0L6x/YL0nsBdAFyCjdlMhLYIMHQGhb5yjy3/Jfxk
	uTGKSz6bX6IAbrEcXYVYxFjyQDwpJn99icxx2XONcF8fKhbrxdnfAPcUDOhoDQNi4x8jxAUJvsk
	7I6nYInSD+J6f2t6h5tT2xwUlKku5PdALSktO+mWYDEiAinUllJdD7G3lMP0DPgbUfBoc6LJfkg
	oUe/uFoGXFbaER06n+NrALLZBrBbrj08fYInWj56dQERRnQ5mbuLVzCeEtngSDcAjmyE=
X-Google-Smtp-Source: AGHT+IGiXFtqjikU8V69Zf2Ja2YTA63RXXh9wfLmsxrcrmVtFj+KeZN6bse3bgKpBr9gnSj742KUmQ==
X-Received: by 2002:a17:902:dac2:b0:24d:64bc:1495 with SMTP id d9443c01a7336-25d26c4670bmr34394125ad.41.1757688979158;
        Fri, 12 Sep 2025 07:56:19 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b3b5bsm5957854a91.16.2025.09.12.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:56:18 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dlink: handle copy_thresh allocation failure
Date: Fri, 12 Sep 2025 23:53:35 +0900
Message-ID: <20250912145339.67448-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 drivers/net/ethernet/dlink/dl2k.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..a82e1fd01b92 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -965,26 +965,31 @@ receive_packet (struct net_device *dev)
 			struct sk_buff *skb;
 
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
-				dma_unmap_single(&np->pdev->dev,
-						 desc_to_dma(desc),
-						 np->rx_buf_sz,
-						 DMA_FROM_DEVICE);
-				skb_put (skb = np->rx_skbuff[entry], pkt_len);
-				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			if (pkt_len <= copy_thresh) {
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+				if (!skb)
+					goto reuse_skbuff;
+
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
 							DMA_FROM_DEVICE);
-				skb_copy_to_linear_data (skb,
+				skb_copy_to_linear_data(skb,
 						  np->rx_skbuff[entry]->data,
 						  pkt_len);
-				skb_put (skb, pkt_len);
+				skb_put(skb, pkt_len);
 				dma_sync_single_for_device(&np->pdev->dev,
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
+			} else {
+reuse_skbuff:
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


