Return-Path: <linux-kernel+bounces-899360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3FC5780E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801DC3A75DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0934FF7C;
	Thu, 13 Nov 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsUdmOXc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604492FFF8B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038355; cv=none; b=FuVv+XBgkcB4tiYoRuxulzqrjXQ81VszkdXPBASASAirjzij3lE7AK3IViHRrtxHTtutzQ31GZlXdAh9dwmrr9pvUxjS1ypsbehjesomH0M+BEQPV+s4VfaGTHcBO0PcXOP8ZimCRGASqlHC0uSjt04jT3s/uwZc+bKxOKFxT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038355; c=relaxed/simple;
	bh=6rf5XICqyYYUFtlvVo+knUPiKpsZJ2UtI9BoM7WxNHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWEBAYsBff/ol9ik3XfwkmmBGxrucQ9pzY2Qw+xRdRkX0G90aiAIfNSh12ydj+CbBVuPfXw9G92VJeS/c7NwXG10B7xC4dv61jl32jahhn0x1bt2fSiTg5tke2NQB8fMeuLT8Oo/jyDMpsjzBYKBLny1S0QlRGjBxhCQ03tj07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hsUdmOXc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477549b3082so6846925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763038348; x=1763643148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXYoTtDd3fqHx8jiPhi5RZA+APMZjV0IIjDW2SgiBMo=;
        b=hsUdmOXcxVfusS8JDOe8Ch+o1ahwXn8wpQ1i7zxYY+frevQwvxJtdKheol/ASrS2fG
         S/gi2Mn2QKY7T45RtXol7ETORcSCHeEM+mqLrt2WhexmM8rdrpidAwhL77+1P+y+o+FC
         OPK4f1FvJFuZ4Dd8a/YgUN74GgxWa+crLvDqmftpHQp2kFb8+c5VUCPKeKvuA4FdP+8X
         K+Eql/6bnYcLkYuuvqIlgtBSVRyZSLso3/VUBVEUz+AXZS5pTsI7dtFPCS7kYKSleWMM
         c4PVgWSnPdzOQ8PrM5hMRw6eARRxOysh5owNHW/9Zc8f3qaWfX2n2Mhff0DRcGXSaY4y
         dfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763038348; x=1763643148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXYoTtDd3fqHx8jiPhi5RZA+APMZjV0IIjDW2SgiBMo=;
        b=AdAqJWAnFjeknKiTOo8/jb1oVOTvxSEGwja9pqif4OaFrS3T9pRSxcVlxlVSCTz5AW
         pr7h+kcgsja+nmuVECNkKoLy07UoxdziVjhAOwJFjY4FsSlCqp8UITAS2h1aQwvhVCgu
         FuJB+mPhZKybUaL2CYiIFgU+nxLr4W5Ijt1Fhma033KUDRpST+AWXucduLCmtwq+DFqh
         dC7K+5J4Essa52j6nJyUI9WB6xzI4H6ZrFZn3fu1ongwdRmKvbqOPzItsQLL2HlgKIU4
         FljpnEDbhs7dKbbUsrZJUu+X/CXykUQMEneRjEDV9T8Os7tIyfrZpwsuS8EGTMYErnAk
         Pm4w==
X-Forwarded-Encrypted: i=1; AJvYcCWOOuYKCHzX8UMef0wOLxzKqZnX27N3fmDlL4bE9yOlfsFAwma5qAK8ia7A73bA22z2Vbs7z2ozyp+QOyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZOaVmqlPiwsQFS6iqagxxb0cMJKh1G1BG+87zoRFwPLl9tQV
	0ix+rgIQST4KZy5cy/pIDJw7Iu5iiAd3gm5iXGYeKDu/Rh4NBfPH3IRyzN0X44WTwqY=
X-Gm-Gg: ASbGnct+XKA2q4bLfZKLtlUZx99XmZMcMi1GkRwLcacmOKOlxHAI+aLUr/CnVF6/Lr/
	VUabZJc/beKwYGHBXTy012TDxUOkIqe3xNn281BbH+AQLb8sjDk6AbTGXr/hQxy90oiJnXtsHgZ
	+/Tb3lnYjLm7x5Z1yTB+xw/UAbi9cN2oC/KtSDtJBLgQ+WFtCgAZXM31GPrwMyJDUVdJLdMvy7R
	rwSlvBQ6CNdMX5peVVFclh8vXcJ/Lllf10XhyFvqktFoxChpv7m63SY+kFcnKvAmTH6KAV2SMrx
	Kd022GtvCpJymShReEoZzZtj/nBr7J0PrUvNbr+fSl27lTnp9+HqcTWZ6jWfV+pUqlU2C2WR0/V
	Zg1U63GtYMmyU4Ce6EM1K5xWFwxAHAGovlZHKx1+IfZ+XrkJI2hYSQbRARrPuNrbhXkh9duDgzC
	+vxfvt/A==
X-Google-Smtp-Source: AGHT+IHpr3MsueMipe4IlddXi4/Vzl0f21raKHfRPZH2whdQqJt5/ks7Bz8Gchg8IDQDCn7p4XbSfQ==
X-Received: by 2002:a05:600c:c4a3:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-4778704513amr69672855e9.3.1763038347935;
        Thu, 13 Nov 2025 04:52:27 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb30e3asm21086955e9.1.2025.11.13.04.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 04:52:27 -0800 (PST)
Message-ID: <8cb0b7eb-d958-48a6-8940-6672d01b7e49@linaro.org>
Date: Thu, 13 Nov 2025 14:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvmem: add Samsung Exynos OTP support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
 <20251112-gs101-otp-v2-2-bff2eb020c95@linaro.org>
 <20251113-benign-macaw-of-development-dbd1f8@kuoka>
 <9d77461c-4487-4719-98db-1c5c5025c87e@linaro.org>
 <725ea727-d488-40aa-b36d-04d6d44a8ec5@kernel.org>
 <1af37451-1f66-4b6b-8b36-846cbd2ca1e8@linaro.org>
 <62bb6c08-a1d0-4dba-a431-0d6ce49d66b2@linaro.org>
 <8eea72ea-c106-4dff-979f-c1acd6b0d617@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <8eea72ea-c106-4dff-979f-c1acd6b0d617@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 12:44 PM, Krzysztof Kozlowski wrote:
> On 13/11/2025 11:26, Tudor Ambarus wrote:
>>>
>>>>>> this can easily be just customized chipid driver - with different
>>>>>> implementation of exynos_chipid_get_chipid_info().
>>>>>
>>>>> If the answer is no to my question above, how shall I model the device
>>>>> that binds to the existing exynos-chipid driver?
>>>> Just extend the existing driver.
>>>>
>>> So you mean I shall have something like that in DT:
>>>
>>> +		chipid@10000000 {
>>> +			compatible = "google,gs101-chipid";
>>> +			reg = <0x10000000 0xf084>;
>>> +			clocks = <&cmu_misc CLK_GOUT_MISC_OTP_CON_TOP_PCLK>;
>>> +			interrupts = <GIC_SPI 752 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +		};
>>>
>>> Maybe remove the interrupts because I don't need them for reading OTP regs.
>>>
>>> What happens in the maybe unlikely case we do want to add support for OTP
>>> for GS101? How will we describe that in DT?
>>>
>>
>> Ah, I guess you meant to keep the node as I described it in patch 3/5,
>> an efuse node with a google,gs101-otp compatible, that will bind to the
>> existing exynos-chipid driver. Then if/when we add OTP support, move
>> everything to a new OTP driver. That can work, yes. Unless I add some
>> OTP support now, to justify the new driver. Both shall be okay, right?
> 
> Yes.
> 

I'm going to extend the existing chipid driver. I looked downstream again,
and couldn't see any other consumer of OTP, even for newer SoCs than gs101.

Thanks!
ta

