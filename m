Return-Path: <linux-kernel+bounces-850370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB6BBD2A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 545654F0405
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9EA3043C4;
	Mon, 13 Oct 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIbJQqA3"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0403304BA6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352573; cv=none; b=nrKoxIiBID8cPRB9QR5GitN6IGv9weU9a8Plb10N1VLYSrGAFOka/0EinKBLFo/b5EqYd+ob80gwuIN8MXf2pdh+KsxOe/C+x0zwmGFFFgMXBT+98h1ZrLugyREAbL45eTjfbkVvrigX8cYzoqanSJeUqogOXyw1C5NrAdN1F5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352573; c=relaxed/simple;
	bh=OBRTBgdQa0ezTgOG0fekcSASOaIs/eav1o10bLNrjYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMiR/ZdsQuA5eXVOhn3STB+d+CbcTVTO8PU2y3hejuQ1kSDu4wSG5kCKPTQqcUP6RVJxYtle93cG2y4Qx3YrCbasV6tSxY383mx1vwSqEv8kzynKdOsVsrOUdpaC9PK7bHURnCXqGVMnjhYSDsYTSgn3Fs3Dc+HCDb4JjSp2DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dIbJQqA3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-371e4858f74so48084831fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760352559; x=1760957359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBRTBgdQa0ezTgOG0fekcSASOaIs/eav1o10bLNrjYg=;
        b=dIbJQqA3hv0qH5S8ffwtW5xd5mp3nBvNThC5DatwFba/UINk/1v+qPAEDYGVm9zCy/
         xk9aAmgF30hBHLUwOGGiqQ4t5ysmrvL/VVRJ4msftFxWNNZoYlHfqXRYePlhJkWgQ+Iz
         XeCa+cGGrlndMAxORngQjOLKggc1Pgz2W9uN2GsleeNeXFfCuQQOqwCriEBIqAfoVF8M
         /KGLseoR13gLcvq8NCJdutHcIVIyTNWLgnGtrljn+TR9sjb3oKNgq/BFXl2RsR2zgKhi
         F28rGpqYQygsoV4x1oFDUSDUa1kZDDdYZfnJ55GUQOL0LielO0oqaaxCHwgeOS+0jCkt
         9epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352559; x=1760957359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBRTBgdQa0ezTgOG0fekcSASOaIs/eav1o10bLNrjYg=;
        b=pqCosPj8hIdEXtZnMWg5C6/v0wW0qU5tVcCbHCGntYLpq4ctoR8zB5Xl7BAiyAPGgw
         xuv3zZDqq3Sqip4Kgi6n2ASjzl1tEIZEzyJ7FpepTKN9U+62i2ZI5xYFrWmroinrQdBj
         iE1P4wzqPCkwbC2LOnWe68U2AKY75WaiaKzI62PMWlToBH8e6/2RxyAKFXa7G1OQtX8y
         nJIXkMZ4ErRQAUXnzMUJtP44pJfR0LpufeTvGZDexM53wil9e6H0leEMQIfM9Qaj0Ok2
         geE47FP+IumDGdrIfl8U0Vqft5jg4bNcJuCxOI3rjrP7xMmLssvFU3/K8NccIzTAU5NC
         QdsA==
X-Forwarded-Encrypted: i=1; AJvYcCWImNVgEYAlB37qy7yvCS59H4ibs71iE2hMN1J78M2WpY643js30hvejPZSbnOK5FEwI5zhxQNh+K4xty8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bdJsWXUoHolr9KIq2Lm+lDx6u9sY3aiNkPiwiZBpRpRDhVC3
	pdSUIUcp9oQCk9Hj0S5O9agn3TMusQNAJ6BErcmPS63uw6TYxkNyfTHgmuh7ENWGhbpNXBKdPH2
	kyx71cqMibCZMMs06+3oK6njknGPDrPz0xveh72OSlg==
X-Gm-Gg: ASbGncsn9aKVzLG4sOCoAdiGEwoZgVtvntNZGEpz3/VUbyUHZwIvUchyL7Byk+AxbOw
	NP73eKFJ4bJidf6rMIy44Uo88H/2QCC6TBCu/6wPOsG+32Ou3BgP88ARyD1c5YVbIMnMlMKlXcp
	hCoa0J/26iwBYP95O/+j89P8s1bFfZWEeeR+yHMz7wnsO9dpmFC1eitIfL8dkfcjV4geKgLNPqL
	jwfiJlmjgYReFuTBegN+vtyh5KJGg==
X-Google-Smtp-Source: AGHT+IFOq8r2+x8j+n2o4YPgt0yqTqrdILP4XzCLFJtq6Qxm8iqZG0/oseSlJ2uW/NV8gJqb/q55XZ6vH5Q9BXkHEkY=
X-Received: by 2002:a2e:a54a:0:b0:373:c272:d986 with SMTP id
 38308e7fff4ca-375f526e5b0mr67942651fa.17.1760352558762; Mon, 13 Oct 2025
 03:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152640.154092-1-herve.codina@bootlin.com>
 <20250922152640.154092-8-herve.codina@bootlin.com> <CACRpkdZPURiag1cUQZ319_QA83u+qOCSRALxpe10_+cTcevy+Q@mail.gmail.com>
 <20251001174205.71a08017@bootlin.com>
In-Reply-To: <20251001174205.71a08017@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:49:06 +0200
X-Gm-Features: AS18NWCu7OuRtExFxAHo2mGL4pkxRIov06rPInvhQDpr6xWeLGLTOcCLnJNvizg
Message-ID: <CACRpkdZ1qg6ecA5DyVEGUHQxLh0SnC=GC5JZdevT99YVWU0ypA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:42=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:
> On Wed, 1 Oct 2025 13:08:57 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:

> I don't see how IRQ_DOMAIN_HIERARCHY would help.
>
> The irq-mux only muxes irq signal without performing any operations usual=
ly
> done by an interrupt controller.
>
> That's why I used interrupt-map in the irq-mux.
>
> The only information needed by the irq-mux is the interrupt line muxing t=
hat
> needs to be applied. This information is available in the interrupt-map.
>
> If we introduce IRQ_DOMAIN_HIERARCHY, either it is done at gpio controlle=
r
> level to route gpio interrupts to GIC interrupts and, in that case, the
> irq-mux is skipped and cannot apply the muxing.

I meant to introduce the muxing code directly into the
GPIO driver instead of using a separate muxing driver,
using the struct gpio_irq_chip supplanted by IRQ_DOMAIN_HIERARCHY.

Are these IRQ lines ever muxed for anything else than
GPIO? In that case go ahead with this solution, I guess.
But the title of your patch seems to suggest it is
only used by GPIO.

If it is only used for GPIO, why make it a separate
driver instead of just putting the muxing into the
GPIO driver?

> Or it is introduced at irq-mux level and irq-mux need to be an interrupt
> controller but is component is not an interrupt controller.

It is a hierarchy, as all interrupts are routed through
it. Just becaus you don't have to ACK every IRQ in the
hierarchy doesn't mean it's not a hierarchy.

> Maybe I missed some points or I misunderstood the purpose of
> IRQ_DOMAIN_HIERARCHY.
>
> Can you give me some details on how IRQ_DOMAIN_HIERARCHY should be
> used in my case?

The gpio_irq_chip ->child_to_parent_hwirq() is called
as part of the translation of each IRQ and in this callback
you can set up your mux. You can return
negative if you run out of muxable GPIO lines.
This means the irqdomain hierarchy fits as abstraction
for this usecase.

Yours,
Linus Walleij

