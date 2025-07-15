Return-Path: <linux-kernel+bounces-731887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFAB05AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A733A6DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF319066B;
	Tue, 15 Jul 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWkj1UC1"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003232E2EE9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585307; cv=none; b=VfOpURTRlvdsdlDA7YqRNEf9UDPU+P0iaJVjfzn9RiWz+C45/7foRI205cXAh58evtKF8/AFP25c3OL4X2DVfrm2VCXfoPtzVL21UWVgOVI9p0GAQpWQfiS5E/QXeHhOKAETvBUsB0mDubrclJZKhLHPXs2Xl7ElrRU9los6Y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585307; c=relaxed/simple;
	bh=yGuWdLHZ4ewsvIla/efowtUUShlq8SpzRz/Aax++gXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHT/U5Eo5MCYQHBR06+vRJ9VKU9FwTd7gWumGOxo9l7LNNHlNEPtwTNEMpWaI6eMWAoN3DIMs5Ehp1DjQ20DfQsxzrG7YmSK2S8Mk0Tt86a9hnizhUlypBnbi7nDR+Qdg5SvqZQbUjKB+VMSpXCBgoKtyTlIOpRMmYp4jzDtRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWkj1UC1; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-531acaddd5eso2111586e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752585305; x=1753190105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cgF9DS/V+rxy/obM05rwE0HVOognW5I2G+NnmxDN3Q=;
        b=gWkj1UC1HV0jAHLBvqpSEKM2kY4YqOQy66/AJjxLmQrgUw7PfPzM3iSeY7SVgKy0uq
         n9RCJPxp4bb3R1WGX15NB+u29bPNC2exm2BgtJMz2KmBzMN8sl5pOjOZDzYnpT3vuCq9
         YAvPlRH/om2lKb+J1fE+abTeKQTugJdgM9PfGjFbOizqO6r9SLzSFlPQATOFMUDk4Mej
         uPI8UCRHGYZYTt/BPmLXXtnxHIsA6/fJeGm5nXtj0FPpLBG3J4g88QUFiVoJrUHW5DId
         IEgVuAAMnuWsKyRFjFHP9C3zmmOxma10F585aQC8pM1HO+uZjBjHSbDjgxCFcAXLpshD
         oTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585305; x=1753190105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cgF9DS/V+rxy/obM05rwE0HVOognW5I2G+NnmxDN3Q=;
        b=k16CRyyCRTWwu2lQjT9yfAnk7iZ5Hu/0Oo6BfPevF+ROFEnmyjR6fN0UJouVWKwWRy
         EH5ohwIvclnF/DVt2CoIyFD0+hOnf4u3LUl/MotZpwW4Q9oeibRUgHxw7XWI7xJxg+u7
         rDcAv/TLQhummt8ouEEAQccotk5cV6x6VLx+TKGXSv0ilukJZhaPTCm3ljU3tBsratyJ
         rFOlCxs38QZoFWXc/0CRs1gh0s8LZ4D+fxbf2CDEgBLcK50QEgoRyNRPVHryqBQqM2db
         n0aTAFNOqwSC8r8O5FowuzRFWEIsqaWXTshgN+BTpjzhA0G9a5boXfJUhAd6OrxHuF0B
         873A==
X-Forwarded-Encrypted: i=1; AJvYcCWro79X+xYOhUS3oRbKIldGF3IHIDm2t+Pdw9OA/k98f1XR74FXt8pJp8773qi2HU52S/QQUv4NrYaGJiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyou1iHEEraG+eOfzSr7UFylDgEmPFzzEbNOFzwr8iY+ivrMK3L
	guoimvfwzV7nJzht04gTb6DybwB77Kdsk5s44lcZpGYNDKU7OGvQuplrw+O3O2kz16wKsv4gjmm
	P5jyTDZEjh+5WUn3FouvwcHE97l/9hos=
X-Gm-Gg: ASbGncu4coLWuuKG+93ipgZrmLMRGKXwL0NPZGkBhGR+lKr58qRu6v2akLcSviEq8f3
	kJ2sCahSALXtJA0iVXNg/pkoU8R3BRflusGq8A0GWKvX9S+KxkCEo6L2TqJ+3c5VpoRm8eKVmO/
	2oDc1kxuLxBe7tUeGGAe7ZGnTtVBo6m7HLL/2BY886AvXSbFYv04SBeWi0seWE67FMnErntiGCl
	UjS7hoJcw==
X-Google-Smtp-Source: AGHT+IH2hTRSG8rOzWYW/wz0g4lXEaIxK8jKZt9GoukMcyUB+nAfPo7gUvfYuzfJTeqf1hpGdG0xLNq6NqE6BXPfz5U=
X-Received: by 2002:a05:6122:4f8a:b0:535:aea0:7a30 with SMTP id
 71dfb90a1353d-535f46cf742mr10401471e0c.2.1752585304260; Tue, 15 Jul 2025
 06:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-3-guoren@kernel.org>
In-Reply-To: <20250713155321.2064856-3-guoren@kernel.org>
From: Han Gao <rabenda.cn@gmail.com>
Date: Tue, 15 Jul 2025 21:14:52 +0800
X-Gm-Features: Ac12FXxem7DUcO6jp_jeS7knLRXTB5hzLLX-DYGIj_Cx8cW7_b9Y5QnwcfV6Srw
Message-ID: <CAAT7Ki9i5gyvituHsDpeq_-z6=e42MdLEULwqCGJ768-XbVxrQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: guoren@kernel.org
Cc: palmer@dabbelt.com, conor@kernel.org, alexghiti@rivosinc.com, 
	paul.walmsley@sifive.com, bjorn@rivosinc.com, eobras@redhat.com, 
	corbet@lwn.net, peterlin@andestech.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 11:53=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> The early version of XuanTie C910 core has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
>
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
>
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
>
> This problem is only observed on the sg2042 hardware platform by
> running the lock_torture test program for half an hour. The problem
> was not found in the user space application, because interrupt can
> break the livelock.
>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig.errata                    | 17 ++++++++++
>  arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
>  arch/riscv/include/asm/errata_list_vendors.h |  3 +-
>  arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
>  include/asm-generic/rwonce.h                 |  2 ++
>  5 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/rwonce.h
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e318119d570d..d2c982ba5373 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -130,4 +130,21 @@ config ERRATA_THEAD_GHOSTWRITE
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD_WRITE_ONCE
> +       bool "Apply T-Head WRITE_ONCE errata"
> +       depends on ERRATA_THEAD
> +       default y
> +       help
> +         The early version of T-Head C9xx cores of sg2042 & th1520 have =
a store
> +         merge buffer delay problem. The store merge buffer could improv=
e the
> +         store queue performance by merging multi-store requests, but wh=
en there
> +         are no continued store requests, the prior single store request=
 would be
> +         waiting in the store queue for a long time. That would cause si=
gnifi-
> +         cant problems for communication between multi-cores. Appending =
a
> +         fence w.o could immediately flush the store merge buffer and le=
t other
> +         cores see the write result.
> +
> +         This will apply the WRITE_ONCE errata to handle the non-standar=
d beh-
> +         avior via appending a fence w.o instruction for WRITE_ONCE().
> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index 0b942183f708..fbe46f2fa8fb 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int sta=
ge,
>         return true;
>  }
>
> +static bool errata_probe_write_once(unsigned int stage,
> +                                   unsigned long arch_id, unsigned long =
impid)
> +{
> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> +               return false;
> +
> +       /* target-c9xx cores report arch_id and impid as 0 */
> +       if (arch_id !=3D 0 || impid !=3D 0)
> +               return false;
> +
> +       if (stage =3D=3D RISCV_ALTERNATIVES_BOOT ||
> +           stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> +               return true;
> +
> +       return false;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>                               unsigned long archid, unsigned long impid)
>  {
> @@ -183,6 +200,9 @@ static u32 thead_errata_probe(unsigned int stage,
>
>         errata_probe_ghostwrite(stage, archid, impid);
>
> +       if (errata_probe_write_once(stage, archid, impid))
> +               cpu_req_errata |=3D BIT(ERRATA_THEAD_WRITE_ONCE);
> +
>         return cpu_req_errata;
>  }
>
> diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/in=
clude/asm/errata_list_vendors.h
> index a37d1558f39f..a7473cb8874d 100644
> --- a/arch/riscv/include/asm/errata_list_vendors.h
> +++ b/arch/riscv/include/asm/errata_list_vendors.h
> @@ -18,7 +18,8 @@
>  #define        ERRATA_THEAD_MAE 0
>  #define        ERRATA_THEAD_PMU 1
>  #define        ERRATA_THEAD_GHOSTWRITE 2
> -#define        ERRATA_THEAD_NUMBER 3
> +#define        ERRATA_THEAD_WRITE_ONCE 3
> +#define        ERRATA_THEAD_NUMBER 4
>  #endif
>
>  #endif
> diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/rwo=
nce.h
> new file mode 100644
> index 000000000000..081793d4d772
> --- /dev/null
> +++ b/arch/riscv/include/asm/rwonce.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RWONCE_H
> +#define __ASM_RWONCE_H
> +
> +#include <linux/compiler_types.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/vendorid_list.h>
> +#include <asm/errata_list_vendors.h>
> +
> +#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE)
> +
> +#define write_once_fence()                             \
> +do {                                                   \
> +       asm volatile(ALTERNATIVE(                       \
> +               "nop",                                  \
> +               "fence w, o",                           \
> +               THEAD_VENDOR_ID,                        \
> +               ERRATA_THEAD_WRITE_ONCE,                \
> +               CONFIG_ERRATA_THEAD_WRITE_ONCE)         \
> +               : : : "memory");                        \
> +} while (0)
> +
> +#define __WRITE_ONCE(x, val)                           \
> +do {                                                   \
> +       *(volatile typeof(x) *)&(x) =3D (val);            \
> +       write_once_fence();                             \
> +} while (0)
> +
> +#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNA=
TIVE) */
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif /* __ASM_RWONCE_H */
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 52b969c7cef9..4e2d941f15a1 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -50,10 +50,12 @@
>         __READ_ONCE(x);                                                 \
>  })
>
> +#ifndef __WRITE_ONCE
>  #define __WRITE_ONCE(x, val)                                           \
>  do {                                                                   \
>         *(volatile typeof(x) *)&(x) =3D (val);                           =
 \
>  } while (0)
> +#endif
>
>  #define WRITE_ONCE(x, val)                                             \
>  do {                                                                   \
> --
> 2.40.1
>

Tested-by: Han Gao <rabenda.cn@gmail.com>

