Return-Path: <linux-kernel+bounces-816684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7FCB57736
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4451D3AAF63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27099303CA1;
	Mon, 15 Sep 2025 10:47:52 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096030102B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933271; cv=none; b=eHqPs9YSs35gi0lk+eUe0cu7cAvmHld3OmVH8V5udEzUQSE/1nVOBTJf7YNU7+VkZQtdJpVENC324GtuVC8rwfB+OYi1EutvNffogQviDjzwUfVGdqPBlBH/kZBXXGBEcc7cWQPCNNtyjpJBdGmLD3h8f7TsFo3/GVH8vUBPrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933271; c=relaxed/simple;
	bh=nh0Gd8fHJE8h5NCSVCO0qeGjEU/OiffbOrqPJ9TZRyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RG4GtTi0lEGNfdX3PkAAO1qYwL/VbqHSgX3/Mpl6bDntk23eEmEAZJX7ehGeHi0Q0wdhk5hEwFneAikgtTG76AZjm60DnVKwFNx6nhrSNWF+G9UdIl2qfVFVHw3AoAHWZIAGL1A3kRf3hRTyFOnC8Z2Sjm5THugjh4tfy6Qzyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0415e03e25so508602866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933268; x=1758538068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3zJ2PhZUzoN48j7NGHKfzo8+L/UqnsBZHD1sGknc0E=;
        b=gR/SMFrVWcUQvd6O0mU9tQr4aiik7ZlhCkudIo0coCY9AQ0XwhZ6c9Lc0WHaJ7sBHT
         qc6DRwiHtkhb0BtwUhABaLb0PLVCBoe4eZPvRTQAnqFiV3AoFJxYSM02ztl2evJoQ69v
         WvSqV47yWk8ZKInSAGALjYmuuVWentMFGG7idS3BMzrWBxFubYvHjCthUcfp7d37tXSc
         Byoy8sZZWrcw+cF4tti2dx36jx9gtiHt/OOxSftue0Xo7n7zBKbeYrcmtWYlmiOAmRWH
         /P+skkmunL90bjECa+pGS0pFyUY2is7HNFh4UKGsmQnn0O0HXCwSNmeSPxVP0NEa+ETy
         na0w==
X-Forwarded-Encrypted: i=1; AJvYcCWaiygmU0sG14wunttu76rffZNni6LQDR9VNbDFza9HZonNS2GEXKF+SbE0POW8gItH79EMU1mRoxazmNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUOo1GRWstq2Oszb7YYwfOajjdMvRBwcZi+2r6DmqUAmUDHSt
	Ialgm/SglNXmMWfADtEORXB5plq+YekJZMmxt+1FtYr3bYv42p6+uFW3
X-Gm-Gg: ASbGncsNO4DjXqanJ+grFue68PR7MPH89Erf7LGuNB73kJ3NXArHouIveFZEK59QkLN
	V88d3RT99E7oRxQsfq87qEZ6Shzm4FiWR2xZDibNUlv4j2/Au+9PcERICyZSyu5scSzatnhGQ0S
	C0OBBsbnO44C/18gZyKs4PSjBjHJKKUy8Tv0dKV60ZVE0zlwrLXNyWRNNrdS+rqcOMOWwLa3tZW
	zz3dM9AC5td/89NgoU6506m5ZPRHES96mi8HFmoW9JXQUnIhD7rqptjRY190KXld1tBxt2ixgf4
	f9VHt2mOZJJZYulWdNjjnb4I64WIPJYgSV0Zu1Yo/2F2KuiIsnWeybWITTIVo8xUiGMRA8dvW+4
	qcKygm4lkFQ==
X-Google-Smtp-Source: AGHT+IF3sEMqm1u3RjCkqLLEFAQiFfukDIezE5o+I5x0VhNAfnZxolVsCu9377E+qnP4u+NgzIbE4w==
X-Received: by 2002:a17:907:7ea8:b0:b04:8358:26fe with SMTP id a640c23a62f3a-b07c381c60emr1183618266b.34.1757933267915;
        Mon, 15 Sep 2025 03:47:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd3e4sm909084366b.54.2025.09.15.03.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:47 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:31 -0700
Subject: [PATCH net-next v3 6/8] net: ethtool: update set_rxfh_indir to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-6-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=leitao@debian.org;
 h=from:subject:message-id; bh=nh0Gd8fHJE8h5NCSVCO0qeGjEU/OiffbOrqPJ9TZRyc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7H5t5pVfBWI/WsQktPWHj+w9TIY2cCP/xJ1
 v9dDjk1sneJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bdEuD/4sdZ73DY7iMb3FA2D6mkUisOHLDfmqimfLeu9VagH7Y+FXlMDlCnJzrfNEPIN986+tlM2
 RhMNMb42bteZPswQTT6GXKrEmWvDWwC+hPb+WVGzeamfM3b0ZtuDuQeza3Ib3cRUY9IT9Zgiy1e
 +hZbo2ykw9TAQrkVElljZfAoQCF86vm+TqQMPON1O12ZAWSdfDM05FJbloxs5toseGV62jN6yBr
 FfvTBbkRyUErpdSmXRZWTwq1Kn1lcIJMmm3QuGgJF3+F8szNCTCf+nW0Uh569C+GkchfnsS561Y
 Wk45Lns93prhdbcZBYLz4e2GuXJ2dj6CScVz33nfL33/4/btCk6eORwke6RfREAPI+fYRVzTpgE
 mvZ/r+D6UXGM7se+kb9K5vbUCibfbnrIfZV3t8Ir8MRduf7TwPjdTJit6PKaE7RelIs7dIm/YdJ
 uAg533xKSS6lvwGh7CPD31HQDEFZyY6CgPPZIhGE0l+dmx5ThdgpaQWJ/PbPegRPjuF/isQe/Ut
 mYNpehytpUZ96evHPN3ABuMs2SoZQv4C8038C3N6ih/cquSNjGaG207JxnsUmNHjAch81MA/Cu/
 UFzAviIt2nYQQc81LKVPLm4lvFbmqHN0Ao4ZYXIYmZmQaxXIseJVNkx/o0xpxiATUOlP486+/a/
 nGlhI6oxl6rtGrg==
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
index 2fcb11e7505f4..30932555618b0 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1374,7 +1374,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1400,20 +1400,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
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


