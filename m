Return-Path: <linux-kernel+bounces-884998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDCC31AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E68189D728
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85597330D3B;
	Tue,  4 Nov 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj3CBwWq"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5133030D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268239; cv=none; b=hi+5sxG/fo54ffstpOy/yTR6z3HXt09WAHQTETDX9JItnTW86VQ51t+snvEKnNhQWxzN/ah1KhMx0run2DdDZqemUNHRHzZpMp+37avRrszDBCqwSY8cfgouWgjmdJE6l218vxnKA/ErKMigSJTPbpsd6u3tZwbz+EvqGqQPPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268239; c=relaxed/simple;
	bh=YM94J44mVWcHhHobHQ4Mu8GD2TcuHc2SnC7RSVcg7t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuJAXFgf+ka7sjK9076KMK1ypvkOVh29qRl7kZACzhdyv68prqQCEpluDkWdYYu+VnBYbGIf/GT9zn8xyS2OPzNcs/uQONQ0iJoeIlawAgG6wfEY4V1k8sXadIvqx44Ko2ZOjh1cUo8GPSCSaqPdhNhn/0P168z7lxiQ1+NFDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj3CBwWq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4f323cf89bso247706766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268236; x=1762873036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyKbMiTwK9ssL83pTrppNaRv02OKweXOu6raB/LyaoI=;
        b=Pj3CBwWqdXm9CV7IUdAk32FimDANuwWamQGEUMadzodQbMrAWxrL7llx+CC6635hWl
         KKmxhFK336jgKFrL/yAt7fB+sRSE6eMekV6HvoCNiO42bZgiG6cYM5YUJUe8LPcS/Ah6
         SN1ENZSsXAjS7UVz3d8gMA7oofoBIqGsz3eQINJDedvs9cpxGspiCc9RFEMO8CZrr9ls
         b/o895/vRwcv4MRnSmlpFUaeAKIqhsAOa7/Peu2ENztVnCqiqkwddjfQ7DvD6+Y/l35L
         59RQfVC+Qx9p85SL0eldIvIfR8qPw83blN0Ao3+wPSadbb/UsTbq9NSCJDhim+WKjyYq
         X0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268236; x=1762873036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyKbMiTwK9ssL83pTrppNaRv02OKweXOu6raB/LyaoI=;
        b=Qn2KaagSfymt42gsqU896XGtL+yeNY1uYaXdrmjoEJNufVfHt3c8hSNkyJDecLizYo
         AuJ6briar/6G/DIV+pBxV/xrdP+H/IfbIjFdyS6rl6LacpiY09W4iKXI2cMEyPW3TW3P
         uGLpA662dQEc/AbqSO9asnwc7WImiHpVUai+RwwvKIjpjYSqBg+09b7lAX22AmSradXL
         Rqx8t9lMEDkt2oIuO77woNZB235iaydToI4oqPQElAxGXggNIK8eKa/bjkgREesRfq+t
         NqZkYLt8DyflGk1Wi80UPS3fkaiwBLQnWdUWJixLBvWmE8i11SJGDAXVYW++8qFu/N8a
         CJsA==
X-Forwarded-Encrypted: i=1; AJvYcCUwshHEP45tMfwQ5tc4fwKZyLk5PQ0EmbbSNOcztaovv8CFiOcLPzuFlOa4/hkpLGiRvyS7hkZchZ8ihOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz920LLP5DXMLcQ3u/CCFeEASJMU2x2dXR+GhjDJppMU6nQo6mP
	RVIZefKWckr+nwwXfbWi+Pucrla920DvysnFLuPb2isbwDeXNQxxr1gY
X-Gm-Gg: ASbGncsSvIiBOm4Z8Lh3m9CchEVbmZKNCbfiMsNbO41vGBdz0jlqbV6WbixeWfk/9lK
	NTlbjZCyZI/E1sXP1wdObkY3K6PEMfEtlMgbbU/5RiJTzlVH+4RHbptDrYVpxeWulFofUlmi/G4
	y4wx4+BK8us/UbugUh8m0O6DmvD4KXOR+xZBGyD/LXsUGEA+4daI+tZqrBWgX5QKPSLjAPlM6hS
	To5DmZagBBhELUoNXvWSmuhuiNIgtGuXwx8C2VdzQJmQwgg9ON7rbppfZi/GzgF15Fp8BXuM3Qi
	Q+1CYFHYEid2q0/kz/+wJmoxokatlvrsRzODZ6SeQCl1xi+MnG5O5ebuze3ZRqojw+rORXlHimW
	+DxcwMHaNEyxOJmXJVKXVQEswVTenwMX4bpyjQyc0ES/yoGJR0xlMTkgDURucXWFYQJ7h7lptkp
	5Y9OvWsHqiktwnJvq6rMXSonoVWufkfa63VpbDIjm6c7osp5RJHSmRvKJqPQ2KNaKl12n/omEsT
	C0=
X-Google-Smtp-Source: AGHT+IF8nsL2Azg7aLrnmFrqf3kuPfRfWtRwF10OY8p++CIvPXZPVi67htZBs2fu0OkHWY7YqQjy0Q==
X-Received: by 2002:a17:907:9618:b0:b71:1164:6a8b with SMTP id a640c23a62f3a-b7111648675mr762408166b.7.1762268236193;
        Tue, 04 Nov 2025 06:57:16 -0800 (PST)
Received: from ?IPV6:2001:9e8:f13f:9101:4d8b:ecf0:8996:ebbe? ([2001:9e8:f13f:9101:4d8b:ecf0:8996:ebbe])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3f96sm229430866b.13.2025.11.04.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:57:15 -0800 (PST)
Message-ID: <59b5eac8-3380-4fb4-a13d-9e4b32b403c4@gmail.com>
Date: Tue, 4 Nov 2025 15:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] gpio: add gpio-line-mux driver
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251026231754.2368904-1-jelonek.jonas@gmail.com>
 <20251026231754.2368904-3-jelonek.jonas@gmail.com>
 <50646b88-5746-4665-8085-09e394aa291f@bootlin.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <50646b88-5746-4665-8085-09e394aa291f@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,


On 28.10.25 10:45, Thomas Richard wrote:
> On 10/27/25 12:17 AM, Jonas Jelonek wrote:
>> +
>> +	struct mutex lock;
>> +
>> +	struct gpio_desc *shared_gpio;
>> +	/* dynamically sized, must be last */
>> +	unsigned int gpio_mux_states[];
>> +};
>> +
>> +DEFINE_GUARD(gpio_lmux, struct gpio_lmux *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
>> +
>> +static int gpio_lmux_gpio_get(struct gpio_chip *gc, unsigned int offset)
>> +{
>> +	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);
>> +	int ret;
>> +
>> +	if (offset > gc->ngpio)
>> +		return -EINVAL;
>> +
>> +	guard(gpio_lmux)(glm);
>> +
>> +	ret = mux_control_select(glm->mux, glm->gpio_mux_states[offset]);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = gpiod_get_raw_value_cansleep(glm->shared_gpio);
> Why ignoring ACTIVE_LOW status ?

I think this would be rather error-prone and doesn't make sense to me. The
consumer of this driver should decide about whether it uses ACTIVE_HIGH or
ACTIVE_LOW for each one of the virtual GPIOs separately. This should then be
applied as if this was a real GPIO. Following the ACTIVE_* that is given in
the 'shared-gpio' property then would interfere again.

> [...]
>

Thanks for all the suggested simplifications, I'll incorporate them.

> The advantage of the forwarder is that it handles if the shared GPIO is
> sleeping or not.
> But I think the forwarder shall have ngpio, not 1. You will have to add
> ngpio times the same GPIO desc. Also unsupported operations shall be unset.
> So I don't really know if it shall be used in this case.

I agree. As Peter mentioned, I need to use "can_sleep" anyway because of the mux.
So there's not really an argument left to use the forwarder.

> Best Regards,
>
> Thomas

Best regards,
Jonas

