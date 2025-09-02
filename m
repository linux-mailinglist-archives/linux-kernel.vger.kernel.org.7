Return-Path: <linux-kernel+bounces-796960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE301B40A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFAF544CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D915321F3F;
	Tue,  2 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="U/2B39No"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5D2264C6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828903; cv=none; b=LptK0hw9k3yzBX9Qp//3d24rjxL7NE5AJVzj6HoQgk96RGd00CHTKKQQesk7lOvkVXfkqEjCGmd+sWK5nmgqZJSy5oCx00Rq3tITPPJaRCdbuxpzqgAkIjFE4vrFYVlEGMAEigJzCqW6IfJtwJiHpNvZaUZomgRQkSAt/EnvUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828903; c=relaxed/simple;
	bh=WPwnkCADAFqBZBB+NCarAyH2NuVqr+4VA69iZQddWaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l830gYiKSmC6aQJKJP0M3apaiGkhhcoxc709Faj+XfzWGfYClMQAHcB9Y5B9+LpdGoNt3rAaaGC6WH3NSy4lFOhyeS8vsowzl8ZG8I/zZ5IYB5UBKvRW/nLeuHvCTH/f3EqXztkMkXoqR3q1SbkqRF9CR8jczW2jWk0Hs1plrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=U/2B39No; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=ePrwZDq7iaPQ889D0c8BezIihziwKkN83oj/ujEEnJE=;
	b=U/2B39NofmVI66J9TxMYYpzNFsjV4TTuudDhk1PnZ1o9JE3/h0emTwmaNPyjlTiwaPVMePSRD
	c/2FxUyN0rRSTLTFP2M++O8NiydXUOk7w4A1fMmEG5fGXX2GAAOpDcgojy2VmHo+k4vZcNs8wId
	pIELLP+z0qgSDKqo79rBOgw=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cGVpl6f3gzYlSDN;
	Wed,  3 Sep 2025 00:01:19 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 00:01:34 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 00:01:33 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<fengbaopeng@honor.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <surenb@google.com>, <tglx@linutronix.de>,
	<tianxiaobin@honor.com>, <zhongjinji@honor.com>
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Wed, 3 Sep 2025 00:01:29 +0800
Message-ID: <20250902160129.13862-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aLWmf6qZHTA0hMpU@tiehlicka>
References: <aLWmf6qZHTA0hMpU@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

> > Sorry, I found that it doesn't work now (because I previously tested it by
> > simulating OOM, which made testing easier but also caused the mistake. I will
> > re-run the new test). Calling __thaw_task in mark_oom_victim will change the
> > victim's state to running. However, other threads are still in the frozen state,
> > so the process still can't exit. We should update it again by moving __thaw_task
> > to after frozen (this way, executing __thaw_task and frozen in the same function
> > looks more reasonable). Since mark_oom_victim and queue_oom_reaper always appear
> > in pairs, this won't introduce any risky changes.
> 
> Hmm, I must have completely forgot that we are actually thawing the
> frozen task! That means that the actual argument for not delaying the
> oom reaper doesn't hold.
> Now I do see why the existing implementation doesn't really work as you
> would expect though. Is there any reason why we are not thawing the
> whole process group? I guess I just didn't realize that __thaw_task is
> per thread rather than per process back then when I have introduced it.

Previously, I didn't know why we needed to call __thaw_task() in 
mark_oom_victim(). Now I understand.

> Because thread specific behavior makes very little sense to me TBH.
> So rather than plaing with __thaw_task placement which doesn't really
> make much sense wrt to delaying the reaper we should look into that
> part.
> 
> Sorry, I should have realized earlier when proposing that.

Is this modification acceptable?

This change only thaws the process previously identified as the victim,
and does not thaw the process being killed in for_each_process.

The reason is that the process being killed in for_each_process is usually
a vfork process, which is only temporary and rarely encountered.

@@ -772,12 +773,18 @@ static void mark_oom_victim(struct task_struct *tsk)
                mmgrab(tsk->signal->oom_mm);

        /*
-        * Make sure that the task is woken up from uninterruptible sleep
+        * Make sure that the process is woken up from uninterruptible sleep
         * if it is frozen because OOM killer wouldn't be able to free
         * any memory and livelock. freezing_slow_path will tell the freezer
-        * that TIF_MEMDIE tasks should be ignored.
+        * that TIF_MEMDIE thread should be ignored.
         */
-       __thaw_task(tsk);
+       rcu_read_lock();
+       for_each_thread(tsk, t) {
+               set_tsk_thread_flag(t, TIF_MEMDIE);
+               __thaw_task(t);
+       }
+       rcu_read_unlock();
+
        atomic_inc(&oom_victims);
        cred = get_task_cred(tsk);
        trace_mark_victim(tsk, cred->uid.val);

