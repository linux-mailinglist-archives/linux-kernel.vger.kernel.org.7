Return-Path: <linux-kernel+bounces-811371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DEB5282B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70E7467CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7724BBE4;
	Thu, 11 Sep 2025 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP33kpdB"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A2168BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757568928; cv=none; b=bHGMTxBUhmOo4KK2ozcrPDJWAX/yrkRyL90Sn5Tt3I3roGli0q5TmjWsOzRUfQ6eHsuyAyqpGY9GTxVYqnjAET5QFg7B9k9sF0qkov2jiXUsJ5Fl5z4wc4a6z9v3++QuZ9RGfhf4dk/pTU5GYSvvIvU9fVDQxrBcSiqm4YYSf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757568928; c=relaxed/simple;
	bh=6DrPjUxSOEgm8/e5jYNWy8+QPMe1YsQxP4QOcSqpuc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgV+yrSYuN5CGwnwFwjN8hT2SytYmxxU2kGRYWrKTh8mZPCO/jPP6e25RSTrgagDAA9zDP7o6pFc5QYiK0me1MalhWWCiFvxTo74aMubsiDbtiH4yL5Wr9NbAJ6T6C21eSA3iPQUwaXJtNzphIVKVRjYh9m5qBNJUDfeRM+BXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP33kpdB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso270081a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757568927; x=1758173727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suFQLgQPBBm2YGkpmXAdEyvaJ71aivqrwO9lscWhiYI=;
        b=YP33kpdBOoVX3HaN3OPchqgz6UDDO5OGDYj6TqK2ZSLRCw+6e/iGFQf8GPwP3y9Y3Q
         e77YkmTyPzyW2goUOUvLfi8qSfclp/X5YL12qYjmkTNWGDZmq6GxzEqG+dcwBNga+Uqo
         5LXTeyh9pEVSuFJ/82pWtP0oFZY0TU6kAhqfj82PypGPIvDNZlTFQEw7ZSxHB6d+28aF
         uvTYsq7iC4OOkEYJvcXDPRV9Xa2NMzrBgCLaHLlSoClRfW8sU/NFGZjR4buAJKOTQ4yV
         aN7t4srm1CjWMGskQOXIxsrSgm+sU90+9s2BuKUm/KukIya/C+q4k8oCyAeiiTPMXtqA
         qFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757568927; x=1758173727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suFQLgQPBBm2YGkpmXAdEyvaJ71aivqrwO9lscWhiYI=;
        b=b0qP4TuOKk0CQu/6rtJGFK9fgpRe64hvUmlgEtDHhHuPVKpOaWpd0LcBjWkZ55ffvY
         7NrGszCiPS1NXaVsGvEBnNKXlH9W1TMXaIuntVXJ8NLQm8uvkfaBFNHyZkkHSqo0V901
         QyOm/VB+O45x8Sx2J4qzQM+XpAA6LcXBzePMpw8iyshK/wboRA3y1ArOEPhWFtLfhJaC
         HVyjCnhfQeYW5G8fWzX8lWYsYiRfMkuBJifiAyyyVgg+nqnUVI5esVpNOYo2GDuaboCc
         JSGzgyktEBISgFF9qF7UTaUTJcLav+qTaanbPH+Hk6vcfpKB5tVRSolKiaX8zfqkMHMT
         7O6A==
X-Forwarded-Encrypted: i=1; AJvYcCUVydQmB+txfiCUMTsb/CufCbjN7FQtyvYfRu/uZezn0yoki6TqfqMubXXKcrjpI0RQu1JF98aPblraoqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8G81CwpLVEZ7Bo+rO638kZ2iOAXeqs7uu+IafZxqhZnsTIhA
	6CX0Mk1f7g67DC0Mxv9uMdLizWHoDc8ZUf3cCoQuAbVBJyUCA/MOI3wO
X-Gm-Gg: ASbGncsQ4REj9gIhyUbhWsfYv7DaIubSttuSJmyRV5rfj9OquRlFZw/YlB/73d8bh3r
	oEgIGkJ/Y9kzKlF4zh590DChhVzFCrlaQyEV7AV7kUk/b09EIj33QwdfQ5w2ZMtwJrGXPL/+Veu
	PiOOxPOB+bQmGyYFGCJcLoqk3L5rzKI3NvD3D0VNjzDIDQELIqBA9hR6Lva3lXvSPLIKKDtEE90
	NKS4BOmNONUTVpKD/Jz1uXLlLkQRtw4LaZLznKckqcO2sh+bxb/etueTA2q3zLHAsIGDdeXmUhm
	j0wBxJp7dJSIfmZIWhciDZnagRU+KCAo1adH2EzJN1LVEA4hqYnbGdPVqEBRgflKKgLwI33aQIv
	qu7xQSTYtqLZOi8bvIpOJ3EsGw/2zdDwXQ43LpvfNlIZtRfjhQS40zuK9
X-Google-Smtp-Source: AGHT+IHT5xn38H3fMN6Zaoo229Z03xpz5XUH4md1BuPQ5jXuX3HCubak/42RqKopAPQHAbDo2VxkTQ==
X-Received: by 2002:a17:90b:1d4f:b0:32b:4c71:f40a with SMTP id 98e67ed59e1d1-32d43f7df43mr22634192a91.24.1757568926662;
        Wed, 10 Sep 2025 22:35:26 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98e7621sm618953a91.22.2025.09.10.22.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 22:35:26 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure
Date: Thu, 11 Sep 2025 14:33:06 +0900
Message-ID: <20250911053310.15966-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`netif_rx()` already increments `rx_dropped` core stat when it fails.
The driver was also updating `ndev->stats.rx_dropped` in the same path.
Since both are reported together via `ip -s -s` command, this resulted
in drops being counted twice in user-visible stats.

Keep the driver update on `skb_put()` failure, but skip it after
`netif_rx()` errors.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/natsemi/ns83820.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index 56d5464222d9..cdbf82affa7b 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -820,7 +820,7 @@ static void rx_irq(struct net_device *ndev)
 	struct ns83820 *dev = PRIV(ndev);
 	struct rx_info *info = &dev->rx_info;
 	unsigned next_rx;
-	int rx_rc, len;
+	int len;
 	u32 cmdsts;
 	__le32 *desc;
 	unsigned long flags;
@@ -881,8 +881,10 @@ static void rx_irq(struct net_device *ndev)
 		if (likely(CMDSTS_OK & cmdsts)) {
 #endif
 			skb_put(skb, len);
-			if (unlikely(!skb))
+			if (unlikely(!skb)) {
+				ndev->stats.rx_dropped++;
 				goto netdev_mangle_me_harder_failed;
+			}
 			if (cmdsts & CMDSTS_DEST_MULTI)
 				ndev->stats.multicast++;
 			ndev->stats.rx_packets++;
@@ -901,15 +903,12 @@ static void rx_irq(struct net_device *ndev)
 				__vlan_hwaccel_put_tag(skb, htons(ETH_P_IPV6), tag);
 			}
 #endif
-			rx_rc = netif_rx(skb);
-			if (NET_RX_DROP == rx_rc) {
-netdev_mangle_me_harder_failed:
-				ndev->stats.rx_dropped++;
-			}
+			netif_rx(skb);
 		} else {
 			dev_kfree_skb_irq(skb);
 		}
 
+netdev_mangle_me_harder_failed:
 		nr++;
 		next_rx = info->next_rx;
 		desc = info->descs + (DESC_SIZE * next_rx);
-- 
2.51.0


