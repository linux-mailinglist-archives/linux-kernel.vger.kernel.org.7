Return-Path: <linux-kernel+bounces-881361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7CC28136
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DDB188AF14
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B121E991B;
	Sat,  1 Nov 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="h0B+Iq8E"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12115D1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009235; cv=none; b=KmSid2c0cTlrp0oPW/Dk61PuNMUuae0fSWrsv4sXZYsUic+1WnCYi1oXgKKX1NgVH3kGPW9WT8SfCvLufPA2ntvqm9wqLOIuhX42lHJjjkXTAWKNDYQQIc0PPL0R6ohYXQVkAOHdL8Hkj2x2a6k3GAcwrOYAAvWTQypTjdVs4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009235; c=relaxed/simple;
	bh=K3/b3jr5SBSHHuWefiHTx21BlqOp5dw/wmKirB+uwkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abi6r+WORlwflEel80KKRsjprmU+3lkX1e6ZNFOt9h1j717Pf16LFVwNHA8JmvY4KHoifmotoswOP902lA8q27oBa1RV0OgVhO5LaCu8bVHiNakOoNcoK3f3sMIF0cTd46JZrUwcKVcuNYAUDM/CaYap5fZkSJ1p5Dk5Eo3wsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=h0B+Iq8E; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c19b5de4so1348122f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762009232; x=1762614032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6g7/oxMyVMxygIoIjYSwO2RhZz+LTOeAZEKc76K6rk=;
        b=h0B+Iq8EMiI/uM3RZAgX45is0ksIrBB3vVl2jGbikXyVBEBEbbMt8OTwIgXqiaqnE0
         ucs3LLV6JzdaTbnxiu/RMFrKA9kQuTPdIX6agE7JSwIxKk+qitDmLXBNKG0fNT/GNADx
         4bmOgFiKdPRcOi+PcPAlqputBur/EAoS542l14bbEgiEhhOojXo3/LgelpSc/Kz1UYuC
         LaBooIMxJyL7BRhmNS+KcrDwlmfarj5GY3GqTniR8XSAM45v7j3i6glrMDuTo9AwHh04
         Lou4BD/aS4+AikEEfujubsUCw7OJFlL0R4tYUh3baCO5Lr4MUnlyw0rgNKGBGvM9SBP9
         FOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762009232; x=1762614032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6g7/oxMyVMxygIoIjYSwO2RhZz+LTOeAZEKc76K6rk=;
        b=wH6ZG3lhDq4RhMTA0bm4h1FHO73zjLYK431iSDbmSkBBEDvcSxJeSoNBQg2QvzHKRP
         96ohAVX+cToXkYPTIHr4vyKdRDA8DiURGowsLl9b9Hf2uX1usHE0Lkf5/Okkd0LVxd7h
         xti7MJykYy3DYZoN6R+v8wCyhXkld96U9VSolBL+NfKLaBHxl9gytBmqKLD3HfGmm5Rp
         pI7cewx9q7VCmo8iOeW0x6bzLFuZF7pEpDhEjYSvmUuZ68+cOwrSmiwKyV1w6MKxtH3E
         J5G4U2JRongbgLS++Ou2NrWCLKW7LQKczORsoXbrxNs2Y9LmZdUvfPzU9KBQqSAKPhdU
         /Nhw==
X-Forwarded-Encrypted: i=1; AJvYcCVqUITjTf3uAjH0C74ozCEP6r3jvWDOINg8h9L6xLYk7cSaWQIMlBWFOItckTN7qEZgQ5pEJI0rmoOFx78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaG3Mwt4QFn/z3mBKx3kZnZoEyPTIE236riqGsEiEtR+YS44RH
	LPyyiFa0c5bxf2XvoEW4rozER31NOrStVM928/B8fdIabYHVks1Pql5p3gEfxme0YL+g0QWCWGm
	s+Nrb
X-Gm-Gg: ASbGnct+gH9gW3HXfXT+6kaTLNPcA+wTS6W2bEwV7+5fnVbO7/PNQXW0uE1cNzAF5Do
	oYtNaWzGEeKPD+69ysxviNKzj77Ecyqwp+VXrgeGg1h4oCa7PWwewsHS0Q8Yl35gurDjliC3VDF
	nxKXvjn7GK7HX+9f1lmoiU2TLU7/xJq2rf12ies7MmmdtMw6UShGDiGtD+bfN0L5OSg+HJKqLkI
	uW+WG6qmyfPMNtBdvecKPsaEfh2MDjrHHjkEoWSuGLWIstPekOaEodyTwsCchMdfuzPiYr0YtIu
	BgpCXrJCx1cpsh0eNUAmQo+sbbwUHc2Nj4x3lGtlOlR2Ojr5cD5KkqWf1ahRnNYFLpAUcDV+XLH
	T9JU2XCI0ve/VF6RphZnv6ATsMYEIPFVmWWxu+vZuouZ7DEdkcLOEyUHqjkiQKhYQmfD+RTNf4Q
	4Dc8wwTzCe
X-Google-Smtp-Source: AGHT+IFIRiQVA75Sc+kE1CPWUk4PiMBnedhmmWdsH1gtnnIcarCQEzcyI5Zta9nGlQH0Yr7n0uCFuA==
X-Received: by 2002:a5d:5f87:0:b0:428:55f2:be4b with SMTP id ffacd0b85a97d-429bd6a4c29mr7851522f8f.38.1762009232556;
        Sat, 01 Nov 2025 08:00:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f3278sm9347526f8f.42.2025.11.01.08.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 08:00:32 -0700 (PDT)
Message-ID: <12f2e17e-15ee-40d3-90c6-e8e210b7da2e@tuxon.dev>
Date: Sat, 1 Nov 2025 17:00:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rtc: renesas-rtca3: stop setting max_user_freq
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Joshua Kinard <linux@kumba.dev>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20251101-max_user_freq-v1-0-c9a274fd6883@bootlin.com>
 <20251101-max_user_freq-v1-4-c9a274fd6883@bootlin.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251101-max_user_freq-v1-4-c9a274fd6883@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/25 02:45, Alexandre Belloni wrote:
> max_user_freq has not been related to the hardware RTC since commit
> 6610e0893b8b ("RTC: Rework RTC code to use timerqueue for events"). Stop
> setting it from individual driver to avoid confusing new contributors.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/rtc/rtc-renesas-rtca3.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
> index ab816bdf0d77..a238ead6cf1a 100644
> --- a/drivers/rtc/rtc-renesas-rtca3.c
> +++ b/drivers/rtc/rtc-renesas-rtca3.c
> @@ -772,7 +772,6 @@ static int rtca3_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->rtc_dev);
>  
>  	priv->rtc_dev->ops = &rtca3_ops;
> -	priv->rtc_dev->max_user_freq = 256;
>  	priv->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
>  	priv->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
>  
> 


