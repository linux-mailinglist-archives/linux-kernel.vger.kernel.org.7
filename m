Return-Path: <linux-kernel+bounces-724002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C0AFED8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CD816BA02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A952E62B3;
	Wed,  9 Jul 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkVQajoi"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90B2E5B3E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074156; cv=none; b=ToPbAk1mkorlPpdVFaeD2IR7q3NvIvsMNaMH0QfTjzSyukzZxEgVfAww5ARnGB4x6FH7TGR2bJ7cKetB+aHc1N7sjDKRoesj3VNgJfhndi7R18mS7bsdBjrBDlEZpbxGN0wojNb9VhxfaAksoYNIf5ug7xNb9E1tWGBFaa8NCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074156; c=relaxed/simple;
	bh=DLS8jygYSNaTiwy0CgsgZpb27Ww1d6uFn1dzolc6GjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzpJ3G3poB0JY9VsTfr/Nkp+p143dRgOdRnsCpXQ4dS0RxAWj5PPnpVbCUm/Kmx0WusvP9+oxt+yCHsS1rmciyTl0IN3lGvpU1FVpSeGxK5swt07WBLn+jHU+U4BgvM8o3zUf8ZokPqn0In6iFUO6WJT9j0RppD5Qy0WXBmOQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkVQajoi; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b49ac6431so46234841fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752074151; x=1752678951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A27z97/vgIlW4uCKp2EUHjwiwnAcyEU21rAHulzMCfI=;
        b=hkVQajois7KEdMStPkbD1SlDLdnNyngWzBQzXd+abRLjvjPqlqTP/wbpKRg9gz3Dmb
         vViD3kYLEeBt6zj54avDdOMDsVNkuF7W8r2Yamza7oF8jn/IYADu3dNisFdMOmfv34aA
         3ZbZEZ7ta1KrZTRcFxNhdhnX4MaWzoH8CVvD8S5HwOZRK0hmq/ALXFED297VAT3UjAz8
         FjhPAaV89WEJi4rywg7guQS7xRJGawN6cDvwudzbwLeiUg96X/fW+Ls/m2orIrwlCVby
         KTrIDIfI0wwaacrexeaFOMqDCylNU+TUDXH38JhZKmiBE0il1SpVE5LsUl/RQf3T0Lck
         Mb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074151; x=1752678951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A27z97/vgIlW4uCKp2EUHjwiwnAcyEU21rAHulzMCfI=;
        b=PJNOhUQaNLEZG4DG57K8X4BeYOrmJ4YhTl0X15mvgpP7TiL8J3udxvTTSPAesNL5eh
         4Z3qOxuRYtTjsPv3joIivqFAt6TVDNGxePnLdJ5kz6NXZEzxoVEp2iHxDlH887k6A1PU
         UinR48k5AmDUY4rbLCvq04JTCTSwzXfXoy809U6J86E5R6Sg7JK2naggKwKF8rTkYYX2
         yLXrOosHjxXVsRPUxwvwZa7aMVhcsyPFe2+Csg6SCJCleW+xoBwxJVvW8Tsqy/GkRefl
         DNKT0rlS8OESva9jOML8FDu2gU4zO/CeuInCa82F3uNzfFOm7LGe5BNAb6jpPYyoTLx+
         mpDw==
X-Forwarded-Encrypted: i=1; AJvYcCVra4QfDrxpvXnKVlc6WM8zFWfZdhxt+kwUY/prAp2qDG+TYsmhXNXEqgHhqMYDyeZwVMvcSyV8e3KY844=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuT8z0NxbNeuoUVUNyAPhkpvgZNE4vw7EQvAK5QUXKTj1WVqxG
	RZjB7pdAEoYtKWI+q3au3BPFqIta8O9eklLDjeRuk2Y3nkrQpmoGeINg53eu8zkeHfbwyypZNIU
	a/QUciOPAiBvsorh5muoJYPlbc0P/BGrhfYNappnWnF25dyM8+4ULy9AMVsc=
X-Gm-Gg: ASbGncvqAMjKSAiGMX4zIR9VxiSJeo+yjB2aNbTHkVHzjwY9zC4dE0E6XAAnMxiHQpb
	z1DQ/B5FK2nN8P70YxnMZbIwrQo75Pg/uoGWVcWtotJRvnD0G+QZEJLp6AoGEfPOuOmKR/Ryn2E
	AaNC93BDFz5R4jiqobsr2W5SZvCelns7WeV0NztXuSlbqplhlR0538QsD3AFbXfVtp887yUW5nu
	xtJ
X-Google-Smtp-Source: AGHT+IHTb/TxouoTNThp4gZ8gp21aPxKW8lzOPcYxDta4J4VBXM0xpqz/63n6JxhKx4qusL32s/M9i4Wqk8DOgGYET8=
X-Received: by 2002:a2e:a98a:0:b0:32a:7d76:262e with SMTP id
 38308e7fff4ca-32f5005d663mr477901fa.3.1752074150568; Wed, 09 Jul 2025
 08:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-11-glider@google.com>
In-Reply-To: <20250626134158.3385080-11-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 9 Jul 2025 17:15:39 +0200
X-Gm-Features: Ac12FXxtraw61CeongbninQQSqNyIx-qmohyONha6T45O1gbt8Lp-PbNMBz2M-A
Message-ID: <CACT4Y+YSfOE6Y9y-8mUwUOyyE-L3PUHUr6PuNX=iu-zyMyv3=A@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] kcov: selftests: add kcov_test
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wrote:
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
> ---
>  MAINTAINERS                              |   1 +
>  tools/testing/selftests/kcov/Makefile    |   6 +
>  tools/testing/selftests/kcov/kcov_test.c | 364 +++++++++++++++++++++++

Let's also add 'config' fragment (see e.g. ./dma/config)
Otherwise it's impossible to run these tests in automated fashion.

>  3 files changed, 371 insertions(+)
>  create mode 100644 tools/testing/selftests/kcov/Makefile
>  create mode 100644 tools/testing/selftests/kcov/kcov_test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5bbc78b0fa6ed..0ec909e085077 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12833,6 +12833,7 @@ F:      include/linux/kcov_types.h
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
> diff --git a/tools/testing/selftests/kcov/kcov_test.c b/tools/testing/selftests/kcov/kcov_test.c
> new file mode 100644
> index 0000000000000..4d3ca41f28af4
> --- /dev/null
> +++ b/tools/testing/selftests/kcov/kcov_test.c
> @@ -0,0 +1,364 @@
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

Then I think we need to do:
#ifndef KCOV_UNIQUE_ENABLE



> +#define KCOV_UNIQUE_ENABLE _IOW('c', 103, unsigned long)
> +#define KCOV_RESET_TRACE _IO('c', 104)
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
> +       EXPECT_EQ(ioctl(fd, KCOV_INIT_TRACE, COVER_SIZE), 0)
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
> +               munmap(self->mapping, COVER_SIZE * sizeof(unsigned long));
> +               close(self->fd);
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
> +       /* Enable coverage collection on the current thread. */
> +       EXPECT_EQ(ioctl(self->fd, KCOV_UNIQUE_ENABLE, BITMAP_SIZE), 0)
> +       {
> +               perror("ioctl KCOV_ENABLE");
> +               munmap(self->mapping, COVER_SIZE * sizeof(unsigned long));
> +               close(self->fd);
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(kcov_uniq)
> +{
> +       kcov_uninit_close(_metadata, self->fd, self->mapping,
> +                         self->mapping_size);
> +}
> +
> +TEST_F(kcov_uniq, kcov_uniq_coverage)
> +{
> +       unsigned long first, second, before, after, i;
> +
> +       /* Reset coverage that may be left over from the fixture setup. */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +
> +       /*
> +        * Collect the coverage for a single syscall two times in a row.
> +        * Use collect_coverage_unchecked(), because it may return zero coverage.
> +        */
> +       first = collect_coverage_unchecked(_metadata, self->mapping,
> +                                          /*dump*/ true);
> +       second = collect_coverage_unchecked(_metadata, self->mapping,
> +                                           /*dump*/ true);
> +
> +       /* Now reset the buffer and collect the coverage again. */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +       collect_coverage_once(_metadata, self->mapping);
> +
> +       /* Now try many times to saturate the unique coverage bitmap. */
> +       reset_coverage(_metadata, variant->fast_reset, self->fd, self->mapping);
> +       for (i = 0; i < 1000; i++)
> +               collect_coverage_unchecked(_metadata, self->mapping,
> +                                          /*dump*/ false);
> +       /* Another invocation of collect_coverage_unchecked() should not produce new coverage. */
> +       EXPECT_EQ(collect_coverage_unchecked(_metadata, self->mapping,
> +                                            /*dump*/ false),
> +                 0);
> +
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
> +TEST_HARNESS_MAIN
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

