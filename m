Return-Path: <linux-kernel+bounces-776780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A664B2D16E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0211C25C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8991482F2;
	Wed, 20 Aug 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="iCDfySv9"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761093D76
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653539; cv=none; b=VjG4pl8cUhxPuk15AsGOabS4wt5EzEe+3U2vfBcRqz2Wss7h8Skco0P7sXnzeBZQe4A1LoEyIjob3y+bqsHlUdIjvQrWCQhvflQpq7ST8LYFV0jW8lDjteh4A8ArIj24anGQ8LUC3VbMzWBUoPUl866ch4xoE0KcoGttvJStMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653539; c=relaxed/simple;
	bh=zsYbIwSLhjEbPkZcJrtIGMF9sDg+qkbytHqQqqjqktM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un9nkJCXIyZQS4JgkpuPIc9ubjoVAY98AVahlifdgplJpBRMLC67+s2YQy6RoobbICxsidYi6YLWz9KP7ys41132e/8syrt9b9oo4R8rOGMYtNVsldd1/kbAEANS3Q0rIlHEPMYgRD/pCWEs0BAz/fK25KMBbgSI8keCrT40AxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=iCDfySv9; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755653492;
	bh=rS4WsZVk4BCyE0nXY7ZBQdE3RLBRdyUulsrOQIeNKts=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=iCDfySv9E2TNV35x0mgAAwVv+qAEuGpOKll40oZ26uXY0rqt4jTS3pVCxtBtg0mAg
	 spVq+XC3LB/QOOPispOEYKslnemCZUWDFy9LUASWJzv5DsWPOBxJ3QwWKQgbTRjlHP
	 JHmsFOeyJuqfNaWyy53wDOD5THmWxJvCuq+Xb18A=
X-QQ-mid: zesmtpsz5t1755653486t11fbf78b
X-QQ-Originating-IP: w6OMFnHZ/Bt7Y45CN2LgpTqzON3eHq+vWyy7C8Hlcuo=
Received: from = ( [120.239.196.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 09:31:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4849368715872619627
EX-QQ-RecipientCnt: 15
Date: Wed, 20 Aug 2025 09:31:24 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Drew Fustini <fustini@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Darius Rad <darius@bluespec.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Florian Weimer <fweimer@redhat.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3] riscv: Add sysctl to control discard of vstate on
 syscall entry
Message-ID: <9D2DE979F179BFC6+aKUlbEZa2vvgmGdQ@LT-Guozexi>
References: <20250819-riscv_v_vstate_discard-v3-1-0af577dafdc2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-riscv_v_vstate_discard-v3-1-0af577dafdc2@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NnpBY4370xRXIi6nbfEAP49DuoOfQwxnToavodgQ/GbcIBE8dP1lu7RP
	wmM9PRrERWqCrNWsrfC32bl93fXUaS4XpT3herMbZLpt6+uK51Zz1EPTvUwARRet+tgHzCw
	/Ugw83J+oSoZ09z+aZz6GgrJSW52Un467Vwuvt1ezsSAxcvaZVxD1ilxUY1tUFBEjt8nt+S
	TL0FSYH3WT2/ETf0ZXZ86Dc+ctU/7xIUGdM89+HsoQjLZKJQLNeUxcM2b4Pfr3aE0dzFrXJ
	7gy1aSzXnNw08f/YUxvyUUl29OCfO+aW45vS0byEtLVeL3CDICv//N8GerBzLAQK8wQC2Ba
	xZuvwH/oiYg/uHQ12ZBH2uR03Vbe4I3tGe7kO62/ecuFgz0xbBblhtA9Ggf1+2hVLfGs04k
	gpUrwE001s2CHpNuZzFWYkZT5hrAB8z47bzcVrC8p+kpzSi7u9GfruFpgzlElkojGhXKCP8
	d/aeZ5s7FOOyuNxBhRbuz/y/8nGMvStoEEgAHGX9ya5cIvzz3lQKDxtgG3CgecgLfuTKNTF
	A/x1fFBmfbPeo8w/GruHJE23cXksfvw8khc5njo6m60bC+PN7zKMbwLaATuOkb5VcDy1Dfh
	6aEL6QWH9TOncG3eo9tFj4tqIQrW+wGrd0qC+AVpPUiRBphvErVScdM0nSwr4vCM89oGWU8
	2wPx5wkpzZ9yYaG+i3HQEa1Z3Tfd0f4Et4xVavPKRPOagipKYLf4tZigG135Ld2I3I4SR4Y
	HTGvmchvrBQX+MxjQXMcjhIITny2GA+kVJ+8B345Y5HcrxKlq4Wow4aSeGgNV+1sTc2CBFL
	w80xdVx5c+39mNKcQbZst2aTVREKqmlRfwaVp6MnsF5iWxd3vedoRg77thPGfXaDGYucfpp
	y1h1567WtXtDLyxBQzgbxCSgsw1OzcUeONxrNNF8DL4GtYXWnAzDs7rXoMsX5eKEjrkGumb
	Te8+ITvLMbfzCDG3SVPaOPGf37V8ldrkfZSd7Hu6NO/pgSCh/8WR4Jq/RE07GNdH4T0QLOc
	W91H/qveOEwUX+0GycBu3oQuA5z/JXg1H0mi2mKRPQvoAjPvv0kmB4xfHgHIplQjORjpdyZ
	W1N1x3zM1iR
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, Aug 19, 2025 at 02:40:21AM -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
> 
> Vector registers are always clobbered in the syscall entry path to
> enforce the documented ABI that vector state is not preserved across
> syscalls. However, this operation can be slow on some RISC-V cores.
> To mitigate this performance impact, add a sysctl knob to control
> whether vector state is discarded in the syscall entry path:
> 
> /proc/sys/abi/riscv_v_vstate_discard
> 
> Valid values are:
> 
> 0: Vector state is not intentionally clobbered when entering a syscall
> 1: Vector state is always clobbered when entering a syscall
> 
> The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> 
> Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
> Changes in v3:
>  - Reword the Kconfig description to clarify that the sysctl can still
>    be changed during runtime regardless of the initial value chosen
>  - Improve the description of vstate clobbering and the sysctl in
>    section 3 of vector.rst
>  - v2: https://lore.kernel.org/linux-riscv/20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org/
> 
> Changes in v2:
>  - Reword the description of the abi.riscv_v_vstate_discard sysctl to
>    clarify that option '0' does not preserve the vector state - it just
>    means that vector state will not always be clobbered in the syscall
>    path.
>  - Add clarification suggested by Palmer in v1 to the "Vector Register
>    State Across System Calls" documentation section.
>  - v1: https://lore.kernel.org/linux-riscv/20250719033912.1313955-1-fustini@kernel.org/
> 
> Test results:
> I've tested the impact of riscv_v_vstate_discard() on the SiFive X280
> cores [1] in the Tenstorrent Blackhole SoC [2]. The results from the
> Blackhole P100 [3] card show that discarding the vector registers
> increases null syscall latency by 25%.
> 
> The null syscall program [4] executes vsetvli and then calls getppid()
> in a loop. The average duration of getppid() is 198 ns when registers
> are clobbered in riscv_v_vstate_discard(). The average duration drops
> to 149 ns when riscv_v_vstate_discard() skips clobbering the registers
> because riscv_v_vstate_discard is set to 0.
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
> This patch applies clean on its own mainline and riscv/for-next.
> 
> [1] https://www.sifive.com/cores/intelligence-x200-series
> [2] https://tenstorrent.com/en/hardware/blackhole
> [3] https://github.com/tenstorrent/tt-bh-linux
> [4] https://gist.github.com/tt-fustini/ab9b217756912ce75522b3cce11d0d58
> [5] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1_vstate_discard
> 
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
[...]

> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 184f780c932d443d81eecac7a6fb8070ee7a5824..7a4c209ad337efd7a3995cfc7cf1700c03e55b40 100644
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
Is this pair of curly braces strictly necessary?
for potential extensibility?

Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Best regards,
Troy
>  		if (!register_sysctl("abi", riscv_v_default_vstate_table))
>  			return -EINVAL;
> +		if (!register_sysctl("abi", riscv_v_vstate_discard_table))
> +			return -EINVAL;
> +	}
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> change-id: 20250818-riscv_v_vstate_discard-e89b3181e0ac
> 
> Best regards,
> -- 
> Drew Fustini <fustini@kernel.org>
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

