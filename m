Return-Path: <linux-kernel+bounces-857035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BBBE5B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECEDE4F626C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4842E1F16;
	Thu, 16 Oct 2025 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9+6M9ah"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF02D47EA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760654496; cv=none; b=thaZmJR5A1FPFeBlDrjGDKcdtjONIcRTEa19BSoRIEtE5VuOZ3TQZ6uSdRz8YOc0xNmM3y6nLiYtJQb3Ghnm2pxqhMoYNZCnzuin8HQzZ9VDiB/0phxo+qevxmLMj119IE45FXPtaz6wDxvZsl/+Kn1H7wejHs5McZ1aXFF9pwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760654496; c=relaxed/simple;
	bh=aMIxLZM/6U/tLtbB22xRRXB39dw+qCRALwooxcdMsi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNk/D8iC8l50oG7MoCF+uIyFir995W7auCL3nPlNNq+Vg+MHqd1mPHybN5Flq0QX9CffqkOH/VnGdCW7snRRNUoinmQUSsBEzlXOQnzejOGpwL/tLaFPPNmVruaMcO4rzOoLrFjuzEZtomqaGssFBpi54uy5/Grd5HPekrLcjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9+6M9ah; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-376466f1280so11194291fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760654493; x=1761259293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMIxLZM/6U/tLtbB22xRRXB39dw+qCRALwooxcdMsi8=;
        b=a9+6M9ahKo1+CjWD7/s7qjkL1rdPbze2hysdRpm6Yl+YAhDdxRCo+3GHSbZjtWZd/1
         fmEJoQa/i+LE7lvtv9ZUJ67bXX3+oLCFz94Uez+vaLRgVvgJosOy7gZ4Ze1G6obp3w4w
         BKnkNjXgK56LNxe+Ip7GSgfwBd5yqtWfdIRJuZzSPb0IzDsUofNc06vidRN61++PJ8lf
         HF00/iyXeLOT8LIQBerf5xCM67meAu1mKETNaQeLlytP1tI28RAXIwcjdh++uwzFNyAr
         UJxzrz7U89uRxdmerLBVamPO9O3qzPSojCWg09IoP50oxCftJ0cqE+/C78hf9lGq+M47
         EbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760654493; x=1761259293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMIxLZM/6U/tLtbB22xRRXB39dw+qCRALwooxcdMsi8=;
        b=mcF+spaSMLQZ3FS+YwCwYnq+7anRT+ydGFhev8AlrZykmiAdb7n4sb+I8RRKIDEwET
         RPILaX5+q3R8SzL3znA0QESB484y4kBvQSNXIke9RMhJiJ+QzEZfoDD1MhoToL9yOFrq
         v63lhLA6+UcFI+suj5KZEHzzStI8Mzal6tIZVlL1cVjWgmwoqrkjM4zt7kd9mJvaid+/
         3FjdGr9KirJhTK1oM5ph0G9V3ape3B47WY2uZV7E9NOz3/KCt5ORFVzqC3bYOu8WsElh
         eHqvkydxwjT4zFu/gMV4wE/ukMY1sKz5S8ewKQlTJEFzWFSoGneOHOPLSebq4rijqEVz
         J6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVgOy8uVEGqV00MAw+q1HGuw6EjBW7cciYlLhNVRJHLOfo2Le2KX2dQuoMJw9U/IagQmi59sdQUQedlsL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOPxsUdYXgBb83RZZzS+brScnf5mmx0Yu91CEt4vr61cdUNWA
	XI/5lglJJetwqpAZSrMiDn0RCnAeRRgmUAdUvlazhQ6h2fw+vr9qch112BXM39HjRw2R6XApeYO
	y+lRvkkor3+oZovzzbaw3w2PIfBPhOlSJcK4NV0V6sg==
X-Gm-Gg: ASbGncuFjY0S0w1N3xrQKjzXKQj3kMMXwl8K9HSCKYsnrzIvaRTiLxGcKI7Dat78f4x
	vRuLsgLE1A312+JeX9U1rvV0hlCO9iX9DZS1gKh/B2VOv9beOSu18VyNK3ZFYoJ/UFKm12oV1Dk
	+LDedxxk5I7PzkEwsjgV6Y8ZUQLfB9VVEgF49fX4d5gUFo6ilusMTIcwE/Py71hIxCaBS5VVlGH
	pf9ovDobfIkWM4OfNMohxWGVouOSGI7rDpEyX6XyfaQ8wJNUaqsbSU9ifOp
X-Google-Smtp-Source: AGHT+IGgJO7Zemo+LpoVZasQFrmgPrpk7XQQVTw1/TLYvKF3dmLuG/UrVSSNariPEoGP40bDmIuuuFjLjUnIT++2s6Q=
X-Received: by 2002:a05:651c:211c:b0:365:6b40:8656 with SMTP id
 38308e7fff4ca-37797948f9bmr5445311fa.35.1760654492708; Thu, 16 Oct 2025
 15:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014140451.1009969-1-antonio.borneo@foss.st.com>
 <20251014140451.1009969-3-antonio.borneo@foss.st.com> <20251014-barbecue-crewman-717fe614daa6@spud>
 <CACRpkdZT20cdH+G6Gjw8PopAkir+gGgMtRR4pkjnXFrmDkdfog@mail.gmail.com> <c2a0f301-ec5e-42d7-9df9-09a852a199ad@lunn.ch>
In-Reply-To: <c2a0f301-ec5e-42d7-9df9-09a852a199ad@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Oct 2025 00:41:21 +0200
X-Gm-Features: AS18NWCfvCVaxN-I2xhCPM2ryQoUWNo2dnNVl4LEycz99TO_NsvVsr2xAwj_RzE
Message-ID: <CACRpkdZX_KJ-G_teTBTwjm_KNmTa5iX4n==yovixvKTOBqqSXw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: pincfg-node: Add properties 'skew-delay-{in,out}put'
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > I don't recall the reason for this way of defining things, but one reas=
on
> > could be that the skew-delay incurred by two inverters is very
> > dependent on the production node of the silicon, and can be
> > nanoseconds or picoseconds, these days mostly picoseconds.
> > Example: Documentation/devicetree/bindings/net/adi,adin.yaml
>
>
> I'm missing the big picture here, and i don't see an example of these
> properties being used. However, since you reference an old networking
> example, for RGMII delays....
>
> adi,rx-internal-delay-ps should be deprecated, we now have the generic
> rx-internal-delay-ps. The point about using -ps is however still
> valid.
>
> However, i would not like to see pinctl DT properties used in place of
> rx-internal-delay-ps. How the Ethernet MAC driver implements
> rx-internal-delay-ps is left open, so calling a pinctl API to set the
> skew is fine by me. And if the real use case has nothing to do with
> networking, then i don't care.

The scope here is to describe skewing the timing of any line
connected to a pin, no matter the purpose. Could be an MMC
card for example, or something else, but the point is that
the control registers are general and inside the SoC perimeter,
i.e. around the pins, not necessarily related to any specific
hardware block.

But I guess it could be used for a line used by some ethernet
interface.

But the config here happens on the pin controller, so a specific
hardware block distinct from e.g. an MMC controller or Ethernet
MAC, the latter just have their lines routed through it.

The pin controller will handle some pin named "TX", which is
just a string, a pin controller does not know what this means,
if it is a UART TX or a MAC TX but it can configure the skew
delay of the pin named like so.

Yours,
Linus Walleij

