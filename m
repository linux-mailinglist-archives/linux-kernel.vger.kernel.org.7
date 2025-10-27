Return-Path: <linux-kernel+bounces-871039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EDC0C4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B23B773D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575628A1E6;
	Mon, 27 Oct 2025 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttwltuwi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913671553AA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553599; cv=none; b=CpwbL70MolrwvrQ7tGTYPVd7wN0iyyEQfnvWBW7xMJs8IYiwe4AC0xWAXXbcotIX13jci/96CSuLw4Mf66Zf5C/hfyFOxoVDkz7xjDHi3IpB1215jn1GeYfkwprcvNw54Yh1TPbVgyODhWeNSzcVU1RpuAZUjol3OCt3IGHNNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553599; c=relaxed/simple;
	bh=gH/jFYL3OQOMsGnxKfmscVPkEFC4139EKkMPyCYuZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en+ggwswUDeGxyFA1bMVcB4I0RD0rg6nQdYcbjGbU7DsuPltgGS/f3rkmJB277Mtn+WHKi3BYXewWuP24MRwley15sJf7X3YbN/C5f8r0UxMG95GS1UBNcJJT3O/mcCAW/8IYWfggc4Kk51ToX4xrHzRUlPVkBXFlNRROVBIFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttwltuwi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso8602196a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761553596; x=1762158396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXj47gID0X51rCR7nOHEpCUw1/xTgwSozZGVXHUZwWE=;
        b=TtwltuwilcscY+8dFsPzHBAei/94hCy8jdSfTjGC7mBQ7Zpz/mCwjkjzwYFflPia0E
         ABK/Ev4iRROE1H4WCfsRdO34YHnYpI6MaR2jhFAOQh4jX+WueO9+3Ypq0/SajqCWqfI/
         uflracaczln2rHt9FhyWZnZbCX8eVVa8yLiGQ20dGs7gS50MUqsFUAc4zRQBeYpDvkIr
         xLVKwHe7C8Us9WvA1ai7NVvVjftUQe+8523FGoc2YdjY0GOsxUaqqlibZx2VTS4KsLj+
         pzlbi/6LTQoUtxpdHvrCNryXQipbKLvXJRNQfy050zg9KtZhPA7R98yiIjy3qfmchbCX
         Kf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553596; x=1762158396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXj47gID0X51rCR7nOHEpCUw1/xTgwSozZGVXHUZwWE=;
        b=RbCmQmXNXMRAZU+ERCX/G8GuyxjaKsiZKI1dw9hnoF6zcEgT+U7vS1jkaw3aj4xDAy
         P/aXCQurUSobcNF6lD5mAlMadDsbbMM6Vs+Bz79FtL3ibBH5FPcPEhzWBA/Rr633c79b
         gbKqx4B0I1Q3VyREl0VBsNLU/8vXqDVd8DiIcr+iCgvkRz/+YEKXlJMZyf6oaDPvccfC
         2g/XTpuVc+EWmPn4Y5iQwY+F6gbM2xjTDqFoU6UGthOJH9B1Wx2SakB0NlWtA8kN1JtM
         G1cDKxaRhprnPvvF7kl+b9P4DI2edRxYQbQ5jEu4R4flUu4QfpHTN/wFCTIwvQIqoYZv
         KAbg==
X-Forwarded-Encrypted: i=1; AJvYcCXuaYWhsxFh0O25bDaZcg14Yis9IYJZQKRXhZS7RIOam8KVLpYHRf8VthCRcTLxHOUPuo0+tbw2diGmVmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywzdj1agPOJuTYgt9/NJPN3ihMEP2GCTqja42j9ab8ICHhivVN
	kO3vgfMAfQ8ZeLHVpejmbILPa3+ajhPNke5k4Jq73Tf7z9NCWLl8wM3K
X-Gm-Gg: ASbGncuw2Yj+lRWVWCkl8eNFeSOMTKqm7/39pDHUrKHpQFYfrSCPC5ROBQ0Uiet2NZn
	YN51Z+O2TY+UK0lPRbtXhGgVN/iZD87K3997NMnEZgrdHkYFa+GMVolXxau+82vMKWACmf5uyIo
	dUY5O39Zkckf+/vnaRI8lLfqbNo3p/q3rfVxxvzPo2t2SwcoYOVFjSiCsFGn4Rx0SMovpgNZ6M+
	z58DN02jDwZZ8Y3BNMLfACp6q+8yDY4gd4cP+l5sF32mXkjtzXjY5d8tEkfVzgUB5Ls+PTVkzGL
	25DG2wUwjfgqKXVHY9JRDT5iV8S3NbsDxHpixXLChmdv0sXAIL78fR0HT932B0GeCjsJV1uc+7u
	qutGq6rvw6am/e5poTRV6xSUMRaxDZ1nxauqvfCXRiOQJyxrZhn6cK1u1cYiL+nydxdDR18E4ST
	ro4VV4ECUTfgs7hvp1LRD+1GkSrKMxEXGHuCQq0x8XDMixa+V2HD7TuWhHNKdefmKHu8Hdng==
X-Google-Smtp-Source: AGHT+IEMjG+xYcQQQTXDj6szqHKzNz0Wj17GrdO0mEaASDNerRNiTqf6l8LOBEgHWNP6zgMDziFhrQ==
X-Received: by 2002:a05:6402:3456:b0:63c:1ea9:9ebf with SMTP id 4fb4d7f45d1cf-63e5eb4b5a6mr6471394a12.15.1761553595651;
        Mon, 27 Oct 2025 01:26:35 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f10f:3501:4457:58fa:e678:17cf? ([2001:9e8:f10f:3501:4457:58fa:e678:17cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb8e54sm5578618a12.25.2025.10.27.01.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:26:35 -0700 (PDT)
Message-ID: <a7b6b606-4b2c-4dcf-bd79-23711dd97b71@gmail.com>
Date: Mon, 27 Oct 2025 09:26:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] gpio: add gpio-line-mux driver
Content-Language: en-US
To: Peter Rosin <peda@axentia.se>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251026231754.2368904-1-jelonek.jonas@gmail.com>
 <20251026231754.2368904-3-jelonek.jonas@gmail.com>
 <bad968a4-37e6-655e-711f-c647becbba5a@axentia.se>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <bad968a4-37e6-655e-711f-c647becbba5a@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

On 27.10.25 08:51, Peter Rosin wrote:
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
> Consider using mux_control_select_delay() here, with some suitable
> delay, to allow the mux to settle before reading the gpio line.

Thanks, will fix this.
> This .set implementation is completely broken. It you want to
> set a gpio to outout high/low, you presumably want the gpio to
> stay that way for at least some period of time, while whatever
> else happens that relies on the gpio to be in that state. But in
> this case only the mux select/deselect is protecting that gpio
> state, which is bound to be inadequate for anything real.
>
> Sure, you can probably build something trivial and see that the
> gpio can be manipulated, but the second something else touches
> the mux, the intended state of an output gpio line is
> (potentially) clobbered.
>
> I notice that in your target application, the sfp driver, all
> uses of gpios via the mux are inputs. Input is a much easier
> problem. At least as long as you do not require IRQ, if you
> need IRQs you face similar problems where the mux needs to be
> locked in its position for whatever period of time you can
> expect IRQs.

Yes, that why I left IRQs out here, but somehow I didn't properly
transfer that I have similar issues with output functionality.

>
> TL;DR, this .set implementation needs to be removed, there is
> simply no reasonable way to implement a muxed gpio .set in a
> pure software driver. You need some hardware to preserve the
> state if/when the mux is manipulated.

I see, thanks for pointing it out! I'll drop this in the next iteration
then and make this driver input-only.

> Cheers,
> Peter
>

Best,
Jonas

