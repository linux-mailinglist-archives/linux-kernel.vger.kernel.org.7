Return-Path: <linux-kernel+bounces-842589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3CCBBD159
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 07:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1717189343D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 05:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C093248896;
	Mon,  6 Oct 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="rJq1bIB1"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B513635E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759729110; cv=none; b=HhhWPxO2r5PAtlwTPYXM8pjVYRhb7wWRKPwyy0556fBj0PM7r6CSEBP8MrKN3P1v+3DdniszmY+15MKmD+szLGm5LmEe/2XUcwjR1mAMAmt9Ta1WCqJ9dlR9CEIR7EybL1QSaQEjoc46omYXHtGPkPPt1WzSrXwd1niE0Ttauhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759729110; c=relaxed/simple;
	bh=AKtIjiVBqrq4PfoCa3F78x854RdCkAPjoN53lNHI2gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qztr4ZJjduoeI/J5nmNe7C1r8ZcYMGp21SWQjScNz35pMX3dGvdODUX7c7cO6o/7XT0spxZ7SxBu3ji+dvVQrhVBi+4IRkaoae1GfdxheTQn3JzJ54zghCyoi9MAHp3HwYVNp1P9Nh/v693eY2aA5vHLLOHmYaGWnKKEkPOgrMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=rJq1bIB1; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-91122373653so185522439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1759729108; x=1760333908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW4c6n+2yRiIWNsxLVYkze/rdTmcGN5mveqQBz1D8t8=;
        b=rJq1bIB1/pWSBY5AykVNiYb/75MsqUveXc0266MoX7afSLRJ1AlA3ZxJ1tVE130QNk
         yUJ6U1HBJkaVDeoCvF7soUMn50W3nL7+55EFoFXA8AvtvLfRR8w7EGx6rKGfWnt/qPoM
         /d84zvbl3e8Mz0g08smDc3HiVjcw+J7ubBp0/oKEc2ioZVh0EphWE0uZmUnmIydhTXnM
         5l8O7rhVXxIQ+mRHUMV0gL/gEBuZrLQ81lFsDaTVxGfP573ftE4AFzFa67jX7Xh14f/x
         FroZLJEmHtjq5ebADtLFNoYtsZ6yEnOEb6+D4suEvtwB9bL8feQ9gijHgfvG3hlxMV40
         x9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759729108; x=1760333908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW4c6n+2yRiIWNsxLVYkze/rdTmcGN5mveqQBz1D8t8=;
        b=rlUelM1OQ4mjWHRLvGw4PGLBgRMcmosfz2XEAbF7Vu+IQC6jCP9JVx5S3RNJcQoltK
         4NTwmB20iJ3kDQr5vT8gwunrM40b8dyG/QyLwX5qbxKh+TD7VvNrvC5vuQ9w1bQ6KPdp
         E0ORvREvfHgbdPMdTXFob17fry9GBs9K3XyuO04PGLO70G1sdHgzWcwRxHiG8ILaVRB5
         XBaODuSWENK+7sPB2FQcdlyju9OTACsnPjFy1xFoF0NTYb2qhsFoUPb6MzrDpp7tWQKZ
         xSemB704IP8N97Fw0ra5yukB8+qEv3sPbS2I4O3lyVvDxgNMEh8Hb43aYIk+X/Fsg6Gb
         oxeg==
X-Forwarded-Encrypted: i=1; AJvYcCX5rB91aJbqPd83oql7DTRb/P+FfMlZHPd69UTBjcGCYTPX5Hi2s5FUlc4IIKSRLEDQJBFQYUcetaYswA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvzuAcaEBd2PEo6mtleouNpOqreeJAKrIh2v36DioxAMHsuv+
	ihtF+1CypLMAqpvdeW+JlgmHAlSpa+5PUJPj0fnVEBHOIffutLA44N39PsSJibZEAhlP5CHKy0R
	vIoWTrLZJ1dN17+QLJYfDhkWwYYAkMVAQV0Cx+mpZ8zCWo9weAL36MGs=
X-Gm-Gg: ASbGnctFZtygi0FH2VH4zgW2nmQFkvUigqPDywTszlxqwtfMW6iH+PRtfqP8FDUHwGX
	zpEm5xl0FXcMpvCDUNs1nZVw/rXRT8/7EkDRNXOFsmZkiulbgsdu+d28H42+fozkcRkYwdVR5l4
	lKMJDIeBrkp+pF5R/fnjbMEcB4mdR7Lz/iiz6a0RR8K9tFz557ZXGRssFobnHIpNvCm64Ho8Pna
	bU0BoJmPjCuJpvn0JgIw6V2rUjH0F9qAzPwosxm1aramfHHh+2wKhhfIxp8+ihc
X-Google-Smtp-Source: AGHT+IHPxAUl4r2f9K0Px0iy8hrJgabwk3brsr3cS0D0PsoKasiHRjoRmClFHKfFEbJFAfVhBzGI/LuLYZOyx1Nd03c=
X-Received: by 2002:a05:6e02:b2a:b0:427:d62b:45f7 with SMTP id
 e9e14a558f8ab-42e7adac50fmr94926185ab.27.1759729107921; Sun, 05 Oct 2025
 22:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908181717.1997461-1-cleger@rivosinc.com> <20250908181717.1997461-4-cleger@rivosinc.com>
In-Reply-To: <20250908181717.1997461-4-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 6 Oct 2025 11:08:17 +0530
X-Gm-Features: AS18NWDCLrNNt4JH_WobaoB3Er2efhAPx6fqnox0H-hF7hS1NfoIoCx1KkffDC4
Message-ID: <CAAhSdy3fwEZ+SQ3Cgc=GbisshRVQsvUPv23kzDFDd45ic=GObg@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] drivers: firmware: add riscv SSE support
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Anup Patel <apatel@ventanamicro.com>, 
	Xu Lu <luxu.kernel@bytedance.com>, Atish Patra <atishp@atishpatra.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:50=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add driver level interface to use RISC-V SSE arch support. This interface
> allows registering SSE handlers, and receive them. This will be used by
> PMU and GHES driver.
>
> Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS                            |  15 +
>  drivers/firmware/Kconfig               |   1 +
>  drivers/firmware/Makefile              |   1 +
>  drivers/firmware/riscv/Kconfig         |  15 +
>  drivers/firmware/riscv/Makefile        |   3 +
>  drivers/firmware/riscv/riscv_sbi_sse.c | 701 +++++++++++++++++++++++++
>  include/linux/riscv_sbi_sse.h          |  57 ++
>  7 files changed, 793 insertions(+)
>  create mode 100644 drivers/firmware/riscv/Kconfig
>  create mode 100644 drivers/firmware/riscv/Makefile
>  create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
>  create mode 100644 include/linux/riscv_sbi_sse.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..684d23f852c3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21648,6 +21648,13 @@ T:     git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/iommu/linux.git
>  F:     Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>  F:     drivers/iommu/riscv/
>
> +RISC-V FIRMWARE DRIVERS
> +M:     Conor Dooley <conor@kernel.org>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
> +F:     drivers/firmware/riscv/*
> +
>  RISC-V MICROCHIP FPGA SUPPORT
>  M:     Conor Dooley <conor.dooley@microchip.com>
>  M:     Daire McNamara <daire.mcnamara@microchip.com>
> @@ -21712,6 +21719,14 @@ F:     arch/riscv/boot/dts/spacemit/
>  N:     spacemit
>  K:     spacemit
>
> +RISC-V SSE DRIVER
> +M:     Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> +R:     Himanshu Chauhan <himanshu@thechauhan.dev>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +F:     drivers/firmware/riscv/riscv_sse.c
> +F:     include/linux/riscv_sse.h
> +
>  RISC-V THEAD SoC SUPPORT
>  M:     Drew Fustini <fustini@kernel.org>
>  M:     Guo Ren <guoren@kernel.org>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index bbd2155d8483..1894df87b08e 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
>  source "drivers/firmware/microchip/Kconfig"
>  source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/qcom/Kconfig"
> +source "drivers/firmware/riscv/Kconfig"
>  source "drivers/firmware/samsung/Kconfig"
>  source "drivers/firmware/smccc/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 4ddec2820c96..6cdd84570ea7 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -34,6 +34,7 @@ obj-y                         +=3D efi/
>  obj-y                          +=3D imx/
>  obj-y                          +=3D psci/
>  obj-y                          +=3D qcom/
> +obj-y                          +=3D riscv/
>  obj-y                          +=3D samsung/
>  obj-y                          +=3D smccc/
>  obj-y                          +=3D tegra/
> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kcon=
fig
> new file mode 100644
> index 000000000000..ed5b663ac5f9
> --- /dev/null
> +++ b/drivers/firmware/riscv/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Risc-V Specific firmware drivers"
> +depends on RISCV
> +
> +config RISCV_SBI_SSE
> +       bool "Enable SBI Supervisor Software Events support"
> +       depends on RISCV_SBI
> +       default y
> +       help
> +         The Supervisor Software Events support allows the SBI to delive=
r
> +         NMI-like notifications to the supervisor mode software. When en=
abled,
> +         this option provides support to register callbacks on specific =
SSE
> +         events.
> +
> +endmenu
> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Mak=
efile
> new file mode 100644
> index 000000000000..c8795d4bbb2e
> --- /dev/null
> +++ b/drivers/firmware/riscv/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_RISCV_SBI_SSE)            +=3D riscv_sbi_sse.o
> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/ri=
scv/riscv_sbi_sse.c
> new file mode 100644
> index 000000000000..57b6dad92482
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#define pr_fmt(fmt) "sse: " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/hardirq.h>
> +#include <linux/list.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/reboot.h>
> +#include <linux/riscv_sbi_sse.h>
> +#include <linux/slab.h>
> +
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> +
> +struct sse_event {
> +       struct list_head list;
> +       u32 evt_id;
> +       u32 priority;
> +       sse_event_handler_fn *handler;
> +       void *handler_arg;
> +       /* Only valid for global events */
> +       unsigned int cpu;
> +
> +       union {
> +               struct sse_registered_event *global;
> +               struct sse_registered_event __percpu *local;
> +       };
> +};
> +
> +static int sse_hp_state;
> +static bool sse_available __ro_after_init;
> +static DEFINE_SPINLOCK(events_list_lock);
> +static LIST_HEAD(events);
> +static DEFINE_MUTEX(sse_mutex);
> +
> +struct sse_registered_event {
> +       struct sse_event_arch_data arch;
> +       struct sse_event *event;
> +       unsigned long attr;
> +       bool is_enabled;
> +};
> +

<snip>

> +
> +static int __init sse_init(void)
> +{
> +       int ret;
> +
> +       if (sbi_probe_extension(SBI_EXT_SSE) <=3D 0) {
> +               pr_err("Missing SBI SSE extension\n");

We might have older firmware which implements an older
SBI spec version so we should not throw errors over here.
Please change this to pr_info().

Regards,
Anup

