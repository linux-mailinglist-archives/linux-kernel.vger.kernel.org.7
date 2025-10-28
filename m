Return-Path: <linux-kernel+bounces-874898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40679C17629
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BAB3BA6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648436A616;
	Tue, 28 Oct 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xzE135tJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EA2C21EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694752; cv=none; b=uNluG7XT5qLUPWERUz2j9x+vMD6UpH9zzoMb/Bjczhhqfj38aItEkB1REGxdACu5V4mRm6Ks+ZLQ5mNpwtQpAsZfqDiVxzdoZ7tZHCYD4K82Inh27imvEacfasCyVa1luALXwDuCFrHfjTiiyalriM9QAaeCwNg7+gUxY4hgolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694752; c=relaxed/simple;
	bh=5GOr6CFcvQVLTSWnlw4oFuFdRMFyQY3rQjMr0c6iFrI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=umVGQDOSApTWBRfHnVXVLoFWGKF0FNamkR1sAgTOcQF3vt42NO886rRJCv2AKK+kYNXML3RRlKhZZDFYI37N/kcxcTSdJAhb+PCwXAYaQXQ53CMGkKpsnub4GjasC/QSx/OonxxfrFRpAtPibO2d0Hld07JwhEDsJ6w8qoDr7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xzE135tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E54DC4CEE7;
	Tue, 28 Oct 2025 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761694751;
	bh=5GOr6CFcvQVLTSWnlw4oFuFdRMFyQY3rQjMr0c6iFrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xzE135tJWZlIHxt4/fZlEUeYUN/78QoOQOgFUmv/hi4tt2wkbjCOeUGqpGq8P1sV7
	 QNRW4QT3KseLxawe2K4W0JD+VBIeYbbrNp1BRP2BjB+aZMRffRuD5NiWo8j1Qq8IdJ
	 C0UfbpCZP1fR6QDTzILYHaFJS5h828cYbECq5Ivs=
Date: Tue, 28 Oct 2025 16:39:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Baoquan
 He <bhe@redhat.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider
 <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Joel Granados <joel.granados@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Stop all userspace deadline tasks
Message-Id: <20251028163911.98990cbf1516d1c6d221f92b@linux-foundation.org>
In-Reply-To: <20251028030914.9520-3-piliu@redhat.com>
References: <20251028030914.9520-1-piliu@redhat.com>
	<20251028030914.9520-3-piliu@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 11:09:14 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> Now that the deadline bandwidth check has been skipped, there is nothing
> to prevent CPUs from being unplugged. But as deadline tasks are crowded
> onto the remaining CPUs, they may starve normal tasks, especially the
> hotplug kthreads. As a result, the kexec process will hang indefinitely.
> 
> Send SIGSTOP to all userspace deadline tasks at the beginning of kexec
> to allow other tasks to run as CPUs are unplugged.

This all looks a bit hacky.

What's special about kexec?  If many CPUs are being unplugged via other
means, won't the kernel still hit the very problems which are being
addressed here for kexec?  If so, we should seek a general fix for these
issues rather than a kexec-specific one?

> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1132,6 +1132,18 @@ bool kexec_load_permitted(int kexec_image_type)
>  	return true;
>  }
>  
> +static void stop_user_deadline_tasks(void)
> +{
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	for_each_process(task) {
> +		if (task->policy == SCHED_DEADLINE && task->mm)
> +			send_sig(SIGSTOP, task, 1);
> +	}
> +	rcu_read_unlock();
> +}

If we can safely stop all SCHED_DEADLINE user tasks then presumably we
can safely stop all user tasks.  Why not do that?

>  /*
>   * Move into place and start executing a preloaded standalone
>   * executable.  If nothing was preloaded return an error.
> @@ -1190,6 +1202,11 @@ int kernel_kexec(void)
>  		cpu_hotplug_disable();
>  		kexec_in_progress = true;
>  		cpu_hotplug_enable();
> +		/*
> +		 * As CPU hot-removal, the crowed deadline task may starve other
> +		 * tasks. So stop them.
> +		 */
> +		stop_user_deadline_tasks();
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
>  		syscore_shutdown();
y

