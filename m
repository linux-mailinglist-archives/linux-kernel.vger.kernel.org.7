Return-Path: <linux-kernel+bounces-858459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5040BEAD67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E85A4CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193842BE639;
	Fri, 17 Oct 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWojvlBB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6B2BE05F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718897; cv=none; b=oMjZEWrWG8itdk/LGhRJHOWv2RlV4KyyRfFnjorAUt0H9WoxqfWGwk2HJX2d7SIVA5q3COrXyMwU0M2GQc1qpe4JQxhZntb+NS180VFxRUARDUr8d0zsAhjQZ2D1P6rBTBZtHa/phNvHoZPn01qHWNnEfrBn/1F9vRjFFBtsUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718897; c=relaxed/simple;
	bh=kXPamFL6kLZKkX3qr3uqlpBYTcor2P54a8mC37l3HQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc0+GHC/9/9L1zFYlUxpUPEmM9/vosdvsZwBWWLAT/XjsHvQfrqYsEh58OuWaPvy6lm5Pb3IfT3pyzG+pzQLSHK9se0SfECgQGrna8bJ5CNVfqN+wLj/pRJM3tMq8qiJWck05WXAuLEOkPXlOmgGtHUcAAwEeOaDOnvI/XkV4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWojvlBB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7930132f59aso2963456b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760718895; x=1761323695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiU/qRnryf546DyCg24gqS1SHnp8qC1F8SvAGiAg928=;
        b=FWojvlBBGTaplpJtxQC0l/z5vOJ5xjKqnz6o/kiYyjTrBJWu2Z1r0bYkqPiz+k0vRE
         v4Y9TAz1lP2phEfF2rgelamhbsH4G2YIE5bu+53Faobji2nCgh6OBraF3oIp62NQyged
         iQQdKKKG9zdX3+NlC5T1C6S+wGpTrnm7pSuvocd9fMliawTzCFBWNPXJmDIO2wNB9HI7
         l7F7fS2znYg3xxCfCrI+isPRv/G0zSgaq1//ctuCu0WkZ050N6h4aiifPNbinIOWY4IU
         wjBqAnwY8o/B4rCqBu01T093qLqzygMZrvN/FPPH/IZBK1WgyG0ce3sxzUskzaE8fgca
         88Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718895; x=1761323695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DiU/qRnryf546DyCg24gqS1SHnp8qC1F8SvAGiAg928=;
        b=a3jcdUZBwW5LuzBkqsI+Uo5FX8aT3/arz0fDLXoxt0uYPdQduomWeGpCR/bY8Q72bj
         RTelZB66mV3gpCxr7lyc7ZxQOO5RNVuQ58seZaZSB3gIsY31VlUJx8NcfU0oY2WM46Wl
         IvCFzL7627rQBWCPPqfqmZT8ES5doxX66JWtIHlT09FE84kLNc4xbreNNXq+yOt0moFZ
         j7ZmF+szYe/mkF8NrAqZL8Y8Gb4syT+Ydt3f1FqWhVodqbzODDjuaqYZPH3MrSbCYLe7
         OuxGNzAFSz9yof+rN76KBGMpH8AzN1z7js6tlDkuO6n97QTHt867qKFtXgfhOUcYo+M8
         IsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZNadtqFM6XkMJPvWm1encrwAQ3Gix0lZE5gQ6rVhPyXEAzUnjuB5V0LeAKUfPkulO98wh9nOLNPRrDfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAncG984KpZ+cvHBpR+iMHM6hh9y6c+WL4P6n30kS+Zi/8QmZF
	n/Ymi3fAdpyVsFxupsi5NtvmJ8b/wn3LcfvFtHYmvI1tlYHXFSaddQY3
X-Gm-Gg: ASbGncsFl4A78kZuzMpudEMaS3jwNa+dN/IZaWp/jrw84xDHd8scUxaRi4FJxwQXN/d
	++ccW8Em8wS5+D1YAB9myukfrs6muqnD3Tgt93vYrhgQ/959sNYfy9qim+t6kOsppbiThd0FjJc
	zVldWP22zc9UbjTWveGl8N1OkueZQmI2SUveP9Iqykhu01y/FcJvQIlqFDXpeTwqufihStHpPiw
	1jl+RAMcjg4gliqXhaOtSzA35MbPOIZr888KiIuaDEpu0oGejscUzEoclBPpiy4lP18/9IONxwF
	HdzzTBL56NX6gzP9a8VxT+EtuaWQES4H4dsXwojT9raOco+Yw3D4G5cTuhhVrF8dRb+nm4Lqr0p
	bW1dRHYkbgK5PeSMc4Foow7e6bGEPm4iBiaa78lBXTEiueTjvlOfr9kLmJwk79g==
X-Google-Smtp-Source: AGHT+IFJ3+KNPGSuwMfsWk2oP7Mi4HeigQmPSucY0XlswK32zmoftHGchXXTi+JkTmrGrEHybr+mbA==
X-Received: by 2002:a05:6a20:e291:b0:307:a015:37ef with SMTP id adf61e73a8af0-334a84da469mr5925151637.20.1760718894441;
        Fri, 17 Oct 2025 09:34:54 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15829sm16810b3a.11.2025.10.17.09.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:34:54 -0700 (PDT)
Message-ID: <601cd8dc-afb5-4a67-af63-567814d755a4@gmail.com>
Date: Sat, 18 Oct 2025 00:34:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Jonas Karlman <jonas@kwiboo.se>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com>
 <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/10/17 23:15, Dragan Simic wrote:
> On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gmail.com> wrote:
>> On 2025/10/17 18:25, Dragan Simic wrote:
>>> On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gmail.com> wrote:
>>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>>
>>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
>>>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
>>>> stable operation.
>>>
>>> Could you, please, provide more details about the troublesome eMMC
>>> chip that gets identified as A3A444, i.e. what's the actual brand
>>> and model?  Maybe you could send a picture of it?  It might also
>>> help if you'd send the contents of "/sys/class/block/mmcblkX/device
>>> /manfid" from your board (where "X" should equal two).
>>
>> Unfortunately I don't have this board nor this eMMC chip.
>> I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A44,
>> manfid is 0x0000d6.
> 
> Thanks for responding and providing the details so quickly!
> 
>>> I'm asking for that because I'd like to research it a bit further,
>>> if possible, because some other eMMC chips that are also found on
>>> the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be that
>>> the A3A444 chip has some issues with the HS400 mode on its own,
>>> i.e. the observed issues may not be caused by the board.
>>
>> Yes, it should be caused by this eMMC chip.
> 
> I'd suggest that we move forward by "quirking off" the HS400 mode
> for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
> downgrading the speed of the sdhci interface on the NanoPC-T6.
> 
> That way, the other similar Foresee eMMC chip that's also found
> on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
> the faster HS400 mode, while the troublesome A3A44 variant will
> be downgraded to the HS200 globally for everyone's benefit.  It's
> quite unlikely that the A3A44 variant fails to work reliable in
> HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
> drivers should be a sane and safe choice.
> 
> If you agree with dropping this patch, I'll be more than happy
> to implement this HS200 quirk in the MMC drivers.

Yes for sure, thank you ;)
The full cid is d6010341334134343411f63ea7208700.

Thanks,
Tianling.

> 
> As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
> eMMC Support List v1.84, [2] but the evidence says the opposite,
> so we should react appropriately by adding this quirk.
> 
> [1] https://github.com/openwrt/openwrt/issues/18844
> [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84_20240815.pdf
> 
>>>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>> ---
>>>>    arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>>> index fafeabe9adf9..5f63f38f7326 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>>> @@ -717,8 +717,7 @@ &sdhci {
>>>>    	no-sd;
>>>>    	non-removable;
>>>>    	max-frequency = <200000000>;
>>>> -	mmc-hs400-1_8v;
>>>> -	mmc-hs400-enhanced-strobe;
>>>> +	mmc-hs200-1_8v;
>>>>    	status = "okay";
>>>>    };
> 


