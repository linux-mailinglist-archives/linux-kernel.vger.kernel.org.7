Return-Path: <linux-kernel+bounces-751731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C6B16CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26B018C6B58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227529DB96;
	Thu, 31 Jul 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWOBup87"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43D182B4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947711; cv=none; b=ptTC2b7G2M3VH+I/ngdf8Lbdbd6i5KdrNztSxFDTFSMYmKhtTl9A2E5bnT0waE3N3065bU3eykb5XpVpko0H3mmm3FeiaP/3ffLcCFWB2lv8OnCyaEG1JRSU62oFBafK4VUUUuIbo8AYJi158TUCXbTTcTU8SyDnbNHhFnQrxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947711; c=relaxed/simple;
	bh=FUk+hS8UV3ct/Zmfxgtd4RMf6XdZWYcVB8mHR4pLQno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5QpHW6Ifc55is06hkshyVRrfiXZuQgJW654W1BJe78zGNr8eU2Z9AbWiXfpC7rvcqfRXa2A1wzVyjOHbBWhgW+vB/ZCXGNJKN0PjCyRAvwUi6Jbh2F86rWQoraeAz/OQBpHJbPaZoSnuiokNe1m9tpeRKc/cuvaiPUgfjfP6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWOBup87; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78294a233so49516f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753947708; x=1754552508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rg8qJybgcN2QySvV7zBDwm9nfaW7SarG7SeeC2wAVGI=;
        b=XWOBup87NdeToIdH0PJk9b6pVxx7RXm66HQ1olaNVoaKT0pnxulmW23pKYYd9xBdF5
         ND2xp9UvHRMSDqqrn4n+StUZczbiNJ4Tw5Dduw78CXIpqlMavkjIKsC/+E7urbUDWzgj
         IGmjUlrXPtzEe8VM7uH4GM+Dni7dESeLk+8dw9Oyu0F55TW9Aa7gyZ+MJfrfTSmEU0P5
         tALTxdRwt+1JWdV5wVvX49V+8tGAUXRQgfBl32lzpqvMASWno6Te4TuQQr1ILwNPpoAA
         3ifDJXzH4WuX2UgqVc4xgkfVpu22BuK0Az9I016RT52n9GblAT+5IrpOF0QL2WyKPclC
         ExEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753947708; x=1754552508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg8qJybgcN2QySvV7zBDwm9nfaW7SarG7SeeC2wAVGI=;
        b=no+iARrDoPDelfJpifX/PU4JVR2ogCv1Ulby2aVgbxIkuXmmDh9ILyaPei2teMBMbQ
         41fs83vqNLu/xdVCaR0zyhhn/tk+PlSJ9LlXCQa4kMPzMMPkAx3ZFvNumPIyz7xIaf7s
         09/lXYQ1XObQhdtkrw6eUiuCQVT3YdY9maBAmJIwUGWbDYQsYCDVW4hwoIdUBmtE4YSV
         +Ja9leCQbC9knuAXmZWIOVSu4CaXzysf/bfzjRpzgF2xRf55UhH4+Bgk6AliQRv14d3m
         MTP7iYTUBEmoLIFvQgNI7u7nS2zTPdea5CMMKk0LRs2p9FHBDUDSYFDzpsbaprWPpNfz
         MBIw==
X-Forwarded-Encrypted: i=1; AJvYcCWzjlidzPB2JHc18TgiTmSgn4S8PHQPqEMsk5j1J78vOByb30UHFareSZcTZqQyHW+S2w8sWp4HtjMjgmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylB2n2suDgv01+YQ4to6UIPbyLVyDyAyf6VuQRPGVRguh823U0
	woInxGqIFJCn9V/9HNMZOOz0JX65HYB4KO0guPMNT+VlD7lUNiSrC8l1cHAM+rLrt9k=
X-Gm-Gg: ASbGncsD7gcFUkMOamcgLgiUTlApH/4iD5hBl8oEaCw1BaK65fCX36QS3ydo4M2uH3r
	A6w3Rq3Du7ZS98J4UjGdjTT9OPEVRXQkrDYf1Tg/OzXTjcrPlJlH8rrA3NAQ9ZfXqjoPITVi2Z6
	3O5cO1Oqri0Xlg6fs6c53lS96jygVTg1oRs/RP09zsNuRu+VTtmumt09fHBNfMI/k36qN+L1cVK
	gI88+OglgQ/g8JsOPimUsZn19M085s+c1wAmzXFGMdAJ8UbOIUk6ISbBxTQvM9cupwynHsqKk68
	eeYR5k9uWtMFoPC51gIk0+5dN9TS+9MvcCLrj1kHTKqHBWWgl3vCL+P3PgT4mST+FBaEOD8mk4w
	Y+LG8UwX/Iec2CBQy7dup8RJWU2EuorITRqO7iAhsvmM9PBLY5AsC/Jod3g46Tg==
X-Google-Smtp-Source: AGHT+IF/E5/SuU8iV+jCxBPuKgOukgigRyRn5Br/+JMK7Nzazv6QWnZ9AFSrYVbUlRdayFffY5H5aw==
X-Received: by 2002:a05:6000:250f:b0:3b4:58ff:ed1 with SMTP id ffacd0b85a97d-3b79503e0a1mr4697527f8f.52.1753947708090;
        Thu, 31 Jul 2025 00:41:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm1439883f8f.18.2025.07.31.00.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 00:41:47 -0700 (PDT)
Message-ID: <858e9dd6-b3a7-4ff7-aaa1-02a140b93de8@linaro.org>
Date: Thu, 31 Jul 2025 09:41:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] dt: bindings: fsl,vf610-pit: Add compatible for
 s32g2 and s32g3
To: Rob Herring <robh@kernel.org>
Cc: tglx@linutronix.de, S32@nxp.com, linux-kernel@vger.kernel.org,
 ghennadi.procopciuc@oss.nxp.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-20-daniel.lezcano@linaro.org>
 <20250730233547.GA1887794-robh@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250730233547.GA1887794-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rob,

On 31/07/2025 01:36, Rob Herring wrote:
> On Wed, Jul 30, 2025 at 10:27:21AM +0200, Daniel Lezcano wrote:
>> The Vybrid Family is a NXP (formerly Freescale) platform having a
>> Programmable Interrupt Timer (PIT). This timer is an IP found also on
>> the NXP Automotive platform S32G2 and S32G3.
>>
>> Add the compatible for those platforms to describe the timer.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   .../devicetree/bindings/timer/fsl,vf610-pit.yaml          | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
>> index bee2c35bd0e2..2aac63a58bfd 100644
>> --- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
>> +++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
>> @@ -15,8 +15,12 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - fsl,vf610-pit
>> +    oneOf:
>> +      - const: fsl,vf610-pit
>> +      - const: nxp,s32g2-pit
> 
> These 2 can be a single enum. Otherwise,

Do you mean this ?

    enum:
      - fsl,vf610-pit
      - nxp,s32g2-pit

> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for the review

>> +      - items:
>> +          - const: nxp,s32g3-pit
>> +          - const: nxp,s32g2-pit
>>   
>>     reg:
>>       maxItems: 1
>> -- 
>> 2.43.0
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

