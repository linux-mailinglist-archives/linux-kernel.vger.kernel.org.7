Return-Path: <linux-kernel+bounces-756240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47DB1B1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F44166E53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9E526C3B0;
	Tue,  5 Aug 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F00kzYyM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41529261581
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388350; cv=none; b=degDbFsWYgD2G7F7s4rpwPrxY9EOLn45My9n71l5Tm5DubtIOzfFtaoSWG3EHyh4pRIS+60w/Q7TCpklGlg34wihiClLCF+XBqUymt3OuS+xP+AgVkW0M8X09doTy5MGbzgQWeVYWMUTWaiBD2k13fvcNH7Z9UErkmK6SGAoduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388350; c=relaxed/simple;
	bh=6C+1KQrRGEVs5yevENfdWXMJjYaH1qtssIzaEcKbKsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHiA//37xT9eTDRGkq4IxwFPf1iSuOnMD3q4cwjOv0LM0CZqkm/sUl7TImJAqcoQtKtZFtHlp6yD//33moY7S5uUlugC2j+dFij851oYixG0mP5UzLJ5CUBkK5kzahcgCuNTCULNOEuyo9q255rgZtsteAduKJY5tJXZyrpRMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F00kzYyM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso1748775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754388346; x=1754993146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WlJi9cGntow0MX8lCUDCRyZGY71FSIx/7fRRzmtG1E=;
        b=F00kzYyMEQxFqtv/g7wiZp8ZAX+n9IM+PU13a4ryesbNAm/oz67tgIoAWgp/ew5csO
         t1a9JCOh1M42LRjpYYfz/n2q3m74KxqJGSxBaqn40Dh3xURAMvytxKoL9rnmy9FP4bZj
         JILZ4hObWOjKVyg6wYrk6YoTKZZhfwRjBdaJDmAacMripyQZV8MtYjjtyqyZqRwmxzTE
         JA6OvyPcq01D1xZO1gWeq8nClslaS/cTTgHpwfgO7jgZYyrS/Ida5cPA4ek2Em8spxP0
         Z99BQB9qBvnV4nDCNBmlbzIyxppy8ZoRGlaGxyGJaS5aGsafHUsCI44y7sjFMzm1jqbk
         xxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388346; x=1754993146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WlJi9cGntow0MX8lCUDCRyZGY71FSIx/7fRRzmtG1E=;
        b=b2mrxltbeTiVsLjIuBbAq0EKQW+0p+WA1pPWRxzgaXwi3SxvKH1TOceN+ENy9Xh96I
         BLNK0KJZOnOjBpbzI7pwMBpA/GV/JcHngq9KTEEmTLKJeyLhfDWw4rBz3FBkX7MPsS0+
         Gugwn1D7N/CxPPvnAWhM9tbk6nQgWglAfEvqs+T4g5SyzF+30qfSRP5d/D3TlcfwJShg
         2lw+yEsmUJ7Jpwt+kEx9eHWAKRhDg3cMdzXXGZIpSMOFYZl43XhESzV2hHQ0As0u9LbJ
         WK66xgjYpuIKyVPkRHgqrtjVHrBtzSqEeXyj8ab1ubqowHvarHR4ddBgFSi8Ak/3WTc5
         WhhA==
X-Forwarded-Encrypted: i=1; AJvYcCXlAHKVMx5AvO6xojbv1iBZhOGkIn+/NU2iuNQrSO4z/OE6+TQfSojT9KRxzjetVTI3sHMVG7zqid/AB+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/3V2lkwJgxoAeWW0Zv6evOkFmwdrMuLQoMr+4jYkWpEW/L8O
	5WhlUDtuIXpwuU4bqoF29X2zKZkSu7BjWHkc7Y5EoXO8GDCaIdBpEiCboPP59kHH79MLWY57ORx
	RydMX
X-Gm-Gg: ASbGncuhU0fuXZ0yY/6AmstovgFmNQu1FXFnghtNjeGdMaXQyqV45x/PuujKRG3FioU
	TtJ66dEOIN28H05vh6cJyQa0kYEDef3oARMwOU7HvYczpdv+/f96RBD4K0qVjw4RuxF8pgGv5gN
	yIrW4H1kTRotyIbU/aJ9/gGf5bC05v8yUUF3dJUXya95nz2f0risHyJx0tbdP2J45iksl71utrO
	D2p2t9DWAo9Ilaw1KHplzM6YAT+2nAZRfZkFzpqniF4RDioBZwj+SPk/wm09ykIc1lwYjIM0u+p
	7ZGdAVeelLmq6/Fv87zHnhIaLtHr9BNpIGO+tW79RTYPozQi186Uo6slrRtaVBFYl83ppz3H+8o
	7QqB5+q6ZsEXOFvi76MtJ4xKKovTL62fk0UoTHnMoolgPhiSncrd5rS/hVUlCvYGVpcD9Jtt1
X-Google-Smtp-Source: AGHT+IH+DQ96eXMvvGEe+t/KMa5/NOiWF9sy7ZABIms9qVBZ7ZnokCJwIj+c1GxCOC9C5xJiKziJOg==
X-Received: by 2002:a05:600c:6748:b0:456:1d06:f37d with SMTP id 5b1f17b1804b1-459e0d12436mr25547225e9.16.1754388346499;
        Tue, 05 Aug 2025 03:05:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458ba0a133bsm124646055e9.0.2025.08.05.03.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:05:46 -0700 (PDT)
Message-ID: <6e496737-3cec-425e-a4a1-29b576f8eade@linaro.org>
Date: Tue, 5 Aug 2025 12:05:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "john.madieu@gmail.com" <john.madieu@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 "magnus.damm" <magnus.damm@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "niklas.soderlund+renesas@ragnatech.se"
 <niklas.soderlund+renesas@ragnatech.se>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <aHgVe0YwPWapIYed@mai.linaro.org>
 <OSCPR01MB14647DE009925C982AE6BB5D2FF27A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <64622ffd-05d1-43c3-85d0-cf98f3012477@linaro.org>
 <OSCPR01MB1464771054F720542F817E84FFF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <OSCPR01MB1464771054F720542F817E84FFF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi John,


On 05/08/2025 09:49, John Madieu wrote:

[ ... ]

>>> I might not get what you are asking, but since I compute the
>>> temperature in the hard IRQ handler, I just wait for it to complete
>>> and notify the completion so I can grab the processed value to notify
>>> the thermal core.
>>>
>>> Please let me know if this does not answer your question.
>>
>> Can you describe how the sensor works ? And perhaps if you have a pointer
>> to some documentation ?
> 
> Here is the documentation [1]. The thermal device is referred to as TSU.
> 
> [1] https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware?r=25574493
> 
>>    [ ... ]

Thanks for the pointer. I got it now ;)

I'm a bit worried about the latency introduced by this mechanism when 
the system is entering in a thermal pressure episode.

The get_temp function wait for a completion up to 100ms, it is a lot. 
Especially if the userspace can be reading the temperature and blocking 
the read.

There is also the spin_lock taken introducing another lock while the 
get_temp function is holding a mutex on the thermal zone.

Did you it that under stress ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

