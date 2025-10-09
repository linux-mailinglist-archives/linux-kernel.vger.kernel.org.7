Return-Path: <linux-kernel+bounces-847237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77126BCA546
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E21B423DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E723371B;
	Thu,  9 Oct 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kBhNiDMu"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C661DDDD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029606; cv=none; b=AykPeEFd6boYR3CZH2r07a3Z6VBbFa42NfEETsxZcDkFNUVdGOAPTTKrUK2mfVCvg2HB5f10QGKtEz0qDUmpxiosXZxn5HndaSy72/xDbW3PKx4KPWYXgBDFFaCqa8fqoo65vB39qnw9pNe+8gL6myUSaJe+f7p7P0ls6IuBpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029606; c=relaxed/simple;
	bh=FCSCoATPagDSQOI4OlPqpsRZqVFH+C+jEnnYX8BpgBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKHKSPj4kLR4Fi4mTg0/VT1ib5cB0Ct7pOXAyLv2uiWI41bo20yw6RdqBlOFy9qn4UAaGdpFOr3rgYNTf9Mmbtecm9sYHj6Vv857Eod70TisC75zyavOQS3+RZBBYcNGjFpXb/1qTK6x9J5TE83hEnXRRPFn9uJkq0ftpZRXB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kBhNiDMu; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f94689e73so6317545ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760029604; x=1760634404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKPMxaw1e/CSI4IBpW9bqFcqd8FgCY16hn8f9eezxvU=;
        b=kBhNiDMuZt44y5yUjM1AHieJDAKS+R3X9oCNhXhwi+NrqCyigZlK6Obh4dQ/hSNs/R
         pVbohcnSujkj3GCmoUMCm4ogsmfm273Z3lXKmk1SJNs5p0Ly0mgYEHkH9EcrRgV3aPT3
         5elWatZcgXE2fIJUq2ty/x82TBltvVl82T6UiYGKJtbEA/o+xi3D75pmwhcive/8hJjW
         Y9epVS39kfX2k2opXVKs558TBisETkOpsH72TY9JgtoXhMI/DIJ1MqHCG1U3W6G9FoXD
         Y8ZzBdE/3OIvv6+PN9627aoknbKIWtPtrlsivPwo2hK34kv/m59MsuTXLluig2vOvYbV
         5c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029604; x=1760634404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKPMxaw1e/CSI4IBpW9bqFcqd8FgCY16hn8f9eezxvU=;
        b=ubV6oeCgT5+EPRT7rLBqQKO2RkK53bUzmQxv/BLSvr9ju3EmbxKXCPXAEZCFF4DaXO
         fr4fMoefPAjk0YVyoEr82br21fvhY09HvZlx6uc/d/M2XdfRBxa9E3Fd6wrMzTmyLhhv
         wKONazA+x7LE8fRJNyEHwgNYRPjZh/+mVaCAswzR/UcKVTtxSFSlBYW4OFc6/S68+bCB
         D2L6Kp9Y0fe6Ec0VNN+RlihnCI1vHQXo+gcWlcKKL/1i9AVIOQk9bMbohvULYyDPVc6/
         udVTkt6+Xr2nCADqfu25kuzq45X5/lHseCHoeo4YAEm8LD4PUg8UxvfNta5t0f+TDfta
         /0rw==
X-Forwarded-Encrypted: i=1; AJvYcCVG2zv6WB0sWxTKCN2blF5bYqHZTos2svh11xTDkY9SWWh4A7DncBzVAgpv0c1nQcfuIcQhkDIPL8eOmRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkAuyMPd9KCIz59jLUOZYvzuUCCzVm6obakijsScBZ3DxEtdL
	mMwIvhkNCUHM8p1ig+/8bOk+6JkxnUvz/iC2621yWDecJHaYALdf4DE7g7UHiwqJhLI=
X-Gm-Gg: ASbGncuBTZ152zqtpByoDrNI6ggJwBz4LP3hpULiUhQjCpojL0J+CRxlGtrb/D9kPXD
	zk9yT0zDg53Yl2aFM4nJLh796wEpBExO+LzPiv//8Wy8PCKcGovbxH/fy5anGMqeAjka1IvsYvV
	7Ly0WV6M3os+sUm0ZLQQOcQDo2Dleldllr0V4JSHmgJXSUVtzUY2cnsGsMoh5K6N0MCELzP98gT
	ncLIryHT+AkLGMNcHkElkcjfQblEkVN67L5O/R56CkjmPLXKhi7CiB70MevNHCV9c+wTGc5s10g
	a+k5hYOqlLAco31y1CYd0sZJKNeQBYscMQWAgS/Vg+KfjuUA6TmCZB1daLNrazagYuFNQj6sBuw
	rKn81hAXdrLu4L+/0rSAoMSAudnC5CQZomy+PfmOJTtqZKMO8ApEtoTKxGmo=
X-Google-Smtp-Source: AGHT+IE7HmtjM/fdzDtBAUsvXAeivVgUWkJTe2pyKClZENU3vOd6f/J8Y5IULzzyaLuO7T3tVJzjVQ==
X-Received: by 2002:a05:6e02:18c7:b0:424:7d95:b90b with SMTP id e9e14a558f8ab-42f8737e0b5mr87355225ab.14.1760029603650;
        Thu, 09 Oct 2025 10:06:43 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc84e7sm7896959173.36.2025.10.09.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:06:43 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:06:42 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alexghiti@rivosinc.com, shuah@kernel.org, samuel.holland@sifive.com, evan@rivosinc.com, 
	cleger@rivosinc.com, zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251009-49032bae395a1c26cbe80928@orel>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
 <20251009134318.23040-5-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009134318.23040-5-zihong.plct@isrc.iscas.ac.cn>

On Thu, Oct 09, 2025 at 09:41:54PM +0800, Yao Zihong wrote:
> Add a new selftest under hwprobe/ to verify Zicbop extension behavior.
> 
> The test checks:
> - That hwprobe correctly reports Zicbop presence and block size.
> - That prefetch instructions execute without exception on valid and NULL
>   addresses when Zicbop is present.
> - That prefetch.{i,r,w} do not trigger SIGILL even when Zicbop is absent,
>   since Zicbop instructions are defined as hints.
> 
> The test is based on cbo.c but adapted for Zicbop prefetch instructions.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  .../testing/selftests/riscv/hwprobe/Makefile  |   5 +-
>  .../selftests/riscv/hwprobe/prefetch.c        | 236 ++++++++++++++++++
>  2 files changed, 240 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/hwprobe/prefetch.c
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/Makefile b/tools/testing/selftests/riscv/hwprobe/Makefile
> index cec81610a5f2..3c8b8ba7629c 100644
> --- a/tools/testing/selftests/riscv/hwprobe/Makefile
> +++ b/tools/testing/selftests/riscv/hwprobe/Makefile
> @@ -4,7 +4,7 @@
>  
>  CFLAGS += -I$(top_srcdir)/tools/include
>  
> -TEST_GEN_PROGS := hwprobe cbo which-cpus
> +TEST_GEN_PROGS := hwprobe cbo which-cpus prefetch
>  
>  include ../../lib.mk
>  
> @@ -16,3 +16,6 @@ $(OUTPUT)/cbo: cbo.c sys_hwprobe.S
>  
>  $(OUTPUT)/which-cpus: which-cpus.c sys_hwprobe.S
>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> +
> +$(OUTPUT)/prefetch: prefetch.c sys_hwprobe.S
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/hwprobe/prefetch.c b/tools/testing/selftests/riscv/hwprobe/prefetch.c
> new file mode 100644
> index 000000000000..d9ea048325fb
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/hwprobe/prefetch.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Ventana Micro Systems Inc.
> + * Copyright (c) 2025 PLCT Lab, ISCAS
> + *
> + * Based on tools/testing/selftests/riscv/hwprobe/cbo.c with modifications
> + * for Zicbop prefetch testing.
> + *
> + * Run with 'taskset -c <cpu-list> prefetch' to only execute hwprobe on a
> + * subset of cpus, as well as only executing the tests on those cpus.
> + */
> +#define _GNU_SOURCE
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <assert.h>
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +#include <asm/ucontext.h>
> +
> +#include "hwprobe.h"
> +#include "../../kselftest.h"
> +
> +#define MK_PREFETCH(fn) \
> +	le32_bswap(0 << 25 | (uint32_t)(fn) << 20 | 10 << 15 | 6 << 12 | 0 << 7 | 19)
> +
> +static char mem[4096] __aligned(4096) = { [0 ... 4095] = 0xa5 };
> +
> +static bool illegal;
> +
> +static void sigill_handler(int sig, siginfo_t *info, void *context)
> +{
> +	unsigned long *regs = (unsigned long *)&((ucontext_t *)context)->uc_mcontext;
> +	uint32_t insn = *(uint32_t *)regs[0];
> +
> +	assert(insn == MK_PREFETCH(regs[11]));
> +
> +	illegal = true;
> +	regs[0] += 4;
> +}
> +
> +#define prefetch_insn(base, fn)							\
> +({										\
> +	asm volatile(								\
> +	"mv	a0, %0\n"							\
> +	"li	a1, %1\n"							\
> +	".4byte	%2\n"								\
> +	: : "r" (base), "i" (fn), "i" (MK_PREFETCH(fn)) : "a0", "a1", "memory");\
> +})
> +
> +static void prefetch_i(char *base) { prefetch_insn(base, 0); }
> +
> +static void prefetch_r(char *base) { prefetch_insn(base, 1); }
> +
> +static void prefetch_w(char *base) { prefetch_insn(base, 3); }

Please remove the unnecessary blank lines between function definitions.

> +
> +static bool is_power_of_2(__u64 n)
> +{
> +	return n != 0 && (n & (n - 1)) == 0;
> +}
> +
> +static void test_no_zicbop(void *arg)
> +{
> +	// Zicbop prefetch.* are HINT instructions.

No C++ comments. Run checkpatch.

> +	ksft_print_msg("Testing Zicbop instructions\n");
> +
> +	illegal = false;
> +	prefetch_i(&mem[0]);
> +	ksft_test_result(!illegal, "No prefetch.i\n");
> +
> +	illegal = false;
> +	prefetch_r(&mem[0]);
> +	ksft_test_result(!illegal, "No prefetch.r\n");
> +
> +	illegal = false;
> +	prefetch_w(&mem[0]);
> +	ksft_test_result(!illegal, "No prefetch.w\n");
> +}
> +
> +static void test_zicbop(void *arg)
> +{
> +	struct riscv_hwprobe pair = {
> +		.key = RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE,
> +	};
> +	cpu_set_t *cpus = (cpu_set_t *)arg;
> +	__u64 block_size;
> +	long rc;
> +
> +	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
> +	block_size = pair.value;
> +	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE &&
> +			 is_power_of_2(block_size), "Zicbop block size\n");
> +	ksft_print_msg("Zicbop block size: %llu\n", block_size);
> +
> +	illegal = false;
> +	prefetch_i(&mem[0]);
> +	prefetch_r(&mem[0]);
> +	prefetch_w(&mem[0]);
> +	ksft_test_result(!illegal, "Zicbop prefetch.* on valid address\n");
> +
> +	illegal = false;
> +	prefetch_i(NULL);
> +	prefetch_r(NULL);
> +	prefetch_w(NULL);
> +	ksft_test_result(!illegal, "Zicbop prefetch.* on NULL\n");
> +}
> +
> +static void check_no_zicbop_cpus(cpu_set_t *cpus)
> +{
> +	struct riscv_hwprobe pair = {
> +		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
> +	};
> +	cpu_set_t one_cpu;
> +	int i = 0, c = 0;
> +	long rc;
> +
> +	while (i++ < CPU_COUNT(cpus)) {
> +		while (!CPU_ISSET(c, cpus))
> +			++c;
> +
> +		CPU_ZERO(&one_cpu);
> +		CPU_SET(c, &one_cpu);
> +
> +		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
> +		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
> +
> +		if (pair.value & RISCV_HWPROBE_EXT_ZICBOP)
> +			ksft_exit_fail_msg("zicbop is only present on a subset of harts.\n"
> +					   "Use taskset to select a set of harts where zicbop\n"
> +					   "presence (present or not) is consistent for each hart\n");
> +		++c;
> +	}
> +}
> +
> +enum {
> +	TEST_ZICBOP,
> +	TEST_NO_ZICBOP,
> +};
> +
> +enum {
> +	HANDLER_SIGILL,
> +	HANDLER_SIGSEGV,
> +	HANDLER_SIGBUS,
> +};

Why create this enum?

> +
> +static struct test_info {
> +	bool enabled;
> +	unsigned int nr_tests;
> +	void (*test_fn)(void *arg);
> +} tests[] = {
> +	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop },
> +	[TEST_NO_ZICBOP]	= { .nr_tests = 3, test_no_zicbop },
> +};
> +
> +static struct sighandler_info {
> +	const char *flag;
> +	int sig;
> +} handlers[] = {
> +	[HANDLER_SIGILL] = { .flag = "--sigill", .sig = SIGILL },
> +	[HANDLER_SIGSEGV] = { .flag = "--sigsegv", .sig = SIGSEGV },
> +	[HANDLER_SIGBUS] = { .flag = "--sigbus", .sig = SIGBUS },
> +};
> +
> +static bool search_flag(int argc, char **argv, const char *flag)
> +{
> +	int i;
> +
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], flag))
> +			return true;
> +	}
> +	return false;
> +}

Instead of this search function just use getopt()

> +
> +static void install_sigaction(int argc, char **argv)
> +{
> +	int i, rc;
> +	struct sigaction act = {
> +		.sa_sigaction = &sigill_handler,
> +		.sa_flags = SA_SIGINFO,
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(handlers); ++i) {
> +		if (search_flag(argc, argv, handlers[i].flag)) {
> +			rc = sigaction(handlers[i].sig, &act, NULL);
> +			assert(rc == 0);
> +		}
> +	}
> +
> +	if (search_flag(argc, argv, handlers[HANDLER_SIGILL].flag))
> +		tests[TEST_NO_ZICBOP].enabled = true;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct riscv_hwprobe pair;
> +	unsigned int plan = 0;
> +	cpu_set_t cpus;
> +	long rc;
> +	int i;
> +
> +	install_sigaction(argc, argv);
> +
> +	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
> +	assert(rc == 0);
> +
> +	ksft_print_header();
> +
> +	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
> +	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&cpus, 0);
> +	if (rc < 0)
> +		ksft_exit_fail_msg("hwprobe() failed with %ld\n", rc);
> +	assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
> +
> +	if (pair.value & RISCV_HWPROBE_EXT_ZICBOP)
> +		tests[TEST_ZICBOP].enabled = true;
> +	else
> +		check_no_zicbop_cpus(&cpus);
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); ++i)
> +		plan += tests[i].enabled ? tests[i].nr_tests : 0;
> +
> +	if (plan == 0)
> +		ksft_print_msg("No tests enabled.\n");
> +	else
> +		ksft_set_plan(plan);
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
> +		if (tests[i].enabled)
> +			tests[i].test_fn(&cpus);
> +	}
> +
> +	ksft_finished();
> +}
> -- 
> 2.47.2
>

There's no reason to duplicate cbo.c. Just parameterize
check_no_zicboz_cpus() (and rename it to check_no_zicbo_cpus())
in order to share it with zicbop and then add your new tests.

drew

