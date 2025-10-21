Return-Path: <linux-kernel+bounces-862297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B456BF4EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E04F7022
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC927281C;
	Tue, 21 Oct 2025 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNiqkTOE"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257B22156F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031145; cv=none; b=mmgudvn3k0Pez7+TnU4DVBNEzMR0TJ+sGEmk1Qo+L0ZFTLycrKQkp12PfniajCD7QTw1PphA76RwmHmX0pzpANWP6eoGI5pyu9lpMJcQerEPfyZw9yLIwKmqah14XsUfI5R3SN0BRcs6jBCyrKNbNIuMrfXe3INdxJQILE9RrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031145; c=relaxed/simple;
	bh=TPytR/oh6ERL16e9/CIiX6YLokDAnd3+ZVvWKR8z9Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/UZlwk3MbvPVDNmXqP+ZikUcf8sniJuQ0KHH1thgd3sYag72UCSYCEs+xY9pzGXAaJGl/Ije+5TG/+oOBPGib8yCwbNt4+598Y0gsMP3YQt4+sn6o17ASI+LGmmdeNOerRHsbUREtTwCDuWbhHgGUjaSYqdObIGWwN5abeddNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNiqkTOE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3717780ea70so57648841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761031141; x=1761635941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPytR/oh6ERL16e9/CIiX6YLokDAnd3+ZVvWKR8z9Ug=;
        b=rNiqkTOEE2wr8pfFYWxEaambhqBtYh3BqPl1yvuPB1LSzEWGmhApEoCb2pMdG9iIGj
         ZglZGFd15rW7it3OZw/Jbs5j7OOL1IdlNqGO3SW4wWg/m/rYudY+4j4SY1p9P22rkheP
         KnfC2YEjfbdA0zu+gDzmW14NmawK3TdO+jgziS4hbhp0fw6ZUV9NB17HwY0vAy3jvZYe
         +WlRGNpRAcqiXUtMr3vFl718Y1yX2rk3ZCE8olN8c1rzWZWnS0pf/rJdAoz1DmDidWAM
         iM5YJXGlY7DRhMiUb8jzYpav9mjn+vwm+iCTE7TfFWKYZAAAk4+JOETCoFwK8DCeWSOR
         NBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031141; x=1761635941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPytR/oh6ERL16e9/CIiX6YLokDAnd3+ZVvWKR8z9Ug=;
        b=Fcz0gwoZsfmGbJAzXyt3ll8p9cGFmb599FYL97G8JHLU1JZdGR508SHhL5COFWdzQF
         zYDdFcxszURKr3if2WVGY2MNh1OVKrvlfPW4ofEkRaW2SEEf3VrsDJC1YDDqgAydiE//
         hFny4Qg88c1+msPumByL3iSLXek0Bou/n1l8vK/yHYscyvhgXRk7zCoA8BerZIPHoSDT
         bBRPagCufWYBD0OVJQ2Zf809XIT+PtcnJ03tbKAK5bR48nNVhZezZxRKv8dKMFZNS6Cp
         TDpxzxCAaHTAQ2dT+X9zqD9L/SjWKAsgY7Df0RiQ0nNtJEwbG53BL24uUelwlnOWQi+9
         C3zA==
X-Forwarded-Encrypted: i=1; AJvYcCUCWyyXofcZPRuw41vZmJDlEv9OeUMCOlLouxFUYBHVzbAv954OiLuaal3oNvv1lPQJNXEF1yjKHapD45s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9L1VAmXacD5BM6i3aydyMHqikF7YLc7uv1KeaMXy3ShVlpFg
	HSvI0OJ4mCBu0e6DYQsFWzFMz5nKZSIw5A9W7z6HU1asDF8ABPacbwHicXEzcLMVIrGvRzgx2Eu
	bolZtxvGfDkd+bsEuz7OagRdjqiwjOdIoieq0QUKqlA==
X-Gm-Gg: ASbGncuT4wT2m2x4Ii6WX4hYZj4rQzoh8FbZLz+xPx56dN7wgvf7kqo4ptC++0dOcM/
	M0/1AOwtmgw5nuLg0q5xDVtx22FA9tugu8cRrPDsTLzhqC2CPx7c+Q1xbAtZKRrfS8er3IWLCkg
	k2Ledpe8n+xV5Ffwuv+lnZRv8J34vMABw9tVmKJToEHtzQJohMhSUqbNU9fP4n9hqsCUY4+MB+4
	n2TjRekI25czfAW16Lye5aTL64xRG+iwCYsAsX3lQ29cD84zyf9CpRY4bBk
X-Google-Smtp-Source: AGHT+IHb0RcnFdyK3FEcqMExpVgW1RnfxelPLl+VNCZ83YgYRm+qQ4EwiVuw7VnhH+G1ZGS+9xMxXTLRxCadOJ89KJs=
X-Received: by 2002:a05:651c:150d:b0:35f:73ba:e758 with SMTP id
 38308e7fff4ca-3779781655fmr61252801fa.1.1761031141518; Tue, 21 Oct 2025
 00:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020115636.55417-1-sander@svanheule.net> <20251020115636.55417-3-sander@svanheule.net>
In-Reply-To: <20251020115636.55417-3-sander@svanheule.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 21 Oct 2025 09:18:50 +0200
X-Gm-Features: AS18NWBZyaqA8OKAlBvNyovq2S3rJ2ezmux_KHn7yd_S_2jjXzxCSZ8a2vy0_b0
Message-ID: <CACRpkdaqXzogkbcnR3uaDeGFcVtwmUq5DbETSqzjVQECJROF7g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] gpio: regmap: Bypass cache for aliased outputs
To: Sander Vanheule <sander@svanheule.net>
Cc: Michael Walle <mwalle@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:56=E2=80=AFPM Sander Vanheule <sander@svanheule.n=
et> wrote:

> GPIO chips often have data input and output registers aliased to the
> same offset. The output register is non-valitile and could in theory be
> cached. The input register however is volatile by nature and hence
> should not be cached, resulting in different requirements for reads and
> writes.
>
> The generic gpiochip implementation stores a shadow value of the pin
> output data, which is updated and written to hardware on output data
> changes. Pin input values are always obtained by reading the aliased
> data register from hardware.
>
> For gpio-regmap the output data could be in multiple registers, but we
> can use the regmap cache support to shadow the output values by marking
> the data registers as non-volatile. By using regmap_read_bypassed() we
> can still treat the input values as volatile, irrespective of the regmap
> config. This ensures proper functioning of writing the output register
> with regmap_write_bits(), which will then use and update the cache only
> on data writes, gaining some performance from the cached output values.
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

That looks good to me for sure!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

