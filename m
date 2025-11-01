Return-Path: <linux-kernel+bounces-881297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A5C27F0F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A46A40172B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D792D0611;
	Sat,  1 Nov 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbOm22VL"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74D254B09
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762002900; cv=none; b=EwJf5ws2I93LMWegcED2c4NcNKOWMYlV6jlSJZ8SoMh4xklt+RX4Gs+I+hXK6DcOGxJer7UOS/mDhG953B4LOB4D8/BBOmCpwHhvbBNMnw6W8eCAQjwq0iUsnOUhOo28MLLe904kr4FbWaqPyHrf1o7RqDsKaVh88dwt0WZwdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762002900; c=relaxed/simple;
	bh=Js+kEEeyeM3DThycbuT69MY6EvJwTDpykSD9qWJCnAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guofhz1sxXcPJ8yFi+5tR5Uet2D4VBklIgqrPTk5sJyecZK1bYc6oWGRThFHe8LwAx2pJ26Xw8JosVtI0RNhyRAFpbIfbqx1AGhVFtLBeHbw49xZ2Pa6danKBxL00LhnTA4j6UEioujBmwxAdO2RBtmFsmikWMoLiuaAhSb/1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbOm22VL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429bf011e6cso1811829f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762002897; x=1762607697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Upr6LEZod7UihSvIyoqPLtgSmSPBWGzOTDYSELD2Pls=;
        b=lbOm22VLjwm/F+3qgK+jpPZ0AAvvBpSCLGq2pue1mWviZeIhcdhIkEvFxZSAM9my3W
         ci3nq0MKzfIXHS1th0Q3hhhqNh3C5l+lx/XAibMOktb9FjTSJsyjGOBIpLqumBXcHS0Q
         QgMLLu2uokC9Csirvj9wOU4k8ikWi9XpUhSuH8wTQs0MnGg+UURfGZRqLPZ+u0H/tNNJ
         ShClfddLpR3AJPSgFA6jxcS2tZszG71aW0MU0sc/B1frscqk7UymS7wpqtIHiyBT8s4c
         PQCZPlvaCjoq3/nCMTMd+u+FM080p91N4K5nHZDwbDXmXVqvZh9xq1gmQ7sCwTmANb60
         1yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762002897; x=1762607697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Upr6LEZod7UihSvIyoqPLtgSmSPBWGzOTDYSELD2Pls=;
        b=Kh6D4Pd/gK0cSNQkZMkj0zteabDHEmHe1pk0QsVP9QgmncqsuSNVxSdq762ZSCFTsz
         FkWdFoDQhiEcEa+ykT43zl4j+Kqo2DaQhQJ7qqjUkmzxIH4T+OG8OJpXlnYQG9AuhcRp
         6De0DOiS6c1pUKJQUqxpy3InMOVAIVTB46eHkvNJeo5lpKGcYNPLawX188M296YHtotV
         hX3oDHpoKRsWmmU66FFSdO1ik9D7CMitSeY66+yzH/3HF3UkoNrl6RHolIs7TOm0fvwC
         FWMRwdejpxYU4WAH6yRms4RSpAJ8+z0sRaa1mBuJ3UJoHR576Et1l3LnSZKpWqPmMVN1
         nCDw==
X-Forwarded-Encrypted: i=1; AJvYcCUmMTPsr7xjY85BvOl2bro1WcPtuorow9O95bz+7PaW474tdppFTRuhFV46AeKRGf8i4ZMN8SYkbFBH2Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1wPQJPBOIACWqDN3g73cvwoJJug3OEWxnzq1VLIqMivgi6U0
	l6e6ZlX7QDevWbo7JqETdTC2XkkcGp1XaLBltIdSQH1luoc8C1khCeEU
X-Gm-Gg: ASbGncs9rKoVSlhydl8z0I32UMLTn6SWtcRyCc7/wQ8EKM56PB1loBViKFFzcY6TX/R
	io8Z9lbC9YnMcTUhL87X25LuXnIv71xd5JsBCcDpjEn5NQpXA/YrC9EjpvN0Uzml2VOM/x4KMel
	gPOOr2s7hAKntxqO29+aTJfYAUdBpjQujNW8YybwCdGztLt9mmPUgEH1FLPeOWzD19vRpuUT40c
	Bx1/HJV+1UT5hEDVGqfE53G8r7m1TpvuqGY1gC6xm5fpiD01qVQP6ugyHMgKfDbpJjqGNxi3gcv
	yuTPA6XoQPhX2GpBLzIx6Qda8aoOJpY/pQD0+ZF7zIffK+S63x9cIYIOZUPKv10GYXjGXzA3lRn
	92Pqbcc2nVnGZhHTqu91522FFEK0o/3gmcGch0Imni7CVXDNEHwmPSJAi/NgfUeMGXipZnFriE7
	qz9B/FEy0NB+iRF2bEKHUIOa2O5X6EVI7bOMH3hl7WXrjRRm8g4FR6tNksMOU6SyNLAkssyRc=
X-Google-Smtp-Source: AGHT+IG9TQlb1uL0biiWsjyFRLeVv/rKy56YQ2LqQbB7TDvmJ+cIF0BHCesuavP4Wddkzt7LbjMbtQ==
X-Received: by 2002:a5d:584b:0:b0:3ec:2529:b4e5 with SMTP id ffacd0b85a97d-429bd6aa4e9mr7024993f8f.38.1762002896422;
        Sat, 01 Nov 2025 06:14:56 -0700 (PDT)
Received: from ?IPV6:2a02:8010:6606:0:4eb:d8a2:c0a2:24db? ([2a02:8010:6606:0:4eb:d8a2:c0a2:24db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e03d0sm9259512f8f.26.2025.11.01.06.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 06:14:55 -0700 (PDT)
Message-ID: <1a66cbba-41c3-425f-b830-efe4b83280f3@gmail.com>
Date: Sat, 1 Nov 2025 13:14:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: pwm-fan overlay for NanoPC-T6
To: Heiko Stuebner <heiko@sntech.de>, Alexey Charkov <alchark@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org
References: <d583ee43-38c4-40fb-b33b-ce3153c9723b@gmail.com>
 <CABjd4Yzfx-4xBHVB=W_r6nEdbwNJKdpHYB6bN3Xsk8dZOegJWw@mail.gmail.com>
 <2cfeeb0c-f7e0-b101-62c4-3b6eae40a30b@manjaro.org> <2246326.irdbgypaU6@phil>
Content-Language: en-GB
From: Hugh Cole-Baker <sigmaris@gmail.com>
In-Reply-To: <2246326.irdbgypaU6@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/11/2025 11:44, Heiko Stuebner wrote:
> Am Montag, 27. Oktober 2025, 22:15:05 Mitteleuropäische Normalzeit schrieb Dragan Simic:
>> Hello Alexey,
>>
>> On Monday, October 27, 2025 21:56 CET, Alexey Charkov <alchark@gmail.com> wrote:
>>> On Tue, Oct 28, 2025 at 12:02 AM Dragan Simic <dsimic@manjaro.org> wrote:
>>>> On Mon, Oct 27, 2025 at 7:08 PM Hugh Cole-Baker <sigmaris@gmail.com> wrote:
>>>>> On 27/10/2025 09:14, Alexey Charkov wrote:
>>>>>
>>>>>> Is there any downside to enabling this unconditionally in the board
>>>>>> .dts?
>>>>>
>>>>> Only that it goes against the principle that the DT should describe the
>>>>> hardware; the board .dts would describe a cooling device that doesn't
>>>>> actually exist on the base board.
>>>>
>>>> Having a separate DT overlay is perfectly fine if we want to
>>>> describe a board absolutely correctly: if the fan actually isn't
>>>> present, the operating system shouldn't be made to think it is
>>>> there, especially if there's no fan RPM feedback, which is the
>>>> case on almost all Rockchip boards that support a fan.
>>>>
>>>> Preventing the kernel from managing a non-existent fan might even
>>>> save some CPU cycles, ending up producing a bit less heat, which
>>>> can only help in passively cooled setups.
>>>
>>> Sounds like an overcomplication without real benefit. It's one thing
>>> with overlays for functionality that can be software-incompatible
>>> depending on whether an external attachment is connected or depending
>>> on the type of attachment connected. Here we are looking at a plain
>>> 2-pin fan which cannot be software incompatible to anything really
>>> (it's not like one could repurpose the fan connector for anything
>>> meaningful if a fan is not in use, and noone gets hurt if a PWM output
>>> is left running without load).
>>>
>>> The CPU cycles spent parsing a slightly larger DTB at boot are likely
>>> comparable to those spent activating a PWM output needlessly upon
>>> hitting the active cooling trip point, and both are negligible for any
>>> practical purpose.
>>
>> Hmm, right, I forgot for a moment that the PWM output is generated
>> by dedicated hardware, so not many CPU cycles would be wasted.
>>
>> BTW, with a fan PWM signal generated by a soft-GPIO output, much
>> more CPU cycles would've been saved by omitting the fan definition
>> if it isn't present, but that isn't the case here.
>>
>>>> However, the practice so far has been to describe the fans in the
>>>> main board dts files, if the board provides fan support, regardless
>>>> of the fan being present in a particular board setup or not.
>>>>
>>>>> I guess then in theory, an OS might allow the SoC to reach undesirably high
>>>>> temperatures if it's relying on the nonexistent fan to cool it down. But I
>>>>> don't think this would be an issue on Linux, at least, in practice.
>>>>
>>>> We're safe, a thermal runaway isn't going to happen when the fan is
>>>> defined in a board DT but actually isn't present.  Thermal CPU and
>>>> GPU throttling will prevent the overheating from happening.
>>>>
>>>>>> Overlays require more user configuration, and not all
>>>>>> bootloaders support them directly (e.g. systemd-boot users would
>>>>>> struggle). Compiling with overlays enabled also makes .dtb's a lot
>>>>>> larger due to added symbols information.
>>>>>
>>>>> Nowadays (on Debian at least) using overlays is pretty easy, I'm using the
>>>>> u-boot-menu package in Debian, I just copy the overlay(s) to /boot/dtbo/ and
>>>>> it detects them automatically and adds them to extlinux.conf for u-boot to
>>>>> apply.
>>>>>
>>>>> Couldn't systemd-boot users just use rk3588-nanopc-t6-(lts-)with-fan.dtb as
>>>>> their single DT to load, if it doesn't support applying overlays and they
>>>>> want to use the fan addon?
>>>
>>> Sure, but it's a manual configuration step, where otherwise the kernel
>>> would just default to the correct dtb for the board that the firmware
>>> told it about. The fan is not discoverable, so the firmware won't ever
>>> offer the "-with-fan" variant, meaning users would need to supply it
>>> manually in every instance.
>>
>> FWIW, the most user-friendly SBC family in the world, Raspberry
>> Pi, :) requires manual enabling of the fan on Raspberry Pi 4.
>> I haven't researched what's the background for that, perhaps the
>> need to keep the GPIO expansion header completely unoccupied by
>> default, because the fan attaches to the GPIO header, instead of
>> to some dedicated fan connector.
>>
>>>> Yes, that's an option.  However, that in general doesn't resolve
>>>> the issues arising from systemd-boot users wanting to apply more
>>>> than a single DT overlay.
>>>>
>>>>> FWIW, I haven't noticed any problems with having a larger .dtb (using mainline
>>>>> U-Boot to load it) and several other RK3588 boards are also compiled with
>>>>> symbols enabled already, and I haven't seen any issues reported with them.
>>>>
>>>> After thinking a bit about it, I'd support the extraction of fan
>>>> definitions into separate DT overlays.  As I wrote above already,
>>>> not managing the non-existent fan might actually help a bit with
>>>> passively cooled board setups, which is a good enough reason for
>>>> me to support separate DT overlays.
>>>
>>> Practical benefits sound far fetched here, while forcing users to
>>> manually configure something that would have otherwise just worked.
>>> Let's see what Heiko thinks.
> 
> Personally, I'm more on the less complication side.
> 
> I.e. if there is an actual fan-connector on the board we should describe
> it as such.
> 
> Overlays I see for things where you attach hats to generic pin headers
> to create specific functionality on top of a generic interface.
> 
> But if the board itself has an actual fan header, it should be described
> as such. Because that then _is_ the standard use of that.

The board does have a fan connector, just no fan by default. But anyway,
since it sounds like the preferred approach I'll send a v2 which puts the
fan into the base board .dts.

Dragan, you mentioned there's no need for more than 2 trip points - if
I remove the trip points between "SoC is warm, start fan at slow speed"
and "SoC is v. hot, run fan at full speed" is the OS/kernel expected to
interpolate between those 2 trip points (if you have a link to docs or
code about this it'd be interesting, I couldn't find anything in the
dt-bindings)?

Best regards, Hugh

