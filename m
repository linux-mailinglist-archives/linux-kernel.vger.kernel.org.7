Return-Path: <linux-kernel+bounces-766749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD922B24AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCAA16E1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA92EA752;
	Wed, 13 Aug 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="zts5AfOi"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16E2EA156
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092061; cv=none; b=Un9o09oJGKH5GUmWaq5RQXT1BKTe1UtxINxnY5O5b1jseU4YMCAD8DIPudVw7PXP30X7RqxxiM/hquBWYMnAAgNQYhcXKsdkJlvfv/c9XT83FVtsKKN3Em/rW4ZSuFVy3iaWniU/EBURntEoS0a+8DC8BMkPrA8QPGxsnLY4KOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092061; c=relaxed/simple;
	bh=fNSC8w8HU0S89hQRnFJWFWREK6fXZjS72GfrRn4HArw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRwNNKcTVT0PmwwvrEvuMdCts+GwcxPaamIbl/wCChEc07KIEn8LtoFsG1CJn4pgncIlnve5ahh82VWHymzBqnxFCqfL7tNmJeIoblCdcNV7ttZ/xHAd8tw67rT4bMnYBI38DKf8tlfs919XgXr53/5MAKgiIObgxyGZe5iqb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=zts5AfOi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b79bdc9a7dso4027525f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755092056; x=1755696856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNSC8w8HU0S89hQRnFJWFWREK6fXZjS72GfrRn4HArw=;
        b=zts5AfOieDGtIpBk2bnNnf3iiJNQg6K8rn3kUC9fc4ndoyX9jnBrcU6x6iHb7qUO3B
         8Glfm88viDrW9fYLImCF3awDhsXQR5j/9Tnspf/hNTi9a7Mxgbvk9/N9uSpofAZXJUes
         duIyApbZ6pD6Jiz4KTsHNefl2uEGh8nOzy/3YVUIWQAXYq18DdXxZh8vt48lfG0IEhLJ
         ZiOztvyokuujAtESWcStkFuHzqrErEhVYgbCK02GiOjp30kScY/UGyJ/baxuuqSFjY/h
         KLqSDClYxOULDu3kFVDRMsf5tILszqYQawDpI7xnlW7MpiZFyoDFCCF85NNB7YfKQiBj
         IN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092056; x=1755696856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNSC8w8HU0S89hQRnFJWFWREK6fXZjS72GfrRn4HArw=;
        b=EpPNBrfGwuAFBXSbTXeUQcE9js/wF9n/JjSvZIlQjgXsx5T6ucfsXGARCeHs/JPbvK
         5uLg03WUlaupUYvY5xtxbtNGuLMvqj73YXbRK398e2E1uY51NHlOo29Bv9ySRhM4mC5u
         +uXiyi6I2mxyFmNAQLElmjWnbRGr9QSUKSGYiyBHHFmMK0Vi8MU7JDG37NAZrzda1pS4
         blsTaO6KG+SXofBRMRaTvOHSfdP0hZBCO7F2g1Y07F3F79Rolm6E7bfWjSSvupisJO0v
         QGtl/u7O+PNZZU5B61rfKm7XQ5qn1vCltGwB4ofAJFwMEnG6G/lYcZoaIsIY23z+BbVz
         BurA==
X-Forwarded-Encrypted: i=1; AJvYcCXFjdX4SmBAe3HZFXLEE8HuLhOyt9NSGDt0LdNOCfyx+2vbGyJahrhMsuP93H4B1Jh5RYWj5MVQeuSmZaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+mvZlVHurdXVdgg2UO7VAe4Ml7ZrVwJzApmGmGg2oRh7YxkZ
	eGNECxptSJKPkeolkmY0+cCnTjmNPyEjYBypLaNI4BqfxEGB19B5q7d9gD9Ul1xF+Ek=
X-Gm-Gg: ASbGncs9gkBVg+rnXICEHffQPW2jk/FXQXcavD2l7BoMUzwYs8dgOib4+YVm+5psGmZ
	0cmEMkvM+qlnV3ongSpTXTmHtvMHtUbyW9xZPaneVWKjsm7ESfSq5oRZxbSi45lglsaW5bJyGAo
	2ranyrEnoYowYJ3uWUbQvShz+Pa8AxcAy3YYBUyhojan1dZEADdKXtzVzClnN5uVTjA0cuzQKcv
	oPzGgh4OjOgpjDTTSsVj9EU/iy7D3nILGBQK0T2DU10tFqIzmuRSM7OnphunBnMiplRnKkK0wEV
	TLECD0/+P7T31P2aQVZyMLKPGLE5EuyUI82DYMvjO+MBhXMBaNvFAvnZ3aCejGVD1AQhPe8yxil
	szpy0tVfqInqcfysa4kjuFOxmTLo5dKhXKFy6lhqWHPl94VKU7lRM6mjg+Ai3ldAaGtCFKDvhSJ
	0LtGcnNzrvEzyMmOi3CBU1
X-Google-Smtp-Source: AGHT+IGyWBRLcYyjmPdaFJ7RJMvGFJChrNnUkFexYqA+15BorH+hR4bUKBZZRC1EER2gmnrpcLdyVA==
X-Received: by 2002:a05:6000:26c9:b0:3b8:ff3b:6437 with SMTP id ffacd0b85a97d-3b917c85890mr2243633f8f.0.1755092055765;
        Wed, 13 Aug 2025 06:34:15 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:388a:2f48:ed4:7e0e? ([2a02:1807:2a00:3400:388a:2f48:ed4:7e0e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0846777sm37944948f8f.48.2025.08.13.06.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:34:15 -0700 (PDT)
Message-ID: <463dcfa3-152e-4a48-9821-debdc29c89b2@hammernet.be>
Date: Wed, 13 Aug 2025 15:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] riscv: dts: spacemit: Add Ethernet
 support for BPI-F3
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn>
 <20250812-net-k1-emac-v5-4-dd17c4905f49@iscas.ac.cn>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250812-net-k1-emac-v5-4-dd17c4905f49@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 04:02, Vivian Wang wrote:
> Banana Pi BPI-F3 uses an RGMII PHY for each port and uses GPIO for PHY
> reset.
>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>
Tested on Banana Pi BPI-F3 and Orange Pi RV2. Verified SSH shell over eth0
and eth1 interfaces, and basic UDP connectivity using iperf3. Thank you!

Tested-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>

Kind regards,
Hendrik

