Return-Path: <linux-kernel+bounces-737754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A701EB0B025
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE73F17826F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEB3597E;
	Sat, 19 Jul 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JWjenM4f"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA5AD5E;
	Sat, 19 Jul 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752930108; cv=none; b=hWXY+CxP33b/ltD44VkP3KT1HaYRNkbsvCT9ozdZk8VA6Qw8JqF9yJB93wRuGTLj+h2+yM5csrTQvDnbBR4y25YiJKLBdKu+jQQuDuLfQ6dWL1SN2biO6jmPI4cxDD6OwiiZHIWen+tw0sLNKgUKenqeMGW1JI98jicGj7i3c0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752930108; c=relaxed/simple;
	bh=3P7MDEtAobW/rju+KIzwv48gfKsjghBJMvaCS1w0xRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sn8v/KgpReVckblp2unH8Q4lwpRjFQgYWKOatnHe+G9gSG79dkEw4jcofBSdts+rLOuv7keMa6oBmrN9vcdb9r1HJJ9KOJXq2tGZqYG0PctB2VK03j4Kn+WQdpsZ/9+j9Kb3bo0UfV8eXqLxPwQB/2NJm1hoUKSGXhg3Rcvi7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JWjenM4f; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id d7Axueh39pTm4d7AxulBeP; Sat, 19 Jul 2025 15:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752930034;
	bh=luTLF4WhRoXNPErA/O4bSpxNmwyHlcnK/b1iN63tmoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JWjenM4fhgqP4Og8ND+UQNmaGkZYhnJUMGVk5DXQ0p5WBiF7xlWGvzCQ6w7FAyotS
	 0M0TpcO7LRZCPVSkDaDDtYrQnt1WZNzvswJbVpvm/duME1BvcV7AwavwzPB6LuUVTT
	 IKpAyZEVfu9BjCDMb51FC8MTqiDqr9qUvT6fc97+H9OsNbWSB8Bz37iDsxpAGNtwQ3
	 XUxEG234UsN9y/TytR9s+Df+vISCqd4HGl/XvGuJPPSix6MfaMe2OvIBeTIBwIL0cg
	 zRRehFt+GKB68rSs5TgE442Zb/6w6Njp2C4N/9yF34iFO7/YcaJYN+di3ECTn77RAU
	 2pu9HW+wFzIjQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 19 Jul 2025 15:00:34 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <e4c297a7-1ef1-4c39-8daa-8acdade47508@wanadoo.fr>
Date: Sat, 19 Jul 2025 15:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: caam - switch to use devm_kmemdup_array()
To: zhang.enpei@zte.com.cn, horia.geanta@nxp.com
Cc: pankaj.gupta@nxp.com, gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250719163416760SUAwKHXRQRBFKhvAOpNbT@zte.com.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250719163416760SUAwKHXRQRBFKhvAOpNbT@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/07/2025 à 10:34, zhang.enpei@zte.com.cn a écrit :
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> Use devm_kmemdup_array() to avoid multiplication or possible overflows.
> 
> Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
> ---
>   drivers/crypto/caam/ctrl.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index ce7b99019537..2250dce9c344 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -592,9 +592,9 @@ static int init_clocks(struct device *dev, const struct caam_imx_data *data)
>          int ret;
> 
>          ctrlpriv->num_clks = data->num_clks;
> -       ctrlpriv->clks = devm_kmemdup(dev, data->clks,
> -                                     data->num_clks * sizeof(data->clks[0]),
> -                                     GFP_KERNEL);
> +       ctrlpriv->clks = devm_kmemdup_array(dev, data->clks,
> +                                           data->num_clks, sizeof(data->clks[0]),

sizeof(*data->clks) maybe?

> +                                           GFP_KERNEL);
>          if (!ctrlpriv->clks)
>                  return -ENOMEM;
> 

Just my 2c,

CJ

