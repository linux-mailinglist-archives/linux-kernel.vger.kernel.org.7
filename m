Return-Path: <linux-kernel+bounces-735142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52AB08B74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8562CB40799
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77F287504;
	Thu, 17 Jul 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5GA65ov"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBC299A8E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749701; cv=none; b=UYamFx6XXWDsBwuVWzlrD46MrbLHk/xjh/jBAqKs5nI2FgtQpTJzfpgWPGDQXZKAxEsSoFVdGiGtvzkqNusBMs8nEGPNv20RN65lq2qcaMwI/PGprl2vBPQiVXcJ2KwI49x4EORh+CXK2Kxbe+q0mtKh2o8so6YQ0BC0gfoI/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749701; c=relaxed/simple;
	bh=Er25eTzwhi8ZiwEYoPbsGQZZpz06nKKfV0nAiBsFy44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM7JOOPYss72HR/T9fpEiW0ReyrTIxcqimrTAho3mtz5l7wwOCuUeF+dktQ4f/6fhi33VGcFaFXaNVa9NUyOnLLIoyjMLl+o4Y6HgY9lAGOxD+i/qRNQSLTxg9I6OP+RDwTWPFOWt0MU9el9jF5MTGyFNJnYWTmSAsVPdYnVwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e5GA65ov; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6070a8f99ffso105539a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752749698; x=1753354498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/V2MviyGAzT/JN6dxCVLQJ7uBRHRVUnw2NP1iPLU0LE=;
        b=e5GA65ovXnMAnDImbcYA83CXS3PENHytNF2AD3+Jy6V2yywjlVPdXkZuIcGL+ZohNm
         CGFSmnsqHYOWd4ehnGCJ7HFgu0qOs9ILAAdayMmF7K5igsL23GfDC7/N4LxGXaWS6oPQ
         J/hYfXKWASx74vuO0NvqTaFvo3Kx6CY5H7y2y+G6lBI2krOEHNX7eu2pN3mAkqvXSxEz
         QsVf7OClKlXfg6rw3LVrdoWitlG3TePZTZxiOfbM98Y7U+FL5GAI1PBWIbWBE/92E7d4
         npInmz7AD203MYY2ElXDkyvH5Eo+mlt1IEXXWi4n7Xd6GWqxrmG8q9ECY1uQHtqv3Kkj
         qXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749698; x=1753354498;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/V2MviyGAzT/JN6dxCVLQJ7uBRHRVUnw2NP1iPLU0LE=;
        b=uqz4xWXQn4jKHvcUzMGJoj83HoLztbhbeSicf+v8ypomHUjb4FpMs9giLhsw+VMU2O
         7TRstveVXysMTyhUMBrd8/HpJC0NphaxVow7qurmwIXgdnLdEMqlDsTJJxys/ZgH6FNF
         FfLfKARIJoEo8nSeR49eB9aO0DfeG/FDofb4wYDi8O/LXyBvgXVKcOos82lE4aTDBz+G
         55Wxe6IRNxdin0k6KqntsMHLzdvOphxGOERy3yLbtr3y3FnaDwnYWNKEKXbeM30uK73P
         2ufwBMlPjg7TpCFzl5BwA8F6rqMyYj20l1z+xhA8pEuTPXTApupbR3z6MOL5KA5fUHDb
         07SA==
X-Forwarded-Encrypted: i=1; AJvYcCUcySEewmkIv6FmInt42uMLKFvz3nJM2t8y4mmlpcfiv2ONLHMTpZOI3n3dAzGlPkbdpGCajBLvTpVpVyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeeg231Q5k7tHP18W3U6Ew72yx6X3UYMTxPG63OV/CpXokHbZ
	WCZMMMKrtOQTZmddEUces6U/ZUjFMIdv+M/oTKXxv2dMHaJhGVmDpFiPyGqAej9VGfI=
X-Gm-Gg: ASbGncup4vqGZ0YUmXW6XETVz7wEBPbNxzWCejzBqDYa93YHB3OTrn+jF16Mix/73Er
	4jbxbEftOBbEQzTp4tdg8Dzd1DRlu3mh6Iqag8FF5VWXpXK/8JyrsWYUwWSAXtU5ClhNi0Y5Fib
	bfEYbE5BDILwEx/AT8MrTS52H88DfLkhkmcebyOofKpVWH3Avg+tF64boIxaC4vQ/aNPLMNbftn
	LNIf3pJC671TpAtuKb5UDSCiIODw6NCfEKkrCYGF972YC6m1oJ5BQL5fIQtFMzAZj3FjJfYh1VA
	qJPiHBk+KqyFK5AsQ3yDqzogtvcwbARz3zDNiOrzu2HTFNvc31Up9KuuCQNbdv3NiBDT8oipGI9
	3LrofuBz6SLMVFoMAmbbsZhcgdI0TgOaGTsuR/iWQFw==
X-Google-Smtp-Source: AGHT+IGu2OLq/BsPAi+TAE2zw+MF9bSuniM2AmRmTWHU6pTb8+Im+klOA44xCQaGUsS4YEodFOYiIg==
X-Received: by 2002:a17:907:980e:b0:ad8:89c7:61e2 with SMTP id a640c23a62f3a-ae9c9a1f649mr257220566b.8.1752749697708;
        Thu, 17 Jul 2025 03:54:57 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee45ebsm1339994066b.43.2025.07.17.03.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:54:57 -0700 (PDT)
Message-ID: <f6f86227-8d26-400b-9ad6-605cee966b56@linaro.org>
Date: Thu, 17 Jul 2025 12:54:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: iris: Add support for SM8750 (VPU v3.5)
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org>
 <20250714-sm8750-iris-v1-3-3006293a5bc7@linaro.org>
 <7b0a984f-b62a-ac4d-74bf-a6e839c59272@quicinc.com>
 <d4c39f2c-9f95-4e65-87a3-78173b39adf1@linaro.org>
 <1c5df071-7000-ab45-dbc6-4384d883ba24@quicinc.com>
 <a6dbca7e-4d49-49a6-987c-8cd587501c98@linaro.org>
 <3a87c37b-b392-598a-736f-bb01e4c311e1@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <3a87c37b-b392-598a-736f-bb01e4c311e1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2025 12:50, Dikshita Agarwal wrote:
>>>>>> +	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
>>>>>> +		ret = readl_poll_timeout(core->reg_base + VCODEC_SS_IDLE_STATUSN + 4 * i,
>>>>>> +					 val, val & 0x400000, 2000, 20000);
>>>>>> +		if (ret)
>>>>>> +			goto disable_power;
>>>>>> +	}
>>>>>> +
>>>>>> +	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
>>>>>> +				 val, val & BIT(0), 200, 2000);
>>>>> what are you polling here for?
>>>>
>>>>
>>>> This is not different than existing code. I don't understand why you are
>>>> commenting on something which is already there.
>>>
>>> Which code are you referring to?
>>
>> To the existing vpu33 which had Reviewed-by: Vikash Garodia
>> <quic_vgarodia@quicinc.com>
>>
>> You understand that everything here is the same, everything is a copy
>> while adding just few more things?
>>
>> My patch is not doing in this respect anything different that what you
>> reviewed.
>>
> 
> It seems to have been missed in vpu33 power off sequence as well and should
> be fixed.
> 
> Still, as mentioned earlier as well, your reference should be
> HPG/downstream driver of SM8750 not the previous generation (SM8650).

Yes and partially no, because we write upstream code matching or
extending existing upstream driver. As you said earlier, downstream is
not the truth always:

"That shouldn’t be the case. The downstream design is different, which
is why the driver requires the above code to move the GDSC"

so here I built on top of SM8650 and re-iterate whatever mistakes are
there. The best if someone fixes VPU33 and then I rebase on top,
re-using fixed code as my base.

Best regards,
Krzysztof

