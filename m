Return-Path: <linux-kernel+bounces-760107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50894B1E683
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE7586C63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6DF2749FA;
	Fri,  8 Aug 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gcBjHvan"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25C2749F4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649129; cv=none; b=aFB+C6IkY8wIV5YtoVDff62Px7LADcPjJuei32+INsNLf9/VjktCdIF8rqfxnajiLJ87YOdDIYIhjB3iOg5KzGbfccqxAJwG/ciVEB82pTXp6f90jJsJ1CAOvxvdBjpP9874ZyrDlLh+DYmjX8fD0SLi/aoAH1rV/1SlgiY2yQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649129; c=relaxed/simple;
	bh=iY75W6j7pIHjhmtkbP1Hku/h+iHCAu+MbBXJB1XzJpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWEVAPJIFJPhWLXc9aTWRvilqZMo6HtQAlFkzpvQlJFvxKogbCCbXii9o/OPvu2aVuD2ZNNcuG9/y3seVGDwmhKKl910TQRZwPTiazNTNZcbY/KbHcX/nvqY7itb61VofxLfkqNe7w+6iCO//10w2lmDbmjfihdWUkR96TMiOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gcBjHvan; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso3123777a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754649125; x=1755253925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6TSWrBncc/Rhuijv2C5MP7HYYUBAQpR0KYcqpwTlxE=;
        b=gcBjHvan0TL0WQ71RJK73V8Q8fgsp0HctchC6H7lZ5bd7VdlYn81ma8yJLJC5n4yAs
         CSzfjbU3TQcUn+CCBm4sIkpo0XD1GknuAPd1TwRRyxVNmR0eMGNmBWirm6c/Q7p2WCOp
         0wXfhK+E0YGdgZCJTeheCbWA59rHrhlZrPSS6btvSNejE/UTY1r7TE0Adp9qsWC6b9Df
         kObNXWVfC+/iqUSohzbmM4FfyAevE/umFiEMsR0f7gRodjJwARW4ODhw8uzVZva9Ve4D
         CERAk1oUPR+H427r0hj3BYBM4s+Wwr9UolDPJOL5o8aHNpG5J4dmgIx0ElggQemlzyHy
         FaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754649125; x=1755253925;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6TSWrBncc/Rhuijv2C5MP7HYYUBAQpR0KYcqpwTlxE=;
        b=k0w4sTaVERA6RUdwHKkQbOm3uySW6bViRtzr8hIqLr3UaLcqhZSkjiDYv1EXjHitlW
         IN/ME98ial029oXqTTVMNSm6KuQfwS+620GT8iQO0FkvZ/xDFgdZN6MGlXWd5O8UkpBb
         B8UhtI7mCVM3u1BunRzHPod+lSNwwdcA7F2Z5Hr9kektG8S/IT/ofG1UlZp2OTsmALO7
         X5cmm4cXxB+aeU9IKVAz6LGjiQgL0a1OgDAIOrkLQeM930X7fVfNS93LuzQEs1wXa4Et
         DusTB8VI/C6RTjm10+idh0v2fNtvuscwhDdLIN7fHMC2H+ZjxNmblI4r+LuQhN1BdhyG
         Ok8w==
X-Forwarded-Encrypted: i=1; AJvYcCUcTaUc2DNOi7t3aqD4NzsfVHvLC1gImPf1u1Pw9X0lDZhP5mk06fCVGK+ODv1z1q3yLoNTuvFA81Zm1V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBOMAEFTEnNFqoxItL0F+TTnuptYXdEyokWiE6FpAwKwR/EJi
	VxJl0Rlzk0jjlVb/ZyxaUJUYC+mTX71h+n6rTidyK4+X36J9DL1GL613ZLVCbUEc5E8=
X-Gm-Gg: ASbGncs9S9FVkBSRXAi94civZ4BFHAWNJ3IMHqUcCOFC9/W8W0c5d2QLW3oUOX1lyqR
	4U+FzRL08d5NQ5o3ijLslRRHo0TnpxUpxWQT4H67L1XUBakl448eIpuv1TJPSd1NQMSDb8Co0cp
	8F5ErK+m5Ez0V3W0HLY/UzFhHVn7nuySZOnCDxUMc/mohSJOtqDLjJCiZHAc4jwYyviwr3LFbRN
	MuOYNOgiWQuDDcOyVDpTcX2Go8nCTuwtl3XhJS8k6GsMGl/uW+t6kieJ121AcHKUXyoSX/VJspP
	ukXLitJcm3C4nlXcVsbw99VyXKNmv6/QT7G6/RaZgZqsL894xepugu9UGCr/5DYH7FvBDUZ+LSU
	5vaOUMXRbDmqjnjf7Z6KSRyG4V+dF/a8=
X-Google-Smtp-Source: AGHT+IFiaq/Bs2HBuHCkLqYo5m9SoJu+9pxruSdi2P+MSc/rxt4OTN3JPa39G9gTH7FXPIDev3nAkA==
X-Received: by 2002:a05:6402:5216:b0:612:a86b:ac79 with SMTP id 4fb4d7f45d1cf-617e2b77876mr1905662a12.2.1754649125126;
        Fri, 08 Aug 2025 03:32:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff596sm13341214a12.5.2025.08.08.03.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 03:32:04 -0700 (PDT)
Message-ID: <cbdfa6fd-e65b-45d7-a21f-3bfdd46af332@tuxon.dev>
Date: Fri, 8 Aug 2025 13:32:03 +0300
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
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdUsFFd+orb17oQqoEidzYWMRjPoqMyzpgrdnicc=MRSYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 08.08.2025 12:29, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, 8 Aug 2025 at 08:18, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: John Madieu <john.madieu.xa@bp.renesas.com>
>>
>> The RZ/G3E system controller has various registers that control or report
>> some properties specific to individual IPs. The regmap is registered as a
>> syscon device to allow these IP drivers to access the registers through the
>> regmap API.
>>
>> As other RZ SoCs might have custom read/write callbacks or max-offsets,
>> register a custom regmap configuration.
>>
>> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>> [claudiu.beznea:
>>  - do not check the match->data validity in rz_sysc_probe() as it is
>>    always valid
>>  - dinamically allocate regmap_cfg]
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - adjusted the patch description by dropping "add" from
>>   "add register a custom regmap configuration"
>> - updated the list of changes from Claudiu Beznea
>> - dynamically allocate the regmap_config as proposed at [2]
>> - this patch is needed for proper function of USB (as proposed in this
>>   series) that being the reason it is introduced here, as well
>>
>> [2] https://lore.kernel.org/all/CAMuHMdVyf3Xtpw=LWHrnD2CVQX4xYm=FBHvY_dx9OesHDz5zNg@mail.gmail.com/
> 
> Thanks for the update!
> 
>> --- a/drivers/soc/renesas/rz-sysc.c
>> +++ b/drivers/soc/renesas/rz-sysc.c
> =
>> @@ -117,7 +125,26 @@ static int rz_sysc_probe(struct platform_device *pdev)
>>                 return PTR_ERR(sysc->base);
>>
>>         sysc->dev = dev;
>> -       return rz_sysc_soc_init(sysc, match);
>> +       ret = rz_sysc_soc_init(sysc, match);
>> +       if (ret)
>> +               return ret;
>> +
>> +       regmap_cfg = devm_kzalloc(dev, sizeof(*regmap_cfg), GFP_KERNEL);
>> +       if (!regmap_cfg)
>> +               return -ENOMEM;
> 
> Is there any specific reason you decided to allocate regmap_cfg
> separately, instead of embedding it into struct rz_sysc?

Sorry, I missed to mention.

I chose to have it like this as the regmap_cfg is not used anywhere else
(through rz_sysc) except in probe.

Thank you for your review,
Claudiu

> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


