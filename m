Return-Path: <linux-kernel+bounces-888798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27848C3BF23
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5EF188D805
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C2345729;
	Thu,  6 Nov 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n6FuvJYS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C432AAD4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441148; cv=none; b=nLsgw+tkhEsS0keSYlbbVPP2fDg4r9ne15jyVrZiKcVqGGJZHOX0JQUITONMq3YXnjnGGt8eybXMwkY/QSvTri5S4KR8zscWPa1GQ+4t2MwYicfcGgkRrpdFizYmsPcZZbukhGHRJgZFrWzpkTiaetlTHfYAkq/8kLGlZj2kY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441148; c=relaxed/simple;
	bh=jRlH1jPcF1waR7uAVHwWqhLwUm4a/DhOStRRSFZCfDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8kzOXqOtYIouN3n8ZdMtFHmzIUoc8eWCP7bVLvlUDMrTnahLgHQXdw8jbO6vpZ5xpbXrI24WXa464U2tB8zDPH1502iB0pTHuW5O42OIzHlF1OEhQRa6egWThIu5UUQq6HjOlP+5OiYUH94FVoyg5LEGkIWj7ksAyaffS3oQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n6FuvJYS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429bcddad32so817007f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762441145; x=1763045945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b626QGmxPl5C2QrlyoCoUJ4MIPcPPxdOo7HYuQFmV1Y=;
        b=n6FuvJYSrqWVO7Wx6N/HwemXMhxj/KMbXqiMl4cd8wx0wbiEhmeGl+s1cdWSanhZrZ
         8ys/KS7Qzmbx+0fNnqggrDCr1HG+f9c36Jr+sdUvYr0A5mE99U235jbH5QOnafEYlW9m
         9fF7+Z14Yz9i7nIc0W6VXSks8cju/CdxLnMy7un4/cFzodWoW3HCkzO0LKUMDsZdyjgQ
         5C4+wU4HR9qZKIee/01/9spvT29S7ez1S+Gv/KHFOETYhZ2FDO1RmOcVXjLN+aBFm/It
         aGYwm9m5P46QSku4yKVka2X/kDIkCkECuhQA9/MTP2W80qOKWUc+lqC/bNAcxxGLOa6e
         umtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441145; x=1763045945;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b626QGmxPl5C2QrlyoCoUJ4MIPcPPxdOo7HYuQFmV1Y=;
        b=Kjz0vUty+CZDw8pTWza9onWGh31IZc8fiPGhxCSNOa9bKsBl9Bzj3f8/KdlPdQa8/f
         PKP6hyUIOZ2B8mGA6wNiPEcri2kac16/9+uH/a5BTU9CSbifSeXrMI4OQN76gxm84Td+
         W5QkwS7ng4isL3sARon0cL5Xd5qwmWbtwUnroP1iFv7RMcM9Gox2oLF1yC9yHtUwW5+S
         GX0cQQCOLDZZILv2ngiAraEu6HgdVQkVHSJZguCrKQRoY9GlOKicpEp8dvzbQLWo5dV9
         Nh3PVx0/+K51Vx0ZxmIS9Oclbf5h9K3pcl2vO+SegzK71WtdiB+Iyzsp5Xrkl3u5BuKd
         SSXg==
X-Forwarded-Encrypted: i=1; AJvYcCWMw0+UZRjnCVTmJ9otQAgmc++lMkif0uzb1HkuXIz3zZTA7YbvWfLv/79djDC49LREmpjshYgRLZBG0G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0J/2EBqMyp4utZujxLejXICyljan/3BNiOhqfAbZ1bQ4poZMq
	/uw3V243tRAbi6sKZbE8nrBO9tUacSvldvdfhgc6ZTk604uj2KILF+c1VTL5nLcZS2s=
X-Gm-Gg: ASbGnctJhwiz8aJij+Cc8E43r2EAY0JvLcInHwg4p5nxDYL+rQucJCaqhkTVP2gAa6E
	0UFgFEyKPqO5Xj1uv+vPBBpj1ZhJ3uidGlh3CBfdBxEpOZslqCmgMksbKkHN0+LYOoZI/jLjUX5
	O43Q567XItgXAlVanjZNlj7+Z7XOPfqlObiIF7pUYvRyLHCwSV1tso3jt23xEWtuO6xTote2TzR
	Tv61Xby9kgNyIGxzpknu//g40u+FdOPTHNlOlqzIndL9eFKOas3HhOGfU/ZVYGI3z5p/Twoj/Dm
	2XoPr3StmRM7trfaMbCgD7eQ5MniB6qtWajobRJ4qgTeFEscWKS5mPtGrB2ip6igN+hdyNzlK7c
	O7ZQJ7lFVcaLA/mS75i2kr+lDmQvT0F4ub9e/ayYAqyjIeucXRHVFx+Ehs5iq5Fjqx3nXLknYUo
	ZCHBxZ3Grk7aSZpHOtVnw=
X-Google-Smtp-Source: AGHT+IFb2ZH77ClbG1Xsvtkj0gasa0VqifKoeJXf8nrkxhdUagrhEY/I6njHvkpHzuiPm1mVcmqaIA==
X-Received: by 2002:a05:6000:4182:b0:429:cd3f:f43a with SMTP id ffacd0b85a97d-429e32c841amr4419135f8f.7.1762441144704;
        Thu, 06 Nov 2025 06:59:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40375bsm5348089f8f.8.2025.11.06.06.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:59:03 -0800 (PST)
Message-ID: <64c74f86-7438-49da-b164-a8a113e47c32@tuxon.dev>
Date: Thu, 6 Nov 2025 16:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] usb: host: ehci-platform: Call reset assert/deassert
 on suspend/resume
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com,
 geert+renesas@glider.be, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
 <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 11/6/25 16:52, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
>> of the SoC components is turned off, including the USB blocks. On the
>> resume path, the reset signal must be de-asserted before applying any
>> settings to the USB registers. To handle this properly, call
>> reset_control_assert() and reset_control_deassert() during suspend and
>> resume, respectively.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/usb/host/ehci-platform.c
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -454,6 +454,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
>>         if (pdata->power_suspend)
>>                 pdata->power_suspend(pdev);
>>
>> +       ret = reset_control_assert(priv->rsts);
>> +       if (ret) {
>> +               if (pdata->power_on)
>> +                       pdata->power_on(pdev);
>> +
>> +               ehci_resume(hcd, false);
>> +
>> +               if (priv->quirk_poll)
>> +                       quirk_poll_init(priv);
> 
> I have my doubts about the effectiveness of this "reverse error
> handling".  If the reset_control_assert() failed, what are the chances
> that the device will actually work after trying to bring it up again?
> 
> Same comment for next patch.

I wasn't sure if I should do this revert or not. In my mind, if the reset
assert fails, the reset signal is still de-asserted.

Thank you,
Claudiu

> 
>> +       }
>> +
>>         return ret;
>>  }
>>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


