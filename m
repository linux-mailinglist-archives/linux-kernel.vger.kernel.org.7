Return-Path: <linux-kernel+bounces-597260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A258A8373D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 05:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C6F166B72
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA61E5B75;
	Thu, 10 Apr 2025 03:33:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0834C8F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744256018; cv=none; b=YiwYShAkW5HDMEz2DbNhSS91EuxY1wx73lUZ1GOzAvLWsk6S0tbwV4ocQ8qKz4qBZnFmpqYxyKZhnuvIqEP2cfwXlobpd5hvwwdK+H9C/R98JnmNz61Yz3vIACLGVx3tsPiS8b6KUSz6C0M2TwRfNFkuY1bl/1J66AJizMGqvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744256018; c=relaxed/simple;
	bh=SpkAA0obsZVi2oKSMKXMSfr8xIGBd61rtNyNvYbL71U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9sxcJAkx4dqYE4/6T5rvb0s5n9SH68p7Tdewerepbga8A27OiCaN+VHC7eIncVQq8epiRs82dfdVMK6gd72n0H/Szs4F63Bn6mp6/ApptbKLSHyztt2UfaP/PAgjCcK6i8PGJirqVSfp60QOWJgcCDrzI6hV6c9LDgM5IUhKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZY50w6gH7zHrVf;
	Thu, 10 Apr 2025 11:30:08 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A767B1800B4;
	Thu, 10 Apr 2025 11:33:32 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 11:33:31 +0800
Message-ID: <d985d65c-ecff-45f8-9188-2bd4c57502a8@huawei.com>
Date: Thu, 10 Apr 2025 11:33:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm64: kprobe: Enable OPTPROBE for arm64
To: Yeoreum Yun <yeoreum.yun@arm.com>
CC: <yangyicong@huawei.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <fanghao11@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20250216070044.1792872-1-xiaqinxin@huawei.com>
 <Z+59CzngNTKGSuwH@e129823.arm.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <Z+59CzngNTKGSuwH@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/4/3 20:20, Yeoreum Yun 写道:
> Hi,
>
>> This patch introduce optprobe for ARM64. In optprobe, probed
>> instruction is replaced by a branch instruction to trampoline.
>>
>> Performance of optprobe on Hip08 platform is test using kprobe
>> example module to analyze the latency of a kernel function,
>> and here is the result:
>>
>> common kprobe:
>> [280709.846380] do_empty returned 0 and took 1530 ns to execute
>> [280709.852057] do_empty returned 0 and took 550 ns to execute
>> [280709.857631] do_empty returned 0 and took 440 ns to execute
>> [280709.863215] do_empty returned 0 and took 380 ns to execute
>> [280709.868787] do_empty returned 0 and took 360 ns to execute
>> [280709.874362] do_empty returned 0 and took 340 ns to execute
>> [280709.879936] do_empty returned 0 and took 320 ns to execute
>> [280709.885505] do_empty returned 0 and took 300 ns to execute
>> [280709.891075] do_empty returned 0 and took 280 ns to execute
>> [280709.896646] do_empty returned 0 and took 290 ns to execute
>>
>> optprobe:
>> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
>> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
>> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
>> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
>> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
>> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
>> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
>> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
>> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
>> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
>> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
>>
>> As the result shows, optprobe can greatly reduce the latency. Big
>> latency of common kprobe will significantly impact the real result
>> while doing performance analysis or debugging performance issues
>> in lab, so optprobe is useful in this scenario.
>>
>> The trampoline design is illustrated in the following diagram.
>> Some commands will be replaced in arch_prepare_optimized_kprobe.
>> +------------------optprobe_template_entry---------------------+
>> |- Saving stacks and registers                                 |
>> |- Loading params for callback                                 |
>> +------------------optprobe_template_common--------------------+
>> |- nop                                                         |
>> |(replaced to the branch jump to optprobe_common)              |
>> |- Restore stacks and registers                                |
>> +-------------optprobe_template_restore_orig_insn--------------+
>> |- nop                                                         |
>> |(replaced to the kprobe->opcode)                              |
>> +----------------optprobe_template_restore_end-----------------+
>> |- nop                                                         |
>> |(replaced to next address of the probe point)                 |
>> +------------------optprobe_template_val-----------------------+
>> |- 0 (two 32-bit words)                                        |
>> |(replaced to params for optprobe_optimized_callback)          |
>> +-----------------optprobe_template_orig_addr------------------+
>> |- 0 (two 32-bit words)                                        |
>> |(replaced to origin probe point address)                      |
>> +-------------------optprobe_template_end----------------------+
>> |- nop                                                         |
>> +--------------------------------------------------------------+
>>
>> Co-developed-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>
>> Changes since V6:
>> - Address the comments from Masami, add design of optprobe trampoline in commit.
>> - Address the comments from Yicong, add nop in optprobe_template_end and move
>> optprobe_optimized_callback from framework to arch.
>> - Link: https://lore.kernel.org/lkml/20250103012753.66988-1-xiaqinxin@huawei.com/
>>
>> Changes since V5:
>> - Address the comments from Masami, saves stack frames to obtain correct backtrace
>> and make an array of usage flags to manage the reserved OPT_SLOT_SIZE.
>> - Link: https://lore.kernel.org/lkml/20211207124002.59877-1-liuqi115@huawei.com/
>>
>> Changes since V4:
>> - Address the comments from Masami, update arch_prepare_optimized_kprobe，
>> if the probe address is out of limit return -ERANGE.
>> - Link: https://lore.kernel.org/lkml/20210818073336.59678-1-liuqi115@huawei.com/
>>
>> Changes since V3:
>> - Address the comments from Masami, reduce the number of aarch64_insn_patch_text
>> in arch_optimize_kprobes() and arch_unoptimize_kprobes().
>> - Link: https://lore.kernel.org/lkml/20210810055330.18924-1-liuqi115@huawei.com/
>>
>> Changes since V2:
>> - Address the comments from Masami, prepare another writable buffer in
>> arch_prepare_optimized_kprobe()and build the trampoline code on it.
>> - Address the comments from Amit, move save_all_base_regs and
>> restore_all_base_regs to <asm/assembler.h>, as these two macros are reused
>> in optprobe.
>> - Link: https://lore.kernel.org/lkml/20210804060209.95817-1-liuqi115@huawei.com/
>>
>> Changes since V1:
>> - Address the comments from Masami, checks for all branch instructions, and
>> use aarch64_insn_patch_text_nosync() instead of aarch64_insn_patch_text()
>> in each probe.
>> - Link: https://lore.kernel.org/lkml/20210719122417.10355-1-liuqi115@huawei.com/
>> ---
>>   arch/arm64/Kconfig                            |   1 +
>>   arch/arm64/include/asm/kprobes.h              |  22 ++
>>   arch/arm64/kernel/probes/Makefile             |   2 +
>>   arch/arm64/kernel/probes/opt_arm64.c          | 244 ++++++++++++++++++
>>   .../arm64/kernel/probes/optprobe_trampoline.S | 113 ++++++++
>>   5 files changed, 382 insertions(+)
>>   create mode 100644 arch/arm64/kernel/probes/opt_arm64.c
>>   create mode 100644 arch/arm64/kernel/probes/optprobe_trampoline.S
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 100570a048c5..f9c4e2625595 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -244,6 +244,7 @@ config ARM64
>>   	select HAVE_SYSCALL_TRACEPOINTS
>>   	select HAVE_KPROBES
>>   	select HAVE_KRETPROBES
>> +	select HAVE_OPTPROBES
>>   	select HAVE_GENERIC_VDSO
>>   	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>>   	select IRQ_DOMAIN
>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> index be7a3680dadf..bd4973bfb58d 100644
>> --- a/arch/arm64/include/asm/kprobes.h
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -37,6 +37,28 @@ struct kprobe_ctlblk {
>>
>>   void arch_remove_kprobe(struct kprobe *);
>>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>> +
>> +struct arch_optimized_insn {
>> +	kprobe_opcode_t orig_insn[1];
>> +	kprobe_opcode_t *trampoline;
>> +};
>> +
>> +#define MAX_OPTIMIZED_LENGTH	sizeof(kprobe_opcode_t)
>> +#define MAX_OPTINSN_SIZE                                                       \
>> +	((unsigned long)optprobe_template_end - (unsigned long)optprobe_template_entry)
>> +
>> +extern __visible kprobe_opcode_t optprobe_template_entry[];
>> +extern __visible kprobe_opcode_t optprobe_template_val[];
>> +extern __visible kprobe_opcode_t optprobe_template_orig_addr[];
>> +extern __visible kprobe_opcode_t optprobe_template_common[];
>> +extern __visible kprobe_opcode_t optprobe_template_end[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
>> +extern __visible kprobe_opcode_t optinsn_slot[];
>> +
>> +void optprobe_common(void);
>> +
>>   void __kretprobe_trampoline(void);
>>   void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>
>> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
>> index 8e4be92e25b1..7b2885b23ff6 100644
>> --- a/arch/arm64/kernel/probes/Makefile
>> +++ b/arch/arm64/kernel/probes/Makefile
>> @@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>>   obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>> +obj-$(CONFIG_OPTPROBES)	+= opt_arm64.o			\
>> +				   optprobe_trampoline.o
>> diff --git a/arch/arm64/kernel/probes/opt_arm64.c b/arch/arm64/kernel/probes/opt_arm64.c
>> new file mode 100644
>> index 000000000000..a7f34ab82a2f
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/opt_arm64.c
>> @@ -0,0 +1,244 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Code for Kernel probes Jump optimization.
>> + *
>> + * Copyright (C) 2025 HiSilicon Limited
>> + */
>> +
>> +#include <linux/jump_label.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/wordpart.h>
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/compiler.h>
>> +#include <asm/insn.h>
>> +#include <asm/kprobes.h>
>> +#include <asm/text-patching.h>
>> +
>> +#define OPTPROBE_BATCH_SIZE 64
>> +
>> +#define TMPL_VAL_IDX \
>> +	(optprobe_template_val - optprobe_template_entry)
>> +#define TMPL_ORIGN_ADDR \
>> +	(optprobe_template_orig_addr - optprobe_template_entry)
>> +#define TMPL_CALL_COMMON \
>> +	(optprobe_template_common - optprobe_template_entry)
>> +#define TMPL_RESTORE_ORIGN_INSN \
>> +	(optprobe_template_restore_orig_insn - optprobe_template_entry)
>> +#define TMPL_RESTORE_END \
>> +	(optprobe_template_restore_end - optprobe_template_entry)
>> +
>> +#define OPT_SLOT_SIZE			65536
>> +#define OPT_INSN_PAGES			(OPT_SLOT_SIZE / PAGE_SIZE)
>> +
>> +static bool insn_page_in_use[OPT_INSN_PAGES];
>> +
>> +void *alloc_optinsn_page(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < OPT_INSN_PAGES; i++) {
>> +		if (!insn_page_in_use[i]) {
>> +			insn_page_in_use[i] = true;
>> +			return (void *)((unsigned long)optinsn_slot + PAGE_SIZE * i);
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +void free_optinsn_page(void *page)
>> +{
>> +	unsigned long idx = (unsigned long)page - (unsigned long)optinsn_slot;
>> +
>> +	WARN_ONCE(idx & (PAGE_SIZE - 1), "Invalid idx with wrong align\n");
>> +	idx >>= PAGE_SHIFT;
>> +	if (WARN_ONCE(idx >= OPT_INSN_PAGES, "Invalid idx with wrong size\n"))
>> +		return;
>> +	insn_page_in_use[idx] = false;
>> +}
>> +
>> +/*
>> + * In ARM ISA, kprobe opt always replace one instruction (4 bytes
>> + * aligned and 4 bytes long). It is impossible to encounter another
>> + * kprobe in the address range. So always return 0.
>> + */
>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	return 0;
>> +}
>> +
>> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>> +{
>> +	return optinsn->trampoline != NULL;
>> +}
>> +
>> +int arch_within_optimized_kprobe(struct optimized_kprobe *op, kprobe_opcode_t *addr)
>> +{
>> +	return op->kp.addr == addr;
>> +}
>> +
>> +static int optprobe_check_branch_limit(unsigned long pc, unsigned long addr)
>> +{
>> +	long offset;
>> +
>> +	if ((pc & 0x3) || (addr & 0x3))
>> +		return -ERANGE;
>> +
>> +	offset = (long)addr - (long)pc;
>> +	if (offset < -SZ_128M || offset >= SZ_128M)
>> +		return -ERANGE;
>> +
>> +	return 0;
>> +}
>> +
>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
>> +{
>> +	kprobe_opcode_t *code, *buf;
>> +	int ret = -ENOMEM;
>> +	u32 insn;
>> +	int i;
>> +
>> +	buf = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
>> +	if (!buf)
>> +		return ret;
>> +
>> +	code = get_optinsn_slot();
>> +	if (!code)
>> +		goto out;
>> +
>> +	if (optprobe_check_branch_limit((unsigned long)code, (unsigned long)orig->addr + 8)) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
> Nit: according to origin opcode, it wouldn't work properly
> as typical example is adrp. See the arm_probe_decode_insn().

Thank you very much for your advice.

Do you mean that you need to verify the probe instructions

in addition to the trampoline and origin addresses?

But, a little question， according to the comments of arm_probe_decode_insn,

the INSN_REJECTED instruction should be for kprobe, not just optprobe,

and should be guaranteed by the kprobe framework?

>> +
>> +	memcpy(buf, optprobe_template_entry, MAX_OPTINSN_SIZE);
>> +
>> +	insn = aarch64_insn_gen_branch_imm((unsigned long)&code[TMPL_CALL_COMMON],
>> +					   (unsigned long)&optprobe_common,
>> +					   AARCH64_INSN_BRANCH_LINK);
>> +	if (insn == AARCH64_BREAK_FAULT) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	buf[TMPL_CALL_COMMON] = insn;
>> +
>> +	insn = aarch64_insn_gen_branch_imm((unsigned long)&code[TMPL_RESTORE_END],
>> +					   (unsigned long)(op->kp.addr + 1),
>> +					   AARCH64_INSN_BRANCH_NOLINK);
>> +	if (insn == AARCH64_BREAK_FAULT) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	buf[TMPL_RESTORE_END] = insn;
>> +
>> +	buf[TMPL_VAL_IDX] = cpu_to_le32(lower_32_bits((unsigned long)op));
>> +	buf[TMPL_VAL_IDX + 1] = cpu_to_le32(upper_32_bits((unsigned long)op));
>> +	buf[TMPL_ORIGN_ADDR] = cpu_to_le32(lower_32_bits((unsigned long)orig->addr));
>> +	buf[TMPL_ORIGN_ADDR + 1] = cpu_to_le32(upper_32_bits((unsigned long)orig->addr));
>> +
>> +	buf[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
>> +
>> +	/* Setup template */
>> +	for (i = 0; i < MAX_OPTINSN_SIZE / MAX_OPTIMIZED_LENGTH; i++)
>> +		aarch64_insn_patch_text_nosync(code + i, buf[i]);
>> +
>> +	flush_icache_range((unsigned long)code, (unsigned long)(&code[TMPL_VAL_IDX]));
>> +	/* Set op->optinsn.trampoline means prepared. */
>> +	op->optinsn.trampoline = code;
>> +
>> +	return 0;
>> +error:
>> +	free_optinsn_slot(code, 0);
>> +
>> +out:
>> +	kfree(buf);
>> +	return ret;
>> +}
>> +
>> +void arch_optimize_kprobes(struct list_head *oplist)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +	kprobe_opcode_t insns[OPTPROBE_BATCH_SIZE];
>> +	void *addrs[OPTPROBE_BATCH_SIZE];
>> +	int i = 0;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		WARN_ON(kprobe_disabled(&op->kp));
>> +
>> +		/*
>> +		 * Backup instructions which will be replaced
>> +		 * by jump address
>> +		 */
>> +		memcpy(op->optinsn.orig_insn, op->kp.addr, AARCH64_INSN_SIZE);
>> +
>> +		addrs[i] = op->kp.addr;
>> +		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
>> +						       (unsigned long)op->optinsn.trampoline,
>> +						       AARCH64_INSN_BRANCH_NOLINK);
>> +
>> +		list_del_init(&op->list);
>> +		if (++i == OPTPROBE_BATCH_SIZE)
>> +			break;
>> +	}
>> +
>> +	aarch64_insn_patch_text(addrs, insns, i);
>> +}
>> +
>> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>> +{
>> +	arch_arm_kprobe(&op->kp);
>> +}
>> +
>> +/*
>> + * Recover original instructions and breakpoints from relative jumps.
>> + * Caller must call with locking kprobe_mutex.
>> + */
>> +void arch_unoptimize_kprobes(struct list_head *oplist,
>> +			    struct list_head *done_list)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +	kprobe_opcode_t insns[OPTPROBE_BATCH_SIZE];
>> +	void *addrs[OPTPROBE_BATCH_SIZE];
>> +	int i = 0;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		addrs[i] = op->kp.addr;
>> +		insns[i] = BRK64_OPCODE_KPROBES;
>> +		list_move(&op->list, done_list);
>> +
>> +		if (++i == OPTPROBE_BATCH_SIZE)
>> +			break;
>> +	}
>> +
>> +	aarch64_insn_patch_text(addrs, insns, i);
>> +}
>> +
>> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	if (op->optinsn.trampoline) {
>> +		free_optinsn_slot(op->optinsn.trampoline, 1);
>> +		op->optinsn.trampoline = NULL;
>> +	}
>> +
>> +}
>> +
>> +void optprobe_optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>> +{
>> +	if (kprobe_disabled(&op->kp))
>> +		return;
>> +
>> +	guard(preempt)();
>> +
>> +	if (kprobe_running()) {
>> +		kprobes_inc_nmissed_count(&op->kp);
>> +	} else {
>> +		__this_cpu_write(current_kprobe, &op->kp);
>> +		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
>> +		opt_pre_handler(&op->kp, regs);
>> +		__this_cpu_write(current_kprobe, NULL);
>> +	}
>> +}
>> +NOKPROBE_SYMBOL(optprobe_optimized_callback)
>> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> new file mode 100644
>> index 000000000000..f564b119da69
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> @@ -0,0 +1,113 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * trampoline entry and return code for optprobes.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/assembler.h>
>> +
>> +#define        OPT_SLOT_SIZE   65536
>> +
>> +	.global optinsn_slot
>> +optinsn_slot:
>> +	.space  OPT_SLOT_SIZE
>> +
>> +SYM_CODE_START(optprobe_common)
>> +	stp x2, x3, [sp, #S_X2]
>> +	stp x4, x5, [sp, #S_X4]
>> +	stp x6, x7, [sp, #S_X6]
>> +	stp x8, x9, [sp, #S_X8]
>> +	stp x10, x11, [sp, #S_X10]
>> +	stp x12, x13, [sp, #S_X12]
>> +	stp x14, x15, [sp, #S_X14]
>> +	stp x16, x17, [sp, #S_X16]
>> +	stp x18, x19, [sp, #S_X18]
>> +	stp x20, x21, [sp, #S_X20]
>> +	stp x22, x23, [sp, #S_X22]
>> +	stp x24, x25, [sp, #S_X24]
>> +	stp x26, x27, [sp, #S_X26]
>> +	stp x28, x29, [sp, #S_X28]
>> +	add x2, sp, #PT_REGS_SIZE
>> +	str x2, [sp, #S_SP]
>> +	/* Construct a useful saved PSTATE */
>> +	mrs x2, nzcv
>> +	mrs x3, daif
>> +	orr x2, x2, x3
>> +	mrs x3, CurrentEL
>> +	orr x2, x2, x3
>> +	mrs x3, SPSel
>> +	orr x2, x2, x3
>> +	adr x1, 2f
>> +	stp x1, x2, [sp, #S_PC]
>> +
> Nit: In some context would be, but I think it could raise some problem
> clearing other bit in the PSTATE to be used restoration.
> i.e) PSTATE.BTYPE field. not only this it's almost unpredictable
> what problem will be raised by this and this is one of reason
> optkprobe isn't improper to arm.
Hello, thank you very much for your advice. Can you add some more details?

Here, I store the original address and pstate in the x1 and x2 
registers, respectively,

and then save them to S_PC and S_PSTATE on the stack, according to the 
definition:

#define S_PSTATE 264 /* offsetof(struct pt_regs, pstate) */

#define S_PC 256 /* offsetof(struct pt_regs, pc) */

PC and pstate are used as members of pt_regs in the probe handler.

I'm not sure if it affects restoration in this case.

>> +	/* set the pt_regs address to x1 */
>> +	mov x1, sp
>> +	/* store lr of optprobe_common temporary */
>> +	stp x29, x30, [sp, #-16]!
>> +	mov x29, sp
>> +
>> +	bl optprobe_optimized_callback
>> +
>> +	ldp x29, x30, [sp], #16
>> +
>> +	ldr x0, [sp, #S_PSTATE]
>> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
>> +	msr nzcv, x0
>> +
>> +	ldp x0, x1, [sp, #S_X0]
>> +	ldp x2, x3, [sp, #S_X2]
>> +	ldp x4, x5, [sp, #S_X4]
>> +	ldp x6, x7, [sp, #S_X6]
>> +	ldp x8, x9, [sp, #S_X8]
>> +	ldp x10, x11, [sp, #S_X10]
>> +	ldp x12, x13, [sp, #S_X12]
>> +	ldp x14, x15, [sp, #S_X14]
>> +	ldp x16, x17, [sp, #S_X16]
>> +	ldp x18, x19, [sp, #S_X18]
>> +	ldp x20, x21, [sp, #S_X20]
>> +	ldp x22, x23, [sp, #S_X22]
>> +	ldp x24, x25, [sp, #S_X24]
>> +	ldp x26, x27, [sp, #S_X26]
>> +	ldp x28, x29, [sp, #S_X28]
>> +	ret
>> +SYM_CODE_END(optprobe_common)
>> +
>> +	.global optprobe_template_entry
>> +optprobe_template_entry:
>> +	stp x29, x30, [sp, #-16]!
>> +	mov x29, sp
>> +	adr x30, 2f
>> +	stp x29, x30, [sp, #-16]!
>> +	mov x29, sp
>> +	sub sp, sp, #PT_REGS_SIZE
>> +	str lr, [sp, #S_LR]
>> +	stp x0, x1, [sp, #S_X0]
>> +	/* Get parameters to optimized_callback() */
>> +	adr x0, 1f
>> +	.global optprobe_template_common
>> +optprobe_template_common:
>> +	nop
>> +	ldr lr, [sp, #S_LR]
>> +	add sp, sp, #PT_REGS_SIZE
>> +	ldp x29, x30, [sp], #16
>> +	ldp x29, x30, [sp], #16
>> +	.global optprobe_template_restore_orig_insn
>> +optprobe_template_restore_orig_insn:
>> +	nop
>> +	.global optprobe_template_restore_end
>> +optprobe_template_restore_end:
>> +	nop
>> +	.balign
>> +	.global optprobe_template_val
>> +optprobe_template_val:
>> +	1:	.long 0
>> +		.long 0
>> +	.balign
>> +	.global optprobe_template_orig_addr
>> +optprobe_template_orig_addr:
>> +	2:	.long 0
>> +		.long 0
>> +	.global optprobe_template_end
>> +optprobe_template_end:
>> +	nop
>> --
>> 2.33.0
>>
> --
> Sincerely,
> Yeoreum Yun
>

