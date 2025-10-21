Return-Path: <linux-kernel+bounces-863840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43304BF93F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264454E73FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C24299AAC;
	Tue, 21 Oct 2025 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cFxhLZ0x"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5A296BB2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089564; cv=none; b=kQu8aX4fD1GOpHvdBYPn4GoXU1UPv7Bufl3JdRL7rvyz2mIgWY04SvA5cKGrP6YlKJ7y0vtGdaI7iIWX0RqiBsPPVb9wJr2bkdIWACXrjEfxQYI1dm9JsUUZQWL+c+R5nk1WV5zEKIvRllEOdYIcnVcmg2MB7gE4hHEt+gE4jIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089564; c=relaxed/simple;
	bh=W9pUaA3zVraV4naj1+WvfAvMwlh/dXoIcr40exlFfqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4iVTWzVpCPc1WtmdsfPo0FMTM1GlHkLXafplkgXKi6uyatWLA7TGcVAh1hsl1pwIgUykG+tb92G1pgZpUoWxMgT+Ez+2pgxbwdqP6JMk45kMdFFI4N7rbmYGoc07Falt3VUR8JTMnkebl/Q0dgXVC03VYSKH13I/419+LhNM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cFxhLZ0x; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a265a02477so222650b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761089561; x=1761694361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3SoQg6qUy/7R1NB2YZ8xX742KWcwmoU6IRF+Yny0HQ=;
        b=cFxhLZ0xV6q8D0PqQms6xxK+vKC4z/m5W0O4Qmh5N3NpPzlB9cQBzV4rBjipGz8rql
         f2K+YavwbrlssaPRZHQSNlYB3/j8rChb4Qm0sMCXJNGv53CsAkCdZ0BtV+nSkpji8+K4
         Ef1HiS3gSY5DQJJEG7fTpnLySuB9HTSPn+pusrDuaHyt4TSqDSLJH8s5zu61V5sJR35m
         LuKlwmkBFDzeNbkl/3qJhBxkI82aRiEU0hzIJWVgxlxI4U2CFebAvnC1AutCXeQnPp4/
         Nc08AuQ3gBY+dK+fYMkwjRHe2m02T/OCLNpdBZ/t0ts4EbDM2V7eTRQc8JxOzcoq4p/6
         2X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089561; x=1761694361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3SoQg6qUy/7R1NB2YZ8xX742KWcwmoU6IRF+Yny0HQ=;
        b=cNhKiUYCcT1HOXmpKGkwn4MpU5u/S+pRch2Cz8gWbjcNSjl7EDPCTx+hqXUwI1zNnb
         w0Xk4kvu8gq1RP0/kijNl8Q/EtiSDgHYEK7nMUg8gNAfA16zO7Uw94axdULnho2P7qao
         qnKq0LsQuVTecvzEysv4FtikHlGjYTVihSQWcX4dS42R4740N+TVywO7xSL/oWUjfCUc
         CworEPxc09W+wM0Lzk+L5a2FIVslsHc7Ry1BpnUYJQggR5Yc3TzsZmI2WIh27urkIXyO
         AywEpwKlrAsA/Q3EcoiiizMidG7vVqYpWrCUza8xQpL2Doc+wB/ZATKn17nsSOllbvjV
         49oA==
X-Forwarded-Encrypted: i=1; AJvYcCVoPccDs5Q1VrxSEF/orTP6LGRowZvZAQIYnXacwwDmJxiGHCtw6icoURAQPggIyTmnTnHfpxrlHYs9Fos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhKgfg+Uc9Dkrn7BAaN8ttpT1fBErQ8PDSnKLdxChAmUUhGAf
	J/ekoPWHl8Z6mL1p9PgNFo8RjHgG320Uwy0eTk/AGzW8dJJ41dsVWn+2kwzD28w0qtBiWtvG2sA
	r+68qkKI=
X-Gm-Gg: ASbGncvCdbj/Hmdku8b0b4sWWzfkxKliDxezP/rdDc+1HqcyOpqszF4Zqix7Outs6Tc
	P06foe5gE8CBJBKRn+Xjp5AMVbmd1Xke7w5yrsKTnwDt9H/TUhl7pqG1rU7sK84BNyEyl1dD3E2
	f8c3OztFHRxU4ws2Wz1Fxz0n/gh1G1BuelnnSAXgmCGFkyXFEhkndPT0G8Ptu61zLw77dRf4rOQ
	Fv+1rxDO0/JdiOvxuxeLjBbbyyqJsR/ztHSdmxQ8eeK1iP64Oe857wiwRuSk2BLvF3qbgYJ2aiH
	C5mVbvQGnW4UcLlbPYkTOT7605uaWRhO/171hYUuGyx7Ri1c5wINXu+FQLvVv5zdGUBW11db/3/
	337t6w5aWsCJH08Udbyk0AHJa0wBjmqjj8uuk199Wj6mlWKCpv1VH/MaI7o9GKhiIQMs6VuUFJx
	C9C0spwqAUSGoH
X-Google-Smtp-Source: AGHT+IH03kcA+/FfdgqJXUp6O1wg52OQMz/iAFdL9ej2bbR8YwvepRUXUpSaIHOJ/xd6jmJ3hdD2jw==
X-Received: by 2002:a05:6a20:918a:b0:32b:71e9:81ae with SMTP id adf61e73a8af0-334a850dcc4mr24086859637.8.1761089561537;
        Tue, 21 Oct 2025 16:32:41 -0700 (PDT)
Received: from localhost ([208.115.86.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33a27sm11434964a12.25.2025.10.21.16.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:32:41 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:32:40 -0700
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu, 
	cleger@rivosinc.com, evan@rivosinc.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org, samuel.holland@sifive.com, 
	shuah@kernel.org, zhangyin2018@iscas.ac.cn, zihongyao@outlook.com
Subject: Re: [PATCH v3 2/2] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251021-01a9b77e3d88543581f1a7fb@orel>
References: <20251020152924.64551-1-zihong.plct@isrc.iscas.ac.cn>
 <20251020153721.71842-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020153721.71842-1-zihong.plct@isrc.iscas.ac.cn>

On Mon, Oct 20, 2025 at 11:37:20PM +0800, Yao Zihong wrote:
> Add selftest to cbo.c to verify Zicbop extension behavior.
> 
> The test checks:
> - That hwprobe correctly reports Zicbop presence and block size.
> - That prefetch instructions execute without exception on valid and NULL
>   addresses when Zicbop is present.
> - That prefetch.{i,r,w} do not trigger SIGILL even when Zicbop is absent,
>   since Zicbop instructions are defined as hints.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 188 +++++++++++++++++---
>  1 file changed, 159 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index 5e96ef785d0d..163228e3f2c7 100644
> --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> @@ -15,24 +15,30 @@
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <asm/ucontext.h>
> +#include <getopt.h>
>  
>  #include "hwprobe.h"
>  #include "../../kselftest.h"
>  
>  #define MK_CBO(fn) le32_bswap((uint32_t)(fn) << 20 | 10 << 15 | 2 << 12 | 0 << 7 | 15)
> +#define MK_PREFETCH(fn) \
> +	le32_bswap(0 << 25 | (uint32_t)(fn) << 20 | 10 << 15 | 6 << 12 | 0 << 7 | 19)
>  
>  static char mem[4096] __aligned(4096) = { [0 ... 4095] = 0xa5 };
>  
> -static bool illegal_insn;
> +static bool got_fault;
>  
>  static void sigill_handler(int sig, siginfo_t *info, void *context)
>  {
>  	unsigned long *regs = (unsigned long *)&((ucontext_t *)context)->uc_mcontext;
>  	uint32_t insn = *(uint32_t *)regs[0];
>  
> -	assert(insn == MK_CBO(regs[11]));
> +	if (regs[12] == 0)
> +		assert(insn == MK_CBO(regs[11]));
> +	else
> +		assert(insn == MK_PREFETCH(regs[11]));
>  
> -	illegal_insn = true;
> +	got_fault = true;
>  	regs[0] += 4;
>  }
>  
> @@ -41,43 +47,75 @@ static void sigill_handler(int sig, siginfo_t *info, void *context)
>  	asm volatile(								\
>  	"mv	a0, %0\n"							\
>  	"li	a1, %1\n"							\
> +	"li	a2, 0\n"							\
>  	".4byte	%2\n"								\
> -	: : "r" (base), "i" (fn), "i" (MK_CBO(fn)) : "a0", "a1", "memory");	\
> +	: : "r" (base), "i" (fn), "i" (MK_CBO(fn)) : "a0", "a1", "a2", "memory");	\
> +})
> +
> +#define prefetch_insn(base, fn)							\
> +({										\
> +	asm volatile(								\
> +	"mv	a0, %0\n"							\
> +	"li	a1, %1\n"							\
> +	"li	a2, 1\n"							\
> +	".4byte	%2\n"								\
> +	: : "r" (base), "i" (fn), "i" (MK_PREFETCH(fn)) : "a0", "a1", "a2");\
>  })
>  
>  static void cbo_inval(char *base) { cbo_insn(base, 0); }
>  static void cbo_clean(char *base) { cbo_insn(base, 1); }
>  static void cbo_flush(char *base) { cbo_insn(base, 2); }
>  static void cbo_zero(char *base)  { cbo_insn(base, 4); }
> +static void prefetch_i(char *base) { prefetch_insn(base, 0); }
> +static void prefetch_r(char *base) { prefetch_insn(base, 1); }
> +static void prefetch_w(char *base) { prefetch_insn(base, 3); }
> +
> +static void test_no_zicbop(void *arg)
> +{
> +	/* Zicbop prefetch.* are HINT instructions. */
> +	ksft_print_msg("Testing Zicbop instructions\n");
> +
> +	got_fault = false;
> +	prefetch_i(&mem[0]);
> +	ksft_test_result(!got_fault, "No prefetch.i\n");
> +
> +	got_fault = false;
> +	prefetch_r(&mem[0]);
> +	ksft_test_result(!got_fault, "No prefetch.r\n");
> +
> +	got_fault = false;
> +	prefetch_w(&mem[0]);
> +	ksft_test_result(!got_fault, "No prefetch.w\n");
> +}
>  
>  static void test_no_cbo_inval(void *arg)
>  {
>  	ksft_print_msg("Testing cbo.inval instruction remain privileged\n");
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_inval(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.inval\n");
> +	ksft_test_result(got_fault, "No cbo.inval\n");
>  }
>  
>  static void test_no_zicbom(void *arg)
>  {
>  	ksft_print_msg("Testing Zicbom instructions remain privileged\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_clean(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.clean\n");
> +	ksft_test_result(got_fault, "No cbo.clean\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_flush(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.flush\n");
> +	ksft_test_result(got_fault, "No cbo.flush\n");
>  }
>  
>  static void test_no_zicboz(void *arg)
>  {
>  	ksft_print_msg("No Zicboz, testing cbo.zero remains privileged\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_zero(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.zero\n");
> +	ksft_test_result(got_fault, "No cbo.zero\n");
>  }
>  
>  static bool is_power_of_2(__u64 n)
> @@ -85,6 +123,34 @@ static bool is_power_of_2(__u64 n)
>  	return n != 0 && (n & (n - 1)) == 0;
>  }
>  
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
> +	got_fault = false;
> +	prefetch_i(&mem[0]);
> +	prefetch_r(&mem[0]);
> +	prefetch_w(&mem[0]);
> +	ksft_test_result(!got_fault, "Zicbop prefetch.* on valid address\n");
> +
> +	got_fault = false;
> +	prefetch_i(NULL);
> +	prefetch_r(NULL);
> +	prefetch_w(NULL);
> +	ksft_test_result(!got_fault, "Zicbop prefetch.* on NULL\n");
> +}
> +
>  static void test_zicbom(void *arg)
>  {
>  	struct riscv_hwprobe pair = {
> @@ -100,13 +166,13 @@ static void test_zicbom(void *arg)
>  			 is_power_of_2(block_size), "Zicbom block size\n");
>  	ksft_print_msg("Zicbom block size: %llu\n", block_size);
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_clean(&mem[block_size]);
> -	ksft_test_result(!illegal_insn, "cbo.clean\n");
> +	ksft_test_result(!got_fault, "cbo.clean\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_flush(&mem[block_size]);
> -	ksft_test_result(!illegal_insn, "cbo.flush\n");
> +	ksft_test_result(!got_fault, "cbo.flush\n");
>  }
>  
>  static void test_zicboz(void *arg)
> @@ -125,11 +191,11 @@ static void test_zicboz(void *arg)
>  			 is_power_of_2(block_size), "Zicboz block size\n");
>  	ksft_print_msg("Zicboz block size: %llu\n", block_size);
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_zero(&mem[block_size]);
> -	ksft_test_result(!illegal_insn, "cbo.zero\n");
> +	ksft_test_result(!got_fault, "cbo.zero\n");
>  
> -	if (illegal_insn || !is_power_of_2(block_size)) {
> +	if (got_fault || !is_power_of_2(block_size)) {
>  		ksft_test_result_skip("cbo.zero check\n");
>  		return;
>  	}
> @@ -148,7 +214,7 @@ static void test_zicboz(void *arg)
>  			if (mem[i * block_size + j] != expected) {
>  				ksft_test_result_fail("cbo.zero check\n");
>  				ksft_print_msg("cbo.zero check: mem[%llu] != 0x%x\n",
> -					       i * block_size + j, expected);
> +						   i * block_size + j, expected);

Undesired reformatting

>  				return;
>  			}
>  		}
> @@ -177,7 +243,19 @@ static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
>  		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
>  		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
>  
> -		cbostr = cbo == RISCV_HWPROBE_EXT_ZICBOZ ? "Zicboz" : "Zicbom";
> +		switch (cbo) {
> +		case RISCV_HWPROBE_EXT_ZICBOZ:
> +			cbostr = "Zicboz";
> +			break;
> +		case RISCV_HWPROBE_EXT_ZICBOM:
> +			cbostr = "Zicbom";
> +			break;
> +		case RISCV_HWPROBE_EXT_ZICBOP:
> +			cbostr = "Zicbop";
> +			break;
> +		default:
> +			ksft_exit_fail_msg("Internal error: invalid cbo %llu\n", cbo);
> +		}
>  
>  		if (pair.value & cbo)
>  			ksft_exit_fail_msg("%s is only present on a subset of harts.\n"
> @@ -194,6 +272,8 @@ enum {
>  	TEST_ZICBOM,
>  	TEST_NO_ZICBOM,
>  	TEST_NO_CBO_INVAL,
> +	TEST_ZICBOP,
> +	TEST_NO_ZICBOP
>  };
>  
>  static struct test_info {
> @@ -206,27 +286,70 @@ static struct test_info {
>  	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
>  	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
>  	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
> +	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop },
> +	[TEST_NO_ZICBOP]	= { .nr_tests = 3, test_no_zicbop },
>  };
>  
> -int main(int argc, char **argv)
> +static const struct option long_opts[] = {
> +	{"sigill", no_argument, 0, 'i'},
> +	{"sigsegv", no_argument, 0, 's'},
> +	{"sigbus", no_argument, 0, 'b'},
> +	{0, 0, 0, 0}
> +};
> +
> +static void install_sigaction(int argc, char **argv)
>  {
> +	int rc, opt, long_index;
> +	bool sigill;
> +
>  	struct sigaction act = {
>  		.sa_sigaction = &sigill_handler,
>  		.sa_flags = SA_SIGINFO,
>  	};
> +
> +	long_index = 0;
> +	sigill = false;
> +
> +	while ((opt = getopt_long(argc, argv, "isb", long_opts, &long_index)) != -1) {
> +		switch (opt) {
> +		case 'i':
> +			rc = sigaction(SIGILL, &act, NULL);
> +			assert(rc == 0);
> +			sigill = true;
> +			break;
> +		case 's':
> +			rc = sigaction(SIGSEGV, &act, NULL);
> +			assert(rc == 0);
> +			break;
> +		case 'b':
> +			rc = sigaction(SIGBUS, &act, NULL);
> +			assert(rc == 0);
> +			break;

Should we just unconditionally register handlers for SIGSEGV and SIGBUS?

> +		case '?':
> +			fprintf(stderr, "Unknown option or missing arg\n");
> +			exit(1);
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (sigill) {
> +		tests[TEST_NO_ZICBOZ].enabled = true;
> +		tests[TEST_NO_ZICBOM].enabled = true;
> +		tests[TEST_NO_CBO_INVAL].enabled = true;
> +		tests[TEST_NO_ZICBOP].enabled = true;
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
>  	struct riscv_hwprobe pair;
>  	unsigned int plan = 0;
>  	cpu_set_t cpus;
>  	long rc;
>  	int i;
>  
> -	if (argc > 1 && !strcmp(argv[1], "--sigill")) {
> -		rc = sigaction(SIGILL, &act, NULL);
> -		assert(rc == 0);
> -		tests[TEST_NO_ZICBOZ].enabled = true;
> -		tests[TEST_NO_ZICBOM].enabled = true;
> -		tests[TEST_NO_CBO_INVAL].enabled = true;
> -	}
> +	install_sigaction(argc, argv);
>  
>  	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
>  	assert(rc == 0);
> @@ -253,6 +376,13 @@ int main(int argc, char **argv)
>  		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOM);
>  	}
>  
> +	if (pair.value & RISCV_HWPROBE_EXT_ZICBOP) {
> +		tests[TEST_ZICBOP].enabled = true;
> +		tests[TEST_NO_ZICBOP].enabled = false;
> +	} else {
> +		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOP);
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(tests); ++i)
>  		plan += tests[i].enabled ? tests[i].nr_tests : 0;
>  
> -- 
> 2.47.2
>

Otherwise

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

