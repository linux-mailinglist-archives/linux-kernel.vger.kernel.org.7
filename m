Return-Path: <linux-kernel+bounces-898535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D28C557BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9AF3ABBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816725BEE8;
	Thu, 13 Nov 2025 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G5hvBHHs"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1211D5ADE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002605; cv=none; b=hP+OC8Z42mkZMztyIfiSs7CvZrIglqi3zMSPAVMWDeGBZeDSm3VcKgvNd1468deqOAF2oEwPo5IMJ2tTaV0ow3FOLBuH5K4CNpdW9gGqTQma8k3fsuBsKhC6LImCreXWIbeqcUknwStckdP2JeA5/Tzx2KNyV/QvrLt5E/hCLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002605; c=relaxed/simple;
	bh=vLEC2Am+CDtV22e79x4SPFh9xlzlojQcqOmFTn97dss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC/FRtxujoBiXU081O0oGx/CMZPpzRIyLelMmHKqlYURVvk5d0PWIzsj/wSQL3Iru0ynBSO7l2n3Dsii8R9Cm8sSLzYHXmnAVWX61AYMDdu2611odzoN6507E1mQaPXdIT15/+wZkdLzAQNKBuuu2+xxqz6X73+1FVyxtUsYIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G5hvBHHs; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763002593; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=F10jQ81Ni4Ig5lLyxePhfoy372DFJGVyjVx60FeIlgs=;
	b=G5hvBHHs2Y4oVZf9lbRBzO+w6Ao/4LrVPJBqfxRFxn5wv29lV96YDDy3ULSKCf6LnVl5810x9tLw33jnxjORmBnkhJk9W/tIUrV7O3H0Z2W2n7PMw4TJ9lGquRilMxWvKKxpqBLMN7iwphXxGrFX95lg6uycpEeM9L/wfzsUugk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsHq27B_1763002592 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 10:56:33 +0800
Date: Thu, 13 Nov 2025 10:56:32 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
Message-ID: <aRVI4EcFu83Lx3TE@U-2FWC9VHC-2323.local>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
 <aRInLdgKCzaVeyG0@pathway.suse.cz>
 <aRRupyzGaP5Z35qE@U-2FWC9VHC-2323.local>
 <aRSdOfA3bgvCzdfH@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRSdOfA3bgvCzdfH@pathway.suse.cz>

On Wed, Nov 12, 2025 at 03:44:09PM +0100, Petr Mladek wrote:
> On Wed 2025-11-12 19:25:27, Feng Tang wrote:
> > On Mon, Nov 10, 2025 at 06:55:57PM +0100, Petr Mladek wrote:
> > > On Thu 2025-11-06 10:30:31, Feng Tang wrote:
> > [...]
> > > @@ -315,8 +295,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> > >  {
> > >  	int max_count = sysctl_hung_task_check_count;
> > >  	unsigned long last_break = jiffies;
> > > +	unsigned long total_hung_task;
> > >  	struct task_struct *g, *t;
> > >  	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
> > > +	unsigned long si_mask;
> > >  
> > >  	/*
> > >  	 * If the system crashed already then all bets are off,
> > > @@ -325,6 +307,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> > >  	if (test_taint(TAINT_DIE) || did_panic)
> > >  		return;
> > >  
> > > +	si_mask = hung_task_si_mask;
> > > +	if (sysctl_hung_task_warnings || hung_task_call_panic) {
> > > +		si_mask |= SYS_INFO_LOCKS;
> > > +
> > > +		if (sysctl_hung_task_all_cpu_backtrace)
> > > +			si_mask |= SYS_INFO_ALL_BT;
> > > +	}
> > 
> > This probably needs to be moved to after the loop check of
> > check_hung_task(). 
> 
> I did it on purpose because "sysctl_hung_task_warnings" might get
> decremented down to "0" in the loop below. But IMHO, we need to print
> the information if it was non-zero at the beginning.
> 
> It might be worth to add a comment why it has to be done
> before the cycle.
 
I see your point. Yes, that could happen and should be handled.

My concern was:
1. 'hung_task_call_panic' is actually set in the following loop of 
   checking, and should be checked after the loop
2. when 'sysctl_hung_task_warnings' is not 0 (likely), the
	si_mask |= SYS_INFO_LOCKS
  will make it always call sys_info() will non-zero value, while the
  'hung_task_si_mask' could be pre-set. I just run a simple hung task
  test and can confirm this.

So I made some small changes based on your patches, please help to
review.

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 5f0275b2c742..5b3a7785d3a2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -71,12 +71,6 @@ static struct task_struct *watchdog_task;
  */
 static unsigned long hung_task_si_mask;
 
-/*
- * There are several sysctl knobs, and this serves as the runtime
- * effective sys_info knob
- */
-static unsigned long cur_si_mask;
-
 #ifdef CONFIG_SMP
 /*
  * Should we dump all CPUs backtraces in a hung task event?
@@ -229,11 +223,8 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
 }
 #endif
 
-static void check_hung_task(struct task_struct *t, unsigned long timeout,
-		unsigned long prev_detect_count)
+static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
-	unsigned long total_hung_task;
-
 	if (!task_is_hung(t, timeout))
 		return;
 
@@ -243,21 +234,13 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 	 */
 	sysctl_hung_task_detect_count++;
 
-	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
-	cur_si_mask = hung_task_si_mask;
-	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
-		console_verbose();
-		cur_si_mask |= SYS_INFO_LOCKS;
-		hung_task_call_panic = true;
-	}
-
 	/*
 	 * Ok, the task did not get scheduled for more than 2 minutes,
 	 * complain:
 	 */
-	if (sysctl_hung_task_warnings || hung_task_call_panic) {
+	if (sysctl_hung_task_warnings) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -272,10 +255,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout,
 			" disables this message.\n");
 		sched_show_task(t);
 		debug_show_blocker(t, timeout);
-		cur_si_mask |= SYS_INFO_LOCKS;
 
-		if (sysctl_hung_task_all_cpu_backtrace)
-			cur_si_mask |= SYS_INFO_ALL_BT;
 		if (!sysctl_hung_task_warnings)
 			pr_info("Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings\n");
 	}
@@ -315,8 +295,11 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
+	unsigned long total_hung_task;
 	struct task_struct *g, *t;
 	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
+	int need_warning = sysctl_hung_task_warnings;
+	unsigned long si_mask = hung_task_si_mask;
 
 	/*
 	 * If the system crashed already then all bets are off,
@@ -325,6 +308,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (test_taint(TAINT_DIE) || did_panic)
 		return;
 
+
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
 
@@ -336,16 +320,29 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 
-		check_hung_task(t, timeout, prev_detect_count);
+		check_hung_task(t, timeout);
 	}
  unlock:
 	rcu_read_unlock();
 
-	if (unlikely(cur_si_mask)) {
-		sys_info(cur_si_mask);
-		cur_si_mask = 0;
+	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
+	if (!total_hung_task)
+		return;
+
+	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
+		console_verbose();
+		hung_task_call_panic = true;
 	}
 
+	if (need_warning || hung_task_call_panic) {
+		si_mask |= SYS_INFO_LOCKS;
+
+		if (sysctl_hung_task_all_cpu_backtrace)
+			si_mask |= SYS_INFO_ALL_BT;
+	}
+
+	sys_info(si_mask);
+
 	if (hung_task_call_panic)
 		panic("hung_task: blocked tasks");
 }

Thanks,
Feng

