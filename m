Return-Path: <linux-kernel+bounces-791672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C20B3B9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB631C278AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAC2C08B2;
	Fri, 29 Aug 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OiRuiVr9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA821CA0D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467051; cv=none; b=Fd3H27qU7E10rFCIycmQALNakdUaRfVtsHIKSYKNqHxkgq+VknkBLtaYWvaVel7xSHZ8tRrMYgG2YbwfjhcCrBEojQUMni/XTRRiqTJ83DmUUgLbY18CMXLQECkfjPwoRY3SR8MhZPRgeM9hAOQQ0YatOOeR3DuHMCCxr4gfbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467051; c=relaxed/simple;
	bh=VKAWtCb6rYELAYfnketJZVRmQdHV2fxRIJzzj2P2WVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAW/K09Gf4PY9nIWBduBdn+PcZjoZl2bEwSdugc55W8O/wQmVvb+eqraOiVZyBrNQiDz60HofUEQOHLjRUI5ftAUGbCmkGRt4LxJP0356dGEW3g0PTOKgQpYrWdM7U9zUR9b9fJgh6rMl/BHuRcooqU62ibhH1u9tSU3Obhiygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OiRuiVr9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d0dd9c9381so451783f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756467048; x=1757071848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0wvfSxTD4PyeUqUaex8loa72nWgHqN7pcaVJw2RW0A=;
        b=OiRuiVr9X2R9qJ2tvmFvz4bY0pUOUrGJW2/+XPF1GFiFXyMgpXLodFfl1gL4jlK+aa
         ak6+tIxfr385OPnEdJKzvcn5mPg3a2GzAzAyrwgPmEVYAbnxsEdURIKwShE6PF8k310Y
         kSezk7Sc1+ZDsUOy2Pq88jI5CZxcaIupxc92kcAnBkhgtm4rwXpv1Im6Ml7zBsYw/PVM
         6ZFLCmRxU9LXk+PibSFaqG0MexGKjX8uEFkgSaABh7YhaGkqtiVZqIgaaH+peIyU04tN
         gnV0z72zH+fqV4qqfZIMuOXZ0VX0IOQ8P9sspzcOiKagUWa3G755yb5f7tJkWM3Q6qwQ
         Zbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467048; x=1757071848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0wvfSxTD4PyeUqUaex8loa72nWgHqN7pcaVJw2RW0A=;
        b=c2blPvZBITTXTEPPVaeQT+CHVn9W+69w+xRNA1mg7aB6dV4PObDUncnYUvkmoE61ie
         LUz2q/v64GFspM9/EU360IHM9QwLGsnZhzsZxoqQJ6v+3TVlJwnSE9TqQg9gqUWyMM0I
         0lJQv1HCdKSrlB0vgqBzxJp66Pec85cmgfs6JUGLJL1sFxfAc/cSuURH5NiLyugCc1ed
         4+J2ESfPa95wjehusQE2EYMWZJKgEtfV3iatbA/rd+dy3PFZS/Fh3gmCUGXHQZWlNhOY
         PK41XVYwHRgHsgIpR6qGG9Os/jVIPa3ugacZhHb6EERW5A9gBBkB1q1uLKXWm6LQ0i0n
         RSQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnf/JmSfLo+ZyO2T8/B2cFiWR9y3AdCOirXye3/DYHsIjZNLlfh3DdFuPIMy2+wEyn9gB9EtDgZfDz1e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIs1BMPuPcoPo3wsrkvUxI21W2Z6E5VnshaUd/DC+5KwmX11c
	mKni0U0vKcF2EWMwPiaTPUZV4zff+dZN8Uc+BBqzS5ZaBOnJMRIQBDSqSLezSi5+bfU=
X-Gm-Gg: ASbGncspUiP/gqxDMpz5jZa06pbG88BhJo9TSuQBHAM1VSleWEqJzNoGeL2jS4LhCVT
	piPHt67Q3o5+UOxMAYoqvtzYLCJxhhYjHi+TWeIvYTlTUqXfeC1n/6pbVJvQ47eoiJuGK+lFxzp
	Z3A2m9ln1rinxrmdeSD9SQd02ep+syEHeJ7cLH/JSWxllmsQDLRSuLkEgiQpEliIAu2Vb9df6bG
	hTb/FwwZWHbBRr3jpvDSNdil5FDO6coofO852fPX99NCZzZo6s9u8MDur2u9G48croyNlMSzm/k
	w9nQ62PhDimq85NoTvptd28o+Bos1JepJ59Au/C8LwB8zMfopk497un0d9KRskEPrgePN2R1kVF
	MLIY9GzOPxWQFp+kxxKvhUy+nDjueie70KQxO4IzqdNEBdXI1wuSAtbYT+SUKaaIwJNLWkS9dfs
	DvJw==
X-Google-Smtp-Source: AGHT+IHYch2FfCJJCEjvAUySW+SgNboylbh4JYSu3C6VxwnMUr6gCMAh25k3up3+KdJsGw1qZPzcww==
X-Received: by 2002:a05:6000:40cb:b0:3d0:64c1:1a2e with SMTP id ffacd0b85a97d-3d064c11ba5mr1572165f8f.28.1756467048267;
        Fri, 29 Aug 2025 04:30:48 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6202:f400:43c2:4394:d834:def5? ([2a02:2f04:6202:f400:43c2:4394:d834:def5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fd2dfsm3140942f8f.3.2025.08.29.04.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 04:30:47 -0700 (PDT)
Message-ID: <be706ee5-057c-4b0a-b0d3-54ca24087f3f@tuxon.dev>
Date: Fri, 29 Aug 2025 14:30:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add initial USB support for the Renesas RZ/G3S SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
 <aLAZprjeKtk4pusw@shikoro> <ae53d367-2ee5-49aa-82ba-86f9e84d4d25@tuxon.dev>
 <aLGGmI8bpKNVaSAa@shikoro>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aLGGmI8bpKNVaSAa@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 8/29/25 13:53, Wolfram Sang wrote:
> Hi Claudiu,
> 
>> I just checked it on latest linux-next and all good on my side. Would it be
>> possible that you don't have commit 2da2740fb9c8 ("soc: renesas: rz-sysc:
>> Add syscon/regmap support") in your tree?
> 
> Yes, I added it and it made the error go away, but still no USB. I

The drivers are not probed or you see no activity when connecting USB devices?

> switched to linux-next as of today, did neither help.
> 
>> This is how my tree looks like:
> 
> Mine is similar, except for a newer -next.
> 
> Let's try your config file next?

I used arm64 defconfig (arch/arm64/configs/defconfig).

Thank you,
Claudiu

