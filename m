Return-Path: <linux-kernel+bounces-868751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D0C06067
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142461C804A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13FC3191CA;
	Fri, 24 Oct 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY6QzpVe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7130FC03
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305022; cv=none; b=DK4k6Ha7Kb+cEhPokDTVHZodCml6ZcTzdPlnQMm/3KAroxiuc4eaec9QF23BFXXIUgT/+bFBbrUAMVdkTkhq01lJRLFraGj18+/t+jmWjl293nzdDt1mCLQREg8hxFqdCaF8qPUc0xWp2OPF8Gz5HksdRZlnJN5XXkHBtqBI49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305022; c=relaxed/simple;
	bh=0zowZQE/EmMI6GxlKIwg6FGmmiIJo4BbJNTy9TYrt7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u5x3KUz4UyX04GgWs9179iBQn+ZxNQmKGvN5GrfVc4wFH7DGeb3GErfg+q6gt5sTwhSn1DP31S346uiwQJow7Q/yzfnSgm1V1EmyMIoeINNKIhRuxgXjqH4iz8FaOEn8DQf6E2gIMkSU23hTywjdSkvg856xfal75P+rFazSnX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DY6QzpVe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso970211f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761305019; x=1761909819; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQOc+jM39ubvRhhSlIjQuPooaB7ldn1LylmA2tOzblM=;
        b=DY6QzpVe0rxSgKfR1z1haUEhujvUsfah5zRuRK+UNKDNuQwQDhgN9Q2Pv/I6rSunfn
         myhJ/e2273OQCiglJIDkS1JB7voG3EU0MHqMxLATAb7bdAAEjJTA+W43vpbn1mDCkAOL
         so0Nynvwyo56spz7PdCkRP35AB1hil/QXwMtKf+3aKT2DBgN078yqy8k287KyXHTEBKG
         VfAAaEVJGfCPaAXFbU3Hane6Llc8DORtJcAQsubIDVvHZqQip9BjGrhcbhiWL/5j/siA
         4HZO3RKb+H5LYfSEKByhCnp6fEMQXcFNXrisTI3nts0WKc2RSv82LRwO3DKU1FpKV21W
         zx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305019; x=1761909819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQOc+jM39ubvRhhSlIjQuPooaB7ldn1LylmA2tOzblM=;
        b=LBGNyY6RSmvbzyVkJMRqIHDJ0bTWUxu6zzfuzQXVX/mh5Btww7IDrQra9/3YbOk98f
         Jp1Dt4ZnWzpDVNJx/b4Gof9Krg1x4jM4IPL+1mjTEhUtod6sDSwCeQ0DsEax36CmcMQC
         wMaqEw26AoU4zeClUKlfA2a08OB9M/tyBKhMwJ+/LT/oVgNSz83LbaUmVTCHDSsG+PTH
         O1UuzHleV77FwVA7WkmeHfxqlss9B4s6tR9C5esr7I5eU2bkWgFvHmzEHS0+NogOa1GY
         aftNX4MvdCVYqDNauNGUna7UDFc+dl3XiZl44umNcAAXxHdTd2tKZnISzKm0CPQVplN1
         UuuA==
X-Forwarded-Encrypted: i=1; AJvYcCWxbDuYw2wPm5yvA6dVW6DAuQMnYzPFNWY8BKRgQKL8ej8fInZFgd+aXcNVGK9uXyPoUEv4r6gfhpBssT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xmmatBfG5/OLvXvOZ1xVeseq1xzGETC+AArAXnrEBmUEZIth
	+t21eTLbFjxv6i/GfZQUkWRAMYwwipdtcfDd1QOLSOGIVeuZiTXOA9pMBkQd3J7ZGpE=
X-Gm-Gg: ASbGncufZlUtUoC460uMDkYaZiaHsX/v491BMmEdltCcn10ny7St01yltI+HPV9lD9W
	el8jc01sPGu7lorbl3riQN5cDun74SwyUaaXt/JntN+unh65q0+s9C+yggm9K5zxXx6zhRD1Cvk
	7SqW7xzjk6hVOERk2DvBAenfWoT8cJML7E+nLb1+kDZDDM8BMid2XVZU4GnCRxbfMiafIP12uua
	F4NYYqtxXugrbmPAvSHW4P+XLU7W67cixXE/OM53gs+d5otP20flo1i46i2P0QfWx2ue1WOmtVI
	iQENOu4z8HK4cfTib4tWRgnoixHefXqAmpic45gUEGJM8lecvS5NSxFOgXOjrNqSK15AGlXa3mG
	QU5oqQql3XHu+YjVQGUC91a+WxQovu7QW7bwQVLvq798ihDxpwvUpXsbDe06sA47SEWLFeP5QYD
	/VatjBx5eVvOXkbWTg
X-Google-Smtp-Source: AGHT+IExQzOyk4omzvi9Zz7XZjs/LOOnvxM4yvkC9gtz1IfMXQ9aSiPVkXwgXIxJvNBEVGrXMNkh3g==
X-Received: by 2002:a05:6000:4a09:b0:427:62b:7f3 with SMTP id ffacd0b85a97d-427062b07f9mr22219100f8f.33.1761305018812;
        Fri, 24 Oct 2025 04:23:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898ec1dfsm8923611f8f.43.2025.10.24.04.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:23:38 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:23:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: airoha: Fix a copy and paste bug in probe()
Message-ID: <aPtht6y5DRokn9zv@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code has a copy and paste bug where it accidentally checks "if (err)"
instead of checking if "xsi_rsts" is NULL.  Also, as a free bonus, I
changed the allocation from kzalloc() to  kcalloc() which is a kernel
hardening measure to protect against integer overflows.

Fixes: 5863b4e065e2 ("net: airoha: Add airoha_eth_soc_data struct")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8483ea02603e..d0ef64a87396 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2985,11 +2985,11 @@ static int airoha_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	xsi_rsts = devm_kzalloc(eth->dev,
-				eth->soc->num_xsi_rsts * sizeof(*xsi_rsts),
+	xsi_rsts = devm_kcalloc(eth->dev,
+				eth->soc->num_xsi_rsts, sizeof(*xsi_rsts),
 				GFP_KERNEL);
-	if (err)
-		return err;
+	if (!xsi_rsts)
+		return -ENOMEM;
 
 	eth->xsi_rsts = xsi_rsts;
 	for (i = 0; i < eth->soc->num_xsi_rsts; i++)
-- 
2.51.0


