Return-Path: <linux-kernel+bounces-835536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AEBA7684
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B377D1765E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EA258CE1;
	Sun, 28 Sep 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYyKhnVE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFF1F875A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086110; cv=none; b=DZXVK4tTQ/USJoM4TaodVu/839JR//O0Inl6P2MLi88uuLwS04VNiQNaqCLg7u3vPsAYlBj2e3Q9UFBMWM93PJsPKBX7Yh7fYGvDQVGhQXj69xO8EoeFf9Mt9PtG1HLW/K4p+q+vVF2yEMdiwptep7caSJsCGtfaxPZfHZ8G56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086110; c=relaxed/simple;
	bh=RPEu8e4XCkPY2pLmJdc73bu5mi6Bblw8TU1IqAT1O4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aOO8zFLxnD4r4a5YwbZCDkXOH+0M+qTo6U+agRwFz6dLLRSj8XMmr3jEf6bIdk/Jxy2OQKMbshI1quNzST5np8XKFvcqNQoW/kf7U+4M5NBc/Y6h5nCzI4LzFla4yeMpl2qcyJ5Zt0Cm7n/Iczf8qiq37XczfhxguozJ8y6GSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYyKhnVE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso3696658a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759086108; x=1759690908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I79Wagnj8/O18vtzNLBvXOz+ty+xd3W7AiEb254seu0=;
        b=MYyKhnVE6V7pR71qumFP/KCJ/0WbbhhCFekP6XsxiOkbSfA8uYIz68797yKBZmf9Il
         D04DEPw3pMgK5ahV/0EtU9056brrvUnstxmm3xgu9IPhC7FdvFGxbGkR981XmCyDaOoR
         Z4zLx+9ROIBLPqWkDcgXQP0t9idFWoR+LzLJJ1q+njuBu4lsLIo1itfbu0yLojhCR8v8
         p8SWhFl8qUezkDBTtmp8RLaRdwqL1LkTBL0FIaNlk8k/hTT0Qhk+MmD2lS/bfbpRwbMv
         II8ogPu24J9gAB0eDw7hJA+A8qHJTp4KjYHNo/mSOXQBBBNwRVEZb0ORhPz/+fbW46MP
         VVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086108; x=1759690908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I79Wagnj8/O18vtzNLBvXOz+ty+xd3W7AiEb254seu0=;
        b=Hyexb1MFkjEWIZzX464WxytSrR6XxUT4HuWcA4vT+jSoZDzC5tVjCs4/uCIRgWBH9T
         E5o1LoeK3/tnrkmQFiwnZlZUyAQZr1KDOKmGa/q719sppEPNgk6tYZgKkz1fP/Fw3dhO
         6pLnHqHOnGm8tr73yG743NDTVyoTQSt6kLBAkZRL1bRbbrK0umyVAuxznGj+O0XAVg8P
         VAc8VYITO6nZkhFqincCqZfFso/N9vXG1vehzqCPpZzAn0fOSvqFq02+x1h1u/I787Xx
         QXkfW7alfAFiIemq7oZcYPSz3stwziJfyp6kxWQIwzyNiGMWJTCeE2w9iFYSO6CrcgZm
         PJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnJGD7rfOHCeilLwvOfAmTN9Kptw3HhmjdF/R30lf+itG7Kw+VJe5IlENgwsNAD8Jy8ko01pDkiKPHgek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhra6zQ8vfMlhZsUf4rosYIcaVgQqHOgY2mINkHD4tbsUT1Dhc
	Z9qbIx9tGQ/Ws5MR9TXGAhswRvXyQ72MGgTmMZh1y+h3bCC2FVOrLrwz
X-Gm-Gg: ASbGncuc+tYWaGSEPk1oDNdNnPwMmWa9XjJE05B+33+Dq/o+tQkoitF3umBZidYoALY
	QrFMkxhwxNh6vcSaKUefhFphsULuX3GAPYUALV4Pc/RIn1ABUHynttzNUSilfz8Qujr7lNuZN4k
	HrP+k0KK4po2i6LP7tcdYytHKhfcROcGA1ntaR+WuapQXSzJLZ/slXVYOAhLXHTrV7ekxY6lyGX
	BbG8jjJhSZP+RYd6TrHUY97aa7wd2HwJEddjf1dR6Yezgap/Ul3fVbZsBwRUbMxWlZem0JxZbRm
	+ZHM4NDFlAr86O/p3t+v8VY+geVP28EHxCQwfRil+oW284xHHOdQaV/wo30xAl+f7+hIx8sNIRL
	cfoy70IGFpUr4020w7Coj0DTYnlu62zERPkoIFG5AE0FiVQugc6w3nSzlKlTdqTh/ziA=
X-Google-Smtp-Source: AGHT+IEc2dfZk4XueBpA/vhO8PC4wSZ2gwbHX8LW4yim98oAg19DqgmTWCz1ul+VviYXhrkwDHaEfA==
X-Received: by 2002:a17:90b:380a:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3342a306014mr13768315a91.36.1759086107740;
        Sun, 28 Sep 2025 12:01:47 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be148e8sm14807455a91.16.2025.09.28.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 12:01:47 -0700 (PDT)
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
Subject: [PATCH net v4] net: dlink: handle copy_thresh allocation failure
Date: Mon, 29 Sep 2025 04:01:24 +0900
Message-ID: <20250928190124.1156-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to
a NULL pointer dereference.

This patch tries to allocate `skb`. If the allocation fails, it falls
back to the normal path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/dlink/dl2k.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
Changelog:
v4:
- consolidated into a single patch
- removed goto statement, per Jakub's suggestion
- reorder changelog for clarity
v3: https://lore.kernel.org/netdev/20250916183305.2808-1-yyyynoom@gmail.com/
- change confusing label name
v2: https://lore.kernel.org/netdev/20250914182653.3152-4-yyyynoom@gmail.com/
- split into two patches: whitespace cleanup and functional fix
v1: https://lore.kernel.org/netdev/20250912145339.67448-2-yyyynoom@gmail.com/
---

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..1996d2e4e3e2 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -964,15 +964,18 @@ receive_packet (struct net_device *dev)
 		} else {
 			struct sk_buff *skb;
 
+			skb = NULL;
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
+			if (pkt_len <= copy_thresh)
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+			if (!skb) {
 				dma_unmap_single(&np->pdev->dev,
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			} else {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
-- 
2.51.0


