Return-Path: <linux-kernel+bounces-822441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF78B83E58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AFD7BCB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7822C21D8;
	Thu, 18 Sep 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ybv3BI+6"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187F22A4E5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188866; cv=none; b=NF46ijDnJMjFGuilELbqs83iVj4sugaoU+s9L9UFr9KAs3w+KnBNmjVxlDpmEdmC60IXQnNcpbKbldJGoTg8hF+RyXku8SO1LI0bWmEsSnRTaoehi0DFP/KhFz7WaMvEUmhvpCzNVIzrU4Ww0tl1tuJWl0mFxmr4ToJFDvvP/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188866; c=relaxed/simple;
	bh=ebIejkG9lO3H+4v19Kd3NsOO4t6uOqMYtPLh1XK6HPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNHX4w5kbVH2lD8MT21h3RUyxvUYByslpVU1M1V4NNc6pkFVD7QWwVDBYCZOwowtmZ9M6LRB2/k4GMojO5iwgdV+uHM0XuFyQ4vUPHg0aFwKD5YbJuv60MGUL01m/YWQ+DdQ+Q5sOHQN0/LrCUK6103PsG+kbhewoTn0mkGnSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ybv3BI+6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so1441488a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758188862; x=1758793662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY2fN2zgk9K5ePhnAH7PE+WNn7DSzrHO8ylDHhqkcZ4=;
        b=Ybv3BI+6pNabav/XvdmX6XIsppQ0M/5IxuGMMtXGZgPUwY0Lnd/MprI2Pk+tOS7kbu
         w2fp5utdwqax5a1S9sBlkkn7oAbBk1ju3xCZ0EHQv/lYLwEjgbeUIgxZIxTOhXj9nefr
         qPiv2mCwuGuJI9ezJUK6Xo9K1uZ9Ae08ij4XxyXDeSwiFt/BW9DxV3KC2zA3DKvDrGI6
         N6nUXPpEtXLqIsyy3Q7F6qLx0OuqWg8OE6X6flkiKAoV4oFhP5E9C0Tvw9SvRzp8cluG
         yxv9j7zqAIQmCBkecM0MwzPVezr/UPQoij/GCYGfDzWnDgeb+mBWcoO4AzzC1oMpIkT4
         cJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188862; x=1758793662;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY2fN2zgk9K5ePhnAH7PE+WNn7DSzrHO8ylDHhqkcZ4=;
        b=Xo1z4daXPDo7fPhwgmWFmjnbjtp65eUU5Q+ss7FMgcHHm2+g8xgR9srr+fdAZoxl90
         XlR3qq02wVR/gtNI/ow+SzAlxImii8rU5BsPs2d1FDjAz5xlV/77Q5AJf0qZj+XOMPax
         RiKk1wi159Upb9OpZqDpkMPfrdtAFsWUeksRfBf603aPT6KlpDHj0005SDvtRHDsMMIK
         lolwJSdVP7IbZKGaG42I5rGnXcemtW70YPHIrwC6XeYR30b9w9JjJ4D1H0Cdm3/4mliT
         NuBWuWNesseoYyNQHlU3Xk89iMDm4Ebxx4MbGxPCatrMWBfPqCHVGHg45UqYCrqRqnwI
         YlaA==
X-Forwarded-Encrypted: i=1; AJvYcCWPu3YC+L90noBxMAb6EPSLu76WRq4JsUrk56G9oyZho/EUZVt6B5YFXCzroHxESjHbbtWsO5+Vt8Vjyw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunYgzSm13PRwurMQZJCMiNX0ybj8TG6NTduJ2PXRabKVKodBn
	lgic8jvkzx5G0VP8LBrpdbOgfZyG9k+6Th8rePGwYHaEflBFZmyTYbT2OdM8qXRlMfY=
X-Gm-Gg: ASbGncvCxj467IJFX4uNfLZ71lLTIFF1QocKfQIibDeV5OGy3ZKLc9muw2bERKNHK6p
	f8MrEgVBhlHXhra9GFLyADNJtw690tjMnkn/P0B+kuNKLdXVlty49c+x+OiSy3zwRHq2rau7EYj
	OIstzCBS4+Mvr0veufRRpQLrR5HW3uKpwWeUkWRSVsBGRd9q/iHFtLPOuqkl4+qp/2au/FdG0Wx
	ALT0ZRBspgvNKyYx7Agzm0o36d6VsXYBMJZUqsQBVF4xUJ6J78fROKW8jDrFDZZqLJkVl+qj8bT
	5hZHZl6j9X0F/bR2mdXWtak4Jt6nlF1GJ86D8Ju3R9LuU3tBBwGMfpYBuoZ6982i5gZzMqn8d/J
	W5jrAnDf+h+iHidP3OsvcItuZ0OLZd88LuLmpt6B9ejxZ8LUvASfMaQjbqKzJ
X-Google-Smtp-Source: AGHT+IGm1gMecKNS7ulsOyutPp7cC/3sMrnG/x/HjeoFQdZsaPx3dh9Tz2I2uksJ4hOSdxJlyIcHBg==
X-Received: by 2002:a17:906:730d:b0:b07:88ae:4b80 with SMTP id a640c23a62f3a-b1bbb7615cdmr515429166b.65.1758188862248;
        Thu, 18 Sep 2025 02:47:42 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd15cb2fesm161684766b.89.2025.09.18.02.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:47:41 -0700 (PDT)
Message-ID: <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
Date: Thu, 18 Sep 2025 12:47:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/18/25 12:09, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The first 128MB of memory is reserved on this board for secure area.
>> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
>> memory node (memory@48000000) excludes the secure area.
>> Update the PCIe dma-ranges property to reflect this.
>>
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> @@ -214,6 +214,16 @@ &sdhi2 {
>>  };
>>  #endif
>>
>> +&pcie {
>> +       /* First 128MB is reserved for secure area. */
> 
> Do you really have to take that into account here?  I believe that
> 128 MiB region will never be used anyway, as it is excluded from the
> memory map (see memory@48000000).
> 
>> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> 
> Hence shouldn't you add
> 
>     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> 
> to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> instead, like is done for all other Renesas SoCs that have PCIe?

I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
the available memory for board, as the available memory is something board
dependent.

If you consider it is better to have it in the SoC file, please let me know.

> 
>> +};
>> +
>> +&pcie_port0 {
>> +       clocks = <&versa3 5>;
>> +       clock-names = "ref";
>> +};
> 
> This is not related.

Ah, right! Could you please let me know if you prefer to have another patch
or to update the patch description?

Thank you,
Claudiu

> 
>> +
>>  &pinctrl {
>>  #if SW_CONFIG3 == SW_ON
>>         eth0-phy-irq-hog {
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


