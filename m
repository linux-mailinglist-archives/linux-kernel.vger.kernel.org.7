Return-Path: <linux-kernel+bounces-850587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56954BD33BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8DD53463BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19093064B7;
	Mon, 13 Oct 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XIE6eJQk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50526D4C1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362773; cv=none; b=KTjH5iik8UyNC16Q40Tw1V66eeXp7t7cxN0zfXFHFwm5FO1Dw2Hry1fCEUq6Jx6ghnKvBpCZD+7Muwy9/W0tCPYBmDe/5VR/8JB8M2jpm+cZJg2Dn//yDuxjRZGhsai5giVSne+eoTlF0q3YFDyoiOc/ds642s0MJtvjugg+wiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362773; c=relaxed/simple;
	bh=+yB+enDuPJv20af+tFiH7Rbky+TskctoJ6/ZmNsCgoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ3RUhpcAF+s4x9evXKOvb6OkAMkVG8HLjKSkV2l1p7p9Dv9w7o4FOdhl/Gx9mQsMTfZpOczcxzlTiMB8c5bydnvQL7zOAuC/dLfdOwZTXXHYUOe2mNCwCvuNbZNGFr0o3dzx3AiVGHIBMqQAcpeb48mnasZ3uKUnLqgj56W+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XIE6eJQk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-273a0aeed57so63724305ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760362770; x=1760967570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYwqHSAoqEx6cdcSctyIP5QRyJuyb0wi9zzKj0Pf+Fs=;
        b=XIE6eJQkkzrCLnr5octEHSb3y5auEIMi78NfleZKuTcRRO3Xk4/HA6ffcCGV4IIf0x
         Fq/m2DBLJgjnNljoeyK2kUAIOzYTFQa5gbV2ClU00DGcxKVoKz6n4qdGx3CqruLOax9a
         xSQIsLzfMXQ8NT3n11n2xlSRdW0uB2regxRVHxGgZ72BacJbj4uaSpzpwGVcuebTVH0o
         7ZVapdh6lkhO943hYtueq/f4xVIGhnltVMrpmCrNrwL82Rm3a4BL5dNBJZU0h0mj44MJ
         A74/iF1yC95a6uxUUusoe7KGFQAwfD3rjFiWRRm7otOmUM+StqeufUEKYvzZJ+zL7t63
         IWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362770; x=1760967570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYwqHSAoqEx6cdcSctyIP5QRyJuyb0wi9zzKj0Pf+Fs=;
        b=JFYF8wUq/cJvbIfMag0AAiLitDD02lkL7z0IciKSQwhOrTUSf4NxKeIyTE5sJOxLs0
         oeXHqjFjnxO1V+uSGe592RPr8MAU23xQzoeXfX7dLi8dFx8Yx2z4yZ9Pu4xk/WoW6gfY
         9a9aOT29w1VxjS+sC7lScptBGw8vyj8VyAnB0bKNLAOkNu+9RzLhOkBlBYHjq51Bw2fn
         nEdb2AD/PzokzQ0zbs7bhivXm68R6B8GdhWhfCREUkdmn7LKlD2lkZVDA4s7G1ujKgwk
         hepCRdRJcCI2FL1rqWcguQeq/MPuxkBYHPA/q8837t9j2kfnt7KH2kp+ED5zc8X0U3a5
         dK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKW0qBus3hZ8brmfjd/g4EzN4KCdYyK/Ns5gns8EJMvkMR42nJSN6bxgvrO1oTi5K/yIPbQ2mjM2yJ3zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEz6Wseo/38YPVT5cs+cVRwhgmFOqg06h8IuthUNCMMnGYN1F
	k3M6DdvCBCEECxjWCZy7CL9DsyNZqhnNarjE0+h92TXjoV3Djazc5OiBKr0Wd3eexpV4EVBOfAF
	f3Y+EyzQUWsH+YEBbiJGgnz5A/ibUl3w3EFN/l0Je/Q==
X-Gm-Gg: ASbGncv6s0uX+xNnQn6UxTNeyu5rSLF7qtclWaLgaeieETgMbEZijGQu+HP0tIXo9Pq
	MLJyBz3vmrXX3D+LQpbVYGsTn235TBp3OMBTtfUPlslLtvMVxBeIPb5wtr/DGdPCovMYoywcYo2
	ivImM2H0VuLvzWCtetth83wXVoonUEvRV+USE4uS5mReC7bUUMLfWU1vCpkOsYVp1wAfQJmn7q7
	p+zgni70L2JM9fLuv+JKN/eSfjqUqqYGOPR24PawVhHn1udbrhGELNvaLK8V8iSiSFz6xTOFnbG
	jarSD9oglCDqHf76ZMbN5/3qM/JOtEMZHKGt2VDshR7ABykxU6o=
X-Google-Smtp-Source: AGHT+IE+0izChbPFkJdEKC8g0J0WRD2X49UUI9MXqjipJ7IlvbM3pJhg2JowFrzFl3z8G63EB/I+nzDZ2+l4fy3hEk0=
X-Received: by 2002:a17:903:3d10:b0:283:f19a:bffe with SMTP id
 d9443c01a7336-29027e734acmr269368095ad.7.1760362769784; Mon, 13 Oct 2025
 06:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-8-apatel@ventanamicro.com> <9422ba89-a6ba-4168-98a1-6d4275698430@gmail.com>
 <CAN37VV5J2+gzpraR2NhaJBNfQ3dPsr-72Mmg03+ykcLoouZ8_Q@mail.gmail.com> <3af020da-f61b-4a32-8209-227b8fe58a78@gmail.com>
In-Reply-To: <3af020da-f61b-4a32-8209-227b8fe58a78@gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 13 Oct 2025 19:08:52 +0530
X-Gm-Features: AS18NWA6rP0C8etffBvWluM8B9nDXPpHi_fNoivc9yOraZMaSMmgGezdAWP20Mw
Message-ID: <CAN37VV6j3qzsrM5BRu+WvvAW4aMDOgkXZRm5+Fn0VARz_qqApA@mail.gmail.com>
Subject: Re: [PATCH 07/11] rvtrace: Add trace ramsink driver
To: Bo Gan <ganboing@gmail.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Anup Patel <anup@brainfault.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mayuresh Chitale <mchitale@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>, 
	Liang Kan <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bo,

On Sat, Oct 11, 2025 at 6:08=E2=80=AFAM Bo Gan <ganboing@gmail.com> wrote:
>
> On 10/8/25 03:35, Mayuresh Chitale wrote:
> >
> >
> > On Tue, Oct 7, 2025 at 1:21=E2=80=AFPM Bo Gan <ganboing@gmail.com <mail=
to:ganboing@gmail.com>> wrote:
> >  >
> >  > On 10/1/25 23:07, Anup Patel wrote:
> >  > > From: Mayuresh Chitale <mchitale@ventanamicro.com <mailto:mchitale=
@ventanamicro.com>>
> >  > >
> >  > > Add initial implementation of RISC-V trace ramsink driver. The ram=
sink
> >  > > is defined in the RISC-V Trace Control Interface specification.
> >  > >
> >  > > Co-developed-by: Anup Patel <apatel@ventanamicro.com <mailto:apate=
l@ventanamicro.com>>
> >  > > Signed-off-by: Anup Patel <apatel@ventanamicro.com <mailto:apatel@=
ventanamicro.com>>
> >  > > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com <mailto=
:mchitale@ventanamicro.com>>
> >  > > ---
> >  > >   drivers/hwtracing/rvtrace/Kconfig           |   8 +
> >  > >   drivers/hwtracing/rvtrace/Makefile          |   1 +
> >  > >   drivers/hwtracing/rvtrace/rvtrace-ramsink.c | 198 ++++++++++++++=
++++++
> >  > >   3 files changed, 207 insertions(+)
> >  > >   create mode 100644 drivers/hwtracing/rvtrace/rvtrace-ramsink.c
> >  > >
> >  > > diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing=
/rvtrace/Kconfig
> >  > > index ba35c05f3f54..aef7e9989165 100644
> >  > > --- a/drivers/hwtracing/rvtrace/Kconfig
> >  > > +++ b/drivers/hwtracing/rvtrace/Kconfig
> >  > > @@ -21,3 +21,11 @@ config RVTRACE_ENCODER
> >  > >       default y
> >  > >       help
> >  > >         This driver provides support for RISC-V Trace Encoder comp=
onent.
> >  > > +
> >  > > +config RVTRACE_RAMSINK
> >  > > +     tristate "RISC-V Trace Ramsink driver"
> >  > > +     depends on RVTRACE
> >  > > +     default y
> >  > > +     help
> >  > > +       This driver provides support for Risc-V E-Trace Ramsink
> >  > > +       component.
> >  > > diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracin=
g/rvtrace/Makefile
> >  > > index f320693a1fc5..122e575da9fb 100644
> >  > > --- a/drivers/hwtracing/rvtrace/Makefile
> >  > > +++ b/drivers/hwtracing/rvtrace/Makefile
> >  > > @@ -3,3 +3,4 @@
> >  > >   obj-$(CONFIG_RVTRACE) +=3D rvtrace.o
> >  > >   rvtrace-y :=3D rvtrace-core.o rvtrace-platform.o
> >  > >   obj-$(CONFIG_RVTRACE_ENCODER) +=3D rvtrace-encoder.o
> >  > > +obj-$(CONFIG_RVTRACE_RAMSINK) +=3D rvtrace-ramsink.o
> >  > > diff --git a/drivers/hwtracing/rvtrace/rvtrace-ramsink.c b/drivers=
/hwtracing/rvtrace/rvtrace-ramsink.c
> >  > > new file mode 100644
> >  > > index 000000000000..7bd0cf1e4dfd
> >  > > --- /dev/null
> >  > > +++ b/drivers/hwtracing/rvtrace/rvtrace-ramsink.c
> >  > > @@ -0,0 +1,198 @@
> >  > > +// SPDX-License-Identifier: GPL-2.0
> >  > > +/*
> >  > > + * Copyright (c) 2025 Ventana Micro Systems Inc.
> >  > > + */
> >  > > +
> >  > > +#include <linux/device.h>
> >  > > +#include <linux/io.h>
> >  > > +#include <linux/of.h>
> >  > > +#include <linux/of_graph.h>
> >  > > +#include <linux/platform_device.h>
> >  > > +#include <linux/property.h>
> >  > > +#include <linux/dma-mapping.h>
> >  > > +#include <linux/rvtrace.h>
> >  > > +#include <linux/types.h>
> >  > > +#include <linux/sizes.h>
> >  > > +
> >  > > +#define RVTRACE_RAMSINK_STARTLOW_OFF         0x010
> >  > > +#define RVTRACE_RAMSINK_STARTHIGH_OFF                0x014
> >  > > +#define RVTRACE_RAMSINK_LIMITLOW_OFF         0x018
> >  > > +#define RVTRACE_RAMSINK_LIMITHIGH_OFF                0x01c
> >  > > +#define RVTRACE_RAMSINK_WPLOW_OFF            0x020
> >  > > +#define RVTRACE_RAMSINK_WPHIGH_OFF           0x024
> >  > > +#define RVTRACE_RAMSINK_RPLOW_OFF            0x028
> >  > > +#define RVTRACE_RAMSINK_RPHIGH_OFF           0x02c
> >  > > +
> >  > > +struct rvtrace_ramsink_priv {
> >  > > +     size_t size;
> >  > > +     void *va;
> >  > > +     dma_addr_t start;
> >  > > +     dma_addr_t end;
> >  > > +     /* WP from prev iteration */
> >  > > +     dma_addr_t prev_head;
> >  > > +};
> >  > > +
> >  > > +struct trace_buf {
> >  > > +     void *base;
> >  > > +     size_t size;
> >  > > +     int cur, len;
> >  > > +};
> >  > > +
> >  > > +static void tbuf_to_pbuf_copy(struct trace_buf *src, struct trace=
_buf *dst)
> >  > > +{
> >  > > +     int bytes_dst, bytes_src, bytes;
> >  > > +     void *dst_addr, *src_addr;
> >  > > +
> >  > > +     while (src->size) {
> >  > > +             src_addr =3D src->base + src->cur;
> >  > > +             dst_addr =3D dst->base + dst->cur;
> >  > > +
> >  > > +             if (dst->len - dst->cur < src->size)
> >  > > +                     bytes_dst =3D dst->len - dst->cur;
> >  > > +             else
> >  > > +                     bytes_dst =3D src->size;
> >  > > +             if (src->len - src->cur < src->size)
> >  > > +                     bytes_src =3D src->len - src->cur;
> >  > > +             else
> >  > > +                     bytes_src =3D src->size;
> >  > > +             bytes =3D bytes_dst < bytes_src ? bytes_dst : bytes_=
src;
> >  > > +             memcpy(dst_addr, src_addr, bytes);
> >  > > +             dst->cur =3D (dst->cur + bytes) % dst->len;
> >  > > +             src->cur =3D (src->cur + bytes) % src->len;
> >  > > +             src->size -=3D bytes;
> >  > > +     }
> >  > > +}
> >  > > +
> >  > > +static size_t rvtrace_ramsink_copyto_auxbuf(struct rvtrace_compon=
ent *comp,
> >  > > +                                         struct rvtrace_perf_auxb=
uf *buf)
> >  > > +{
> >  > > +     struct rvtrace_ramsink_priv *priv =3D dev_get_drvdata(&comp-=
>dev);
> >  > > +     struct trace_buf src, dst;
> >  > > +     u32 wp_low, wp_high;
> >  > > +     u64 buf_cur_head;
> >  > > +     size_t size;
> >  > > +
> >  > > +     wp_low =3D rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_WPLOW=
_OFF);
> >  > > +     wp_high =3D rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_WPHI=
GH_OFF);
> >  > > +     buf_cur_head =3D (u64)(wp_high) << 32 | wp_low;
> >  > > +
> >  > > +     if (buf_cur_head =3D=3D priv->prev_head)
> >  > > +             return 0;
> >  > > +
> >  > > +     dst.base =3D buf->base;
> >  > > +     dst.len =3D buf->length;
> >  > > +     dst.cur =3D buf->pos;
> >  > > +     dst.size =3D 0;
> >  > > +
> >  > > +     src.base =3D priv->va;
> >  > > +     src.len =3D priv->end - priv->start;
> >  > > +     if (buf_cur_head > priv->prev_head) {
> >  > > +             src.size =3D buf_cur_head - priv->prev_head;
> >  > > +     } else {
> >  > > +             src.size =3D priv->end - priv->prev_head;
> >  > > +             src.size +=3D buf_cur_head - priv->start;
> >  > > +     }
> >  > > +
> >  > > +     src.cur =3D buf_cur_head - priv->start;
> >  > > +     size =3D src.size;
> >  > > +     tbuf_to_pbuf_copy(&src, &dst);
> >  > > +     buf->pos =3D dst.cur;
> >  > > +     priv->prev_head =3D buf_cur_head;
> >  > > +
> >  > > +     return size;
> >  > > +}
> >  > > +
> >  > > +static int rvtrace_ramsink_setup(struct rvtrace_component *comp)
> >  > > +{
> >  > > +     struct rvtrace_ramsink_priv *priv;
> >  > > +
> >  > > +     priv =3D devm_kzalloc(&comp->dev, sizeof(*priv), GFP_KERNEL)=
;
> >  > > +     if (!priv)
> >  > > +             return -ENOMEM;
> >  > > +     dev_set_drvdata(&comp->dev, priv);
> >  > > +
> >  > > +     priv->size =3D SZ_4M;
> >  > Can we make this size dynamically determined? 4M seems inadequate. T=
his is
> >  > exceedingly so if the RAM sink is linked to a funnel, where you can =
have
> >  > many harts dumping traces into this sink.
> >  >
> >  > > +     priv->va =3D dma_alloc_coherent(&comp->dev, priv->size, &pri=
v->start, GFP_KERNEL);
> >  > > +     if (!priv->va)
> >  > > +             return -ENOMEM;
> >  > > +     priv->end =3D priv->start + priv->size;
> >  > > +     priv->prev_head =3D priv->start;
> >  > > +
> >  > > +     /* Setup ram sink addresses */
> >  > > +     rvtrace_write32(comp->pdata, lower_32_bits(priv->start), RVT=
RACE_RAMSINK_STARTLOW_OFF);
> >  > > +     rvtrace_write32(comp->pdata, upper_32_bits(priv->start), RVT=
RACE_RAMSINK_STARTHIGH_OFF);
> >  > > +     rvtrace_write32(comp->pdata, lower_32_bits(priv->start), RVT=
RACE_RAMSINK_WPLOW_OFF);
> >  > > +     rvtrace_write32(comp->pdata, upper_32_bits(priv->start), RVT=
RACE_RAMSINK_WPHIGH_OFF);
> >  > > +     /* Limit address needs to be set to end - 4 so that HW doesn=
't cause an overflow. */> + rvtrace_write32(comp->pdata, lower_32_bits(priv=
->end - 0x4), RVTRACE_RAMSINK_LIMITLOW_OFF);
> >  > Should not hardcode 4 as the trace write width. Control Interface Sp=
ec
> >  > chapter 7.1 has the proper instruction on how to probe for this widt=
h:
> >  >
> >  > "Not every value may be settable in trRamStart/Limit registers. Valu=
e
> >  >   written may be trimmed (for example aligned on a particular 2^N bo=
undary)
> >  >   and a trace tool should verify values being written"
> >  >
> > Thanks for the comments. I will incorporate those in v2.
>
> @Mayuresh, I went over the spec again. I don't see the handling off wrap.
> You need to detect if the buffer has wrapped around by testing bit 0 of
> trRamWPLow. So:
>
>   a. trRamWPLow needs masking bit 0 before being used as address to read
>      trace data.
The trRamWPLow isn't used directly and the size is calculated based on
current head(wpLow) and previous head values but I agree that
trRamWrap needs to be masked.
>   b. If wrapped, then the trace buffer is actually scattered in two parts=
:
>      [WP, Limit + width) and [Start, WP). During copying, you need to use
>      the right portion of the trace buffer.
This is done using the buf_cur_head and priv->head variables.
>
> ref: https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/funn=
el.py#L260
>
> BTW, again your mail wasn't delivered to the mailing-list for some reason
> Please check: I couldn't find your name on
>
> https://lists.infradead.org/pipermail/linux-riscv/2025-October/thread.htm=
l
> https://lore.kernel.org/all/20251002060732.100213-1-apatel@ventanamicro.c=
om/
In a previous reply the mode wasn't set to 'plain text'. I hope this
email gets delivered.
>
> >
> >  > > +     rvtrace_write32(comp->pdata, upper_32_bits(priv->end), RVTRA=
CE_RAMSINK_LIMITHIGH_OFF);
> >  > > +
> >  > > +     return 0;
> >  > > +}
> >  > > +
> >  > > +static void rvtrace_ramsink_cleanup(struct rvtrace_component *com=
p)
> >  > > +{
> >  > > +     struct rvtrace_ramsink_priv *priv =3D dev_get_drvdata(&comp-=
>dev);
> >  > > +
> >  > > +     dma_free_coherent(&comp->dev, priv->size, priv->va, priv->st=
art);
> >  > > +}
> >  > > +
> >  > > +static int rvtrace_ramsink_probe(struct rvtrace_component *comp)
> >  > > +{
> >  > > +     int ret;
> >  > > +
> >  > > +     ret =3D rvtrace_ramsink_setup(comp);
> >  > > +     if (ret)
> >  > > +             return dev_err_probe(&comp->dev, ret, "failed to set=
up ramsink.\n");
> >  > > +
> >  > > +     ret =3D rvtrace_enable_component(comp);
> >  > > +     if (ret)
> >  > > +             return dev_err_probe(&comp->dev, ret, "failed to ena=
ble ramsink.\n");
> >  > > +
> >  > > +     return ret;
> >  > > +}
> >  > > +
> >  > > +static void rvtrace_ramsink_remove(struct rvtrace_component *comp=
)
> >  > > +{
> >  > > +     int ret;
> >  > > +
> >  > > +     ret =3D rvtrace_disable_component(comp);
> >  > > +     if (ret)
> >  > > +             dev_err(&comp->dev, "failed to disable ramsink.\n");
> >  > > +
> >  > > +     rvtrace_ramsink_cleanup(comp);
> >  > > +}
> >  > > +
> >  > > +static struct rvtrace_component_id rvtrace_ramsink_ids[] =3D {
> >  > > +     { .type =3D RVTRACE_COMPONENT_TYPE_RAMSINK,
> >  > > +       .version =3D rvtrace_component_mkversion(1, 0), },
> >  > > +     {},
> >  > > +};
> >  > > +
> >  > > +static struct rvtrace_driver rvtrace_ramsink_driver =3D {
> >  > > +     .id_table =3D rvtrace_ramsink_ids,
> >  > > +     .copyto_auxbuf =3D rvtrace_ramsink_copyto_auxbuf,
> >  > > +     .probe =3D rvtrace_ramsink_probe,
> >  > > +     .remove =3D rvtrace_ramsink_remove,
> >  > > +     .driver =3D {
> >  > > +             .name =3D "rvtrace-ramsink",
> >  > > +     },
> >  > > +};
> >  > > +
> >  > > +static int __init rvtrace_ramsink_init(void)
> >  > > +{
> >  > > +     return rvtrace_register_driver(&rvtrace_ramsink_driver);
> >  > > +}
> >  > > +
> >  > > +static void __exit rvtrace_ramsink_exit(void)
> >  > > +{
> >  > > +     rvtrace_unregister_driver(&rvtrace_ramsink_driver);
> >  > > +}
> >  > > +
> >  > > +module_init(rvtrace_ramsink_init);
> >  > > +module_exit(rvtrace_ramsink_exit);
> >  > > +
> >  > > +/* Module information */
> >  > > +MODULE_AUTHOR("Mayuresh Chitale <mchitale@ventanamicro.com <mailt=
o:mchitale@ventanamicro.com>>");
> >  > > +MODULE_DESCRIPTION("RISC-V Trace Ramsink Driver");
> >  > > +MODULE_LICENSE("GPL");
> >  >
> >  > Bo
>
> Bo

