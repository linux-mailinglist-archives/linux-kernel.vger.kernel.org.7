Return-Path: <linux-kernel+bounces-774905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C8B2B909
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43879196167E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B024BBFD;
	Tue, 19 Aug 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g3Aeuh64"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DE212B28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583290; cv=none; b=LXFWL/xfDKTTZQ9Ri0kRW8xtqOI9U49AVhs7SfZ+XHToBwwPIglGmLYNmyMPhAwa/KMsIV01GuisbqBWHEJ8CNiTB8wyhtPxso1IeuyyBjviaRcUs5Bsdd+JOSxRM0zyvG4usRbP5/3QOPxK+vXPVTSmgVdXBXFZgDH4QwMZmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583290; c=relaxed/simple;
	bh=d90UlPnb7NvxVKC9yf2/H9lQTofd1mj/OUUr+YCoIPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPGPYEHyfAzAyIQEbHkZflPamMshCBNmbQruTCuzfKa9bCcfTsrVx+jgbYEPQ8vjHkgzUOa1nNCOLR0QDFSg0RQiHrVUU4So+YchBTuX2TpSSYUFNB3G+Vc3H08TZv2uZPCPXzhvdTK3tj3OzMOUv7/TCNFeH1T6WVDh5EA5kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=g3Aeuh64; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b004954so35763465e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755583287; x=1756188087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCrxZo4+iFbzWuafqcWchsTA3vFDSS7vqG8us0w6qHw=;
        b=g3Aeuh64z51UVaLG/7lD81owbYC8+gqgmhJa4e4mJy087vjjf3o6MHkwO+vVv8pjVW
         jfOsUaxgQIkDw5jHmGu7/fKPuqxoQEl+vq1qFpLP/KFiod5Yz9MTjfp2kMv/Tbbi4bC8
         1/VZggdudZigJp6NJc/3TkaCsuoIoheD0dnTz89pRCkEBMN1g+ppIGASlW3V1XeuZ9ki
         iol4XojmwaNu2BRYVEZIf76SyoAJ48/tH8MP/C9X3VNLm76vZGdl7ATssaX+MVGYYj2I
         RlwJkaPMAR8JdP3+klDqwyvrGPTMMYQiiQyLaj2ie6Dabo2BG+udYt0kO0Idjh6jPoOZ
         Gz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583287; x=1756188087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCrxZo4+iFbzWuafqcWchsTA3vFDSS7vqG8us0w6qHw=;
        b=LgDHl+uk/vyiqJVQFk4XaXLT8Q6RLolkyDaFRuEY/gY2d2C5pxmVRDH/ZemMHDIyAE
         K3JLgEbbS9pm0oJvPC2a0ec/mIjRMGA/CX5dHQ5aGZ8YqpKSvFotIDlY3AkiJwP5UUwF
         S2r3joUVuqeyv6xnWnRQbpPOxG5TbgL4F7sSxSgeFwSsYYIIKPBGQjT5VNFWyVJDFrVk
         fcg+xdyLo0rk9Yj4fxRmuZ3uFSgBwzM6HC92gp1phWQBJO5JV3j9+WT3xbHI52XKazAQ
         7981wKegtWkJ4Fmol6rxhfKe5aGRTEtkb220c+L3B0C2BRZxifc/ydIzVEx1SRog3gG0
         TfLg==
X-Forwarded-Encrypted: i=1; AJvYcCWMVMmI6bDKBrYuTiSVeUVsJ5jc9kKqr3ow/vBHD7O2lHJSUN+Gn6JF/axPl0nQXHKLf2Yzpq5DofECUGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9rlGoHjaQNW8O7IrRKvM5gTXjWaZSQwkfkcjSpdC+rIvJspg
	iGCWAQdVpj6FtQ8zLx72TdpsRoAeFvLyo1Tj2CBNOtx1HHubRl7blLnMj0z8GFXObKk=
X-Gm-Gg: ASbGnctLkXvpBhQjEFxeqU+5zdKHh8XhuWbiC8IXUz5e/eiuJB/j8RybzRnEvaKhnEm
	j8OUVERCSdNyzg1U+hBr7HfOR8WtC0rV1TZGgxvdPrQbY4mLRYBSfV0p1nRECUZ/63amq9kPaZV
	QGWDWiMLkD6ZXIOw2BCcTZyTNSJXYr3GNl9/Ywq8AjHIvV3wsQpaiClhZqi+kD/nCdZ3OOT3fq+
	fnMU45HmVEgYGyEAA9ZxluGyWxCXQsHUSZtYzyGPieMoUYCv78QYvsPlQkdRWAojV9QHdzhSpuy
	tHOiZ/aLusiPSGrmp9ArT8sD2LaS83y5PJ0RAaU4jQkfRiq5E8wr/sJinqPs6tsRkYBk45YX6wd
	sdeNnosCdnO6W2bm0yw3xUKxX4DRvQPjJ9NqtZ2c3QumSm3D4OCntozNmK9jI/YoERj975SW2O4
	hwYw==
X-Google-Smtp-Source: AGHT+IEBenKmHbomfqM7jRrj+OcZnm9VNNe9GX3JYk6fkmpM0P8zqRVhhyCR0kaRAw4wTbU/JEdLvw==
X-Received: by 2002:a05:600c:4750:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-45b43e02bc0mr6688745e9.29.1755583287073;
        Mon, 18 Aug 2025 23:01:27 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:620a:8b00:4343:2ee6:dba1:7917? ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c5767fsm2102502f8f.62.2025.08.18.23.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 23:01:26 -0700 (PDT)
Message-ID: <bc053bca-8dd9-4a50-a352-290b38a329b0@tuxon.dev>
Date: Tue, 19 Aug 2025 09:01:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] phy: renesas: rcar-gen3-usb2: Fix an error
 handling path in rcar_gen3_phy_usb2_probe()
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
 <20250819054212.486426-3-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB1134647BC6436CA61E0A200F98630A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB1134647BC6436CA61E0A200F98630A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 8/19/25 08:49, Biju Das wrote:
> Hi Claudiu, Christophe,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: 19 August 2025 06:42
>> Subject: [PATCH v5 2/7] phy: renesas: rcar-gen3-usb2: Fix an error handling path in
>> rcar_gen3_phy_usb2_probe()
>>
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> If an error occurs after the reset_control_deassert(),
>> reset_control_assert() must be called, as already done in the remove function.
>>
>> Use devm_add_action_or_reset() to add the missing call and simplify the
>> .remove() function accordingly.
>>
>> Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to initialize the bus")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> [claudiu.beznea: removed "struct reset_control *rstc = data;" from  rcar_gen3_reset_assert()]
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v5:
>> - none
>>
>> Changes in v4:
>> - none
>>
>> Changes in v3:
>> - collected tags
>>
>> Changes in v2:
>> - none; this patch is new; re-spinned the Christophe's work at
>>
>> https://lore.kernel.org/all/TYCPR01MB113329930BA5E2149C9BE2A1986672@TYCPR01MB11332.jpnprd01.prod.outloo
>> k.com/
>>
>>
>>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> index 47beb94cd424..d61c171d454f 100644
>> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> @@ -699,6 +699,11 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
>>   	return candidate;
>>   }
>>
>> +static void rcar_gen3_reset_assert(void *data) {
>> +	reset_control_assert(data);
>> +}
>> +
>>   static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)  {
>>   	struct device *dev = channel->dev;
>> @@ -717,6 +722,11 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
>>   	if (ret)
>>   		goto rpm_put;
>>
>> +	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert,
>> +				       channel->rstc);
> 
> Now 'rstc' can be removed from struct rcar_gen3_chan and use the local rstc pointer
> as context variable here.

I can drop it now but it will be added later (after this series) along with 
suspend to RAM support. That is the reason I preferred to still keep it.

Thank you,
Claudiu

> 
> Cheers,
> Biju
> 
>> +	if (ret)
>> +		goto rpm_put;
>> +
>>   	val = readl(channel->base + USB2_AHB_BUS_CTR);
>>   	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
>>   	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
>> @@ -860,7 +870,6 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
>>   	if (channel->is_otg_channel)
>>   		device_remove_file(&pdev->dev, &dev_attr_role);
>>
>> -	reset_control_assert(channel->rstc);
>>   	pm_runtime_disable(&pdev->dev);
>>   };
>>
>> --
>> 2.43.0
> 


