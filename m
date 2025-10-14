Return-Path: <linux-kernel+bounces-852626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FACBD97C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4309F189767D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA8313E06;
	Tue, 14 Oct 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HD+nY9Ki"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2131353E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446726; cv=none; b=YXarSdtP3VvoO15K1DouXHypwFPWSWEX+EwsUoUsL4MBliq/Osyow4fxuHruQWpWucQ6SjM9RLORB3ZiFQSs5cL7sWBVl068QPsBejn1WBJ27twJ+0MUKTv6dj34GK5xyaqmv9/y8qhEGLTVLljpNHCmnuxxEp4uWJwicMqoKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446726; c=relaxed/simple;
	bh=ERKaxZi856JIVKreXO7sribpAgoWkWL8cPcVypMRmHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MenBvHJ5egod0jwoWBrNmUdHN/pLKarATQ5eNo5ImT5C8WdzrTT0+pmYukdgiacD0kDj6OgGNZTvWcD8M745lxHYW80ktQpJteLPCY78OJj5qTkZnCUFoOpP8lG5JHiTx9RmYj+A4bEVseUmypRdUNWCWEs6+3pS7PqUdX8moW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HD+nY9Ki; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-635c9db8a16so5042148d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760446723; x=1761051523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERKaxZi856JIVKreXO7sribpAgoWkWL8cPcVypMRmHo=;
        b=HD+nY9Ki9ZCU+ZBbai3sK4TlP+Gj4PeD5IBvNbVgmRwrXEMP1rH1Kq7Wd2U4DC9ql2
         mmbSs/sedO+Z+pqNh178iwTUljJhUPXdoP+VQFu2ruyAZTpafom4Dgb3i9C7kLT30HMb
         nugdcECozBZLP8w6AumLU59dnaaYGy11Vk23pFabxvZWzNmDF8nOoZlM5WedT3ES7DKS
         D/cB7mXIddWy/q7Wje43ITkR6khfIHEjDiCwmec977cTp60w5mWUdbX6XXjhJUkrWeWO
         j4ESkWjq0mWBEgaoWoQnKZzyhE+qXTM8zA+qwVIdhoT3qqyvhnb1qjF3AFb5czRRY0iT
         BJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446723; x=1761051523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERKaxZi856JIVKreXO7sribpAgoWkWL8cPcVypMRmHo=;
        b=nFF5EXqmfkMtmC6ey6YRONS2XU75GnykmOp38717cYA8zbPK96tiQkksl9KE+Gi3ys
         2iErvbHPMgxCXSrO8+F1QogBBMu6G22fa9qNla4JIPrcMinwGZBWK6XEg9ZgItAPuXhz
         JxYVzZ8uGr7LEJHwyv8/rguGC2HmVBgYrR1EPoJQ4UJwdUVDUn/nZLt2nS6hpuZsIkFd
         T+XDYvhp2gNkfVupdRQqDIcYkDjY5jmbBOAhTmhnmpJEWzBy/zfNmQ3sbfrbhT+R3Dc8
         2O68Ki+DHD0TERa09TAUAbc4sY5q665otGp0rZ7xTxT8J2Hom/4H7PcsvvQ5xA96sH9d
         N+oA==
X-Forwarded-Encrypted: i=1; AJvYcCUWIruFLV8z5xSPSOHEYAQG3NKhJZDuHlDOQdEbSUfHwSLwNffiXYOcGG+I/I/tchRsb/0yllKSKqU/HTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsMRPzNxpaRpGJh6Wu8KM/wSeRDVsskfZM3x5mpKw9a9bgpCU
	46lfRxtijoR7+vS4O/4zNVc7EjYD9BSqPZrzvB7lAxq7iho0bWBmXjdr2sTp53PpAAXznlbUAd5
	CFzqOt+O0OXQ86NOyhjPKmDOc/sVWvZcEyfwjrLgs8g==
X-Gm-Gg: ASbGnctmH5nlx+TnuR/X3/6IKJ2d6fKk6rnSOfj5r4Nl/m4Vx2H7VtyYcZPOrLWs1+Q
	Em46dNDNzo1awidjhJIgfum7lKAsVVKnNuagnH3K8RknHmE3UnzAXPNyBoFhgb9f9STHKeWE9PF
	aTTd66Jot8P65T1AWxtTqDKG3lp1rI/R/yp+DTY85QcJvK259YV9m8QkWssVlt9w204DYmMapq8
	VTS0te5TcMYZYnlsTwO0uzxPtTtnw==
X-Google-Smtp-Source: AGHT+IG7Kofwx6n9tYMDxUa5Z04wJalhfP6YJEHLa4yTiQQEa2UVqFp3ownpK3FKUhmGBn3Yg5tzw6HGtBhEHg9/vxk=
X-Received: by 2002:a53:ba8d:0:b0:63d:24f9:5332 with SMTP id
 956f58d0204a3-63d24f953d8mr775113d50.55.1760446723523; Tue, 14 Oct 2025
 05:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <fe1f4a0947c864496f4eeec8eef806afcf6094a4.1759824376.git.mazziesaccount@gmail.com>
 <CACRpkdZnoMvYBXN7b6dw+uPs=f1WXr9wX-0VF1c1qd-rq+17LQ@mail.gmail.com> <cac4222e-1f66-40e1-abf8-7d4661d43bbf@gmail.com>
In-Reply-To: <cac4222e-1f66-40e1-abf8-7d4661d43bbf@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 14:58:28 +0200
X-Gm-Features: AS18NWAzYGkVtZF2eWYQ8i62TI7iWUixyj6KHyQnG8bjFDuI6exLbunxibrSSZs
Message-ID: <CACRpkdbOKNPFxNJM-r+HdnfKYisWJrQXvG21EL9w4UQVP74D5A@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] dt-bindings: mfd: ROHM BD72720
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:11=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> > These are a bit idiomatic, not using the actual framework for such
> > things (pin control) BUT: they are on the other hand crystal
> > clear for an integrator working with this device tree, and only
> > four pins so why over-engineer it. I am fine
> > with them if the DT people are.
>
> I kind of like to emphasize the fact that this is not really a pin-mux
> in a traditional sense. We can't change the routing after OTP is
> written. As such, it more resembles "wiring" of the signal inside the
> PMIC, and this property is not a control but tells us how the signal is
> wired. But yeah, let's see what others think of it.

Just that the muxing is controlled by OTP and not by runtime
software doesn't make it not pinmux. It is, because it is
(one time) PROGRAMMED to a certain purpose. In a factory,
nevertheless.

But the pin control muxing subsystem is designed for muxing
that is controlled by software at runtime, and as such, indeed
not a good fit.

Let's go with this!

Yours,
Linus Walleij

