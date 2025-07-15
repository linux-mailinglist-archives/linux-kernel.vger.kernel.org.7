Return-Path: <linux-kernel+bounces-731809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE25B059D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7463ADC55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F52E2F06;
	Tue, 15 Jul 2025 12:18:04 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41F2DE71D;
	Tue, 15 Jul 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581884; cv=none; b=obZujcIrdLxLOOgwB1wSbcOn4QG/UOXbpK8notgd9G6lVs2iRT/77OC036o6buyQ7xYbStDlEtyTMzH099eHPkl/xiwaxox8u6iinWQp6Ok+g40hwSTWDXJTHBdsSRuDv3KV3o+KwFKqWiUvGLQo27UZt9OCGIkaj/CuofPMvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581884; c=relaxed/simple;
	bh=UCd2gWAmQMHdstUbA+U+6Ic4LMzG5S/gIseyIKIAjhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwbK3hNQZE43MPjST9VDhWQ+/SqRzRz8h+kYRO2F3lwxHP4pNWOV6ZnT5buwhZfCnuI9XfRFTU5vPBenmLufD3/40TNojje7c+dpQsQCPOSZf6fSBe2xpI3DaLw2c56lOxU4bKiuIueMlhzqnFyL3bqvdHuauw5UY41QDV6wgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB9A743967;
	Tue, 15 Jul 2025 12:17:55 +0000 (UTC)
Message-ID: <a2976179-c279-48bf-9fdd-24844ba7d562@ghiti.fr>
Date: Tue, 15 Jul 2025 14:17:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE
 selection
To: ChenMiao <chenmiao.ku@gmail.com>,
 Linux RISCV <linux-riscv@lists.infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Heiko Carstens <hca@linux.ibm.com>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250706151830.25091-1-chenmiao.ku@gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250706151830.25091-1-chenmiao.ku@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepveeklefhuddtvdehudevffeflefgleehgeehieeuveevueffhefgffdvfeeujedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhmtghouhhnthdrshgsnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudeljehfmedufeehtgemjegurghfmegsfhgujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudeljehfmedufeehtgemjegurghfmegsfhgujedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudeljehfmedufeehtgemjegurghfmegsfhgujegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheptghhvghnmhhirghordhkuhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhst
 ghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomh

On 7/6/25 17:18, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
>
> V1: The first version mainly involves modifications to the
> configuration of the dynamic ftracer.
>
> Link https://lore.kernel.org/all/f7e12c6d-892e-4ca3-9ef0-fbb524d04a48@ghiti.fr/
>
> V2: After a series of discussions, Steven concluded that only
> supporting the dynamic ftracer would suffice. Alex also pointed
> out that if only the dynamic ftracer needs to be supported, the
> code related to the static ftracer would become obsolete and
> turn into dead code. He had already done some preliminary work on this.
>
> Based on this, the modifications to the configuration were made,
> and the dead code generated by the ftracer
> (originally related to the static ftracer) was also removed.
>
> Link https://lore.kernel.org/all/20250703115222.2d7c8cd5@batman.local.home/
> Link https://github.com/linux-riscv/linux/pull/556/commits/0481092a5bec3818658981c11f629e06e66382b3
>
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
>   arch/riscv/Kconfig              |  3 +-
>   arch/riscv/include/asm/ftrace.h |  3 --
>   arch/riscv/kernel/ftrace.c      | 11 +-----
>   arch/riscv/kernel/mcount.S      | 64 ---------------------------------
>   kernel/trace/Kconfig            |  2 +-
>   5 files changed, 4 insertions(+), 79 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 36061f4732b7..95d24b19c466 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -97,8 +97,9 @@ config RISCV
>   	select CLONE_BACKWARDS
>   	select COMMON_CLK
>   	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
> +	select DYNAMIC_FTRACE if FUNCTION_TRACER
>   	select EDAC_SUPPORT
> -	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
> +	select FRAME_POINTER if PERF_EVENTS
>   	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
>   	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
>   	select GENERIC_ARCH_TOPOLOGY
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 22ebea3c2b26..77ddb6dce0a8 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -49,7 +49,6 @@ struct dyn_arch_ftrace {
>   };
>   #endif
>   
> -#ifdef CONFIG_DYNAMIC_FTRACE
>   /*
>    * A general call in RISC-V is a pair of insts:
>    * 1) auipc: setting high-20 pc-related bits to ra register
> @@ -237,6 +236,4 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsi
>   
>   #endif /* __ASSEMBLY__ */
>   
> -#endif /* CONFIG_DYNAMIC_FTRACE */
> -
>   #endif /* _ASM_RISCV_FTRACE_H */
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4c6c24380cfd..93bad646d233 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -13,7 +13,6 @@
>   #include <asm/cacheflush.h>
>   #include <asm/text-patching.h>
>   
> -#ifdef CONFIG_DYNAMIC_FTRACE
>   unsigned long ftrace_call_adjust(unsigned long addr)
>   {
>   	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -191,13 +190,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>   	return 0;
>   }
>   
> -#else /* CONFIG_DYNAMIC_FTRACE */
> -unsigned long ftrace_call_adjust(unsigned long addr)
> -{
> -	return addr;
> -}
> -#endif /* CONFIG_DYNAMIC_FTRACE */
> -
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>   		       unsigned long addr)
> @@ -236,7 +228,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>   		*parent = return_hooker;
>   }
>   
> -#ifdef CONFIG_DYNAMIC_FTRACE
>   void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>   		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>   {
> @@ -257,5 +248,5 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>   	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
>   		*parent = return_hooker;
>   }
> -#endif /* CONFIG_DYNAMIC_FTRACE */
> +
>   #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
> index da4a4000e57e..bb550c15f1c9 100644
> --- a/arch/riscv/kernel/mcount.S
> +++ b/arch/riscv/kernel/mcount.S
> @@ -14,13 +14,6 @@
>   
>   	.text
>   
> -	.macro SAVE_ABI_STATE
> -	addi	sp, sp, -16
> -	REG_S	s0, 0*SZREG(sp)
> -	REG_S	ra, 1*SZREG(sp)
> -	addi	s0, sp, 16
> -	.endm
> -
>   	/*
>   	 * The call to ftrace_return_to_handler would overwrite the return
>   	 * register if a0 was not saved.
> @@ -34,12 +27,6 @@
>   	addi	s0, sp, FREGS_SIZE_ON_STACK
>   	.endm
>   
> -	.macro RESTORE_ABI_STATE
> -	REG_L	ra, 1*SZREG(sp)
> -	REG_L	s0, 0*SZREG(sp)
> -	addi	sp, sp, 16
> -	.endm
> -
>   	.macro RESTORE_RET_ABI_STATE
>   	REG_L	ra, FREGS_RA(sp)
>   	REG_L	s0, FREGS_S0(sp)
> @@ -49,10 +36,8 @@
>   	.endm
>   
>   SYM_TYPED_FUNC_START(ftrace_stub)
> -#ifdef CONFIG_DYNAMIC_FTRACE
>          .global _mcount
>          .set    _mcount, ftrace_stub
> -#endif
>   	ret
>   SYM_FUNC_END(ftrace_stub)
>   
> @@ -79,53 +64,4 @@ SYM_FUNC_START(return_to_handler)
>   SYM_FUNC_END(return_to_handler)
>   #endif
>   
> -#ifndef CONFIG_DYNAMIC_FTRACE
> -SYM_FUNC_START(_mcount)
> -	la	t4, ftrace_stub
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -	la	t0, ftrace_graph_return
> -	REG_L	t1, 0(t0)
> -	bne	t1, t4, .Ldo_ftrace_graph_caller
> -
> -	la	t3, ftrace_graph_entry
> -	REG_L	t2, 0(t3)
> -	la	t6, ftrace_graph_entry_stub
> -	bne	t2, t6, .Ldo_ftrace_graph_caller
> -#endif
> -	la	t3, ftrace_trace_function
> -	REG_L	t5, 0(t3)
> -	bne	t5, t4, .Ldo_trace
> -	ret
> -
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -/*
> - * A pseudo representation for the function graph tracer:
> - * prepare_to_return(&ra_to_caller_of_caller, ra_to_caller)
> - */
> -.Ldo_ftrace_graph_caller:
> -	addi	a0, s0, -SZREG
> -	mv	a1, ra
> -#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> -	REG_L	a2, -2*SZREG(s0)
> -#endif
> -	SAVE_ABI_STATE
> -	call	prepare_ftrace_return
> -	RESTORE_ABI_STATE
> -	ret
> -#endif
> -
> -/*
> - * A pseudo representation for the function tracer:
> - * (*ftrace_trace_function)(ra_to_caller, ra_to_caller_of_caller)
> - */
> -.Ldo_trace:
> -	REG_L	a1, -SZREG(s0)
> -	mv	a0, ra
> -
> -	SAVE_ABI_STATE
> -	jalr	t5
> -	RESTORE_ABI_STATE
> -	ret
> -SYM_FUNC_END(_mcount)
> -#endif
>   EXPORT_SYMBOL(_mcount)
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a3f35c7d83b6..28afc6941e7a 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -275,7 +275,7 @@ config FUNCTION_TRACE_ARGS
>   	  funcgraph-args (for the function graph tracer)
>   
>   config DYNAMIC_FTRACE
> -	bool "enable/disable function tracing dynamically"
> +	bool
>   	depends on FUNCTION_TRACER
>   	depends on HAVE_DYNAMIC_FTRACE
>   	default y
>
> base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026


I have just given it a try but I'm getting the following errors:

../arch/riscv/kernel/ftrace.c: In function 'arch_ftrace_update_code':
../arch/riscv/kernel/ftrace.c:44:9: error: implicit declaration of 
function 'ftrace_modify_all_code' [-Werror=implicit-function-declaration]
    44 |         ftrace_modify_all_code(command);
       |         ^~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/kernel/ftrace.c: At top level:
../arch/riscv/kernel/ftrace.c:116:5: warning: no previous prototype for 
'ftrace_make_call' [-Wmissing-prototypes]
   116 | int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
       |     ^~~~~~~~~~~~~~~~
../arch/riscv/kernel/ftrace.c: In function 'ftrace_make_call':
../arch/riscv/kernel/ftrace.c:118:52: error: invalid use of undefined 
type 'struct dyn_ftrace'
   118 |         unsigned long distance, orig_addr, pc = rec->ip - 
MCOUNT_AUIPC_SIZE;
       |                                                    ^~
../arch/riscv/kernel/ftrace.c:125:37: error: 'ftrace_caller' undeclared 
(first use in this function); did you mean 'ftrace_kill'?
   125 |         orig_addr = (unsigned long)&ftrace_caller;
       |                                     ^~~~~~~~~~~~~
       |                                     ftrace_kill
../arch/riscv/kernel/ftrace.c:125:37: note: each undeclared identifier 
is reported only once for each function it appears in
../arch/riscv/kernel/ftrace.c:128:24: error: 'FTRACE_ADDR' undeclared 
(first use in this function)
   128 |                 addr = FTRACE_ADDR;
       |                        ^~~~~~~~~~~
../arch/riscv/kernel/ftrace.c: At top level:
../arch/riscv/kernel/ftrace.c:133:5: warning: no previous prototype for 
'ftrace_make_nop' [-Wmissing-prototypes]
   133 | int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, 
unsigned long addr)
       |     ^~~~~~~~~~~~~~~
../arch/riscv/kernel/ftrace.c: In function 'ftrace_make_nop':
../arch/riscv/kernel/ftrace.c:142:41: error: invalid use of undefined 
type 'struct dyn_ftrace'
   142 |         if (patch_insn_write((void *)rec->ip, &nop4, 
MCOUNT_NOP4_SIZE))
       |                                         ^~
../arch/riscv/kernel/ftrace.c: In function 'ftrace_init_nop':
../arch/riscv/kernel/ftrace.c:157:31: error: invalid use of undefined 
type 'struct dyn_ftrace'
   157 |         unsigned long pc = rec->ip - MCOUNT_AUIPC_SIZE;
       |                               ^~
   CC      drivers/nvme/target/io-cmd-bdev.o
../arch/riscv/kernel/ftrace.c:167:35: error: 'ftrace_caller' undeclared 
(first use in this function); did you mean 'ftrace_kill'?
   167 |         offset = (unsigned long) &ftrace_caller - pc;
       |                                   ^~~~~~~~~~~~~
       |                                   ftrace_kill
../arch/riscv/kernel/ftrace.c: At top level:
../arch/riscv/kernel/ftrace.c:177:5: warning: no previous prototype for 
'ftrace_update_ftrace_func' [-Wmissing-prototypes]
   177 | int ftrace_update_ftrace_func(ftrace_func_t func)


