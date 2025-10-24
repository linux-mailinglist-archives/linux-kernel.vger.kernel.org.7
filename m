Return-Path: <linux-kernel+bounces-868544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D9C056E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F0EF4F6AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99A30C638;
	Fri, 24 Oct 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j9R8JSXv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71891B3930
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299496; cv=none; b=smbBfZBDTyFQeO1CJl3L9bRMx6D6LWa8/TxQ+zbu8mcsnNnT286v/n1V/9iyQ3bY+i8GhsBbP71AuaiD22CjXMj9CtkKBeuWcbDAo7WZId5FoGvBu+0IYhpQH2bkQy6TJ8JrC8Kq3v7WGRiqEoUV1+z3LM4l/5Do7+9eN0v9EEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299496; c=relaxed/simple;
	bh=6wJ5ozxccB/nzgcmHOXuI1xKrq/4DHvB+RURaKbk3O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sq4+x3wQK5XvQPYQvipZgAqLgYqdzHReDpsaRi5oKVcKLOXex0q4yKDhHiVHaV7VpZguQMzZmnnvHrwkJxl3JIht9jZ8pfL3lp4NDCg5MwJKiWXZyRu+C2MHZBNo8Dy70VcN6S7OEDfkn1SQuxYaJEy12bt47TfkB7nFhatsW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j9R8JSXv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so3567112a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761299492; x=1761904292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ly3AYuLKibQEdYHOL/Htjgp8xjTYNizR6VDMFs2t4hc=;
        b=j9R8JSXv/26z9gYmd0CPlvrWskwALR+V95RQCyh6JqZVXmU/RtT/i0YJW9Hh/Cp6Ta
         GtkkU0IpJeVMAU/y5Kt3DkWRzpbLSbay5DdQk6AY+WkZNsJF9MmQ8mmTpcM8gyVaq9CR
         k95negSWJa2v8h+AQ+nwmty8os8QDp03T60c6gbtF8SzhAbtTY7AtfyKQ7Gx69t6muoz
         crz+73cdzmq9wwy9Gjr+KjcxxgId6f5201wvzOOliok4c+qqGLzeRwGDCdMPu1x4j4DI
         0RaOzV2Xd8Dgq4KEFdoZJnZag9GxZnRcDVwvQigtYVXY0H/8UXn+Jr55EMAQ3ZPpX9Kr
         0ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299492; x=1761904292;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly3AYuLKibQEdYHOL/Htjgp8xjTYNizR6VDMFs2t4hc=;
        b=X8GBXz/jFgVSD/jMQOpTVux5plUeTwkZgqatso17tGnCAptBxYojawwDl1qnIw2njY
         jcPvh3l11ndNlqrN1r0/us1tRyCA1XicgINnLS6YB+ePB4j6LSI6J/elSxCIrVyDEbni
         elvq59Ihfkx9H5TDhLITp5JdTHcEjr2vlV4h5Qhd1UNzlq+pw41HDIiIM+MFQ6TJkl4H
         ivSCvZg/UnTJJ7Za+DlSLCKez5en4Cb6r8nUYGC7DTwBOIuEBUCeonkyeiwlvd0aqwx4
         nTeFKta2d55/33Xx8ZwtlvvUSm7TWScdx3Kzx+sSa2pdIfgnVth2dKHGgMGVkSkiv6J8
         3urg==
X-Forwarded-Encrypted: i=1; AJvYcCXBCPLmPMHZ5pqXecXl851ivuyCIWCGrWGAUwJg82Uo9zh+UJ8osGtgJA4BQIFH4ofJ0YNS63TJ9TYfP3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBWh1zZRFpN4kJo4q3dKYrSmkZ00z5R7pWhbzq7yacg4fAxiW
	7W1z4G+wvKUMoN4NAH/btcmufeofjBtdYmJuqxOvFVY+NHscip/UCHxt2axhsCI8xts=
X-Gm-Gg: ASbGncv+52/HHa0APBtyRCpFfxpGvwN96V7IddKmsrvP8AbRMTa6ule8WPf46oa6yof
	AZq5AS/ull6ZulQks0+X8dSQKE0Ag/quKSYmDEhK25wiMtm+D/NLmIjepIlA1hvl1YO3g+skVk9
	GqC/Brd7rFfaaPz+x6IIZWGfsYyhHt81Bz69QPnCECmf7+l4go/f3Ra7J+uK2m/Y9fQIMZ+P5pi
	+1i0g9Ss2e7ShcJ7q1pekQBqiH3X4NYQXRm4y5lZ+In+vXP8onooZMxwiXz/wZvnqxsSQOSm9nR
	LSokbLXmNfaSnXG12GZ8YDrz91u/xUR1W57EUNL09RTz+LpYAkws86wmli3aYW5gYttATxFKFay
	ZktJ6MY4qVCYuPtBl9BX51cTvIhTK+Vl+uqwT/T7fP/6Av+dws4QKUyU176P22yJ7n1OsvJgJZl
	Kkaxtgdn5D
X-Google-Smtp-Source: AGHT+IGmo8RIThQOxDu/Zi1gWcAuc6tFi+Y4rpL7zem9sqyDB03ggroT6vzhcOREXWW2G8nw+BwgWw==
X-Received: by 2002:a05:6402:51cb:b0:63c:66b5:bbbf with SMTP id 4fb4d7f45d1cf-63c66b5c00dmr20265189a12.20.1761299491899;
        Fri, 24 Oct 2025 02:51:31 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebcd2fasm3947160a12.14.2025.10.24.02.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 02:51:30 -0700 (PDT)
Message-ID: <e3403b2a-533f-4962-a615-32a4095fd6dc@tuxon.dev>
Date: Fri, 24 Oct 2025 12:51:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] arm64: dts: renesas: rzg3s-smarc: Enable USB
 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com,
 yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
 <20251023135810.1688415-8-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV7ScKUw7bGFW4v0wS9caXKDeT02MXkLWpk2LZfYw8GfQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdV7ScKUw7bGFW4v0wS9caXKDeT02MXkLWpk2LZfYw8GfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 10/24/25 12:15, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, 23 Oct 2025 at 20:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Enable USB support (host, device, USB PHYs).
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> 
>>  &pinctrl {
>>         audio_clock_pins: audio-clock {
>>                 pins = "AUDIO_CLK1", "AUDIO_CLK2";
>> @@ -207,6 +230,27 @@ ssi3_pins: ssi3 {
>>                          <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
>>                          <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
>>         };
>> +
>> +       usb0_pins: usb0 {
>> +               peri {
>> +                       pinmux = <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
>> +                                <RZG2L_PORT_PINMUX(5, 2, 1)>; /* OVC */
>> +               };
>> +
>> +               otg {
>> +                       pinmux = <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
>> +                       bias-pull-up;
>> +               };
>> +       };
>> +
>> +       usb1_pins: usb1 {
>> +               pinmux = <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
>> +                        <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
>> +       };
>> +};
>> +
>> +&phyrst {
>> +       status = "okay";
>>  };
> 
> This node should be located before pinctrl.

You're right! I missed it.

> No need to resend just for this.

Thank you!


> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


