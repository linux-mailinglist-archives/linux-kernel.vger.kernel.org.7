Return-Path: <linux-kernel+bounces-875589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B40C19619
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65336349022
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20D326D5D;
	Wed, 29 Oct 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhpgKPxq"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD52E0905
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730414; cv=none; b=hUCF7Cnzm3wF+evaVciGxEfFXWnQtPUCuij6p0LY92wV37Ak8BbJ9P6MctrgvTVX+fgrLynxtjLtJ3ZcbBwrQqDFUqHGA6G4j0EzQcGFbSGxYsNT3qEIgc9WKR0Luo05pbOGirbsqiHWDHijNCb3vy6YbnOQEdrcwe8G97BCkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730414; c=relaxed/simple;
	bh=FsH8szvWrBS1aEFh+5xGcdjg1TM83EPt/kJP+WhNKHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4O3kipToTSLTx3AI4WHPWLbMNYj0yf1yDgtL0raGmxkRtuxWS74oX2AX6wwJbTBfCtW485iFMnZqGzAFMla+YR5vGdCudaCXqZF5IM/Fm8wZnJ4jvHNH/KX24fHzY9k0+HDUOAk1q/Tqh9C+MEOiz6ZdrASdDhlmEiwfl4EJMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhpgKPxq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378e622e9e3so10672381fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761730410; x=1762335210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZsofUoQy4xDbUxi1JncXn4brcSZHYShastMGK+62Io=;
        b=ZhpgKPxqGhRtgZYtUcDNv6pqxpjgYLdPepD+sQARPdbQmqs+5Hd79tswP5nlhafEY4
         pmtH64QymGpUK8GRPPxpR3UbJxp0Q7Es6SbWsHrj6/iTxVKiHdbbEwpB2YaRguaXDN+s
         2/J8XiNcPhp6ZQ/eav95xQJ2ArvV9dSaVdSL+SZEILWC3ZzLMtdyDiWH8eRC3IxjyLpA
         jTlKxYB1c4yqn+R1BGMFUjbgL1Sc1EhKrb/zHxifoLBdz4SZNxQbwK8gR6o6WnqT7ulU
         tba6cTdlIyUAUtczs406ytoNSOwC2t6ODGPBRTsapgNavV/b1WpuK1q0RuaoYKFBGb6+
         RURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730410; x=1762335210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZsofUoQy4xDbUxi1JncXn4brcSZHYShastMGK+62Io=;
        b=stmgdWHAMtsUTX/1eVhxMIx0n1QK2khjy9yTWIUMKzD5AwfDEUnkxTk/jCbRBqrbk2
         Cm/T/t3k0NlL0OtpbtPbVA015+4Ogh0lBr4RkgBWgUU2WdPevwfqXdm+20rmOHNPBzik
         SNvikO9ZGcHf2TQ3Fdb5SYe1Wq7SMcyPdjZvBPGod9AkiBTanB/ByL9Vs/k1PKEbGlqs
         U5AvCWizMoYrTSNn6m8PMqEUYVpF0w/RAchK+W56u/mHeBk+GYU5OKvtJwu+d7ysuj7K
         UuGVkSNFA6x288cYsvSij2amEUcArFjaZr8pRTl0zD4kpc3kqwB3H2ZWvaW29d5tKeaF
         dV7w==
X-Forwarded-Encrypted: i=1; AJvYcCX0BSe41P8HP7Sj/4h2mPPd9h6mb2vVFE+4ny9yPHn0P1IEjcnx8fn6mHe5VvQ+4EQQU1QNqT0tXH5RZ10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxiVZPzI5GxOp006vCEuzRze3P1SjMNg4e6sloxfWp65Hi/Kk
	k09fEbOhEtAyqOBY7NjTldageOPtt8Hn+5V960/vlW2UTBLrE33+QSBZ
X-Gm-Gg: ASbGnctPFbyEeSAd1N613Zj4a7wVerMev+OeUOIEAEH6wTw+t1iTZy3ibeqftTIK2BS
	QJarO8PuQs9ImMniW7xnSG7Awo740qZN1R5E5buDn4m7ENwCmgS0afWeQ9MMCb2Yxji8sd7StZj
	xxxiSw4hUAx4TWa4ETAb0UxQda8phs16XFqENmMYpl5TM0/540JzdHkfgz/33X2rA7zcSwJ3HbR
	wTx1qQF/ITtHfZaDQKmyaq+2/FDp+jEn5X8jIAdTtUOkr3iFT0E7tNPFf/EIl6Zf1QchIHE0hKw
	EGEYGXzEW8qCauRM42Jj3C/ooJxK95x0rHV1JiH8ZKFQL6wegl+uOFwrufBmCcKeGlK0cBRxtmz
	mWFlvYgefdmpgZA7nsTMXl3sibbPsuEE7VL/gddY+h5/dZqVMerb+eLfW4e4qxLwSDnntE3pZ4N
	AJt5dQ16UpOzSuCGtFTvlZ
X-Google-Smtp-Source: AGHT+IGzr4p5MyvY1ejjzx35Qq65bjiAfmxFhDvnxLZNuTYbHxWS6cLUXfrqNYmxCV8A0Im+UkyGJQ==
X-Received: by 2002:a2e:bc22:0:b0:336:b891:18db with SMTP id 38308e7fff4ca-37a05bd1dc8mr9065371fa.2.1761730410092;
        Wed, 29 Oct 2025 02:33:30 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09c957sm32130781fa.14.2025.10.29.02.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:33:29 -0700 (PDT)
Message-ID: <160bf6cf-5385-4304-9afa-e1d2af589397@gmail.com>
Date: Wed, 29 Oct 2025 11:33:28 +0200
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
 <4733e8cd-3a2d-4d75-adbd-a3101760d13a@gocontroll.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <4733e8cd-3a2d-4d75-adbd-a3101760d13a@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/2025 11:00, Maud Spierings wrote:
> 
> 
> On 10/29/25 09:42, Matti Vaittinen wrote:
>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>> Hi,
>>>
>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>> [...]
>>>>>> Could/Should this be described using the:
>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>> scaled voltages.
>>>>>>
>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>
>>>>> Ah I didn't know those existed, should've checked the bindings in more
>>>>> detail, thanks for the hint!
>>>>>
>>>>> I will have to investigate this carefully, since I don't have 
>>>>> access to
>>>>> the actual design of the COM, so I don't know exactly what is there.
>>>>
>>>> So I am not yet entirely sure if this works out, I used the calculation
>>>> in the driver:
>>>>
>>>> /*
>>>>    * Setups where regulator (especially the buck8) output voltage is 
>>>> scaled
>>>>    * by adding external connection where some other regulator output is
>>>> connected
>>>>    * to feedback-pin (over suitable resistors) is getting popular 
>>>> amongst
>>>> users
>>>>    * of BD71837. (This allows for example scaling down the buck8 
>>>> voltages
>>>> to suit
>>>>    * lover GPU voltages for projects where buck8 is (ab)used to 
>>>> supply power
>>>>    * for GPU. Additionally some setups do allow DVS for buck8 but as 
>>>> this do
>>>>    * produce voltage spikes the HW must be evaluated to be able to
>>>> survive this
>>>>    * - hence I keep the DVS disabled for non DVS bucks by default. I
>>>> don't want
>>>>    * to help you burn your proto board)
>>>>    *
>>>>    * So we allow describing this external connection from DT and 
>>>> scale the
>>>>    * voltages accordingly. This is what the connection should look 
>>>> like:
>>>>    *
>>>>    * |------------|
>>>>    * |    buck 8  |-------+----->Vout
>>>>    * |        |    |
>>>>    * |------------|    |
>>>>    *    | FB pin    |
>>>>    *    |        |
>>>>    *    +-------+--R2---+
>>>>    *        |
>>>>    *        R1
>>>>    *        |
>>>>    *    V FB-pull-up
>>>>    *
>>>>    *    Here the buck output is sifted according to formula:
>>>>    *
>>>>    * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>>    * Linear_step = step_orig*(R1+R2)/R1
>>>>    *
>>>>    * where:
>>>>    * Vout_o is adjusted voltage output at vsel reg value 0
>>>>    * Vo is original voltage output at vsel reg value 0
>>>>    * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>>    * R1 and R2 are resistor values.
>>>>    *
>>>>    * As a real world example for buck8 and a specific GPU:
>>>>    * VLDO = 1.6V (used as FB-pull-up)
>>>>    * R1 = 1000ohms
>>>>    * R2 = 150ohms
>>>>    * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>>    * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>>    */
>>>>
>>>> Because I do not know the pull up voltage, and I am not sure if it is a
>>>> pull up.
>>>>
>>>> So:
>>>> Vout_o = 1.35V
>>>> Vo = 1.1V
>>>> Vpu = unknown
>>>> R2 = 499 Ohm
>>>> R1 = 2200 Ohm
>>>> Gives:
>>>> Vpu = ~0V
>>>>
>>>> And:
>>>> Vout_o = 1.35V
>>>> Vo = 1.1V
>>>> Vpu = unknown
>>>> R2 = 2200 Ohm
>>>> R1 = 499 Ohm
>>>> Gives:
>>>> Vpu = ~1.04V
>>>>
>>>> I am not quite sure which resistor is R1 and which is R2 but having
>>>> there be a pull down to 0V seems the most logical answer?
>>>>
>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some light on
>>>> this setup.
>>>>
>>> R2 is connected to GND, so Vpu = 0.
>>> With:
>>>     regulator-min-microvolt = <1350000>;
>>>     regulator-max-microvolt = <1350000>;
>>>     rohm,fb-pull-up-microvolt = <0>;
>>>     rohm,feedback-pull-up-r1-ohms = <2200>;
>>>     rohm,feedback-pull-up-r2-ohms = <499>;
>>> the correct voltage should be produced on the BUCK8 output, but a quick
>>> test with these parameters led to:
>>> |failed to get the current voltage: -EINVAL
>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register 
>>> buck6 regulator
>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>>
>>> Apparently noone has ever tested this feature in real life.
>>
>> Thanks for trying it out Lothar. I am positive this was tested - but 
>> probably the use-case has been using a pull-up. I assume having the 
>> zero pull-up voltage causes the driver to calculate some bogus values. 
>> I think fixing the computation in the driver might not be that big of 
>> a task(?) The benefit of doing it would be that the correct voltages 
>> would be calculated by the driver.
>>
>> If real voltages aren't matching what is calculated by the driver, 
>> then the voltages requested by regulator consumers will cause wrong 
>> voltages to be applied. Debug interfaces will also show wrong 
>> voltages, and the safety limits set in the device-tree will not be 
>> really respected.
>>
>> I think this would be well worth fixing.
>>
> 
> Do you intend to do this Matti?
> 
> Otherwise I will give it a try.

It would be great if you had the time and enthusiasm to take a look at it!

Yours,
	-- Matti


