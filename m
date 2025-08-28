Return-Path: <linux-kernel+bounces-790528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334ADB3A9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29DA3AA2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34C26FD86;
	Thu, 28 Aug 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sV3S9goY"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20F216E1B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405162; cv=none; b=QUxzX24ExdWspaOzHEcIl8/p6DCGAsIDU4aQQdHcX700Cdley2CmjVYl63nN7dbRLxKEYV9Z0iYsBCFKHgeGbDFT3OUMyC6pYimh9Ag5wi5Baj8Jv6/Q9QtSkYWOZRmfpEs81ZD0c90o5I0O4b9MVG86QHO4ChwqLmDgVu6iR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405162; c=relaxed/simple;
	bh=jSRAPGlaacLCN8IweNZh4ovq/ER2fHwcytIyHUy6LpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0vqWbbg5u9CNQ0LLm/Vz8+chVLI4PeCnk308C3mnUSVNS9R+dR01MqdlOKW8FZUlrAphUNxa7JZ3PxnTr/Sg4bChZxVkklr3CoFPUeKLuzQo1AuKDUwyHigSMMEbnGZoINd9Vxr/vMdB5MCAmFPi+Hxnv/Fon9RVcfELnzaqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sV3S9goY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3366f102680so10805851fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756405158; x=1757009958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8WCzP5XruJZcY+aCROX20DDrThlC8LXbUjIf1UiM2s=;
        b=sV3S9goY3NPAf5ctpK7jz0PvMJ5CZF+mdIgh/lZbNZTdmuxyIjxQWmKkd6mH2z48bh
         8t4LlF2hKGblupZPWyhKD5ZB00sDHXHWvLkt5kT1IODEB4wBC4mOThflyKB0SRQhjquQ
         JO9iwRWImL7WdLxae73B+vTYVVz2HI0rN7L7tVyuzQXCgDy1mOGhrBkaXHlJBMPrLrVn
         zTHuY3nnSfUfIPPSMTkJxNnVXwgt8PhwihTeoGwNd70zJJjWoE4E3B/o4cLNuoj8pCJw
         8EZgp4ZoioWvjcwmIkEpPXW9mTFSC49IJO5QVSX80wVn8dva9fAVBGV6GD0f6nPX7XXL
         eCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756405158; x=1757009958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8WCzP5XruJZcY+aCROX20DDrThlC8LXbUjIf1UiM2s=;
        b=MZaHO2ogWTnzLKsIhHj+ZAH6rkVnAMTHWt/MRel3up/MQPH+g/7McXIwGjSo1s4RS2
         dIgSQI5QHnvx5V6/2nqB14fPNRefVjtRXd+aq/X0LBx7sp/Jclmfy68J5CkPTER+oFwa
         h06JkBmiZ4zt4aBc13Nxx/znytWkMfxY+5hnRjyGfqaFDAQHmUjrY9L0UyBMCE9gIf41
         6GT9227Nixw3KL1kv1IGVdjAzNAZAx3pvF2Dp9F4SLScXPY2/oEuEGJzMpp6EdjBZSu2
         IPJ99MfbT1ltIKP0rPnXa2GeTGG74dH/hWHvL+ahGeQHwhcSzQIXTi1J6ZDzvnxK1v6K
         aUZw==
X-Forwarded-Encrypted: i=1; AJvYcCVVz1BmWFoe8kHaeQZBPi8FHJfwT62CjTbSTHfETXyKTaEs9pD7aO4H/RgmrlfVe7G2cwnJnMAd1EbhgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvzhK5cA59rLuz3KXd7WOEmtnDah3ck1scW34TkiJupdYykGhd
	N+HeLnxXpORJsXwFInDbxSWbghmS2so9/qW0kzPDsd3av1/gZMm42ck1zhcg/8x9kr8e+GrnWKZ
	OpUc7c/0Efkmrywh6reVd8K0PP8ZYxFEQnI9KSjup5Q==
X-Gm-Gg: ASbGncsLWW+Nx4tQYtS7TMVgHL1t6QcHOzoDMjr2n3Vk3JnGkKKAnP5wVp88d9XxU2i
	0mpvmBLF3AIwyyC5UOaYNhLz/9kM8PSzdi3gxPx2VqBxWktL9xmVV/2Mm7sz7rw4aQo+G2fig1u
	u1CkekZ+UvokOaUENnCigynUigOy9Xk4W5j4T9daUNfvIYDFoSdv0fki0CltEK7Eq+j3RDNP/0g
	zRYH8I=
X-Google-Smtp-Source: AGHT+IH1DSJZGXknSzW6wH3w+Axy81DzZxfZ0orRS3bzF7NdL/MqGTEERDxVjp0WltcO4vKqnpq+IlyPKB7YEvEtM8Q=
X-Received: by 2002:a05:651c:f04:b0:332:4528:c0e0 with SMTP id
 38308e7fff4ca-33650f40230mr73400651fa.32.1756405158218; Thu, 28 Aug 2025
 11:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827024222.588082-1-gary.yang@cixtech.com>
 <20250827024222.588082-3-gary.yang@cixtech.com> <0fa7e2cb-fa0b-4f9e-84d6-a4b2b3d8a4cf@kernel.org>
 <PUZPR06MB5887D9A879D16DC6A8C8ED58EF3BA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <25283b66-4cbb-4db9-9b1e-7a4e6e3db2a1@kernel.org> <PUZPR06MB5887887C93BFF42BC8417D96EF3BA@PUZPR06MB5887.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB5887887C93BFF42BC8417D96EF3BA@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 20:19:07 +0200
X-Gm-Features: Ac12FXwRlxWLxClpU7dqWEVAoO6fz9nruFt5m8l0uHGvpyxmXFRxpd6jlKHnWxY
Message-ID: <CACRpkdYC-3qybKW7VH5MVfBc3oqSrOa2RTt1Q=p=HHsi5drGOQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDIvM10gZHQtYmluZGluZ3M6IHBpbmN0cmw6IEFkZCBjaQ==?=
	=?UTF-8?B?eCxza3kxLXBpbmN0cmw=?=
To: Gary Yang <gary.yang@cixtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

thanks for your patch!

On Thu, Aug 28, 2025 at 10:58=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> =
wrote:
> > On 28/08/2025 07:37, Gary Yang wrote:

> > >> Whats the difference between? You have entire description field to
> > >> explain this but instead you said something obvious there.
> > >>
> > > Cix sky1 has three power states. S0 means work state. S3 means STR st=
ate.
> > S5 means SD state.
> > >
> > > The pin-controller on sky1 has two power states. They are S0 and S5.
> >
> >
> > State !=3D device. Please create bindings for devices, not states.
> >
>
> Sorry, maybe I didn't explain it correctly before, and then make you misu=
nderstand
>
> There are two pin-controller on sky1. One is used under s0 state, other i=
s used under s5 state.
>
> They are two devices

Just explain this in the description: and everyone will understand what
is going on. Since "S0" and "S5" can be easy to confuse for "states"
it is extra helpful with some extended descriptions.

> > >>> +    properties:
> > >>> +      cix,pins:
> > >>
> > >> No, use generic properties from pinmux schema.
> > >>
> > >> You should also reference it.
> > >
> > > Did you suggest us to refer to
> > Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml?
> > >
> > > Make us support drive-strength, bias-pull-down properties?
> >
> > and pinmux. There is a standard pins property.
>
> Ok, I see, try our best to support standard

Unfortunately many pin controllers have forged ahead
with custom foo,pins =3D <....>; settings where they set up
mux and electrical config by OR:in together different bits,
and then they just poke this into some registers.

This isn't very helpful for users.

I initially wanted all functions and groups to be strings
and then to associate groups with functions using
strings in the device tree.

But I have realized (though much pain) that many developers
don't like this. They want a magic number to write to
a register to configure a pin, because their hardware
has one (or several) register for each pin.

So nowadays the most common is to use a compromise.

A magic number in the pinmux property to set up the muxing.

For example:

arch/arm/boot/dts/mediatek/mt7623.dtsi:
pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
               <MT7623_PIN_76_SCL0_FUNC_SCL0>;

Then the electric properties like bias-pull-down; to set
these on the state:

        i2c0_pins_a: i2c0-default {
                pins-i2c0 {
                        pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
                                 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
                        bias-disable;
                };
        };

This is a good compromis becaus it looks similar on all
SoCs and you see immediately what is going on: we enable
SDA0 And SCL0 and disable bias, so there must be external
pull-up resistors on this bus since I2C is open drain. Very
easy for an electronics engineer to grasp, they don't need
to be computer engineers or device tree experts.

Yours,
Linus Walleij

