Return-Path: <linux-kernel+bounces-816681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA0B5770D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878E7188A263
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC940302153;
	Mon, 15 Sep 2025 10:47:46 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C12FFDF8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933266; cv=none; b=aiTLfHgqVpV+Xv6ide0DZhDhbKDOtqWpJuWJCVrlyBA1KvSw/Zo/EPMKqeerNz5DYXe86SltYjMGyk22esVf32lZ4orScQyj1L2wKQT/4McPaxeUJw4DgsCjmsxPivGx7i2t9FDPoQ/AnqOBM3ZmY28xRORTAytCoRE09M8auzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933266; c=relaxed/simple;
	bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/fCpYqJ6jvFflmZSS69OP6kBj01JCHBaShIluanZ1YxOAeGUoyGa7ooTYV7ZJQikMIf1h8MFPKMEybntaee5x8SiUpo3oB9Otw8CKzbl+wSp759207zTmrlewlTM9xEQ4sP5hqHxG2KhgVYgiOx3rwr3aKKcxa6bwZxm2JhIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b046fc9f359so611042266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933263; x=1758538063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNdbybFK0ieLurW9tGv2v5Ky8Nf9YctW4a1t2pmLOlc=;
        b=w740SK6oC/O4UO5sAHXaJ3ARDhDFAvvBDi5mI9JkOIU6kcXLxSBUae5kRGKaxmM0Gf
         lGRPrKGn42VGE9khaeeGB1pA6/FTpSjzOWds1K/QVwBdhwhOFK2nvrrXz8LyDOMBS9We
         AFXpc+kfiQSEQHUrVW+Z+SeKbe394KAgJE/M3bGv7yDC7VxVWGX6RsggJvoAf52vKVlW
         xoSkE/bxYIOmictDKsFGCjD0vEidOyA5OpS0mwNIo0LjR/y2rVqyZsa7Ips+Xld+0MrH
         UrDUMI/jCcOXeynCe23+mDXPXpFwBiQUAAcH0LSlF4JfkidmDBK71nLUqM+d4d/3xkHu
         tRow==
X-Forwarded-Encrypted: i=1; AJvYcCWzzNvMYDSpyDzgTcB7OMtA7PmdBhHUv7mEmRzs5Ua5iu2PDj2R+14/xKMKgf4UVD0GFGby0Jhpal/ISWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovP0GdZ1tMO7CyODwLk2/XPWTmB3XtfzD3VpxKakDe7uvK//1
	sqRzF82poJc4M+XaCs115+LQ465F4lkUtV8Ug0tt4iP1Q2cvBTpbHlaj
X-Gm-Gg: ASbGncvEQIGsBSKv0palLiJjlWKpLU3EK3+SG08tkLDYWWEzChs/63Hau10v906Yadz
	e6t3xDCVG2XlEzDus2hxza4Y4MAJcnMMlgjM7TtxDDbhmJ3tu1Ms6pqOwU6Ui7nrIdGzPY+zBvu
	Di8EUHYYQ/4UQSOvBn416teHphinmEvDU16F+QKjl/slHPuMqHBqGRPvJtToACxktLmxmzlCKAr
	YonvM1Lt895WXjNV30GPJjb+Pt6m1wTCVk6XnWGVMtvIBotCVTYaHNI7wjSlL8xZVfjBjlLHarY
	ZeP4ZvhOtDlG8D+M2FODBghBGz56/3oBvP9cirOU8lrrdSMkD/6Um565x7aL7VasOVVSesS9yAh
	+mKdvKcQrTw1A6XL/RNLd0gOn
X-Google-Smtp-Source: AGHT+IEv9M1+XeyH4YaGcgM5JD/js2B92gnuLogt/kc1W1a14tJODp4LRaazcfABYgiJxEm71MSNiw==
X-Received: by 2002:a17:907:1df1:b0:b07:dacd:f981 with SMTP id a640c23a62f3a-b07dace06b9mr663196666b.28.1757933262660;
        Mon, 15 Sep 2025 03:47:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347a4fsm898294366b.103.2025.09.15.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:28 -0700
Subject: [PATCH net-next v3 3/8] net: ethtool: remove the duplicated
 handling from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-3-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HLk5bXOHgNvPiT5PsRW3BqaLieuawmdwFr
 ubyn3yCUy6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bYp0D/9KMm+eyNuQ0UcsobmG05pUWUug8aAkloEZ0u15EiwrwffFmvDg5SlDdWasTQMMs3pk1ar
 p8d4XJ+ZhuYz6GJor/r8TF1wppK1adTPbj+CbSzaN8GNtqKPr8EdW6N1J2VPPXxI4xl/wmX3KO+
 oHlyYVtux3Sbd3baDeBzxT1+R4VUvEwkiqcWycmcUI0fCFvSQtDbzFnEEdtG7kdgUbiE2asgrCf
 gIk2bQrOCEKyD2BahG0xQnl4sM9/kpqvAgH24TYih0I0JcIKXR8zJ/TqvfC8H7mHYzZEVpTPh4d
 VNAQmGNh7zUB5HFNZYhIRf/TapTUQ098xOJ3kjxl/Jl9HhRVaM246X/XzzUHJGBrPDas0929twW
 8xom2ZmCPKsV++PxGXGhcWZCga08zILBviYHnQ/prKzW8oxrPmDKEtoQPpJUycVmkO8ilPcmN1W
 yCygBfgcwWC9UTW7+9PAuihEcWga13V4COPOxN8as1GqleZN5LQ9ZrDUUHYiVfI7FJj4P0br2KU
 Sb5fLKqbxzZlKFZ6AOBSjrn7ETAdUyI8y2y5GZ3oQo09+tJhoeoxH/gSl9mC1HO3gwKWTjLgfgb
 Hh54mVP38tfx1exhUV67xI40wlP+11y/rPxO6kKnqqfYmAMzuyx0agOVuUv5Qor5IPS2msYllaq
 SZDDcphGmS0AqWw==
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


