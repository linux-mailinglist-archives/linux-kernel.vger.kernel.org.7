Return-Path: <linux-kernel+bounces-754714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6FDB19B49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8BF1770AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E92288C6;
	Mon,  4 Aug 2025 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FPj/Jepz"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659C1F3FDC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287476; cv=none; b=u77tAIU/YyyQ79vbQtJs8862VCf3loARaKPyJMjafA0snBEizVEfT1bsGVNqt6C8P8MtAnPHWdUQwKL9aHlkZuoBR0ejJwMcm7DL5WiiNMAyC9QbyYdmGFXLCXq0MYcRunhfA+6egKXIJ1eZ3AZFgDC8OJ/vEEJG3fmwGwhymoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287476; c=relaxed/simple;
	bh=z6RXGnJic0GWtivBVWdbyc91Vd/9cmLtkNlRA9pWXVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUirRNWRI4Vrkr5m269cjOWfCwkHoh07S4Fa0jvK/P0+7C/oF0IF8z7ivmqIhLsAwksxOGGzGAu+ipCNNhOEBUdIpDz4lBocO/wx2ngE6aIyJ3VlbgSDzwTAt99EIqS0cdvpzNf4MT0sr9TVihWZp7ulkvJWUHo4JcSBz5TS3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FPj/Jepz; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso15956515e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754287472; x=1754892272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSRLbZH+ywoLvwHXORH5c+0524CP0mry4togVdem3jU=;
        b=FPj/JepzdnEn6elh2+0fGXCQrScmOQTQz9P4WYYowRIABaAm6rcPVCxofzqQbF1ZpC
         P7WNJbpwMgD/fmeRspZHq38A4E5RWxhcI8nn8UKsaJQ8myRAxZcIcP+4HTZOyDhmwoUw
         dZfO74woNghye0d1U6BfCAhAUa81wRfS7Bpbo8zpcIGVCotoDOT/9GvPouUPEyXmHEH7
         3XlOrJ0Ah6KKJjgkCNDyE1UNO/9TJAQUKPWr9jFBS0KWKuoDZnPzRcSdv9JoFZFY6iLJ
         kiN/mrtzHSGtJtPok0AuyYFSPAoZnDvzceHkkOty7x4QRxGb9IX6R/GJEluDOhiDTyjM
         aP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287472; x=1754892272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSRLbZH+ywoLvwHXORH5c+0524CP0mry4togVdem3jU=;
        b=VCYwJvwSUly2OElQ9O2YW5C/8vK8nQPhq/qF42EygSbjHb5i7yNjY1E1ppe+U8aa+W
         JrpDi3vxJFqItLcERY2yUhWFQR7CPTrxd+9dzCyLE8vLB4Yl+IGlf+acIrrgYY32zizE
         f6ueM5TloVs0PKApjxfEG3D5Io6wkSIMP6pozlPIOnNWvkw64/RWtPJYV9WHnQoK0GaM
         Iypr3vRezFaEyS8Vr1Eu2whBVBEv/mHjro6RFrs3kOzm9gQn4LBnJzKyvvymbLKHjDXb
         sPz/gYMdXYCpy47T++zF1SzLDYte2eq6B3mM2a9iD76fEdK1wRLl+FFwsTipH1hxqOHr
         RiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWviEFBvSOJCrDFIOChB6eFE/un+W1OEV3GMZZUlwJ+WRk+kgd48msLqIBC2XmDOw2pN1Dr75aqVRNQUOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwOFpxVR4q2M5itV8cghQI8kh82bvnCLbhl1n7DLridixhAly
	TjI5osXxHWkOyXzC5KoKowkBfk9aGUtbfVSesWOi6OUoii+W2Dn1QJegBDDQZjgobq0=
X-Gm-Gg: ASbGnctdoMsC+ults0ydsRaHxef3yq+U/1BYxKSlCvPb4mPp7G0mbnbwWJqyQp0ZInJ
	eTx1GX3syXFs7EGVih7/tyBW8NJJ7Rastode0ZRFX8IW5swzqPFH9ZO7X6nasE4OVYt/TwXNa5x
	fkA5z8Yq6viS5l96+fkaunAowXPJ2dD1xjb+TQXTJIpWMmvS378aGnnHauXDS7WfE1lIAWt0xA4
	gROP3w86+5Di0rMuueK5GN0AyRIPF/FlyYc4Gml6j7vGeAWTTXzUwOYYJw6mnnYr1x6f+NuZ9b/
	9RJfeSSxhGOgn/P2qOEfaXQpeEd2X6GtJoCCAa05BDBMbeI8r5LHqFtPwmIm3euS8n6agT5jm/u
	wdKsgSiUh/0bo7H0UwKqFOhFJ+pVmLlycfzjfaizz9CA=
X-Google-Smtp-Source: AGHT+IGV4z76ItAlYSJtArOu2dhPWvUpQD//brr8fTRiDvDErvYBsQksalTenrcg8flqyPReDXASDw==
X-Received: by 2002:a05:600c:35c6:b0:459:d709:e5cf with SMTP id 5b1f17b1804b1-459d709e8b1mr24094045e9.3.1754287471695;
        Sun, 03 Aug 2025 23:04:31 -0700 (PDT)
Received: from localhost (109-81-86-79.rct.o2.cz. [109.81.86.79])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459de91ea4csm2379665e9.10.2025.08.03.23.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:04:31 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:04:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji@honor.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
	shakeel.butt@linux.dev, npache@redhat.com,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v3 2/2] mm/oom_kill: Only delay OOM reaper for processes
 using robust futex
Message-ID: <aJBNbnNWa5KLciOq@tiehlicka>
References: <20250804030341.18619-1-zhongjinji@honor.com>
 <20250804030341.18619-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804030341.18619-2-zhongjinji@honor.com>

I have only noticed this now. Did you have any reason to repost v3
without any prior feedback on v2 and without any changelog from v2?

On Mon 04-08-25 11:03:41, zhongjinji@honor.com wrote:
> From: zhongjinji <zhongjinji@honor.com>
> 
> After merging the patch
> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
> the OOM reaper runs less frequently because many processes exit within 2 seconds.
> 
> However, when a process is killed, timely handling by the OOM reaper allows
> its memory to be freed faster.
> 
> Since relatively few processes use robust futex, delaying the OOM reaper for
> all processes is undesirable, as many killed processes cannot release memory
> more quickly.
> 
> This patch modifies the behavior so that only processes using robust futex
> are delayed by the OOM reaper, allowing the OOM reaper to handle more
> processes in a timely manner.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  mm/oom_kill.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..c558ac93ae7d 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -30,6 +30,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/timex.h>
>  #include <linux/jiffies.h>
> +#include <linux/futex.h>
>  #include <linux/cpuset.h>
>  #include <linux/export.h>
>  #include <linux/notifier.h>
> @@ -692,7 +693,7 @@ static void wake_oom_reaper(struct timer_list *timer)
>   * before the exit path is able to wake the futex waiters.
>   */
>  #define OOM_REAPER_DELAY (2*HZ)
> -static void queue_oom_reaper(struct task_struct *tsk)
> +static void queue_oom_reaper(struct task_struct *tsk, bool delay)
>  {
>  	/* mm is already queued? */
>  	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> @@ -700,7 +701,7 @@ static void queue_oom_reaper(struct task_struct *tsk)
>  
>  	get_task_struct(tsk);
>  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	tsk->oom_reaper_timer.expires = jiffies + (delay ? OOM_REAPER_DELAY : 0);
>  	add_timer(&tsk->oom_reaper_timer);
>  }
>  
> @@ -742,7 +743,7 @@ static int __init oom_init(void)
>  }
>  subsys_initcall(oom_init)
>  #else
> -static inline void queue_oom_reaper(struct task_struct *tsk)
> +static inline void queue_oom_reaper(struct task_struct *tsk, bool delay)
>  {
>  }
>  #endif /* CONFIG_MMU */
> @@ -871,11 +872,12 @@ static inline bool __task_will_free_mem(struct task_struct *task)
>   * Caller has to make sure that task->mm is stable (hold task_lock or
>   * it operates on the current).
>   */
> -static bool task_will_free_mem(struct task_struct *task)
> +static bool task_will_free_mem(struct task_struct *task, bool *delay_reap)
>  {
>  	struct mm_struct *mm = task->mm;
>  	struct task_struct *p;
>  	bool ret = true;
> +	bool has_robust = !delay_reap;
>  
>  	/*
>  	 * Skip tasks without mm because it might have passed its exit_mm and
> @@ -888,6 +890,15 @@ static bool task_will_free_mem(struct task_struct *task)
>  	if (!__task_will_free_mem(task))
>  		return false;
>  
> +	/*
> +	 * Check if a process is using robust futexes. If so, delay its handling by the
> +	 * OOM reaper. The reason is that if the owner of a robust futex lock is killed
> +	 * while waiters are still alive, the OOM reaper might free the robust futex
> +	 * resources before futex_cleanup runs, causing the waiters to wait indefinitely.
> +	 */
> +	if (!has_robust)
> +		has_robust = check_robust_futex_rcu(task);
> +
>  	/*
>  	 * This task has already been drained by the oom reaper so there are
>  	 * only small chances it will free some more
> @@ -912,8 +923,12 @@ static bool task_will_free_mem(struct task_struct *task)
>  		ret = __task_will_free_mem(p);
>  		if (!ret)
>  			break;
> +		if (!has_robust)
> +			has_robust = check_robust_futex(p);
>  	}
>  	rcu_read_unlock();
> +	if (delay_reap)
> +		*delay_reap = has_robust;
>  
>  	return ret;
>  }
> @@ -923,6 +938,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	struct task_struct *p;
>  	struct mm_struct *mm;
>  	bool can_oom_reap = true;
> +	bool delay_reap;
>  
>  	p = find_lock_task_mm(victim);
>  	if (!p) {
> @@ -950,6 +966,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	 * reserves from the user space under its control.
>  	 */
>  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
> +	delay_reap = check_robust_futex_rcu(victim);
>  	mark_oom_victim(victim);
>  	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
>  		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
> @@ -990,11 +1007,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
> +		if (!delay_reap)
> +			delay_reap = check_robust_futex(p);
>  	}
>  	rcu_read_unlock();
>  
>  	if (can_oom_reap)
> -		queue_oom_reaper(victim);
> +		queue_oom_reaper(victim, delay_reap);
>  
>  	mmdrop(mm);
>  	put_task_struct(victim);
> @@ -1020,6 +1039,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	struct mem_cgroup *oom_group;
>  	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
>  					      DEFAULT_RATELIMIT_BURST);
> +	bool delay_reap = false;
>  
>  	/*
>  	 * If the task is already exiting, don't alarm the sysadmin or kill
> @@ -1027,9 +1047,9 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	 * so it can die quickly
>  	 */
>  	task_lock(victim);
> -	if (task_will_free_mem(victim)) {
> +	if (task_will_free_mem(victim, &delay_reap)) {
>  		mark_oom_victim(victim);
> -		queue_oom_reaper(victim);
> +		queue_oom_reaper(victim, delay_reap);
>  		task_unlock(victim);
>  		put_task_struct(victim);
>  		return;
> @@ -1112,6 +1132,7 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
>  bool out_of_memory(struct oom_control *oc)
>  {
>  	unsigned long freed = 0;
> +	bool delay_reap = false;
>  
>  	if (oom_killer_disabled)
>  		return false;
> @@ -1128,9 +1149,9 @@ bool out_of_memory(struct oom_control *oc)
>  	 * select it.  The goal is to allow it to allocate so that it may
>  	 * quickly exit and free its memory.
>  	 */
> -	if (task_will_free_mem(current)) {
> +	if (task_will_free_mem(current, &delay_reap)) {
>  		mark_oom_victim(current);
> -		queue_oom_reaper(current);
> +		queue_oom_reaper(current, delay_reap);
>  		return true;
>  	}
>  
> @@ -1231,7 +1252,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	mm = p->mm;
>  	mmgrab(mm);
>  
> -	if (task_will_free_mem(p))
> +	if (task_will_free_mem(p, NULL))
>  		reap = true;
>  	else {
>  		/* Error only if the work has not been done already */
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs

