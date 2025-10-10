Return-Path: <linux-kernel+bounces-848672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C751BBCE4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29D919A2A96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057D301035;
	Fri, 10 Oct 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GGgochEu"
Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2171DFD8F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122602; cv=none; b=aug8ufe1pCX+B7iHUmInBlgn8X3uxvHKq51nG1dYuh6RkFd3irA0G8KUQf7cGTY/ugAW+FK+e+TABcrf/ax1Ubx5SH64SFB7thEghXk8VXqjj9Toeh5T88HYSB/Aed1bl+QQvB41Q1AD8uAqOyqoVT3tlKSVY1ytTg8dVupxqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122602; c=relaxed/simple;
	bh=Z2eDj2yo45hoGwWfCTbSBgL/DxIx3H2GOVYOK8y4avw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e22arLkW2qjpLyscS55QEcfnldcrkrTVERnRTCOQCPb/+tekalcYp/N0utZyUCS/48cr5+0JdnTp1z6sfEP50OevmM9iiWkxkqRuevLokzyCd0SQWkOmffBuIodBw9HdRgTJ+hq8naq04dMmpzgZ6m+8hraBhNi7pz5TsyodBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GGgochEu; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 7I9BvGl2gj6re7I9BvJh69; Fri, 10 Oct 2025 20:47:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760122044;
	bh=ApAqzSxFUHRu693UbW8HIzKg18XgBTW2gNWp6s76L0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GGgochEuPDnrUMdhC0PZNKxGe33rXEWsr8li0muwwGmwSz9erYPM+tuB1pZUDKKSN
	 ICxYsh+NTjanXzJ4ToKCAIyX+wEi4wM/uyvo11knLMXAEf0hLTtJCTI6K95fHQjSuU
	 /uwyGHfSQr72S/c8IA2dyfi3bl0cmgFdsoVhs8Y5TWZBzuijhNhgOkhQEu9uhpdN19
	 A8uc6LB8xzwdIwKCkM6V+j3uZ4svI0hBJVEu9aubrXwfSOuISSRL0fduedYGj4QP4j
	 ug4DdlXXFCabmTUe4WD342PQef4hmOnODqk92TP7Y6VHXG4opPYn79xCx0whatm0/U
	 msxgYxhTUp3Ow==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 10 Oct 2025 20:47:24 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <b2836421-c7b5-442b-a208-5cd3efdafa4b@wanadoo.fr>
Date: Fri, 10 Oct 2025 20:47:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: da9055: Fix missing regmap_del_irq_chip() in error
 path
To: Haotian Zhang <vulab@iscas.ac.cn>,
 Support Opensource <support.opensource@diasemi.com>,
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20251010011737.1078-1-vulab@iscas.ac.cn>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251010011737.1078-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/10/2025 à 03:17, Haotian Zhang a écrit :
> When da9055_device_init() fails after regmap_add_irq_chip()
> succeeds but mfd_add_devices() fails, the error handling path
> only calls mfd_remove_devices() but forgets to call
> regmap_del_irq_chip(). This results in a resource leak.
> 
> Fix this by adding regmap_del_irq_chip() to the error path so
> that resources are released properly.
> 
> Fixes: 2896434cf272 ("mfd: DA9055 core driver")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>   drivers/mfd/da9055-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
> index 1f727ef60d63..8c989b74f924 100644
> --- a/drivers/mfd/da9055-core.c
> +++ b/drivers/mfd/da9055-core.c
> @@ -388,6 +388,7 @@ int da9055_device_init(struct da9055 *da9055)
>   
>   err:
>   	mfd_remove_devices(da9055->dev);

I don't think that mfd_remove_devices() is needed here. Looks harmless, 
but should mfd_add_devices() fail, this clean-up is already done (see [1]).

CJ

[1]: 
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/mfd/mfd-core.c#L337

> +	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
>   	return ret;
>   }
>   


