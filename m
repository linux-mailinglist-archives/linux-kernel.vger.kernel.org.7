Return-Path: <linux-kernel+bounces-812780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB1B53CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8617AE643
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BA26FDB3;
	Thu, 11 Sep 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYbqvfh0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4975265CBE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620246; cv=none; b=I49GjCD6zKewUrIGSj4wPfnmFO/EgW7WDBHSz2wrjhDF4HNneTdadE5a2nSsklL3y+MOEpVMjcKla/7FTkeOEpBJD5XhW3BwsB8TJJLd3SWuAjjUVITwkJdcwVqWKKWoSRrN9d7WdwTITdsSwFTAdpk7D+GuGMGpEvng4yaXy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620246; c=relaxed/simple;
	bh=kjGxb0dqWe7yMsPMZAV2sViKlRrgFATmcxKdL62xjMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgPnYUrNIK6JzGYgOIP7RquRC3PONxAvzwxsIOg193+hR+m8p9HPLWIjPmlciIpbG8cXmKp509twa1uw8gVLyZjCRiELkp4S4vf+m1g94SUZvlIJ86ywYPQ8H9ma2/UdL386byL1vCfraAJNY/bKJH7SgL1hkDAmvBZTPFniREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYbqvfh0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24456ce0b96so13745235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757620244; x=1758225044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJeew9YIVoP09p3LirTxwS5JzCuSaF7BlgkulwqqjZw=;
        b=lYbqvfh0apVRXMw+txPj0wP76djiX9rgjxr4pMffpBBxgjA9QIxYKQvqPyWx8yFLYP
         8l/q3pWkuetePejx6oo+sURwayCHPh2fzsURenVJ14vSn2gFHhPb9MxOx66joJjW/AXm
         VVfnH8vC1kA7mDA2GGoaNyVgUbrQ/jUj17cTeAAEM8lqP4aYRAAZbJrLF1svu21pFe4I
         0ESLc0Pp/rY3tMipO/Wl7U37HbTdplJnH43xex4KBq+yB4vbnhBzRyGmLyOFQNFzKGUp
         i/rDcGTgEuyoH3u3E0YJ8eZWS72evKAgxCUJTw2wigD0TXH/sSyAc7ibOsNwXc0QwcWs
         58XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757620244; x=1758225044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJeew9YIVoP09p3LirTxwS5JzCuSaF7BlgkulwqqjZw=;
        b=lZzMVOPh+jqk/F7U4wTdX5bKjkCmdpHNzXGWgSr4nbieIqCNPUv5Og9xLoBqqnjk3w
         0152axhpNX+aQ1OxiGW7PFRnYvLW5lI4ZgiJyE53RKftd4kTU9SslWzmXRFHAbJVnQRA
         MhFDWvfN49fzgY9G7c4tLMJoeEfGKY8SoMr2gBQRWM+0Gqj1eReyIKFpqipa7ZRMSk0r
         9uJYWn+tinXOiQJ29/sd4xbReXSzYM6q9Yab4+JlCkJA89zs07nkqMqv4gb29dkbPqMS
         grS2rXO7+lfeKxETg/p+XgiCG68CCdhKuOVI9QIhW/JR43EEpfScFeC/dWtBWV8VRNfD
         Xg+g==
X-Forwarded-Encrypted: i=1; AJvYcCWYlZH+OJGg251Sl/uO7vrYWixZyhuhT7bM3fqy6cFSsT4pCqSZDyQWQDY9tUFLUJiJiYuxvRutYu4/Zyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2OmF3HZtrnZhmGAIXcZ2ebGYAJ/pa2DnJiftHpI5TNiVSNeI
	0A17XtRmiVY1UO4xrUYXKzSMoONMgIDIFaEO69hWxrKFxsHeNgh/iOdL
X-Gm-Gg: ASbGnctL8ZDmW8ymelnTmtHrUfMDLyooo2aVAdc1ddlZVVDOQL//yEePglRg1kt83FV
	TmpE5A+zx373Uq+SaAWE1ia0rK/CkPeSwLgqhWu1mNhNPprX7QyvpCzXp75cVm10uM/rhBEnsiO
	wbHS4BJ7CgDs44au7xoNmZhgWgnRCny7q6aKzcfsh15v6lLTsGsP/eM+ZY/9nqFf43Dfcz9G4Xf
	F0+XNHtcMggrqksJBzfpsQbtxZugC+qctGkKQ1AWOKRwilJCO1pLRtxR1YIxs3EfU6uzTYtAGxc
	0znPb/FDPNXkGhiolX/+y4C8+YD5o9WJrrIgLLZhtQxma8hMApV1JkD8bHAoI7a6KFwQ6a7Iw2t
	QN9n6Df5bMWnhI5Yo94yYG3+eRE/FugKWLtecQkwUm/2SkPOu
X-Google-Smtp-Source: AGHT+IGM3HY9cYe0k8sf5GxMMVgG9l2ykvqk4n7ayiGGr2GhLio6Ij8ygJsJDwHZ88T4ZvBeMdpxjA==
X-Received: by 2002:a17:902:d506:b0:25c:9084:4172 with SMTP id d9443c01a7336-25c908466d3mr25755745ad.14.1757620243626;
        Thu, 11 Sep 2025 12:50:43 -0700 (PDT)
Received: from [10.69.47.143] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53bcsm26957775ad.28.2025.09.11.12.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:50:43 -0700 (PDT)
Message-ID: <cfe7bc19-763f-4e92-b1ae-355c661bcc19@gmail.com>
Date: Thu, 11 Sep 2025 12:50:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] gpio: brcmstb: use new generic GPIO chip API
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Keguang Zhang <keguang.zhang@gmail.com>, Alban Bedel <albeu@free.fr>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Yixun Lan <dlan@gentoo.org>,
 Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
 <20250910-gpio-mmio-gpio-conv-part4-v2-7-f3d1a4c57124@linaro.org>
 <e0941449-7a62-4bbb-8790-616f393f2cc8@gmail.com>
 <CAMRc=MfZ5ss8Gd_TTPV8EYSv04ENp_C26b3=wukO+UTy_boXUA@mail.gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <CAMRc=MfZ5ss8Gd_TTPV8EYSv04ENp_C26b3=wukO+UTy_boXUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/2025 12:56 AM, Bartosz Golaszewski wrote:
> On Thu, Sep 11, 2025 at 2:11 AM Doug Berger <opendmb@gmail.com> wrote:
>>
>>>
>>> @@ -700,7 +707,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>>>                 * be retained from S5 cold boot
>>>                 */
>>>                need_wakeup_event |= !!__brcmstb_gpio_get_active_irqs(bank);
>>> -             gc->write_reg(reg_base + GIO_MASK(bank->id), 0);
>>> +             gpio_generic_write_reg(&bank->chip,
>>> +                                    reg_base + GIO_MASK(bank->id), 0);
>>>
>>>                err = gpiochip_add_data(gc, bank);
>>>                if (err) {
>>>
>> I suppose I'm OK with all of this, but I'm just curious about the longer
>> term plans for the member accesses. Is there an intent to have helpers
>> for things like?:
>> chip.gc.offset
>> chip.gc.ngpio
> 
> I don't think so. It would require an enormous effort and these fields
> in struct gpio_chip are pretty stable so there's no real reason for
> it.
> 
> Bart
Ok, so assuming struct gpio_chip is sticking around long term that makes 
sense to me.

Thanks!

Acked-by: Doug Berger <opendmb@gmail.com>

