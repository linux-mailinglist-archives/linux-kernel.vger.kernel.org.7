Return-Path: <linux-kernel+bounces-760217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE63B1E806
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF81E18C820E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F4276026;
	Fri,  8 Aug 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aW9VOXyk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113B275B16
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655067; cv=none; b=fyBvb+7eJdRoSaRM817cLpfNSUoCCrAe56/4/QYqqAYdcUfs+yrSTxH9VBVKhEzFAoHR6kn17O72R4fCVhF+/PvSd+5MBCizvyY9pkd1EvCBXXpM50lvmw5kbNWGDFAqFDlYAMKlSdCykZX/3Coapp8xr97Qs3qM2GUBFPlTx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655067; c=relaxed/simple;
	bh=jrIEWBRIyno6UVI34k6pRfIfKxlL/J2GMbRuz4wtFbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na+QyUw6nKjwUURt26jIiy45WCz8cH7ZCnXsJz+ixLPR/Xidf2oxOWJpnQJpig6gXjQWJWHlsbC3lX76PACrx96mI28FY5YCuL9HzyDfN8ipBjOuMDDdlAgK+MSNjTmp+WGPD9UZeDiJgZloe6qpBlyIPcXbPMHgj/pa65nHAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aW9VOXyk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af66d49daffso361172366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754655064; x=1755259864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7H80wazDhrSZXsCUSdHhSJpvhnQo21M43h8Ky6/QQsc=;
        b=aW9VOXykFy9EaBOjw1ysCPG1AnI8CFQy/n356NjYz32dkx1PLLCAk2gApqd7i72Pg9
         VIsJzv28lD/BbBgPN7xDEKu97+Y5PfQ5FcW8KoUqn/3akJRGQe/+yFytMjm4XPQH8R2p
         TPdg8WPTLDkfCLpjg6w9860Au8oQvWtZikzTFvXQvMOMnqgMMg5TLcfOmwVHXDxPe0sL
         JKttD5Ooy4/O7oZiHiRmn7+jq5Kpp99i59tjfrYpOEZPXbaif9sXNpxSgtwqflifxqy3
         9bgeCh/dYImGSAy6sPjIFy6w86r0nWOBfigRKkRZrqT4ObZZdnqSpibsys+MMcr8jJCj
         A4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655064; x=1755259864;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H80wazDhrSZXsCUSdHhSJpvhnQo21M43h8Ky6/QQsc=;
        b=cKO1L2VO4Ox+7WBZ+iwv9OMUQqsdBsVery5DKXvjPE5Qfn8Cz2yTxZE144zEgVliMS
         +eH1szkGWjuS/WRTjfnILVo2OX2kCRZ1liTokizQQ/b7qsKfP/fJRUCCzXykg5QJQUMb
         cHsVXkFewq1lmFP8JUfCSZhgZq6ZDqlZ6sLY4QwhAFdbEfV2vr6GEGPScFETbE/M9bkZ
         xY/1F6N5NvLKUhHjpDTl6/dOclrplLVN8BA/516FDm96EPEZUgWgXP7HCgfHM9GalFKR
         vaeIl4WLkdx2kYLtxwZfNl+4yMQoWlM8TSe7auMSmlUCjQt//6WW4ZWl6KIB2Uughhso
         +x3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk6/DsDi6ngAGOjOhaytcNavChlZZLNe8iSF+EAhok1P7g0rne36C40fgs+y6zYOaH2ZXC9gM1xqJAMCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1wx9P/8XzzjKMXpoV/Uy92HYyGqVMLK75PFNXyRYZBqDMexT
	SdngA2afSrMVyXtrrZLMFn4XkScFMpPGPpj9U9YymPhuO6JSMGjI+wT1hibgOyTl2tM=
X-Gm-Gg: ASbGncspndDA+/z06/zIKequ1zj3yR+d7oBBttBBaQETumNpej1xxmNJuC3GU2RTF7Q
	yLjku+1Q5tmWK2S46Y65qJnLOSIQXETO/3NK0UirB53S4YPkNiZH9L67GerfhkembYpd5lfNvWt
	P3gjAfOhEzN2V4RknLKCzwaX7PTKVRYDh6LAWP8Tk+WY56ReIoUMBAxlZKtbs6rjQ5cfi0osyPC
	+BNPXg0jBx5oZ7xAYY+kc+KPnT1Axv4fyapU2XheTtxPTMN9/vMXnozpu4ZMV79+vO+n3Z8Mxgx
	efuNAlh1YiVA9WH+y+0zu6UVHjjUbQbEKjZNOj8FFGP9ZfY/5iPaaK+Hl2o3fRTidbRYeqXa10/
	wPZW8gj/Vl/GiVew2Wi6sNY74TyfCF5M=
X-Google-Smtp-Source: AGHT+IEP1hKdTSLFyfN0oVcI9oj4h90fVgoQ1FAVba1VNEavj2ZZMm/pymmutdkY8hgx8gRVclajEQ==
X-Received: by 2002:a17:907:7fab:b0:ad8:a935:b908 with SMTP id a640c23a62f3a-af9c64fba5amr264177766b.30.1754655063505;
        Fri, 08 Aug 2025 05:11:03 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm1485634566b.41.2025.08.08.05.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:11:03 -0700 (PDT)
Message-ID: <277ca37d-e304-4d78-bfd9-b1fa222fd0f3@tuxon.dev>
Date: Fri, 8 Aug 2025 15:11:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] soc: renesas: rz-sysc: Add syscon/regmap support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com,
 yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 John Madieu <john.madieu.xa@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
 <20250808061806.2729274-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUsFFd+orb17oQqoEidzYWMRjPoqMyzpgrdnicc=MRSYQ@mail.gmail.com>
 <cbdfa6fd-e65b-45d7-a21f-3bfdd46af332@tuxon.dev>
 <CAMuHMdXM=Mu+vJ6n3spj7Dd+8boLXEpcSn0M1KB8OwPijqq4aw@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdXM=Mu+vJ6n3spj7Dd+8boLXEpcSn0M1KB8OwPijqq4aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 08.08.2025 14:36, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, 8 Aug 2025 at 12:32, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 08.08.2025 12:29, Geert Uytterhoeven wrote:
>>> On Fri, 8 Aug 2025 at 08:18, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: John Madieu <john.madieu.xa@bp.renesas.com>
>>>>
>>>> The RZ/G3E system controller has various registers that control or report
>>>> some properties specific to individual IPs. The regmap is registered as a
>>>> syscon device to allow these IP drivers to access the registers through the
>>>> regmap API.
>>>>
>>>> As other RZ SoCs might have custom read/write callbacks or max-offsets,
>>>> register a custom regmap configuration.
>>>>
>>>> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>>>> [claudiu.beznea:
>>>>  - do not check the match->data validity in rz_sysc_probe() as it is
>>>>    always valid
>>>>  - dinamically allocate regmap_cfg]
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - adjusted the patch description by dropping "add" from
>>>>   "add register a custom regmap configuration"
>>>> - updated the list of changes from Claudiu Beznea
>>>> - dynamically allocate the regmap_config as proposed at [2]
>>>> - this patch is needed for proper function of USB (as proposed in this
>>>>   series) that being the reason it is introduced here, as well
>>>>
>>>> [2] https://lore.kernel.org/all/CAMuHMdVyf3Xtpw=LWHrnD2CVQX4xYm=FBHvY_dx9OesHDz5zNg@mail.gmail.com/
>>>
>>>> --- a/drivers/soc/renesas/rz-sysc.c
>>>> +++ b/drivers/soc/renesas/rz-sysc.c
>>> =
>>>> @@ -117,7 +125,26 @@ static int rz_sysc_probe(struct platform_device *pdev)
>>>>                 return PTR_ERR(sysc->base);
>>>>
>>>>         sysc->dev = dev;
>>>> -       return rz_sysc_soc_init(sysc, match);
>>>> +       ret = rz_sysc_soc_init(sysc, match);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       regmap_cfg = devm_kzalloc(dev, sizeof(*regmap_cfg), GFP_KERNEL);
>>>> +       if (!regmap_cfg)
>>>> +               return -ENOMEM;
>>>
>>> Is there any specific reason you decided to allocate regmap_cfg
>>> separately, instead of embedding it into struct rz_sysc?
>>
>> Sorry, I missed to mention.
>>
>> I chose to have it like this as the regmap_cfg is not used anywhere else
>> (through rz_sysc) except in probe.
> 
> OK.  Upon closer look, devm_regmap_init_mmio() does not save the
> regmap_cfg pointer for later use, so it can be allocated using kzalloc()
> instead, and freed immediately after calling devm_regmap_init_mmio().

You're right, I forgot this. I'll update it this way.

Thank you,
Claudiu

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


