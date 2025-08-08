Return-Path: <linux-kernel+bounces-760169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B9B1E757
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615D6587BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5596F2749E8;
	Fri,  8 Aug 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM9N/akd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7F27467A;
	Fri,  8 Aug 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652514; cv=none; b=utlfOKeP08TWyoJXnOdMJK2vOuppbsYd6ka/AmRDJVf0Lu/WxsWyM/6LwfDtLec0Df3Pa+KDMY1tFoj166q+rIAj6Edo3PU1lKhk3bl6ylDcI4fXTSu6pk6yQEm6flXB1TBrkiQiZw8fLNkzf9w7f1s0G33D4vGChhiD9WEhFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652514; c=relaxed/simple;
	bh=7bjZzLfO9fl1ghbHcTqWmndQHxP4RCvD8GzQZJjMcHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uqev8xKZCWQLjq3kRfd/Gm0pAWrPRQAGrljY0j5JYKoDXc/4UqMxvdENFHz8cFO7VlS8JoDsGngLRQZo/p1R2zs/yLGp5r2DfT6l1EuiznQvR4MHPuZZPlT3aczZePN3I2t/VfdTpyXKJ4dLeYMkS3uWAv8DiGtFwr5ErYZ83Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM9N/akd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D52C4CEED;
	Fri,  8 Aug 2025 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754652514;
	bh=7bjZzLfO9fl1ghbHcTqWmndQHxP4RCvD8GzQZJjMcHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EM9N/akdd5EknCUIRfNSycnmf+GuuLwx9r1iowOgI1VM/jPQJJWuTe2M0lx0BCn62
	 7ZJZSQ8QPw4PqxA3E7U0+yIrHQZQeATd5AYlunMxnVVvZWTDPCfTicAT0WobVXjfdP
	 qAaqRL8W/f20T5FDrzmj4TI/NVMtel/Vur+PgekEOSgDoqkTqBWpz3mfJiTtWKT3kK
	 pRUnPPM6tBDkZBCEfnDCMrAeK5NqhPOWuxZQ+FkxBCvlkPB5K7ZFj5NdL//rfUHp3r
	 JQSeLsGt2mezuOoIzXIH5b/tSYvkvtRRvvukOVKBp96rhpHiU+4ZKlUa79r0A3m4lW
	 p+zYV/qcchcFQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>,  <oe-lkp@lists.linux.dev>,
  <lkp@intel.com>,  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Changyuan
 Lyu <changyuanl@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,
  <kexec@lists.infradead.org>,  <linux-mm@kvack.org>
Subject: Re: [linus:master] [kho]  b753522bed:
 INFO:trying_to_register_non-static_key
In-Reply-To: <202508081032.1450e413-lkp@intel.com>
References: <202508081032.1450e413-lkp@intel.com>
Date: Fri, 08 Aug 2025 13:28:31 +0200
Message-ID: <mafs0sei2aw80.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 08 2025, kernel test robot wrote:

> Hello,
>
[...]
>
>
> [   59.011407][    T1] INFO: trying to register non-static key.
> [   59.011783][    T1] The code is fine but needs lockdep annotation, or maybe
> [   59.011783][    T1] you didn't initialize this object before use?
> [   59.011783][    T1] turning off the locking correctness validator.
> [   59.011783][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.16.0-rc5-00079-gb753522bed0b #1 PREEMPT(voluntary)
> [   59.011783][    T1] Tainted: [T]=RANDSTRUCT
> [   59.011783][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   59.011783][    T1] Call Trace:

Pasha, I think your patch [0] fixes this. Perhaps it is a good idea for
it to land independent of the LUO patches, since those are likely to
take some more time?

[0] https://lore.kernel.org/lkml/20250807014442.3829950-2-pasha.tatashin@soleen.com/

> [   59.011783][    T1]  <TASK>
> [ 59.011783][ T1] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 59.011783][ T1] assign_lock_key (kernel/locking/lockdep.c:988) 
> [ 59.011783][ T1] register_lock_class (kernel/locking/lockdep.c:?) 
> [ 59.011783][ T1] __lock_acquire (kernel/locking/lockdep.c:?) 
> [ 59.011783][ T1] lock_acquire (kernel/locking/lockdep.c:5871) 
> [ 59.011783][ T1] ? xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
> [ 59.011783][ T1] ? tracer_preempt_off (kernel/trace/trace_irqsoff.c:412) 
> [ 59.011783][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
> [ 59.011783][ T1] ? xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
> [ 59.011783][ T1] xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
> [ 59.011783][ T1] __kho_preserve_order (kernel/kexec_handover.c:156) 
> [ 59.011783][ T1] kho_test_init (lib/test_kho.c:84) 
> [ 59.011783][ T1] ? __cfi_kho_test_init (lib/test_kho.c:271) 
> [ 59.011783][ T1] do_one_initcall (init/main.c:1274) 
> [ 59.011783][ T1] ? __cfi_kho_test_init (lib/test_kho.c:271) 
> [ 59.011783][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
> [ 59.011783][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
> [ 59.011783][ T1] ? __kasan_kmalloc (mm/kasan/common.c:398) 
> [ 59.011783][ T1] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:412) 
> [ 59.011783][ T1] ? do_initcalls (include/linux/slab.h:909 include/linux/slab.h:1039 init/main.c:1345) 
> [ 59.011783][ T1] ? kernel_init_freeable (init/main.c:1588) 
> [ 59.011783][ T1] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:452) 
> [ 59.011783][ T1] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:412) 
> [ 59.011783][ T1] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:452) 
> [ 59.011783][ T1] ? irqentry_exit (kernel/entry/common.c:311) 
> [ 59.011783][ T1] ? next_arg (lib/cmdline.c:273) 
> [ 59.011783][ T1] ? parameq (kernel/params.c:91) 
> [ 59.011783][ T1] ? parse_args (kernel/params.c:?) 
> [ 59.011783][ T1] do_initcall_level (init/main.c:1335) 
> [ 59.011783][ T1] do_initcalls (init/main.c:1349) 
> [ 59.011783][ T1] kernel_init_freeable (init/main.c:1588) 
> [ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
> [ 59.011783][ T1] kernel_init (init/main.c:1476) 
> [ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
> [ 59.011783][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
> [ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
> [ 59.011783][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
> [   59.011783][    T1]  </TASK>

-- 
Regards,
Pratyush Yadav

