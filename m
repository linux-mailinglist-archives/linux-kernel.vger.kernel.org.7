Return-Path: <linux-kernel+bounces-742371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EABB0F0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1DE188B4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311912D9EC8;
	Wed, 23 Jul 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4UJfqe+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD32E11BA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268931; cv=none; b=uY89rLPR6A96LppoOMZfi4oFibsuhKLX39Es/o3olwA2ZMNb53eviyVlWQp8UjVydJKSGqbbAntaAs0Ae6Dd0JAo/zSZmRtj4/M4w3y++9geImCL7pq/6tPQLGJcA+SR+40NWKYgGpOMTH/M6Jz2c/yM/cRYMraNhjlfghC0zfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268931; c=relaxed/simple;
	bh=3B0D+GxZIdTFezM7wUdeHc2Z7x4Bz95ATZb5mHcRHNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWGg4nAY2h/t99TzXfpb3iIrEqSPEsQpD9HqDIxBz1c6UJuRVmNhSzrt1corWGztO/bmHv4nppWn13DH9xmGm0Eir76QYWPlj2phq/pNGdNBaJEL4inWzhDoK2FjH7FCZgOzH2aojuBn954UsYmvtaFU9ApIv91AiA+YbyMWxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4UJfqe+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-558facbc19cso5425378e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753268928; x=1753873728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B0D+GxZIdTFezM7wUdeHc2Z7x4Bz95ATZb5mHcRHNs=;
        b=O4UJfqe+a1uRJFOXYrDAfuQgdI3nruGymy2J58oYxaAIvgXRTPnWm6NGiDYJFUdK1n
         3xrS76FPfUfK8BHVVfS15hKXkVB/J/xh9354WQQXu+70RX6odvPSeEUhT1AsADkzuP5I
         kdyXiqtxzomhvnTxl3yZyaN5X6sSAPo52+QHDOwRjHjhZ8iSxJtT8mWdJdVsD8zWt/H1
         tecHpGmhygnVsY0QgqgAWGgYijcdJ9k3Nv6NHM0bDCmcwoHySagHnVTle3m7WZDslhkH
         p3e8gBcizrZWvAFx41f50XVsUBPi7vstLpUApiNZNRh/2JYSxzaaSwBiM55RhbA6WQA0
         PpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753268928; x=1753873728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B0D+GxZIdTFezM7wUdeHc2Z7x4Bz95ATZb5mHcRHNs=;
        b=PyiwxKHPeKsR64XfX7b3EpvuIigfO2WguL3fz9uJHE8ntrLca/o8SIvdUMJmGVxxnZ
         nSzPRUALo5JiLDfi8Bbke52v279t16YP9OlvIFtPA768iU1u7kCwV/GyvAq4yp+BFRbF
         dEIsK1s+0rFTAaTU+8lhC82Edrmd2je/7NQsd00VwLcp1EXG2AEt8Hy/dZNU6cZEDNVg
         1I1Qy6e4YaAWGswqlOzSCFxfUD8B8l47Wa1dKfcznXfR0v0N/6A/RWAufIEsEh2KL7Dq
         9pyFwMRXi3/omqQPobivMWXy9cSgePYRKXcInuj7BbEQBaRfKw3I+UI80hqw8mzhJ9QY
         bspw==
X-Forwarded-Encrypted: i=1; AJvYcCXTDFWyuF9P5pZfKSlCX1AdwBAzPa4VUrcfr+KkvGyjJMQ1rzMM00w5pc56Hv90UI+WvHHFblrKB8KD9OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWfr/5iIHRFzm3Ptou5cPeQYx7eWJa3UJdoLRZFxLoqVsrxS4
	1GT7cGzMy8R4yEbu+JCTCX4RJGpaW4yiSi+UXbn5JQQEj0iUANeZMI1HqwKtq8RqdKqSwYUuAJT
	C0E2l3Nolfl3j4wNdwvROerr+GlPsgavNgrX3zymwcg==
X-Gm-Gg: ASbGnctXaEQUXMKhPiG4fPml0lUt3+AkB69HdWkEa133g/o7Nrz1++F3wFmE9YMGck4
	cfipueY+bE1JulsD71IXX7kwLJ6qoModaiuaWvG19RH3jnn8B7EUC0B5yALvxKPDVd/Q2Rt3tNB
	qbDcwBNO5SlZvbbSz1IK+IgpcrLT8iv93kTSLB9lEF5cf0B+SxbcSStx6l9w+aDVyR/EKjaYBaK
	+kF+J0=
X-Google-Smtp-Source: AGHT+IFKArCYdHOkQCTFcXAgfJ76l45O02eVn107esIDRp4PDEtys19CbwegoUBC08sGUKe6rDVxbL8pTwqzpc2cdT8=
X-Received: by 2002:a05:6512:39d5:b0:553:2e59:a104 with SMTP id
 2adb3069b0e04-55a513e983emr851506e87.37.1753268927568; Wed, 23 Jul 2025
 04:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-tegra186-pinctrl-v2-0-502d41f3eedd@gmail.com>
 <20250608-tegra186-pinctrl-v2-2-502d41f3eedd@gmail.com> <yw2uglyxxx22d3lwyezy34wdniouu32zppfgwqs5omny3ge5zd@iuqo4qmi55a2>
 <CACRpkdZha_ucjWvP_NQ+z2vbD65Y3u7Q0U57NYbJ=vqQ6uPGGA@mail.gmail.com>
 <yslfabklduaybg255d3ulaxmzpghyj54zdfeqkx3oxgisxf6fo@2wecuqpvvefc>
 <CALHNRZ8jq++KVKxKP2-GwMA6CauP=cM2_wt==MRAV4mOzK2kxw@mail.gmail.com>
 <xc72g7j7png443pjxu2wpsuqofgrpxvn43emkt3rv5qrjzf7vt@qzvsiy3eakub> <CALHNRZ928+=85FbvfKt1c4VX7RudU7ehuOa6wwLj8JJNz+=W-A@mail.gmail.com>
In-Reply-To: <CALHNRZ928+=85FbvfKt1c4VX7RudU7ehuOa6wwLj8JJNz+=W-A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:08:35 +0200
X-Gm-Features: Ac12FXyYD0AJUEr7X9CzcjA1Pj4U-nYzctmGPS86PrlZzjvsb6lrpBvI2Km-UA0
Message-ID: <CACRpkdbLzAJS=iqgOEzE9kD-fM9tx22JTDPgQeLwbTFKiStrtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pinctrl: tegra: Add Tegra186 pinmux driver
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:45=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com>=
 wrote:

> I started looking at the pinmux scripts a few days ago, but updating
> the pinmux driver import/export for the t194 style spiderwebbed out of
> control quickly. I expected it to be hairy, but that was an
> underestimation. Doesn't help that I'm not the most proficient at
> python either. I'll continue the effort later, but if someone with
> more familiarity wants to try, it might be quicker.

If this means people with 186 dev boards cannot use mainline
Linux and they would if this driver was applied, maybe we need
to apply it anyways?

Yours,
Linus Walleij

