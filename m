Return-Path: <linux-kernel+bounces-876322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F6BC1B91F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A90463F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6B1EB9E3;
	Wed, 29 Oct 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD9m+TSD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4427262E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747204; cv=none; b=JRhgVaCPx349cihsDxG5zy1WGpZpO1zD7oAOBJzIshEHRtsp6KPFvsBBcCkxmRcn/1vhqx5RETn9Ko0MM0I2Kqf1SX+MZCawvIpSEjAA9EXU7deJFt8XrOFW6IkG9FskV6weQHrmDTT2iQvEFK2E+1Er86jSN5TkqO8D8B8/94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747204; c=relaxed/simple;
	bh=fprySnGFG5CPJcDu1tJYNwz1wUtSQ1AJO2YyUJxgZhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxiTpSsjRmTQUhq+3P4HvHLIo7y8jSyp33VkCh6TlOZkLHmxYK24dGUVIO/NhirvZCcoFYkcAHzaepbzasB6Ii1IxkuDf+8iA0tzVzLvTQ/CtYIdBi9y+ocH49pUAYNDNVhFBhotUZ9icEeCVHB+1objx+FGcpj37JuEhO+tl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GD9m+TSD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso1636923e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761747200; x=1762352000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4v0cJRmSCnSgMMu1WdLtnYLEr1pOeV1u124uY+kAGI=;
        b=GD9m+TSDPzXzwAb4Qph25O27mF53/U1R/K5BP4I7pZ8Nn9fyEAPIoBO2ppcatb6Ns5
         xULHcJXJvPsRm0ro9FNzQ9x8wz0kOQp1v+zwRqzVBhtl7B/9R3QULpWE3/J+n9F1OAeX
         iTQKGIOEUXMOca95IO7drBg+wK9PY8mSaweWvkhsMOxAWQsoUizml6KUreYjLsvptPr/
         OPDbjUvhmr03fJw/jwY2XYqz3Y+tMhK76M2ElA3Esa1IVK14MlRyFhe8YsgRFfNjwn/u
         LfBAVVziy4FbWTQPXcrkHdprYzepgcMxG5RhFivqqHEi/9hrxChhrWKg+tgFoMsBLU8Y
         rNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747200; x=1762352000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4v0cJRmSCnSgMMu1WdLtnYLEr1pOeV1u124uY+kAGI=;
        b=XhdGUXTe+vxGLggUatX9Tgz6a1Wet2nlFtUKLE4TJ5yIHeyX29CdbMQEDqr9hmj9Vs
         6uJ0fzZFgCKSchWqwQgVK75uJYm96ENmA0rSN4I+qt99O8xTJG8TLC+MlzY0AV/Xm/P2
         bH4UiJ+uE+uemY8xnjo4nhpOM0rrWT0V8gYRpT2nq/kDQ8m8ugzuOxJxzYqHAUEbI3fd
         Tl2nDgD9FxX58j2xUV/kSDRwNUOgIv9NUGiQOeTJzP8tlkqQ3TEWgwVJ6JKBNx/SVTz7
         fy9SOYuOYKo15vUMVa+awpo4OJbkPrpzpAOorTq6SG6jVA+P9cgiFarAeXACkyCYPAEs
         /zCA==
X-Forwarded-Encrypted: i=1; AJvYcCXGNKn8REk9KWzWha1vxK6Q5cFFoK3WfO+md4TeKye+0EiYRbQHn/UyFBipIKQQkIQs0axaQckjk2Xq4Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4e0yTZGoUsgi1qR44hisxUWvtVJtCZ/rOO14ywoj/ilAxw/5
	QWnJIsaGvHY+TVwma1+81zPs4SCPKy6BWqEMmbicbuucNHhSF/J1mR+RJvJTc2CxwQJyCvQTUoZ
	BzOa2so0J6BGdC0DBVCiEub9jDkXHOkgK0JCHFxL3rw==
X-Gm-Gg: ASbGnctX1Y28OUnjWFks3TVu/igh/sjKbmEP8B4auq6LNjXArXMXZ2jvnFAPm7v/vcM
	5F7iO6v5EnxdKaTWc1nX+zHXfWujeMZs3QI1M8stgN8KK1i9XHs6C/K6PisS2yNHu7ky3nxWwiL
	9mDVxk/PLyOyyg3dJ65bYMHFdABDD0LvWMn/SbGybjMS20VgQExRlrWVIuvtDYHuzri5nl2jurl
	9b3cD6iGajL1FhYGW7Tfx7mVFMbRLnyuBV0X5zTr44CXruI1dejeqQTZT1pdPgHeWCWYkk=
X-Google-Smtp-Source: AGHT+IGFvyOOIZISMRY/ZCAuIO7S1nmZlWQtEjRjxLEx8BDnt7A+8Sw76smNCHKXXeWzoMh/qrLJz/WWz20lOINjxhk=
X-Received: by 2002:a05:6512:1194:b0:57a:8eb7:1ea2 with SMTP id
 2adb3069b0e04-59412cc6575mr976030e87.27.1761747199742; Wed, 29 Oct 2025
 07:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027104746.282351-1-bigunclemax@gmail.com>
 <aP9cSArwCdvPZff3@smile.fi.intel.com> <CALHCpMjy=J7PNuDBPGOWzf35pmTAzw846DabGuHjN8nn3CftCA@mail.gmail.com>
In-Reply-To: <CALHCpMjy=J7PNuDBPGOWzf35pmTAzw846DabGuHjN8nn3CftCA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 15:13:08 +0100
X-Gm-Features: AWmQ_bme3lzZeAedX0mxAYZZgObVCGCm0Re2pV_I9K4FbHXpwbD7OrxP25GnG0U
Message-ID: <CACRpkdZ8hoqk2UT4=ZWLn01Zw03nbz57vKMwRKU9quNEPzejbw@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: mcp23s08: init reg_defaults from HW at probe
 and switch cache type
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	akaessens@gmail.com, arturas.moskvinas@gmail.com, e.shatokhin@yadro.com, 
	linux-kernel@vger.kernel.org, mastichi@gmail.com, mike.looijmans@topic.nl, 
	radim.pavlik@tbs-biometrics.com, u.kleine-koenig@pengutronix.de, 
	zou_wei@huawei.com, Sander Vanheule <sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:04=E2=80=AFPM Maxim Kiselev <bigunclemax@gmail.co=
m> wrote:

> Changelog:
> v3:
>  - changed cache type from REGCACHE_FLAT to REGCACHE_MAPLE
>  - added .num_reg_defaults_raw to init regs cache from HW at probe
>
> v2:
>  - rollback v1 changes
>  - dropped .reg_defaults of mcp23x regmaps
>  - dropped reset all pins to input at probe (commit 3ede3f8b4b4b)

It'd be great if I could get some ACKs/R-Bs and/or Tested-by:s on
this patch.

Is this fixes (for-v6.18) material or is v6.19 fine?

I'm good with putting it in queue for v6.19 but for fixes I would
really like a few tested-by:s given how widely this driver is used.

Yours,
Linus Walleij

