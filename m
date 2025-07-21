Return-Path: <linux-kernel+bounces-739253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15573B0C3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1858816C53A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD102D373A;
	Mon, 21 Jul 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b="YUdfjk5G"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA182BEFEC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100034; cv=none; b=vDetZxcdV97lTyq3hC8jIArjgjCXCWPV0teTlC2AIcsWYtzGqE3BaiL2j+867xJ1aS6GU+1hQfrlLes0RWXfnYuuEa+dV4T53vggm1PcIpgK9+dhqKdvl2+/hQMJuhFSIVy1BCIPrDshhxCmg+ZHaVh3SWZnr9lmXx4R5EmENp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100034; c=relaxed/simple;
	bh=X9R/UNmMK6vNL/QjPSaxpG+Bnzl79kA+Ao/iqxaeoIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foR65EMMIj6EYJ2fyw9vHUAbQSbDIKCzM3RRZOmQbH2j6JdwLcWDyV5WQldkoWOW0gkYNUHTQmKuUceE6/cDRuGd6RNt1nwInaAbbo5gf8Aq+tp4BqttPKp89OfRKHfoBdSAUKbMvUf3hmE3gYfl4+IFzuefNMsnlPrE+S/3BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com; spf=fail smtp.mailfrom=bluespec.com; dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b=YUdfjk5G; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bluespec.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e278d8345aso415779485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20230601.gappssmtp.com; s=20230601; t=1753100031; x=1753704831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hypDpQARvVvKtBpFWgi9odwWzFEdtItD8EptB9ZSvjY=;
        b=YUdfjk5GSxg0jGC9bfCLbQbewJmGr7X6jkH2fhmfLZ35meKqg1Uzclv7uqX5VCu8/a
         ZUEf7TdjszSwMAXS7QnzyMZtaHuvlIKs/4kyy/u1PAi39dl5Jz0z+qHt4l2/Yhj0ZR+P
         p216dTTn6hIL3q36QhgvBFZO0SOmCpIunX8udYqUxa+SnAmxp4WbuT0bnO0MYcqhKfHo
         lE4zRFoqHkAVXubONAdSZlNbluW0h+xD4bhGHGrh5BBa5c37X+CxoVv8/MOTVUOh2wMg
         ajVsU9GcJGEWKAO/l0XqmMdsCSKXG4hbP2EqqEtEaAjfWpKgy3b8pBD4pdkoN+s5LjL8
         eLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753100031; x=1753704831;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hypDpQARvVvKtBpFWgi9odwWzFEdtItD8EptB9ZSvjY=;
        b=XcsWZBnGYsjheSsTQJDnyUVIcm413hoRgfYfIPK5sf6BZbeVvnzPJ2s+nyl+qbrp6S
         ewRfuHwPO7AZAnPZFxeTsXj3f4NIKNOYApzInRN7dq3ZK6XHPn2XxTz2lsRUiGZoOlTi
         ebCy+oOhgN4USsV0sUCkqRR1IUl5CAo6tooBdFe/X4c4YwmS7Dhp0AfQ/aSyLFNhcEYH
         OUOHMIXixHnAxwU4EICNoKqtuH4eKJYs3FIdfOj8MtbPdDVCWIvs+Bgn3OSsOG302Uvd
         Wa73ax879mVJAkNnWjjjSB7y5ScMLQ9YTvODW7jTT0mZrCuijBPoqKT4+Y76/OqQGj7G
         +zXg==
X-Forwarded-Encrypted: i=1; AJvYcCWxCmj7v/obFxN8pX/aUQO13hGrbkjjDDOR/6dc3lOPtue/dDQaivf9x1FTsDJYhtc0I40zXv9A9PIro/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBgkeouIfNcousC3ugGTYVVtpmeJV5E7mY4QwRZW9uQ4JuXt4
	RNEMRmo1NjjfE8kR9/hvhteN9btdOrIPAC5oyeNyzAWTB6EUs+ByYogAkfV3Ix47
X-Gm-Gg: ASbGncsWf/JPkVwxWUh0GxAZF77cs0KuDMkKcOI3M/ZAQvbSp121oL6xlfkPbfMeDtv
	V0426Bq2QAwQ804ABg2kbDH3QRIGMzaP5eE4ulv9La8wbDv/ai5iw5yvfO1+Hw0meJvxzJi4VYc
	bE4JXRBkU8gW/5XzTbXiRYor/zzFiX7nl3+OkguV8bVmy+dTHaPYSSZgfq7l2nh0SMtg4U8zcCH
	sS0k0TyQkIFubFvwumtnsQbBzo7Q7cX5IA+U6JSC8T+tZMybWl8lPcEanUs7o4lmHIpYX0cUPwH
	PfDMg8R7QE1ei5jBLOCjzcdBYGabzGjA4iWfp8d1nKNohTZxgsKNAEoDFM6rQ3+30+PuNqOIy2e
	lbS176mwEUprIgJUOQ6Iu+xhuKLDrjgM=
X-Google-Smtp-Source: AGHT+IHp24iuvVBqyc5MF9K9vhTLFKl/PRULp6clUv25e6wBKwFRcFYT3yg8TpvCYvSSBwyJ/XQdcw==
X-Received: by 2002:a05:620a:2b8b:b0:7e3:51f5:b4d with SMTP id af79cd13be357-7e351f50ba8mr1759891885a.32.1753100030714;
        Mon, 21 Jul 2025 05:13:50 -0700 (PDT)
Received: from localhost.localdomain ([37.19.220.47])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c6403csm418579985a.82.2025.07.21.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:13:50 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:13:48 -0400
From: Darius Rad <darius@bluespec.com>
To: Drew Fustini <fustini@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aH4u_OHqZHZtXjn3@localhost.localdomain>
Mail-Followup-To: Drew Fustini <fustini@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250719033912.1313955-1-fustini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250719033912.1313955-1-fustini@kernel.org>

On Fri, Jul 18, 2025 at 08:39:13PM -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
> 
> Clobbering the vector registers can significantly increase system call
> latency for some implementations. To mitigate this performance impact, a
> policy mechanism is provided to administrators, distro maintainers, and
> developers to control vector state discard in the form of a sysctl knob:
> 
> /proc/sys/abi/riscv_v_vstate_discard
> 
> Valid values are:
> 
> 0: Do not discard vector state during syscall
> 1: Discard vector state during syscall
> 

Is the intention for this this mean "don't guarantee vector state is
clobbered" or "preserve vector state"?  I suspect it is the former, but the
wording seems unclear.  Additionally, if that's indeed the case, maybe the
documentation should more clearly articulate the tradeoff (performance vs.
security/robustness).

> The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> 
> Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  Documentation/arch/riscv/vector.rst | 15 +++++++++++++++
>  arch/riscv/Kconfig                  | 10 ++++++++++
>  arch/riscv/include/asm/vector.h     |  4 ++++
>  arch/riscv/kernel/vector.c          | 16 +++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
> 
> I've tested the impact of riscv_v_vstate_discard() on the SiFive X280
> cores [1] in the Tenstorrent Blackhole SoC [2]. The results from the
> Blackhole P100 [3] card show that discarding the vector registers
> increases null syscall latency by 25%.
> 
> The null syscall program [4] executes vsetvli and then calls getppid()
> in a loop. The average duration of getppid() is 198 ns when registers
> are clobbered in riscv_v_vstate_discard(). The average duration drops
> to 149 ns when riscv_v_vstate_discard() skips clobbering the registers
> as result of riscv_v_vstate_discard being set to 0.
> 
> $ sudo sysctl abi.riscv_v_vstate_discard=1
> abi.riscv_v_vstate_discard = 1
> 
> $ ./null_syscall --vsetvli
> vsetvli complete
>  iterations: 1000000000
>    duration: 198 seconds
> avg latency: 198.73 ns
> 
> $ sudo sysctl abi.riscv_v_vstate_discard=0
> abi.riscv_v_vstate_discard = 0
> 
> $ ./null_syscall --vsetvli
> vsetvli complete
>  iterations: 1000000000
>    duration: 149 seconds
> avg latency: 149.89 ns
> 
> I'm testing on the tt-blackhole-v6.16-rc1_vstate_discard [5] branch that
> has 13 patches, including this one, on top of v6.16-rc1. Most are simple
> yaml patches for dt bindings along with dts files and a bespoke network
> driver. I don't think the other patches are relevant to this discussion.
> 
> This patch applies clean on its own to riscv/for-next and next-20250718.
> 
> [1] https://www.sifive.com/cores/intelligence-x200-series
> [2] https://tenstorrent.com/en/hardware/blackhole
> [3] https://github.com/tenstorrent/tt-bh-linux
> [4] https://gist.github.com/tt-fustini/ab9b217756912ce75522b3cce11d0d58
> [5] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1_vstate_discard
> 
> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
> index 3987f5f76a9d..1edbce436015 100644
> --- a/Documentation/arch/riscv/vector.rst
> +++ b/Documentation/arch/riscv/vector.rst
> @@ -137,4 +137,19 @@ processes in form of sysctl knob:
>  As indicated by version 1.0 of the V extension [1], vector registers are
>  clobbered by system calls.
>  
> +Clobbering the vector registers can significantly increase system call latency
> +for some implementations. To mitigate the performance impact, a policy mechanism
> +is provided to the administrators, distro maintainers, and developers to control
> +the vstate discard in the form of a sysctl knob:
> +
> +* /proc/sys/abi/riscv_v_vstate_discard
> +
> +    Valid values are:
> +
> +    * 0: Do not discard vector state during syscall
> +    * 1: Discard vector state during syscall
> +
> +    Reading this file returns the current discard behavior. The initial state is
> +    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> +
>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0aeee50da016..c0039f21d1f0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -655,6 +655,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
>  
>  	  If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_V_VSTATE_DISCARD
> +	bool "Enable Vector state discard by default"
> +	depends on RISCV_ISA_V
> +	default n
> +	help
> +	  Say Y here if you want to enable Vector state discard on syscall.
> +	  Otherwise, userspace has to enable it via the sysctl interface.
> +
> +	  If you don't know what to do here, say N.
> +
>  config RISCV_ISA_V_UCOPY_THRESHOLD
>  	int "Threshold size for vectorized user copies"
>  	depends on RISCV_ISA_V
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> index 45c9b426fcc5..77991013216b 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -40,6 +40,7 @@
>  	_res;								\
>  })
>  
> +extern bool riscv_v_vstate_discard_ctl;
>  extern unsigned long riscv_v_vsize;
>  int riscv_v_setup_vsize(void);
>  bool insn_is_vector(u32 insn_buf);
> @@ -270,6 +271,9 @@ static inline void __riscv_v_vstate_discard(void)
>  {
>  	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
>  
> +	if (READ_ONCE(riscv_v_vstate_discard_ctl) == 0)
> +		return;
> +
>  	riscv_v_enable();
>  	if (has_xtheadvector())
>  		asm volatile (THEAD_VSETVLI_T4X0E8M8D1 : : : "t4");
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 184f780c932d..7a4c209ad337 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -26,6 +26,7 @@ static struct kmem_cache *riscv_v_user_cachep;
>  static struct kmem_cache *riscv_v_kernel_cachep;
>  #endif
>  
> +bool riscv_v_vstate_discard_ctl = IS_ENABLED(CONFIG_RISCV_ISA_V_VSTATE_DISCARD);
>  unsigned long riscv_v_vsize __read_mostly;
>  EXPORT_SYMBOL_GPL(riscv_v_vsize);
>  
> @@ -307,11 +308,24 @@ static const struct ctl_table riscv_v_default_vstate_table[] = {
>  	},
>  };
>  
> +static const struct ctl_table riscv_v_vstate_discard_table[] = {
> +	{
> +		.procname       = "riscv_v_vstate_discard",
> +		.data           = &riscv_v_vstate_discard_ctl,
> +		.maxlen         = sizeof(riscv_v_vstate_discard_ctl),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dobool,
> +	},
> +};
> +
>  static int __init riscv_v_sysctl_init(void)
>  {
> -	if (has_vector() || has_xtheadvector())
> +	if (has_vector() || has_xtheadvector()) {
>  		if (!register_sysctl("abi", riscv_v_default_vstate_table))
>  			return -EINVAL;
> +		if (!register_sysctl("abi", riscv_v_vstate_discard_table))
> +			return -EINVAL;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linu

