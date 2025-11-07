Return-Path: <linux-kernel+bounces-890436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4B1C400C1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D353C4E606E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4432C15A0;
	Fri,  7 Nov 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ic3s8Zsr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0F22F14D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521050; cv=none; b=vD9xw+QEpxtuU3rs5rFxwEzyNcCG8HeXAEaP1tw72oddfEYncKsqANSSmrr+ApU73ZNe576QDKZue13cbsyuj9CIcNmOx+rZZT+PGHFaYxH1UX7H4udBRgQR6odfmz+0pl9MAm2bcQqlpAyaq1JIsgrrNlcEKD+sJO1P4BTytlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521050; c=relaxed/simple;
	bh=X9iTnwju2qFdxCnEg0NR9GAe26HVn4rmc+Xg59b/xTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbVGG+LwCTXixEVcXRYQ6h1M/8So8EhxKk7Y0668/RppiAucOPAPI8hL38xww5eWDf+aQ4iuhBwU8ek2bFGaKLT/pMW1lk4BRv4ECKrGUifFM/pxUFANd+1wm54kY/NextAnieEfkPawwgb/bmLINlFbp5I3LCsokkrdW26tNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ic3s8Zsr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so775303a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762521047; x=1763125847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYHHRwUPFMx2o7hSDNrrgKGsA3wEJmqOL2og+5hJ+F4=;
        b=ic3s8Zsrq/cpSWPimMQl7eXeyy7bURpkZUATf/NTYwHwXoHDzY5lr03vozTpwbOVFd
         n84WUEsWfs+PSzjpBeJGdJcRmKb+t1fHx9jXXcoqfVGZ0WdYOnuG7UXxvoEDmWhBTiXY
         zYjAbRzvKUkKKqDqVPZv6lSjRfVHAobhdj957364p4mtfXn9e79Scq4G4AlGVT5LBcE3
         Hb5KdxI5WKe8TvkS6pvnv+3ci+FulVJK+FXNu8Chn3x1uR690jFaKrFkbQG1MGIzqghS
         RxQ9emH7WgYdIIiHqNgcePT6jj6tl7aGpMhtuZ4u2WwaGMneJ7QTfDTYc4xJjkut4W34
         Dm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521047; x=1763125847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYHHRwUPFMx2o7hSDNrrgKGsA3wEJmqOL2og+5hJ+F4=;
        b=s1Gg/cgLzn+ePB/a49/PmZjqMdcNhkskSMf5tS+6Ex5hhm4/ApmXPRhLjERvvkikgR
         ayfDOUDGrg+wub25a7q8DE8ivqR1mIZ+RKuqhlfaSUtCCJkm69lnFlzp2s2V+SxnbTRk
         KaNhG4AQyUix4aWwwwvWYqVNsDlI6wRp18mV/Z/JpMWMtN7C+PqrO/fG66fImr6biXTS
         H6CCoIv+VQoCzA0SWPhkcu9JVZVtoykdCXQZNc6FZhbdXxQg9414sioNAz5f2l5nUHql
         t1ufSqAHtLwjFpIivpBg+Qd2RZarkBp/TMO46QvDcDJQb5myOJsFtv7zgQmB6Gq86NYu
         I9tw==
X-Forwarded-Encrypted: i=1; AJvYcCViWarms1Ykpa6LCoSE9a5d5Weje/ToPfGjYV4NI7DWi/Q5ivRBKH6YQXGRrj66WQnPlAuFFO4zl9dWmS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVXpcELAIKOFPr8i8RLmRhoMvu/lylViRMERS7RrjYTrMWeqA
	D4xUeBbTB992q37h41T72lIcI9h1VHv+u40ypUwozXrAm05gKkFOPpWa69ewB8JX750=
X-Gm-Gg: ASbGncuhInghp6mdL5+3V6ArWP8JTdPaze28dbdVh51UaLR9yltxECVWI0xH2hr0cT1
	Ez30675KhDCfsChggaTGDwPW/7ibzy5jxW4Vn8Gy3eShN6MwMoOx5pUnh+iUTjJKM9ndNLbv68w
	FRO6/MN9M0OCYYBpMPOH9fNgqT3o4/Yxdr9K/ecUR2RpuF98CYE7CAFgULOGNWYCrlEAi9qP3EK
	52NOhXkZxuie9kUI4fK3WIYOEJbEro8/4yirwF3L4kM16z7Gl4hdzJnpyKgXWd7B6JsztKRJoGU
	0M2Fg1aMnHzWYgQjbK/+XqR+7itLjT4U58WqC3O2xG3+TXP8p5PulsCLc52OaGhdxAhs51BNYkI
	ah2UrphZ1C27M6GVqWmxX+Fam2JtWJSabgVZVah1T6acBEzIuzXu8NyijgxKhaxkbnOMMfyfG56
	GlQT1SOLetOfJlJJOxurKlvi46
X-Google-Smtp-Source: AGHT+IGg1Zbnws8cxX7orORuWlbhSBF5v/XmuMbF1BaB1hdo3oYtaWYVQbZOezZs+ceawiJZq7x26A==
X-Received: by 2002:a05:6402:461b:10b0:641:1cbe:a5bf with SMTP id 4fb4d7f45d1cf-64147094e1fmr1299694a12.9.1762521046750;
        Fri, 07 Nov 2025 05:10:46 -0800 (PST)
Received: from [172.20.148.153] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813e9fsm3999374a12.16.2025.11.07.05.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:10:46 -0800 (PST)
Message-ID: <db9ea6f8-810e-4143-9e09-84536145999a@linaro.org>
Date: Fri, 7 Nov 2025 14:10:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: panel: Add Samsung SOFEF00 DDIC with
 panel
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, David Heidelberg <david@ixit.cz>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20251104-sofef00-rebuild-v1-0-dfcfa17eb176@ixit.cz>
 <20251104-sofef00-rebuild-v1-1-dfcfa17eb176@ixit.cz>
 <20251106-enlightened-centipede-of-tempering-3cfa50@kuoka>
 <be1b6e34-40ab-4587-8dbe-84e08bf83dcb@linaro.org>
 <108b8631-6d92-4b2f-a59d-3c9e0c607e5d@kernel.org>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <108b8631-6d92-4b2f-a59d-3c9e0c607e5d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/25 12:27, Krzysztof Kozlowski wrote:
> On 07/11/2025 12:23, Neil Armstrong wrote:
>> On 11/6/25 09:48, Krzysztof Kozlowski wrote:
>>> On Tue, Nov 04, 2025 at 11:16:09PM +0100, David Heidelberg wrote:
>>>> Basic description for S6E3FC2X01 DDIC with attached panels
>>>>
>>>>    - Samsung AMS601NT22 6.01 inch, 1080x2160 pixels, 18:9 ratio
>>>>    - Samsung AMS628NW01 6.28 inch, 1080x2280 pixels, 19:9 ratio
>>>>
>>>> This panel has three supplies, while panel-simple-dsi is limited to one.
>>>> There is no user of this compatible, nor the compatible make sense.
>>>
>>> There are. git grep samsung,sofef00, gives me two users.
>>
>> Hmm, on -next I only see a single one:
>>
>> $ grep samsung,sofef00 arch/*/boot/dts/ -R
>> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts:  compatible = "samsung,sofef00";
>>
> 
> These are the users:
> 
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> drivers/gpu/drm/panel/panel-samsung-sofef00.c
> 
>>>
>>>> Remove it from simple DSI panel definitions.
>>
>> Can't you mark is deprecated at first ?
> 
> Not sure what would be the benefit here. There is no negative ABI impact
> here.

If we want to acknowledge the potential scenario where someone is 
booting a newer kernel with an older DT then we should keep the old 
compatible in the driver right? And marking it deprecated in bindings 
would make sense.

It could be removed from the driver in the future if there is another 
variant of the panel added or we decide to cleanup.

It's still not entirely clear to what extent we care about DT/kernel 
backwards compatibility though.
> 
> Best regards,
> Krzysztof


