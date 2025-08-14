Return-Path: <linux-kernel+bounces-767917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38AB25A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8396A7A4DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C831F582B;
	Thu, 14 Aug 2025 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fynBo/fu"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464488634A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145929; cv=none; b=SRwsiZj8eJh80mzhKa+7Aq4QF3PxDbRxv/Hov7MdI/Zw2QRVAeeaokKrro2bJRvojN9uFGU8RwEt2uCgUhiPidkDFslwnWmZmVkivhdfJWZtjYvanO4EsmiXGqr0+83XdRS9Wjpa0iulpXD2HZifO1dPs5IHs/vlk1huVnPzz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145929; c=relaxed/simple;
	bh=tAj9CD9gCRnCuc6SjjGpaEXGKg40Hb/52c6iE7ORNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlH+HoI/BmMHaWtwSm8KFZEa10EG/Yw525Z9I3PSuD4Bzods8wYmnv8/EOyoEaYaMgDOenuaoPXZGOhNmuQ9sX9l8ISt7RKnvvNX/fKfmTAEYI8XCPH8m6Cqi/cCp4IlWbVMatwaoosKpxhOswD0pZHJWLK16kaxFfrxgDxn0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fynBo/fu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7e7670b-c665-4938-aa38-5813e8e85b00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755145920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMm7OUmtL1cO3Lf9F5fm8DIlViztwnYoXoSxK0Wwk24=;
	b=fynBo/fu3JtkHYLNraOjvvpfpVtyCH7RIBWvbesOwA61LcB+aJVuZhrx/JgNIXLaSLUqjS
	ttZJ6H0lJ0AJGBCM/CRiTiveeYHJh94rVCi+n92bMED9h5TO8p8nczCrx5u8ptm0tFyXAH
	AHiUJL4jmLyj0KSWISPIOOnA80Mahbg=
Date: Thu, 14 Aug 2025 12:30:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hung_task: Skip hung task detection during core dump
 operations
Content-Language: en-US
To: "Nanji Parmar (he/him)" <nparmar@purestorage.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <CAEK+-Oe8GszRBDDF8jKAmVQNUEvgVqJYDp31P+mZTbqzneEZzA@mail.gmail.com>
 <20250813150155.81680178704c4652fd454a80@linux-foundation.org>
 <33f995c6-4db7-4e4c-ba12-eb5d05e8521c@linux.dev>
 <CAEK+-Od=j88QND5pZ-K_23fwmacy9enxogzNLxH4PjPYotDh9A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAEK+-Od=j88QND5pZ-K_23fwmacy9enxogzNLxH4PjPYotDh9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/14 11:31, Nanji Parmar (he/him) wrote:
> Hi Lance, Andrew,
> 
> Thanks for looking into this.
> After checking further, we found that the following patch fixed that 
> issue. Thank you once again.

Ah, I see. That's why I couldn't reproduce it on 6.16 kernel — the
fix was already there ;)

Thanks for digging this up!
Lance


> 
> commit b8e753128ed074fcb48e9ceded940752f6b1c19f
> Author: Paul E. McKenney <paulmck@kernel.org <mailto:paulmck@kernel.org>>
> Date:   Wed Jul 24 17:51:52 2024
> 
>      exit: Sleep at TASK_IDLE when waiting for application core dump
> 
>      Currently, the coredump_task_exit() function sets the task state
>      to TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.
>      But a combination of large memory and slow (and/or highly contended)
>      mass storage can cause application core dumps to take more than
>      two minutes, which can cause check_hung_task(), which is invoked by
>      check_hung_uninterruptible_tasks(), to produce task-blocked splats.
>      There does not seem to be any reasonable benefit to getting these 
> splats.
> 
>      Furthermore, as Oleg Nesterov points out, TASK_UNINTERRUPTIBLE could
>      be misleading because the task sleeping in coredump_task_exit() really
>      is killable, albeit indirectly.  See the check of signal->core_state
>      in prepare_signal() and the check of fatal_signal_pending()
>      in dump_interrupted(), which bypass the normal unkillability of
>      TASK_UNINTERRUPTIBLE, resulting in coredump_finish() invoking
>      wake_up_process() on any threads sleeping in coredump_task_exit().
> 
>      Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.
> 
>      Reported-by: Anhad Jai Singh <ffledgling@meta.com 
> <mailto:ffledgling@meta.com>>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org 
> <mailto:paulmck@kernel.org>>
>      Acked-by: Oleg Nesterov <oleg@redhat.com <mailto:oleg@redhat.com>>
>      Cc: Jens Axboe <axboe@kernel.dk <mailto:axboe@kernel.dk>>
>      Cc: Christian Brauner <brauner@kernel.org <mailto:brauner@kernel.org>>
>      Cc: Andrew Morton <akpm@linux-foundation.org <mailto:akpm@linux- 
> foundation.org>>
>      Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org 
> <mailto:willy@infradead.org>>
>      Cc: Chris Mason <clm@fb.com <mailto:clm@fb.com>>
>      Cc: Rik van Riel <riel@surriel.com <mailto:riel@surriel.com>>
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 7430852a8571..0d62a53605df 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -428,7 +428,7 @@ static void coredump_task_exit(struct task_struct *tsk)
>                          complete(&core_state->startup);
> 
>                  for (;;) {
> -                       set_current_state(TASK_UNINTERRUPTIBLE| 
> TASK_FREEZABLE);
> +                       set_current_state(TASK_IDLE|TASK_FREEZABLE);
>                          if (!self.task) /* see coredump_finish() */
>                                  break;
>                          schedule();
> 
> Thanks,
> Nanji
> 
> On Wed, Aug 13, 2025 at 8:12 PM Lance Yang <lance.yang@linux.dev 
> <mailto:lance.yang@linux.dev>> wrote:
> 
>     Hi Nanji,
> 
>     Thanks for your patch!
> 
>     On 2025/8/14 06:01, Andrew Morton wrote:
>      > On Wed, 13 Aug 2025 11:30:36 -0700 "Nanji Parmar (he/him)"
>     <nparmar@purestorage.com <mailto:nparmar@purestorage.com>> wrote:
>      >
>      >> Tasks involved in core dump operations can legitimately block for
>      >> extended periods, especially for large memory processes. The hung
>      >> task detector should skip tasks with PF_DUMPCORE (main dumping
>      >> thread) or PF_POSTCOREDUMP (other threads in the group) flags to
>      >> avoid false positive warnings.
>      >>
>      >> This prevents incorrect hung task reports during legitimate core
>      >> dump generation that can take xx minutes for large processes.
>      >
>      > It isn't pleasing to be putting coredump special cases into the
>     core of
>      > the hung-task detector.  Perhaps the hung task detector should get an
> 
>     Yeah, adding a special case for coredumps is not a good design ;)
> 
>      > equivalent to touch_softlockup_watchdog().  I'm surprised it doesn't
>      > already have such a thing.  Maybe it does and I've forgotten
>     where it is.
>      >
>      > Please provide a full description of the problem, mainly the relevant
>      > dmesg output.  Please always provide this full description when
>      > addressing kernel issues, thanks.
> 
>     Interestingly, I wasn't able to reproduce the hung task warning on my
>     machine with a SSD, even when generating a 100 GiB coredump. The process
>     switches between R and D states so fast that it never hits the timeout,
>     even with hung_task_timeout_secs set as low as 5s ;)
> 
>     So it seems this isn't a general problem for all coredumps. It look like
>     it only happens on systems with slow I/O, which can cause a process to
>     stay in a D-state for a long time.
> 
>     Anyway, any task *actually* blocked on I/O for that long should be
>     flagged;
>     that is the hung task detector's job, IMHO.
> 
>     Thanks,
>     Lance
> 
> 


