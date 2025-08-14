Return-Path: <linux-kernel+bounces-768470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C4FB2614C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434061894BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB692C3252;
	Thu, 14 Aug 2025 09:39:34 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD88262FDC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164374; cv=none; b=K3ysB0msioJWn9ELteSE574MOw+xuPTFYkIGbaBk93NbZ84J0rf0N00gCxbd0pfkfmCuhX+N97UIRlX1lCPiFQwJg+o2g76krkbbluceJ4Fcs4A+BLymwS/02H7hPE/1hLQFsyYA5IlfCDktWtG49YxhJzDs5F3rCRIZxEox2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164374; c=relaxed/simple;
	bh=fpQix0fC8RiLDfKDlLtL2ytKXzEI3Wc85g8Va+Veefk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lAcOdWyq+3qyzHsldPf5pIJd/9itDyfcqVd5tBZeSu+t4UTep8oRR28dVvW3B6JSfez8aakBXCfRMHeqeajX7pttNY0Ud2la5v0DgJUrLQovfsHoJiLRMbQjTxjj42TrTSjjm28y7HlfipjIGcLihwX6L4hAEqr4rJFoxeD6aAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c2gG93jG7z2dMHD;
	Thu, 14 Aug 2025 17:40:33 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 460C11A016C;
	Thu, 14 Aug 2025 17:39:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 17:39:27 +0800
Message-ID: <04df941a-f62d-e640-6619-e79dc88114b3@huawei.com>
Date: Thu, 14 Aug 2025 17:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 0/7] arm64: entry: Convert to generic irq entry
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <puranjay@kernel.org>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <ryan.roberts@arm.com>, <akpm@linux-foundation.org>,
	<chenl311@chinatelecom.cn>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <kristina.martsenko@arm.com>,
	<liaochang1@huawei.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <aJsjQsDZjhG8oiK-@J2N7QTR9R3>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aJsjQsDZjhG8oiK-@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/12 19:19, Mark Rutland wrote:
> Hi,
> 
> This is looking pretty good now, thanks for continuing to work on this!
> 
> I've left a couple of minor comments, and Ada has left a few more. If
> you're able to address those and respin atop v6.17-rc1, I think we can
> start figuring out how to queue this.

Sure，I will revise these review comments based on v6.17-rc1 and release
a new version after local testing.

> 
> Mark.
> 
> On Tue, Jul 29, 2025 at 09:54:49AM +0800, Jinjie Ruan wrote:
>> Currently, x86, Riscv, Loongarch use the generic entry. Also convert
>> arm64 to use the generic entry infrastructure from kernel/entry/*.
>> The generic entry makes maintainers' work easier and codes more elegant,
>> which will make PREEMPT_DYNAMIC and PREEMPT_LAZY use the generic entry
>> common code and remove a lot of duplicate code.
>>
>> Since commit a70e9f647f50 ("entry: Split generic entry into generic
>> exception and syscall entry") split the generic entry into generic irq
>> entry and generic syscall entry, it is time to convert arm64 to use
>> the generic irq entry. And ARM64 will be completely converted to generic
>> entry in the upcoming patch series.
>>
>> The main convert steps are as follows:
>> - Split generic entry into generic irq entry and generic syscall to
>>   make the single patch more concentrated in switching to one thing.
>> - Make arm64 easier to use irqentry_enter/exit().
>> - Make arm64 closer to the PREEMPT_DYNAMIC code of generic entry.
>> - Switch to generic irq entry.
>>
>> It was tested ok with following test cases on QEMU virt platform:
>>  - Perf tests.
>>  - Different `dynamic preempt` mode switch.
>>  - Pseudo NMI tests.
>>  - Stress-ng CPU stress test.
>>  - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
>>    and all test cases in tools/testing/selftests/arm64/mte/*.
>>
>> The test QEMU configuration is as follows:
>>
>> 	qemu-system-aarch64 \
>> 		-M virt,gic-version=3,virtualization=on,mte=on \
>> 		-cpu max,pauth-impdef=on \
>> 		-kernel Image \
>> 		-smp 8,sockets=1,cores=4,threads=2 \
>> 		-m 512m \
>> 		-nographic \
>> 		-no-reboot \
>> 		-device virtio-rng-pci \
>> 		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
>> 			earlycon preempt=voluntary irqchip.gicv3_pseudo_nmi=1" \
>> 		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
>> 		-device virtio-blk-device,drive=hd0 \
>>
>> Changes in v7:
>> - Rebased on v6.16-rc7 and remove the merged first patch.
>> - Update the commit message.
>>
>> Changes in v6:
>> - Rebased on 6.14 rc2 next.
>> - Put the syscall bits aside and split it out.
>> - Have the split patch before the arm64 changes.
>> - Merge some tightly coupled patches.
>> - Adjust the order of some patches to make them more reasonable.
>> - Define regs_irqs_disabled() by inline function.
>> - Define interrupts_enabled() in terms of regs_irqs_disabled().
>> - Delete the fast_interrupts_enabled() macro.
>> - irqentry_state_t -> arm64_irqentry_state_t.
>> - Remove arch_exit_to_user_mode_prepare() and pull local_daif_mask() later
>>   in the arm64 exit sequence
>> - Update the commit message.
>>
>> Changes in v5:
>> - Not change arm32 and keep inerrupts_enabled() macro for gicv3 driver.
>> - Move irqentry_state definition into arch/arm64/kernel/entry-common.c.
>> - Avoid removing the __enter_from_*() and __exit_to_*() wrappers.
>> - Update "irqentry_state_t ret/irq_state" to "state"
>>   to keep it consistently.
>> - Use generic irq entry header for PREEMPT_DYNAMIC after split
>>   the generic entry.
>> - Also refactor the ARM64 syscall code.
>> - Introduce arch_ptrace_report_syscall_entry/exit(), instead of
>>   arch_pre/post_report_syscall_entry/exit() to simplify code.
>> - Make the syscall patches clear separation.
>> - Update the commit message.
>>
>> Changes in v4:
>> - Rework/cleanup split into a few patches as Mark suggested.
>> - Replace interrupts_enabled() macro with regs_irqs_disabled(), instead
>>   of left it here.
>> - Remove rcu and lockdep state in pt_regs by using temporary
>>   irqentry_state_t as Mark suggested.
>> - Remove some unnecessary intermediate functions to make it clear.
>> - Rework preempt irq and PREEMPT_DYNAMIC code
>>   to make the switch more clear.
>> - arch_prepare_*_entry/exit() -> arch_pre_*_entry/exit().
>> - Expand the arch functions comment.
>> - Make arch functions closer to its caller.
>> - Declare saved_reg in for block.
>> - Remove arch_exit_to_kernel_mode_prepare(), arch_enter_from_kernel_mode().
>> - Adjust "Add few arch functions to use generic entry" patch to be
>>   the penultimate.
>> - Update the commit message.
>> - Add suggested-by.
>>
>> Changes in v3:
>> - Test the MTE test cases.
>> - Handle forget_syscall() in arch_post_report_syscall_entry()
>> - Make the arch funcs not use __weak as Thomas suggested, so move
>>   the arch funcs to entry-common.h, and make arch_forget_syscall() folded
>>   in arch_post_report_syscall_entry() as suggested.
>> - Move report_single_step() to thread_info.h for arm64
>> - Change __always_inline() to inline, add inline for the other arch funcs.
>> - Remove unused signal.h for entry-common.h.
>> - Add Suggested-by.
>> - Update the commit message.
>>
>> Changes in v2:
>> - Add tested-by.
>> - Fix a bug that not call arch_post_report_syscall_entry() in
>>   syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
>> - Refactor report_syscall().
>> - Add comment for arch_prepare_report_syscall_exit().
>> - Adjust entry-common.h header file inclusion to alphabetical order.
>> - Update the commit message.
>>
>> Jinjie Ruan (7):
>>   arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
>>   arm64: entry: Refactor the entry and exit for exceptions from EL1
>>   arm64: entry: Rework arm64_preempt_schedule_irq()
>>   arm64: entry: Use preempt_count() and need_resched() helper
>>   arm64: entry: Refactor preempt_schedule_irq() check code
>>   arm64: entry: Move arm64_preempt_schedule_irq() into
>>     __exit_to_kernel_mode()
>>   arm64: entry: Switch to generic IRQ entry
>>
>>  arch/arm64/Kconfig                    |   1 +
>>  arch/arm64/include/asm/daifflags.h    |   2 +-
>>  arch/arm64/include/asm/entry-common.h |  56 ++++
>>  arch/arm64/include/asm/preempt.h      |   2 -
>>  arch/arm64/include/asm/ptrace.h       |  13 +-
>>  arch/arm64/include/asm/xen/events.h   |   2 +-
>>  arch/arm64/kernel/acpi.c              |   2 +-
>>  arch/arm64/kernel/debug-monitors.c    |   2 +-
>>  arch/arm64/kernel/entry-common.c      | 411 +++++++++-----------------
>>  arch/arm64/kernel/sdei.c              |   2 +-
>>  arch/arm64/kernel/signal.c            |   3 +-
>>  kernel/entry/common.c                 |  16 +-
>>  12 files changed, 217 insertions(+), 295 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/entry-common.h
>>
>> -- 
>> 2.34.1
>>
> 

