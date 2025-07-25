Return-Path: <linux-kernel+bounces-746004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C875B121CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D831CE7417
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD5E2EF2AF;
	Fri, 25 Jul 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RxjoTNGA"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418C2EF287
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460188; cv=none; b=oXyJ5C1unQDkYTTFHXiP6YMplmnftIxg+UBFc9cxDTWmb8pErYjGppQc2j7C2ZniGNpx7zFb+t3SfN/C32qCdBS5Ve18cxu6dOX+EJEYR1EcH3yupFN1WTFd5ErT8BibLTZFay2Va41QyLIkqxtQ19f4CS90OoQ0/LTr+vU56Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460188; c=relaxed/simple;
	bh=G6cKxpFpNKWSetLJHJ3pQ6zg1bL/LOkHThhiObiZaiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5TS6viZwfDC7WsRQqlwGB4KK2/R9mBucGhARdKOHstdQh0djqioRj2iQqoesJR4pDqpI1AXkBqkaOYkMI6r4QqLplbLvln1qdKx/Hq1kXv/BHTVhRInQAIgFzsON2uHifQGXHcDDPkYXqLmVvx5O0/slU4+WuaVYPrW9dS9wZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RxjoTNGA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b7123edb9so29986391fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753460184; x=1754064984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOo595UD81PW4Cz1UFmTlajy9wRb7dyhybVVNSTeWD4=;
        b=RxjoTNGADffczmoCgzq8vqRTkAAT2YiyseHpZvygnUhkFtdREp6OT0XRzRckbk1Qg2
         /PBKREDSYxOnmxXdkBwD4T0KBwiDnnipayFkuOA5jgFx+Xaka61ozxbiqbqpC6BtSEgi
         nwCi1Y7dy1Ve8EaF2shU716RzX14iJRZwzfQa+qpO/jZdFK0DONZyeilNNb28muOA0JY
         kQ9I2DUCvfFzdfLb7XR3kVLk3Fz2sN6qdc6aU3n8ddH+Y8BCprNR36wkI+Qlse17pp3r
         3cci7ZtSHSiPN5+s/nqwKlHlc4zmK1sLdFxsiln0DBO3+XcBGACtTW+QrK8RXnlRTJfZ
         O9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460184; x=1754064984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOo595UD81PW4Cz1UFmTlajy9wRb7dyhybVVNSTeWD4=;
        b=sPXExAJZvCBx95Pfz0D5NkYRv5KLu6nB4C+60qxWqIQGSod5brkS3vaC6gm6AsZ6Ep
         pN0RbDRYdjDvvkDfEax632U6o97KmrCzGEYwKR/3tet49YxqaHBPN72jOsbC6Qii8Qdy
         FPBRyPq/PnJHUC7gpkTR7I7Ip4ZnWo1yNFE6fh4S4jr0MDv5atfhwh0QbI8ehrjOL+6A
         QubB0wlJBzrrkZATbhMVJHsDY7jPR61XgH4636F6OGxyavnbhaPsXw4CdnAKmyfsd+SL
         qx8hIbMyAWlHqUm0x41Gvs9DpN/RI8XdWAeRpaLLFIm2gKXnKzFeRqqzFYV1gRfZm9js
         dVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRlbgDuer6jBztzTb/vGNwqT7veCFBa+oeXx2sFpP5Rdo3Q+WUj/76zabde0Q5f3oewUhVDGrUx4NlVIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThnm+uSKw3Ajl42HNWfITdKpDFtbfaMQtDWDUZM/qc45yMwNN
	nHxWjCcR1yAxNaY4X6u79P5kxe50aDYl27id6LpKj4iohLMKIy+QLR5lDhASUt2v7IYH2wUfBe1
	7FZ8vEpo8OPrQZC4t37ojjIaX82uy5jrSm/w69gPH4Q==
X-Gm-Gg: ASbGnctPaQbAVMsKqF0jW5e0SUOw2bTRtBNOlPTH6j8QBIWzynu0bzaUG1zk9ZTT2dU
	1bs7vLHCIO6aj84SGCfitsvfuGB0MtMiaAyt/Rb+PDs0rWR8G3Q+6F5qwoL+/mQskNhw3Ec+Izc
	8HouvVeMxsIxNUjPBUFzre59edyeBeDIxnPRS/FqKTh3KKst3h+ZYGO1EaJiyTNQMdSbNu9OgsY
	FJgZwM=
X-Google-Smtp-Source: AGHT+IFIuUIEQS0zyr6rBam/nD3H+hqGiiProGvcAqPkV/NrJ9CSjPmlKsQWWtSCr8nBHng2+tmatocM0hZ4PbG8CJs=
X-Received: by 2002:a05:651c:1503:b0:32b:5672:41fb with SMTP id
 38308e7fff4ca-331ee74cc42mr12092821fa.19.1753460184460; Fri, 25 Jul 2025
 09:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
 <20250704070356.1683992-9-apatel@ventanamicro.com> <175341132347.3513.7184287611040628050@lazor>
In-Reply-To: <175341132347.3513.7184287611040628050@lazor>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 25 Jul 2025 21:46:12 +0530
X-Gm-Features: Ac12FXyJjR2ZAcC8iSDmp338bf2ZOm1s9QD7gpAd84fmChTRX_UPxaRyR5VVtyQ
Message-ID: <CAK9=C2UDV3xCpKxZmT4NsRvN=hCcQrcx0fr-QFD2fuOrqmXmHA@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] dt-bindings: clock: Add RPMI clock service
 message proxy bindings
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 8:12=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Anup Patel (2025-07-04 00:03:40)
> > Add device tree bindings for the RPMI clock service group based
> > message proxy implemented by the SBI implementation (machine mode
> > firmware or hypervisor).
> >
> > The RPMI clock service group is defined by the RISC-V platform
> > management interface (RPMI) specification.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> [...]
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clock-controller {
>
> Maybe the name should be 'clock-service' then? I don't understand SBI so
> not sure why this is in DT to begin with. Is something consuming this
> node? Or a driver is binding to it?

SBI is a syscall style interface between SBI implementation (aka
M-mode firmware or hypervisor) and supervisor software (aka
Linux kernel).

We have DT based drivers in OpenSBI (M-mode firmware). This
binding allows Clock message proxy driver to be probed on the
OpenSBI side. The clock message proxy driver allows Linux
RPMI clock driver to send RPMI messages via OpenSBI as
proxy thereby sharing the RPMI transport between OpenSBI
and Linux kernel.

Regards,
Anup

