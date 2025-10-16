Return-Path: <linux-kernel+bounces-856487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D322DBE447A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06E0E4F607A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FF34DCCF;
	Thu, 16 Oct 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJzK1g4v"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC634AB05
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629045; cv=none; b=AR7N/OPj62Nq3TqrTwm0m4ga/JOaar75Zpy2u7Denwe0zQfeNDDnjy8DkiiWFTyE1PvxPKFhxy9rIrTs9uFUMGCNTDbw/8cLDh2NlYvB5tCNqw036Q9+bXfgL474L1ymHN+UnNjzZ6nTV6AS4/82t4UK0k0nD7HdHVlRq5ZNhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629045; c=relaxed/simple;
	bh=IQFwym3P9+Nw3XQ9AhLnb0cLG2B7kYyMSV3AcTLlS5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhSZ/VXcGdho0Fdp3aT6NdxfiiPNqSep5tpJfRhwiurkOykV1wBDc7a1aeXEy9cU/DeKQI3C0KQpPPypcXNUAf/kMsLnFRle1xnohzOGiPJ+S0PX9VdIWdGAcR72RP1e6WHks24JfVjzyw49gvQAC7DZTYz15eC9MBNW0FCDyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJzK1g4v; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63babfdb52cso1507029a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629041; x=1761233841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lt9AoG+5Ci07Qvd8dFqmwNsNmi0V9J5hOKNJ8ADlmH8=;
        b=cJzK1g4vWJMSH6IKrpfA/tmiEZjJfecLXtzULXUvJInL31UJk6WbXsGrMXScK0PTVV
         ikQb1tmC+mhmYbsZ6EDxLDDjDqdWkbbRfDw/Ruj32KQMOapwC92EANi4imxIVN9coYnW
         gf08bIWYfyFm8rfDml8cp9B1pEYEVtWEsW0SaDYkdK2ASrysKUEYDbP8yeffHutCKns4
         iFI9fcLIUB/vfmA6jP2el2YaDuAIdE2rR+PTg6FJzDdqStNbznBsPriVfWroqMh+cyML
         UEBJB8HHYQu4Iu7FHiHUkCDg7P9+2I9gEFaL/DqKCF1Re4MAsSm+WE/C3EINBUdXiLO/
         42nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629041; x=1761233841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt9AoG+5Ci07Qvd8dFqmwNsNmi0V9J5hOKNJ8ADlmH8=;
        b=iAl460yoyk8XI/ZsaJMXIaUQqVgUftsL1YC4V60+z7yxjd4NZPBrWNxT3VaGG1I9MM
         yNKyK1wxWeK45TOzDrxqj1sW1ClwoPGKEGTMzIj/Ift6VX0uh0DvMH//S+6Nb9/+P4SL
         wHUTorDTR9QJgKz/c3dW1VEuWDnGrxBAPWPiLFOe6itKHfVvnacanvW4bBE8l1CRsMK3
         6rPKTIEggE7mGalkY1j5Oouy2Pc9bcL/K+au798JP5/vB/GDg4hh0+sBbHSNhfsLSSrm
         pwLbqtVuWLsX1KVdig52RlGzIRMdi/LCh4T7F9iMj/ygdO4Lp0PnHY5Te8ii5foMgI6A
         6jPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOG1f0tFTPg0WPhE21e8eEBDYRBSy1EHVInhsKUWcONpw3fAcmwO5zqtbMbv2D9QjULEN7VCn2Xkmy6gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCpqq3ZmFuR5EMNpoFwxvJEIUgHbPo1eim6hYBpZO50/mbnfz
	O9zQYr+F0x1TYkoRbveoKEQUl1J+AwE32x79EVNemPEfay4T8RekTZHt
X-Gm-Gg: ASbGnctKTxOyBIjeq66J7fbcHUTmf18UxSlfGozOwb0FhY1dFEgoa2NaqdsmDASylEi
	hrwAOs02K795azYqNkWagWqmyP8orQMcU3ig80Q6gXgcqZGoDnwWI3lbS+EZMZTK9+0Mdvr1kGB
	wMOC4Gp1j2zMV3u9bH4CSJf6GQIzAax9XsURx4of71aLpVTkC15KIA4GmtcT/8oVm3LT5wgCtFy
	FCYOmYq4dhuElmx86tjnKD4S7d19QlS46kU1vmqXJ9LCqg4gIdN2Qv1qWOga4EIm/P3/3kMEXuK
	oeG6jJzvAMzdtqG96Ckw4oUyWmyHYO5nb/mV6aX3bieECy+yFTe8b+xDwmaMGs9ljuE11cIvtRa
	I/lcIOp4G68hHWlUg7OJYG1f9Rc/dt3h8tlNNHANHS8NJOG855LTmh6fb6LMX5y/4HN/b5MFwyr
	EVkez1tNg9F03gJxLjAzIbY6sFHidqDBVJL1WOOL0FYCdjSVmIYhQuIhEnWFGkQoIbbP3xrsLp0
	j0Ou3C39rc=
X-Google-Smtp-Source: AGHT+IH5rChTcQ8KMfdTwyelHm2o0px+idB9KuE6OvaeLt94wXIWXpeWcF/P5s/Pb2bnDPg7YRkZog==
X-Received: by 2002:a17:907:2d06:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b64769cd245mr34400266b.64.1760629040911;
        Thu, 16 Oct 2025 08:37:20 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f10a:ad01:ad7e:4d4c:7985:153? ([2001:9e8:f10a:ad01:ad7e:4d4c:7985:153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb9e7a23dsm554836166b.23.2025.10.16.08.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:37:20 -0700 (PDT)
Message-ID: <22a84772-0e54-4b99-9bc7-59e7e4633807@gmail.com>
Date: Thu, 16 Oct 2025 17:37:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] gpio: add gpio-split driver
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009223501.570949-1-jelonek.jonas@gmail.com>
 <20251009223501.570949-3-jelonek.jonas@gmail.com>
 <CACRpkdbCw1Agnsy-aYPs+2PhQDFjj+=VjmGQBmxuCUfwRuWkfw@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CACRpkdbCw1Agnsy-aYPs+2PhQDFjj+=VjmGQBmxuCUfwRuWkfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

On 14.10.25 10:37, Linus Walleij wrote:
> This can be made easier these days, reusing the
> forwarder library. I think! Check if I'm right.

I think this doesn't really simplify things her. As far as I can see the
GPIO forwarder is more targeted toward 1-to-1 scenarios, requiring some
(or even more?) "hackery" to fit to my 1-to-many.

> This part is maybe the most interesting:
>
>         fwd = devm_gpiochip_fwd_alloc(dev, pctrl->pctrl_data->ngpio);
>
> Here ngpio will be 1 for your usecase.

Giving ngpio=1 here makes the gpiochip only provide a single gpio. This then
needs to be the number of GPIOs defined in the DT (number of child nodes).
But in this case, the internal 'descs' is allocated accordingly and there's a
1-to-1-mapping between the external offset and internal offset. To solve this
I would have to add the same descriptor for the shared gpio multiple times.
Not sure if this is a good idea.

>> +++ b/drivers/gpio/gpio-split.c
> As mentioned I would call this gpio-line-mux.c

Sure, will be changed.

> Yours,
> Linus Walleij

Best,
Jonas

