Return-Path: <linux-kernel+bounces-754425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0FB19427
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08463B5F50
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4031A5B9E;
	Sun,  3 Aug 2025 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ChV5/8Vh"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EE1607AB
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230062; cv=none; b=bAI+RuJ1rHWvl/hVU6wZO9/EOdMphQgbqA+m62JyBaGcEVpTDNTy4tZ7T+g4xhU10OrEZBjxt4xD1RcmcqCwwnJHqm83p9szftlq7/cM7EUvlq+Hvm49Ic2jdR27chKulzIf+TQRgTXkcz5PR84ih8/ER9LyW3xuiIqzzoMYbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230062; c=relaxed/simple;
	bh=HnQn3NsQPazFAhowZPT45O5Yd/QRrD+8FRMPKE4W6Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbkfgUi0ftL9hHVskDZJV5NvmjkE/vS2m3C25N/8HyE+yuyoECNjBLb92sF0ECIeOvjZtwu0XyOPG/rokV61dO7C2MhJ36BkjWYKt/HDh1b9fNzDTadDuLM67IdDT0NGnqaChRMkkfw9smJkpsVMVywKM1rfIXVxvBcBimbeEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ChV5/8Vh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso36174081fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754230059; x=1754834859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzN7qn/y0iYwP/aeVo8H8FbGk6Rq9qUZdl4rPLj5kjY=;
        b=ChV5/8VhWxchGtGmqtxbm0WuTpjD+X2Z2cMP77T3SIMTiXWQDvqv7dQu1rF+wgBgRy
         e2uT+fnkL4kSYUsmTm+pK7kF+E1W+AoSrEneUa3jwmFkoLhxo0sB4/x4pTfRR6djscy2
         ROKFoMTduNsTLaq4VFRzOfx6G8xuuDGLQ21sD0faKr7jnaYW0c65kNIGplPMYvoOqZ7n
         qb3BWED1IIn3XYMNxqZgFE4yrJj0czLom7zsszTMf47r2J+svGvCFcXHv8RE8hvGjfkE
         iGnrDiyrpei4oaCbxOSA4P1lZ89T9Xhjr+OHmfUGOAYnPdtLNyDYNNd7xx1zWxpbWVP1
         dUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754230059; x=1754834859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzN7qn/y0iYwP/aeVo8H8FbGk6Rq9qUZdl4rPLj5kjY=;
        b=AUCZ6fQSMaJmm4PGHIWFkDD/RhVQzAVKaEf3xl+kWbsTaQEsHqiZmwxSgIn0ClsW1V
         EufzotFzIa0oUUxK0VChrW9oGUmAqd9rg1g2gNhbIG1Hu2amXxWHX7S8QqwS3itJfZfx
         v1DjOyOg8hd21tDOU87+eZlVB2yu8VfpVWlQR0YAa9FDfreqWubqW9dAqTI1W1s/1AoC
         dIRvarabS8j52U5+tlKzF2PtDMZzyb+L8uy/cEAgkd6awNyVgXAAyCRwDDWNan1Vc32d
         jHf/gdVQ67SD6wweZRApGGgFJyLo7EZlro/D9n65OT45mp5tr6a0Yx1lLj68zP7enjWD
         tkng==
X-Forwarded-Encrypted: i=1; AJvYcCVUSOIzNl5wSbBucha2DPTy0vDKAfFFCznMZSNBg99pikq7hUWloU4/RvJ287p0znPJkawKY++avUB+VGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LLodNvsmcPH/ed0hXSCJvSGA4sd6B55iBGNxEXYStJnUvgZO
	EdZtKttvftowhYdFiwAAYPqgi3bVEPPdRtazxjFIzSX3mEcUcr5m5qkjXdr648TyTRmHXaYfm7R
	h7QSbE3Fgyzw2qiY21DWRaF9ocYdnJTJiBqRteQ4lpQ==
X-Gm-Gg: ASbGncuJnml6D2Kmza18vMiXy96BhEnGmCYRpK3yv2F5mKFx+SPP83V/Rxb2rs07+oe
	fTl53Sc47uioyF07RAWNGnVm3SPURR3KDvYholVqc2sLKsvliaPDhlyHsmWoEd6UhwJb/2xPPVB
	bHTzHCn2MJkM/Zdvb+X/zQZFMavn/TsS9qvC3wIpZFf0E9UZtZMI9pDk54w+uxr6TJAXFuTPtBt
	mNL6B1w
X-Google-Smtp-Source: AGHT+IGI01nt/5ajRIEd/g/MYYkHAENe8uTVuWwKi9fXBY6lvrfHdbPFp85gGg1wpDr38Z4dWnZtmPTXqXWXRm4y5Hw=
X-Received: by 2002:a2e:b750:0:b0:32f:1c10:fa with SMTP id 38308e7fff4ca-332567e1fbfmr14536171fa.28.1754230058857;
 Sun, 03 Aug 2025 07:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728094032.63545-1-apatel@ventanamicro.com>
 <20250728094032.63545-3-apatel@ventanamicro.com> <612a13d3-d3a6-460b-90fd-c26e47b80711@sifive.com>
In-Reply-To: <612a13d3-d3a6-460b-90fd-c26e47b80711@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 3 Aug 2025 19:37:27 +0530
X-Gm-Features: Ac12FXxM6lZVHsF2fkqmflt_uD2kktQDD8J5muF5ctWK04jd5MRevT31V0qlm18
Message-ID: <CAK9=C2Vaf5wuHW3db97TKJBQd7RjOng1mTGXZmoswJh3XxMNiw@mail.gmail.com>
Subject: Re: [PATCH v9 02/24] dt-bindings: mailbox: Add bindings for RISC-V
 SBI MPXY extension
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 9:42=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Anup,
>
> On 2025-07-28 4:40 AM, Anup Patel wrote:
> > Add device tree bindings for the RISC-V SBI Message Proxy (MPXY)
> > extension as a mailbox controller.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi=
-mpxy-mbox.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-m=
box.yaml b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.ya=
ml
> > new file mode 100644
> > index 000000000000..061437a0b45a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yam=
l
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V SBI Message Proxy (MPXY) extension based mailbox
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description: |
> > +  The RISC-V SBI Message Proxy (MPXY) extension [1] allows supervisor
> > +  software to send messages through the SBI implementation (M-mode
> > +  firmware or HS-mode hypervisor). The underlying message protocol
> > +  and message format used by the supervisor software could be some
> > +  other standard protocol compatible with the SBI MPXY extension
> > +  (such as RISC-V Platform Management Interface (RPMI) [2]).
> > +
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  References
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +  [1] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> > +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> > +
> > +  [2] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> > +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> > +
> > +properties:
> > +  compatible:
> > +    const: riscv,sbi-mpxy-mbox
> > +
> > +  "#mbox-cells":
> > +    const: 2
> > +    description:
> > +      The first cell specifies channel_id of the SBI MPXY channel,
> > +      the second cell specifies MSG_PROT_ID of the SBI MPXY channel
>
> What is the purpose of the second mailbox cell?
>
> The client can probe the message protocol using a SBI call, if it doesn't=
 just
> assume a protocol based on the kind of node that references this mailbox.=
 The
> SBI implementation knows the message protocol from the kind of node that
> instantiates the channel (for example riscv,rpmi-mpxy-clock has
> riscv,sbi-mpxy-channel-id). So this cell looks redundant.

It is the SBI MPXY mailbox controller driver which does SBI calls
and not the RPMI client driver. The RPMI client driver (for example
RPMI clock driver) only xfer RPMI messages so it only needs mailbox
channels bound to RPMI protocol. This way same RPMI client driver
will work for both SBI MPXY mailbox controller driver and RPMI shared
memory mailbox controller driver.
(NOTE: RPMI shared memory mailbox controller driver is currently
not available for Linux.)

The SBI MPXY mailbox controller driver provides mailbox channels
for RPMI protocol and other custom message protocols as well so
if a RPMI mailbox client request a mailbox channel bound to some
other protocol then such a mailbox channel request should fail. To
achieve this, we have a second mailbox cell for mailbox channels
provided by SBI MPXY mailbox controller driver which specifies the
expected message protocol ID for the mailbox channel.

On other hand, the RPMI shared memory mailbox controller driver
will only provide mailbox channels bound to RPMI protocol and
not any other message protocol so for such mailbox channels we
only need one mailbox cell which specifies the service group ID.

Regards,
Anup

