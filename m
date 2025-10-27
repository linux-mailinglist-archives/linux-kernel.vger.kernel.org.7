Return-Path: <linux-kernel+bounces-872243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E63C0FB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC89A428CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533E319858;
	Mon, 27 Oct 2025 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYw70aUB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01633168FC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586475; cv=none; b=Rn565FIYTAeznp4d0cdtpNhsgSLO2+ZKdF1+jWP/iv27drhLWu36iG9HXyYhtyimkz1y1tIktBAdqfmBvdgujIdX7/yB51Ion/ZhfrLrFM3mHAZ94XSbAGZWFWZ09g4hviLu6Xbj5sqIp0/KrHcbXRHv2IVfFC8wpt5PWpzkVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586475; c=relaxed/simple;
	bh=JSsEa2sILCUrGBa+/eAE/HWgRWWieuXbaUfhsDV6jNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FfDC5QvXH9ocgfsI23LcGZmtwUCeAWlHBc9xFv7k2qMVb7gVe8BA74w1VxrcSWBbkUlHFKTTXPLR6Uz14jvarrgidHfTt8/dCBwodFaBlovLDqttDKWBq7fEYjW18DVEc3JJtC0UTkkAdnJ+D1GCUUVmhLqfGvDViw/JwEQOGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYw70aUB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f5d497692so5960434b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761586472; x=1762191272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEjlvHcQp4lpZ1m36wlxzDAnqifTiWNPk+NjQID7RjI=;
        b=VYw70aUBDjvNozfwZUJU7Z6/RudPWS1nALHegSSAl36GAVnbrxtD9IZhHcIKNGg0oF
         Q0igwqpgkDVyG6NnPWzc8Ng1VdSBLRHZ8nOZJUoR5VLzm9fzY9kldTyF4ptVVrkD7sZ8
         8h7LA6wMG00exAnNkYY/NEOuQS68Xd0bay/ccv1tuv9L/mZVKqFa6+gKrl4JnzJy3mCN
         12ZpgxiTHyEtmSfjAUoZrs9jcgCbufyBT2v2KoqczLGrutzAaIqAk9M7h3+loXcPzltE
         w0J/OAS4Pkgu2GAIHJqXrJY7GLqNAYFjG6Gj53idVFoBSgnP8f++385yixAJk71KynoX
         5uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586472; x=1762191272;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kEjlvHcQp4lpZ1m36wlxzDAnqifTiWNPk+NjQID7RjI=;
        b=mw+CtK70E+YUSpU8qENHgH43tbOwSt5wt2rhX5TZyN9cY8sNTHbIRJSV5/v2wZa76C
         g2dcbF4c23jJ/jxLeZfhWa5Ezc/Ge88FhC2bgstOCEKCRy7qXJeg/Bv6WQW+pEoLGd3U
         5sDKjnMjy6SDLXp5kOw74duA0ScogijezjtO+AmlS9E/93jqB6uSWEED1AzTEsxubXK/
         MurVeRw4Q/58ghCcmJQMoN28Lt1f9daSDuJJrjlBw7f0ucWa2oYFG2lNXXtzQhaUQ5rf
         +WtQBknFMb5RLoGnUsVmwA7qKo+0nHFcCghBAh+Uy4OicNs+Y0fQPtSe09uhocRwgHwt
         xJZw==
X-Forwarded-Encrypted: i=1; AJvYcCWJRZFOGFHSS/851CE/M2Z+TzKbXZFp8Lf0aFlOPowgqAit2i6mWVW+hmnITp288lFCcbRHENOpn9Xq5Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyTzg/r7FRKciigdTkvnAoNqPyPdFUemGZfxi2ToS0I2cVGky
	iOWxJp6VgGYQkDHzxvvyXpxe88GNiGUa5+P5EEEffSJRbO1jORGoKxA5
X-Gm-Gg: ASbGncvzcRMAUn0pcUNJdyGurLbebq4UEzeb0AC4LwnBcsYUMsslQtph694UZrzKSOq
	MXhzxUDrbHaX6ue3z8vubkl4eHSITOsIgTH1p3RsE+BCDcDVXXCMAbDo3FufmK76AFRvkLAXADt
	Qe2pfUFTUcdq+DZwyJHgdkRvS/V4VntGlBgr23e4x4r3ke69F/LeGq7MtL3gS9JMf05OS+Mz8e0
	neCnV8rgFOx20HTYYmMzdY+JpuolmS83hOtPZTmIefiM6Hg10xdm3hc7tLVnZ9FPt5d4hr91cUB
	c++A+A8y8B6iFRPCSvcZj8TMu2qH/tjPp8pIEU9EX88hrOlg951UOWLEtwsZ6Nu08bplCAS3RTN
	Ug0D7xpO46XwqfHf3m12u+kvugba8myzv8FJkWP7alnqY9U4Y9FcJb2Vyz3VNFPIDTy5ZL6F1p7
	2aPQ==
X-Google-Smtp-Source: AGHT+IHAljstHcaoMHk/lLRlsppwJy/V1KHAMxtXlEIjZrVw2dfhWs2pVvM+g1XbMmpxHBsC5hDZxg==
X-Received: by 2002:a05:6a00:13a0:b0:7a2:8853:28f6 with SMTP id d2e1a72fcca58-7a441c476f3mr801487b3a.22.1761586471576;
        Mon, 27 Oct 2025 10:34:31 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2001:df0:a640:1::15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140a0d47sm8684282b3a.73.2025.10.27.10.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 10:34:31 -0700 (PDT)
Message-ID: <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com>
Date: Tue, 28 Oct 2025 01:34:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
From: Tianling Shen <cnsztl@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Dragan Simic
 <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jianfeng Liu <liujianfeng1994@gmail.com>
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <d70c0eb5-9aa2-47b1-8205-81b724180319@rock-chips.com>
 <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
In-Reply-To: <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ Jianfeng

On 2025/10/20 12:44, Tianling Shen wrote:
> Hi Shawn,
> 
> On 2025/10/20 9:53, Shawn Lin wrote:
>> Hi Tianling
>>
>> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>
>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
>>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
>>> stable operation.
>>
>> May I ask you to test another patch I just posted to see if it fixes
>> your issue?
>>
>> https://patchwork.kernel.org/project/linux-mmc/ 
>> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.com/
> 
> Thank you for the patch! I will ask my friend to test it but he uses 
> this board as a home router, so it may take a few days or weeks to 
> report the result.

Hi all, sorry for the late. My friend has tested this patch and it works 
fine after 50 times dd operation. A big thanks to Shawn!

And hi Jianfeng, I found you made a similiar patch[1] for the ROCK 5 ITX 
board to lower down the mmc speed, could you please check if this patch 
also fixes your issue?

Thanks,
Tianling.

1. 
https://lore.kernel.org/linux-rockchip/20250228143341.70244-1-liujianfeng1994@gmail.com/

> 
> Thanks,
> Tianling.
> 
>>
>>
>>>
>>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/ 
>>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>> index fafeabe9adf9..5f63f38f7326 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>> @@ -717,8 +717,7 @@ &sdhci {
>>>       no-sd;
>>>       non-removable;
>>>       max-frequency = <200000000>;
>>> -    mmc-hs400-1_8v;
>>> -    mmc-hs400-enhanced-strobe;
>>> +    mmc-hs200-1_8v;
>>>       status = "okay";
>>>   };
>>
> 


