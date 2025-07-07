Return-Path: <linux-kernel+bounces-720113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F207AFB744
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F261AA530C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8E2E2EE5;
	Mon,  7 Jul 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XyAstOaH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1E2E2EE2;
	Mon,  7 Jul 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901931; cv=none; b=FGoiC+AIpseR5MWcVzk9fa5WGsF5j9BiDxQy0DTZ3xAoPz7dS1KqNqrxp4SUpFf04lWrilfgKu9eicYPBkElDKpdrSYs4EFh4zp/btRFl4SxriJ5BAud1DJlqWS5LmtWTw7NBbryJY7T4EF0GfPDKBRV1ss1Zftcpl7HU0X/x2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901931; c=relaxed/simple;
	bh=juWOZsgNPV5fS9ldL5u2tLkhsDJJKTTWAxca9hm39Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NDC9W8YUM/1QpAWD+b8RGHNb4OukW2UtQ2QGGH2GDeiyJ1+c7WBp23+OE6EK4VgbQsSoEv3LnyO1stvnz5EGbvdZ7nZ+eRSJVjX3Au4Ljf5PTnD1zyU0ZV6H32nAF1GiEqCIo1352nM3ZaCJrxP5qBsTow9+UWMrgcGMx7aZQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XyAstOaH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751901929; x=1783437929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=juWOZsgNPV5fS9ldL5u2tLkhsDJJKTTWAxca9hm39Ys=;
  b=XyAstOaH2ltaLxEb/7K8b8TXRcqQVz8wf8QcApIm2EVBNEP2CXECmCHl
   eit1+/h8xWkx2q5T8P5JYoOAo8Q9zcHbKhqLGJVvePGo14ELyni+BRlHb
   QMjT6HAcjelB+j0OYKgCjXgcJbXnZSfNPXa/y4JZusjFxUmcTFvbuyui+
   jbMIQ0jTsAtxYYRY5LVlrPOA5mwweY/jBeDD0Ow4fT/ZyrXRvkI1bSxzR
   6ZrEDjBnMa1CCWGnUBgygc4WZ1dW8c9l5hDty7zcpENhnoc8VwJI68/o1
   oME5RMVu5x4OxMkhS2bdmkU0/vp6AWJUKIxHydQtEvQzGB/tuc0Bu+Omw
   Q==;
X-CSE-ConnectionGUID: ter5V2FMQaSxLNPqQc2Evw==
X-CSE-MsgGUID: 4UssQHcNQUKVKnb/MD2MbQ==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="44281645"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 08:25:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 08:25:00 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 08:25:00 -0700
Message-ID: <784f30a8-e524-41fb-8b14-99483116e657@microchip.com>
Date: Mon, 7 Jul 2025 08:24:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/32] clk: at91: clk-sam9x60-pll: use clk_parent_data
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <robh@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<varshini.rajendran@microchip.com>
References: <cover.1750182562.git.Ryan.Wanner@microchip.com>
 <cc085ca99d75fe59c13acd74782d8437bbc1d65d.1750182562.git.Ryan.Wanner@microchip.com>
 <486d447b-9984-4044-a620-1d73ffd54111@tuxon.dev>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <486d447b-9984-4044-a620-1d73ffd54111@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On 7/7/25 06:21, Claudiu Beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi, Ryan,
> 
> On 24.06.2025 18:08, Ryan.Wanner@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>
>> Use struct clk_parent_data instead of struct parent_hw as this leads
>> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
>> conversion of existing SoC specific clock drivers from parent_names to
>> modern clk_parent_data structures. As clk-sam9x60-pll need to know
>> parent's rate at initialization we pass it now from SoC specific drivers.
>> This will lead in the end at removing __clk_get_hw() in SoC specific
>> drivers (that will be solved by subsequent commits).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> [ryan.wanner@microchip.com: Remove SoC specific driver changes, those
>> will be added in subsequent commits.]
> 
> With this, series is not bisectable.
> 
> Also, building this patch throws:
> 
> ../drivers/clk/at91/sama7g5.c: In function ‘sama7g5_pmc_setup’:
> ../drivers/clk/at91/sama7g5.c:1054:12: warning: passing argument 5 of
> ‘sam9x60_clk_register_frac_pll’ makes integer from pointer without a cast
> [-Wint-conversion]
>  1054 |      NULL, parent_hw, i,
>       |            ^~~~~~~~~
>       |            |
>       |            struct clk_hw *
> In file included from ../drivers/clk/at91/sama7g5.c:17:
> ../drivers/clk/at91/pmc.h:260:24: note: expected ‘long unsigned int’ but
> argument is of type ‘struct clk_hw *’
>   260 |          unsigned long parent_rate, u8 id,
>       |          ~~~~~~~~~~~~~~^~~~~~~~~~~
> ../drivers/clk/at91/sama7d65.c: In function ‘sama7d65_pmc_setup’:
> ../drivers/clk/at91/sama7d65.c:1175:12: warning: passing argument 5 of
> ‘sam9x60_clk_register_frac_pll’ makes integer from pointer without a cast
> [-Wint-conversion]
>  1175 |      NULL, parent_hw, i,
>       |            ^~~~~~~~~
>       |            |
>       |            struct clk_hw *
> In file included from ../drivers/clk/at91/sama7d65.c:16:
> ../drivers/clk/at91/pmc.h:260:24: note: expected ‘long unsigned int’ but
> argument is of type ‘struct clk_hw *’
>   260 |          unsigned long parent_rate, u8 id,
>       |          ~~~~~~~~~~~~~~^~~~~~~~~~~
>   AR      drivers/clk/at91/built-in.a
> 
> 
> Same for the rest of patches in this series following the "Remove SoC
> specific driver changes" approach.

Would the best approach be to make every patch atomic and change every
SoC to match each clock function change or put back in the sama7g54
clock driver changes that where combined?

> 
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>> ---
>>  drivers/clk/at91/clk-sam9x60-pll.c | 14 +++++---------
>>  drivers/clk/at91/pmc.h             |  5 +++--
>>  2 files changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
>> index cefd9948e103..03a7d00dcc6d 100644
>> --- a/drivers/clk/at91/clk-sam9x60-pll.c
>> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
>> @@ -630,19 +630,19 @@ static const struct clk_ops sam9x60_fixed_div_pll_ops = {
>>
>>  struct clk_hw * __init
>>  sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>> -                           const char *name, const char *parent_name,
>> -                           struct clk_hw *parent_hw, u8 id,
>> +                           const char *name, const struct clk_parent_data *parent_data,
>> +                           unsigned long parent_rate, u8 id,
>>                             const struct clk_pll_characteristics *characteristics,
>>                             const struct clk_pll_layout *layout, u32 flags)
>>  {
>>       struct sam9x60_frac *frac;
>>       struct clk_hw *hw;
>>       struct clk_init_data init = {};
>> -     unsigned long parent_rate, irqflags;
>> +     unsigned long irqflags;
>>       unsigned int val;
>>       int ret;
>>
>> -     if (id > PLL_MAX_ID || !lock || !parent_hw)
>> +     if (id > PLL_MAX_ID || !lock || !parent_data)
>>               return ERR_PTR(-EINVAL);
>>
>>       frac = kzalloc(sizeof(*frac), GFP_KERNEL);
>> @@ -650,10 +650,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>>               return ERR_PTR(-ENOMEM);
>>
>>       init.name = name;
>> -     if (parent_name)
>> -             init.parent_names = &parent_name;
>> -     else
>> -             init.parent_hws = (const struct clk_hw **)&parent_hw;
>> +     init.parent_data = (const struct clk_parent_data *)parent_data;
>>       init.num_parents = 1;
>>       if (flags & CLK_SET_RATE_GATE)
>>               init.ops = &sam9x60_frac_pll_ops;
>> @@ -684,7 +681,6 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>>                * its rate leading to enabling this PLL with unsupported
>>                * rate. This will lead to PLL not being locked at all.
>>                */
>> -             parent_rate = clk_hw_get_rate(parent_hw);
>>               if (!parent_rate) {
>>                       hw = ERR_PTR(-EINVAL);
>>                       goto free;
>> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
>> index 63d4c425bed5..b43f6652417f 100644
>> --- a/drivers/clk/at91/pmc.h
>> +++ b/drivers/clk/at91/pmc.h
>> @@ -255,8 +255,9 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
>>
>>  struct clk_hw * __init
>>  sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>> -                           const char *name, const char *parent_name,
>> -                           struct clk_hw *parent_hw, u8 id,
>> +                           const char *name,
>> +                           const struct clk_parent_data *parent_data,
>> +                           unsigned long parent_rate, u8 id,
>>                             const struct clk_pll_characteristics *characteristics,
>>                             const struct clk_pll_layout *layout, u32 flags);
>>
> 


