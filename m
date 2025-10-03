Return-Path: <linux-kernel+bounces-840950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB1DBB5CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995C4485720
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59232D3EF1;
	Fri,  3 Oct 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAfvXdM9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CE2D29A9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458201; cv=none; b=a75R2Hlhu/dUkFLd2HhQJrcUdItI1rZeXH7T69/m8SM8Y9s9pwlIYVgFKDMwccqjmct4TpZ7JZv6rt+GoPF/MUwltpL1l/8DDcKEHcIsohEp8vGUjivjZTskYPPh/fEbZFt+6VvBZ6qhWbxcO5B461+v7ZEHY2Gpbc/bkgIH0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458201; c=relaxed/simple;
	bh=Q/GTZeowJZkPGr6Ii9Db/DUkP7qcFYhns+17KdephwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilP/Zi7JntCYdO0z5aiR01OF05/51tEA2Vb1J8CClcjHa1e5SIGdawmo0/z0YRlXkvFakMFKV78sjrSMsx5Yw9bcomqLmq34cFDOqr6H7Y2FlinL03TF42ye6lwoO9xP1ziF2ouQghTXTvxeTqFIWFLnboB8wLSrNjOkaDHvBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAfvXdM9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-279e2554b5fso12647115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759458194; x=1760062994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwM7hNvsHnNSOJ7+Bp5EcACbvFcp1Jo4CMapJ4a9hQc=;
        b=ZAfvXdM9MtsPQLlGgrNQTGRRYCsB2rCLKav4XaCx89caYrpUFjQ3z/yhxJquuYVx+l
         W1XZmadMHYE+VzCzSEczHNOSYy5X1X1SkTjDtscsP15qbRHNQ9e+bvyIq+519i2Lamog
         i4ADlqyO1dsla9Rs+WbrVgKc+62F8J1KG0oEujqhRMj3lTww/Mg/XHQlu+fHZDEDfrWI
         7ZAwehvQWo72oPtuNOXTKrtC/jgTN6XUNpGthC+XL8WIrnm7+txScP0vcSyXaGjajShj
         ijwitm6i6Qi8jMhfQ2CAhG2Qa4wawsMw74xlXrzrxGYC6HCLPTdnnrIucu4962CLLqNG
         CbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759458194; x=1760062994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwM7hNvsHnNSOJ7+Bp5EcACbvFcp1Jo4CMapJ4a9hQc=;
        b=S3zeszKH30lqgyLdhbdagf6G+CmvHAZz3ToYTcGbpRU5nNqCFgeUWhq8DiyzAlNi3R
         NO9BVn02/VEhrVrkoYYxnq3FxvwUYJK4MR2RcREe9kxnDI0Yh7XkZ4ZeZt/NIn441O+8
         zMKPL9q9R7JcMrrR2NCdblmDIZ7Qok1EkmRj+AH89G11yZqL5ru141y2sE3PhLK1eAdF
         NHMZbGsmd5yb3mkgDk4q7JBThnpvjkrxALOHMAW2e/Kldiuaw9+P5aHfTlt/Lb764Ltn
         BAFoJwUGtO8Tz0rECswaEwgl7azFwnvCj2ihvvm7bf+a0/f2KdJTZaO52P3nkeQnu+1D
         fDGw==
X-Forwarded-Encrypted: i=1; AJvYcCWjLoxA2yK9K7IlVHWtfXjC/lPzqT0lNmFmWBGH0CSfOoHskpTQUQJzxZ1ZGS+qvD6yP40xMNvDSztmedo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPp3AkXDJF9S8uUr3bR48F+gzPJpzeplSPv8+EsiJN9mmf9gm
	6yRf/aTdsQU9wZpJy7MxDSqkbgYiZIlKWKZsuaFdSorKSPVDxB7R2Zwt
X-Gm-Gg: ASbGncviUDHYZY2ty0izCXRAugX10rScmzYmXGIjhuY7U4Fdr7wlvKz1d8/DgMQcwKt
	+Rrv2y6KOIewAh8Wj20RKROtzBgM+6A2R+fLlLjw4E0B5J65sNDeppMd7FXWRZYl48QiU7a1Bt7
	UMngXGT5DjwLh2dkA1s8bIwjWwPUAAoxR+JCBNGhB+WNz7sxh/gcMYly9/NXJ0HLQ3oMEJRAgmY
	FUihAXd3CtXDV0tvIz27WBUtiTEgUTzqbu5uoHqPzibz9nNoasVnfkhSUOinSbIaww2sjXEQbsB
	lwldXhw6/+eYVxLxYim32ZOCpguWQXyt8qkV5WjgxQn5aoDi6oYeNtg4y4qqXz3Dd9g8nVR85NR
	IY0d8kEPDzLfkvXurMBUY5CLCVnh88UTNF4W2BNezhlslGpg=
X-Google-Smtp-Source: AGHT+IHtD468SsvQKxPqSOP+le5fRPrdW5RE6RHnWgwiYu2bpRmuPfQfabmTIJ6pacAdYun9k/hvRA==
X-Received: by 2002:a17:903:b46:b0:269:a6b2:2463 with SMTP id d9443c01a7336-28e99d87b0amr14739605ad.16.1759458194399;
        Thu, 02 Oct 2025 19:23:14 -0700 (PDT)
Received: from mythos-cloud ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d112797sm33850725ad.22.2025.10.02.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 19:23:14 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net] net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb
Date: Fri,  3 Oct 2025 11:23:00 +0900
Message-ID: <20251003022300.1105-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
which can be called from hard irq context (netpoll) and from other
contexts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Tested-on: D-Link DGE-550T Rev-A3
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..fcb89f9e5e2e 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -724,7 +724,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 	u64 tfc_vlan_tag = 0;
 
 	if (np->link_status == 0) {	/* Link Down */
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	entry = np->cur_tx % TX_RING_SIZE;
-- 
2.51.0


