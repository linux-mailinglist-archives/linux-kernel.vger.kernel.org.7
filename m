Return-Path: <linux-kernel+bounces-722921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A1AAFE0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7F54A823E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148A26B74E;
	Wed,  9 Jul 2025 07:01:06 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B39267B89
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044466; cv=none; b=j8vGFOC4c0xNw5I2Ho/L8hOM0RRiUDH2dVWu+SiG4frvdz1ZETsFac81/rAkHlcqUCRoELlhJY5L57ldGH57QZkD7jCjGDE1mJ+/GwW37Y/bMVYTjRejMGlv5FnEbujrqWhRGqSzMtUFb4Wnohosg0JT2zwKAFlFRp20eZ5wmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044466; c=relaxed/simple;
	bh=tG/YzIht748x9oejqHS0is0xE478z/njblx4OmMKI/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MRgAk4W+ehM3gMFmXl9hM6/ICbfvRQ7oScMEWaFGB90UQs+svl4SV1Oqog0YFRoH2CFSHT6UAS9qYC7Xuv6mM364w9UGqltUgxUKBRu5jKvm3PH0hwM1qWkeKLbLrq5ZBdc0H1yB21A5e9D01OWdPYj/WeThU9F49Q7cVvwzWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 012BA442EF;
	Wed,  9 Jul 2025 07:00:58 +0000 (UTC)
Message-ID: <6a07cf54-8e97-4726-ba38-67feb90f3e7f@ghiti.fr>
Date: Wed, 9 Jul 2025 09:00:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Enable interrupt during exception handling
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250625085630.3649485-1-namcao@linutronix.de>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250625085630.3649485-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeufeegheehgedtvdegleegjeejfedukeegteffieejgfevjeduheffffdtlefhhfenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegrjegvvdemrgguledvmeelrggsjeemfeduhegsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegrjegvvdemrgguledvmeelrggsjeemfeduhegspdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegrjegvvdemrgguledvmeelrggsjeemfeduhegsngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehnrghmtggroheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdpr
 hgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg

Hi Nam,

On 6/25/25 10:56, Nam Cao wrote:
> force_sig_fault() takes a spinlock, which is a sleeping lock with
> CONFIG_PREEMPT_RT=y. However, exception handling calls force_sig_fault()
> with interrupt disabled, causing a sleeping in atomic context warning.
>
> This can be reproduced using userspace programs such as:
>      int main() { asm ("ebreak"); }
> or
>      int main() { asm ("unimp"); }
>
> There is no reason that interrupt must be disabled while handling
> exceptions from userspace.
>
> Enable interrupt while handling user exceptions. This also has the added
> benefit of avoiding unnecessary delays in interrupt handling.
>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2: stop enabling interrupts for kernel exceptions. For exceptions treated
> like NMI, it is wrong. For page faults, interrupts are already
> (conditionally) enabled.
> ---
>   arch/riscv/kernel/traps.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 9c83848797a78..80230de167def 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -6,6 +6,7 @@
>   #include <linux/cpu.h>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> +#include <linux/irqflags.h>
>   #include <linux/randomize_kstack.h>
>   #include <linux/sched.h>
>   #include <linux/sched/debug.h>
> @@ -151,7 +152,9 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
>   {										\
>   	if (user_mode(regs)) {							\
>   		irqentry_enter_from_user_mode(regs);				\
> +		local_irq_enable();						\
>   		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
> +		local_irq_disable();						\
>   		irqentry_exit_to_user_mode(regs);				\
>   	} else {								\
>   		irqentry_state_t state = irqentry_nmi_enter(regs);		\
> @@ -173,17 +176,14 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>   
>   	if (user_mode(regs)) {
>   		irqentry_enter_from_user_mode(regs);
> -
>   		local_irq_enable();
>   
>   		handled = riscv_v_first_use_handler(regs);
> -
> -		local_irq_disable();
> -
>   		if (!handled)
>   			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
>   				      "Oops - illegal instruction");
>   
> +		local_irq_disable();
>   		irqentry_exit_to_user_mode(regs);
>   	} else {
>   		irqentry_state_t state = irqentry_nmi_enter(regs);
> @@ -308,9 +308,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>   {
>   	if (user_mode(regs)) {
>   		irqentry_enter_from_user_mode(regs);
> +		local_irq_enable();
>   
>   		handle_break(regs);
>   
> +		local_irq_disable();
>   		irqentry_exit_to_user_mode(regs);
>   	} else {
>   		irqentry_state_t state = irqentry_nmi_enter(regs);


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Let's also add:

Cc: stable@vger.kernel.org

I pick this up for next week fixes PR.

Thanks,

Alex



