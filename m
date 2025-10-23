Return-Path: <linux-kernel+bounces-866511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B15BFFF67
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A3274E274A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9F2DEA89;
	Thu, 23 Oct 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n1GsVp6i"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93630100E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208695; cv=none; b=piR0hCkLc8HwsSVJdmbbvbIgpmzNoqSE7tLRb7pUuIRE/QTFVhM/bOKsIwq0ZYF5SiKjJPLfvHixFSDfigLbSkud5kvsEdoZpb3kBjiSryWtAnWjdROzS2VV1hhc0cG0PsQiQ8LvHRqPJiJoP3EDS8HEBNZTrhS/URt5RnhdDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208695; c=relaxed/simple;
	bh=aFCgRoWn6hr4O8owO6CsgHqO3QDo17jbxuWEH1cK73c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fq+poET1Vw8W5WN8+s6vsTx2U0C/eSTODAIk40GJBXUWAdprBB5t24iRrABS8jjgcEGnJ6agry8nWg++8t78n0qYl0x6LifEO3AriC4YGQR3Epiyjs7SIwm6s1SjOMI2hukgMoDkBWMdQ2JeeCMn0m0xLHAeDmP1qy3NBAGfRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n1GsVp6i; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4736e043f9so107839466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761208691; x=1761813491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUt/inqRNvCStH0GgE4cyP1lzFZ0UUVf4yEz/ZUZ2wM=;
        b=n1GsVp6iD2vwk03pMqjHdxS2dgNFtZWO70yeXIRynU2d29NDbHkyKkLvPXGo7R9TfG
         sVUjSRr22oEqvgaXACweSspqcOt37a1NSuUw67PAAQc9apZuCcbUn6CsB+FPvkVTM0VS
         0cZ64oTc0iuqsxaiHPgkf4XyD24TA9ZpMQt4G+8c4kHrmqlto3adbKaAyHC+irkHZWXK
         Hy0C05CklCaOg4/Ki05L08RTojP9Wq+EUoXCaNfaq0OiE9bp7zwCxiqf//w42Ey+IN0G
         SpyBbQTIYs9DnRsForEEiK5ql8EyLoT7ZuPVWtfZXJkgZIjJeCmyV4LZTdc/rX0Sx7jW
         hriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208691; x=1761813491;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUt/inqRNvCStH0GgE4cyP1lzFZ0UUVf4yEz/ZUZ2wM=;
        b=jI/yqPieCHLvCtdvUpxiYAJT1WkPVZUKpVe2Nkxgkn/ade4mQNWfXVZOmQn1iadkC1
         Ef4EGm4eGK4gdZiUqKs563QfJZhmwqV73JlQ5M5SPUY3eTlrfIxFueuruY7Ou+slO5YE
         EBb/v6YoSUPmeV7b347jfYFgnacCffnuDsp3gS3k8ONPqh593nuJHdd37T83YWWUgKMW
         crX8C4+Rsp5fxr9cWXrU2Zuok48PU7Qm8IwgA3EXQ+dANuo2UiJk16kRmUwy1xzmxRnx
         1rBAJtCHutNfgAvAeX4xwqMxyhwxNTWNUwExqD0IlstOiVk9bT9t/toH8tILmxgrkeDN
         RWOg==
X-Forwarded-Encrypted: i=1; AJvYcCWxEwFnClE34gLXb9BV/F/kuslF8BjuwFo5jTJ7vKBPwPn4YHv7W63QMXzygDU10KfXw2wiKPhwkxDflPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dpwIW4D0AGewRssit0UbMUWW9eyJjcuPb1iyq3a37lGe3Ybt
	m3C8UynJxWtUxoKbgHJ2jyutG1YnHgd4kgVwWi5Fd+ZKaNs2rRARVDr7btMwXgWgwTg=
X-Gm-Gg: ASbGncvSqeW6neGY+V02kuNJ0Y8Hh2GWYs+g95y1OD0RYh1rBTI49Fh4Gs0sesRdBZ2
	3eaUvXiMlqfjCS89Eodvx1H+AeKaIPv+T5qfANi+x6I0pVhxfizVolMaAeIpF75Xa4nWR2JWEY4
	M8wPWFu1eFsQgTt5FoN+D5IWTqqtj1gKU9LKZA1WhaSqWDDnIULwVu/4D+gQrBdAKskU7BOKFiw
	ERASH0jpkWHTEJRShRjM0Ng0rL3PMwsnO4wBsSKOp0XL9+HwwkW7yplEZ4U0AAGa2OOxArQrtYk
	nbDQ3jf0+MaULpmf/6PwfCMI+3IFivzUuI99NC19ppB1Do8vuRsHebEUppaLBFQ6kpK4bXYVug3
	E0dMek1nSehRfhg1qha8hg0ikU+9EXlVKwp4KSo1pOn8cVcfaT7lM53+C85Wa6tV5hu0952mgjW
	HqIrrwDDS8
X-Google-Smtp-Source: AGHT+IEYctlT509BIkD5r6RIEyIRhDk3R9yLwlPD0q+eO8PeE5EUYZN1xaUEvKp653FWiTfMauLsCA==
X-Received: by 2002:a17:907:7ba7:b0:b3f:f207:b748 with SMTP id a640c23a62f3a-b6471e3c961mr3124511166b.10.1761208690969;
        Thu, 23 Oct 2025 01:38:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d41a4sm157071566b.9.2025.10.23.01.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:38:10 -0700 (PDT)
Message-ID: <4de8ed54-e850-4685-b486-623a45145ab1@tuxon.dev>
Date: Thu, 23 Oct 2025 11:38:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: renesas_usbhs: Fix synchronous external abort on
 unbind
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com,
 geert+renesas@glider.be, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20251022124350.4115552-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWTe8t8O2H+hPU6=WC6V_YGHwTd7sF1htuhX8mVC_fUqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 10/23/25 11:07, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, 22 Oct 2025 at 15:06, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> A synchronous external abort occurs on the Renesas RZ/G3S SoC if unbind is
>> executed after the configuration sequence described above:
> 
> [...]
> 
>> The issue occurs because usbhs_sys_function_pullup(), which accesses the IP
>> registers, is executed after the USBHS clocks have been disabled. The
>> problem is reproducible on the Renesas RZ/G3S SoC starting with the
>> addition of module stop in the clock enable/disable APIs. With module stop
>> functionality enabled, a bus error is expected if a master accesses a
>> module whose clock has been stopped and module stop activated.
>>
>> Disable the IP clocks at the end of remove.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/usb/renesas_usbhs/common.c
>> +++ b/drivers/usb/renesas_usbhs/common.c
>> @@ -813,18 +813,18 @@ static void usbhs_remove(struct platform_device *pdev)
>>
>>         flush_delayed_work(&priv->notify_hotplug_work);
>>
>> -       /* power off */
>> -       if (!usbhs_get_dparam(priv, runtime_pwctrl))
>> -               usbhsc_power_ctrl(priv, 0);
>> -
>> -       pm_runtime_disable(&pdev->dev);
>> -
>>         usbhs_platform_call(priv, hardware_exit, pdev);
>>         usbhsc_clk_put(priv);
> 
> Shouldn't the usbhsc_clk_put() call be moved just before the
> pm_runtime_disable() call, too, cfr. the error path in usbhs_probe()?

You're right! I missed it. Thank you for pointing it.

Claudiu

