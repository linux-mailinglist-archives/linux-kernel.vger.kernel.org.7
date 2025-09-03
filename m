Return-Path: <linux-kernel+bounces-799306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4FB429CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3941BC662A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4103629B2;
	Wed,  3 Sep 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEXgy4nB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690A350D76
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927401; cv=none; b=fo7F5cZRifoJcWMzy4TFt+Ayd6hj4Our6hoh3Dus5610W5BozLsFAgL2naWlScgiBkoK1stV1c5fg6sH/vWuZJL/mrCwp4PCsFUTO4xK7A7UKhMJ4REFk24NG1rvgj933Y4MUArMkIgV/2Y8BBGrBQ/ldvQ3Afe6pSMsgpomTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927401; c=relaxed/simple;
	bh=gJ/bFRAd0iDz04QupVIiAnJmwSv0PtDJEqUwWK7A5HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PofqQ2Qs+VA9w6PFd8vK0aOINST95JrOdnJC2OC9zxEhxCAMOLQhwXNUf5ZrGtYFbCngONY/soSSGt0IC727qmlw3PTLHi0/2rYW+WAuteCwmD9q8rwYqgGusD0imV1ULJSgjKrQq8w/aaA/HilmVH7TAmzWvFxSjqtCUCd0N50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEXgy4nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CDC4CEE7;
	Wed,  3 Sep 2025 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927400;
	bh=gJ/bFRAd0iDz04QupVIiAnJmwSv0PtDJEqUwWK7A5HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEXgy4nBX0lAe9nJ3hqjpzflzzWlnRUSa49/g4YXN8Ce8qn2hI7CAL2VQIcuV3Bkb
	 Ma3b8R2PvfmzAzRN/PG32oeFa90rxZRhxpYvXGkVa5pUCYMjSuWYRMVsclrWzN6yxD
	 TfFAPvWl53z2YpFH6F7Fo4Lf1hzf+T3nxhQj3/RN9+7TflZAucpj2T+D9b84paXr8S
	 PdOHkHkLsOJqI1yqVyc7bRXD59DVxk4s+GefVr+crESilXhAbLzhsJTlg1ZErg+8q/
	 YIGOBB/AjPt3lvOAMkHIO4uTHIQHvcGhOxxN19Je83+KWZdzZ0dt4kuFCc1O6moX0W
	 P+TlOKA259r1w==
Date: Wed, 3 Sep 2025 12:23:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
Message-ID: <dqpml2a3cgta6s32mkzptqldhiro7jfdmgh7qfpypwihwxdsc5@y5bfss3dlfq2>
References: <20250830092556.3360776-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830092556.3360776-1-wutengda@huaweicloud.com>

On Sat, Aug 30, 2025 at 09:25:56AM +0000, Tengda Wu wrote:
> When task A walks task B's stack without suspending it, the continuous
> changes in task B's stack (and corresponding KASAN shadow tags) may cause
> task A to hit KASAN redzones when accessing obsolete values on the stack,
> resulting in false positive reports. [1][2]
> 
> The specific issue occurs as follows:
> 
> Task A (walk other tasks' stacks)           Task B (running)
> 1. echo t > /proc/sysrq-trigger
> 
> show_trace_log_lvl
>   regs = unwind_get_entry_regs()
>   show_regs_if_on_stack(regs)
>                                             2. The stack data pointed by
>                                                `regs` keeps changing, and
>                                                so are the tags in its
>                                                KASAN shadow region.
>     __show_regs(regs)
>       regs->ax, regs->bx, ...
>         3. hit KASAN redzones, OOB
> 
> Fix this by detecting asynchronous stack unwinding scenarios through
> `task != current` during unwinding, and disabling KASAN checks when this
> scenario occurs.
> 
> [1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
> [2] KASAN out-of-bounds:
> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
> [332706.552562]
> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
> [332706.552783] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
> [332706.552906] Call Trace:
> [332706.552998]  <TASK>
> [332706.553089]  dump_stack_lvl+0x32/0x50
> [332706.553193]  print_address_description.constprop.0+0x6b/0x3d0
> [332706.553303]  print_report+0xbe/0x280
> [332706.553409]  ? __virt_addr_valid+0xed/0x160
> [332706.553512]  ? __show_regs+0x4b/0x340
> [332706.553612]  kasan_report+0xa8/0xe0
> [332706.553716]  ? __show_regs+0x4b/0x340
> [332706.553816]  ? asm_exc_page_fault+0x22/0x30
> [332706.553919]  __show_regs+0x4b/0x340
> [332706.554021]  ? asm_exc_page_fault+0x22/0x30
> [332706.554123]  show_trace_log_lvl+0x274/0x3b0
> [332706.554229]  ? load_elf_binary+0xf6e/0x1610
> [332706.554330]  ? rep_stos_alternative+0x40/0x80
> [332706.554439]  sched_show_task+0x211/0x290
> [332706.554544]  ? __pfx_sched_show_task+0x10/0x10
> [332706.554648]  ? _find_next_bit+0x6/0xc0
> [332706.554749]  ? _find_next_bit+0x37/0xc0
> [332706.554852]  show_state_filter+0x72/0x130
> [332706.554956]  sysrq_handle_showstate+0x7/0x10
> [332706.555062]  __handle_sysrq+0x146/0x2d0
> [332706.555165]  write_sysrq_trigger+0x2f/0x50
> [332706.555270]  proc_reg_write+0xdd/0x140
> [332706.555372]  vfs_write+0x1ff/0x5f0
> [332706.555474]  ? __pfx_vfs_write+0x10/0x10
> [332706.555576]  ? __pfx___handle_mm_fault+0x10/0x10
> [332706.555682]  ? __fget_light+0x99/0xf0
> [332706.555785]  ksys_write+0xb8/0x150
> [332706.555887]  ? __pfx_ksys_write+0x10/0x10
> [332706.555989]  ? ktime_get_coarse_real_ts64+0x4e/0x70
> [332706.556094]  do_syscall_64+0x55/0x100
> [332706.556196]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
> v3: Address Josh comment, move kasan checks to show_trace_log_lvl, and
>     controlled by task != current.
> v2: https://lore.kernel.org/all/20250829094744.3133324-1-wutengda@huaweicloud.com/
> v1: https://lore.kernel.org/all/20250818130715.2904264-1-wutengda@huaweicloud.com/

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

