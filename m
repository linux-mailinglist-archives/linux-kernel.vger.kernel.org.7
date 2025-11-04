Return-Path: <linux-kernel+bounces-884557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F34C3071A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D09264E8295
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56402314B62;
	Tue,  4 Nov 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OVTbNDlN"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397472BE64D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251302; cv=none; b=t/CNyk41VUt6AZFPz9G70fRq4y+KEM0eJdZ0DkMn4nvRfN1vPZii8GMg9Jvshl2NHl4xU8h4DpHFkRQIs8NvNcWtpmnKNvXO/Jn3k3ynf37u3b/1RBNA7c9NHVFMKK75AWS1Dx3P+8SO+cf6OhA+P2mgd9PW2KQQ69E+Zlq5zmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251302; c=relaxed/simple;
	bh=XcQOLlP7lDH4KciW/rNOuCE0cTSrqMzPKKr1wMywodA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4QPQEEEytvKJ/PWtPRK1hkOndTSWeiclr1x2TeJOfjHtqf0mbRIvs2kjrVKQ//hEl9E9ME9Zl69vhidNQ906YcAFhY1WnhhMwfWHJ5xqzS1BH/t5COu8FCtOL1Gp+Mx117XpHBu/hZzlgp0Xp0Xez6I1dz1BQzfV5HM/+j+uxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OVTbNDlN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475de184058so17050025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762251298; x=1762856098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzTHhy3GAbklolyt8qy1XMnUZAQnKYr+cBkCn68R7OE=;
        b=OVTbNDlNMfRou9Zuj6aeOF0zLR0LDxjDBWc0gy4aj/xe6+QHbD5geqK6mQ3se5VDlf
         ocS6fzbjRK9mrkyZZPjx/U0DHeV1p7o3Hm5EhAO/Ou0IgG95CkFRqF3QJlztPUqouqur
         D5EVvs7EjYUlY2Q/u1BAybwDgY7FSIUXJHQA1aK3fIAJTNyey4PM6s6Z4cg+hRWOZo+R
         DcnJhgXZ9LLtFPNds+8pDKnYvCXV7sBAIvAsoMgQvWK5TR2ah2ccy/r2/Y0nFvCU+sxG
         9ak5oPa+WLmsYtgjMYgvc9F2pyDZBdpQcH2aZfh8q0w8wl1g0UYFNkd7Gh2mz1nIOFV5
         +NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251298; x=1762856098;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VzTHhy3GAbklolyt8qy1XMnUZAQnKYr+cBkCn68R7OE=;
        b=buXIDTtG27Zr0xHL9Z0A1UXmgFY2wE0E+bubUzw8S9AU4+pNmQeKhTI1I8cN4JW8+n
         m3IcORnVBaxpb9yKNrz242ZnkbQE4cLIWBAs74abyAF26idNSVDMz6k2SVrhvYjQBPkP
         /fBq5yBH3ZHmfKUGVTo1WssoozDnYqmV7TieF5enQmV72/EyVhX90KH1gzxlsZiKQuvN
         V/neSgaZkvtlWtWCUWbY912rxZWHzI1eDCYaVtlF5catBsKLys8ZMxrV0WLzhXE1z3AI
         AOZN+1WM1/6eOt8XBouePowsbITMzwZRsKxA2cLo4yY73NXod5uuUQ/iCAggdqncNXdE
         Oc1A==
X-Forwarded-Encrypted: i=1; AJvYcCUq9EuM//lCayJc1ds1CMCJoA0y9rKejScyeYmcAS4nw+IqX0NoW9uYkdXJkmLlGE4sQlHpph+/uWhzlSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCiMZTFUV8H9isNiYphRdgEVmaDbKKM9MEAV0jUsyuaK36GN7
	ute+LP6YoJJDVLMZUol05MbE6QfdM23CGKn1gWUjr8+UWmgVHwRU/Ocx4BQpqT0X804=
X-Gm-Gg: ASbGnctp1yhfStLd3O8P+gt/5GRULx+LNDTMq6Y+jl3uKK6G+Y9g+2fN2SvhEIrYBUJ
	3PnHcZ66ZbZ2QGf4IuNk5Mu3cjd2bY9EQ5Ex3g8ODQrHnfas2DNHuYCaIOaj+/4tihmDzkLah6L
	5Khz5mHkwojpN5CtkWjszy1GOwj4i+oe7mgx5TMvIQlSDHlLDqu/CSTN4r0cb+YCUbn2GQpv69m
	xG2OWZcKCtl7h4VI65GbweGhTQVhQ4sAQNyQWAUbdYJfYcTdxP95VYLmQ7tjj3FXigEEiBBUuYB
	fXvLIrm0HiC3OqTQycQfWQ12WZhq4n+KkzXi4D6vJLIN4osieNqmqYvogPUETRmXF9UAO11jSPN
	BbEm/A2jswIcHbPUHKPqry32UluhBkhqua/11oPScQ2jn2INedCy/8ucbGdCBka7Ht51SuhaXX5
	AIjhGrAi4YZw==
X-Google-Smtp-Source: AGHT+IFW39f8luyhpSRptudm6R2xZGEcdodo7MnF7yu9NJ2j+0Jo9qKayBjVFzg4CRgrhQRxcMSJYw==
X-Received: by 2002:a05:600c:3489:b0:477:cb6:805e with SMTP id 5b1f17b1804b1-477307e0513mr122942125e9.18.1762251298482;
        Tue, 04 Nov 2025 02:14:58 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:8c13:6331:568f:92f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429dc18ef89sm3810253f8f.6.2025.11.04.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:14:57 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jian Hu <jian.hu@amlogic.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,  Chuan Liu
 <chuan.liu@amlogic.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Kevin Hilman <khilman@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  Michael Turquette <mturquette@baylibre.com>,  Dmitry Rokosov
 <ddrokosov@sberdevices.ru>,  robh+dt <robh+dt@kernel.org>,  Rob Herring
 <robh@kernel.org>,  devicetree <devicetree@vger.kernel.org>,  linux-clk
 <linux-clk@vger.kernel.org>,  linux-amlogic
 <linux-amlogic@lists.infradead.org>,  linux-kernel
 <linux-kernel@vger.kernel.org>,  linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 5/5] clk: meson: t7: add t7 clock peripherals
 controller driver
In-Reply-To: <3b9a5978-aa02-486b-85f5-6443dc607dd5@amlogic.com> (Jian Hu's
	message of "Tue, 4 Nov 2025 17:17:50 +0800")
References: <20251030094345.2571222-1-jian.hu@amlogic.com>
	<20251030094345.2571222-6-jian.hu@amlogic.com>
	<1jbjlnxuug.fsf@starbuckisacylon.baylibre.com>
	<3b9a5978-aa02-486b-85f5-6443dc607dd5@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Nov 2025 11:14:57 +0100
Message-ID: <1j1pmew1cu.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 04 Nov 2025 at 17:17, Jian Hu <jian.hu@amlogic.com> wrote:

>>> +
>>> +static struct clk_regmap t7_dspa =3D {
>>> +     .data =3D &(struct clk_regmap_mux_data){
>>> +             .offset =3D DSPA_CLK_CTRL0,
>>> +             .mask =3D 0x1,
>>> +             .shift =3D 15,
>>> +     },
>>> +     .hw.init =3D &(struct clk_init_data){
>>> +             .name =3D "dspa",
>>> +             .ops =3D &clk_regmap_mux_ops,
>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>> +                     &t7_dspa_a.hw,
>>> +                     &t7_dspa_b.hw,
>>> +             },
>>> +             .num_parents =3D 2,
>>> +             .flags =3D CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> ......
>>> +
>>> +static struct clk_regmap t7_anakin_0 =3D {
>> Nitpick: for the DSP it was a/b, here it is 0/1
>> Could you pick one way or the other and stick to it ?
>
>
> ok , I will use 0/1 for DSP.

I think I prefer a/b if you don't mind. see below for why ...

>
>>> +     .data =3D &(struct clk_regmap_gate_data){
>>> +             .offset =3D ANAKIN_CLK_CTRL,
>>> +             .bit_idx =3D 8,
>>> +     },
>>> +     .hw.init =3D &(struct clk_init_data) {
>>> +             .name =3D "anakin_0",
>>> +             .ops =3D &clk_regmap_gate_ops,
>>> +             .parent_hws =3D (const struct clk_hw *[]) { &t7_anakin_0_=
div.hw },
>>> +             .num_parents =3D 1,
>>> +             .flags =3D CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>>> +     },
>>> +};

[...]

>>> +
>>> +static struct clk_regmap t7_anakin_clk =3D {
>>> +     .data =3D &(struct clk_regmap_gate_data){
>>> +             .offset =3D ANAKIN_CLK_CTRL,
>>> +             .bit_idx =3D 30,
>>> +     },
>>> +     .hw.init =3D &(struct clk_init_data) {
>>> +             .name =3D "anakin_clk",
>> Again, not a great name, especially considering the one above.
>> Is this really really how the doc refers to these 2 clocks ?
>
>
> bit30 gate clock is after bit31 mux clock,=C2=A0 and the gate clock is th=
e final
> output clock, it is used to gate anakin clock.
>
> I will rename bit31 as anakin_pre, rename bit30 as anakin.

Ok for the last element

... but I don't  like "_pre" for a mux selecting one the 2 glitch free
path. It does not help understanding the tree.

For such mux, when it is not the last element, I would suggest
"_ab_sel" ... at least it is clear what it does so, "anakin_ab_sel" ?


>
>>> +             .ops =3D &clk_regmap_gate_ops,
>>> +             .parent_hws =3D (const struct clk_hw *[]) {
>>> +                     &t7_anakin.hw
>>> +             },
>>> +             .num_parents =3D 1,
>>> +             .flags =3D CLK_SET_RATE_PARENT
>>> +     },
>>> +};
>>> +

