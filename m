Return-Path: <linux-kernel+bounces-746730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4AB12A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90D74E58ED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3641246768;
	Sat, 26 Jul 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="dHuwALo+"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB5233145
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753534676; cv=none; b=EnXKABRTQpX/qgbnRpxTgsjJrXlRAzgo2AUcKRUR5E4W+AOIGf+tBPlKd5HtE3z1ViGsxXbUmQNDf7YuQPDtc3BCEluDtxaOe/kg0oWkihCffqBpbJrRVZUDdBnCB8C6qEtebFVHehVeKC5CBepJb13Qc1n8Xz1v0pclidA6Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753534676; c=relaxed/simple;
	bh=2lFsjqaXkY+9lybBw6P/Zhy/kr8mE8D11FVC2cE4RlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3hq3DeFGVEaGn+8zSRbeF2X4va2QzzaiflI3e5WQ8X2dHKFuNixus+fis9p2dzEgdyPgrhdMXLxFFpyW47rf22jLF2noN+UrdO8cincuBtH3xByGrcUK6XZWF9P1G4Odzn45HsC1V6wUxgKiw8jNJt5iXfFVGo0fDdSwuSBQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=dHuwALo+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70707b268b0so22614016d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1753534672; x=1754139472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33vHvGUYy2jUaJ1MFRxvGoPpdjPDXIobpjBWzBoYSe0=;
        b=dHuwALo+IRl30+AG8DVuXqCSopMOKX4NympPpQNckDeM5QqozTqI2zwqdvD99V9NTO
         +CnpSBuB1o21pgvEnMh0Oda6OjsYwJec45mDjwMcy1njLBE+6NmUQU0JtxiIepQSkmpu
         kF6+ruhvKX52Tp3A5NjV7UvD/HX51wz5bTQTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753534672; x=1754139472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33vHvGUYy2jUaJ1MFRxvGoPpdjPDXIobpjBWzBoYSe0=;
        b=vVvYU/66gS2Ev/bKleqzIKF+hT9O0esNwbYFGlEviRLYlh/aXweaUOWI29xG/rA6S4
         eT1j7Y4B6NtmVA9x3EUw53vTNQQ9XBBIk8n6W5ax9j2qcT22Nq5sDsJIFO93vKTiRW9q
         2krZq1B+/r2X0g0PMsdwxB9LaSWAmDZbl7IqpxFHkkN0aSa5B7gwGwxbYKVuwiTvEe7i
         GM6qC+Vb+7OkoHc+1yjne2JslE1n63WdDzP47fVy0MsrvRpkr9IVs3GJoEsBLsYlsmoK
         CVEY82ydsvdMWMFugj26kDAACGoFJ97pn4bCvgkMGUvTqVbS4Dg5tBOeS+bo//G6IcD2
         199A==
X-Forwarded-Encrypted: i=1; AJvYcCXDQdX7r1soolUls37MMOkJMPnyC9q+s4QpLCywaXwBW1CA/kF7q0Lm4UAKU/femL5QWqddq+GHimHl3VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRJ9DxgY7IkM494eRWjrm5zeVOo6CTTJAMkQhyWcmP7BMSGU5
	8P731ZY5A0ZoKYIj0JkgLQtgca39NT02FdUSUnLxvtXOZd7C0LNtGjaXd8+3htdBBQ==
X-Gm-Gg: ASbGncvCiMcxD5Zm3fKmKlj/og0qGwy8Ep5Fzru5K8D8K17ScOkbh42vhsYToYIbc6n
	qROS+JT9t1LmpIp3oXqj9UIeFWA2MQb/bJAzEbUOWC6F8AAS8wE4suucKPNasnbIS5NohgDTX3w
	rTZeebfDxO0j50tEA67Lgz30oyc9jdPU5YUq6TI/He6EGZqizCxrIsL3QGh6SAJPLqlHLn5k99u
	3OZjKjjQNsZLZlf9YAxLm+a3uLPpQJGMOsm/p85DdNbE2tgksxsgAucWKS9cVIyHu7viaaUS+pk
	aPLtIJ/m1ivBRS320wRNENFyDpfksziE3cZod2o5QXG+J491GCI7r/tjIb218HjXdK18o85U992
	xI/eEoG6KVVvkwVhKRKR5LZwis7Ml45xrx07u+LSUW6MfujH3y1kZTuz4Roy18ViBag==
X-Google-Smtp-Source: AGHT+IGb5AjxoFosxgBP3Pc/RtOYVIrHr0x3CfJjhlmHSPGuq16MvnncfHDH4Nbi3Zz1t72hhHOhFA==
X-Received: by 2002:a05:6214:268a:b0:704:8db8:d3cd with SMTP id 6a1803df08f44-707204e8855mr68135236d6.8.1753534672381;
        Sat, 26 Jul 2025 05:57:52 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-70729ad99d0sm10716946d6.46.2025.07.26.05.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:57:51 -0700 (PDT)
Message-ID: <d968eb77-50f2-4d28-a57a-112c87dff8bf@ieee.org>
Date: Sat, 26 Jul 2025 07:57:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: spacemit: fix resource leak in
 spacemit_ccu_reset_register
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, sboyd@kernel.org,
 dlan@gentoo.org
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250723132504.66273-1-hendrik.hamerlinck@hammernet.be>
 <ed5fcfec-6330-46e8-a302-5cf1d8b3a9ce@wanadoo.fr>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <ed5fcfec-6330-46e8-a302-5cf1d8b3a9ce@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/26/25 4:16 AM, Christophe JAILLET wrote:
> Le 23/07/2025 à 15:25, Hendrik Hamerlinck a écrit :
>> The function spacemit_ccu_reset_register() allocates memory for an
>> auxiliary device. If auxiliary_device_add() fails, it skips cleanup of
>> these resources, resulting in leaks.
>>
>> Fix this by using the appropriate error handling path.
>>
>> Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>> Reviewed-by: Yixun Lan <dlan@gentoo.org>
>> ---
>> Changes in v2:
>> - Properly place the Fixes tip.
>> ---
>>   drivers/clk/spacemit/ccu-k1.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu- 
>> k1.c
>> index 65e6de030717..5bb85e32c6cf 100644
>> --- a/drivers/clk/spacemit/ccu-k1.c
>> +++ b/drivers/clk/spacemit/ccu-k1.c
>> @@ -1059,7 +1059,7 @@ static int spacemit_ccu_reset_register(struct 
>> device *dev,
>>       ret = auxiliary_device_add(adev);
>>       if (ret) {
>>           auxiliary_device_uninit(adev);
>> -        return ret;
>> +        goto err_free_aux_id;
>>       }
>>       return devm_add_action_or_reset(dev, spacemit_adev_unregister, 
>> adev);
> 
> 
> Hi,
> 
> I'm not sure this is correct.

I'm sure this patch is incorrect, and the original code did
not have the stated problem.  Thank you for calling attention
to this Christophe.

Stephen, could you please revert your commit of this patch?

Thank you.

					-Alex

> auxiliary_device_uninit() which is called if auxiliary_device_add() 
> fails should already do the clean-up.
> 
> So I would say that this patch adds a double-free issue and should not 
> be applied.
> 
> If I'm right, note that Stephen has already added a "Applied to clk-next"
> 
> CJ
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


