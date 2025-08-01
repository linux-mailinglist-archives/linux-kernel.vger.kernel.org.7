Return-Path: <linux-kernel+bounces-752853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86348B17BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB56D583DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95B1917F4;
	Fri,  1 Aug 2025 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmorGNTx"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983E23AD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021428; cv=none; b=WEnE6QMKcrI73CSui6AxQsYypnis5G3/bx/vQf5wwW1nGAcoCR+8cEW0nAcYy2pWMyOapAhOSY235TMWYRmNJEgFBXT56wziDagVZVBEZIvfTTMnw/s6zaH0I88i7uyhbPHNg7cxiOh8jDEzqeI4Kgz1mr/kUSv3+u35zh0hy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021428; c=relaxed/simple;
	bh=IFSrKyozeRfmlVyHNxh6hxXWXS6Ru05onOOepuHYm6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwBMysQLrRaps4hXbcP2n+GjfNS3kDDdbuVbvcc3c2XKM9LuLavjyRNqNyEG140R6GaL7WA8gNaUb/P+9fsI7kVp9e3KOcH6Fw+85XYJeG9Dn7sxJpVSb/2TOGYxWHYAQuCfwQ0cr3XsbaYOQ9RXa0Ldz+DNg4O6bMWeX6lprpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmorGNTx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32f1df5b089so11996751fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754021424; x=1754626224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAW4jsjGko+3B//T/ExjPGSsgZPk1ToCs8jJS1FOe/8=;
        b=qmorGNTxrmcj0AQPQi0mOxIYdXXVr8QZMTRkz8Y+xGl8+lVLTKlNhVLrLHehpy30Oz
         IVEVZlXTupM/zJHkuTOHoPvtBKDUx22j7ZRX3qwnNgBbxcJiPlHdcL/3yr3RqO/2HYs3
         ghxBjlA9nhHrADr8PqzfCDOsKAkyOwTGLSsc9jhLfnTPTpZIvop7NTyuz6UbZfApQhvY
         LqH6Dhh0CiLUCXI5AlQfEbFiXYg3Qt+jk2HOGEVdqou9zMOOksEYzQ7jnsIxAS5evqhE
         C6E3C7P7A7t69gEZYvscXKfWDLwLOEYfAUJMuxDLlFQV0Z8KWm/ph9fmGVdWoP2stBkK
         cVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754021424; x=1754626224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAW4jsjGko+3B//T/ExjPGSsgZPk1ToCs8jJS1FOe/8=;
        b=ThzWSbCwRT/3Z+KyfHrRmv80Pv4O83a4i3npSPHx4KPX23e7MjyK23yKOAOj7wBhKB
         oCq2Xwp9IfPM/XYaEg+EXnlmr+Ta/HwRHxcLBuLvACjHAf7s5KOjkUluTc+OAuqOnOKz
         2nj0JXUknQ4DfRynIYkjmymVGjn2AxpwmSyzZ27NsZyKtkZ8OjIg09+7YrFHc94sqhP8
         +EPmBhHCtg47E5VfDiRW2cyQi121orc3sPTHUbGo/KDS0JQvAFr+IJJkke6X/obyvy+5
         kqNJF0rwefYwmrYIBMzBPvl2MBhiAyGgjiaVatZ4BE535iwQRlZohgC+oZpWOB3BzYG6
         pmMw==
X-Forwarded-Encrypted: i=1; AJvYcCXBIqC0MlmwTmG8w/ku63yCaWSLAVIarEWhLiFpHXtPQMC9aet4LxZvKNivO9EHOwjogXk1Ffcd7TELdYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/++bqz9oEjiSZlb5ZiXVZyRCFo8jUEV6tIRS82cRs/K2iVZqQ
	M8AOCAuFcib5rJ1kILHipO2C7RehLXonTBIf3NP2DWkh8TqTmWVPEDeGhAEVuVEz1Y6llkQSSUO
	4S9W1NCWiOD84CLndHZQIx3wgYDQQHIOdSki01F7Y
X-Gm-Gg: ASbGncvR31XCuxFkqkuAzd35sSzXUNHVo62zymT1E1d8sgy3KCC5aDDtIKlsHhDKoEW
	5ljrfE9rig97Yg/lXwyDIjL8pM6KkHr2AFUETEjztX9fKyk9cw7Fr9n/zk0bBJOdIaVuGGMMM74
	c0p1cEBna/6P4jnaHnVX6/uN6uV0OcwLSpyhNs7bsWVT/sEXxYThpWZwFh7SSxf0G7x2zEuvvKw
	2OTMeMwDpaq4QggzCvwo56xn8djJapgFDOgv50=
X-Google-Smtp-Source: AGHT+IFpLQfqgNP3sOXGbK4rrdkZDFzZkXzMQVuhbR2yywEQ6BecdCGf2TcTIlOItQFew5ZIHxJiPl61jy7aPh4TUZY=
X-Received: by 2002:a2e:9215:0:b0:32c:bc69:e921 with SMTP id
 38308e7fff4ca-33224a7b2b4mr24191841fa.9.1754021423238; Thu, 31 Jul 2025
 21:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com> <20250731115139.3035888-10-glider@google.com>
In-Reply-To: <20250731115139.3035888-10-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 Aug 2025 06:10:11 +0200
X-Gm-Features: Ac12FXzVDZLMsbHd-ebP8MIlpJEBPq1Ul2ifjai1v48RZ5V6KaIP2GFJOPpyIHU
Message-ID: <CACT4Y+bLQvbfW0_wmJ9f+ESrOd4JuR6jk5ngzq936XkZNSRZ9Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] kcov: selftests: add kcov_test
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 13:52, Alexander Potapenko <glider@google.com> wrote:
>
> Implement test fixtures for testing different combinations of coverage
> collection modes:
>  - unique and non-unique coverage;
>  - collecting PCs and comparison arguments;
>  - mapping the buffer as RO and RW.
>
> To build:
>  $ make -C tools/testing/selftests/kcov kcov_test
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v4:
>  - Per Dmitry Vyukov's request, add CONFIG_KCOV_UNIQUE=y to the
>    list of required configs
> v3:
>  - Address comments by Dmitry Vyukov:
>    - add tools/testing/selftests/kcov/config
>    - add ifdefs to KCOV_UNIQUE_ENABLE and KCOV_RESET_TRACE
>  - Properly handle/reset the coverage buffer when collecting unique
>    coverage
>
> Change-Id: I0793f1b91685873c77bcb222a03f64321244df8f
> ---
>  MAINTAINERS                              |   1 +
>  tools/testing/selftests/kcov/Makefile    |   6 +
>  tools/testing/selftests/kcov/config      |   2 +
>  tools/testing/selftests/kcov/kcov_test.c | 401 +++++++++++++++++++++++
>  4 files changed, 410 insertions(+)
>  create mode 100644 tools/testing/selftests/kcov/Makefile
>  create mode 100644 tools/testing/selftests/kcov/config
>  create mode 100644 tools/testing/selftests/kcov/kcov_test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6906eb9d88dae..c1d64cef693b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13018,6 +13018,7 @@ F:      include/linux/kcov_types.h
>  F:     include/uapi/linux/kcov.h
>  F:     kernel/kcov.c
>  F:     scripts/Makefile.kcov
> +F:     tools/testing/selftests/kcov/
>
>  KCSAN
>  M:     Marco Elver <elver@google.com>
> diff --git a/tools/testing/selftests/kcov/Makefile b/tools/testing/selftests/kcov/Makefile
> new file mode 100644
> index 0000000000000..08abf8b60bcf9
> --- /dev/null
> +++ b/tools/testing/selftests/kcov/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +LDFLAGS += -static
> +
> +TEST_GEN_PROGS := kcov_test
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/kcov/config b/tools/testing/selftests/kcov/config
> new file mode 100644
> index 0000000000000..ba0c1a0bc8bf2
> --- /dev/null
> +++ b/tools/testing/selftests/kcov/config
> @@ -0,0 +1,2 @@
> +CONFIG_KCOV=y
> +CONFIG_KCOV_UNIQUE=y
> diff --git a/tools/testing/selftests/kcov/kcov_test.c b/tools/testing/selftests/kcov/kcov_test.c
> new file mode 100644
> index 0000000000000..daf12aeb374b5
> --- /dev/null
> +++ b/tools/testing/selftests/kcov/kcov_test.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test the kernel coverage (/sys/kernel/debug/kcov).
> + *
> + * Copyright 2025 Google LLC.
> + */
> +#include <fcntl.h>
> +#include <linux/kcov.h>
> +#include <stdint.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "../kselftest_harness.h"
> +
> +/* Normally these defines should be provided by linux/kcov.h, but they aren't there yet. */
> +#ifndef KCOV_UNIQUE_ENABLE
> +#define KCOV_UNIQUE_ENABLE _IOW('c', 103, unsigned long)
> +#endif
> +#ifndef KCOV_RESET_TRACE
> +#define KCOV_RESET_TRACE _IO('c', 104)
> +#endif
> +
> +#define COVER_SIZE (64 << 10)
> +#define BITMAP_SIZE (4 << 10)
> +
> +#define DEBUG_COVER_PCS 0
> +
> +FIXTURE(kcov)
> +{
> +       int fd;
> +       unsigned long *mapping;
> +       size_t mapping_size;
> +};
> +
> +FIXTURE_VARIANT(kcov)
> +{
> +       int mode;
> +       bool fast_reset;
> +       bool map_readonly;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(kcov, mode_trace_pc)
> +{
> +       /* clang-format on */
> +       .mode = KCOV_TRACE_PC,
> +       .fast_reset = true,
> +       .map_readonly = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(kcov, mode_trace_cmp)
> +{
> +       /* clang-format on */
> +       .mode = KCOV_TRACE_CMP,
> +       .fast_reset = true,
> +       .map_readonly = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(kcov, reset_ioctl_rw)
> +{
> +       /* clang-format on */
> +       .mode = KCOV_TRACE_PC,
> +       .fast_reset = false,
> +       .map_readonly = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(kcov, reset_ioctl_ro)
> +/* clang-format off */
> +{
> +       /* clang-format on */
> +       .mode = KCOV_TRACE_PC,
> +       .fast_reset = false,
> +       .map_readonly = true,
> +};
> +
> +int kcov_open_init(struct __test_metadata *_metadata, unsigned long size,
> +                  int prot, unsigned long **out_mapping)
> +{
> +       unsigned long *mapping;
> +
> +       /* A single fd descriptor allows coverage collection on a single thread. */
> +       int fd = open("/sys/kernel/debug/kcov", O_RDWR);
> +
> +       ASSERT_NE(fd, -1)
> +       {
> +               perror("open");
> +       }
> +
> +       EXPECT_EQ(ioctl(fd, KCOV_INIT_TRACE, size), 0)
> +       {
> +               perror("ioctl KCOV_INIT_TRACE");
> +               close(fd);
> +       }
> +
> +       /* Mmap buffer shared between kernel- and user-space. */
> +       mapping = (unsigned long *)mmap(NULL, size * sizeof(unsigned long),
> +                                       prot, MAP_SHARED, fd, 0);
> +       ASSERT_NE((void *)mapping, MAP_FAILED)
> +       {
> +               perror("mmap");
> +               close(fd);
> +       }
> +       *out_mapping = mapping;
> +
> +       return fd;
> +}
> +
> +FIXTURE_SETUP(kcov)
> +{
> +       int prot = variant->map_readonly ? PROT_READ : (PROT_READ | PROT_WRITE);
> +
> +       /* Read-only mapping is incompatible with fast reset. */
> +       ASSERT_FALSE(variant->map_readonly && variant->fast_reset);
> +
> +       self->mapping_size = COVER_SIZE;
> +       self->fd = kcov_open_init(_metadata, self->mapping_size, prot,
> +                                 &(self->mapping));
> +
> +       /* Enable coverage collection on the current thread. */
> +       EXPECT_EQ(ioctl(self->fd, KCOV_ENABLE, variant->mode), 0)
> +       {
> +               perror("ioctl KCOV_ENABLE");
> +               /* Cleanup will be handled by FIXTURE_TEARDOWN. */
> +               return;
> +       }
> +}
> +
> +void kcov_uninit_close(struct __test_metadata *_metadata, int fd,
> +                      unsigned long *mapping, size_t size)
> +{
> +       /* Disable coverage collection for the current thread. */
> +       EXPECT_EQ(ioctl(fd, KCOV_DISABLE, 0), 0)
> +       {
> +               perror("ioctl KCOV_DISABLE");
> +       }
> +
> +       /* Free resources. */
> +       EXPECT_EQ(munmap(mapping, size * sizeof(unsigned long)), 0)
> +       {
> +               perror("munmap");
> +       }
> +
> +       EXPECT_EQ(close(fd), 0)
> +       {
> +               perror("close");
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(kcov)
> +{
> +       kcov_uninit_close(_metadata, self->fd, self->mapping,
> +                         self->mapping_size);
> +}
> +
> +void dump_collected_pcs(struct __test_metadata *_metadata, unsigned long *cover,
> +                       size_t start, size_t end)
> +{
> +       int i = 0;
> +
> +       TH_LOG("Collected %lu PCs", end - start);
> +#if DEBUG_COVER_PCS
> +       for (i = start; i < end; i++)
> +               TH_LOG("0x%lx", cover[i + 1]);
> +#endif
> +}
> +
> +/* Coverage collection helper without assertions. */
> +unsigned long collect_coverage_unchecked(struct __test_metadata *_metadata,
> +                                        unsigned long *cover, bool dump)
> +{
> +       unsigned long before, after;
> +
> +       before = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> +       /*
> +        * Call the target syscall call. Here we use read(-1, NULL, 0) as an example.
> +        * This will likely return an error (-EFAULT or -EBADF), but the goal is to
> +        * collect coverage for the syscall's entry/exit paths.
> +        */
> +       read(-1, NULL, 0);
> +
> +       after = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> +
> +       if (dump)
> +               dump_collected_pcs(_metadata, cover, before, after);
> +       return after - before;
> +}
> +
> +unsigned long collect_coverage_once(struct __test_metadata *_metadata,
> +                                   unsigned long *cover)
> +{
> +       unsigned long collected =
> +               collect_coverage_unchecked(_metadata, cover, /*dump*/ true);
> +
> +       /* Coverage must be non-zero. */
> +       EXPECT_GT(collected, 0);
> +       return collected;
> +}
> +
> +void reset_coverage(struct __test_metadata *_metadata, bool fast, int fd,
> +                   unsigned long *mapping)
> +{
> +       unsigned long count;
> +
> +       if (fast) {
> +               __atomic_store_n(&mapping[0], 0, __ATOMIC_RELAXED);
> +       } else {
> +               EXPECT_EQ(ioctl(fd, KCOV_RESET_TRACE, 0), 0)
> +               {
> +                       perror("ioctl KCOV_RESET_TRACE");
> +               }
> +               count = __atomic_load_n(&mapping[0], __ATOMIC_RELAXED);
> +               EXPECT_NE(count, 0);
> +       }
> +}
> +
> +TEST_F(kcov, kcov_basic_syscall_coverage)
> +{
> +       unsigned long first, second, before, after, i;
> +
> +       /* Reset coverage that may be left over from the fixture setup. */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +
> +       /* Collect the coverage for a single syscall two times in a row. */
> +       first = collect_coverage_once(_metadata, self->mapping);
> +       second = collect_coverage_once(_metadata, self->mapping);
> +       /* Collected coverage should not differ too much. */
> +       EXPECT_GT(first * 10, second);
> +       EXPECT_GT(second * 10, first);
> +
> +       /* Now reset the buffer and collect the coverage again. */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +       collect_coverage_once(_metadata, self->mapping);
> +
> +       /* Now try many times to fill up the buffer. */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +       while (collect_coverage_unchecked(_metadata, self->mapping,
> +                                         /*dump*/ false)) {
> +               /* Do nothing. */
> +       }
> +       before = __atomic_load_n(&(self->mapping[0]), __ATOMIC_RELAXED);
> +       /*
> +        * Resetting with ioctl may still generate some coverage, but much less
> +        * than there was before.
> +        */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +       after = __atomic_load_n(&(self->mapping[0]), __ATOMIC_RELAXED);
> +       EXPECT_GT(before, after);
> +       /* Collecting coverage after reset will now succeed. */
> +       collect_coverage_once(_metadata, self->mapping);
> +}
> +
> +FIXTURE(kcov_uniq)
> +{
> +       int fd;
> +       unsigned long *mapping;
> +       size_t mapping_size;
> +       unsigned long *bitmap;
> +       size_t bitmap_size;
> +       unsigned long *cover;
> +       size_t cover_size;
> +};
> +
> +FIXTURE_VARIANT(kcov_uniq)
> +{
> +       bool fast_reset;
> +       bool map_readonly;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(kcov_uniq, fast_rw)
> +{
> +       /* clang-format on */
> +       .fast_reset = true,
> +       .map_readonly = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(kcov_uniq, slow_rw)
> +{
> +       /* clang-format on */
> +       .fast_reset = false,
> +       .map_readonly = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(kcov_uniq, slow_ro)
> +{
> +       /* clang-format on */
> +       .fast_reset = false,
> +       .map_readonly = true,
> +};
> +
> +FIXTURE_SETUP(kcov_uniq)
> +{
> +       int prot = variant->map_readonly ? PROT_READ : (PROT_READ | PROT_WRITE);
> +
> +       /* Read-only mapping is incompatible with fast reset. */
> +       ASSERT_FALSE(variant->map_readonly && variant->fast_reset);
> +
> +       self->mapping_size = COVER_SIZE;
> +       self->fd = kcov_open_init(_metadata, self->mapping_size, prot,
> +                                 &(self->mapping));
> +
> +       self->bitmap = self->mapping;
> +       self->bitmap_size = BITMAP_SIZE;
> +       /*
> +        * Enable unique coverage collection on the current thread. Carve out
> +        * self->bitmap_size unsigned long's for the bitmap.
> +        */
> +       EXPECT_EQ(ioctl(self->fd, KCOV_UNIQUE_ENABLE, self->bitmap_size), 0)
> +       {
> +               perror("ioctl KCOV_ENABLE");
> +               /* Cleanup will be handled by FIXTURE_TEARDOWN. */
> +               return;
> +       }
> +       self->cover = self->mapping + BITMAP_SIZE;
> +       self->cover_size = self->mapping_size - BITMAP_SIZE;
> +}
> +
> +FIXTURE_TEARDOWN(kcov_uniq)
> +{
> +       kcov_uninit_close(_metadata, self->fd, self->mapping,
> +                         self->mapping_size);
> +}
> +
> +void reset_uniq_coverage(struct __test_metadata *_metadata, bool fast, int fd,
> +                        unsigned long *bitmap, unsigned long *cover)
> +{
> +       unsigned long count;
> +
> +       if (fast) {
> +               /*
> +                * Resetting the buffer for unique coverage collection requires
> +                * zeroing out the bitmap and cover[0]. We are assuming that
> +                * the coverage buffer immediately follows the bitmap, as they
> +                * belong to the same memory mapping.
> +                */
> +               if (cover > bitmap)
> +                       memset(bitmap, 0, sizeof(unsigned long) * (cover - bitmap));
> +               __atomic_store_n(&cover[0], 0, __ATOMIC_RELAXED);
> +       } else {
> +               EXPECT_EQ(ioctl(fd, KCOV_RESET_TRACE, 0), 0)
> +               {
> +                       perror("ioctl KCOV_RESET_TRACE");
> +               }
> +               count = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> +               EXPECT_NE(count, 0);
> +       }
> +}
> +
> +TEST_F(kcov_uniq, kcov_uniq_coverage)
> +{
> +       unsigned long first, second, before, after, i;
> +
> +       /* Reset coverage that may be left over from the fixture setup. */
> +       reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
> +
> +       /*
> +        * Collect the coverage for a single syscall two times in a row.
> +        * Use collect_coverage_unchecked(), because it may return zero coverage.
> +        */
> +       first = collect_coverage_unchecked(_metadata, self->cover,
> +                                          /*dump*/ true);
> +       second = collect_coverage_unchecked(_metadata, self->cover,
> +                                           /*dump*/ true);
> +
> +       /* Now reset the buffer and collect the coverage again. */
> +       reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
> +       collect_coverage_once(_metadata, self->cover);
> +
> +       /* Now try many times to saturate the unique coverage bitmap. */
> +       reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
> +       for (i = 0; i < 1000; i++)
> +               collect_coverage_unchecked(_metadata, self->cover,
> +                                          /*dump*/ false);
> +
> +       /* Another invocation of collect_coverage_unchecked() should not produce new coverage. */
> +       EXPECT_EQ(collect_coverage_unchecked(_metadata, self->cover,
> +                                            /*dump*/ false),
> +                 0);
> +
> +       before = __atomic_load_n(&(self->cover[0]), __ATOMIC_RELAXED);
> +       /*
> +        * Resetting with ioctl may still generate some coverage, but much less
> +        * than there was before.
> +        */
> +       reset_uniq_coverage(_metadata, variant->fast_reset, self->fd, self->bitmap, self->cover);
> +       after = __atomic_load_n(&(self->cover[0]), __ATOMIC_RELAXED);
> +       EXPECT_GT(before, after);
> +       /* Collecting coverage after reset will now succeed. */
> +       collect_coverage_once(_metadata, self->cover);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.50.1.552.g942d659e1b-goog
>

