Return-Path: <linux-kernel+bounces-815057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74526B55ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DBB565D76
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF2D2E6CC8;
	Sat, 13 Sep 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu3CWZJB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835D2E2845
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743439; cv=none; b=MbkPX7A8Z61Q1anE2bfw2+P00L5LchXzPubSwZHR4y+1iNs81BCB9XX1lkOCdxWQwnopI0esvZ7kkRJP+2xWCOHRlqDwYQ7po8/nNWk3fLM7YGO2J54wSoS/MVj1lT/GgeKR0XSJknsxdm5FtgLrRuKS2zW52T4CnanZZxnZ2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743439; c=relaxed/simple;
	bh=ix31eSL81pFOW9vzIfsqnpRQ/OW4z+xiuCQH9UQniT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnEmkFm51FQd+6XVb4iIpsoklSW55RQK2btWT/6vVE/AyeTmZ2b0TlhGugArQL+qnDpx8/3maWNeoO/ybmFEkzB2+q/JWmOlm7IMPzyQDRhs3MFHJmIewvVfj5TpJQVq4nY8s7cuz4cbuOq7OegzTu9FLeRsvakq6MP9szibaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu3CWZJB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445826fd9dso31598825ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757743437; x=1758348237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41Zu+8Pun+PpMd8x6mUjfEY70mK6ipIOPQyqQYxTK8o=;
        b=lu3CWZJBKw3WJX2GSKt1JXsZg67FitL42bfcsDg+psVq8AmVO1mi9sjARyYlvckT9a
         w+tceOy40a8yRz/9RAspkZ/4fUBdIzwPZjPqI/LvjM4HkTEe/dCiGn/8hWe+C2PS/Ju2
         dLEMjGMbQATPpqdijYjTUPvzAwWdmZJJd5tty25J+noivjKErHmq9a3XC+9RfNqrH1C0
         qLmKvL8aj38ICSi7gCHO9j+WzY+zOsppzSgIDv8KwxedJpEhGqKd48LarTXrmLP5xc2f
         vlPJsAWD201OVL6Jkrev0cFDsYfy65UXHzGDgrtqb7PfafWjyL8ZVBKo70XGbQ4vZUk9
         Oacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757743437; x=1758348237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41Zu+8Pun+PpMd8x6mUjfEY70mK6ipIOPQyqQYxTK8o=;
        b=r+WhqV3Wtim3ztduNhcSzRB+9NmHrGKhJZbT7DPV0BHGfgszLBMrXjrHw5fwP9E/ry
         ESZ6B3hyonxAHrG1MaQx6Drfw0XXmwdImF/8kBYX88G84tqjk9VwDBLPreCXUXULSzme
         Q/Qyd/HSHkwrUwpNETs5PqWBiYxvfwBJrQuhnacjDsly7NKR+Zgnbei3xSiJxfKWzElo
         lRdHDdqottd24/+ExT5fMluDxLCOAruV6+tKa12zmH6knNAhwvlGUJ5IBhCN8O6m35B8
         zJ4bENU1W2r3I9EvAbWYlAsd76E2zP+O6kVq9Di5fIK54ZGUuTBd27dq25vY9AOm3fru
         iKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVw96xUm43LwEc2JSLtHxMxmYTdH9qW1PPhXQ+2BbcGPiaJdDnkva/ntHWQrnrZG6ynzMnM3L0sgE+RGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbGFQNMtHNpQYlZv1+ffTuwLEGKZ9Fun42JlIQK8ec/n/MtM3
	Z4LKlBP/KD9qMB3P979UcONMPzdgbSndEdMFZqAZmgouaLcamxFbX6KO
X-Gm-Gg: ASbGnctc3V7moH2mXEPN6qMZMttGp+kKDBrTEi5g5/aAUMZVDcMGBG5xieU1WYaqGKV
	/XE0+k4TniIj9OEWLJ/AFD8qBAG4osBpBMeqFxEAuMfy8WL/Fa9Wi/wYbdoJz31i2DhQlS8qLFR
	1DKjOLGNYAvobGizAmO4JmsuZ6ZJrtZ6m9lml8Jf/mj3/h4QVF6AQMlUVMqBshpwdzBs5qxDXcg
	rkx6ZzfldTRxuSKSR6aSkmKQTqSxc1F2URAlwPSbfPDsUYFyOdgMvK+m++N0RvvqxrX2XWfZc84
	KRA3WWdtQx1kohEjKYdI54nqX1lVruwzguaRIJLAS2QOoxoUXGUi6WmtSzIPafKeQdF+Zu+0HLh
	OMZmFOE/IpSm5vT0/a8elKvR1jnXwPfZIw3Yn2WIgsiNtwrEaKvHUpf4dPq4ccl1gW08=
X-Google-Smtp-Source: AGHT+IEAfgG7M/u2SSxRv4ShiDR+vJqe2T44IbROgBQqdm+3/74ZEJbrOuuf/pP7mig0OgSHGmTtqw==
X-Received: by 2002:a17:902:ef46:b0:24c:da3b:7376 with SMTP id d9443c01a7336-25d261781d4mr59102455ad.26.1757743437016;
        Fri, 12 Sep 2025 23:03:57 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae29aefsm66340855ad.118.2025.09.12.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:03:56 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure
Date: Sat, 13 Sep 2025 15:01:36 +0900
Message-ID: <20250913060135.35282-3-yyyynoom@gmail.com>
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

Keep the driver update on `if (unlikely(!skb))`, but skip it after
`netif_rx()` errors.

Fixes: caf586e5f23c ("net: add a core netdev->rx_dropped counter")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
changelog:
v1: https://lore.kernel.org/netdev/20250911053310.15966-2-yyyynoom@gmail.com/
v2:
- Correct commit reference in `Fixes:` tag.
- Fix incorrect commit message.
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


