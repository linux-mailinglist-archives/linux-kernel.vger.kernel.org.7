Return-Path: <linux-kernel+bounces-814452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A536EB55449
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332B3A636B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E014311C2D;
	Fri, 12 Sep 2025 15:59:33 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD23176EE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692772; cv=none; b=P5cfeGOMRmSUsQ1RQghnWls/YMidl1brGIe19ouIHZCaWQJCxgN+6P3VdwjVgfy3O/RoLUNATDDoDWmTtnSajoKYSUKqnKjb89lGlCXhUdLBmqeLxyVSF9tf72sxvwQu3jn8x5AETnBfNZ/pA+FFx4pWBkq0cNQxU1xdoNi+4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692772; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL9QCrRwz/Bgr21uHrJ4FMUrPChg1YW18onH/wPkAPVPkkA+At4J/1M2s/lmK2cSj0ZEYsVZCvjZBU92eCmEXczdq+OVHh0n2B3ywQdSZHr8f3tdfQDst6WcDrwJXagXHdEc1KVqkXMzSVwtYkm6VFih4m9v9bsSSiUoTUsZPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so326357266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692769; x=1758297569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=tt5oLx6SIKlNyQmfYI4YLRYbCPwFoYv9Fn1NFzax48kDI1EmnrsAaf5HLEJXUsIvD0
         hDTy9SfW1KD7MJoPjaMhjNe0iSEXCK5fK6wpuHLHhh8UdaJUc/yQDeT6UQxSqDNYAGSx
         O2NAOW2xut41Mmc3sM3hllJKH4MTdj7Vl0lnE7hsS5+iL8VMDosIntzLLPeYIj3wsBlm
         1VghfzgFei3LzrzFUEt8J5KeQjm+mbwO/LkA8ZzmIXsAFBbtT3SjajdSLkgz6a1c5Y0q
         WtISZ+sP3bLU6tSYZfGGuYZvtrQuvAqSsQBp2qzg0ijNGBnqVp2rdsFbzkRR/SGJSu0N
         l0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVI7DbtbixttbL+nLGvpVHbN8QaAT4DtEgd7DM0wE18pdJLp8C4u9suYXbpeZuO/tkHW0MC+GrmED1lDnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRHlcvyTqsObhdkGOmTUhcDNlKFe8nh4Y/bNSxAf0Qe8lH036
	Ll0wrp56vWetF5ebG5T0Z3Jq0BmhcMk7kkwx14iwuq6E4EDPEYvgYrYl
X-Gm-Gg: ASbGnct0YpXa2/VjULMeFirWsiB86Vw3RYjhjCUsaHhIWp+/PEzW3MgO+5lfoyl3ViW
	lL4dinLV8W8DSAAhGOwCqjEl+M0NU8JY2Jvgc1Uf/xpyfwUQjZNLi+U8XSWhSzJ48jGhkHTBr/D
	5OhNNVPjrdZAILuHRHuqKFyWYZxhZbWkKCA3Y2R7BUF9J6iSoD2B40b5siCL2nMnosq3dFri2Aj
	+O+tLWM5W2FrC125/CQwqfHFBBZ0i1GXD7rWckZAEVQbRXcjq7OsocqRwKwZ5ki8IXeI0slyagA
	L1Cq02XfFvhehhmzn3zpJQtF8vmPnCd1LSt6lJkyksA+Qi5lTHql9BGgfOh5CICHUJNTFy04lGj
	DnE5m0CQmvmke6a2Tws33zQE=
X-Google-Smtp-Source: AGHT+IGwXf3cEKsabQt7Cpv//i35Dk3tdl2J8AgqN2uAsDXsRwu0qjGwDDuOq0Zb8pJ6XlFCPXpkVg==
X-Received: by 2002:a17:907:970b:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b07c37fb563mr287369966b.36.1757692769279;
        Fri, 12 Sep 2025 08:59:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da310sm391317766b.20.2025.09.12.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:10 -0700
Subject: [PATCH net-next v2 1/7] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-1-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdgqKr9Fqt+M3KsL86YnjoIRFj5P6h9BlZB
 uvzTHP8ZW6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 bZWsD/9ifi1mU7JfHUYLeM/FBblDRGtwn1dshElRb3dsckyN4Do12PHTEBk+mROTkHyOiYxqG73
 jiVB3pO0P6M1TGvZqfrwN4AZoCWsD1/U66QJDwQbVBumxJthXRVJfWlrbhqgChCWw2/+cjEaY+H
 KbaZtTHHNrYlCnhExil8uKsHkQnVpKiWPe2yTwAfvq1tCOzyAPNqskm59VHesdt2uVirAFeWyhn
 zr/1rHRRWH+NoEZUxOEpuMG4OFgjMSdtt6yOQlABdsbDP5aigu8eMGCXoA2PrTPDjvaFuFwxKLn
 5luWHIVPRD5F7zOu61nWpEjzC3sRbW1iEpFpt5Xwhs7MF8R3Tr+mNnN0dIdvjYXMK9XYGOl9ghX
 aZk0NpO5ZFq1IVwfFdovmudMo/iWo9DLzG9Hlyriyk45UR3Pp9wzZsjh9s0lCJjRhTsgaRSPqdW
 b3dEyQMf2TgMuoKBEZ43ghrlFVN0l+HA/3TZvsAO1zdphnET2omx04CFVxAV497gcanQNjXnk+0
 Wdh8BZTfE3X8mZvGe4PID3f4aUwUWH/bfkZMtULEMKx5c+b+UCSRtL3vlR6wFlAaKn7fPuI98Jq
 LILPXp8tedMFLh3xUIZEzsDp6tNVydkX/R28E2bVGTbyPE4WfWbUfZ4ln9xEZHnrGKyN0MEHhrg
 CcUQMWg52gv4n+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3


