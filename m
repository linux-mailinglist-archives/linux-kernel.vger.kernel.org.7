Return-Path: <linux-kernel+bounces-819365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64007B59F64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F851BC418C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEF2F25E4;
	Tue, 16 Sep 2025 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XU23z4Nz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE5277C8C;
	Tue, 16 Sep 2025 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044130; cv=none; b=MdHyvqdtHxdiYjbamy4eR5qhkN0Mg1wXL2T+0wf8ynu3KNGrl4gM5Qszui57D/at/9FUmROD6GBk0OKmfGxIfTR0yMOuSWH8i17c9kGmfvFwCOTpYi+hsL6B8PkHOyfOmKNsxteEsKY4/byel/pOwQUg8ngIJFcNYBqQJem7g4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044130; c=relaxed/simple;
	bh=Ix9BZEDU706zVBE7HUYL3TRWisPsGB6lyHix83FcTUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k/Glw+AeKGltchCjLF2Vk47jW1lBFmlzcIPnPSF/FUEwh+FKhaJ6BMGoWT4fVYOzFRG+Yyt3suJnw17zvWpZV9o7SZsbjJahReEGjqrSB6T8rgGPblROsgSH52cWlM+PTWCEtfoLcmyTOl5FoJ18qv1KshgscA4CqdmjG5otneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XU23z4Nz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758044127; x=1789580127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ix9BZEDU706zVBE7HUYL3TRWisPsGB6lyHix83FcTUg=;
  b=XU23z4Nz1nTucSud+uQyEJdmcjhNH0Kc9yHXv8L3oNT7S4Z23XeTEHXk
   1nMg70qRKVqF+/kl2i2SrplU0yldgXOhIaiS35qLK+RjmqY2nfJQmV4SY
   vgHZyJApdKcsuurKlZZwP6HwtLOPyggsm1ZW9DNX/bZgiXgR3SfqY0pJE
   XE+Q+HyzFTDK4xmIw8iGiR/WbOhAzIJgbtx1EnPgeH43tlANMT8Trp1/1
   KVSMUa1DH15kefNgY1QNEhSz7ryMMDQdR8oIHUgu2uwl2IxwADSWWcHe5
   inmt8ZOYFGN4GbYYSCm8drwVIvSfcvF3x0NhJ1gENnjOGApfeitElPfKZ
   Q==;
X-CSE-ConnectionGUID: 9gsFoYIUQd260MqKd1EmbQ==
X-CSE-MsgGUID: hgZsQh8cTE28XQxvMyJx7Q==
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="52418539"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 10:35:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 10:35:06 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 10:35:06 -0700
Message-ID: <61cfc570-6632-4e14-9e2b-2bd5d2ce1690@microchip.com>
Date: Tue, 16 Sep 2025 10:35:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/32] clk: at91: clk-master: use clk_parent_data
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <4b404eaaab4062464a4142e95aaa76d5cba866f0.1752176711.git.Ryan.Wanner@microchip.com>
 <95e19f49-d0df-4d3f-bd7d-8b58b60f1f7a@tuxon.dev>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <95e19f49-d0df-4d3f-bd7d-8b58b60f1f7a@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 9/6/25 11:36, claudiu beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>
>> Use struct clk_parent_data instead of struct parent_hw as this leads
>> to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
>> conversion of existing SoC specific clock drivers from parent_names to
>> modern clk_parent_data structures.
>>
>> The md_slck name and index are added for the SAM9X75 SoC so the
>> clk-master can properly use parent_data.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> [ryan.wanner@microchip.com: Add clk-master changes to SAM9X75 and
>> SAMA7D65 SoCs. As well as add md_slck commit message.]
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>> ---
>>   drivers/clk/at91/clk-master.c | 24 ++++++++++++------------
>>   drivers/clk/at91/pmc.h        |  6 +++---
>>   drivers/clk/at91/sam9x7.c     | 19 ++++++++++---------
>>   drivers/clk/at91/sama7d65.c   | 23 ++++++++++-------------
>>   drivers/clk/at91/sama7g5.c    | 29 +++++++++++++----------------
>>   5 files changed, 48 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
>> index 7a544e429d34..cc4f3beb51e5 100644
>> --- a/drivers/clk/at91/clk-master.c
>> +++ b/drivers/clk/at91/clk-master.c
>> @@ -473,7 +473,7 @@ static struct clk_hw * __init
>>   at91_clk_register_master_internal(struct regmap *regmap,
>>               const char *name, int num_parents,
>>               const char **parent_names,
>> -             struct clk_hw **parent_hws,
>> +             struct clk_parent_data *parent_data,
>>               const struct clk_master_layout *layout,
>>               const struct clk_master_characteristics *characteristics,
>>               const struct clk_ops *ops, spinlock_t *lock, u32 flags)
>> @@ -485,7 +485,7 @@ at91_clk_register_master_internal(struct regmap *regmap,
>>       unsigned long irqflags;
>>       int ret;
>>
>> -     if (!name || !num_parents || !(parent_names || parent_hws) || !lock)
>> +     if (!name || !num_parents || !(parent_names || parent_data) || !lock)
>>               return ERR_PTR(-EINVAL);
>>
>>       master = kzalloc(sizeof(*master), GFP_KERNEL);
>> @@ -494,8 +494,8 @@ at91_clk_register_master_internal(struct regmap *regmap,
>>
>>       init.name = name;
>>       init.ops = ops;
>> -     if (parent_hws)
>> -             init.parent_hws = (const struct clk_hw **)parent_hws;
>> +     if (parent_data)
>> +             init.parent_data = (const struct clk_parent_data *)parent_data;
>>       else
>>               init.parent_names = parent_names;
>>       init.num_parents = num_parents;
>> @@ -531,13 +531,13 @@ struct clk_hw * __init
>>   at91_clk_register_master_pres(struct regmap *regmap,
>>               const char *name, int num_parents,
>>               const char **parent_names,
>> -             struct clk_hw **parent_hws,
>> +             struct clk_parent_data *parent_data,
>>               const struct clk_master_layout *layout,
>>               const struct clk_master_characteristics *characteristics,
>>               spinlock_t *lock)
>>   {
>>       return at91_clk_register_master_internal(regmap, name, num_parents,
>> -                                              parent_names, parent_hws, layout,
>> +                                              parent_names, parent_data, layout,
>>                                                characteristics,
>>                                                &master_pres_ops,
>>                                                lock, CLK_SET_RATE_GATE);
>> @@ -546,7 +546,7 @@ at91_clk_register_master_pres(struct regmap *regmap,
>>   struct clk_hw * __init
>>   at91_clk_register_master_div(struct regmap *regmap,
>>               const char *name, const char *parent_name,
>> -             struct clk_hw *parent_hw, const struct clk_master_layout *layout,
>> +             struct clk_parent_data *parent_data, const struct clk_master_layout *layout,
>>               const struct clk_master_characteristics *characteristics,
>>               spinlock_t *lock, u32 flags, u32 safe_div)
>>   {
>> @@ -560,7 +560,7 @@ at91_clk_register_master_div(struct regmap *regmap,
>>
>>       hw = at91_clk_register_master_internal(regmap, name, 1,
>>                                              parent_name ? &parent_name : NULL,
>> -                                            parent_hw ? &parent_hw : NULL, layout,
>> +                                            parent_data, layout,
>>                                              characteristics, ops,
>>                                              lock, flags);
>>
>> @@ -812,7 +812,7 @@ struct clk_hw * __init
>>   at91_clk_sama7g5_register_master(struct regmap *regmap,
>>                                const char *name, int num_parents,
>>                                const char **parent_names,
>> -                              struct clk_hw **parent_hws,
>> +                              struct clk_parent_data *parent_data,
>>                                u32 *mux_table,
>>                                spinlock_t *lock, u8 id,
>>                                bool critical, int chg_pid)
>> @@ -824,7 +824,7 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
>>       unsigned int val;
>>       int ret;
>>
>> -     if (!name || !num_parents || !(parent_names || parent_hws) || !mux_table ||
>> +     if (!name || !num_parents || !(parent_names || parent_data) || !mux_table ||
>>           !lock || id > MASTER_MAX_ID)
>>               return ERR_PTR(-EINVAL);
>>
>> @@ -834,8 +834,8 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
>>
>>       init.name = name;
>>       init.ops = &sama7g5_master_ops;
>> -     if (parent_hws)
>> -             init.parent_hws = (const struct clk_hw **)parent_hws;
>> +     if (parent_data)
>> +             init.parent_data = (const struct clk_parent_data *)parent_data;
>>       else
>>               init.parent_names = parent_names;
>>       init.num_parents = num_parents;
>> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
>> index d9a04fddb0b1..54d472276fc9 100644
>> --- a/drivers/clk/at91/pmc.h
>> +++ b/drivers/clk/at91/pmc.h
>> @@ -204,14 +204,14 @@ at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
>>   struct clk_hw * __init
>>   at91_clk_register_master_pres(struct regmap *regmap, const char *name,
>>                             int num_parents, const char **parent_names,
>> -                           struct clk_hw **parent_hws,
>> +                           struct clk_parent_data *parent_data,
>>                             const struct clk_master_layout *layout,
>>                             const struct clk_master_characteristics *characteristics,
>>                             spinlock_t *lock);
>>
>>   struct clk_hw * __init
>>   at91_clk_register_master_div(struct regmap *regmap, const char *name,
>> -                          const char *parent_names, struct clk_hw *parent_hw,
>> +                          const char *parent_names, struct clk_parent_data *parent_data,
>>                            const struct clk_master_layout *layout,
>>                            const struct clk_master_characteristics *characteristics,
>>                            spinlock_t *lock, u32 flags, u32 safe_div);
>> @@ -220,7 +220,7 @@ struct clk_hw * __init
>>   at91_clk_sama7g5_register_master(struct regmap *regmap,
>>                                const char *name, int num_parents,
>>                                const char **parent_names,
>> -                              struct clk_hw **parent_hws, u32 *mux_table,
>> +                              struct clk_parent_data *parent_data, u32 *mux_table,
>>                                spinlock_t *lock, u8 id, bool critical,
>>                                int chg_pid);
>>
>> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
>> index eaae05ba21ad..945983f72140 100644
>> --- a/drivers/clk/at91/sam9x7.c
>> +++ b/drivers/clk/at91/sam9x7.c
>> @@ -739,7 +739,8 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>>   {
>>       struct clk_range range = CLK_RANGE(0, 0);
>>       const char *main_xtal_name = "main_xtal";
>> -     u8 main_xtal_index = 2;
>> +     const char *const md_slck_name = "md_slck";
>> +     u8 md_slck_index = 1, main_xtal_index = 2;
>>       struct pmc_data *sam9x7_pmc;
>>       const char *parent_names[9];
>>       void **clk_mux_buffer = NULL;
>> @@ -747,12 +748,12 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>>       struct regmap *regmap;
>>       struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
>>       struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
>> -     struct clk_parent_data parent_data[2];
>> +     struct clk_parent_data parent_data[9];
>>       struct clk_hw *parent_hws[9];
>>       int i, j;
>>
>>       td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
>> -     md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
>> +     md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, md_slck_name));
> 
> Please use:
> 
> i = of_property_match_string(np, "clock-names", "md_slck");
> if (i < 0)
>     return;
> 
> md_slck_name = of_clk_get_parent_name(np, i);
> 
> Same sama7d65, sama7g5.

For these SoCs the clk_hw struct is still needed since it is used later
in the driver and not changed until a subsquent patch later in this
series. Would it be better to hold this change untill then?

> 
>>       main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
>>
>>       if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
>> @@ -853,18 +854,18 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
>>               }
>>       }
>>
>> -     parent_hws[0] = md_slck_hw;
>> -     parent_hws[1] = sam9x7_pmc->chws[PMC_MAIN];
>> -     parent_hws[2] = sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw;
>> -     parent_hws[3] = sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw;
>> +     parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
> 
> AT91_CLK_PD_NAME(md_slck_name);
> 
> Same sama7d65, sama7g5.
> 


