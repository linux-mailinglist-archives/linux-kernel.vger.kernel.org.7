Return-Path: <linux-kernel+bounces-827581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0AB92248
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1B52A15FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FDE3112C7;
	Mon, 22 Sep 2025 16:08:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3032948CFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557322; cv=none; b=qb/kAmQ3yrGHQM2fpN6ICpQ3B9/VYBwU8agkR4fJgw35Gl+Gpn5ifeTmLKx6JqVvEQ+ADR30xGuKT4hzevdo8p1+Cie4YV7OoKhvKD5aGtKN3V54eSO6pJSdqLTGvlQAmkC7JXyOK6rrmBwyzg/5+WlorziDRmiOrOjU0dWcUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557322; c=relaxed/simple;
	bh=nvswOqijzNfQrOmw4Zg9AAw6f1JENWkgBsFAFt9n6uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar70xCr06qlTrvIt/vmTPzKu0h/WQEHQN8hxgj2C/bDZdsylZacWw/pd1HMVdwkndXY/PyR1bzMyC5UWf/+2MKBKos0chmACORZEtg5zDx8k1jvtdW7khRikINx9ZVtaJtOuBNVjy1TIHXM2/dKfB4G3AvLLGAUVtZ1Qlxj9O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 052771424;
	Mon, 22 Sep 2025 09:08:29 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F13CA3F694;
	Mon, 22 Sep 2025 09:08:35 -0700 (PDT)
Date: Mon, 22 Sep 2025 17:08:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: shechenglong <shechenglong@xfusion.com>, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stone.xulei@xfusion.com, chenjialong@xfusion.com,
	yuxiating@xfusion.com
Subject: Re: [PATCH] cpu: fix hard lockup triggered during stress-ng stress
 testing.
Message-ID: <aNF0gb1iZndz0-be@J2N7QTR9R3>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <aMvsxd8nHb5roC0o@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMvsxd8nHb5roC0o@arm.com>

On Thu, Sep 18, 2025 at 12:28:05PM +0100, Catalin Marinas wrote:
> On Thu, Sep 18, 2025 at 02:49:07PM +0800, shechenglong wrote:
> > Context of the Issue:
> > In an ARM64 environment, the following steps were performed:
> > 
> > 1. Repeatedly ran stress-ng to stress the CPU, memory, and I/O.
> > 2. Cyclically executed test case pty06 from the LTP test suite.
> > 3. Added mitigations=off to the GRUB parameters.
> > 
> > After 1–2 hours of stress testing, a hardlockup occurred,
> > causing a system crash.
> > 
> > Root Cause of the Hardlockup:
> > Each time stress-ng starts, it invokes the /sys/kernel/debug/clear_warn_once
> > interface, which clears the values in the memory section from __start_once
> > to __end_once. This caused functions like pr_info_once() — originally
> > designed to print only once — to print again every time stress-ng was called.
> > If the pty06 test case happened to be using the serial module at that same
> > moment, it would sleep in waiter.list within the __down_common function.
> > 
> > After pr_info_once() completed its output using the serial module,
> > it invoked the semaphore up() function to wake up the process waiting
> > in waiter.list. This sequence triggered an A-A deadlock, ultimately
> > leading to a hardlockup and system crash.
> > 
> > To prevent this, a local variable should be used to control and ensure
> > the print operation occurs only once.
> > 
> > Hard lockup call stack:
> > 
> > _raw_spin_lock_nested+168
> > ttwu_queue+180 （rq_lock(rq, &rf); 2nd acquiring the rq->__lock）
> > try_to_wake_up+548
> > wake_up_process+32
> > __up+88
> > up+100
> > __up_console_sem+96
> > console_unlock+696
> > vprintk_emit+428
> > vprintk_default+64
> > vprintk_func+220
> > printk+104
> > spectre_v4_enable_task_mitigation+344
> > __switch_to+100
> > __schedule+1028 (rq_lock(rq, &rf); 1st acquiring the rq->__lock)
> > schedule_idle+48
> > do_idle+388
> > cpu_startup_entry+44
> > secondary_start_kernel+352
> 
> Is the problem actually that we call the spectre v4 stuff on the
> switch_to() path (we can't change this) under the rq_lock() and it
> subsequently calls printk() which takes the console semaphore? I think
> the "once" aspect makes it less likely but does not address the actual
> problem.

Agreed; I think what we do here is structurally wrong, even if (in the
asbence of writes to the 'clear_warn_once' file) this happens to largely
do what we want today.

We really shouldn't print in accessors for kernel state.

> > diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> > index edf1783ffc81..f8663157e041 100644
> > --- a/arch/arm64/kernel/proton-pack.c
> > +++ b/arch/arm64/kernel/proton-pack.c
> > @@ -424,8 +424,10 @@ static bool spectre_v4_mitigations_off(void)
> >  	bool ret = cpu_mitigations_off() ||
> >  		   __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
> >  
> > -	if (ret)
> > -		pr_info_once("spectre-v4 mitigation disabled by command-line option\n");
> > +	static atomic_t __printk_once = ATOMIC_INIT(0);
> > +
> > +	if (ret && !atomic_cmpxchg(&__printk_once, 0, 1))
> > +		pr_info("spectre-v4 mitigation disabled by command-line option\n");
> >  
> >  	return ret;
> >  }
> 
> I think we should just avoid the printk() on the
> spectre_v4_enable_task_mitigation() path. Well, I'd remove it altogether
> from the spectre_v4_mitigations_off() as it's called on kernel entry as
> well. Just add a different way to print the status during kernel boot if
> there isn't one already, maybe an initcall.

I agree; I think we want to rip that out of spectre_v2_mitigations_off()
too.

We print a bunch of things under setup_system_capabilities(), so hanging
something off that feels like the right thing to do.

Mark.

