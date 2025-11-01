Return-Path: <linux-kernel+bounces-881262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C87C27DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237CD4E7EDF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB62F6924;
	Sat,  1 Nov 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBk0neOd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577432F6193
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999279; cv=none; b=t6WKAmTLeO2yPmULx+rsINpcYiAYUSaa1vIhpBNumdFkjkYFJNqam7BjgQLlp4YjgcAH3m2TFQ/Qpm0KiZytJSTYbqCBnxgbeB/Uuntgq0Gdzi71CBfFNI9NkdrHAODRivchx+yl0go+dNTh9oxuTcG/M5+TVihh42KzdJaEnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999279; c=relaxed/simple;
	bh=QWQRfctde/i6733HoeiN3BEKCruQKAcajbElJ53s+mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSeSvCcPKn+y06YU8lRlKohESzNXbU4mC/ox9CrL5rW8rc2iQAqx4VsRgoGSNvIifeQNZ1dFiMSBo7WfTEIcogPqMT8uM6dSvkOndYVyBid8YVjebpuW0bgGJodUfFequgelnxT5GkUYuzwdGXdiJLXKM4dc0UmOvkJEeQvyWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBk0neOd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290d4d421f6so30339295ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761999277; x=1762604077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ujdLBAXhZY2AOY4FZZ6eP/3+PsXNveO7Mezvnen8AY=;
        b=KBk0neOdk1GOQd5Mrf4G3k6kzK/IEFO/zZI8fFVmDjhvaBgffsk+lP8oYQn5Zg26WB
         fwG4l/UquNHuijL+bvQPQLryphsPr6fpzJ7kNtlnEC8DlnTSr/F1c/W/i+RLXlOSyHvb
         MnWIDrxDuDIoF292Oik0zihKWF3U1kpTxA6qXFX8aE4Sf558S3avmX0bUynXMucflO6b
         FNK1DEvMAWmGyvjyl9o1KyYeN/FFh+Knzcq04rhWJbu6SAxIVuofqcjb/K66gTaDG83t
         Ard5eQyjG1TuiuzT6qN7GSqZTu6aqW1g/igVs/v8nQi1PxNdLf85ARvbJZtffe7ooZ+l
         c5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999277; x=1762604077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ujdLBAXhZY2AOY4FZZ6eP/3+PsXNveO7Mezvnen8AY=;
        b=KFqFrALirxFP0qc0VjCiwIvq3z+tecXu8R0aeDk+IAqykF7remlfmNCTZtTaTwN9ph
         p3pC7/5Rkr5g/FNd87E+F2c9tpniOP/dEJPr0jvsazr9DWL1jtTpcabDW4fzVoqDhEeY
         0yK/2m42j/b/VosLRRw16qumNpKEdABdA9sf20IrSqmJG/qiZMs+3gRsy/O+DSOdzvQ3
         TdbET1bx4aNhzPALwdsYkQ0nKJqtdtZVZ5vfRNFRy1iT75rSWL4UsbmVkog2ULBeuha5
         NAk2bZhbHHvLl/whtq6aQQk87Dh30J7VBnnGFTvO6yD7XrntXaJ6rLYHYWifgG2eKjSD
         Y87g==
X-Forwarded-Encrypted: i=1; AJvYcCUlJPwxzcBSNjNV/JTJNE4P27cEJkWep90+WDGmiujz7GcNtyN39OdXqOxqhFljQBFKQ3U0sXOM1f/5Th8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUzD6e+nz13PDL2rZ8RLpAD0cz3ZFVIssFx0oubGflveLiyqe
	FT/RZsJZKCQTtUjwhMfxsCFGphULiFeponn/37nRJfkFN0OpHZx0S58m
X-Gm-Gg: ASbGncuk5WcjmMl7elq8jhHONM6TWXbc0oIeLZOyp9pyZiRI8luOBKY0plIjpidC1IY
	k+8JcC8/fWeSHR8+089toy83CC5zSYafTQF3WoRnWWPqHNBma4gefKXw4U2939DjuoUO/P1pxXR
	Y/aHVUOs/7eL1BomQ4MN+MSXi91+RYSXhKoHAzjAoaHyl8Evd88gl3r0ZFm30TrlxWIhArXUCx3
	6Gr6DM/MKqCaFz69DKOd2dtnDBIKAt0AMacpXs+yK0ZQMRLvDlq6wmLkRlUC/I6iAgFze/2TIXq
	p/GuGMOby3gmVPua8e/rA8iv1YsgdbFwsh5lkh3HXgZ+EoTkUifae4nH3ETg51YlK6Anq6nCBHE
	E8X6joAkF7F5H9rJcyLpwyzjLfBq4BaZQBmNAs8UtTFKqgbAcV94RijKj8PqZcIk=
X-Google-Smtp-Source: AGHT+IEeRk+2DxXb5yHODDdJKSDxSfi10vJFhmh11HwS87jb+u5luDPpAWnpSEzbksr4arETIJtz8w==
X-Received: by 2002:a17:903:2343:b0:27e:ef35:2dbf with SMTP id d9443c01a7336-2951a55b4e1mr82703355ad.30.1761999276934;
        Sat, 01 Nov 2025 05:14:36 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2001:df0:a640:1::14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952e9a3972sm49654205ad.46.2025.11.01.05.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:14:36 -0700 (PDT)
Message-ID: <3cba9996-228e-4086-99ba-4a2a00de57ab@gmail.com>
Date: Sat, 1 Nov 2025 20:14:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Grzegorz Sterniczuk <grzegorz@sternicz.uk>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jianfeng Liu <liujianfeng1994@gmail.com>
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
 <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com> <10751338.nUPlyArG6x@phil>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <10751338.nUPlyArG6x@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 2025/11/1 19:54, Heiko Stuebner wrote:
> Am Montag, 27. Oktober 2025, 18:34:25 Mitteleuropäische Normalzeit schrieb Tianling Shen:
>> + Jianfeng
>>
>> On 2025/10/20 12:44, Tianling Shen wrote:
>>> Hi Shawn,
>>>
>>> On 2025/10/20 9:53, Shawn Lin wrote:
>>>> Hi Tianling
>>>>
>>>> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
>>>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>>>
>>>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
>>>>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
>>>>> stable operation.
>>>>
>>>> May I ask you to test another patch I just posted to see if it fixes
>>>> your issue?
>>>>
>>>> https://patchwork.kernel.org/project/linux-mmc/
>>>> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.com/
>>>
>>> Thank you for the patch! I will ask my friend to test it but he uses
>>> this board as a home router, so it may take a few days or weeks to
>>> report the result.
>>
>> Hi all, sorry for the late. My friend has tested this patch and it works
>> fine after 50 times dd operation. A big thanks to Shawn!
> 
> So I guess, we don't need the patch reducing the speed anymore, right?

Yes! ;)

Thanks,
Tianling.

> 
> 
> Thanks
> Heiko
> 
> 
>> And hi Jianfeng, I found you made a similiar patch[1] for the ROCK 5 ITX
>> board to lower down the mmc speed, could you please check if this patch
>> also fixes your issue?
>>
>> Thanks,
>> Tianling.
>>
>> 1.
>> https://lore.kernel.org/linux-rockchip/20250228143341.70244-1-liujianfeng1994@gmail.com/
>>
>>>
>>> Thanks,
>>> Tianling.
>>>
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/
>>>>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>>>> index fafeabe9adf9..5f63f38f7326 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
>>>>> @@ -717,8 +717,7 @@ &sdhci {
>>>>>        no-sd;
>>>>>        non-removable;
>>>>>        max-frequency = <200000000>;
>>>>> -    mmc-hs400-1_8v;
>>>>> -    mmc-hs400-enhanced-strobe;
>>>>> +    mmc-hs200-1_8v;
>>>>>        status = "okay";
>>>>>    };
>>>>
>>>
>>
>>
> 
> 
> 
> 


