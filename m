Return-Path: <linux-kernel+bounces-877782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1630C1F051
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDD7189A48B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078D337BAF;
	Thu, 30 Oct 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I8WaZNCv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4C273D66
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813439; cv=none; b=r9BV3FJ7ClSlZN1kuMgXwblOXBbZQ7YyG1t0ZXrQ2iwvYN4kkaKvMMichw7D+vWW6NJ7WbaKNM5jAkjEu9n+0qGbIlmrbUHRq6uvMyshQh6JkDynb2u4GDtfZpxvS9xsTt97qylW9zCztO0f3EBu756GFP2Hd/5g+9pg7A8oNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813439; c=relaxed/simple;
	bh=dOyie0yCXO/GbtAgnOj61Pq33OYi7CnHGt//vwdbqO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heN4w7xTS5lpYwlADXyhewAeGQynTWkAAMKZqQVbmMHcPW33YLOoViZMxhXkwbGtTVkcQNrOmhsFnU7h8tFvnEhWLUlviZswz/WxpG9DZaRiPjD4NkKXbLIJGgt4yQnjcFiOSpJG/qR8BKEXZaRFicyqTYYDo0KyOVQHfBTzLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=I8WaZNCv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-592f1988a2dso2071585e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761813435; x=1762418235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PhiALHDI2i2xAY9PDd3sY1TK4QtQDn4cEBZj3KzuzY=;
        b=I8WaZNCv7kHw9wSyLYIo83UibJXN/D3VFwOReJsbdKZg+l1/OFRThbOhnYBm3IO2Jd
         GyLBxl4D3XLPuD/PMtSbMoVicUOleQ4ku3iq8srodxFZw8xyRGR/XTuO/6iQbcv4dllm
         ioSLWwiO4K7o+2tfwhFKV5ir1G1W8AikBc6NpBmYaYnb48d/HQ5KnpwSaDRW8f7mTf98
         97IB28FSbsqbctlTBh1T0RrMkSMzoBqXBwLz4TFR/rudvXrUjUlapomHJuy/dmBVjRIB
         zobxLk/PC34k2F0wVCruzM57OyFGCIzO0qezoHqWfOtBKp1e5U70D73hTP6JXnYfsnDy
         rzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813435; x=1762418235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PhiALHDI2i2xAY9PDd3sY1TK4QtQDn4cEBZj3KzuzY=;
        b=NCHhuzbT7Ir1LQbaeAvCRcRfE3kPFPY9WHjscleAASztrxizI/9/MOYX19miLCy/1u
         d3Ad3c5yp9VALvRkaWk7bNFkRfSqTtaPlxENSmDp3PCZhWz6sOW4BsgIsIYzKomYJl6Q
         9KRngaJEMwPwqFYHeiwHMUmHBfgfjr+0vIWPeqDdhNm4Y8qvLRxZv9c++VMDG+FBBoKV
         86dZlAnSO1K1AiEOGfCbipjUEqjR5QoUvuzMXc7CbgazOvWiFSmEzX+XwcdzTfxkYnpY
         orbMjNCmN8dXtvy1VA/9gwqJkAVXXKuPx+jHzPXMV5mEwXVb5s4P4pLnYbP1c8dsCQ0c
         YdQw==
X-Forwarded-Encrypted: i=1; AJvYcCX45y9fJwXNeTvP3cjnwFCTdHdfVyMQPx/ZHJxWjIb923IRVdMgjf0zbvdph+sJZAqBv/9JOCtKACle3rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6adFuh8gMxU6YvGfFAhft/1bk9gMZKHAW2JxNxJQBqIkusZo
	dmr8sDHUdu01Ui7YxUy+XqQPkLtoz6729z5NmNjCrsj6B8QJEO/znNeGiARvw2sNWeHK0RdMhoI
	FSaCK5YxaLnLZr+cNgh2oe6gHHgX2fm+JRPERW5w8yA==
X-Gm-Gg: ASbGncvZIzK/3TOaLIA7n7KpocNWisIkO+YkYh/D3njklfJI63HbmXIJC0tTIsUWXxi
	0t+DRCOSqAgm5khQeqvINXNJEHz4JeHxAFPxTJ9n2CGOq1qpnTESxxQ25h79tUNukiSbkQgeDJ9
	2Cm/pOwuBw9o0zui6Ilpdk0BjmsBOC8fccOlzbpCvejFpDiSnh3+vbcaJLGL0B0mngIAaUuyEV1
	wFr35VZkQlgGDdLvT/iYvxcT4q+yMi6NA6KOOGq6l8epNFwInqUZ39+8Wbd4g==
X-Google-Smtp-Source: AGHT+IHkpyb2Sv1I8gNm5QUQRU3yZvJ68ZqIsxkusGiO4qQw5aPSH5scs2Ze+urNswiBjd70TZnxpRoAHCaHRkKxXf4=
X-Received: by 2002:a05:6512:a81:b0:591:c6eb:baf1 with SMTP id
 2adb3069b0e04-59416d939admr703103e87.20.1761813434324; Thu, 30 Oct 2025
 01:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-3-apatel@ventanamicro.com> <55fd77a1-19c8-40b1-a3b2-6202d0ae5241@gmail.com>
In-Reply-To: <55fd77a1-19c8-40b1-a3b2-6202d0ae5241@gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 30 Oct 2025 14:07:01 +0530
X-Gm-Features: AWmQ_bnmwrSbXZJO-T_TY1nYSCXBiUmZqrb2LCfIRqGLtz7qgG95-xNPxd1Yw2M
Message-ID: <CAK9=C2Vpd8EajVXdnwMjSjSFkt4OFkn8OT4XHr-Nfs6ipjynpg@mail.gmail.com>
Subject: Re: [PATCH 02/11] rvtrace: Initial implementation of driver framework
To: Bo Gan <ganboing@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Anup Patel <anup@brainfault.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mayuresh Chitale <mchitale@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>, Liang Kan <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 6:33=E2=80=AFAM Bo Gan <ganboing@gmail.com> wrote:
>
> On 10/1/25 23:07, Anup Patel wrote:
> > The RISC-V Trace Control Interface Specification [1] defines a standard
> > way of implementing RISC-V trace related modular components irrespectiv=
e
> > to underlying trace format (E-trace or N-trace). These RISC-V trace
> > components are organized in a graph-like topology where each RISC-V
> > hart has its own RISC-V trace encoder component.
> >
> > Implement a basic driver framework for RISC-V trace where RISC-V trace
> > components are instantiated by a common platform driver and a separate
> > RISC-V trace driver for each type of RISC-V trace component.
> >
> > [1] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1=
.0_Ratified/RISC-V-Trace-Control-Interface.pdf
> >
> > Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >   drivers/Makefile                             |   1 +
> >   drivers/hwtracing/Kconfig                    |   2 +
> >   drivers/hwtracing/rvtrace/Kconfig            |  16 +
> >   drivers/hwtracing/rvtrace/Makefile           |   4 +
> >   drivers/hwtracing/rvtrace/rvtrace-core.c     | 484 ++++++++++++++++++=
+
> >   drivers/hwtracing/rvtrace/rvtrace-platform.c | 174 +++++++
> >   include/linux/rvtrace.h                      | 272 +++++++++++
> >   7 files changed, 953 insertions(+)
> >   create mode 100644 drivers/hwtracing/rvtrace/Kconfig
> >   create mode 100644 drivers/hwtracing/rvtrace/Makefile
> >   create mode 100644 drivers/hwtracing/rvtrace/rvtrace-core.c
> >   create mode 100644 drivers/hwtracing/rvtrace/rvtrace-platform.c
> >   create mode 100644 include/linux/rvtrace.h
> >
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index b5749cf67044..466a55580f60 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -178,6 +178,7 @@ obj-$(CONFIG_CORESIGHT)           +=3D hwtracing/co=
resight/
> >   obj-y                               +=3D hwtracing/intel_th/
> >   obj-$(CONFIG_STM)           +=3D hwtracing/stm/
> >   obj-$(CONFIG_HISI_PTT)              +=3D hwtracing/ptt/
> > +obj-$(CONFIG_RVTRACE)                +=3D hwtracing/rvtrace/
> >   obj-y                               +=3D android/
> >   obj-$(CONFIG_NVMEM)         +=3D nvmem/
> >   obj-$(CONFIG_FPGA)          +=3D fpga/
> > diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
> > index 911ee977103c..daeb38fe332d 100644
> > --- a/drivers/hwtracing/Kconfig
> > +++ b/drivers/hwtracing/Kconfig
> > @@ -7,4 +7,6 @@ source "drivers/hwtracing/intel_th/Kconfig"
> >
> >   source "drivers/hwtracing/ptt/Kconfig"
> >
> > +source "drivers/hwtracing/rvtrace/Kconfig"
> > +
> >   endmenu
> > diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtr=
ace/Kconfig
> > new file mode 100644
> > index 000000000000..f8f6feea1953
> > --- /dev/null
> > +++ b/drivers/hwtracing/rvtrace/Kconfig
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +menuconfig RVTRACE
> > +     tristate "RISC-V Trace Support"
> > +     depends on RISCV
> > +     depends on OF
> > +     default RISCV
> > +     help
> > +       This framework provides a kernel interface for the RISC-V trace
> > +       drivers (including both e-trace and n-trace). It's intended to
> > +       build a topological view of the RISC-V trace components and
> > +       configure the right series of components when trace is enabled
> > +       on a CPU.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called rvtrace.
> > diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvt=
race/Makefile
> > new file mode 100644
> > index 000000000000..988525a379cf
> > --- /dev/null
> > +++ b/drivers/hwtracing/rvtrace/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_RVTRACE) +=3D rvtrace.o
> > +rvtrace-y :=3D rvtrace-core.o rvtrace-platform.o
> > diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtraci=
ng/rvtrace/rvtrace-core.c
> > new file mode 100644
> > index 000000000000..52ea931745fc
> > --- /dev/null
> > +++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
> > @@ -0,0 +1,484 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2025 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/cpumask.h>
> > +#include <linux/delay.h>
> > +#include <linux/export.h>
> > +#include <linux/idr.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/percpu.h>
> > +#include <linux/rvtrace.h>
> > +
> > +/* Mutex to serialize component registration/unregistration */
> > +static DEFINE_MUTEX(rvtrace_mutex);
> > +
> > +/* Per-CPU encoder instances */
> > +static DEFINE_PER_CPU(struct rvtrace_component *, rvtrace_cpu_encoder)=
;
> > +
> > +/* Component type based id generator */
> > +struct rvtrace_type_idx {
> > +     /* Lock to protect the type ID generator */
> > +     struct mutex lock;
> > +     struct idr idr;
> > +};
> > +
> > +/* Array of component type based id generator */
> > +static struct rvtrace_type_idx rvtrace_type_idx_array[RVTRACE_COMPONEN=
T_TYPE_MAX];
> > +
> > +static int rvtrace_alloc_type_idx(struct rvtrace_component *comp)
> > +{
> > +     struct rvtrace_type_idx *rvidx =3D &rvtrace_type_idx_array[comp->=
id.type];
> > +     int idx;
> > +
> > +     mutex_lock(&rvidx->lock);
> > +     idx =3D idr_alloc(&rvidx->idr, comp, 0, 0, GFP_KERNEL);
> > +     mutex_unlock(&rvidx->lock);
> > +     if (idx < 0)
> > +             return idx;
> > +
> > +     comp->type_idx =3D idx;
> > +     return 0;
> > +}
> > +
> > +static void rvtrace_free_type_idx(struct rvtrace_component *comp)
> > +{
> > +     struct rvtrace_type_idx *rvidx =3D &rvtrace_type_idx_array[comp->=
id.type];
> > +
> > +     mutex_lock(&rvidx->lock);
> > +     idr_remove(&rvidx->idr, comp->type_idx);
> > +     mutex_unlock(&rvidx->lock);
> > +}
> > +
> > +static void __init rvtrace_init_type_idx(void)
> > +{
> > +     struct rvtrace_type_idx *rvidx;
> > +     int i;
> > +
> > +     for (i =3D 0; i < RVTRACE_COMPONENT_TYPE_MAX; i++) {
> > +             rvidx =3D &rvtrace_type_idx_array[i];
> > +             mutex_init(&rvidx->lock);
> > +             idr_init(&rvidx->idr);
> > +     }
> > +}
> > +
> > +const struct rvtrace_component_id *rvtrace_match_id(struct rvtrace_com=
ponent *comp,
> > +                                                 const struct rvtrace_=
component_id *ids)
> > +{
> > +     const struct rvtrace_component_id *id;
> > +
> > +     for (id =3D ids; id->version && id->type; id++) {
> > +             if (comp->id.type =3D=3D id->type &&
> > +                 comp->id.version =3D=3D id->version)
> > +                     return id;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_match_id);
> > +
> > +static int rvtrace_match_device(struct device *dev, const struct devic=
e_driver *drv)
> > +{
> > +     const struct rvtrace_driver *rtdrv =3D to_rvtrace_driver(drv);
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +
> > +     return rvtrace_match_id(comp, rtdrv->id_table) ? 1 : 0;
> > +}
> > +
> > +static int rvtrace_probe(struct device *dev)
> > +{
> > +     const struct rvtrace_driver *rtdrv =3D to_rvtrace_driver(dev->dri=
ver);
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +     int ret =3D -ENODEV;
> > +
> > +     if (!rtdrv->probe)
> > +             return ret;
> > +
> > +     ret =3D rtdrv->probe(comp);
> > +     if (!ret)
> > +             comp->ready =3D true;
> > +
> > +     return ret;
> > +}
> > +
> > +static void rvtrace_remove(struct device *dev)
> > +{
> > +     const struct rvtrace_driver *rtdrv =3D to_rvtrace_driver(dev->dri=
ver);
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +
> > +     comp->ready =3D false;
> > +     if (rtdrv->remove)
> > +             rtdrv->remove(comp);
> > +}
> > +
> > +const struct bus_type rvtrace_bustype =3D {
> > +     .name   =3D "rvtrace",
> > +     .match  =3D rvtrace_match_device,
> > +     .probe  =3D rvtrace_probe,
> > +     .remove =3D rvtrace_remove,
> > +};
> > +
> > +struct rvtrace_fwnode_match_data {
> > +     struct fwnode_handle *fwnode;
> > +     struct rvtrace_component *match;
> > +};
> > +
> > +static int rvtrace_match_fwnode(struct device *dev, void *data)
> > +{
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +     struct rvtrace_fwnode_match_data *d =3D data;
> > +
> > +     if (device_match_fwnode(&comp->dev, d->fwnode)) {
> > +             d->match =3D comp;
> > +             return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +struct rvtrace_component *rvtrace_find_by_fwnode(struct fwnode_handle =
*fwnode)
> > +{
> > +     struct rvtrace_fwnode_match_data d =3D { .fwnode =3D fwnode, .mat=
ch =3D NULL };
> > +     int ret;
> > +
> > +     ret =3D bus_for_each_dev(&rvtrace_bustype, NULL, &d, rvtrace_matc=
h_fwnode);
> > +     if (ret < 0)
> > +             return ERR_PTR(ret);
> > +
> > +     return d.match;
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_find_by_fwnode);
> > +
> > +int rvtrace_poll_bit(struct rvtrace_platform_data *pdata, int offset,
> > +                  int bit, int bitval, int timeout)
> > +{
> > +     int i =3D 10;
> > +     u32 val;
> > +
> > +     while (i--) {
> > +             val =3D rvtrace_read32(pdata, offset);
> > +             if (((val >> bit) & 0x1) =3D=3D bitval)
> > +                     break;
> > +             udelay(timeout);
> > +     }
> > +
> > +     return (i < 0) ? -ETIMEDOUT : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_poll_bit);
> > +
> > +int rvtrace_enable_component(struct rvtrace_component *comp)
> > +{
> > +     u32 val;
> > +
> > +     val =3D rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET=
);
> > +     val |=3D BIT(RVTRACE_COMPONENT_CTRL_ENABLE_SHIFT);
> > +     rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
> > +     return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSE=
T,
> > +                             RVTRACE_COMPONENT_CTRL_ENABLE_SHIFT, 1,
> > +                             comp->pdata->control_poll_timeout_usecs);
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_enable_component);
> > +
> > +int rvtrace_disable_component(struct rvtrace_component *comp)
> > +{
> > +     u32 val;
> > +
> > +     val =3D rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET=
);
> > +     val &=3D ~BIT(RVTRACE_COMPONENT_CTRL_ENABLE_SHIFT);
> > +     rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
> > +     return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSE=
T,
> > +                             RVTRACE_COMPONENT_CTRL_ENABLE_SHIFT, 0,
> > +                             comp->pdata->control_poll_timeout_usecs);
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_disable_component);
> > +
> > +struct rvtrace_component *rvtrace_cpu_source(unsigned int cpu)
> > +{
> > +     if (!cpu_present(cpu))
> > +             return NULL;
> > +
> > +     return per_cpu(rvtrace_cpu_encoder, cpu);
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_cpu_source);
> > +
> > +static int rvtrace_cleanup_inconn(struct device *dev, void *data)
> > +{
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +     struct rvtrace_platform_data *pdata =3D comp->pdata;
> > +     struct rvtrace_connection *conn =3D data;
> > +     int i;
> > +
> > +     if (device_match_fwnode(&comp->dev, conn->dest_fwnode)) {
> > +             for (i =3D 0; i < pdata->nr_inconns; i++) {
> > +                     if (pdata->inconns[i] !=3D conn)
> > +                             continue;
> > +                     pdata->inconns[i] =3D NULL;
> > +                     return 1;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void rvtrace_cleanup_inconns_from_outconns(struct rvtrace_compo=
nent *comp)
> > +{
> > +     struct rvtrace_platform_data *pdata =3D comp->pdata;
> > +     struct rvtrace_connection *conn;
> > +     int i;
> > +
> > +     lockdep_assert_held(&rvtrace_mutex);
> > +
> > +     for (i =3D 0; i < pdata->nr_outconns; i++) {
> > +             conn =3D pdata->outconns[i];
> > +             bus_for_each_dev(&rvtrace_bustype, NULL, conn, rvtrace_cl=
eanup_inconn);
> > +     }
> > +}
> > +
> > +static int rvtrace_setup_inconn(struct device *dev, void *data)
> > +{
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +     struct rvtrace_platform_data *pdata =3D comp->pdata;
> > +     struct rvtrace_connection *conn =3D data;
> > +     int i;
> > +
> > +     if (device_match_fwnode(&comp->dev, conn->dest_fwnode)) {
> > +             for (i =3D 0; i < pdata->nr_inconns; i++) {
> > +                     if (pdata->inconns[i])
> > +                             continue;
> > +                     pdata->inconns[i] =3D conn;
> > +                     return 1;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int rvtrace_setup_inconns_from_outconns(struct rvtrace_componen=
t *comp)
> > +{
> > +     struct rvtrace_platform_data *pdata =3D comp->pdata;
> > +     struct rvtrace_connection *conn;
> > +     int i, ret;
> > +
> > +     lockdep_assert_held(&rvtrace_mutex);
> > +
> > +     for (i =3D 0; i < pdata->nr_outconns; i++) {
> > +             conn =3D pdata->outconns[i];
> > +             ret =3D bus_for_each_dev(&rvtrace_bustype, NULL, conn, rv=
trace_setup_inconn);
> > +             if (ret < 0) {
> > +                     rvtrace_cleanup_inconns_from_outconns(comp);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void rvtrace_component_release(struct device *dev)
> > +{
> > +     struct rvtrace_component *comp =3D to_rvtrace_component(dev);
> > +
> > +     fwnode_handle_put(comp->dev.fwnode);
> > +     rvtrace_free_type_idx(comp);
> > +     kfree(comp);
> > +}
> > +
> > +static int rvtrace_component_reset(struct rvtrace_platform_data *pdata=
)
> > +{
> > +     int ret;
> > +
> > +     rvtrace_write32(pdata, 0, RVTRACE_COMPONENT_CTRL_OFFSET);
> > +     ret =3D rvtrace_poll_bit(pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
> > +                            RVTRACE_COMPONENT_CTRL_ACTIVE_SHIFT, 0,
> > +                            pdata->control_poll_timeout_usecs);
> > +     if (ret)
> > +             return ret;
> > +
> > +     rvtrace_write32(pdata, RVTRACE_COMPONENT_CTRL_ACTIVE_MASK,
> > +                     RVTRACE_COMPONENT_CTRL_OFFSET);
> > +     return rvtrace_poll_bit(pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
> > +                             RVTRACE_COMPONENT_CTRL_ACTIVE_SHIFT, 1,
> > +                             pdata->control_poll_timeout_usecs);
> > +}
> > +
> > +struct rvtrace_component *rvtrace_register_component(struct rvtrace_pl=
atform_data *pdata)
> > +{
> > +     struct rvtrace_connection *conn;
> > +     struct rvtrace_component *comp;
> > +     u32 impl, type, major, minor;
> > +     int i, ret =3D 0;
> > +
> > +     if (!pdata || !pdata->dev) {
> > +             ret =3D -EINVAL;
> > +             goto err_out;
> > +     }
> > +
> > +     for (i =3D 0; i < pdata->nr_inconns; i++) {
> > +             if (pdata->inconns[i]) {
> > +                     ret =3D -EINVAL;
> > +                     goto err_out;
> > +             }
> > +     }
> > +
> > +     for (i =3D 0; i < pdata->nr_outconns; i++) {
> > +             conn =3D pdata->outconns[i];
> > +             if (!conn || conn->src_port < 0 || conn->src_comp ||
> > +                 !device_match_fwnode(pdata->dev, conn->src_fwnode) ||
> > +                 conn->dest_port < 0 || !conn->dest_fwnode || !conn->d=
est_comp) {
> > +                     ret =3D -EINVAL;
> > +                     goto err_out;
> > +             }
> > +     }
> > +
> > +     ret =3D rvtrace_component_reset(pdata);
> > +     if (ret)
> > +             goto err_out;
> > +
> > +     impl =3D rvtrace_read32(pdata, RVTRACE_COMPONENT_IMPL_OFFSET);
> > +     type =3D (impl >> RVTRACE_COMPONENT_IMPL_TYPE_SHIFT) &
> > +             RVTRACE_COMPONENT_IMPL_TYPE_MASK;
> > +     major =3D (impl >> RVTRACE_COMPONENT_IMPL_VERMAJOR_SHIFT) &
> > +             RVTRACE_COMPONENT_IMPL_VERMAJOR_MASK;
> > +     minor =3D (impl >> RVTRACE_COMPONENT_IMPL_VERMINOR_SHIFT) &
> > +             RVTRACE_COMPONENT_IMPL_VERMINOR_MASK;
> > +
> > +     if (pdata->bound_cpu >=3D 0 && !cpu_present(pdata->bound_cpu)) {
> > +             ret =3D -EINVAL;
> > +             goto err_out;
> > +     }
> > +     if (type =3D=3D RVTRACE_COMPONENT_TYPE_ENCODER && pdata->bound_cp=
u < 0) {
> > +             ret =3D -EINVAL;
> > +             goto err_out;
> > +     }
> > +
> > +     comp =3D kzalloc(sizeof(*comp), GFP_KERNEL);
> > +     if (!comp) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +     comp->pdata =3D pdata;
> > +     comp->id.type =3D type;
> > +     comp->id.version =3D rvtrace_component_mkversion(major, minor);
> > +     ret =3D rvtrace_alloc_type_idx(comp);
> > +     if (ret) {
> > +             kfree(comp);
> > +             goto err_out;
> > +     }
> > +
> > +     comp->dev.parent =3D pdata->dev;
> > +     comp->dev.coherent_dma_mask =3D pdata->dev->coherent_dma_mask;
> > +     comp->dev.release =3D rvtrace_component_release;
> > +     comp->dev.bus =3D &rvtrace_bustype;
> > +     comp->dev.fwnode =3D fwnode_handle_get(dev_fwnode(pdata->dev));
> > +     switch (comp->id.type) {
> > +     case RVTRACE_COMPONENT_TYPE_ENCODER:
> > +             dev_set_name(&comp->dev, "encoder-%d", comp->type_idx);
> > +             break;
> > +     case RVTRACE_COMPONENT_TYPE_FUNNEL:
> > +             dev_set_name(&comp->dev, "funnel-%d", comp->type_idx);
> > +             break;
> > +     case RVTRACE_COMPONENT_TYPE_RAMSINK:
> > +             dev_set_name(&comp->dev, "ramsink-%d", comp->type_idx);
> > +             break;
> > +     case RVTRACE_COMPONENT_TYPE_PIBSINK:
> > +             dev_set_name(&comp->dev, "pibsink-%d", comp->type_idx);
> > +             break;
> > +     case RVTRACE_COMPONENT_TYPE_ATBBRIDGE:
> > +             dev_set_name(&comp->dev, "atbbridge-%d", comp->type_idx);
> > +             break;
> > +     default:
> > +             dev_set_name(&comp->dev, "type%d-%d", comp->id.type, comp=
->type_idx);
> > +             break;
> > +     }
> > +
> > +     mutex_lock(&rvtrace_mutex);
> > +
> > +     ret =3D device_register(&comp->dev);
> > +     if (ret) {
> > +             put_device(&comp->dev);
> > +             goto err_out_unlock;
> > +     }
> > +
> > +     for (i =3D 0; i < pdata->nr_outconns; i++) {
> > +             conn =3D pdata->outconns[i];
> > +             conn->src_comp =3D comp;
> > +     }
> > +
> > +     ret =3D rvtrace_setup_inconns_from_outconns(comp);
> > +     if (ret < 0) {
> > +             device_unregister(&comp->dev);
> > +             goto err_out_unlock;
> > +     }
> > +
> > +     if (comp->id.type =3D=3D RVTRACE_COMPONENT_TYPE_ENCODER) {
> > +             rvtrace_get_component(comp);
> > +             per_cpu(rvtrace_cpu_encoder, comp->pdata->bound_cpu) =3D =
comp;
> > +     }
> > +
> > +     mutex_unlock(&rvtrace_mutex);
> > +
> > +     return comp;
> > +
> > +err_out_unlock:
> > +     mutex_unlock(&rvtrace_mutex);
> > +err_out:
> > +     return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_register_component);
> > +
> > +void rvtrace_unregister_component(struct rvtrace_component *comp)
> > +{
> > +     struct rvtrace_component *c;
> > +
> > +     mutex_lock(&rvtrace_mutex);
> > +
> > +     if (comp->id.type =3D=3D RVTRACE_COMPONENT_TYPE_ENCODER) {
> > +             c =3D per_cpu(rvtrace_cpu_encoder, comp->pdata->bound_cpu=
);
> > +             per_cpu(rvtrace_cpu_encoder, comp->pdata->bound_cpu) =3D =
NULL;
> > +             rvtrace_put_component(c);
> > +     }
> > +
> > +     rvtrace_cleanup_inconns_from_outconns(comp);
> > +     device_unregister(&comp->dev);
> > +
> > +     mutex_unlock(&rvtrace_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(rvtrace_unregister_component);
> > +
> > +int __rvtrace_register_driver(struct module *owner, struct rvtrace_dri=
ver *rtdrv)
> > +{
> > +     rtdrv->driver.owner =3D owner;
> > +     rtdrv->driver.bus =3D &rvtrace_bustype;
> > +
> > +     return driver_register(&rtdrv->driver);
> > +}
> > +EXPORT_SYMBOL_GPL(__rvtrace_register_driver);
> > +
> > +static int __init rvtrace_init(void)
> > +{
> > +     int ret;
> > +
> > +     rvtrace_init_type_idx();
> > +
> > +     ret =3D bus_register(&rvtrace_bustype);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D platform_driver_register(&rvtrace_platform_driver);
> > +     if (ret) {
> > +             bus_unregister(&rvtrace_bustype);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit rvtrace_exit(void)
> > +{
> > +     platform_driver_unregister(&rvtrace_platform_driver);
> > +     bus_unregister(&rvtrace_bustype);
> > +}
> > +
> > +module_init(rvtrace_init);
> > +module_exit(rvtrace_exit);
> > diff --git a/drivers/hwtracing/rvtrace/rvtrace-platform.c b/drivers/hwt=
racing/rvtrace/rvtrace-platform.c
> > new file mode 100644
> > index 000000000000..a110ff1f2f08
> > --- /dev/null
> > +++ b/drivers/hwtracing/rvtrace/rvtrace-platform.c
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2025 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/rvtrace.h>
> > +#include <linux/types.h>
> > +
> > +static int rvtrace_of_parse_outconns(struct rvtrace_platform_data *pda=
ta)
> > +{
> > +     struct device_node *parent, *ep_node, *rep_node, *rdev_node;
> > +     struct rvtrace_connection *conn;
> > +     struct of_endpoint ep, rep;
> > +     int ret =3D 0, i =3D 0;
> > +
> > +     parent =3D of_get_child_by_name(dev_of_node(pdata->dev), "out-por=
ts");
> > +     if (!parent)
> > +             return 0;
> > +
> > +     pdata->nr_outconns =3D of_graph_get_endpoint_count(parent);
> > +     pdata->outconns =3D devm_kcalloc(pdata->dev, pdata->nr_outconns,
> > +                                    sizeof(*pdata->outconns), GFP_KERN=
EL);
> > +     if (!pdata->outconns) {
> > +             ret =3D -ENOMEM;
> > +             goto done;
> > +     }
> > +
> > +     for_each_endpoint_of_node(parent, ep_node) {
> > +             conn =3D devm_kzalloc(pdata->dev, sizeof(*conn), GFP_KERN=
EL);
> > +             if (!conn) {
> > +                     of_node_put(ep_node);
> > +                     ret =3D -ENOMEM;
> > +                     break;
> > +             }
> > +
> > +             ret =3D of_graph_parse_endpoint(ep_node, &ep);
> > +             if (ret) {
> > +                     of_node_put(ep_node);
> > +                     break;
> > +             }
> > +
> > +             rep_node =3D of_graph_get_remote_endpoint(ep_node);
> > +             if (!rep_node) {
> > +                     ret =3D -ENODEV;
> > +                     of_node_put(ep_node);
> > +                     break;
> > +             }
> > +             rdev_node =3D of_graph_get_port_parent(rep_node);
> > +
> > +             ret =3D of_graph_parse_endpoint(rep_node, &rep);
> > +             if (ret) {
> > +                     of_node_put(ep_node);
> > +                     break;
> > +             }
> > +
> > +             conn->src_port =3D ep.port;
> > +             conn->src_fwnode =3D dev_fwnode(pdata->dev);
> > +             /* The 'src_comp' is set by rvtrace_register_component() =
*/
> > +             conn->src_comp =3D NULL;
> > +             conn->dest_port =3D rep.port;
> > +             conn->dest_fwnode =3D of_fwnode_handle(rdev_node);
>
> Don't you need the fwnode_handle_get the dest_fwnode to hold the referenc=
e
> to the sink like coresight does?
>
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/hwtracing/coresig=
ht/coresight-platform.c#L243

Okay, I will update.

>
> > +             conn->dest_comp =3D rvtrace_find_by_fwnode(conn->dest_fwn=
ode);
> > +             if (!conn->dest_comp) {
> > +                     ret =3D -EPROBE_DEFER;
> > +                     of_node_put(ep_node);
>
> Missing a break; here.
>
> I finally figured out the hang issue on my p550. It's caused by this miss=
ing
> "break;". It caused the "ep_node" to get of_node_put twice. Please check.

Good catch. Thanks for reporting.

>
> > +             }
> > +
> > +             pdata->outconns[i] =3D conn;
> > +             i++;
> > +     }
> > +
> > +done:
> > +     of_node_put(parent);
> > +     return ret;
> > +}
> > +
> > +static int rvtrace_of_parse_inconns(struct rvtrace_platform_data *pdat=
a)
> > +{
> > +     struct device_node *parent;
> > +     int ret =3D 0;
> > +
> > +     parent =3D of_get_child_by_name(dev_of_node(pdata->dev), "in-port=
s");
> > +     if (!parent)
> > +             return 0;
> > +
> > +     pdata->nr_inconns =3D of_graph_get_endpoint_count(parent);
> > +     pdata->inconns =3D devm_kcalloc(pdata->dev, pdata->nr_inconns,
> > +                                   sizeof(*pdata->inconns), GFP_KERNEL=
);
> > +     if (!pdata->inconns)
> > +             ret =3D -ENOMEM;
> > +
> > +     of_node_put(parent);
> > +     return ret;
> > +}
> > +
> > +static int rvtrace_platform_probe(struct platform_device *pdev)
> > +{
> > +     struct rvtrace_platform_data *pdata;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct rvtrace_component *comp;
> > +     struct device_node *node;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +     if (!pdata)
> > +             return -ENOMEM;
> > +     pdata->dev =3D dev;
> > +     pdata->impid =3D RVTRACE_COMPONENT_IMPID_UNKNOWN;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -EINVAL;
> > +
> > +     pdata->io_mem =3D true;
> > +     pdata->base =3D devm_ioremap(&pdev->dev, res->start, resource_siz=
e(res));
> > +     if (!pdata->base)
> > +             return dev_err_probe(dev, -ENOMEM, "failed to ioremap %pR=
\n", res);
> > +
> > +     pdata->bound_cpu =3D -1;
> > +     node =3D of_parse_phandle(dev_of_node(dev), "cpu", 0);
> > +     if (node) {
> > +             ret =3D of_cpu_node_to_id(node);
> > +             of_node_put(node);
> > +             if (ret < 0)
> > +                     return dev_err_probe(dev, ret, "failed to get CPU=
 id for %pOF\n", node);
> > +             pdata->bound_cpu =3D ret;
> > +     }
> > +
> > +     /* Default control poll timeout */
> > +     pdata->control_poll_timeout_usecs =3D 10;
> > +
> > +     ret =3D rvtrace_of_parse_outconns(pdata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to parse output co=
nnections\n");
> > +
> > +     ret =3D rvtrace_of_parse_inconns(pdata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to parse input con=
nections\n");
> > +
> > +     comp =3D rvtrace_register_component(pdata);
> > +     if (IS_ERR(comp))
> > +             return PTR_ERR(comp);
> > +
> > +     platform_set_drvdata(pdev, comp);
> > +     return 0;
> > +}
> > +
> > +static void rvtrace_platform_remove(struct platform_device *pdev)
> > +{
> > +     struct rvtrace_component *comp =3D platform_get_drvdata(pdev);
> > +
> > +     rvtrace_unregister_component(comp);> +}
> > +
> > +static const struct of_device_id rvtrace_platform_match[] =3D {
> > +     { .compatible =3D "riscv,trace-component" },
> > +     {}
> > +};
> > +
> > +struct platform_driver rvtrace_platform_driver =3D {
> > +     .driver =3D {
> > +             .name           =3D "rvtrace",
> > +             .of_match_table =3D rvtrace_platform_match,
> > +     },
> > +     .probe =3D rvtrace_platform_probe,
> > +     .remove =3D rvtrace_platform_remove,
> > +};
> > diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
> > new file mode 100644
> > index 000000000000..04eb03e62601
> > --- /dev/null
> > +++ b/include/linux/rvtrace.h
> > @@ -0,0 +1,272 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2025 Ventana Micro Systems Inc.
> > + */
> > +
> > +#ifndef __LINUX_RVTRACE_H__
> > +#define __LINUX_RVTRACE_H__
> > +
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/types.h>
> > +
> > +/* Control register common across all RISC-V trace components */
> > +#define RVTRACE_COMPONENT_CTRL_OFFSET                0x000
> > +#define RVTRACE_COMPONENT_CTRL_ACTIVE_MASK   0x1
> > +#define RVTRACE_COMPONENT_CTRL_ACTIVE_SHIFT  0
> > +#define RVTRACE_COMPONENT_CTRL_ENABLE_MASK   0x1
> > +#define RVTRACE_COMPONENT_CTRL_ENABLE_SHIFT  1
> > +
> > +/* Implementation register common across all RISC-V trace components *=
/
> > +#define RVTRACE_COMPONENT_IMPL_OFFSET                0x004
> > +#define RVTRACE_COMPONENT_IMPL_VERMAJOR_MASK 0xf
> > +#define RVTRACE_COMPONENT_IMPL_VERMAJOR_SHIFT        0
> > +#define RVTRACE_COMPONENT_IMPL_VERMINOR_MASK 0xf
> > +#define RVTRACE_COMPONENT_IMPL_VERMINOR_SHIFT        4
> > +#define RVTRACE_COMPONENT_IMPL_TYPE_MASK     0xf
> > +#define RVTRACE_COMPONENT_IMPL_TYPE_SHIFT    8
> > +
> > +/* Possible component types defined by the RISC-V Trace Control Interf=
ace */
> > +enum rvtrace_component_type {
> > +     RVTRACE_COMPONENT_TYPE_RESV0,
> > +     RVTRACE_COMPONENT_TYPE_ENCODER, /* 0x1 */
> > +     RVTRACE_COMPONENT_TYPE_RESV2,
> > +     RVTRACE_COMPONENT_TYPE_RESV3,
> > +     RVTRACE_COMPONENT_TYPE_RESV4,
> > +     RVTRACE_COMPONENT_TYPE_RESV5,
> > +     RVTRACE_COMPONENT_TYPE_RESV6,
> > +     RVTRACE_COMPONENT_TYPE_RESV7,
> > +     RVTRACE_COMPONENT_TYPE_FUNNEL, /* 0x8 */
> > +     RVTRACE_COMPONENT_TYPE_RAMSINK, /* 0x9 */
> > +     RVTRACE_COMPONENT_TYPE_PIBSINK, /* 0xA */
> > +     RVTRACE_COMPONENT_TYPE_RESV11,
> > +     RVTRACE_COMPONENT_TYPE_RESV12,
> > +     RVTRACE_COMPONENT_TYPE_RESV13,
> > +     RVTRACE_COMPONENT_TYPE_ATBBRIDGE, /* 0xE */
> > +     RVTRACE_COMPONENT_TYPE_RESV15,
> > +     RVTRACE_COMPONENT_TYPE_MAX
> > +};
> > +
> > +/* Encoding/decoding macros for RISC-V trace component version */
> > +#define rvtrace_component_version_major(__version)   \
> > +     (((__version) >> 16) & 0xffff)
> > +#define rvtrace_component_version_minor(__version)   \
> > +     ((__version) & 0xffff)
> > +#define rvtrace_component_mkversion(__major, __minor)        \
> > +     ((((__major) & 0xffff) << 16) | ((__minor) & 0xffff))
> > +
> > +/*
> > + * Possible component implementation IDs discovered from DT or ACPI
> > + * shared across the RISC-V trace drivers to infer trace parameters,
> > + * quirks, and work-arounds. These component implementation IDs are
> > + * internal to Linux and must not be exposed to user-space.
> > + *
> > + * The component implementation ID should be named as follows:
> > + *    RVTRACE_COMPONENT_IMPID_<vendor>_<part>
> > + */
> > +enum rvtrace_component_impid {
> > +     RVTRACE_COMPONENT_IMPID_UNKNOWN,
> > +     RVTRACE_COMPONENT_IMPID_MAX
> > +};
> > +
> > +/**
> > + * struct rvtrace_connection - Representation of a physical connection=
 between
> > + * two RISC-V trace components.
> > + * @src_port:    A connection's source port number.
> > + * @src_fwnode:  Source component's fwnode handle..
> > + * @src_comp:    Source component's pointer.
> > + * @dest_port:   A connection's destination port number.
> > + * @dest_fwnode: Destination component's fwnode handle.
> > + * @dest_comp:   Destination component's pointer.
> > + */
> > +struct rvtrace_connection {
> > +     int src_port;
> > +     struct fwnode_handle *src_fwnode;
> > +     int dest_port;
> > +     struct fwnode_handle *dest_fwnode;
> > +     struct rvtrace_component *src_comp;
> > +     struct rvtrace_component *dest_comp;
> > +};
> > +
> > +/**
> > + * struct rvtrace_platform_data - Platform-level data for a RISC-V tra=
ce component
> > + * discovered from DT or ACPI.
> > + * @dev:         Parent device.
> > + * @impid:       Component implementation ID
> > + * @io_mem:      Flag showing whether component registers are memory m=
apped.
> > + * @base:        If io_mem =3D=3D true then base address of the memory=
 mapped registers.
> > + * @read:        If io_mem =3D=3D false then read register from the gi=
ven "offset".
> > + * @write:       If io_mem =3D=3D false then write register to the giv=
en "offset".
> > + * @bound_cpu:   CPU to which the component is bound. This should be -=
1 if
> > + *               the component is not bound to any CPU. For encoder co=
mponent
> > + *               type this must not be -1.
> > + * @nr_inconns:  Number of input connections.
> > + * @inconns:     Array of pointers to input connections.
> > + * @nr_outconns: Number of output connections.
> > + * @outconns:    Array of pointers to output connections.
> > + */
> > +struct rvtrace_platform_data {
> > +     struct device *dev;
> > +
> > +     enum rvtrace_component_impid impid;
> > +
> > +     bool io_mem;
> > +     union {
> > +             void __iomem *base;
> > +             struct {
> > +                     u32 (*read)(struct rvtrace_platform_data *pdata,
> > +                                 u32 offset, bool relaxed);
> > +                     void (*write)(struct rvtrace_platform_data *pdata=
,
> > +                                   u32 val, u32 offset, bool relaxed);
> > +             };
> > +     };
> > +
> > +     int bound_cpu;
> > +
> > +     /* Delay in microseconds when polling control register bits */
> > +     int control_poll_timeout_usecs;
> > +
> > +     /*
> > +      * Platform driver must only populate empty pointer array without
> > +      * any actual input connections.
> > +      */
> > +     unsigned int nr_inconns;
> > +     struct rvtrace_connection **inconns;
> > +
> > +     /*
> > +      * Platform driver must fully populate pointer array with individ=
ual
> > +      * array elements pointing to actual output connections. The src_=
comp
> > +      * of each output connection is automatically updated at the time=
 of
> > +      * registering component.
> > +      */
> > +     unsigned int nr_outconns;
> > +     struct rvtrace_connection **outconns;
> > +};
> > +
> > +static inline u32 rvtrace_read32(struct rvtrace_platform_data *pdata, =
u32 offset)
> > +{
> > +     if (likely(pdata->io_mem))
> > +             return readl(pdata->base + offset);
> > +
> > +     return pdata->read(pdata, offset, false);
> > +}
> > +
> > +static inline u32 rvtrace_relaxed_read32(struct rvtrace_platform_data =
*pdata, u32 offset)
> > +{
> > +     if (likely(pdata->io_mem))
> > +             return readl_relaxed(pdata->base + offset);
> > +
> > +     return pdata->read(pdata, offset, true);
> > +}
> > +
> > +static inline void rvtrace_write32(struct rvtrace_platform_data *pdata=
, u32 val, u32 offset)
> > +{
> > +     if (likely(pdata->io_mem))
> > +             writel(val, pdata->base + offset);
> > +     else
> > +             pdata->write(pdata, val, offset, false);
> > +}
> > +
> > +static inline void rvtrace_relaxed_write32(struct rvtrace_platform_dat=
a *pdata,
> > +                                        u32 val, u32 offset)
> > +{
> > +     if (likely(pdata->io_mem))
> > +             writel_relaxed(val, pdata->base + offset);
> > +     else
> > +             pdata->write(pdata, val, offset, true);
> > +}
> > +
> > +static inline bool rvtrace_is_source(struct rvtrace_platform_data *pda=
ta)
> > +{
> > +     return !pdata->nr_inconns ? true : false;
> > +}
> > +
> > +static inline bool rvtrace_is_sink(struct rvtrace_platform_data *pdata=
)
> > +{
> > +     return !pdata->nr_outconns ? true : false;
> > +}
> > +
> > +/**
> > + * struct rvtrace_component_id - Details to identify or match a RISC-V=
 trace component
> > + * @type:      Type of the component
> > + * @version:   Version of the component
> > + * @data:      Data pointer for driver use
> > + */
> > +struct rvtrace_component_id {
> > +     enum rvtrace_component_type type;
> > +     u32 version;
> > +     void *data;
> > +};
> > +
> > +/**
> > + * struct rvtrace_component - Representation of a RISC-V trace compone=
nt
> > + * pdata:    Pointer to underlying platform data
> > + * id:       Details to match the component
> > + * type_idx: Unique number based on component type
> > + * dev:      Device instance
> > + * ready:    Flag showing whether RISC-V trace driver was probed succe=
ssfully
> > + */
> > +struct rvtrace_component {
> > +     struct rvtrace_platform_data *pdata;
> > +     struct rvtrace_component_id id;
> > +     u32 type_idx;
> > +     struct device dev;
> > +     bool ready;
> > +};
> > +
> > +#define to_rvtrace_component(__dev)  container_of_const(__dev, struct =
rvtrace_component, dev)
> > +
> > +static inline void rvtrace_get_component(struct rvtrace_component *com=
p)
> > +{
> > +     get_device(&comp->dev);
> > +}
> > +
> > +static inline void rvtrace_put_component(struct rvtrace_component *com=
p)
> > +{
> > +     put_device(&comp->dev);
> > +}
> > +
> > +const struct rvtrace_component_id *rvtrace_match_id(struct rvtrace_com=
ponent *comp,
> > +                                                 const struct rvtrace_=
component_id *ids);
> > +struct rvtrace_component *rvtrace_find_by_fwnode(struct fwnode_handle =
*fwnode);
> > +
> > +int rvtrace_poll_bit(struct rvtrace_platform_data *pdata, int offset,
> > +                  int bit, int bitval, int timeout);
> > +int rvtrace_enable_component(struct rvtrace_component *comp);
> > +int rvtrace_disable_component(struct rvtrace_component *comp);
> > +
> > +struct rvtrace_component *rvtrace_cpu_source(unsigned int cpu);
> > +
> > +struct rvtrace_component *rvtrace_register_component(struct rvtrace_pl=
atform_data *pdata);
> > +void rvtrace_unregister_component(struct rvtrace_component *comp);
> > +
> > +/**
> > + * struct rvtrace_driver - Representation of a RISC-V trace driver
> > + * id_table: Table to match components handled by the driver
> > + * probe:    Driver probe() function
> > + * remove:   Driver remove() function
> > + * driver:   Device driver instance
> > + */
> > +struct rvtrace_driver {
> > +     const struct rvtrace_component_id *id_table;
> > +     int                     (*probe)(struct rvtrace_component *comp);
> > +     void                    (*remove)(struct rvtrace_component *comp)=
;
> > +     struct device_driver    driver;
> > +};
> > +
> > +#define to_rvtrace_driver(__drv)   \
> > +     ((__drv) ? container_of_const((__drv), struct rvtrace_driver, dri=
ver) : NULL)
> > +
> > +extern struct platform_driver rvtrace_platform_driver;
> > +
> > +int __rvtrace_register_driver(struct module *owner, struct rvtrace_dri=
ver *rtdrv);
> > +#define rvtrace_register_driver(driver) __rvtrace_register_driver(THIS=
_MODULE, driver)
> > +static inline void rvtrace_unregister_driver(struct rvtrace_driver *rt=
drv)
> > +{
> > +     if (rtdrv)
> > +             driver_unregister(&rtdrv->driver);
> > +}
> > +
> > +#endif
> I suggest stress-testing it by creating some negative cases such as havin=
g
> dangling endpoint links in DT, e.g., RAM sinks disabled, but source encod=
er
> enabled, and check if the driver can properly handle it. Also because the=
re
> can be 3 modules rvtrace/rvtrace-encoder/rvtrace-ramsink (and probably mo=
re
> for funnel later), check different module load orders and other edge case=
s
> such as only loading rvtrace+encoder and see if the driver can safely han=
dle
> it without crash. In addition, try to load/unload the driver in a loop an=
d
> see if resources are free'ed.

Testing infrastructure will develop over-time and there are a lot of topolo=
gy
configurations to cover.

The current goal is to add a reasonably flexible rvtrace framework which
can be extended and hardened over time.

Regards,
Anup

