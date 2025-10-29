Return-Path: <linux-kernel+bounces-876976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C280BC1CE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFFE56621D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13C53596E7;
	Wed, 29 Oct 2025 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbdelEdN"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8102EAD15
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764689; cv=none; b=LghLsvqEkmrR0sr/ludbVhlaSOQNmq+anv1gYEBWs4v44dIFRGGkYbPXDjZVFp7jo/IfP8FD99KX5EQgvp0GUA2T+y8nR9cGrCQYXG1eGDmYJBxC6xNDYYEplUttNwGSo4V7zJpZ+IZOtdz3pFog6mwJWyq1ikQjjy7J27GZrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764689; c=relaxed/simple;
	bh=ILrBrsQU1LXNylD5t56dKuiGC5knG7DR8D7Ovf3f2Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6TrmMn9M3FX8V9hFLbIbbniK0j/Cb4/ZY5q1H6PIJ2HBVaN5D3bYfbjo95JgSKRbzS+EtYl0wLibY+upf2dOB0b4i+a3xRW460NAYKx3C2ej5Q5HqdNl0g0bXhsBtlujfunX4wz1BWUe6hSHVHC28qDv5kb9L17cLp1b1uqRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbdelEdN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59390875930so233529e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761764685; x=1762369485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MADp8JCGJDJpbQCdc3g1O92CBRZChcx+mPxGU0zSLXM=;
        b=hbdelEdNkpoWhoRblXX+MBO3UsSgEZppLftPNJBhnHuCO9jwhLGvaXFRa6fvEwDy6S
         XR4Eq8xjZp1ibBfLudSAxB2d63Lp3S3C/b2Le0BhVUNW6vwdqVJ7zkJNmcXb9DSobMFy
         Hbnl+IoXJSuzFtwSg4EWDeIo/0HQnH9MtJxDH+ygIFPSTVtjK3PGtj4gxq2hy7UbghOd
         Zvp8y1ip727olGKFierr9qOQ252XWGgHTggLHd4vyRW9wS+Lx6R76W0i7XTEMBszYb2y
         3KtVNp8WN7tYLzzHukOToo6bgnZbKjyHnQEUfhlzdCn+rD4KKKJxj0KOrtqbOY6cfH3k
         yHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761764685; x=1762369485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MADp8JCGJDJpbQCdc3g1O92CBRZChcx+mPxGU0zSLXM=;
        b=mCn6qhKm9wdsyL1d9D2KrFULg1Hl5a818SJc4LDUNw4Whyczl3+xD/iOWTy4Ns3L9y
         JthCjPjpcJD95BXx27KHbBSKnWPuvdhtsmREa8et4IuuHbfhzPu8rw9Ycez4dUZAj/Gz
         42VRgGrF7s5v31Dm6GriQf5QFHCbZBCaQIB+4MZCyW7x7MYQOja3eDl/W3dARM5M/fvk
         FPKp0ruerOwygb4AvqcFp5yi1F8zsaSTPpyV9JvYwk6dHKkqBt2MIlli/L93B8Z6DvW+
         9gGXE3Sbb9vFfYGHyTDoG3rS3E9hvfLuWSLzTHfAmdP7Apb1fuhRyDU38nY/ZthbZTAO
         hE0w==
X-Forwarded-Encrypted: i=1; AJvYcCV1GJZ2499LheEkyexnq3+yVF0xK4VQ4fFv5FIuql7V2ohKMYPhUWkuuPR1W2VCLrM5uHXyFJtVtJXTWEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62BOjIgj8xfBzRRUxR8XqHWUNS0t2UHrDvEZCs34mNGNtR6fu
	GLeTv6Arx0a3y0F3QOTGVDcxnd/OMs5a9fqMS9Yizdythq1chcodrTJV
X-Gm-Gg: ASbGncuxdm6UruxmJcBQGdiR8zIWrQbYsyiv4EfPJL+u3a0XoZljPdcqeREEhcCKZEp
	3gAugqvarkeQnYq0BuYkSoxV6nqFbm5bYW2JV6XWZEFZ7xFI6ALwiIjEA864bGkEHw/BSbNqngU
	aUYiePJhdxK7avHiu5KaN01NBKFggW95dhWSuT1Aj70+4DGQckFWTBmgasz4W71HfhSARnjrkPp
	HDusayILseHsf3HkV+7biNDvDFEmYdBCQ7ItkHzSyAgskanUryc1qBX1uzmAozQySE7h86yOjyK
	DLzsAzZwZpHhIDASr+/xP6ZhZn5qTvQBurmp3TjliooM/2aQZdMOsCRbUeT18wEoQXTDbQG7HXE
	RZ+Ci6xdJQNbjkMp3Acy6rlZ5ZKO46oKMhtRgWq6pFRJGPygo1GKLcNjR2RpOWOgvBMityfDu2d
	jlt0DgmRnMZ9wmaCmGDRQc8vhMzUEJMAd2coq4XkQ7GZmuVU0r8kkxeogzSw==
X-Google-Smtp-Source: AGHT+IE5BcxhvI597RfEprglxbVp/g/p8XgtmT0Jr/Tdtka5w1yu1s5vmXW5Ea/wqRujMOvi3aXxeQ==
X-Received: by 2002:a05:6512:33d4:b0:592:f31d:da18 with SMTP id 2adb3069b0e04-59416e9f0e9mr181566e87.14.1761764684935;
        Wed, 29 Oct 2025 12:04:44 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f55739sm4044356e87.49.2025.10.29.12.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 12:04:44 -0700 (PDT)
Message-ID: <b3d810f1-ebf7-4859-8f57-bfe3c094dcc0@gmail.com>
Date: Wed, 29 Oct 2025 21:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: Maud Spierings <maudspierings@gocontroll.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
 <20251029104838.44c5adcf@karo-electronics.de>
 <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
 <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
 <7aaa736c-2390-44b6-913c-0ecb63393ee5@gocontroll.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <7aaa736c-2390-44b6-913c-0ecb63393ee5@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/2025 17:51, Maud Spierings wrote:
> 
> 
> On 10/29/25 16:35, Maud Spierings wrote:
>> Hi Matti,
>>
>> On 10/29/25 11:05, Matti Vaittinen wrote:
>>> On 29/10/2025 11:48, Lothar Waßmann wrote:
>>>> Hi,
>>>>
>>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>>>> [...]
>>>>>>>>> Could/Should this be described using the:
>>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>>>> scaled voltages.
>>>>>>>>>
>>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>>>
>>>>>>>> Ah I didn't know those existed, should've checked the bindings 
>>>>>>>> in more
>>>>>>>> detail, thanks for the hint!
>>>>>>>>
>>>>>>>> I will have to investigate this carefully, since I don't have 
>>>>>>>> access to
>>>>>>>> the actual design of the COM, so I don't know exactly what is 
>>>>>>>> there.
>>>>>>>
>>>>>>> So I am not yet entirely sure if this works out, I used the 
>>>>>>> calculation
>>>>>>> in the driver:
>>>>>>>
>>>>>>> /*
>>>>>>>     * Setups where regulator (especially the buck8) output 
>>>>>>> voltage is scaled
>>>>>>>     * by adding external connection where some other regulator 
>>>>>>> output is
>>>>>>> connected
>>>>>>>     * to feedback-pin (over suitable resistors) is getting 
>>>>>>> popular amongst
>>>>>>> users
>>>>>>>     * of BD71837. (This allows for example scaling down the buck8 
>>>>>>> voltages
>>>>>>> to suit
>>>>>>>     * lover GPU voltages for projects where buck8 is (ab)used to 
>>>>>>> supply power
>>>>>>>     * for GPU. Additionally some setups do allow DVS for buck8 
>>>>>>> but as this do
>>>>>>>     * produce voltage spikes the HW must be evaluated to be able to
>>>>>>> survive this
>>>>>>>     * - hence I keep the DVS disabled for non DVS bucks by 
>>>>>>> default. I
>>>>>>> don't want
>>>>>>>     * to help you burn your proto board)
>>>>>>>     *
>>>>>>>     * So we allow describing this external connection from DT and 
>>>>>>> scale the
>>>>>>>     * voltages accordingly. This is what the connection should 
>>>>>>> look like:
>>>>>>>     *
>>>>>>>     * |------------|
>>>>>>>     * |    buck 8  |-------+----->Vout
>>>>>>>     * |        |    |
>>>>>>>     * |------------|    |
>>>>>>>     *    | FB pin    |
>>>>>>>     *    |        |
>>>>>>>     *    +-------+--R2---+
>>>>>>>     *        |
>>>>>>>     *        R1
>>>>>>>     *        |
>>>>>>>     *    V FB-pull-up
>>>>>>>     *
>>>>>>>     *    Here the buck output is sifted according to formula:
>>>>>>>     *
>>>>>>>     * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>>>>>     * Linear_step = step_orig*(R1+R2)/R1
>>>>>>>     *
>>>>>>>     * where:
>>>>>>>     * Vout_o is adjusted voltage output at vsel reg value 0
>>>>>>>     * Vo is original voltage output at vsel reg value 0
>>>>>>>     * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>>>>>     * R1 and R2 are resistor values.
>>>>>>>     *
>>>>>>>     * As a real world example for buck8 and a specific GPU:
>>>>>>>     * VLDO = 1.6V (used as FB-pull-up)
>>>>>>>     * R1 = 1000ohms
>>>>>>>     * R2 = 150ohms
>>>>>>>     * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>>>>>     * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>>>>>     */
>>>>>>>
>>>>>>> Because I do not know the pull up voltage, and I am not sure if 
>>>>>>> it is a
>>>>>>> pull up.
>>>>>>>
>>>>>>> So:
>>>>>>> Vout_o = 1.35V
>>>>>>> Vo = 1.1V
>>>>>>> Vpu = unknown
>>>>>>> R2 = 499 Ohm
>>>>>>> R1 = 2200 Ohm
>>>>>>> Gives:
>>>>>>> Vpu = ~0V
>>>>>>>
>>>>>>> And:
>>>>>>> Vout_o = 1.35V
>>>>>>> Vo = 1.1V
>>>>>>> Vpu = unknown
>>>>>>> R2 = 2200 Ohm
>>>>>>> R1 = 499 Ohm
>>>>>>> Gives:
>>>>>>> Vpu = ~1.04V
>>>>>>>
>>>>>>> I am not quite sure which resistor is R1 and which is R2 but having
>>>>>>> there be a pull down to 0V seems the most logical answer?
>>>>>>>
>>>>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some 
>>>>>>> light on
>>>>>>> this setup.
>>>>>> R2 is connected to GND, so Vpu = 0.
>>>>>> With:
>>>>>>     regulator-min-microvolt = <1350000>;
>>>>>>     regulator-max-microvolt = <1350000>;
>>>>>>     rohm,fb-pull-up-microvolt = <0>;
>>>>>>     rohm,feedback-pull-up-r1-ohms = <2200>;
>>>>>>     rohm,feedback-pull-up-r2-ohms = <499>;
>>>>>> the correct voltage should be produced on the BUCK8 output, but a 
>>>>>> quick
>>>>>> test with these parameters led to:
>>>>>> |failed to get the current voltage: -EINVAL
>>>>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to 
>>>>>> register buck6 regulator
>>>>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>>>>>
>>>>>> Apparently noone has ever tested this feature in real life.
>>>>>
>>>>> Thanks for trying it out Lothar. I am positive this was tested - but
>>>>> probably the use-case has been using a pull-up. I assume having the 
>>>>> zero
>>>>> pull-up voltage causes the driver to calculate some bogus values. I
>>>>> think fixing the computation in the driver might not be that big of a
>>>>> task(?) The benefit of doing it would be that the correct voltages 
>>>>> would
>>>>> be calculated by the driver.
>>>>>
>>>>> If real voltages aren't matching what is calculated by the driver, 
>>>>> then
>>>>> the voltages requested by regulator consumers will cause wrong 
>>>>> voltages
>>>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>>>> safety limits set in the device-tree will not be really respected.
>>>>>
>>>>> I think this would be well worth fixing.
>>>>>
>>>> Before doing the real-life test I did the same calculation that's done
>>>> in the driver to be sure that it will generate the correct values:
>>>> bc 1.07.1
>>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 
>>>> Free Software Foundation, Inc.
>>>> This is free software with ABSOLUTELY NO WARRANTY.
>>>> For details type `warranty'.
>>>> fb_uv=0
>>>> r1=2200
>>>> r2=499
>>>> min=800000
>>>> step=10000
>>>> # default voltage without divider
>>>> min+30*step
>>>> 1100000
>>>> min=min-(fb_uv-min)*r2/r1
>>>> step=step*(r1+r2)/r1
>>>> min
>>>> 981454
>>>> step
>>>> 12268
>>>> # default voltage with divider
>>>> min+30*step
>>>> 1349494
>>>>
>>>> Probably we need to use this value rather than the nominal 135000 as
>>>> the target voltage in the DTB.
>>>
>>> Yes. When the driver calculates the voltages which match the actual 
>>> voltages, then you should also use the actual voltages in the device- 
>>> tree.
>>>
>>
>> Think I've got it:
>>
>> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/ 
>> regulator/ bd718x7-regulator.c
>> index 022d98f3c32a2..ea9c4058ee6a5 100644
>> --- a/drivers/regulator/bd718x7-regulator.c
>> +++ b/drivers/regulator/bd718x7-regulator.c
>> @@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device 
>> *dev, struct device_node *np,
>>                                  step /= r1;
>>
>>                                  new[j].min = min;
>> +                               new[j].min_sel = desc- 
>>  >linear_ranges[j].min_sel;
>> +                               new[j].max_sel = desc- 
>>  >linear_ranges[j].max_sel;
>>                                  new[j].step = step;
>>
>>                                  dev_dbg(dev, "%s: old range min %d, 
>> step %d\n",
>>
>>
>> the min_sel and max_sel fields were uninitialized in the new 
>> linear_range, copying them over from the old one (they refer to the 
>> register range if I understand correctly so they should not change) 
>> initializes them.

Ah, indeed. Well spotted! Thanks for debugging it :)
>> Then setting 1349494 as the actual voltage makes it fully work. 
>> Otherwise it complains:
>> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
>>
>> Final debug output now:
>> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 
>> 10000
>> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
>> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up 
>> configured
>>
>> I will add this fix to the next version of this patchset and include 
>> your requested change in the dts.
> 
> New idea, why don't we just change the values of the original 
> linear_range? Do away with the allocation there entirely.

I kind of like to keep the global structs const, and allocate new memory 
for anything we need to change. That should help us if we ever need to 
support more than 1 instance of the driver (Eg, on a system with 
multiple PMICs) - although that's not likely, and AFAIR, the driver is 
currently not written to work in such use-case.

Anyways, the selectors won't change when voltage gets scaled. Maybe just 
allocate with kmemdup, update the min and step, and be done with it(?)

Well, hard to say what's the best approach without seeing it :) I'd 
suggest you consider what you think is the best solution, write a patch 
and let's see how it looks like (and, at the end of the day, what Mark 
thinks of it).Yours,	-- Matti

