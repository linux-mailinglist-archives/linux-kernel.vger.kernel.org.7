Return-Path: <linux-kernel+bounces-820410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5222B7D5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9133B1BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834C35A2AF;
	Wed, 17 Sep 2025 09:58:28 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99424353357
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103107; cv=none; b=V9aiJfgMCedA7GSPXPKKsvnkZvFKSdgDSYM8kfj+rIaOEDUKgvqSeVhjJMhqRTgoM0+Q0QdatxBbn7FsgMmiGM8ND9FfqzQRM+P37IVHGEq0URiZrK3cCcBLPN5+MDRliknCgp1Q/tyrZrTsoY+AgbXCKCU6gSUxr4exUpy8c4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103107; c=relaxed/simple;
	bh=QXXieBKf/qDPoEgfClxj3gr2F5IdggJS5IlfjK3ieA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Erh4PXde3WGLa/R9ph3RU/sy9myMb/iZbBfMr5p2ohPcDUraZKfBer7s72zBOIcuvcvISefsIe77/9+Fqs8i6umcDlSsN4fsCLmPoI8mgvTCt9BH8BJThVCU/GdEYEAsrOE3pop1dqiy+0gkgHbYRFr+RfmGYUa8QpFLVDToOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so978985166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103104; x=1758707904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOgozD00A4hNFRi8AgAmWi2KKHVWlXL+R7SPq6Vi9eU=;
        b=ivmN1pQ1BiIEKMKgUcPNx+ZuJ0W2akzD9GDpOf4p/rTpys+p0ktjqQ4wUhUmBs/WaE
         jP5fz/9zYmhbp9xsuqTQI0EiKtaq3zszxnqrtzgCn8bJTLo6GAPqihbnv1Wqc7Sf8vvr
         b4ew2GtgDHPSf+KDGVC8ZITC8kRPNngxxPUxxbq4Hc4412n1IaXe+zKvkH8AiaPQWkmC
         +2OjlyTEZW4LIrMYzt5RPk3nIheTD5O5ZoxEv2qFpKKK4L6PxkEri8rATHx9hyeNyfRO
         j6rpqmBxPetXeJ0jj/qqEY6uSX4WkhcqZN/XQOw6lux51bojUAMcMAATyibjravverOt
         99Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXJKkgDy7xV4ChKU3UUr5ut6AHXq5a14s858h4SBw5yIoJ8PQaLaRL21BIzbL78gyP/Hi3xhueNqFQteBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocRKPymZj0Y5vCZ1srRaZjSq1S4yREGh8hozFVLT/hxMvYrDR
	9KmJx7gxkvMACa/YI4Zex2nYiJKpq2qbbi8XKKoo41KXEAKR5v1R69d0
X-Gm-Gg: ASbGncsDd9mCACgZxUV5gv+fy//n4jMsdu3VGTgHxj1iS2O6dVzrqTtEQ9/2ciVpAQ+
	9sOO05HPR0+CjNfJQS9HuJbe8HT8veczbtb3lKmMFdu1LlZPu5HwYkOXbC9cZehXGhs40ko5o7c
	j8ma/NR6aFyehyAiz/zwkzoejvkp2oVpi8y+BBbYKy1xaD6fm+ZnHQq+W6dl52JIRw8BUFzdpDh
	a1hT1QXfAmxiRKuOs1LWs1EJ0MocL0XS8g5WqUL56AnHV9ApMJbiqCT1IXAt8lAnzWFocutZgZ0
	tGDCPfCW8/GgPCEhwCPY4KERw29yJm0LxMHcZMZt3j4SxivZ9HAbafeDb5WX8zvBTn9H3Q6BWY5
	Hp2zZ2rf9DtAh
X-Google-Smtp-Source: AGHT+IHWhNLaSj4GaBET29vGLJOZQzKQJUIhJjiuxTD58qfCtQouRqIuAShsRH1fyV82nqGogZX5PQ==
X-Received: by 2002:a17:907:94c3:b0:b07:c5a0:fcaa with SMTP id a640c23a62f3a-b1bb6ed624emr165473366b.26.1758103103766;
        Wed, 17 Sep 2025 02:58:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f49d30d41sm4969284a12.15.2025.09.17.02.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:12 -0700
Subject: [PATCH net-next v4 5/8] net: ethtool: update set_rxfh to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-5-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=leitao@debian.org;
 h=from:subject:message-id; bh=QXXieBKf/qDPoEgfClxj3gr2F5IdggJS5IlfjK3ieA0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY25eFsVy8R4NXrf+9RD+lXdDdWZIOeQrhQ+
 mOxxJ5vCeGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bYoLD/92b1Xe/T/RSALr69nvsx9sWtm5Wy3XIYTHPln+VmBNVEHVTIO9O17fDkYkY7FRplWcqQy
 0NWlSnLYVeWYyPmKEersEqULKSvKe3quLbXapfHiW6cW7SmratrEdt4PqdiH8HgTANiYxV00m/a
 JDYM5aW4gi5TGX8ktwKZ3C2d4BRX7xSfUYS3+PslPmFkESkkxko5kAI4S9kI/y+4fz8XLHdR+U9
 rAOEdYD4woePExV/lvMUEsubiXbcbccbxWD1vRucB0k1NbY1bKcMKHn9TH7NqYPM4iRFwo+ma3X
 GOnkTNw1RAkRiXJ3BRjYbJs5IeT0DlPnoSb5IsbOzxGoJhBpatbCxm9Ik/EGyedqgt44wxRlvAn
 cc78e9rOeKuZUsd1T2gi+IFBdiBnWCCSjPq+bTaAMvfxnqqgQSiieigZH4tY7InXvBebZ5Yh3Fh
 n8pO97F1lbgR59Rae4bcJYcVgB7mrQnBAHoUyHZcO8cHN6eLBd98+gviXoI30bph530ybj7+RsP
 hiu+bGX16tSOwb1LwcuIJzQ0se/TGy/7xJZC70L7lsYpws0SD470IBCrwGkGY6tqXAAuV88p6TT
 uUfH0hvBtpKa+B+VTCJHcLHN8mKYa/5eA2rzIuqnGIgQSYyYNuc0vqX3Wv16Oc6+aBzEDCeeXjr
 X96zrOO4jy+pXJQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8493ee200601e..d61e34751adc8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1531,14 +1531,14 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool create = false;
+	int num_rx_rings;
 	u8 *rss_config;
 	int ntf = 0;
 	int ret;
 
-	if (!ops->get_rxnfc || !ops->set_rxfh)
+	if (!ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	if (ops->get_rxfh_indir_size)
@@ -1594,10 +1594,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rss_config)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out_free;
+	}
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1610,7 +1611,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1622,7 +1623,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			rxfh_dev.indir_size = dev_indir_size;
 			indir = rxfh_dev.indir;
 			for (i = 0; i < dev_indir_size; i++)
-				indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+				indir[i] =
+					ethtool_rxfh_indir_default(i, num_rx_rings);
 		} else {
 			rxfh_dev.rss_delete = true;
 		}

-- 
2.47.3


