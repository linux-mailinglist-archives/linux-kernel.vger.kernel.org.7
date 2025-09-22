Return-Path: <linux-kernel+bounces-826988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CBB8FD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F152A00A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B3226E715;
	Mon, 22 Sep 2025 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OSA1VEl0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE02287254
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534279; cv=none; b=dEeWYOXJmIXhb7o811Lj2QJmnZeza3kY8DKfmGlqbTyNm9l8WyhWAV1006USrFXRw96bRjdpvGZQ0IYkDwN8WapUKSIxtDEAkhrk1JJ83IoL83nG1aIcfzWa9jshREnVFqt4rsdBEHThAa/s5qM7brQ8FNyTErD6V7gw+Uecnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534279; c=relaxed/simple;
	bh=bh3PrlTyHqr89iR5kDHD3GFHvUPf4v7jEkCtIvQxWFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN0aHDxqh46rohiWHMwCDDWVB7Aci4JchKJ3/qR/eTQtI2h5Z/8mifuLRgWsARHT4N2XzvnGOOSdjHzvAi/zASuBbDExy7ihB4LEFj1OENYOoZ2/efFTW9ktVqqSfwQgCONTkkFfMI9+0d6GL5q3bOFptb2qHy4Kc1ZYgerMz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OSA1VEl0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1AC3340E015C;
	Mon, 22 Sep 2025 09:44:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WJo_HN9dz-Cw; Mon, 22 Sep 2025 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758534262; bh=UC6vGCroZxEaEsreADnB6bNDmgN+ygH/lgJg5f2jp6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSA1VEl0zFJ6BO6/gXLxRPhkJ1Hqv3dJxPeNDhbPPdGbApjpYgT6eCizi8j4X8X2c
	 2i2HK2Xtgx9tyyEyw5CXQ7/gVJKFcYN7k4Qm+Gq/H6ICn5bh6igQMwUeuY4awoFsiH
	 GTM2ocypeqIh+EG8tHTLPqzRuwknmoaoBE7kx30wOek8wbptEu+o6CJCxxtU3lptjF
	 qId111jlPqA+LP4CBp+nSj6HK3qKlGXS5H0evaEtpVWV4eCnePtIQE05c0ZTR5S4Or
	 MNWULQuXFb+uqnquuQFyiTFFu730CS6xc2eHIFMTOQaspQvAvhPrDR2g90KsIdecuS
	 DDqnZ6+cGWZBe8Fm7noJdl3Rhowdc+1wvOZioHNH9mEN40n2VDadA8dZQ9R/4L6Ck3
	 J/p/MM+ht+aiSXXjQYm1ZDuMe4P2HcQBSR0beRXR3WzhUJvD4BJvZbQSpTzEJdx3Uq
	 RzHGlywz8HaWHUxpVjQs+qvPeg2Rj2sShbbsMla1OQXA5YX/8oHbLhESd8iJ+EZsjq
	 rBY8Le1Z10cUArMDUnVWpmpvGYo2WwT5ormo26KlXvQ5pShlguBSAUA5mnnWPbNqSM
	 J63CB9oy46KGDpwuzIqoXwNcDONXOKPhfUxD9Fk8VbcCuynCKUvl354T1y6EWRSTQr
	 m5vQtCIXoT+T2s1yXoklQl8M=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1F7C340E0196;
	Mon, 22 Sep 2025 09:44:11 +0000 (UTC)
Date: Mon, 22 Sep 2025 11:44:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: x86@kernel.org, jpoimboe@kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
Message-ID: <20250922094404.GAaNEaZIj-Hdilh_9H@fat_crate.local>
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

What kind of a use case is that even? Why do we care?

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

What is this stack dump here for?

If it is absolutely needed, at least clean it up by removing hex numbers and
timestamps because they're useless in a commit message.

> 
> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
> v3: Address Josh comment, move kasan checks to show_trace_log_lvl, and
>     controlled by task != current.
> v2: https://lore.kernel.org/all/20250829094744.3133324-1-wutengda@huaweicloud.com/
> v1: https://lore.kernel.org/all/20250818130715.2904264-1-wutengda@huaweicloud.com/
> ---
>  arch/x86/kernel/dumpstack.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 71ee20102a8a..6d1ae0d77ffc 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -189,9 +189,20 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>  	unsigned long visit_mask = 0;
>  	int graph_idx = 0;
>  	bool partial = false;
> +	bool kasan_disabled = false;
>  
>  	printk("%sCall Trace:\n", log_lvl);
>  
> +	/*
> +	 * KASAN should be disabled during walking another task's stacks
> +	 * to prevent false positives, as values on these stacks may change
> +	 * concurrently with task execution.
> +	 */
> +	if (task && task != current) {
> +		kasan_disable_current();
> +		kasan_disabled = true;
> +	}

I don't like the sprinking of KASAN checks all over the tree just to make this
thing work.

If anything, you should disable KASAN like this:

show_trace_log_lvl:
	disable KASAN
	__show_trace_log_lvl
	enable KASAN

so that at least this thing is out of the way.

But I'd like to hear first whether that's a use case we really want to
support. Right now, it sounds like a meh to me: if you want to walk a task's
stack with KASAN enabled, then stop it first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

