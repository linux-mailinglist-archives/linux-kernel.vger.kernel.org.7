Return-Path: <linux-kernel+bounces-747730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEBB13764
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0697A23A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E001D8E1A;
	Mon, 28 Jul 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HRfloTkh"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59E1A83F7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694380; cv=none; b=C+g5qXkTjn9+Mi8iNRIbabjNzwuiqKGyLI4qGtVbGBOjgWf9C0b738n7BF7qET5FkHSzZANDMpFaOGQgrU7+6MJfqkwBaeW5iTPPd+yu6pJ9p3rs5j/D1H+tYFAHDS/HbkfRcpImwqmOCSz3LXTZ6PEtoLiTQnRVpgGaxyYLEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694380; c=relaxed/simple;
	bh=EM/dwFq1yZlzHICX5jZbmxa1S4pmrfRrhSn472Stlgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAAUNzbptkgau0ryyoAOW0eM0bsinFHR0O6mjGjGfDXFCimfZKdMuI0UsHuqL8ROkbuMVgh5NlBZxJbeJcycPEAubLRiKCKCeS+o5bq61sCi2OOSpuxZFgNDEBhQmAv6onfGBuXCKN+jY9xHe2VFZHncrA2NcRsYFvhkfpi9pNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HRfloTkh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553d771435fso4309692e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753694376; x=1754299176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Wfr6IDv5PxwXwO5SalQp0PsuBKS/k9qem5YR1Q0PY=;
        b=HRfloTkh4g3PC0IRR5nBPYEUCItNL97qQtAbO7ZLMpifPsMfWvlcHWaBHyaatTfRsj
         jSBjf84GF3pi31/f+Ujyj8nAHjF1GX+ZAA4iNPVC5p3SkXXONA9NS46ka/rLAJAuvbDg
         xOkhj4ZNBmrv3MRTs8Oq3IX8sCz3NrEKeasECeEWoIzeZ0er0zHpZeq1D9eAlPRhU6AN
         PiCwuvw8Eqt61T9lM3CmnB0v1OqMQhDHeQj/ft1HRwFa7JElpcuNoqV+M5LLD1QRuXb1
         gPTiUQddv/yIIsonilbvKZ+K/6TgNc0eKyil/S7SRVaIUTFNJcZ/+DrpqnQau5WZWovy
         W5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694376; x=1754299176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Wfr6IDv5PxwXwO5SalQp0PsuBKS/k9qem5YR1Q0PY=;
        b=p8daPy1yquOfEeVIe5/70CqCoKJ55Xjhg5x5VPKjmpyam1Z1PqH2saaUU0e8h55kD3
         R8R+qz+30ebf2/sGSiDNImKXRZrCtBbpyaKNVD8bukOQYf/VcF5nJHrhfdQKWJankyuv
         4yJYKR3Ba40YoZaKFrNI1HYk3Je5CVJaxq7xLVgfPXFXidL7vEEN4IKMpJ9jLr6baYBQ
         XCdZXIUvfc0OU3O2BQfyVFc50lcHj14SlvBtzNh4Ar1gdJjHMjXII/4O40oEJelniNiH
         mxDvLJTGqhTjeR79V1uA6s3caNtglnFDq4JFEKcH0OeN+F0eUK2VWaLVLG8A9BhbiFVX
         tFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVH2VaRiPs5OfCk3NZEg6QzDxmU86hXobn4SYtBOerRFmvqyunwudzeAQXnqjWNBMvacTRi/0g4dPJltWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUO8oSZJF8ouqgOrnfAQKnWoyP3yYSCpH/9gGOVJtK5+Wvpwr
	4B4LI4G/YaBSDEMVQo8091+1yomAipi6tgP41KPWLiuYozvAn2bSfcPV87kUhBStCuIu2DQvqg4
	bk2spzVE3gDkKEongH0oj3i6IE93YJMPtDkIaXd3M5Q==
X-Gm-Gg: ASbGncvvBILU66qa2Ab3blCif7f79DA+m4tlz+PZBhxyJc1iJmCgd+NMw9oIkLlDVvF
	8ZYQ784XL5lNMLk7rkNS/aqBUW4X3E7mO0xlU1QEkaqZb+UTqpvb9FhF+GbV99CiJcPMlN/66gd
	PJUtSP2gb4gsK5Mz8xadyFh8D0KBvO7lzuGV28jhIVJC2kPer5qj2Yr9vD81Nk1JGpwkyEna6Ck
	dIb9T0=
X-Google-Smtp-Source: AGHT+IE+L8kojs9dsw3C6rCUb7FSCgckOs2Jkf9bqhFZnlMh8FPpWpEIQvGXcm9tMwdZmOjR+SBZh5eXeLrR0pntl+w=
X-Received: by 2002:ac2:51d2:0:b0:55b:5ad8:186d with SMTP id
 2adb3069b0e04-55b5f4bbd79mr2861674e87.37.1753694376329; Mon, 28 Jul 2025
 02:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
 <20250704070356.1683992-9-apatel@ventanamicro.com> <175341132347.3513.7184287611040628050@lazor>
 <CAK9=C2UDV3xCpKxZmT4NsRvN=hCcQrcx0fr-QFD2fuOrqmXmHA@mail.gmail.com> <175359739515.3513.8664828076215459722@lazor>
In-Reply-To: <175359739515.3513.8664828076215459722@lazor>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 28 Jul 2025 14:49:23 +0530
X-Gm-Features: Ac12FXzCp3IP9jRK5qLB49tEzZkZnvv77-g8d-wAPrlIzxfNVRivXQcgZVb8d84
Message-ID: <CAK9=C2WRVHZ4FdoW0fKRRFg6qAC5asn03dHj_NXkMKfBXKkXdA@mail.gmail.com>
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
	linux-acp <i@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 11:53=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Quoting Anup Patel (2025-07-25 09:16:12)
> > On Fri, Jul 25, 2025 at 8:12=E2=80=AFAM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> > >
> > > Quoting Anup Patel (2025-07-04 00:03:40)
> > > > Add device tree bindings for the RPMI clock service group based
> > > > message proxy implemented by the SBI implementation (machine mode
> > > > firmware or hypervisor).
> > > >
> > > > The RPMI clock service group is defined by the RISC-V platform
> > > > management interface (RPMI) specification.
> > > >
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > [...]
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    clock-controller {
> > >
> > > Maybe the name should be 'clock-service' then? I don't understand SBI=
 so
> > > not sure why this is in DT to begin with. Is something consuming this
> > > node? Or a driver is binding to it?
> >
> > SBI is a syscall style interface between SBI implementation (aka
> > M-mode firmware or hypervisor) and supervisor software (aka
> > Linux kernel).
> >
> > We have DT based drivers in OpenSBI (M-mode firmware). This
> > binding allows Clock message proxy driver to be probed on the
> > OpenSBI side. The clock message proxy driver allows Linux
> > RPMI clock driver to send RPMI messages via OpenSBI as
> > proxy thereby sharing the RPMI transport between OpenSBI
> > and Linux kernel.
>
> Let me try to clarify my confusion. A 'clock-controller' node without a
> '#clock-cells' property is confusing.

Ahh, I see your point. The node name need not be 'clock-controller'
since the node is for a firmware driver which provides MPXY channel
to supervisor software (aka Linux kernel).

>
> It's not providing clks? The SBI firmware is not discoverable? Do you
> have a pointer to the DTS for this node and the clock controller node in
> the next patch? I'd like to understand why this is named a clock
> controller when it doesn't provide clks.

The firmware driver is not providing clks. Also, the SBI firmware and
various SBI extensions are indeed discoverable from supervisor software.

On the Linux side, we have two DT nodes:
1) One DT node for the SBI MPXY based mailbox-controller
    (Refer, https://lore.kernel.org/all/20250704070356.1683992-3-apatel@ven=
tanamicro.com/)
2) Second DT node for the clock-controller based on the
    RPMI clock service group.
    (Refer, https://lore.kernel.org/all/20250704070356.1683992-10-apatel@ve=
ntanamicro.com/)

Regards,
Anup

