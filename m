Return-Path: <linux-kernel+bounces-794224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7BB3DE91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B86F7A9F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E72FB97E;
	Mon,  1 Sep 2025 09:31:13 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BA2EE5FD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719073; cv=none; b=bk7Dj3gDBJs0kdT4sAh7Drrw/37c1D/J2mtsoCKbFkYvWFQComppUZ0CWwUQKCgLLEZT/08sBJ11V7OcHnoCgEPc1dZv48ESvWlgZUrEWknOxmRyTvdefLZWxi8k8oe3/td75qixrfbk9G6R2mxVjreEE32VG0jWgmQwoiHasr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719073; c=relaxed/simple;
	bh=Z+x20DiDkSdmgOsq6mc9hU/YUC1XW3a/mmfGz6xIrZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0HzOGCEB+rRmFMip9dDwWzyspJ7YPLzSk3nWSETRzHEmwas/ICTY5Gv0Y3EYoCQ61/78w6rVkyK/m6Izcie3XDbugFP0wpc+jzJBFRTYdz/G75QhLM1XqA7zia1cS4A1W3/X6PZ041eKeShugCciuKGvvlxnjFJUqkBPcvooyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cFkBT61rLzYlFMN;
	Mon,  1 Sep 2025 17:30:41 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Sep
 2025 17:31:01 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Sep
 2025 17:31:01 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<fengbaopeng@honor.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <surenb@google.com>, <tglx@linutronix.de>,
	<tianxiaobin@honor.com>, <zhongjinji@honor.com>
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Mon, 1 Sep 2025 17:30:57 +0800
Message-ID: <20250901093057.27056-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aLVKYz6C5bXYG1v3@tiehlicka>
References: <aLVKYz6C5bXYG1v3@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

> On Fri 29-08-25 14:55:49, zhongjinji wrote:
> > The oom reaper is a mechanism to guarantee a forward process during OOM
> > situation when the oom victim cannot terminate on its own (e.g. being
> > blocked in uninterruptible state or frozen by cgroup freezer). In order
> > to give the victim some time to terminate properly the oom reaper is
> > delayed in its invocation. This is particularly beneficial when the oom
> > victim is holding robust futex resources as the anonymous memory tear
> > down can break those. [1]
> > 
> > On the other hand deliberately frozen tasks by the freezer cgroup will
> > not wake up until they are thawed in the userspace and delay is
> > effectively pointless. Therefore opt out from the delay for cgroup
> > frozen oom victims.
> > 
> > Reference:
> > [1] https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
> > 
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks

Sorry, I found that it doesn't work now (because I previously tested it by
simulating OOM, which made testing easier but also caused the mistake. I will
re-run the new test). Calling __thaw_task in mark_oom_victim will change the
victim's state to running. However, other threads are still in the frozen state,
so the process still can't exit. We should update it again by moving __thaw_task
to after frozen (this way, executing __thaw_task and frozen in the same function
looks more reasonable). Since mark_oom_victim and queue_oom_reaper always appear
in pairs, this won't introduce any risky changes.

 static void queue_oom_reaper(struct task_struct *tsk)
 {
+       bool delay = !frozen(tsk);
+
+       /*
+        * Make sure that the task is woken up from uninterruptible sleep
+        * if it is frozen because OOM killer wouldn't be able to free
+        * any memory and livelock. freezing_slow_path will tell the freezer
+        * that TIF_MEMDIE tasks should be ignored.
+        */
+       __thaw_task(tsk);
+
        /* mm is already queued? */
        if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
                return;
@@ -711,7 +721,7 @@ static void queue_oom_reaper(struct task_struct *tsk)
         * If the task is frozen by the cgroup freezer, the delay is unnecessary
         * because it cannot exit until thawed. Skip the delay for frozen victims.
         */
-       if (!frozen(tsk))
+       if (delay)
                tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
        add_timer(&tsk->oom_reaper_timer);
 }
@@ -783,13 +793,6 @@ static void mark_oom_victim(struct task_struct *tsk)
        if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
                mmgrab(tsk->signal->oom_mm);

-       /*
-        * Make sure that the task is woken up from uninterruptible sleep
-        * if it is frozen because OOM killer wouldn't be able to free
-        * any memory and livelock. freezing_slow_path will tell the freezer
-        * that TIF_MEMDIE tasks should be ignored.
-        */
-       __thaw_task(tsk);
        atomic_inc(&oom_victims);
        cred = get_task_cred(tsk);
        trace_mark_victim(tsk, cred->uid.val);

> 
> > ---
> >  mm/oom_kill.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..a5e9074896a1 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -700,7 +700,14 @@ static void queue_oom_reaper(struct task_struct *tsk)
> >  
> >  	get_task_struct(tsk);
> >  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> > -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> > +	tsk->oom_reaper_timer.expires = jiffies;
> > +
> > +	/*
> > +	 * If the task is frozen by the cgroup freezer, the delay is unnecessary
> > +	 * because it cannot exit until thawed. Skip the delay for frozen victims.
> > +	 */
> > +	if (!frozen(tsk))
> > +		tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
> >  	add_timer(&tsk->oom_reaper_timer);
> >  }
> >  
> > -- 
> > 2.17.1

