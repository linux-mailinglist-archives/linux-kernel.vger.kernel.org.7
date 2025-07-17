Return-Path: <linux-kernel+bounces-734697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE1B084EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A763F1AA3472
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BB21639B;
	Thu, 17 Jul 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2cZdd/cq"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3601E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733888; cv=none; b=YfA0XBY7AFE3qh8kEeNzt82n4yLylaCWfxXAuk2wf8iZC0SsXH6IZrqUfXofg3s5uWSuAiLW2rPKlXtBYkp56JqXRpBFG7/Qxv8VjjMFITApYZzIKabBGEkDBRo1qgPENp6Y/43MpIlZEB20S6U6jM1xtZZy8/tNL+vZ99AEjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733888; c=relaxed/simple;
	bh=u+7xn3si52BNm7HgKrdKpdJEHwTIZ0Ej7n1XYoKlzIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwj4MKs9f52C7cpyFmJYJqXs662r/IfMupUViWAmXHWEJivb/xk4Q1Ob1+BwrCmqgbXfUPMOnSV/g/1ujYwxi/cRxUJ/pplH5RkjPykdTM5kcEV4kn4zieT8mZ8KrcBA5xSt9PjwrSLZiWoiybsgaY2eKtE/xVMYJnC3igd86H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2cZdd/cq; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso2743745ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752733885; x=1753338685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cShu34IsKP+rMuJDtZGgY5sl29QdNRHSmVJoKkGJ+Hg=;
        b=2cZdd/cqWA0lZFjeGfGmvOmdTbdkHemRa20h4Dt9a5MyF1dB0DyRGpQAmwPFXjlx4o
         5iDTR9C+57NhSEMhLkaRoP3/90u6IJ1tdoc9TtxqIzDpab6QxfTLU7AJGuB3ij3votwm
         pyZ6IbLfu3wrl40A0kKc8E3sBB78uOmxoSKlTLm9Q+B2feGR+2fR+1lZkYzh8Re0/Hdy
         34OmaEZUZnpL0GmKA5cINmTf6RuVVGmqS10Gm6nhHPQi6yEB6oHFjHOynAPGSNJ8nVV3
         7bOHHEXDEtAUoRCugzOavRVj37u6aZ4kyG8g71OcEBVublDeV4ib6jlu/6KzXTdsHxcy
         iryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733885; x=1753338685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cShu34IsKP+rMuJDtZGgY5sl29QdNRHSmVJoKkGJ+Hg=;
        b=Jp19KmDciseFMt59syxQPOF+QUaiD3LBAGzZl3p21uox2NRS65z2PQjPGlfGcSnWbh
         JQq+RiVrPbBXd7IyM6Pt1PjJfHSWMU5mf+KHu3lznFxaaO/c6BFFOdGjk8IpTC4CU+Z/
         sEVz5FVRyEoDAr9wAKv7Zzj1sFizyM8snACbhybsMZeNgGyol0FvUZVx18QYgHYBJYCJ
         hDmR+ZS/2F3PkZnCP6Iq41phCUL59Lp8ZCbCpRExU8GCaaP5J+EMKz2l1SeYqxJkTGfX
         hRdsAXzyQMdApZw+yxIz5/Rofgm0tMMhIQXqjqIydcrtYROfSawTRc3WGKPQ9oXpkjkg
         Si/w==
X-Forwarded-Encrypted: i=1; AJvYcCVYHC/RdaC4Z0Jxyh5exb76MWwOJcgdhKrTxFVWh188OxPqxl144TvVxBj0n4ACb0b3EpAHbM+Eq+dKYsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgF1bmBv7U2C5yVOtEOW73ye8q/z7WpTgN/slh4EQLDL1nLaoP
	OQJezZUYtiitvb381DQL9UDS1MKboHZz6dcyQWaHD5/BwagN8kXQihnXoYBtfQ4RLM1nPOky+H4
	wzjeQwFj1MIcSGHMnAMQDVghE/wCcxFJNpiuA4vCcCw==
X-Gm-Gg: ASbGnctC+Mpk8FL4+1KlRlWiVBIzAJT7mzhTKkVThIssuwMqgAKw3f8t84UdXTxX2oA
	FuHauXAWS/KSM+uxBcXPaYpkbG+pnz/5RHTGw7FJOXjAf3gqpNVvdWQ0yFfFtglr/r6EiVH+W4q
	Lx4M8hEc1spCcGgoqFecOEvjU4SWgSPF8RgAxSfT4o7XZ92ncZrMPYGDRDDhF7dO4zpRFaKzq/9
	kng0Q==
X-Google-Smtp-Source: AGHT+IE/sfncb34OAJCvsNtZ+vhPtab+pneDsmqOE/XaS/elV01OiQl/WRzo4PEBg2bqbd4kAnguheLatIGEICEhU4U=
X-Received: by 2002:a05:6e02:97:b0:3de:287b:c445 with SMTP id
 e9e14a558f8ab-3e282c4f886mr53813265ab.0.1752733884509; Wed, 16 Jul 2025
 23:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9693132df4d0f857b8be3a75750c36b40213fcc0.1726211632.git.zhouquan@iscas.ac.cn>
In-Reply-To: <9693132df4d0f857b8be3a75750c36b40213fcc0.1726211632.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 12:01:10 +0530
X-Gm-Features: Ac12FXyZI5bndF4oUBeF-5txAoMIgPzgIwwbYF2456Qc2MeDpR2sZuF-78qU4Ss
Message-ID: <CAAhSdy2CLZxuXU9z6=44NECMFgEBYbSeyyuL9TV2LaBEnQLcRQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: perf/kvm: Add reporting of interrupt events
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:32=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> For `perf kvm stat` on the RISC-V, in order to avoid the
> occurrence of `UNKNOWN` event names, interrupts should be
> reported in addition to exceptions.
>
> testing without patch:
> ---
> Event name                    Samples  Sample%       Time(ns)
> ---------------------------  --------  --------  ------------
> STORE_GUEST_PAGE_FAULT            1496461   53.00%    889612544
> UNKNOWN                        887514   31.00%    272857968
> LOAD_GUEST_PAGE_FAULT          305164   10.00%    189186331
> VIRTUAL_INST_FAULT              70625    2.00%    134114260
> SUPERVISOR_SYSCALL              32014    1.00%     58577110
> INST_GUEST_PAGE_FAULT               1    0.00%         2545
>
> testing with patch:
> ---
> Event name                    Samples  Sample%       Time(ns)
> ---------------------------  --------  --------  ------------
> IRQ_S_TIMER                   211271    58.00%  738298680600
> EXC_STORE_GUEST_PAGE_FAULT    111279    30.00%  130725914800
> EXC_LOAD_GUEST_PAGE_FAULT      22039     6.00%   25441480600
> EXC_VIRTUAL_INST_FAULT          8913     2.00%   21015381600
> IRQ_VS_EXT                      4748     1.00%   10155464300
> IRQ_S_EXT                       2802     0.00%   13288775800
> IRQ_S_SOFT                      1998     0.00%    4254129300
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

Queued this patch for Linux-6.17

Thanks,
Anup

> ---
>  tools/perf/arch/riscv/util/kvm-stat.c         |  6 +-
>  .../arch/riscv/util/riscv_exception_types.h   | 35 ------------
>  tools/perf/arch/riscv/util/riscv_trap_types.h | 57 +++++++++++++++++++
>  3 files changed, 60 insertions(+), 38 deletions(-)
>  delete mode 100644 tools/perf/arch/riscv/util/riscv_exception_types.h
>  create mode 100644 tools/perf/arch/riscv/util/riscv_trap_types.h
>
> diff --git a/tools/perf/arch/riscv/util/kvm-stat.c b/tools/perf/arch/risc=
v/util/kvm-stat.c
> index 491aef449d1a..3ea7acb5e159 100644
> --- a/tools/perf/arch/riscv/util/kvm-stat.c
> +++ b/tools/perf/arch/riscv/util/kvm-stat.c
> @@ -9,10 +9,10 @@
>  #include <memory.h>
>  #include "../../../util/evsel.h"
>  #include "../../../util/kvm-stat.h"
> -#include "riscv_exception_types.h"
> +#include "riscv_trap_types.h"
>  #include "debug.h"
>
> -define_exit_reasons_table(riscv_exit_reasons, kvm_riscv_exception_class)=
;
> +define_exit_reasons_table(riscv_exit_reasons, kvm_riscv_trap_class);
>
>  const char *vcpu_id_str =3D "id";
>  const char *kvm_exit_reason =3D "scause";
> @@ -30,7 +30,7 @@ static void event_get_key(struct evsel *evsel,
>                           struct event_key *key)
>  {
>         key->info =3D 0;
> -       key->key =3D evsel__intval(evsel, sample, kvm_exit_reason);
> +       key->key =3D evsel__intval(evsel, sample, kvm_exit_reason) & ~CAU=
SE_IRQ_FLAG;
>         key->exit_reasons =3D riscv_exit_reasons;
>  }
>
> diff --git a/tools/perf/arch/riscv/util/riscv_exception_types.h b/tools/p=
erf/arch/riscv/util/riscv_exception_types.h
> deleted file mode 100644
> index c49b8fa5e847..000000000000
> --- a/tools/perf/arch/riscv/util/riscv_exception_types.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#ifndef ARCH_PERF_RISCV_EXCEPTION_TYPES_H
> -#define ARCH_PERF_RISCV_EXCEPTION_TYPES_H
> -
> -#define EXC_INST_MISALIGNED 0
> -#define EXC_INST_ACCESS 1
> -#define EXC_INST_ILLEGAL 2
> -#define EXC_BREAKPOINT 3
> -#define EXC_LOAD_MISALIGNED 4
> -#define EXC_LOAD_ACCESS 5
> -#define EXC_STORE_MISALIGNED 6
> -#define EXC_STORE_ACCESS 7
> -#define EXC_SYSCALL 8
> -#define EXC_HYPERVISOR_SYSCALL 9
> -#define EXC_SUPERVISOR_SYSCALL 10
> -#define EXC_INST_PAGE_FAULT 12
> -#define EXC_LOAD_PAGE_FAULT 13
> -#define EXC_STORE_PAGE_FAULT 15
> -#define EXC_INST_GUEST_PAGE_FAULT 20
> -#define EXC_LOAD_GUEST_PAGE_FAULT 21
> -#define EXC_VIRTUAL_INST_FAULT 22
> -#define EXC_STORE_GUEST_PAGE_FAULT 23
> -
> -#define EXC(x) {EXC_##x, #x }
> -
> -#define kvm_riscv_exception_class                                       =
  \
> -       EXC(INST_MISALIGNED), EXC(INST_ACCESS), EXC(INST_ILLEGAL),       =
  \
> -       EXC(BREAKPOINT), EXC(LOAD_MISALIGNED), EXC(LOAD_ACCESS),         =
  \
> -       EXC(STORE_MISALIGNED), EXC(STORE_ACCESS), EXC(SYSCALL),          =
  \
> -       EXC(HYPERVISOR_SYSCALL), EXC(SUPERVISOR_SYSCALL),                =
  \
> -       EXC(INST_PAGE_FAULT), EXC(LOAD_PAGE_FAULT), EXC(STORE_PAGE_FAULT)=
, \
> -       EXC(INST_GUEST_PAGE_FAULT), EXC(LOAD_GUEST_PAGE_FAULT),          =
  \
> -       EXC(VIRTUAL_INST_FAULT), EXC(STORE_GUEST_PAGE_FAULT)
> -
> -#endif /* ARCH_PERF_RISCV_EXCEPTION_TYPES_H */
> diff --git a/tools/perf/arch/riscv/util/riscv_trap_types.h b/tools/perf/a=
rch/riscv/util/riscv_trap_types.h
> new file mode 100644
> index 000000000000..854e9d95524d
> --- /dev/null
> +++ b/tools/perf/arch/riscv/util/riscv_trap_types.h
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef ARCH_PERF_RISCV_TRAP_TYPES_H
> +#define ARCH_PERF_RISCV_TRAP_TYPES_H
> +
> +/* Exception cause high bit - is an interrupt if set */
> +#define CAUSE_IRQ_FLAG         (_AC(1, UL) << (__riscv_xlen - 1))
> +
> +/* Interrupt causes (minus the high bit) */
> +#define IRQ_S_SOFT 1
> +#define IRQ_VS_SOFT 2
> +#define IRQ_M_SOFT 3
> +#define IRQ_S_TIMER 5
> +#define IRQ_VS_TIMER 6
> +#define IRQ_M_TIMER 7
> +#define IRQ_S_EXT 9
> +#define IRQ_VS_EXT 10
> +#define IRQ_M_EXT 11
> +#define IRQ_S_GEXT 12
> +#define IRQ_PMU_OVF 13
> +
> +/* Exception causes */
> +#define EXC_INST_MISALIGNED 0
> +#define EXC_INST_ACCESS 1
> +#define EXC_INST_ILLEGAL 2
> +#define EXC_BREAKPOINT 3
> +#define EXC_LOAD_MISALIGNED 4
> +#define EXC_LOAD_ACCESS 5
> +#define EXC_STORE_MISALIGNED 6
> +#define EXC_STORE_ACCESS 7
> +#define EXC_SYSCALL 8
> +#define EXC_HYPERVISOR_SYSCALL 9
> +#define EXC_SUPERVISOR_SYSCALL 10
> +#define EXC_INST_PAGE_FAULT 12
> +#define EXC_LOAD_PAGE_FAULT 13
> +#define EXC_STORE_PAGE_FAULT 15
> +#define EXC_INST_GUEST_PAGE_FAULT 20
> +#define EXC_LOAD_GUEST_PAGE_FAULT 21
> +#define EXC_VIRTUAL_INST_FAULT 22
> +#define EXC_STORE_GUEST_PAGE_FAULT 23
> +
> +#define TRAP(x) { x, #x }
> +
> +#define kvm_riscv_trap_class \
> +       TRAP(IRQ_S_SOFT), TRAP(IRQ_VS_SOFT), TRAP(IRQ_M_SOFT), \
> +       TRAP(IRQ_S_TIMER), TRAP(IRQ_VS_TIMER), TRAP(IRQ_M_TIMER), \
> +       TRAP(IRQ_S_EXT), TRAP(IRQ_VS_EXT), TRAP(IRQ_M_EXT), \
> +       TRAP(IRQ_S_GEXT), TRAP(IRQ_PMU_OVF), \
> +       TRAP(EXC_INST_MISALIGNED), TRAP(EXC_INST_ACCESS), TRAP(EXC_INST_I=
LLEGAL), \
> +       TRAP(EXC_BREAKPOINT), TRAP(EXC_LOAD_MISALIGNED), TRAP(EXC_LOAD_AC=
CESS), \
> +       TRAP(EXC_STORE_MISALIGNED), TRAP(EXC_STORE_ACCESS), TRAP(EXC_SYSC=
ALL), \
> +       TRAP(EXC_HYPERVISOR_SYSCALL), TRAP(EXC_SUPERVISOR_SYSCALL), \
> +       TRAP(EXC_INST_PAGE_FAULT), TRAP(EXC_LOAD_PAGE_FAULT), \
> +       TRAP(EXC_STORE_PAGE_FAULT), TRAP(EXC_INST_GUEST_PAGE_FAULT), \
> +       TRAP(EXC_LOAD_GUEST_PAGE_FAULT), TRAP(EXC_VIRTUAL_INST_FAULT), \
> +       TRAP(EXC_STORE_GUEST_PAGE_FAULT)
> +
> +#endif /* ARCH_PERF_RISCV_TRAP_TYPES_H */
>
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> --
> 2.34.1
>

