Return-Path: <linux-kernel+bounces-814454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E3B55451
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C6AA24CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80207320A20;
	Fri, 12 Sep 2025 15:59:36 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAF31DDB8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692775; cv=none; b=rQD9JQGwK0Gw93f6RsYjYIrnA28peXiv7vYwHxTr8YsWp5/oMbocNEKMle2h7207V/+YZCpIHcS0yb3Q34NEKI6zqh2EqfdtA55D36b5UBka3tHgqmQbShDu98iRkysABCMwdPROyMKX5zeLJ2pMvGKy87gKhdATJjwGbl1KHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692775; c=relaxed/simple;
	bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2A9NQKTFjmj7AtyqRiGkANN16ZhhVvLwXCbSvsglx5qGEj7Jml/RBpQ0zG4HaBFQUvwLm6j4LiD8pn6xwKBCt2ahCqQ1vdOhsQuFYSX+wP4D/QFtEMA2bSMoSvIRbYiLFZWCgVvKXLadSFDHHCzv4437mqYNn2sUeaKTPf3USI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0418f6fc27so362728566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692772; x=1758297572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNdbybFK0ieLurW9tGv2v5Ky8Nf9YctW4a1t2pmLOlc=;
        b=W9AFu+AXxJg4Zh7i1LVVAGCimciPGXERJE7onPhEao3s2VE3nTCQ24Bst54wW/+Qym
         2cNSPjCyiXmEJa8zKPsD5Wpkr7aY/QqljAA0fEnNDkB01+CO91JGSgMkbf/D5+l4D21N
         Q2GvUwRIN8/8drs4kdIOqGWYTSV00NXurJ0X+Zx539dhi3hcN6D8FaHRmxyZdK/WanDo
         DuCtlROzEs+AP2xT4ogCuMe1XwUmh0VW4AHz56aKkfalrr01FBD9Enmj7tTycWzCNSTO
         +XSk7h46FnjAQJxNYU84VqpURKiAfutKJYwGbWkqBhGtJzSvi7A4JOskm40a1R+1V9wc
         5P+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFFzqmuvOxxixfQ5Q+VrkeSp0qic07DA1mYBHMnFY4/r5FTa5KV+oj01a73j382cVjDr+JDBxOyQ5d+uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7LYDff1vFB3n+ulBbMMzXIa1NcEANWywdiVHgQ42CODZF5/q
	mma4lgX4L7W5JXUbkJf3bMUL0Lpzk9vjVMompqe36yS3/ibzZol3I7rb
X-Gm-Gg: ASbGncsm1sPQXB2kiWg8aPgRtjObC/cYr7l5NnQdrlyP81vsZ8YfJ4DjzqNdbUvY3BH
	BnC9oF+nspkz6SuwQJRcKscz/p7mJkmOgSQyVsboFaL1xFdkrRcqHs/Q2VxV3eW7pG2tzvaUsMy
	QK3FZriaxlCsVO5Z8lLnyEZZ2rugQVsgMjrRK9fLcdne+WUIZSpTpr2+UuSSkSJqzjAs1Iswjkg
	og0gqb2e7axCBizsmT3PPUkBAlYDe36VpNu+rgLCPvb8VGv65b5K/1oZJpwMkFf4ixBin0FQiyS
	3PJrkJsoYuNP6nnd7VAelArzD+RwBChmAvg1KWTJCSaYPFXvEuugFTienfW7mPhSMyXt0I1hMa8
	Rx4rZ1XRKmtZTkeIrqKDDk2l+
X-Google-Smtp-Source: AGHT+IEkD2uKpEbBOPznpcF87Q/iRdRhFr6K7yCKT4Ro2d7cPjURx4Kesax8u56jVk7KiymNdYS3QA==
X-Received: by 2002:a17:907:d88:b0:b04:7541:e695 with SMTP id a640c23a62f3a-b07c35fb5ecmr324439566b.32.1757692772365;
        Fri, 12 Sep 2025 08:59:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3129199sm391244566b.36.2025.09.12.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:12 -0700
Subject: [PATCH net-next v2 3/7] net: ethtool: remove the duplicated
 handling from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-3-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=leitao@debian.org;
 h=from:subject:message-id; bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeorzEH9QoRC/ICeYokjFdcyZfGLA0p+bf8
 LlBUghC5w+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 baWxEACGe5myxSrcs2HUexrCkumOZIB5/PiB1ni7TYZ0H4kUe9au5/pIp6vIffrT2wKAO7uZbjE
 zt1KGIZ/ZSIuCDF2QCW61Jn7u+W/fYhi4b7VggTP9Ea2u444t6ohJM7mm/xbN3R6CBZQS9pzj0E
 dCsyolAnhysLUk2ln3ZuJGEXXcr4C7bgwezjzkI5mf+xu2pF6KnEA3XU4shj+f5sq4pww+m3UbJ
 wTiBZ9B5b2tH9IU9RGpzKEE2J9vGWnpoHc88eTOB2BBAOvgF8X5IFzAwiJ9bVFaLDxCd+X7gzqd
 xdtRUDorGrVvxxWJh4SNEfzt2ejaq6f3fpjqbQI6LRg9SdlqAHBs11lcG37X00AeJ63u5e0XEls
 NePnbxkt7Ufa6B/1w/cjVYbOdBsLb+ZvK76O+4GaQXPgN6p8YhoMcGokMbvHbDHRkO0+xV+ep9R
 vmSlJMA9Af733q4NbHl1SvFFa/K9SS7yRc6wRKaBsMHFw5CQNYaZLp29FXF64YrZfFwNLmd+kkO
 pNkvyE/ZL7AszZLfhfGhbS2ICCR8Zr3t5e2aPD+SBWG5PuHAXJHRdHnL8/L9YL8xvbMufGNjIS2
 qYtnEwuRqWoDogiaqxgDWraJBtqhv97StmFJ/5raenWoAwrYrseBx9KRBiOK9+LfF7olGI2SdQ6
 e3NOMM5IZYErUIQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

ethtool_get_rxrings() was a copy of ethtool_get_rxnfc(). Clean the code
that will never be executed for GRXRINGS specifically.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4214ab33c3c81..a0f3de76cea03 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1212,52 +1212,39 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc info;
+	size_t info_size;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-		if (info.rule_cnt > 0) {
-			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
-						   GFP_USER);
-			if (!rule_buf)
-				return -ENOMEM;
-		}
-	}
-
-	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
-		goto err_out;
-
-	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
-err_out:
-	kfree(rule_buf);
+		return ret;
 
-	return ret;
+	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	int ret;
+	struct ethtool_rxnfc info;
 	void *rule_buf = NULL;
+	size_t info_size;
+	int ret;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;

-- 
2.47.3


