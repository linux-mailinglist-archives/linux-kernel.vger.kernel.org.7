Return-Path: <linux-kernel+bounces-798720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48251B421F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BF218960D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BDB30ACFE;
	Wed,  3 Sep 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqIki6zW"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60305306D58;
	Wed,  3 Sep 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906661; cv=none; b=R7cJ676mxH4jXb38Hh6dcr23x/uxvRJg4C9WF2wixd54n82PTtG+P0ZcCJQPzypyTwwiS8n4SocrsCzaXaygaQSByfEMclXHSoYNEZMrK7N6kR4y/HOOhmBzM18omahklF5JkMfk57obDc0qkIe7waaSTO8kzxDiRr17z2+Ow6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906661; c=relaxed/simple;
	bh=xFiEl/WZbgrH3b5G3kdyX4oHClAVarAcPAtaZ8YojW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNZ7YuD2KxpxR1Szz6bflp9lOKQ6Gvkv+XhS4UGz4IzK00mtfGRH1gLwMrl/noCNSlTu+cVHjclDWTAc3yl0YVQIMjA2a8rKx9AN0bSQMsGcXYWjKVYNRX64LHKm2/2YoqIRIu8zVpc5Aeu9TiAECZ8leP+xTz+KtgveU1RZ1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqIki6zW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso5577623b3a.2;
        Wed, 03 Sep 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756906657; x=1757511457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2ePhaD2TvCl7nFTyH0fAt6338i1RBsjOrwD4h9agBdU=;
        b=XqIki6zW+e+IUBSJUXr3xqEYQtb2iEN9zA6uGcQpPqjWu8TJ+JCFFX4GhduW4d2UvB
         AheidM4ej5tNWKmulE9cen3Edv++A6iwPKcm9ZPvopbNNUABlJbgwQUg0rjmmAjftqfX
         21vPq7/S/bpsBZOMR9YxTp8t+n6ErLF9Dm9IchaoXKhIc9qwOljX2wunVVNDiO2VuzDo
         /IKmHXtJeBb5KtF/4vJ5CG57DXUbVRFGunZbeBKqC0mZJPqpTB5ShWNRnHkRfHo3EMI8
         V525WsZYs8qOHjAJ7IVeTiBO6MZMq1jtUJqW+3lH2mlrP9bEwWImoLPb5XK4kbvvfiY6
         2umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906657; x=1757511457;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ePhaD2TvCl7nFTyH0fAt6338i1RBsjOrwD4h9agBdU=;
        b=Xodb6IRwLr+rfXYH5urO3W0rpwIpPAqfVZi2p9QnPyO+vCA3LvuvkbJTXxA2iubSxd
         xbXySGAKE+IU5wsCIUs4sygA41Aes1BhN5UUlVEvgWqwE2g/rhTLfq2qD83adlVLBjAi
         Zzb5zfPfUq9jglguChsck8UvSkLj9jOWED8vci9XoNe/9qyWyXxAKNGfCzp2Qn0qEEcA
         Gevfi1GxexDhsBjlozf207wgkHQX2oa2fyp6/ts98yrhJseJkF/mPgCa375b1AbEF8mi
         X/+8ffpHJ3YruzYplqXq/XDVhcUVZpDJtXeUF9J5TSYdAQb5toGp7QvbCZwzuq2Nw0sL
         amZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKSYZgE0i7mJssYlk7YchyxHv4/8IDn7+UoN6C7FUf7fu9k7V1tWoCZabyhNb0B6pDgWhZemQmQnmBOb0G@vger.kernel.org, AJvYcCUs8VGfW1uqqFID8ZWSO6OPDqXtv4Kd7iPR6XgOh1r6CL46w1vvvRM1rNmKaWc6C/MPRU551ocOyKML51E=@vger.kernel.org, AJvYcCV+MG/1surhyWo0sOEHEb1I1UjIlm+MbPU0AxXJ0dyqmSwm748Nfx/9zgKAYoKyNjGOvhssZB8enFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlWHiArFo7jlSZQWOnAX9oKgc7DMWJ4gq6JaL3bE103RcYNIn
	gQ7Kbr+R9/Y4sBhOlCRC+j9jRFXXlez1wAgbnEeHtP2pNEeiNPLsuCob
X-Gm-Gg: ASbGnctoMf3QEm5OckgTOZV6+5T7bQgRnRppqlXhpTcAXZt6TtcMYEtyp3pG2IAUko8
	BAEiPL1UAz6xJBR+gk8qZ1anZbrqs5CId4CLD0KIVYPM37U9hUlseVXSswy3KkGZqeFSLn8oaGL
	icqXDIQC+zVjjLhfm/0t2r+VKoFPo0q27SM+5aGBfR8EJxiQ56O/YLW2JmaOtxAwZuH1h0uyAGH
	pafP6My8V+KqQi7breiF0XC/1AzzjIzqZdk4sRxvhleJz9xa3yj1ACJDTXtYS/6UsOqudujUaO3
	kSd7XQuqfnEQ0xd7wOC7pe4/+jnbJXFEgkg20GLeQnuwdHLazuPDiFGa+Xao4uUhzPDeVRVuIbj
	PVc53FzrdRZceosuzvGapBt7SWjvfviS8/p0YxuuEcdS2Xq+7gjHRRkYm04ndahaPznOJAvQ=
X-Google-Smtp-Source: AGHT+IHPe59TuLDAN/MMPE9kyzaKM7zmD2QfmRnB8SPbQjiUN8D/vK0aWP1IcNUKtqdzsNK3BZ0MyQ==
X-Received: by 2002:a05:6a20:1594:b0:246:3a6:3e40 with SMTP id adf61e73a8af0-24603a662demr5967240637.12.1756906657390;
        Wed, 03 Sep 2025 06:37:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772608b1b5asm8211051b3a.46.2025.09.03.06.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:37:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3bf7df79-7512-4372-9e37-8726d88a8f36@roeck-us.net>
Date: Wed, 3 Sep 2025 06:37:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>,
 WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>,
 niecheng1@uniontech.com, guanwentao@uniontech.com,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, Antheas Kapenekakis
 <lkml@antheas.dev>, command_block <mtf@ik.me>, derjohn <himself@derjohn.de>,
 Crashdummyy <crashdummy1337@proton.me>
References: <20250820-gpd_fan-v7-0-10c8058f4dba@uniontech.com>
 <20250820-gpd_fan-v7-1-10c8058f4dba@uniontech.com>
 <c6063674-94a0-4f0b-8b40-c9438e28c0fd@roeck-us.net>
 <5B765D41DFE0AA0C+de6965fb-02c6-4ecf-8223-afabfdff36f9@uniontech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <5B765D41DFE0AA0C+de6965fb-02c6-4ecf-8223-afabfdff36f9@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 01:33, Cryolitia PukNgae wrote:
> 
> On 02/09/2025 23.38, Guenter Roeck wrote:
>> On Wed, Aug 20, 2025 at 05:50:38PM +0800, Cryolitia PukNgae wrote:
>>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>>
>>> Sensors driver for GPD Handhelds that expose fan reading and control via
>>> hwmon sysfs.
>>>
>>> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
>>> devices. This driver implements these functions through x86 port-mapped
>>> IO.
>>>
>>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
>>> ---

>>> +static int gpd_win_mini_set_pwm_enable(enum FAN_PWM_ENABLE pwm_enable)
>>> +{
>>> +	const struct gpd_fan_drvdata *drvdata;
>>> +
>>> +	switch (pwm_enable) {
>>> +	case DISABLE:
>>> +		return gpd_generic_write_pwm(255);
>>> +	case MANUAL:
>>> +		return gpd_generic_write_pwm(gpd_driver_priv.pwm_value);
>> This means setting the enable status to MANUAL will set the pwm
>> speed to the maximum unless a different speed is written first.
>> That includes win_max_2 even if the value was read before.
>> Is this really what is intended ?
> Thank you for raising this important question. After reconsidering the
> design, I believe this approach is indeed intentional and justified for
> this specific hardware platform.
> 
> GPD devices are extremely compact yet high-performance systems, and their
> gaming handheld form factor means they're often subjected to rapidly
> fluctuating workloads. The small thermal mass combined with high heat
> generation creates a scenario where even minor CPU load changes can cause
> temperature spikes of 10+ Kelvin within seconds—as I observed during
> testing when briefly stopping the fan.
> 
> This behavior is designed with a specific safety philosophy: when userspace
> announces it's taking manual control, we assume it has already prepared
> proper thermal monitoring and fan curves. The brief moment of max fan
> speed acts as a safety buffer until userspace writes its first intended
> value—which should happen almost immediately if the userspace controller
> is properly implemented. This prevents any gap in thermal protection or
> frame drops caused by throttling if userspace fails to write a value
> promptly after claiming control.

Please make sure to document this behavior.

Thanks,
Guenter


