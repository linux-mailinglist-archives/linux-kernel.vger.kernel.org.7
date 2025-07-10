Return-Path: <linux-kernel+bounces-725206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C318CAFFBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D251781FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C728C2CA;
	Thu, 10 Jul 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T7lu3Vnm"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A428C02C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135520; cv=none; b=cxvG6q1bButADDFMC0h6Z7ZEt1PkEKvG8IEmN4uW70Nl7rci/6l2NdBflATBMO7Fg5VZr3z5ATt+Jaw1yOtZz2fqetYisE1q94QY+7f/Vv9LK/E+DdOBgxQvv/uEl9/K49e3A91WMGr1hb/PxsmhBKX32ogETvvfJYxqn7+ygA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135520; c=relaxed/simple;
	bh=+EL8OLuDMLLMp/uF/e6dXFiI7pnVxxZAUL8Ph+lLE9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9oR/pVN2v0uHbd5U99F2Mfb06DXdooHUTXHw/luh30ln+YSTUaQDDe+xE8DJ4Eu0XOzsfYSkDO4KPh5s2n6dx9OSKiuNr93cRUxuGQicch623LX+1S7YDfNTnW6qGEVv+UmkfjzfBZvjjfg7BPFLVxMBNFjLW4WBcPuS14o37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T7lu3Vnm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1413408a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1752135516; x=1752740316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+oHkXFsQKm+K3CLYzLMU5QyZ7WKR1z3LIfoPESoqL4=;
        b=T7lu3VnmOshfhr6amPPYBXpJwZhGCv4zFOfJBKLe/ZhfcGhflJBpJGU3FMeYiiwUIZ
         ErIXRyw/UtbcNwXaS8Bj5Xz1X8LcpLqZIL49v/b4u8DVqtA6ZIyPrHMsgRlNMgPyGqzX
         esD6MI4o80RMLZvsoaR6zrmyoy9NzcgnAtmWLabhc7ASAyzdm8kvfMqB9wmu/otBHgTI
         kkmLDQIK5uv05ElOYOoT+2RjohoNB9bMeTIRnRqPTiOQRAaIyCccGr0DBr8w36D08o4E
         D1jstfuYXaCW9RDW+E+gME5uDyf4/Lu2IHizBig1wPvHPYsjrnYx8ubAaKTqDLah4GQn
         jXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752135516; x=1752740316;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+oHkXFsQKm+K3CLYzLMU5QyZ7WKR1z3LIfoPESoqL4=;
        b=IetIXgrGve1KAGFtNLGFEdHobwJh55f+12vGdUINLCRNbYkSS+8blXCKYXAKXjnWyl
         jd/XxMhbjLWGqc+g+detdQNC/gD9fv10ZqU1CNvZN5a+2z03hF1HAHhS9mrxOlQRfAln
         DnqFPgKTc9Rp6VSp/RB1MRcJnwlv9HHKAVDSr+OIKTt9Iz33j8sEkmK+21/GemKd87fC
         ykOL0L6rLuf2AQR5qr03OqRAnwHn2zoMjDJcyRWc9wYzp8sdUDeut0m8hBJZPPEHsXzT
         KrZXJbXRrnpUpnwrtNkZVuXpZksx8FuCK25J+3Ed/ZbYunYrpmmpFDOSxTYbN2AN8EiO
         JBSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8GhFkdKs8152QLW3seEE6wkm0a8A/8ZRXHK9yoK6jr+5pXz2Y3TaI6Pbrr5RlqOWhdiu7ribFdVUJaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFuFem1cPz6A47JrIh8CAQUUS6FRnBbQna/P9W2HYtmRkyzC6
	d+QxrucV4/OZ7UJx4DoGMbiScbJO7zuRXpr/SAyxKK1PWdmklXLaBv8MLBl2GFg72YI=
X-Gm-Gg: ASbGncvHlnPr3+xcx1RDiriuB057IsuG782Z0XVuRFqxFWVOWDTfoOUytFdITl4MFbc
	rfw1bWE1COf2Es61JNBztTxyDYF8oQtvyOqVArGBhl6ieLLutH4ECV0agi7HFPtMLEcqWWAHNXF
	QYGzRDcsV2vNnKf1+g15W3c5KRMtrpnEVwLn37R7kg/TdzoYTTZqXUArA3z4lHaS5vnOw/TfQrT
	MUNJNKvL3+vOtT+1lcTlU7CnhX6KxARWUzoqhV15zfi1HRs4G5TqHVlPj8h5ICnVUFmdO/K5ThP
	dsQykjlqwZ+l47dk5kSMXoCfBqpIjFvpDXk5jaHtJ/nLLIANGt5wSLjkyR94pAkm+QwL2A==
X-Google-Smtp-Source: AGHT+IH9+Y6zBGxlZWXtPGIuD+2CIc9sCQ4CgPX4kZA/Pa+VR6uPN5Br/i9pvGmZ/oOvowIV9udbPQ==
X-Received: by 2002:a17:907:7288:b0:ae3:5da3:1a23 with SMTP id a640c23a62f3a-ae6cf5c7dbemr583384266b.21.1752135516414;
        Thu, 10 Jul 2025 01:18:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e3a8csm88075366b.154.2025.07.10.01.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:18:35 -0700 (PDT)
Message-ID: <d1a16315-8e17-446e-87f2-57f18046288c@tuxon.dev>
Date: Thu, 10 Jul 2025 11:18:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: at91: sam9x7: update pll clk ranges
To: Varshini.Rajendran@microchip.com, mturquette@baylibre.com,
 sboyd@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Patrice.Vilchez@microchip.com
References: <20250610084503.69749-1-varshini.rajendran@microchip.com>
 <c51b2b64-24a7-4e14-bdd8-c4a356423100@tuxon.dev>
 <0652df01-13e8-4fb8-a2e0-35820d83ac3d@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <0652df01-13e8-4fb8-a2e0-35820d83ac3d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 24.06.2025 12:09, Varshini.Rajendran@microchip.com wrote:
> Hi Claudiu,
> 
> On 24/06/25 12:34 pm, Claudiu Beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Varshini,
>>
>> On 10.06.2025 11:45, Varshini Rajendran wrote:
>>> Update the min, max ranges of the PLL clocks according to the latest
>>> datasheet to be coherent in the driver. This patch apparently solves
>>> issues in obtaining the right sdio frequency.
>>>
>>> Fixes: 33013b43e271 ("clk: at91: sam9x7: add sam9x7 pmc driver")
>>> Suggested-by: Patrice Vilchez <Patrice.Vilchez@microchip.com>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>>   drivers/clk/at91/sam9x7.c | 20 ++++++++++----------
>>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
>>> index cbb8b220f16b..ffab32b047a0 100644
>>> --- a/drivers/clk/at91/sam9x7.c
>>> +++ b/drivers/clk/at91/sam9x7.c
>>> @@ -61,44 +61,44 @@ static const struct clk_master_layout sam9x7_master_layout = {
>>>
>>>   /* Fractional PLL core output range. */
>>>   static const struct clk_range plla_core_outputs[] = {
>>> -     { .min = 375000000, .max = 1600000000 },
>>> +     { .min = 800000000, .max = 1600000000 },
>>>   };
>>>
>>>   static const struct clk_range upll_core_outputs[] = {
>>> -     { .min = 600000000, .max = 1200000000 },
>>> +     { .min = 600000000, .max = 960000000 },
>>>   };
>>>
>>>   static const struct clk_range lvdspll_core_outputs[] = {
>>> -     { .min = 400000000, .max = 800000000 },
>>> +     { .min = 600000000, .max = 1200000000 },
>>>   };
>>>
>>>   static const struct clk_range audiopll_core_outputs[] = {
>>> -     { .min = 400000000, .max = 800000000 },
>>> +     { .min = 600000000, .max = 1200000000 },
>>>   };
>>>
>>>   static const struct clk_range plladiv2_core_outputs[] = {
>>> -     { .min = 375000000, .max = 1600000000 },
>>> +     { .min = 800000000, .max = 1600000000 },
>>>   };
>>>
>>>   /* Fractional PLL output range. */
>>>   static const struct clk_range plla_outputs[] = {
>>> -     { .min = 732421, .max = 800000000 },
>>> +     { .min = 400000000, .max = 800000000 },
>>>   };
>>>
>>>   static const struct clk_range upll_outputs[] = {
>>> -     { .min = 300000000, .max = 600000000 },
>>> +     { .min = 300000000, .max = 480000000 },
>>>   };
>>>
>>>   static const struct clk_range lvdspll_outputs[] = {
>>> -     { .min = 10000000, .max = 800000000 },
>>> +     { .min = 175000000, .max = 550000000 },
>>>   };
>>>
>>>   static const struct clk_range audiopll_outputs[] = {
>>> -     { .min = 10000000, .max = 800000000 },
>>> +     { .min = 0, .max = 300000000 },
>>
>> Is this min value something valid?
> 
> Yes. This is a valid value mentioned in the datasheet. This is the range 
> that fixes the issue of not being able to set low frequency values for 
> the SDIO interface for instance.

Sorry for the late reply. This range is for audiopll. Can you please
explain in the commit message why this fixes issues with the SDIO interface.

Also, having zero here as min rate would involve, as of my code inspection,
setting frac->mul = -1 for disabled PLLs on probe (I suppose audio PLLs are
among them). Please check:

https://elixir.bootlin.com/linux/v6.15.5/source/drivers/clk/at91/clk-sam9x60-pll.c#L693

Having frac->mul = -1 means frac->mul = 0xff meaning the HW registers will
be set with the maximum multiplier. If my assumption is right, for a
reference clock of 24MHz this will mean the Fcorepll will be 384MHz which
is not in range for Fcorepll specifications (described by
audiopll_core_outputs[]).

This may be harmless if the PLL is unused at boot time, or reconfigured
later, but if the PLL is just enabled later (w/o setting again the
frequency) and the core output frequency is not in range (described by
audiopll_core_outputs[]) it will lead to PLL lock to take forever and the
execution to stuck.

Can you please check this?

Thank you,
Claudiu



