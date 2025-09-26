Return-Path: <linux-kernel+bounces-833605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE19BA2650
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4803A8B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122512727E5;
	Fri, 26 Sep 2025 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OtR7IdRL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4C2727ED
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758861518; cv=none; b=OMC174aVhjEEgaH0pxynXX2F5c10PA3MzOkjQv6uAt815PHt0vn9WDSs58nup9a2Ua/8mqVYHrnNpV6yvqCRSPfMfYhZqnyaD8AcgemwnsFK4+LEHKj19a4EW0Nm4I1T/y8Xi8TZG3F7xntB2GK/hLO/cnIM8MMwdA9W7vk04KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758861518; c=relaxed/simple;
	bh=UfvJ8TmcLK+tkDG9n3Q3mgrjRikRjnzrORArw7XmKbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzXjJLnjt7VYMSXP+5wAusFLWNTkYZ9Lx+mX8Wr2G62Qj8w1mDXr4nb4AEUChKBjsh7vSHLiuwqp+6MWIoaWmixZhIs12Tn8tq6SdqzAnx2kc2L7LpamJR+6H8CSUOMDqjSu6YjTJht85om5AFs89ahGwb48Da7u91mLPM+bwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OtR7IdRL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso9606295e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758861514; x=1759466314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxatTHwC9Xn3qhX5h8Sim3fj0VZDoqVJbZZgfl8nJks=;
        b=OtR7IdRLU3Fhx3OKvfVp5qph1lJyadrWkdMUqSeGUwDHBJY4hmzVSDHY+bMyD0Wysk
         L79wEAXVtXHb0yVa7nl5wtVF6/Ron3+3QI9ZaT9/q8IbkvZVefOGULjqb0L0Dtfmqczq
         buaGujz+Q2SusoNtbWMDQc7LKr+N4foQoEwTLRxrQiQGszOLS96F5j4wxhwLcbRd5CPh
         MtelwXVehgK1EKy1NJN/Cl+EmT9BO91yKxxn7LjhZhZIKnNvUSAX7banHkvLpS1uJT8+
         O1SPT5m9n3mLe8PoVKd7m2/TgxFd+cSrM/AGwJ1P/stwuM83pk6XC85FoYz3vYVlfXJM
         b4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758861514; x=1759466314;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxatTHwC9Xn3qhX5h8Sim3fj0VZDoqVJbZZgfl8nJks=;
        b=elTMVhyUNn6BKxwzUsCdSUw6BDGg2rD0vHlJkF13fCC9RzNaHVE2gKD3hew/pqVffC
         GbbumdEMEsbHYuK1veIpDaCQDkTIbf4QRzvNKUiVHVSaUDn4IB64L8sRv+i374I7vaj6
         cnTkqLGKB4Iy6iGkjtwWR7U+7szlyVnMWzMlHNS8bJiCEP0XSb/I1CiARfkb7A+RR9q0
         obfLv1XrTBLeb6Mitqi1ySmY1GZRDMvaZfE/oHbDMQEbfKz5EZpBmROr2tpPGubFHvR9
         K37AunCoKIQVnhsgLlLxg4uxMbZBHODELisHQb/0L5JYdvhtenK39v8Y9bKGiPjQejb5
         PuUg==
X-Forwarded-Encrypted: i=1; AJvYcCXG8goZzpnm3KinULkIoBi6JN6x5HHEAre367wrcLYScLrTgGZFS8LheGuxvg7/3/+v9SQy8hf2hAKeNYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+adFUl4BW68kAmon2nHWXh8BMfXBZZRlQ8sGzV4KvHHfoe/M
	2usr/4nTgNxcQfY5GiAdUoyHZ7czBLKZpeFXNgcPu0pT+7sGz4FMnIJOogyibBoMySo=
X-Gm-Gg: ASbGncsO/FgmyMYNpTH1WXqBcQ+jHiaBiEOhPWDQNeZRBIn8ke+qjADUafWmVoe7Gkq
	SjCCiPtRqjHgUQGuWqhA3Us2WfxC38khsr9wDKZM3TMuu6Brl1K8qAiBeClQA0khZey6guR+zym
	EZn32uCXvbrwUa2LKotfE8D9JWf4GLrc+VnnblXk0KWBAuBqXokaIG94bJjhBusi9xpVOhZhV6Q
	XaE4ouBdleSSgdSEJZ3eGzC1qivfS/EZubju3Vep9jjOuLdFgUY7m/xuu97r5cauxOvsxUPmQHS
	I1gLaND34uvkFnKOS0l2/B7uQ5TA8R6dHtQc3N10Uz6Sve3py40AXhVGq6bV0jQyY1U50rPiaX5
	Xru+BaHEOfeY6nuBO8ceV6DtvskcPcMJdpE1kZC3VdcvJdeC+qmrC
X-Google-Smtp-Source: AGHT+IGfGIfO3JlKG8iJXMVeyNZqqykoAqKYTugo5hGNqwBHSYw8pfzE+K1JLXIW/Oo09R3thVkcGQ==
X-Received: by 2002:a05:600c:22d3:b0:45d:2ac9:4240 with SMTP id 5b1f17b1804b1-46e329eaeffmr49454125e9.17.1758861513684;
        Thu, 25 Sep 2025 21:38:33 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31ea3sm99583345e9.12.2025.09.25.21.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 21:38:33 -0700 (PDT)
Message-ID: <4cf2c655-053f-4ab7-a807-a63a1150e7bc@tuxon.dev>
Date: Fri, 26 Sep 2025 07:38:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: renesas: rz-sysc: Populate
 readable_reg/writeable_reg in regmap config
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV62NUeEYyYgf4LJ2JQLwA-fAzYyA-cy9h_nyYKmtB=1g@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdV62NUeEYyYgf4LJ2JQLwA-fAzYyA-cy9h_nyYKmtB=1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/25/25 17:05, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, 22 Sept 2025 at 09:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Not all system controller registers are accessible from Linux. Accessing
>> such registers generates synchronous external abort. Populate the
>> readable_reg and writeable_reg members of the regmap config to inform the
>> regmap core which registers can be accessed. The list will need to be
>> updated whenever new system controller functionality is exported through
>> regmap.
>>
>> Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/soc/renesas/r9a08g045-sysc.c
>> +++ b/drivers/soc/renesas/r9a08g045-sysc.c
>> @@ -6,10 +6,14 @@
>>   */
>>
>>  #include <linux/bits.h>
>> +#include <linux/device.h>
>>  #include <linux/init.h>
>>
>>  #include "rz-sysc.h"
>>
>> +#define SYS_USB_PWRRDY         0xd70
>> +#define SYS_PCIE_RST_RSM_B     0xd74
>> +
>>  static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initconst = {
>>         .family = "RZ/G3S",
>>         .id = 0x85e0447,
>> @@ -18,7 +22,20 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
>>         .specific_id_mask = GENMASK(27, 0),
>>  };
>>
>> +static bool rzg3s_regmap_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +       switch (reg) {
>> +       case SYS_USB_PWRRDY:
>> +       case SYS_PCIE_RST_RSM_B:
> 
> Given upstream has already support for RZ/G3S Ethernet, it may be wise
> to add the GEther0/1 Config Registers at 0x380/0x390, too.  That way
> you avoid a possible future hard dependency and regression when adding
> support for configuring that register from the Ethernet driver.
> The same is true for RZ/G3E, RZ/V2H, and RZ/V2N.

Ok, I'll update.

> 
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>>  const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
>>         .soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
>> +       .readable_reg = rzg3s_regmap_readable_reg,
>> +       .writeable_reg = rzg3s_regmap_readable_reg,
>>         .max_register = 0xe20,
>>  };
> 
>> --- a/drivers/soc/renesas/r9a09g056-sys.c
>> +++ b/drivers/soc/renesas/r9a09g056-sys.c
>> @@ -70,6 +70,13 @@ static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data __initco
>>         .print_id = rzv2n_sys_print_id,
>>  };
>>
>> +static bool rzv2n_regmap_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +       return false;
> 
> I would already add the TRU trimming registers, also for RZ/V2H, as
> they can probably just reuse the RZ/G3E TSU driver.

Wasn't aware of it. I'll check it.

> 
>> +}
>> +
>>  const struct rz_sysc_init_data rzv2n_sys_init_data = {
>>         .soc_id_init_data = &rzv2n_sys_soc_id_init_data,
>> +       .readable_reg = rzv2n_regmap_readable_reg,
>> +       .writeable_reg = rzv2n_regmap_readable_reg,
> 
> Oops, this one does not have ".max_register = 0x170c" yet.
> Does this cause any ill effects that warrant an urgent fix?

Yes, similar crash. I wrongly checked it initially. I'll update it.

Thank you for your review,
Claudiu

> 
>>  };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


