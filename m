Return-Path: <linux-kernel+bounces-730257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612EB041FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9303166437
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2242561A7;
	Mon, 14 Jul 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJatAwmu"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8C14A60F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504059; cv=none; b=mSUFAl0XE7jM+Hab50aJvwXaFb0LYX+U39szwBFyXyA6yjpDzJkf6c34tmjDV5Ro779aF9YileOQ67TsANNVkOI7S7cn3KvEgKzIBCyCq09e3T515FAIspNMkFDkzjOLWW1KrcHt1/fUbQdlgo25k/0zLsTK8qS4Fyo2aZ1TjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504059; c=relaxed/simple;
	bh=KPa1Xi+0Kj9jOLgaY3CpZ5S39oFaWuIleqPBJQU4uko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pg01DrxflZWWbaUm7P88zXpgb99u48e+yFPSmDzf8yfSnlLlgYMPfHdXFuRtJ4XcbUr69d5LMLLT5J43uDGWHVZjvzctBOLiN/zDoYcwxvrlNQAm2mnKK5XOIEnuSS0LfkOf9X8VmB3vgNbgEdldKAbenDmwChEV7npyns68YyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJatAwmu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4562421501fso57555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752504056; x=1753108856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=83mP6l1iA2hcAoEVcKK7xAWQf3cJP6s75bC7pATme9U=;
        b=zJatAwmuxgmSNRVF47AMoXX1E2O23aNeShSeSYW5NWZDI/ZmlZ8vf7zZkxRuKVazqp
         joQA70Pd6avAmAIEe0Jx0KRWhD1IsV1/UiVzeipfizC7pQEAys2LKcyQwm+9iI9EP/js
         0R6Iyh2pyfJymVDbw932URstbBqjLkwJs8UFg2Ib0TTCouVKF5TmOG2hBlO/wgaeRAdK
         P7McbBjpJTMnZwFk4xM+dv701dtzXAOEJ1WhaNMtlyTXW2ZT3WfAGSmygS+C5qGgTrJD
         +5wtV3efRV7O7t04K/JS0QlrEY2QTARO+q1a0T2P4r1WXBZ+vUSec6pkMnyaQQMxeTrj
         folw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504056; x=1753108856;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83mP6l1iA2hcAoEVcKK7xAWQf3cJP6s75bC7pATme9U=;
        b=jThbU0v3gqVYsqXzzWC5ttqxMcNI/k8NezCNmSN/ngA68sqz5wNX4FX30aF7YIz5Bz
         6SmkKz0uZDdHo/WktHJ3eWTJ27MZNYcC16asSD5y+nR0KxAMSb4I/yRAo4RtyUQvpanG
         yclijGTSaqdkE5jXZaeXeWyC9MqIq/6jUr9GnZKc8uQHrPmM2Ozo313DM/JOFXXiANcq
         P4dz4oaAsv4rAALsPCCJCzRuyVOyhex5J08RSFEFoNrdAOvSomlmd0dSisPZpDVdpk1S
         DmzSaNk9l1EN9nQGJSag9A6uQwb4tx9dJU1gY8L4KJcVtPqyzYjbIwchOsjfRFizmwjr
         ZKEA==
X-Forwarded-Encrypted: i=1; AJvYcCVit+ZohvZhjk29THJrlH3RqNU53RWqqmy7p7qwCsV5JbmQOITfGYmqctepxxyKRvtROtB5HErp2/xhPkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGoQ/rPzL8sESSsqRzKtxODPSxpj0Wgj2R86P4dvA1O8ljxPB
	aK0DhRDdr3X6A1FTxvJNDtjJFI30vWAnF4AajXYvtrcJPjcfRbdZJ4cNHaSKFifUw9M=
X-Gm-Gg: ASbGncuHPF71aKM1db9UifTAkA3TiZyyf4cKduWeurVm6FKbLS++Z88wl3JXNy39vER
	wTX2E2jLbkgmQ2BU1t7MPQQIGXBZwV9ehBjKU9hRpyiv/uuCzjrE4ijobFRQztykWKNa6xrKita
	EFx3zBPy/ow2QMxkOsKJdlC4Odh2C2SLfqOY7/kro14MheJYbG/Kmw2aPajJ6MZu8ShnO7rCB2w
	52U+CtM93kpFgBCtj9TpRxnhEgMLe6bdsra9kNuQEI+mtJEPPHakwGb3c+qpYg5/CfTiD9iIQln
	aMUyA6rj4QJXs0BC0sC3TY7JrO7koDuDDtWEt670IdI4V9Rs1xCqSzq5VmqT+FGNRFrjbXfdzSC
	fEKamnqznqVPkYBjpRxgYV77QukSwWKa+y2HPYTwTO4TSX+X61C0b
X-Google-Smtp-Source: AGHT+IF/6VLR+s+RRZQkaP+/wGIfCuQAfLZweR0sCDTX1mOmUud28cvHC26ApEa2AAxHWg7MFRtFOg==
X-Received: by 2002:a05:6000:659:10b0:3a5:2dae:970f with SMTP id ffacd0b85a97d-3b5f1893c29mr2997763f8f.13.1752504055681;
        Mon, 14 Jul 2025 07:40:55 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d5easm12473850f8f.48.2025.07.14.07.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:40:55 -0700 (PDT)
Message-ID: <f9157fbf-09a1-41e5-b5f2-902ca20b870d@linaro.org>
Date: Mon, 14 Jul 2025 16:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c: master: cdns: Simplify handling clocks in probe()
To: Frank Li <Frank.li@nxp.com>
Cc: =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250713152411.74917-2-krzysztof.kozlowski@linaro.org>
 <aHUQ7Ge97/glY+s7@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aHUQ7Ge97/glY+s7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 16:15, Frank Li wrote:
> On Sun, Jul 13, 2025 at 05:24:12PM +0200, Krzysztof Kozlowski wrote:
>> The two clocks, driver is getting, are not being disabled/re-enabled
>> during runtime of the device.  Eliminate one variable in state struct,
>> all error paths and a lot of code from probe() and remove() by using
>> devm_clk_get_enabled().
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/i3c/master/i3c-master-cdns.c | 51 +++++++---------------------
>>  1 file changed, 12 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
>> index 449e85d7ba87..cc504b58013a 100644
>> --- a/drivers/i3c/master/i3c-master-cdns.c
>> +++ b/drivers/i3c/master/i3c-master-cdns.c
>> @@ -412,7 +412,6 @@ struct cdns_i3c_master {
>>  	} xferqueue;
>>  	void __iomem *regs;
>>  	struct clk *sysclk;
>> -	struct clk *pclk;
>>  	struct cdns_i3c_master_caps caps;
>>  	unsigned long i3c_scl_lim;
>>  	const struct cdns_i3c_data *devdata;
>> @@ -1566,6 +1565,7 @@ MODULE_DEVICE_TABLE(of, cdns_i3c_master_of_ids);
>>  static int cdns_i3c_master_probe(struct platform_device *pdev)
>>  {
>>  	struct cdns_i3c_master *master;
>> +	struct clk *pclk;
>>  	int ret, irq;
>>  	u32 val;
>>
>> @@ -1581,11 +1581,11 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
>>  	if (IS_ERR(master->regs))
>>  		return PTR_ERR(master->regs);
>>
>> -	master->pclk = devm_clk_get(&pdev->dev, "pclk");
>> -	if (IS_ERR(master->pclk))
>> -		return PTR_ERR(master->pclk);
>> +	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
>> +	if (IS_ERR(pclk))
>> +		return PTR_ERR(pclk);
>>
>> -	master->sysclk = devm_clk_get(&pdev->dev, "sysclk");
>> +	master->sysclk = devm_clk_get_enabled(&pdev->dev, "sysclk");
> 
> Can you use devm_clk_bulk_get_all_enabled() to simpilfy futher?

Instead of asking redundant question check yourself. On a first glance
it cannot, because it won't be simpler - you still need individual
clock. But if you find it possible which is not visible on first glance,
make a proposal instead of just random drive by comments.

Best regards,
Krzysztof

