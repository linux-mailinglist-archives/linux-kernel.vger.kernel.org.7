Return-Path: <linux-kernel+bounces-749429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1EB14E42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55855448FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4911A18DB27;
	Tue, 29 Jul 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8xdKihB"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452942F24;
	Tue, 29 Jul 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795000; cv=none; b=U9Ya6Zf0adJ3PP25kXdJAvRNz56aH7blk3s7Ze+NjJlm5C5BF9OMB2GnAI91NaB9ZfLUDoZN7j0uZnOlNL/+KCrLE51IGjRyh2DZL5k/9kx2pp2N4LPWhV0iZl/bIi5XLKy/7oqsdooFBpkXz2daMqqPkAT0+dFW1uXZNOHayuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795000; c=relaxed/simple;
	bh=RUF08R7NpLN8blL4sUVGgdMI/qgrbUe2bQ4Li7BkTuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwYLV2hPdivVGLI25t4zKGnwA++oXO5tEsOhGDtlrhgc9qmsgWJX7cDXCNZskkaWRMuSbkLTL4VMNI38ZRXlYazvU92f7A/YWimIvyewKAnGTHrfj5Sl8soJTKoSIfB25RL4jTsEFijDSYS02ItnpfuOZQWarjMppiWPDLBP8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8xdKihB; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-719fe335186so23143167b3.1;
        Tue, 29 Jul 2025 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753794998; x=1754399798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/lfTifbzeJtDBdptx2/mM5xq8Rur7Nj3CsrchIJIonA=;
        b=m8xdKihBrATcQr+acs9o3iORy4t+8g6HjjJdo6i7id8tsMmEIz6Q3zyhszaMrOoTrl
         9RgsMD75QBmzc/T1DQJUk16Dcyl8bvaCcZCrpluivrfX7XhSWpqFnEk6UwPvERvx3fGw
         gduHSY2whughOhgDq06TBYNau6M20mgq9OcBiYRVkp9Kd0xLXjg4fJfQ1gW7AVe0klNM
         Rs/XOTB9H3kJHqqmTzNgN+JEjx+7MRaxbRXN6XTZ2CUKNaUOqmyuAMdI5eI+8UVDq0EL
         YGP1BEL82aDRlt53x8TK6ERjpZmxk7G3H+WDPhQgAr4ZhwKhHJSL+gBMVhsxL6xF8tY5
         vSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794998; x=1754399798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lfTifbzeJtDBdptx2/mM5xq8Rur7Nj3CsrchIJIonA=;
        b=BnlTV68psQoC9slLYJytMifK5ZCSSpObaKnMDvXNXYLF7Ewh65uedbwKtOatK+KXuW
         t9uncpZQhNwZFC5xoJjbVAHYAxOXtifMvBsXmxZeSENqQN+Uk9dtCbHxg1MhTwk8udT2
         Y+k9RPjeI200f+t86qDpAd+DAJurqdA9WEkXy0g9gewclS8RCqXYS7jAD+f2RCPv2OXl
         a+VQMEziTlDNf3anH0AaIDax9zhbY4Px0IeaeUlw7zfFjJiJIFk3BStuTYpwu+3GzHsN
         lXFQ5wb31c7BEWj7hbBKHE6Qnk0BQxTPYuOFqjUum5uP0840E+dX/S+WlGsPCL0j/CO0
         HOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Kjn6o+NT48WmgZTx8QK8srqVMvT/ByuyivsiAv7rKt0wCo9uanMq1+OHhwR/nsHK8gZtQC1SKllnPRz7@vger.kernel.org, AJvYcCWu9QOXq4SyRUDWN0lrLyF5nUOjkBJJ45QsK2dDimUCm2WJp7eYQ97g5vEdm8kjpBFOEIY6lRgsZGpq@vger.kernel.org
X-Gm-Message-State: AOJu0YzEA/i8rQHfUUsI80r1p1KMwm4IG+19Z4ZltKpCGlTRY/iEUq1U
	ARnemujY39aW5npWqmy5gHU4H1OIsGnWufmKQqKoTvkpkW7vYyDJ/Apm5JcO19IQoBG0aD5mopb
	MSvoHnxQ9ZymiTPgLRsYZyrrBLK8ilqQ=
X-Gm-Gg: ASbGncs00ZQlBM1a0LRpjGl/pegiBTQYfvnkm+OBPnL3EyrPq3WTbAx3HB3uuE08E3R
	BRxtVumYVL2AFOgpPtbdwOyoVoNSP2epP0sI2F6LvT6PyMXeiiYNiURSr180xhvWCnCC2BA6fAJ
	9V68bwo4NfBHtqxHn/FRvynEMRLRm7wixNDn1lDpUBag/m/7mA4TKcRF3fGGj6u2dF33P+dbP8F
	ey7fI99
X-Google-Smtp-Source: AGHT+IEVae635NG5Lnt4HLDioDmt7SEj8cMo8l/+8dWgrcypmmqoDPY8G7XnLkcZ+fTaIcEF50pQVxzPBwWh8wy3V2o=
X-Received: by 2002:a05:690c:f87:b0:71a:18fb:7386 with SMTP id
 00721157ae682-71a18fb79admr125380267b3.2.1753794998174; Tue, 29 Jul 2025
 06:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717135336.3974758-1-tmaimon77@gmail.com> <20250717135336.3974758-3-tmaimon77@gmail.com>
 <91119587-789e-485d-9cf1-da2c500f241c@linaro.org> <CAP6Zq1gN28y-6_OwnzMbJ+EiubtABVw+FUqbmAo5bvBW-5tDdw@mail.gmail.com>
 <c661130c-3d18-4e6c-9c63-ac4c10c415de@linaro.org>
In-Reply-To: <c661130c-3d18-4e6c-9c63-ac4c10c415de@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 29 Jul 2025 16:16:27 +0300
X-Gm-Features: Ac12FXxH-ZuZJCzUxfuM_gJnXAtYQn_WVuODI9WBIPAGyW5P6swnPSsLiOyEMH8
Message-ID: <CAP6Zq1jxysc+Uy0U_2dczyLDb5mwKBEafaJJ9+ouJMfipjBoYw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof

On Tue, 29 Jul 2025 at 09:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/07/2025 14:12, Tomer Maimon wrote:
> >>> +
> >>> +     mdio0: mdio@0 {
> >>
> >> Huh... this should fail checks. It's not MMIO node, is it?
> > No, it's MDIO node,
> > https://elixir.bootlin.com/linux/v6.16-rc7/source/Documentation/devicetree/bindings/net/mdio-gpio.yaml#L48
> > Should I modify the node name? If yes, which node name should I use?
> >>
> >>
> >>> +             compatible = "virtual,mdio-gpio";
> >>
> >> where is the reg?
> > It does not include reg in the mother node, but only in the child.
>
> You put the unit address...
OK
>
> >>
> >> Please confirm that you introduced no new dtbs_check W=1 warnings.
>
> I need you to answer this.
I didn't run dtbs_check with W=1 and the mdio-gpio document. I will
make sure to run dtbs_check W=1 before submitting the next version
>
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer

