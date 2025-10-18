Return-Path: <linux-kernel+bounces-859180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D995BBECF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0274E45FE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6076277C87;
	Sat, 18 Oct 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1A4IKeS"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E2267B01
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789692; cv=none; b=rx7tdqT/RwhztJzeFfAnQFS8LvRqEwb+0+zesw4UUcD6MsfXFJTTkGsXTKn4WeX2WRlVioFoxR+FYDKts0Gt1KkvuT5g8Ua6SAWxNdsQYu3s/Ncyfm0XCx/4fhCc5QPCW3NOz9X98qiCQ+zzng57PlTg1Fxi8u0Ae23YSe3tSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789692; c=relaxed/simple;
	bh=v5ZqyUW81gjLtw5Tcc247E43kXDcQo/vTO4xzVLiZns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EU6hurz1V/ew6y2WQUqzudHEwOgjzpZRUJl74zsijAYgYGyktodRq33fKyi/GlhpzzSp23mxR9qekodcsnyW+9OJyZqzwoYAHA2whdqQgj6u8IWm4OTiaoxa3eVb2afqEh4FngufOr+PhC3SB3q+xJORNT/ZMTF5ke90G9BxfOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1A4IKeS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3ee18913c0so507681266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789689; x=1761394489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufOkjl+qPiRtshghurKtqky4g5561TsZhHIpMFstA/A=;
        b=G1A4IKeStuEQKi8/JE8ylVr55WBy9IMme8wTiJWZIe7u1HIGxw3q42jQQN6nXmnd2b
         +h+cwy8yB72gPovDxEKRo6qgWs4mgSJHFe1iBSnyQRtifm7e+y8kl8pAom0YkB8hAzQ6
         A5GqvnXT67THMwOtP/i1wEdzU9ftl7h3U6AWIERb5uHo3+7mpFeJchRdoVJaXLvK6ojD
         ivkmOz24fKXOcRzINuvFXdIQOCcuHcGV+m7ce0zooMkjdGssOceDWuU7kJ/lGrO0nC7Q
         Er8JjAj+cvt8srxHCWYZA/npXIPaFGUOxu4ApOjjKzxZfXPDt1uYtK66FC78EjR6cLg4
         P+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789689; x=1761394489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufOkjl+qPiRtshghurKtqky4g5561TsZhHIpMFstA/A=;
        b=DtVvnZtY4mCTIUQpHWgoO2ZSRck2m90HXOTOQ/6mkK7cYcg07YtagLydcxokJSqJZc
         iRfMn23PD334AReLKtOqv6h7rriy9NO8Qt8CxfbhX4x4gCzsQSEoYNGdRYjzP06HRjvJ
         m9ZUlfvWVKY+Qp1e2QC4CSbhVrrN8YW0uusniXNppGmT+892xcGh3KPO1ON7pSZChEjb
         m+lto/9r1e7o6UVRjVt38/Guea9bawWO/8tfOziwfVlfkQFE9bIkWMVEj74sG3Dv2dRt
         Zm00kAZMjfxkn5NaeM7mZp9+rS5Jf18qpwGMLLVGENWLTfvUSMTL5Um+hIfTYgW474oN
         5t2A==
X-Forwarded-Encrypted: i=1; AJvYcCUm5XIfWmJZDEZ+xmUvkjBDWl3drl9aa02AVcV2Azj5kX+gTcf3dnEYqnpNtQUPBBCsTaK5wQkVISMzsns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60qEhXVj2oGHaL4rBZ5o+zIbsA1R+aWth0Le4o21zImaL4lL5
	/S1U7CEDggLslhviDs7R4Tz+h5gvZDhg/qz+dPsLaDiXTrM+PTisLf+t
X-Gm-Gg: ASbGnctGNBg9Wj3Y50pcZynVOAoQKZxVLljfdEV2elf4v7YNZsYcN0skuvG5igVAHPK
	pfNkKMays1nlno7hy4Ue5rQ4cQHW2eHjcCH1KMUMsTbwKMIKxYizdKtmpC0FEKe4HT20UMe2fth
	onWYd28zaFmDfJJMkrhqGGYRVbTH4EcP9E9ePI6Iunx3pm528c2yjanxfTxDYVGcykuD2FcnJVG
	aWNEKwQLC9+Wqr13Z01NVFSlTEH7sF+Ih3RUomK958hH/ONUdN9WeYcVeajn6QJFn9E2kg/hVuq
	90Cg3wgnVf+mqcKcqZnM+1mS4CTP4AaoalGilyxXQsJPOq3sgLro2DLDEevMGZjOQXkqCxvtTj4
	S39zPgyKZ/3T1uR8WJ6qx0aJLuq4AJZgTfgR9hUBRXyhaupnElUGH6xz27EmSOFXJ/++B6nrQr9
	R1lzGfQJ0ooFEjtXQDEbziKrcBtdLW+SAkxWKwHoSylQYrjt6gklN8yo8QGRajX5lm77l90pl3c
	ANMEOEcEf5V
X-Google-Smtp-Source: AGHT+IGBPsSaJcR0ev47Hb3xPBn0QIJdrD4FfY6KddrSOXRmNh4o7RZCBMe0k/WnE7eQQbehnrN6qA==
X-Received: by 2002:a17:907:2685:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b647254f6bdmr770989466b.3.1760789689192;
        Sat, 18 Oct 2025 05:14:49 -0700 (PDT)
Received: from ?IPV6:2a02:8010:6606:0:8c72:1dd5:7473:88ff? ([2a02:8010:6606:0:8c72:1dd5:7473:88ff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc42963sm223334266b.77.2025.10.18.05.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 05:14:48 -0700 (PDT)
Message-ID: <b22425c3-01e0-4d2e-bf78-5db884d4ec38@gmail.com>
Date: Sat, 18 Oct 2025 13:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Dragan Simic <dsimic@manjaro.org>, Jimmy Hon <honyuenkwun@gmail.com>
Cc: Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Jonas Karlman <jonas@kwiboo.se>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com>
 <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
 <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
 <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org>
Content-Language: en-GB
From: Hugh Cole-Baker <sigmaris@gmail.com>
In-Reply-To: <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dragan,

On 18/10/2025 09:30, Dragan Simic wrote:
> Hello Jimmy,
> 
> On Saturday, October 18, 2025 02:42 CEST, Jimmy Hon <honyuenkwun@gmail.com> wrote:
>> On Fri, Oct 17, 2025 at 10:15 AM Dragan Simic <dsimic@manjaro.org> wrote:
>>> On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gmail.com> wrote:
>>>> On 2025/10/17 18:25, Dragan Simic wrote:
>>>>> On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gmail.com> wrote:
>>>>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>>>>
>>>>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
>>>>>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
>>>>>> stable operation.
>>>>>
>>>>> Could you, please, provide more details about the troublesome eMMC
>>>>> chip that gets identified as A3A444, i.e. what's the actual brand
>>>>> and model?  Maybe you could send a picture of it?  It might also
>>>>> help if you'd send the contents of "/sys/class/block/mmcblkX/device
>>>>> /manfid" from your board (where "X" should equal two).
>>>>
>>>> Unfortunately I don't have this board nor this eMMC chip.
>>>> I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A44,
>>>> manfid is 0x0000d6.
>>>
>>> Thanks for responding and providing the details so quickly!
>>>
>>>>> I'm asking for that because I'd like to research it a bit further,
>>>>> if possible, because some other eMMC chips that are also found on
>>>>> the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be that
>>>>> the A3A444 chip has some issues with the HS400 mode on its own,
>>>>> i.e. the observed issues may not be caused by the board.
>>>>
>>>> Yes, it should be caused by this eMMC chip.
>>>
>>> I'd suggest that we move forward by "quirking off" the HS400 mode
>>> for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
>>> downgrading the speed of the sdhci interface on the NanoPC-T6.
>>>
>>> That way, the other similar Foresee eMMC chip that's also found
>>> on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
>>> the faster HS400 mode, while the troublesome A3A44 variant will
>>> be downgraded to the HS200 globally for everyone's benefit.  It's
>>> quite unlikely that the A3A44 variant fails to work reliable in
>>> HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
>>> drivers should be a sane and safe choice.
>>>
>>> If you agree with dropping this patch, I'll be more than happy
>>> to implement this HS200 quirk in the MMC drivers.
>>>
>>> As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
>>> eMMC Support List v1.84, [2] but the evidence says the opposite,
>>> so we should react appropriately by adding this quirk.
>>
>> When adding the quirk for the A3A44, can we lower the max frequency
>> and keep the HS400 mode instead?
>> That's what the Fedora folks found works [3]. There's more test
>> results in Armbian [4]
> 
> Are there any I/O performance tests that would prove that lowering
> the HS400 frequency to 150 MHz ends up working significantly faster
> than dropping the eMMC chip to HS200 mode?
> 
> I'm asking that because lowering the frequency looks much more like
> there's some issue with the board, rather than the issue being the
> eMMC chip's support for HS400 mode.  Thus, a quirk that would lower
> the HS400 mode frequency would likely be frowned upon and rejected,
> while a quirk that puts the chip into HS200 mode is much cleaner
> and has much higher chances to be accepted.

I also have the NanoPC-T6 with one of the A3A444 eMMCs which suffers
from I/O errors in the default HS400 mode. These are its details in
/sys/block/mmcblk0/device/:
manfid: 0x0000d6
oemid: 0x0103
name: A3A444
fwrev: 0x1100000000000000
hwrev: 0x0
rev: 0x8

I wasn't sure if I was just unlucky to get a faulty chip, but seeing
this thread it seems like a wider issue. On my board, limiting it to
HS200 mode gets rid of the I/O errors, and it seems that lowering
the frequency to 150MHz also avoids I/O errors.

I did a quick unscientific test with fio; HS400 Enhanced Strobe mode
with a 150MHz clock gives slightly better performance than HS200:

HS200 mode:
read: IOPS=697, BW=43.6MiB/s
write: IOPS=697, BW=43.6MiB/s

HS400 mode with 150MHz clock:
read: IOPS=805, BW=50.3MiB/s
write: IOPS=799, BW=50.0MiB/s

so from my perspective, limiting the frequency would be a better fix
than disabling HS400 entirely.

It could also be of interest that the clock used apparently can't
provide an exact 200MHz, e.g. in HS200 mode:

root@t6:~# cat /sys/kernel/debug/mmc0/ios
clock:		200000000 Hz
actual clock:	187500000 Hz
vdd:		18 (3.0 ~ 3.1 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	3 (8 bits)
timing spec:	9 (mmc HS200)
signal voltage:	1 (1.80 V)
driver type:	0 (driver type B)

> With all that in mind, if the resulting I/O performance difference
> between 150 MHz HS400 and HS200 is within 15-20% or so, I'd highly
> recommend that we still go with the HS200 quirk.  It also leaves
> us with a nice safety margin, which is always good to have when
> such hardware instability issues are worked around in software,
> unless detailed eye diagrams, protocol dumps and whatnot can be
> pulled and analyzed, in which case the resulting safety margin
> can be much slimmer.
> 
> Ideally, we'd have a completely different board with the same
> Foresee FEMDNN256G-A3A44 eMMC chip to test how reliably its HS400
> mode works there, to see is it really up to this eMMC chip or up
> to the board design, but I'm afraid we don't have that (easily)
> available, so the only remaining option is to work with what's
> actually available, which inevitably leads to a certain amount
> of guesswork and some compromises.
> 
>>> [1] https://github.com/openwrt/openwrt/issues/18844
>>> [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84_20240815.pdf
>> [3] https://lists.fedoraproject.org/archives/list/kernel@lists.fedoraproject.org/thread/MCSDYDQVOXS5AZMKA7LLY4QX7JXBWPCA/
>> [4] https://github.com/armbian/build/pull/8736#issuecomment-3387760536

