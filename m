Return-Path: <linux-kernel+bounces-819431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42393B5A08E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F8232371F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABA2DE6F1;
	Tue, 16 Sep 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgC3DJTS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B202D9488
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047606; cv=none; b=H0zBOgBe0zTor6qlp2RLLdChtcn6jIw49kIpzk+a2zMefEXHqwlV7RuTrqlojIMvzylPkoQe/6zwKpSQ/rPBWIqgY68rxv5qjuOsnupmWlPe4ahzz7hdpXeviwACAGyjEHCnIEOSxjj1uLcuSQ+TuFMdxh+dE7ZMslez0m9RTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047606; c=relaxed/simple;
	bh=BlV/zHkqjQf+ifev6wIKglqCA5gEeZLAyIwo6fmUPNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7rWorO6iADvKBBAA2X9HH6oXUS/8uuTWAriw16ZueE6MK5JXKY5FBb3wY9//jx2xJpGkzUx46mhIVfOEx8Tjfw7mwyF1YaRAEBIc/NN246wqhAB3TpJeDiHmaGv+9SbPGs6IMK2+XUmWMIFxMl3GsxdyPYN0TnhXv3dFIkx/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgC3DJTS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso3646509b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047604; x=1758652404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6NAtqurZPuJVv9MlI+fsRcvLTmzttrSsdFVWoHOXaA=;
        b=MgC3DJTSAbbAaWK5aNgomWWhN8rU22YE+QUx8HerMxfXvRDKujKr1jxsCdHp4nxsBu
         ZweHCbMjAEr1hYKk/gd1AwF0AKa+6yl+5S/+b/1nxTKoH8XGm0TITx1owect2EQN7sNz
         5qVifne7tp6JML1YuOQpywvGSWOBSMYAZqb2yDX1rJSHgzO6ulkbc6955LOBM2k06Ucp
         Cd0E3OBCdeKMAB6xlJp4EuH9IIhjKZdR+sVKjBiWFfeltr/XVStChqM/w3zmSEwFHzbw
         j8dSnFOO8MbnpC6fkwVHD7twPEILuzjXVmb6qzk2gIugOtBpi0SEUKoucrckR/NrBs4o
         7wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047604; x=1758652404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6NAtqurZPuJVv9MlI+fsRcvLTmzttrSsdFVWoHOXaA=;
        b=WUW6Y2GF/LsrP7fjJO8kaF7RTlyFgyHW0tQUaZpYaKZYVbmNnnN3hKYEOjOKjSgq3x
         fEhLHn4larQBb65Wd12nsjOAp+BGMI00fhPNKTCSAel5xASKK1vMslbMwolnzKfyht9x
         KOBnf8eHb72iMtFEQBc7RLATZIZntCzdWt084iV2mkb94oXKByHu1tnFp2Msu49qSOjc
         aWPj8ZaeA9INeG4gt098Z1ZezVOtBFLakG3J9BMeDRBi8ITdbc9j165zlZA4SqK+kepG
         IBicRbtYhtYjf+FHLK9pJ2b6x5adp4xUK63SVqW8OWzfkBric6CEfwh58u8B8yN52mT7
         KHyw==
X-Forwarded-Encrypted: i=1; AJvYcCV3E0eLidZsxg8ZPJuvTZu3IAsMfqHRxHK+dvw3VS8D5wKCadC7of82KZTS+DMdfUSKbmfhSi8W4B5EdEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPzYPQWNp/8jJEafm85Mjw1XsRWDD9e8OYGbUPb6gVzMRi/0z
	m+nU94kRQ63IcNtWl+A4WNbka7c7dFwIprUU2WLvb8KFU8ZUbaxuCiax
X-Gm-Gg: ASbGncsKJLNnGN2GOCT5ntbF7IGJt+4pGziRb1WS+zSFiaHXSqrwufjhnF4fCfzFT5g
	Mg3Z9Edex8I2vhiZEoYyFRks55vWo/lFKoINvhYTpsLgsRhUtsu/6pTHjAf3rqd9LcTeke0v6pq
	82cn0f4JO4zoMOJ+2ZMsb3rB38m9Orcawc7ewbEngiziHaUx4HcsPoz9gIW8HF6KJBXM6BvlrqM
	rSD3vNGypKaUm3kN8hl7e8HGddDtq1oY/u54HKJukuMz9LTHT40ZV4vf+Ev6MM/n0+pkq9zBW9H
	9jZbpPRUByFFrNHdRKwlevvR3dnWdMGWa5Vajr6iKO7GOA64+jADVZq9cJlbHv6gV4TGdVGeuZ1
	4te3PNl21e4k1ZlIqGM7KLwGYAzpyv/ei1Rl2efTOezYD6AWr16E7kvM6
X-Google-Smtp-Source: AGHT+IE+y04TgsnGdr50srE5VJlDF11c/nMrRpgKED3As1DNw1hUFMxhvslMP2AQcq5t/31wHspodA==
X-Received: by 2002:a05:6a20:7f87:b0:262:7029:107e with SMTP id adf61e73a8af0-26270291299mr14807680637.4.1758047604237;
        Tue, 16 Sep 2025 11:33:24 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm14915968a12.33.2025.09.16.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:33:23 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v3 1/2] net: dlink: fix whitespace around function call
Date: Wed, 17 Sep 2025 03:33:04 +0900
Message-ID: <20250916183305.2808-2-yyyynoom@gmail.com>
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

Remove unnecessary whitespace between function names and the opening
parenthesis to follow kernel coding style.

No functional change intended.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/dlink/dl2k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..faf8a9fc7ed1 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -970,17 +970,17 @@ receive_packet (struct net_device *dev)
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
-				skb_put (skb = np->rx_skbuff[entry], pkt_len);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
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
-- 
2.51.0


