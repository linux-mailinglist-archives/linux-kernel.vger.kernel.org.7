Return-Path: <linux-kernel+bounces-753055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA4B17E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8D41C26C37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C82AD0D;
	Fri,  1 Aug 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua4wBJEo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84121146C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036594; cv=none; b=MzEVl3TRP9AEw4ogFjsOqpdPR+4wFbdl7zjZCv7qT+u2CcmPGH9SHFVYbNt2/sCcpbL5CkACGDU4kBNviP7WxCmfVwp/8JPkChvlmIW3ouhMJlLu3u50JUyH43z3Z0RmMZOWTOB2sKsPOrGTcDBR35kQ4lBe4i/hj0DveS38ERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036594; c=relaxed/simple;
	bh=Y7WQ7L71H57fDKal4CKiDxZgn5pcjDXeUkmROUcHIOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGTU/AsOmdfaBd5/5kB7UYu/5azOFdtu+ZCp2OnUlcU5fRHI//1U6hRBqoGOMFPp7LzELbNSXVigvbL9BgcKLLebrw2szidNi5tTIiVQNNklCNqza8L+pa1Nd1jf5XfI9ogLKcWCiPKLqR8MCq8svJZk6r/BaMsJPrJKZR0YjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ua4wBJEo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso5929965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754036590; x=1754641390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOC4uGHuBV8wACSUSYr4zqb/AWSw2lkHtrho7jKDnI4=;
        b=Ua4wBJEohd8ZhcTECWMpTxd05reQOCG9FT1Cczz9NXmf7/00m5BmTPNnVQDt1Dkz7z
         dLG9wVYQJbUkn+pAIAYkJUQc6vVpeBFlqHx99ri9jPANC6OBM87+qeNswl7trbSOiFGm
         zI0xVbwJmCCWQhy1eUfVViSGOzwPQlWplKAEycL/lfLnp8DUsLotCvnZGUlY1WQ04N2L
         B+RsfB2QhC8IaXS9FZCUx68w0CSJG/DbOfFGXVHlE3HavwS21qyPzt3xwZkwEyA0e+sK
         TUCj3Zk1053cKpPY8YYpjMuKk2MzR78B0Jxtuivd58yRn3JbiW+cmdjR6vjkoYkEA/6Y
         DEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036590; x=1754641390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOC4uGHuBV8wACSUSYr4zqb/AWSw2lkHtrho7jKDnI4=;
        b=ohh12oM/TV3urgufMSwwvyIMSs9mFbW1ohVWxR1V8s8eLZ5AmhjQO5P2rx0os4EYC2
         fLG/nsFUJFei2ejRAlZVAV2DysW/fndUYOArxGTFKYLaR0zb2RkwE8RxsbxiKZxV1HUo
         aDfrt0QGh5Nif8Npb3AyOhy5uLFNoTWlEvMD8lEwTIG20/dgceUaDn9/WzBaCog52kWx
         DL5vwLPJxjTTrZ7Efd9m36kgrFqC0cF6+EJlk+Bcobn/08pr3b3DJmkYrx3oADJkrVFT
         lVFKkIGXxVo5vmrACmXHuj2zjspE7bzX0DKAABhAvT9MUqGidJeF/vIvBv3/UpGOJz9J
         06Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU5dKTXibtYJ1pH+so98lHU0a4P8qiYK2Z+9LT8MapUmXepaII00EZYayX00OUrnOAe996Te+UyqoEzArQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TRqObiDyjN5m4Nndcs8xS8ma2XuHW8Evhpc0q040woZylcw8
	Sl0lz5T95YkXMPy3adXvVo7D9+mroXjVEcrh8jlYPW7dpf4jfwYKLaneUk4tXuNhfkg=
X-Gm-Gg: ASbGncuIMZdlDfpSVHnefgAapEz0ikYsz4eJ2FJnnbfuaGSwRH1u0cS4XnssbzTxg9T
	PkeBPgl9v1X2jSzoSJmnD3h4UTA2jOr9sKqXsjzj4tK36SNV8cL6Ul55JP7SbUzsIcaCdPWcyll
	3pkvy3+VZweMF5xIjn6f0Xmn9gBJAIaPdpVWaKDa6rfFPGVE68Aqc4UBfvLxitfsFVMNUvKKKNr
	AJOVsByfQ8fuRG+EgFrSq5qL7SFMEGVBdl8gr1/eKrwpapbYqFErj6lkDsOKKAxQsk8E2cHzEiH
	xQu0lIAYBrOd5zAe5yz7/yGKP4rMFrF7LPop2nnxfcJZHpXu6Hx6B911i0ZiCwEavyjxNpsy+OB
	Hj1aC7WJ2ty/gFikl/Ud4QFLenZMvXSlCTHNSMaCfNmwp3zGeRByG41LCv8HXqA==
X-Google-Smtp-Source: AGHT+IHFaN3+egakRXZOjinaJFG+r4LMkGjP5kelar/Ki6ZV3odXQ8ubCXOx4u3mK+PBxlSADMEjhQ==
X-Received: by 2002:a05:600c:630f:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-45898a828a3mr106806585e9.10.1754036590465;
        Fri, 01 Aug 2025 01:23:10 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589edf5683sm56534915e9.7.2025.08.01.01.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:23:09 -0700 (PDT)
Message-ID: <4b2bd0ab-cc4b-4afd-a46e-60ccc8d6f239@linaro.org>
Date: Fri, 1 Aug 2025 10:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: s32g274-rd2: Enable the STM timers
To: Frank Li <Frank.li@nxp.com>
Cc: mbrugger@suse.com, chester62515@gmail.com,
 ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Thomas Fossati <thomas.fossati@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-3-daniel.lezcano@linaro.org>
 <aIp+4mWS1k73Vf/A@lizhi-Precision-Tower-5810>
 <87d40626-8789-4e71-8ac3-fa8fff0a7435@linaro.org>
 <aIv5hYGq+fNStRBw@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aIv5hYGq+fNStRBw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 01:17, Frank Li wrote:
> On Wed, Jul 30, 2025 at 11:15:54PM +0200, Daniel Lezcano wrote:
>> On 30/07/2025 22:21, Frank Li wrote:
>>> On Wed, Jul 30, 2025 at 09:50:15PM +0200, Daniel Lezcano wrote:
>>>> Enable the timers STM0 -> STM3 on the s32g274-rd2
>>>>
>>>> The platform has 4 CPUs and the Linux STM timer driver is per
>>>> CPU. Enable 4 timers which will be used, other timers are useless for
>>>> the Linux kernel and there is no benefit to enable them.
>>>
>>> S32 have not ARM local timer? It is quite strange!
>>
>> I'm not saying there is no architected timers but there are the STM. May be
>> I can reword the sentence to prevent this ambiguity.
> 
> if there are local timer, why need STM for each core here?

Yes, I had initially the same question when upstreaming the STM timer. 
Ghennadi explained the automotive designs can partition the system by 
running a firmware and several instances of Linux. By using the STM, it 
is then possible to have the firmware to read the STM counters or to 
stop the timers when the board switches to debug mode.

Ghennadi can elaborate more on this if you need more context.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

