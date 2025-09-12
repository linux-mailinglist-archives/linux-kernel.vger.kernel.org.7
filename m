Return-Path: <linux-kernel+bounces-814458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD30B55458
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A061D68068
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4449329F23;
	Fri, 12 Sep 2025 15:59:42 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72187324B05
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692782; cv=none; b=HuTphAMXAyI8K3SyDWyt473gIwemt8hqMCIqhrzGL/msF+RPHdiSnllum62bRI89isPysRgkbRpX2qvsszPuXJ5CLDYsOG85j8BW1amRwwnuI9N29aQwKFQDd9imlSJZv6TnvwNq88rmoHv5RLV/PCOkPSx4VLYkEddSW7/3wJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692782; c=relaxed/simple;
	bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ia1krQ8ix8kKQ7TSYlCXjplj67Q1JAABzbExMxuGFo3xikkVncMiZvfd1NKhTewBlEQaxwYUreEgmO1g+nVa/9lFfgW9oW7VlOz72S5vDlXBdqrlUbolBbsQBK5EKlPcdzPFCOLvK8HFNWUZbh93l01/GLS4AbIm+/wST93zKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042eb09948so443691166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692779; x=1758297579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0gIuHH4FHMvq9oSF/Jigf17pZ9LbJklvlGco8PAXnY=;
        b=s5cRgWflF1JKTtrg9YhcbBrjkBfHVbQvgQbnfZgmSfghvcRS0py8cRp4DG5apfeCKq
         Z0siwjGaXHUHX4h09Dq2HkKV1mALwTM23lQydM+Ghrmzh5DYFpjCwLO7+nWfwoWEWJ7U
         GmjkVGpRgjYHQKedeQo31lDex7WBVl5brXPoY/l3z5jsbOVrkHMCj0DjbLj2oiSpM9iz
         uhIagv2K6oasX/w/IQD61IxELzZJsHRux75S6+CPTh2c3sTYIaFWixTi+Lj6Ke7s3/Ex
         QJiauI1V4qyp/oKxHL0+/WTu0iTd9pfaravPKbqcCS//FaE9aGMrL+2yGqNrREZd/Otz
         T29A==
X-Forwarded-Encrypted: i=1; AJvYcCUkiLCFSGFY3f/ZHCoYsHFJf/Q4dmi1RCGQh8wVOseLomffchiO/Eqa3fD7Lb6w6FmCpeaumRTFS0QjAsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEuGwDdVxgSKu/ffAjvDvvk8d6nuy3E8oL7Z/78jswdGV83qz
	r9oJjqvhWIFyuMwinUWIBiVKGFcd5DxoYP8KDf+Wz5Z3w9VfJXytjf6qlI+BAg==
X-Gm-Gg: ASbGnctPpMOK16bmqPkQ1wcl+CW4iPMAaWxvexCKNPYBFu2ZMvMx8P7SP7kX3ZSGTkN
	epph+R4MnlhGG4UEdEwLLF6hfKRxXAIWHYO8aKtxKVhzWGki1IovnJXHm3ilLdZlwe+x7oOdrC0
	D8V/MjlokiR605l11162V6jgSIUhH/XZFztaj8yshZna9CfUauwiVvBaZw7493iPG+Wk0xqCGXV
	L+phTWOOPdsiNX39L8iPy1z8kqfTNLsHeNnf3DGaRIrsYnPqAM5VmAZRig0ZU5LoOXwaKryQyR5
	vp+T5H6gJq4KXDBDv+Wy+j+P/o6E/EqfXNVi2QQiYhrYqsPQDdmQV/TMFSJ8svIoAWdMqsfJbhS
	QlC+WcamYJuT9MppQmt/zYfar
X-Google-Smtp-Source: AGHT+IENc4Ma8V5tCc/liKhp+02LKc2RicXHgsiwshsnplPzDX12vx98CIJbx90/d9q+6PULUumo8Q==
X-Received: by 2002:a17:907:3f18:b0:b04:45e1:5929 with SMTP id a640c23a62f3a-b07c35cd746mr359576666b.28.1757692778573;
        Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33f3c01sm3584285a12.34.2025.09.12.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:16 -0700
Subject: [PATCH net-next v2 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-7-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeBFGi6WpdTS8dpLji/97clvQfo2zMjVoNE
 56PFE2cZluJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 bdEVD/0XB2Bl57L+rLumfG+of0zBhpBmxvs79I7Bx+mXlU0xsci+hGJzDcx3G5qMnEWiIYYrDMg
 ENU+pkKPyT7wLQ6HhaeQH5su1B19HWA35aqAhkbbJaF/GDSl1bhrAxMQ2760HBmXo4FAErMzz9L
 2x6DIxi70oHcK8swT6751x0MXxqot89K1pzgh2D7xgBBGENxY6AXvdT7zzWOJT6c63v2gH8Rsrk
 CjjfqojfPIP0aPVE8NbnmUQ42KigZXuJdNnitjTE1ok7ymYN2wZbRUMOrzSmuyJ5v4PEIa966KL
 HLzQ5BMb09bn+gX0W4U5XwZznEAEVgIbjY7OAvuKXsUrarYZ5IPyJY/2oc11MhFM2MaA36uDjmU
 zRpmLtt51vHyuUls0x0yU3Plx4WQP8RWMzZRG5KDKpdJMvQJKmKCuhtKFDsX7mF85FxPAKf72l4
 VoEcAUwIci3bBZdZ9wFU3CzpeY1Qlc+SC493uQcoYy7VR//qHNz4aUbO8rOaKzlermR9c6ChYdm
 8MDXoMyIVKGmmb6T0ayHbpF+1x7aUK6+5y1Dle0bu77fnCmGYI4A6Rn8hveuQNNPMou3SxPtPxk
 4ShbNEvs8CF0KN9N+RsYNfTLgvsmQpH4pzF99CTHrj8hUPcbKyuBSbw6PddAMO3Xhw5lzWVnBFo
 wp4FunMO4VxPSwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rx_ring_count pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..e35b6ef015c05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5651,7 +5642,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3


