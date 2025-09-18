Return-Path: <linux-kernel+bounces-822631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31DB845A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8044A8597
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDEA30496A;
	Thu, 18 Sep 2025 11:28:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68236303A3E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194889; cv=none; b=YsXqwtMEAN5fKccOYbTs32APT2jXnYnfzWd1WPhfvaaRrPDnnRsIEH2NXgU4HB4qHF8d73vqWaSk3tFC/vI0fhIu+bej+RS5W5cTCNFsMwkEQCWULnZAvNxl2W9y0gjWnALLOsisSQkw5pdYY+ueREDgqPimYWX2JrCjZ9O3MqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194889; c=relaxed/simple;
	bh=hq+bGyb564QEovQdWqRvrGIRd5MAH79oTofRW4U38uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2BKnM0Nl7TLVloidpWiqVx8LEqiXMwHQRtMjW28ly99m9c4KPgb+gj394lNmNt8s4S92B33fj+gdAO8O7uoS85FGly+YKKlWBIDYsmQRmiL2WnS+GkbDbVkEOHOQvuRG7q9ysBW6h/0ibjBtDNOb/6D+407UJjYB14ZakeWQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E27C4CEE7;
	Thu, 18 Sep 2025 11:28:07 +0000 (UTC)
Date: Thu, 18 Sep 2025 12:28:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: shechenglong <shechenglong@xfusion.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
	chenjialong@xfusion.com, yuxiating@xfusion.com
Subject: Re: [PATCH] cpu: fix hard lockup triggered during stress-ng stress
 testing.
Message-ID: <aMvsxd8nHb5roC0o@arm.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918064907.1832-1-shechenglong@xfusion.com>

On Thu, Sep 18, 2025 at 02:49:07PM +0800, shechenglong wrote:
> Context of the Issue:
> In an ARM64 environment, the following steps were performed:
> 
> 1. Repeatedly ran stress-ng to stress the CPU, memory, and I/O.
> 2. Cyclically executed test case pty06 from the LTP test suite.
> 3. Added mitigations=off to the GRUB parameters.
> 
> After 1–2 hours of stress testing, a hardlockup occurred,
> causing a system crash.
> 
> Root Cause of the Hardlockup:
> Each time stress-ng starts, it invokes the /sys/kernel/debug/clear_warn_once
> interface, which clears the values in the memory section from __start_once
> to __end_once. This caused functions like pr_info_once() — originally
> designed to print only once — to print again every time stress-ng was called.
> If the pty06 test case happened to be using the serial module at that same
> moment, it would sleep in waiter.list within the __down_common function.
> 
> After pr_info_once() completed its output using the serial module,
> it invoked the semaphore up() function to wake up the process waiting
> in waiter.list. This sequence triggered an A-A deadlock, ultimately
> leading to a hardlockup and system crash.
> 
> To prevent this, a local variable should be used to control and ensure
> the print operation occurs only once.
> 
> Hard lockup call stack:
> 
> _raw_spin_lock_nested+168
> ttwu_queue+180 （rq_lock(rq, &rf); 2nd acquiring the rq->__lock）
> try_to_wake_up+548
> wake_up_process+32
> __up+88
> up+100
> __up_console_sem+96
> console_unlock+696
> vprintk_emit+428
> vprintk_default+64
> vprintk_func+220
> printk+104
> spectre_v4_enable_task_mitigation+344
> __switch_to+100
> __schedule+1028 (rq_lock(rq, &rf); 1st acquiring the rq->__lock)
> schedule_idle+48
> do_idle+388
> cpu_startup_entry+44
> secondary_start_kernel+352

Is the problem actually that we call the spectre v4 stuff on the
switch_to() path (we can't change this) under the rq_lock() and it
subsequently calls printk() which takes the console semaphore? I think
the "once" aspect makes it less likely but does not address the actual
problem.

> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index edf1783ffc81..f8663157e041 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -424,8 +424,10 @@ static bool spectre_v4_mitigations_off(void)
>  	bool ret = cpu_mitigations_off() ||
>  		   __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
>  
> -	if (ret)
> -		pr_info_once("spectre-v4 mitigation disabled by command-line option\n");
> +	static atomic_t __printk_once = ATOMIC_INIT(0);
> +
> +	if (ret && !atomic_cmpxchg(&__printk_once, 0, 1))
> +		pr_info("spectre-v4 mitigation disabled by command-line option\n");
>  
>  	return ret;
>  }

I think we should just avoid the printk() on the
spectre_v4_enable_task_mitigation() path. Well, I'd remove it altogether
from the spectre_v4_mitigations_off() as it's called on kernel entry as
well. Just add a different way to print the status during kernel boot if
there isn't one already, maybe an initcall.

-- 
Catalin

