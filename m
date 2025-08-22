Return-Path: <linux-kernel+bounces-782549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65547B321DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8B1CC836E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278B299AA9;
	Fri, 22 Aug 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NTWdP+X4"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700029993A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885506; cv=none; b=ZVf5Gt5q45ay9Djnpe1tcW2kvzrX7vcA/KmJIH4YxPrpdj2S1nQpxTvKTO6BcHcEU4f6BTT0V5wdoXyyndmpZJA/fTMS4tZ4P24mYFvciTt/PmJG2sb5MVHAXS2PKdBwh9LwXwDtc+ak3M5QQujf/RflNfTAjzIJMvlujvaiphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885506; c=relaxed/simple;
	bh=nF6YlaAh7XuRGcAeSUxzKN7syva3tGK7AQ9piMFQqbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErpGeUNnDRbzxw0QJ7DUkoM+cv6eYkFB6D5QGvvn4pBtRxXsWcBKHUmVOvuZBQ/eEsu9/pF1Fc+H8GWc48TkbVG7x6etU76fkkdAdozjMugNkvVs/khsSzIuNWGp434cWCNQnl3//0/Gfh2woAGzk/VeUC/XZNHL/XdHh0xnxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NTWdP+X4; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89021b2569cso682647241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755885503; x=1756490303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QctlWqJYLmIg/E5LPhpjhg17ib5pNjMH7p/Hx4zus4I=;
        b=NTWdP+X4Xxg5tI/7NKVqN1Ci7k2Air8QvJc564jyZr4rzbB3TvlktHSN9INkmEzU5Y
         TbSGmMiGkWC/ChQaf7pQqRIU5BaqW3cQTALyS2C9cLftquNgKDCtqd44P9RPDLHpL8Uu
         lsrXYkAbY/7WE8/EDWxkaj1gDDZVDY1j0F/HlKY6e847+KXbBqc0WYyJgqY5NGq58ZCK
         vdC5L1B4NMw0uBU0YeTmuLAgd2W4ZGqk3ImZNztNDN2iLZ8V+d5H6vE/IdbeWRNIZyyB
         oPv5rgNxsau7nLVUK0leUdLzznqfEM3cCJ0tUMIT9K+nuGg9qeQhDVjqD6BCLyU0ai5u
         Uycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885503; x=1756490303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QctlWqJYLmIg/E5LPhpjhg17ib5pNjMH7p/Hx4zus4I=;
        b=BbKuDU2DC3nfHYvpedKT/pZL9awQ4mDxdiQxNHEfQgAj+HmZhIipuGIga7giQXpcTr
         EFl8QhKEkn3JgEywHKQ8sn8IOTvbSK6wVdoO75it0NYy45Lgv3SLDYNyM8cMySkcdJhH
         VjSkv3UbOZ7X7tWwlnHnDwge1cBMApcruSQ60C/OsIWoU3O0gw/rg1aKexz7orNlcF7c
         kKlL27xJi+OIsbPhozBdiKqEqEkPpqVNTOaOw6Nc8gWqIhZLhiNDhzI7Q2O55Giecmr4
         XgTNN5SpcB9RKcTX1XAiT9mLK8ywfNaC/2rMBo/EjzDcybvwNhVNpNDp9HxKWgng8s9s
         72cw==
X-Forwarded-Encrypted: i=1; AJvYcCXcMYRYvigwazwxDM//Dt7qaqfkAXJj+8xBfAyO2jNFI/AFY22vdOdF4pJ5KKVOffIPA3+mR4lQ6vkzFVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhrwKgeIAVNf6TmrEsKQ1FqGSWRqTTUjo8OBbaNyNVq1PpvwD
	VfOapCTAOJ0oMFl5tenvr9v8dJNHf143j7dvg6ulvNd5piKOTrPaS2a09q77L0KAFmc3Pf15qZ3
	XoMlM2JjAJV7jXypvLRa9GF7eidqkwJOLhZo8tXzwLA==
X-Gm-Gg: ASbGncuKvhGDFgyrVu5VP66Eqbs2V3rlAiE/l2tqbc3x8CaFFreUF08xvqRVvfkjqsC
	W+MYJjQ4t3YUZzr/qDiX38USehdoHhzsv+GhJ3J0SeNJZf7kIWMMPBxD4ssib8T1Gt03+IXCEbj
	uUXUnqQWbGk6w46rZ27TNO772yGoMtiuAbpjxhYIh0LzS5OHTTPUKok/ZGInzzkCe7zt3J47tNK
	xSG+F3L
X-Google-Smtp-Source: AGHT+IFN//tAIOu8+R+uuhM96f7zV3pePtaUS87r3F/6litKfGF0/DndAdWIWiwCZ7w8YwN9/a0uzZqZes7ebIu5qsc=
X-Received: by 2002:a05:6102:579b:b0:4fc:f151:a644 with SMTP id
 ada2fe7eead31-51d0f1e3aebmr1186332137.27.1755885503401; Fri, 22 Aug 2025
 10:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805193955.798277-1-jesse@rivosinc.com> <20250805193955.798277-9-jesse@rivosinc.com>
 <CACPK8Xd2QfL460LY2T0ia7Akb79fEXKF2+=B27M8q5j7jUoouQ@mail.gmail.com>
In-Reply-To: <CACPK8Xd2QfL460LY2T0ia7Akb79fEXKF2+=B27M8q5j7jUoouQ@mail.gmail.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Fri, 22 Aug 2025 10:58:12 -0700
X-Gm-Features: Ac12FXyOxEp8jMlrarfb8y3cqhZyCnGwLGrfNnesQRaBf_dB1MguAeHwG0yw4Oc
Message-ID: <CALSpo=bM8S2cKHRQ1Zn1ViDh9QfoKkWGVVeW50D1UQkXP_6rug@mail.gmail.com>
Subject: Re: [PATCH 8/8] selftests: riscv: Add test for hardware breakpoints
To: Joel Stanley <joel@jms.id.au>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:42=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> Hi Jesse,
>
> We had a pretty huge cc list on the thread, I've trimmed it right
> back. Feel free to add some people back but keep it focused.
>
> On Wed, 6 Aug 2025 at 05:42, Jesse Taube <jesse@rivosinc.com> wrote:
> >
> > Add riscv specific selftest for hardhardware breakpoints.
>
> nit: double hardware
>
> > These tests are based on:
> > tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
>
> The sefltest didn't build for me. There's a few suggested fixes below.
>
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > The selftest fails as register_user_hw_breakpoint seemingly does not
> > call arch_install_hw_breakpoint. The test also seems to fail on arm64
> > in the same way when I tested it.
>
> Is this still a problem with your patchset?

Yes

>
> Do you test in qemu? Can you share your version, command line, etc?

Yes. I used buildroot's `qemu_aarch64_virt_defconfig` config and set
`BR2_PACKAGE_LINUX_TOOLS_SELFTESTS` and tested with the example
command from the boards readme.

>
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/breakpoints/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2021 ARM Limited
> > +# Originally tools/testing/arm64/abi/Makefile
>
> CFLAGS +=3D $(KHDR_INCLUDES)
>
> This adds -isystem to include local headers for the up to date
> ptrace.h and elf.h definitions.
>
>  $ make headers

oh that's why it wasn't building!

Thanks,
Jesse Taube
>  $ make -C tools/testing/selftests CROSS_COMPILE=3Driscv64-linux-gnu-
> ARCH=3Driscv TARGETS=3Driscv/breakpoints
>      make: Entering directory 'tools/testing/selftests'
>      riscv64-linux-gnu-gcc -static
> -otools/testing/selftests/riscv/breakpoints/breakpoint_test
>      -isystem usr/include -Itools/testing/selftests/../../../tools/includ=
e
>      -D_GNU_SOURCE=3D   breakpoint_test.c
>
> > +
> > +CFLAGS +=3D -I$(top_srcdir)/tools/include
> > +
> > +TEST_GEN_PROGS :=3D breakpoint_test
> > +
> > +include ../../lib.mk
> > +
> > +$(OUTPUT)/breakpoint_test: breakpoint_test.c
> > +       $(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > diff --git a/tools/testing/selftests/riscv/breakpoints/breakpoint_test.=
c b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
> > new file mode 100644
> > index 000000000000..faeecc72da12
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2016 Google, Inc.
> > + *
> > + * Original Code by Pavel Labath <labath@google.com>
> > + *
> > + * Code modified by Pratyush Anand <panand@redhat.com>
> > + * for testing different byte select for each access size.
> > + * Originally tools/testing/selftests/breakpoints/breakpoint_test_arm6=
4.c
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <asm/ptrace.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <sys/ptrace.h>
> > +#include <sys/param.h>
> > +#include <sys/uio.h>
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +#include <stddef.h>
> > +#include <string.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <elf.h>
>
> This is the wrong elf.h, we want the one with NT_RISCV_HW_BREAK.
>
> -#include <elf.h>
> +#include <linux/elf.h>
>
>
> > +#include <errno.h>
> > +#include <signal.h>
> > +
> > +#include "../../kselftest.h"
> > +
> > +#define MAX_BP_SIZE 8
> > +

