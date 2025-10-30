Return-Path: <linux-kernel+bounces-877807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488FC1F13E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 488E54E9F03
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B2311957;
	Thu, 30 Oct 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="btc86mXT"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716562E092D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814013; cv=none; b=NefrJGZb6wOpjOn1ThRxb2Rzapw2g+MuqkPcYPfQkoUh2Ix0McUUlDO6YT+K1Ky3VY21qTA2XMmFOYUsnzYU0+7bueCaLn6RPT4LHRmRSnf6COdUOIU7o1lF8hvQbmlr1WcNAgxpJmMAHOfz1y6+jjnYfa39BPhQa9K4yl19CYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814013; c=relaxed/simple;
	bh=vjLdCNlaJAv8F+u21kOBC8dOCjMucS/4uY9btI/ZyGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hF07gd3LXEmvzxp5lpAUITauzCsCEECz1mQmoBGlLreiNVtLORqkOiy46BcQ0FZQ2FSuofcHg32gAuwIC9AW/JTVKxZCV1gnXwswCs082g9wnX+UjeLFF3lQ1uFVDOC++oHcPn9iRMwkX0H5Gm1eOZmYyRTHcTF7vCbD60qLqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=btc86mXT; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9c2021a-fa7f-4b01-9b48-afe5fa73135f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761814007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts8r14E983Oj7YJR45lgRteJfrOnqFoS1A/vTyH0UoY=;
	b=btc86mXT8yRgDvLIH42JPCXR2Rr3nleh9BvTKXgCEXn70QTw0Ku+Ixlyj+Cs7I3GbhVomY
	8htPfQqzMpamGyA7XQOi/EbQDnBw3pxmBDWQN0KZ6emQTsR/OaNJ97p1Biq3PfpzMd66uz
	hoWrQlgogjMrUtz5L82iYBNSPTf8keM=
Date: Thu, 30 Oct 2025 01:46:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] riscv: crash: use NMI to stop the CPU
To: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, conor@kernel.org,
 luxu.kernel@bytedance.com, cleger@rivosinc.com, ajones@ventanamicro.com,
 apatel@ventanamicro.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, songshuaishuai@tinylab.org,
 bjorn@rivosinc.com, charlie@rivosinc.com, masahiroy@kernel.org,
 valentina.fernandezalanis@microchip.com, jassisinghbrar@gmail.com,
 conor.dooley@microchip.com
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
 <20251027133431.15321-4-cuiyunhui@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
Content-Language: en-US
In-Reply-To: <20251027133431.15321-4-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/27/25 6:34 AM, Yunhui Cui wrote:
> NMI is more robust than IPI for stopping CPUs during crashes,
> especially with interrupts disabled. Add SBI_SSE_EVENT_LOCAL_CRASH_NMI
> eventid to implement NMI for stopping CPUs.
> 

Resending it again as my previous response was rejected due to 
gmail/html issue.

This should be used as the last resort instead of the preferred approach 
for below reasons.

1. Invoking SSE on this path may lead to some race conditions if 
interruption is enabled.
2. With AIA IPI will be faster than SSE if interrupt is enabled.

Can we do a hybrid approach where we use CRASH_NMI (or SOFTWARE_INJECTED 
event) only when IPI fails.
Looking at other architecture implementations, it already does something 
similar.

> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/include/asm/crash.h   |  1 +
>   arch/riscv/include/asm/sbi.h     |  1 +
>   arch/riscv/kernel/crash.c        | 31 +++++++++++++-
>   drivers/firmware/riscv/sse_nmi.c | 71 +++++++++++++++++++++++++++++++-
>   include/linux/sse_nmi.h          |  8 ++++
>   5 files changed, 109 insertions(+), 3 deletions(-)
>   create mode 100644 include/linux/sse_nmi.h
> 
> diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
> index b64df919277d4..5076f297cbc15 100644
> --- a/arch/riscv/include/asm/crash.h
> +++ b/arch/riscv/include/asm/crash.h
> @@ -5,6 +5,7 @@
>   
>   #ifdef CONFIG_KEXEC_CORE
>   void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
> +void cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
>   #else
>   static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>   {
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 52d3fdf2d4cc1..65cce85237879 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -487,6 +487,7 @@ enum sbi_sse_attr_id {
>   #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
>   #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
>   #define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI		0xffff0001
> +#define SBI_SSE_EVENT_LOCAL_CRASH_NMI		0xffff0002
>   #define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED	0xffff8000
>   
>   #define SBI_SSE_EVENT_PLATFORM		BIT(14)
> diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
> index 12598bbc2df04..9f3f0becfdd95 100644
> --- a/arch/riscv/kernel/crash.c
> +++ b/arch/riscv/kernel/crash.c
> @@ -3,14 +3,16 @@
>   #include <linux/cpu.h>
>   #include <linux/delay.h>
>   #include <linux/kexec.h>
> +#include <linux/sse_nmi.h>
>   #include <linux/smp.h>
>   #include <linux/sched.h>
>   
> +#include <asm/crash.h>
>   #include <asm/cpu_ops.h>
>   
>   static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
>   
> -inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> +void cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>   {
>   	crash_save_cpu(regs, cpu);
>   
> @@ -27,6 +29,11 @@ inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>   		wait_for_interrupt();
>   }
>   
> +inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> +{
> +	cpu_crash_stop(cpu, regs);
> +}
> +
>   /*
>    * The number of CPUs online, not counting this CPU (which may not be
>    * fully online and so not counted in num_online_cpus()).
> @@ -38,6 +45,24 @@ static inline unsigned int num_other_online_cpus(void)
>   	return num_online_cpus() - this_cpu_online;
>   }
>   
> +#ifdef CONFIG_RISCV_SSE_NMI
> +static int send_nmi_stop_cpu(cpumask_t *mask)
> +{
> +	unsigned int cpu;
> +	int ret = 0;
> +
> +	for_each_cpu(cpu, mask)
> +		ret += carsh_nmi_stop_cpu(cpu);
> +
> +	return ret;
> +}
> +#else
> +static inline int send_nmi_stop_cpu(cpumask_t *mask)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>   void crash_smp_send_stop(void)
>   {
>   	static int cpus_stopped;
> @@ -66,7 +91,9 @@ void crash_smp_send_stop(void)
>   	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
>   
>   	pr_crit("SMP: stopping secondary CPUs\n");
> -	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
> +
> +	if (send_nmi_stop_cpu(&mask))
> +		send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
>   
>   	/* Wait up to one second for other CPUs to stop */
>   	timeout = USEC_PER_SEC;
> diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/sse_nmi.c
> index 2c1eaea2bbabc..152d787075345 100644
> --- a/drivers/firmware/riscv/sse_nmi.c
> +++ b/drivers/firmware/riscv/sse_nmi.c
> @@ -4,13 +4,16 @@
>   
>   #include <linux/nmi.h>
>   #include <linux/riscv_sbi_sse.h>
> +#include <linux/sse_nmi.h>
>   #include <linux/sysctl.h>
>   
> +#include <asm/crash.h>
>   #include <asm/irq_regs.h>
>   #include <asm/sbi.h>
>   
>   int unknown_nmi_panic;
>   static struct sse_event *unknown_nmi_evt;
> +static struct sse_event *crash_nmi_evt;
>   static struct ctl_table_header *unknown_nmi_sysctl_header;
>   
>   static int __init setup_unknown_nmi_panic(char *str)
> @@ -32,6 +35,12 @@ const struct ctl_table unknown_nmi_table[] = {
>   	},
>   };
>   
> +static inline struct sbiret sbi_sse_ecall(int fid, unsigned long arg0,
> +					  unsigned long arg1)
> +{
> +	return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, 0, 0, 0, 0);
> +}
> +
>   static int unknown_nmi_handler(u32 evt, void *arg, struct pt_regs *regs)
>   {
>   	pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_id());
> @@ -73,9 +82,69 @@ static int unknown_nmi_init(void)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_KEXEC_CORE
> +int carsh_nmi_stop_cpu(unsigned int cpu)
> +{
> +	unsigned int hart_id = cpuid_to_hartid_map(cpu);
> +	u32 evt = SBI_SSE_EVENT_LOCAL_CRASH_NMI;
> +	struct sbiret ret;
> +
> +	ret = sbi_sse_ecall(SBI_SSE_EVENT_INJECT, evt, hart_id);
> +	if (ret.error) {
> +		pr_err("Failed to signal event %x, error %ld\n", evt, ret.error);
> +		return sbi_err_map_linux_errno(ret.error);
> +	}
> +
> +	return 0;
> +}
> +
> +static int crash_nmi_handler(u32 evt, void *arg, struct pt_regs *regs)
> +{
> +	cpu_crash_stop(smp_processor_id(), regs);
> +
> +	return 0;
> +}
> +
> +static int crash_nmi_init(void)
> +{
> +	int ret;
> +
> +	crash_nmi_evt = sse_event_register(SBI_SSE_EVENT_LOCAL_CRASH_NMI, 0,
> +				 crash_nmi_handler, NULL);
> +	if (IS_ERR(crash_nmi_evt))
> +		return PTR_ERR(crash_nmi_evt);
> +
> +	ret = sse_event_enable(crash_nmi_evt);
> +	if (ret) {
> +		sse_event_unregister(crash_nmi_evt);
> +		return ret;
> +	}
> +
> +	pr_info("Using SSE for crash NMI event delivery\n");
> +
> +	return 0;
> +}
> +#endif
> +
>   static int __init sse_nmi_init(void)
>   {
> -	return unknown_nmi_init();
> +	int ret;
> +
> +	ret = unknown_nmi_init();
> +	if (ret) {
> +		pr_err("Unknown_nmi_init failed with error %d\n", ret);
> +		return ret;
> +	}
> +
> +#ifdef CONFIG_KEXEC_CORE
> +	ret = crash_nmi_init();
> +	if (ret) {
> +		pr_err("Crash_nmi_init failed with error %d\n", ret);
> +		return ret;
> +	}
> +#endif
> +
> +	return 0;
>   }
>   
>   late_initcall(sse_nmi_init);
> diff --git a/include/linux/sse_nmi.h b/include/linux/sse_nmi.h
> new file mode 100644
> index 0000000000000..548a348ac0a46
> --- /dev/null
> +++ b/include/linux/sse_nmi.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_RISCV_SSE_NMI_H
> +#define __LINUX_RISCV_SSE_NMI_H
> +
> +int carsh_nmi_stop_cpu(unsigned int cpu);
> +
> +#endif


