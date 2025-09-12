Return-Path: <linux-kernel+bounces-814730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372BB557E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51226AC4B72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5631D39B;
	Fri, 12 Sep 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay5gNk+T"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD92D662D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710079; cv=none; b=b9sZRJrFwAjh7UIa4iz/xW6GjdYiaGlR9fhxYCVLKyKyfPysIYo4hURGe+CwoiovYGKjZKTzK8yletNf8FECPJdzO5lTnwPDkgyaWSTzVQx7ko0ptOfe/lFoYjuQ3zBftDmVh1HOheqcqWvK/iL6SmLED7qHXQ91N8Bsx1HvXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710079; c=relaxed/simple;
	bh=a5r1D82Y2WoGNE88dbhuZrqCxTlrKYnBKNCQdv+sI1Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV6AU1TXbwfpa0bqrPzIDNoTsqt1kWq4TM5vRqo7E4N8+PzzWmURs4+Wu0xIkO9RMSZRDMApq6Xa7RKYBDZ4Q7kOq4d2FOPYF1rwwZR5l0e4DLna4yWr9aRcR2ecMh/ypZ325d+KuBTZcbBYvIcraFJZ2o6vWU94akbEZk/rvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay5gNk+T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45df09c7128so19478615e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757710076; x=1758314876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztodRZzqZ7LwwLlFxMHp4gp6whyJBQuaH7JG6HpRU/w=;
        b=Ay5gNk+TlZZC5WsVXpdZzb0LGcNZHY3+FScsegHImpTMGiFKyenG22jTe+TXZDMkk8
         Q33ce0pdgxb/aiQ0kUn7L4u8EW50kep/tsGZz6RdWEswLmQmgv5qTwYufUJCxZm2uK1M
         jT2ra4GmL8qA3mLQcTCuT8A4euoOpuUR4xJwIa3Ukn/dMGj3bbCHFhMk+UM80JanO/qg
         7MLIUG60PjLXpaIX69kqKJpmN7+VT7Y+NycF/+VV9EIxGEJCKHpXcmZ0HmiZ8Zh4xIfm
         71hQh3QXNmzcR4mxxoyia7NEOO+2kWzS/mlprYmm8/DNsCbFSnOJrOtzctBzGkv1SyOu
         qoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757710076; x=1758314876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztodRZzqZ7LwwLlFxMHp4gp6whyJBQuaH7JG6HpRU/w=;
        b=G5xjI++9l1e9zvPoJOmA0Ii4InE8QCEuq7lRBBKD7FWgWQ9BMrfyDDn9vad/Aq2CWG
         uFl0K1OC/AhN5l3MXwoaqYEiv44QsUmuCseLhuLETPA9w8dej4getfmQ4mcbpc++MbRM
         VIAFkpwKb/ah7l6DEZX7Nrxq1J9/Y2uSOHWFY6PkQc4T9kBO3Eaeaa0eF+3IP28pp6aT
         9Nq0Ds7ZqTB9OkX/77vwVkWfG7ywNXH6GIKhds5tDMc8Y5YyTRMyHeZ30Gtz2KgvOznB
         hdUxgqqb6S0r5r5nLjyYauCuwCb9KxsXOOZsd+JbtL84gb7DUlJwjVB1ldNVhpTKD9m9
         VUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR8anQG1guE9i4+4Mg7BmQ8UigrnSuQGMv6FI2Ey5EnZOk4WaumnLZcmcAssoiRWxVpU02foxUcTDAh2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IpAeFuAh8HD6KzuOi1DFlAEwIyTc3CXJjMz6yfGU4yA3dbVA
	T63H5w+wn95uzTs1WdH+Q6O4pjgPP28uBX2GXHldntFMlGG+oklA12Er
X-Gm-Gg: ASbGnctkJ6TNNycb0u8/LHYBPdYwo5kY+A7KGnXsjNAVnrRsIAER8M1ICnsHygcif74
	K3gIxRQOKmYo9FaW8l1orrhZlW6+5cvExPyFk4BzImdNR+n8zTNEGVIys9Cv3jSY8x+qTwEBec/
	qoV9YbUPiymVCLkM0Wx2yGPgBsdsYFphaqcIJQEppLhWW7nxY2Ouk3e7jxBlxmbrMhJmVVX73T1
	hPLWcRYj6+JG+8hve2pEx9yDlmZl0hkSFDayHbuiDcdCSbXEWxh1BUxs/hROtfbOaGbPnoFG9u5
	rsR5IaqGKsaryC02HPRF20Lg8tbhBfqXSWWIgy7RkHpo6Q/dfzs4PsXreZAu2g3JJrmP4Na4Wyb
	bs1aUJohIZX4rZcVOWpFUkQ67yzzni8KIUz1vHxcIMDoUARWnxg==
X-Google-Smtp-Source: AGHT+IFIvkjy8Vwo+tcss+tuzUrJigzqjS7F4UVyfQ+Mr6yldJrMZviznywA0j6s22x0kQNAy0i8hQ==
X-Received: by 2002:a05:600c:3b93:b0:45b:8ac2:9761 with SMTP id 5b1f17b1804b1-45f2698a026mr4412855e9.13.1757710075861;
        Fri, 12 Sep 2025 13:47:55 -0700 (PDT)
Received: from krava (89-40-234-69.wdsl.neomedia.it. [89.40.234.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015ad780sm38311015e9.10.2025.09.12.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 13:47:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 Sep 2025 22:47:52 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiawei Zhao <phoenix500526@163.com>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the bpf-next tree
Message-ID: <aMSG-N9MiySZX6UQ@krava>
References: <20250912124059.0428127b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912124059.0428127b@canb.auug.org.au>

On Fri, Sep 12, 2025 at 12:40:59PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   tools/testing/selftests/bpf/prog_tests/usdt.c
> 
> between commit:
> 
>   69424097ee10 ("selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic")
> 
> from the bpf-next tree and commit:
> 
>   875e1705ad99 ("selftests/bpf: Add optimized usdt variant for basic usdt test")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

hi,
fwiw the conflict was mentioned in here:
  https://lore.kernel.org/bpf/aMAiMrLlfmG9FbQ3@krava/

the fix looks good, thanks

jirka

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc tools/testing/selftests/bpf/prog_tests/usdt.c
> index 615e9c3e93bf,833eb87483a1..000000000000
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@@ -40,73 -40,20 +40,80 @@@ static void __always_inline trigger_fun
>   	}
>   }
>   
>  +#if defined(__x86_64__) || defined(__i386__)
>  +/*
>  + * SIB (Scale-Index-Base) addressing format: "size@(base_reg, index_reg, scale)"
>  + * - 'size' is the size in bytes of the array element, and its sign indicates
>  + *   whether the type is signed (negative) or unsigned (positive).
>  + * - 'base_reg' is the register holding the base address, normally rdx or edx
>  + * - 'index_reg' is the register holding the index, normally rax or eax
>  + * - 'scale' is the scaling factor (typically 1, 2, 4, or 8), which matches the
>  + *    size of the element type.
>  + *
>  + * For example, for an array of 'short' (signed 2-byte elements), the SIB spec would be:
>  + * - size: -2 (negative because 'short' is signed)
>  + * - scale: 2 (since sizeof(short) == 2)
>  + *
>  + * The resulting SIB format: "-2@(%%rdx,%%rax,2)" for x86_64, "-2@(%%edx,%%eax,2)" for i386
>  + */
>  +static volatile short array[] = {-1, -2, -3, -4};
>  +
>  +#if defined(__x86_64__)
>  +#define USDT_SIB_ARG_SPEC -2@(%%rdx,%%rax,2)
>  +#else
>  +#define USDT_SIB_ARG_SPEC -2@(%%edx,%%eax,2)
>  +#endif
>  +
>  +unsigned short test_usdt_sib_semaphore SEC(".probes");
>  +
>  +static void trigger_sib_spec(void)
>  +{
>  +	/*
>  +	 * Force SIB addressing with inline assembly.
>  +	 *
>  +	 * You must compile with -std=gnu99 or -std=c99 to use the
>  +	 * STAP_PROBE_ASM macro.
>  +	 *
>  +	 * The STAP_PROBE_ASM macro generates a quoted string that gets
>  +	 * inserted between the surrounding assembly instructions. In this
>  +	 * case, USDT_SIB_ARG_SPEC is embedded directly into the instruction
>  +	 * stream, creating a probe point between the asm statement boundaries.
>  +	 * It works fine with gcc/clang.
>  +	 *
>  +	 * Register constraints:
>  +	 * - "d"(array): Binds the 'array' variable to %rdx or %edx register
>  +	 * - "a"(0): Binds the constant 0 to %rax or %eax register
>  +	 * These ensure that when USDT_SIB_ARG_SPEC references %%rdx(%edx) and
>  +	 * %%rax(%eax), they contain the expected values for SIB addressing.
>  +	 *
>  +	 * The "memory" clobber prevents the compiler from reordering memory
>  +	 * accesses around the probe point, ensuring that the probe behavior
>  +	 * is predictable and consistent.
>  +	 */
>  +	asm volatile(
>  +		STAP_PROBE_ASM(test, usdt_sib, USDT_SIB_ARG_SPEC)
>  +		:
>  +		: "d"(array), "a"(0)
>  +		: "memory"
>  +	);
>  +}
>  +#endif
>  +
> - static void subtest_basic_usdt(void)
> + static void subtest_basic_usdt(bool optimized)
>   {
>   	LIBBPF_OPTS(bpf_usdt_opts, opts);
>   	struct test_usdt *skel;
>   	struct test_usdt__bss *bss;
> - 	int err, i;
> + 	int err, i, called;
>  +	const __u64 expected_cookie = 0xcafedeadbeeffeed;
>   
> + #define TRIGGER(x) ({			\
> + 	trigger_func(x);		\
> + 	if (optimized)			\
> + 		trigger_func(x);	\
> + 	optimized ? 2 : 1;		\
> + 	})
> + 
>   	skel = test_usdt__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "skel_open"))
>   		return;
> @@@ -126,22 -73,13 +133,22 @@@
>   	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
>   		goto cleanup;
>   
>  +#if defined(__x86_64__) || defined(__i386__)
>  +	opts.usdt_cookie = expected_cookie;
>  +	skel->links.usdt_sib = bpf_program__attach_usdt(skel->progs.usdt_sib,
>  +							 0 /*self*/, "/proc/self/exe",
>  +							 "test", "usdt_sib", &opts);
>  +	if (!ASSERT_OK_PTR(skel->links.usdt_sib, "usdt_sib_link"))
>  +		goto cleanup;
>  +#endif
>  +
> - 	trigger_func(1);
> + 	called = TRIGGER(1);
>   
> - 	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
> - 	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
> - 	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
> + 	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
> + 	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
> + 	ASSERT_EQ(bss->usdt12_called, called, "usdt12_called");
>   
>  -	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
>  +	ASSERT_EQ(bss->usdt0_cookie, expected_cookie, "usdt0_cookie");
>   	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
>   	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
>   	ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
> @@@ -225,18 -163,9 +232,19 @@@
>   	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
>   	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
>   
>  +#if defined(__x86_64__) || defined(__i386__)
>  +	trigger_sib_spec();
>  +	ASSERT_EQ(bss->usdt_sib_called, 1, "usdt_sib_called");
>  +	ASSERT_EQ(bss->usdt_sib_cookie, expected_cookie, "usdt_sib_cookie");
>  +	ASSERT_EQ(bss->usdt_sib_arg_cnt, 1, "usdt_sib_arg_cnt");
>  +	ASSERT_EQ(bss->usdt_sib_arg, nums[0], "usdt_sib_arg");
>  +	ASSERT_EQ(bss->usdt_sib_arg_ret, 0, "usdt_sib_arg_ret");
>  +	ASSERT_EQ(bss->usdt_sib_arg_size, sizeof(nums[0]), "usdt_sib_arg_size");
>  +#endif
>  +
>   cleanup:
>   	test_usdt__destroy(skel);
> + #undef TRIGGER
>   }
>   
>   unsigned short test_usdt_100_semaphore SEC(".probes");



