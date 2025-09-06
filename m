Return-Path: <linux-kernel+bounces-804423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E69B47651
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2CEA45467
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B1281341;
	Sat,  6 Sep 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="J2jc4APL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8121171D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757184729; cv=none; b=CwhLAw3Bxm1Eko55B2xXiTTbxlLs072YATEm+orarcrjIAf33Ly6fkarofMVR5dgKqDr9Ixr48tAayquqzUBo0jVOQJW1psJuZHigkDUolzmkycgvP9FqlCnQYttW26TRkJ9Hy47SgxEZVraLZP7qPlLgqzOjucuUZ0vLX8grSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757184729; c=relaxed/simple;
	bh=AXwT0kHloCdjCQXQT0QNKgsw9c361exmwtf2WiUe9g0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eXZSBNaNv3Tbfq+wFbfZAW2JkxY+g90F8Q52E8qlsaQIH+fK1xprRfI69Hie+ZOmRE6zCnvvUklfti+VewQ+gvcUQvf09KNQnJpPmdZqAHFqB7OFwS10qA7yIheCwPuw7MYuR8n7NEjAaeka6JbYH0yum5nYK0HLhEyymKNFwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=J2jc4APL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so15953775e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757184726; x=1757789526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYHy1RYaZz8qwqLoCLiBztSqW0ycyPrtnmbrVy9V3QA=;
        b=J2jc4APLfQCD64LPpYHb6WczF4Fgr2TY99RQ3r19ljesYTCj4je7CqkL/Kodvq1Ta/
         e4M0Y6bNmdhHhZ0/d5BhmVWmjDvpMJtH+HlErJ//Uj49H6fO7xogW4AB2ujDCn2otE3t
         4Ali7b2iEl3WdDe7W4IlDWOgoZe5UQ3oQjWO0k1wKdnS7+KouDZFqaJlycIBeRVO+haf
         WvRk7iDPIPKeT4ipuEuvGRNyyz085BeRrERidt3D6+TM0qV4W45aBKyT6h4e2vDpmy04
         q/7IIwEKdbU5y9KISHtzalk6faUweEfXNQtpRjo/8ioL6VvRAiQWKzbFhLRQ13UDek4K
         CDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757184726; x=1757789526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYHy1RYaZz8qwqLoCLiBztSqW0ycyPrtnmbrVy9V3QA=;
        b=LNocq+3EdQyG4An4liS5UknK55yok3VFZGD0e9Xzeq4jNvol1ZQRhDxa7KobUsYAw6
         pwhh64UIsFH+Zua9EmrPDre6e9s0Z9Swu+ImOtGWkZ+Ne3sCE9tA2gnQMoBAzH0hpSTk
         H4vOxiPNywUmAi3Ze1KuirZNnIfSJjVBhXwr9vLeb/d7TXeHTiYLkNZSdedCqQ4eoEYo
         5byCeuyqwRHGXYiK6o3Rzm0HHksAxVzQuk7Cagm8XSPp8oiyCGxV7ExEIJqchJMjvedm
         pTIKkwJkd4c1g07FHEfeqod5VO5FwE04fhfcB4jnJPxTvQeO3yWldkJ4cqnXxKarfHAK
         3zUw==
X-Forwarded-Encrypted: i=1; AJvYcCWV1+ho+ESnHjfk5j1FWD4iof3AftnAKi/QlnsvP2BwvQtZyp0C6TkiCxs1k6vYOWdw5KYSRKFb7pGVWJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFszY0ordLbl2E3HOwlpNoT36oDdOLQmFK8TzAuYoqVwHg1G3w
	qSe6NdETxfJMkEiCRUqKZNW8cXUiBKdVQIQM7ZjXMjIYFkkfsuhbNHWOk02l4vseJWY=
X-Gm-Gg: ASbGncvxyUGKxcOSwBPYsc/I8ERHNKu+k/qI39IkK1ncl0ZzjWbE4vt7DxHVAqTNk5a
	ZI+xDfUgaJNwNpR2GevkOWFap6ybPUp5lJ/d0EbfCmL/x9/0fFRMqsheRjAvpUdzxnbZPYF7uyd
	+Dg0msLQ0PRjX0OiP86m0TNsYd/vcJQ6CoWsHLXgeczYGUTQHGpPbqm4W6giXrrAwR8DqS1CBkL
	0pANKucB3ukawog6g2U5fVkxO0zvrT8P4lXV4M6V2toPdw93VAo9hmwLIvmALoEjIUkZEbWuCZv
	mN495XI1pqKWNhYEn+igZVNGkNiZy2QFHOSTQh9fu4fQV8QCE9YHyRIEV45+UL2uxMSvN0Rw51z
	vJci8CBZdAwsrRfekQEG+z5pXUF2IroKzfrSYqDhe/w==
X-Google-Smtp-Source: AGHT+IEpMP6ACL8oRBA8hTz9DJ0XgNVlGBZlDBNrI3mU0DI00pLaSesHNRCSOeWsnURabXbOB6R20Q==
X-Received: by 2002:a05:600c:8b5c:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dd5b78584mr60223555e9.16.1757184725986;
        Sat, 06 Sep 2025 11:52:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb687fe4esm150076175e9.23.2025.09.06.11.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:52:05 -0700 (PDT)
Message-ID: <41cf6626-ce6f-408f-bcbd-299866d70fe0@tuxon.dev>
Date: Sat, 6 Sep 2025 21:52:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/32] clk: at91: at91sam9x5: switch to parent_hw and
 parent_data
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <95cbe3653752bc3c0b6f068949706313e3778fe5.1752176711.git.Ryan.Wanner@microchip.com>
 <10f016fd-2ceb-40b0-a81d-9c5663f65191@tuxon.dev>
Content-Language: en-US
In-Reply-To: <10f016fd-2ceb-40b0-a81d-9c5663f65191@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/3/25 18:16, claudiu beznea wrote:
> 
> 
> On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>
>> Switch AT91SAM9X5 clocks to use parent_hw and parent_data. Having
>> parent_hw instead of parent names improves to clock registration
>> speed and re-parenting.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>> ---
>>   drivers/clk/at91/at91sam9x5.c | 125 ++++++++++++++++++----------------
>>   1 file changed, 65 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
>> index 13331e015dd7..f6138622ab50 100644
>> --- a/drivers/clk/at91/at91sam9x5.c
>> +++ b/drivers/clk/at91/at91sam9x5.c
>> @@ -38,9 +38,9 @@ static const struct clk_pll_characteristics
>> plla_characteristics = {
>>       .out = plla_out,
>>   };
>>   -static const struct {
>> +static struct {
>>       char *n;
>> -    char *p;
>> +    struct clk_hw *parent_hw;
>>       unsigned long flags;
>>       u8 id;
>>   } at91sam9x5_systemck[] = {
>> @@ -48,12 +48,12 @@ static const struct {
>>        * ddrck feeds DDR controller and is enabled by bootloader thus we
>> need
>>        * to keep it enabled in case there is no Linux consumer for it.
>>        */
>> -    { .n = "ddrck", .p = "masterck_div", .id = 2, .flags =
>> CLK_IS_CRITICAL },
>> -    { .n = "smdck", .p = "smdclk",   .id = 4 },
>> -    { .n = "uhpck", .p = "usbck",    .id = 6 },
>> -    { .n = "udpck", .p = "usbck",    .id = 7 },
>> -    { .n = "pck0",  .p = "prog0",    .id = 8 },
>> -    { .n = "pck1",  .p = "prog1",    .id = 9 },
>> +    { .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
>> +    { .n = "smdck", .id = 4 },
>> +    { .n = "uhpck", .id = 6 },
>> +    { .n = "udpck", .id = 7 },
>> +    { .n = "pck0",  .id = 8 },
>> +    { .n = "pck1",  .id = 9 },
>>   };
>>     static const struct clk_pcr_layout at91sam9x5_pcr_layout = {
>> @@ -133,25 +133,16 @@ static void __init at91sam9x5_pmc_setup(struct
>> device_node *np,
>>                       const struct pck *extra_pcks,
>>                       bool has_lcdck)
>>   {
>> +    const char *slow_clk_name = "slowck", *main_xtal_name = "main_xtal";
>> +    struct clk_hw *main_rc_hw, *main_osc_hw, *hw;
>> +    u8 slow_clk_index = 0, main_xtal_index = 0;
>>       struct clk_range range = CLK_RANGE(0, 0);
>> -    const char *slck_name, *mainxtal_name;
>> +    struct clk_parent_data parent_data[6];
>> +    struct clk_hw *smdck_hw, *usbck_hw;
>>       struct pmc_data *at91sam9x5_pmc;
>> -    const char *parent_names[6];
>>       struct regmap *regmap;
>> -    struct clk_hw *hw;
>> -    int i;
>>       bool bypass;
>> -
>> -    i = of_property_match_string(np, "clock-names", "slow_clk");
>> -    if (i < 0)
>> -        return;
>> -
>> -    slck_name = of_clk_get_parent_name(np, i);
>> -
>> -    i = of_property_match_string(np, "clock-names", "main_xtal");
>> -    if (i < 0)
>> -        return;
>> -    mainxtal_name = of_clk_get_parent_name(np, i);

Same here, and same for the rest of conversion patches.

