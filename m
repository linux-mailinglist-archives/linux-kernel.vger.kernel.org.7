Return-Path: <linux-kernel+bounces-847630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D2BCB4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9BBA3503F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FB20FA81;
	Fri, 10 Oct 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qJz2Fp6g"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920491A275
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760057995; cv=none; b=Sniilvk1Hxk5Ae/D0kKu4PhcoIpQeEFDjkcjWku7EKnoojKBXAfkNRFhhKL2SuALokwpwmYQ1g/LJFPjy9jI4TiQKqLsG3SXM4Fn/VVlsIzBIENbJ5Ufj6ptUznN0eT2aEQj17V53u63dV1Qx+FJO6ber2PoQMwtlO7yHZTKZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760057995; c=relaxed/simple;
	bh=Pnt4chEVnkNjBUjJi/6n0WZ13ofQOhZwYqqx+QruaIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d2w4x20QkDdgaoX1Rao76bulLVphb9UtO3jcMgbV2DWqprOo68VQ5cJXwgibQDwLenX0PW6UKQin8cpNDCMhRjvaiouT2fl5kwiRoeYBrXPjLzHJBTcuTQsDTifCjqAUKKKJD1xAj02SiBKDDyUY/HP4jtqwH7EZl/nHYT3aFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qJz2Fp6g; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WA9Pel75fLqSTRw8Eo2gsDw6Gknb1AfqAzovfD12K1w=;
	b=qJz2Fp6gn3nQw2UvxxRThm3qNI/ZNTiTG58N0RC2sb2ZLqs0PzxynoeKTqKGNYl2u1omOn0Hv
	yA/wR8gZB+Qws43VF7GH8JSlsc1tx7+R/4VNB3SknLYChShHbgZDJ+Lb/aMfglX88EfB/zol5Pe
	x4oR++GsflQGfuUGf0WGWNU=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cjT0b0DKGzLlTj;
	Fri, 10 Oct 2025 08:59:27 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 11331180043;
	Fri, 10 Oct 2025 08:59:44 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 08:59:43 +0800
Message-ID: <35491951-3833-8055-bf3c-f0bf3a239409@huawei.com>
Date: Fri, 10 Oct 2025 08:59:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v6 00/10] arm64: entry: Convert to generic entry
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <charlie@rivosinc.com>,
	<macro@orcam.me.uk>, <deller@gmx.de>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250916082611.2972008-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250916082611.2972008-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/9/16 16:26, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry which makes
> maintainers' work easier and codes more elegant. In the previous patchset,
> arm64 has already successfully switched to the generic IRQ entry, it is
> time to completely convert arm64 to generic entry.

Gentle ping.


> 
> The main convert steps are as follows:
> - Make arm64 closer to generic syscall entry code.
> - Switch to generic entry.
> 
> This patch set is rebased on v6.17-rc5-next.
> 
> It was tested ok with following test cases on QEMU virt platform:
>  - Perf tests.
>  - Different `dynamic preempt` mode switch.
>  - Pseudo NMI tests.
>  - Stress-ng CPU stress test.
>  - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
>    and all test cases in tools/testing/selftests/arm64/mte/*.
> 
> The test QEMU configuration is as follows:
> 
> 	qemu-system-aarch64 \
> 		-M virt,gic-version=3,virtualization=on,mte=on \
> 		-cpu max,pauth-impdef=on \
> 		-kernel Image \
> 		-smp 8,sockets=1,cores=4,threads=2 \
> 		-m 512m \
> 		-nographic \
> 		-no-reboot \
> 		-device virtio-rng-pci \
> 		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
> 			earlycon preempt=voluntary irqchip.gicv3_pseudo_nmi=1" \
> 		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
> 		-device virtio-blk-device,drive=hd0 \
> 
> Changes in v6:
> - Rebased on v6.17-rc5-next as arm64 generic irq entry has merged.
> - Update the commit message.
> - Link to v5: https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.com/
> 
> Changes in v5:
> - Not change arm32 and keep inerrupts_enabled() macro for gicv3 driver.
> - Move irqentry_state definition into arch/arm64/kernel/entry-common.c.
> - Avoid removing the __enter_from_*() and __exit_to_*() wrappers.
> - Update "irqentry_state_t ret/irq_state" to "state"
>   to keep it consistently.
> - Use generic irq entry header for PREEMPT_DYNAMIC after split
>   the generic entry.
> - Also refactor the ARM64 syscall code.
> - Introduce arch_ptrace_report_syscall_entry/exit(), instead of
>   arch_pre/post_report_syscall_entry/exit() to simplify code.
> - Make the syscall patches clear separation.
> - Update the commit message.
> - Link to v4: https://lore.kernel.org/all/20241025100700.3714552-1-ruanjinjie@huawei.com/
> 
> Changes in v4:
> - Rework/cleanup split into a few patches as Mark suggested.
> - Replace interrupts_enabled() macro with regs_irqs_disabled(), instead
>   of left it here.
> - Remove rcu and lockdep state in pt_regs by using temporary
>   irqentry_state_t as Mark suggested.
> - Remove some unnecessary intermediate functions to make it clear.
> - Rework preempt irq and PREEMPT_DYNAMIC code
>   to make the switch more clear.
> - arch_prepare_*_entry/exit() -> arch_pre_*_entry/exit().
> - Expand the arch functions comment.
> - Make arch functions closer to its caller.
> - Declare saved_reg in for block.
> - Remove arch_exit_to_kernel_mode_prepare(), arch_enter_from_kernel_mode().
> - Adjust "Add few arch functions to use generic entry" patch to be
>   the penultimate.
> - Update the commit message.
> - Add suggested-by.
> - Link to v3: https://lore.kernel.org/all/20240629085601.470241-1-ruanjinjie@huawei.com/
> 
> Changes in v3:
> - Test the MTE test cases.
> - Handle forget_syscall() in arch_post_report_syscall_entry()
> - Make the arch funcs not use __weak as Thomas suggested, so move
>   the arch funcs to entry-common.h, and make arch_forget_syscall() folded
>   in arch_post_report_syscall_entry() as suggested.
> - Move report_single_step() to thread_info.h for arm64
> - Change __always_inline() to inline, add inline for the other arch funcs.
> - Remove unused signal.h for entry-common.h.
> - Add Suggested-by.
> - Update the commit message.
> 
> Changes in v2:
> - Add tested-by.
> - Fix a bug that not call arch_post_report_syscall_entry() in
>   syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
> - Refactor report_syscall().
> - Add comment for arch_prepare_report_syscall_exit().
> - Adjust entry-common.h header file inclusion to alphabetical order.
> - Update the commit message.
> 
> Jinjie Ruan (10):
>   arm64/ptrace: Split report_syscall() into report_syscall_enter/exit()
>   arm64/ptrace: Refactor syscall_trace_enter/exit()
>   arm64/ptrace: Refator el0_svc_common()
>   entry: Extract syscall_exit_to_user_mode_prepare() helper
>   arm64/ptrace: Handle ptrace_report_syscall_entry() error
>   arm64/ptrace: Rework secure_computing() in syscall_trace_enter()
>   arm64/ptrace: Use syscall_get_arguments() heleper
>   entry: Add arch_ptrace_report_syscall_entry/exit()
>   entry: Add has_syscall_work() helper
>   arm64: entry: Convert to generic entry
> 
>  arch/arm64/Kconfig                    |  2 +-
>  arch/arm64/include/asm/entry-common.h | 69 ++++++++++++++++++++
>  arch/arm64/include/asm/syscall.h      |  6 +-
>  arch/arm64/include/asm/thread_info.h  | 22 +------
>  arch/arm64/kernel/debug-monitors.c    |  7 +++
>  arch/arm64/kernel/ptrace.c            | 90 ---------------------------
>  arch/arm64/kernel/signal.c            |  2 +-
>  arch/arm64/kernel/syscall.c           | 31 +++------
>  include/linux/entry-common.h          | 42 ++++++++-----
>  kernel/entry/syscall-common.c         | 43 ++++++++++++-
>  10 files changed, 161 insertions(+), 153 deletions(-)
> 

