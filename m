Return-Path: <linux-kernel+bounces-820411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A3B7D818
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFFE3237B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A5E35E4D0;
	Wed, 17 Sep 2025 09:58:29 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0D3570A4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103108; cv=none; b=O9jMn9v8z7xD9cbs4UZ90gw9Z8qQFjP3wxkvTrECwlFUjta7uI3bagJYcEkAbZh7nO0tv4w/rvO6/ftNR0sRA7LhJePsvf3pyBgoXq+wmN4vsJkrNwtBeRkKtMpodlneN4JMGH83S6IQeSvLeCpH9eVfvbd8gp4DFjoeTkga8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103108; c=relaxed/simple;
	bh=kfv8/isgFJkve+pUMNYFR+xX7YuKFGDbmsknnEybwB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auZCYYwh8wE8Fxndl5E2es+2+X4DzBM7NR6XVncDpUqW0ButOyqhg/87esUaHhskXuppW6RGVVH2P9mCy/+ZWrLioXkNcOBpR989nQzAhQw3zDWLE8twSYeS5pSpNjEbYFRm9RYO3HVIxk2m9cUuBq5rDBvmGzKvyRoDqeyllIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so12464268a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103105; x=1758707905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aJLU+C/XG/Cs7lbHPBzQftppoOaWgk5/Dp38Z+cqoI=;
        b=m/iHdCAHlDuIdKb3QxAktz9ow8Nm/6ITp5ANvEbKemQ45QuR4DRgwOBjxfHJCDT5E2
         CtA7JrHP3D9AXF0quTpA0EvxRGh36NwepQxnt0ggrh5eFvf7Yty2Pic9W+WjEnz9X6oj
         2hjI2DM/al4tdyV7h9/bnQ544pxG6yBD+N6Q++1jPJf66xitgZ384i2si5C7XSNMQScB
         fTjzzrxFpvhF7Uu/o89EFENf5OO69CfoNuX66hJZBYp5MB6McSspmgrpL756zAxLo2p6
         IKJpPTgxmAmBQYDtW0xQw9bMLHTxJW3zFsPAToHHiJ/XCLwf7pVl6BEBS6Ei2VR/Zjq1
         nvXg==
X-Forwarded-Encrypted: i=1; AJvYcCUyfBI5hfdUVSXy/itUWwZp0cPyki1sQXoStCjAEruZYAa9HeBNkPu3dRqXFu7mFvIpTXRzjsq80teQM4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5x8fSvV5ZmXS4cgz41ie0CBppX16HYRNWnGILWsCCIAIhitag
	CImENp6KdjE85CnhaLwKNExXlIqxNQm2jeWVTjHUjpm97163oe0aNiSR
X-Gm-Gg: ASbGncs8X2zR3UZ45pXcllvKnKCiz7W1vRlqCWVcdoH+Zw4DvWubt5bp0PGNhSAjfW1
	hX9FDRVWcapLtX5zexs/lrpApEXA3AzMVPG7K+PF0YOf3VAy7FXOa6QTDHFkduNZYP3nmw3gKEf
	IELfWUre0DjcV+rwBh5K4BOoymX0NiC5srqQb8hcM/kvfhhFb4wwebo7PqSTQKiKbKf2D3rseiF
	q79UgyTzUjMK9x8PhTvMjz3pb2SOKe1SOsjx0d9Jpx9PxWxZf/juh75E15gBYG4gUfBflafHTb8
	WSMSmLosxmkf/yHPZ018FamLX5udyLe0uzC9pNBPzmVlPoLCqN+IcMw3X7JwGD21W+zTACdxSSg
	XtPXTs6cSdkLG
X-Google-Smtp-Source: AGHT+IFbtxDDQiq4E6vrTUTnLWzSiiGw7r9iV9QyFrVEem4PTiAwde6mW4FJX0XXykQM5eRuqX7WoA==
X-Received: by 2002:a05:6402:1ec9:b0:625:fc4c:567f with SMTP id 4fb4d7f45d1cf-62f84462564mr1698377a12.18.1758103105127;
        Wed, 17 Sep 2025 02:58:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f482a3153sm5247282a12.0.2025.09.17.02.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:13 -0700
Subject: [PATCH net-next v4 6/8] net: ethtool: update set_rxfh_indir to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-6-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=leitao@debian.org;
 h=from:subject:message-id; bh=kfv8/isgFJkve+pUMNYFR+xX7YuKFGDbmsknnEybwB8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2pwyR+9ANWMW/E3om+S0EZhq0AcURdXWvZ
 AT482XewVaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bRulD/9QIbtKwc8DEsOHr4z4Z65vPq0qcPfRPVuUh/zIwIexjpBzieGa8L6yRr1FAaFLYVSm84L
 NV3fI7L0k3WQC1QY+3gFfUgRKwnZu8Nbr+yIXFyDddRHuI5I08hTu51mJCe6th3wL2kYe37Il/I
 yCZdr8/5hBL6zKbTipKvj7ZdbE82bq3pmm7k/GPQ+tSvTNv2h5Rt7rhWEgDS8JyK/oufPg0TNOg
 YBhzQcsc1UXLTZHMSTUg/fNKrWCritWn1jF7/irRTaHuXHIFOipjkIRebn8cZg2u9hySbampAEp
 3iYbHPO82OqPrBNkX/Je4qolBNxq9MPQPVbxC+0Kdd/RPwjlGFnYi8MPbaEB1zpQSvpRw+i625g
 4BuF2nF8om7GTvw+u9mApzImPBYRGS3ryw2FztGzgV0RFWQxaINinCB3KV7xUrMDsZ6yDy/VGA1
 tFm4v4UOSntDWrvpHPYGdJpUBQRGwkp8l1PSasq4voKPDjMuz7+Z/8T6WZVkJ4SN+dhfvM56Ui5
 7C7Q3O8kjJZ+OgUMZkJTsjUaQuLvsXdEoxhbUTZSaQeKCNQWD1RSUHM6RAkiUvdVuHE+aLj903Q
 rM77om5qtEA36HvH/kTM0LaPYo6BDqYl2N8NZ+pKJf0hcKLOVySqdt0gbLkITi3lOryaB5sBMU7
 d7BtHnrFU3F3MXQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index d61e34751adc8..fa83ddade4f81 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1350,13 +1350,12 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
 
-	if (!ops->get_rxfh_indir_size || !ops->set_rxfh ||
-	    !ops->get_rxnfc)
+	if (!ops->get_rxfh_indir_size || !ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	rxfh_dev.indir_size = ops->get_rxfh_indir_size(dev);
@@ -1376,20 +1375,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
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


