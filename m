Return-Path: <linux-kernel+bounces-814457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD0B55455
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40901D80852
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C64326D4A;
	Fri, 12 Sep 2025 15:59:41 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA8321F57
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692780; cv=none; b=utqS4fUjGFrWadErUufW8jHjLFrFKngM1WB3cvG7C3t1mNA4oSJyYeukIacBvhb8HIn67pL1FA5hTQSU43E1UE6LLMctgctTf8n/f2odYhuxtCMmOPpU2Hi4Eja11WwhjovEdJHhwxKTv95z5iyWweUpT6vq8/tCwINt/o92cgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692780; c=relaxed/simple;
	bh=+Cyg8fYez6TSqkQqySfOA53/MjPLqa4vHVdBzTfcQyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBlyhtQyq+nrdRv1rwEVxOKRFC/JyY0Ovip3+5sSvq3oM35kTcfmYqHb7DXOiOieSA5j65epYnjxUstL2kJuikJ10xpQvoW+Rg69XFtpC3+SPZJYT52geAVE+kniFvlVKs9XSqc9denCTEMIoXNASYcQyri3rhD1VWopYsj+uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so326372966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692777; x=1758297577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDEVJdYmXjRIZdNwmkm1CN0B9UrWr+aTfgx+0lOTdy8=;
        b=qmWitkxrQ91ndXvo67iTQlV+IHNthOY9Y9uvWxfVlLaKvDSy8oq3I5sCy0CslB3Ss6
         Uwq8FLHxICy52564rpBoB2JP6EJ6OjfowJVQK8ipRriPB5sxvd1cP73rTA+SU209VGst
         byBGnHvT5VjurLBD2srnEJSLV7oDtqjvJHmZBizoC600A4dDsuLiEpmw/vR2hTKt5L+9
         lscHJMJg9Dt33Q1lbjXYlgyA2eBUcAn3m7VE15bHECIaDV8bIIXy84WCnnTXMIZkozJK
         K8HNEg1bfc3DTzwOR7xy1cX+mb1wWa93DxS1YoaVz+FathYDTC48EDw9FOf6tq3/Pz7h
         DLAg==
X-Forwarded-Encrypted: i=1; AJvYcCWJZvCAr1s1A0/FXKzyu5FizrICd7Vd84MB1Pt5iqs+bXJmwMaj8apy3hEaAwgk5Tm/rZhVCDy3mfgFEfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh34fo2AUPCm+hy80evJVVHiyJwLstLBslk3RRHMCexcTrfJkD
	VZuWDbUXOaANSoHaJNT3C7QYfLRgeX6RmWQrmsKDzsyyvD3SIjASLmsK
X-Gm-Gg: ASbGnctPyrRlj2fz7S2hhBbOn53Wt+IRqbrDwxwi63w+eIqMcR2LXFXRM1wRTHzRQN1
	6LjVwKczr9ikfME8ZIFw7ux65w1CSta8GWwLK10ZMWmlDq9EI2915jDCVTkMYNOhknQZFP1DDLW
	12vpNW278FbtOI3KLrXvaiaQQr7403gEO1HL43oHGGXSetVb7CAXaw3AGg1EgChJSt63vyFp9Li
	op3vZkahgCxn9iP5uVoDZ00DDlwp82H90TPPWgnmS3FQ88dUgcGuYKpWERauZvWDfyRdiu8mTcQ
	wjz/uLelB1ByyMbr5bmQ6Iv6EWivLtH1H2HDX8SS32fE8XMNunqGvwv9sg6qIQV8NRWYaJr80zB
	2iPDrXdr3q3xhWw==
X-Google-Smtp-Source: AGHT+IGeZOJfA4BYuVq5HIBmnSMrSvhAZUV+17uTbGUeRylSUyMC8Q9l/3TI3WqxzCCNRy6BdNSpCg==
X-Received: by 2002:a17:907:970b:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b07c37fb563mr287410466b.36.1757692777007;
        Fri, 12 Sep 2025 08:59:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334eb65sm396246166b.97.2025.09.12.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:15 -0700
Subject: [PATCH net-next v2 6/7] net: ethtool: update set_rxfh_indir to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-6-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=leitao@debian.org;
 h=from:subject:message-id; bh=+Cyg8fYez6TSqkQqySfOA53/MjPLqa4vHVdBzTfcQyQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeV/U+AoSVBvH29w1x5dgjHI+lQxwjy7J9E
 oLedliMp2WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 baEJD/0XwL02qnUe6HDYNlGQqcQRWFgZHUKCbBy3LsFsKxavtRdpdQqqU6gwdgBSWl6krL0hWDK
 0dsvkqpzcReVpsyA7LZAr4TW5aKao8XHxs2wBO+LA1pAmr9qSjpJDhcwgmLBSMZlHpleZFYLcPr
 FRkMPSYglEJWGV9+rE4IpJ8hdKgvHDlTtohIa9r6YqpGvc3Qgq2Usbf80AWHJEUIhjavNbPIJJ/
 Iqz4wYohMKlNB4wpYc+3kV4+lX4PNzGOrvt71PkttsY+IZ2t0FCghEjlnlCVpl2wLihJFPJcg/8
 ajI4FSPvrO6qluUJyLY52z4v7muRi2h1YdIOzPleNmWid8DlyzT+7konNntacaoodEplEhoZypp
 J13opvchnsmb9T0yFUPoyj8zNL5ZA7XEsmmH/jgsZ/m5uWFbl0W9l8ZLf5faMGEaal10qM13lTT
 vGcHnzSlf+RwrXQzJdgSqpXHsUcEJExwUtoeZKBocGxEEiTtQBVcKnlJ684pNg+89Z9OdiJLjYv
 e2BV1XeATyu3vdTQkvvX0/YmYQAvlpSyh8GDI4qDKNE7hzFXZy1q69N5VsEXa9jfQQL6c5s8OI1
 2hpJ9Hf3YVeHu7QPdkLKcs+Dv41dn9/LAgCbSFvgZJdzoBvVVCQ0+3Ff67TpQvq544GBle5MOEG
 7v7ZXGc4YB+Qk9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 01db50ba85e71..c95edb228c3b5 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1367,7 +1367,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1393,20 +1393,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	if (!rxfh_dev.indir)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out;
+	}
 
 	if (user_size == 0) {
 		u32 *indir = rxfh_dev.indir;
 
 		for (i = 0; i < rxfh_dev.indir_size; i++)
-			indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+			indir[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;

-- 
2.47.3


