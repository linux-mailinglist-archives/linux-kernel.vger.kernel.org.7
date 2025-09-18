Return-Path: <linux-kernel+bounces-822340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D45B83953
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2957B1C02349
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FD2F531B;
	Thu, 18 Sep 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMJvnw7t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnUpVrH7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627582EE272
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185311; cv=none; b=pzkr/S/QY0NRO4sR8GYFsx82T1LXmZkF1+sJnfWJRiKDp/58phaoLLuWx8/qHEz44enZedDVJwI9P6F1Y+Z4obEVHIkaOpWDPM3DvjvWoq3OqbZwIlVVcUbIb8PLZHJtiaO3zbSVc4CPtgVprQM16jtmq+5YnJnfBfp9GVCOgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185311; c=relaxed/simple;
	bh=JBZR2fZceeb3s9Njcr5qRf9u/YvbodzQnBlr4vIzFys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRII6hFrWAl2brQKsJ0tJbpC/sbOTOncmU860AGrLDQbK1mrOPadVuksH40rkDrBWDF3U7yH1rnMBpDlPNcfG6zF0SVvX5IB1paL5KJqApujddWh3h/Su41hwM8afFE9CKuWhF7+DuP3tfMtAUPEPwmlzl9/+VDTLPQSKG7ih6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMJvnw7t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnUpVrH7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 10:48:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758185308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NovFkcDVYf3fWWfVdmD07cNejJYNvS+8SZukBGrwXpA=;
	b=UMJvnw7tiZL+wh09yBToLHDtDL90kX13No0ExrtQl+3EY/ze8xgLAgMsERf4qS8jdOXkZ7
	oxgp+16vwQNQ588n+AQOpNu/bvCaBpsHh2RrLRjqVvIDINfBe1ZrOi0oEgoa9r77kDtkN7
	hdgbx6fAFRa9RwmYwrz+XLgewSHDKgjBj0VLc4puD5yGQMgZA2zeEvis492h3cOsYg+S3H
	TZ//CW7P1vEa1qYJnBznmYll7XP9zBfA5ffYXF1EGvpl7FP2ZKvKkAplMxcyjYfh6U0+Vz
	WV80UlDKKIheOU6PbJ0RpSc312vj49Xe+XTkwSLWVn9v2vvSpad8TmAUk0JdPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758185308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NovFkcDVYf3fWWfVdmD07cNejJYNvS+8SZukBGrwXpA=;
	b=rnUpVrH7VLqgqPHwqBZcw1/2erH1AKrwHgZd1huwdHAkcgbLyJnSRkZEPRrNCsbs46vuhb
	OUG1H3/w667CjnAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: syzbot <syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com,
	juri.lelli@redhat.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	rppt@kernel.org, surenb@google.com, syzkaller-bugs@googlegroups.com,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in copy_process
Message-ID: <20250918084827.TWzT-hc4@linutronix.de>
References: <68cb1cbd.050a0220.2ff435.0599.GAE@google.com>
 <867144d3-b05e-4ce2-8bb6-da01e10fbd73@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <867144d3-b05e-4ce2-8bb6-da01e10fbd73@suse.cz>

On 2025-09-18 10:35:24 [+0200], Vlastimil Babka wrote:
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com
> > 
> > =====================================
> > WARNING: bad unlock balance detected!
> > syzkaller #0 Not tainted
> > -------------------------------------
> > syz.1.48/6865 is trying to release lock (&sighand->siglock) at:
> > [<ffff8000803b8634>] spin_unlock include/linux/spinlock.h:391 [inline]
> > [<ffff8000803b8634>] copy_process+0x22d4/0x31ec kernel/fork.c:2432
> 
> bad_fork_core_free:
>         sched_core_free(p);
>         spin_unlock(&current->sighand->siglock); <- here
> 
> Sebastian, I think it's your 7c4f75a21f63 ("futex: Allow automatic
> allocation of process wide futex hash") adding a "goto bad_fork_core_free;"
> from a place that doesn't yet have current->sighand->siglock locked?

Yes. Judging from -rc6, if futex_hash_allocate_default() fails we hold
neither siglock nor tasklist_lock. sched_core_free() looks also bad as
the cookie was allocated later in sched_core_fork(). sched_cgroup_fork()
does nothing special. So it should be

diff --git a/kernel/fork.c b/kernel/fork.c
index c4ada32598bd5..6ca8689a83b5b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2295,7 +2295,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (need_futex_hash_allocate_default(clone_flags)) {
 		retval = futex_hash_allocate_default();
 		if (retval)
-			goto bad_fork_core_free;
+			goto bad_fork_cancel_cgroup;
 		/*
 		 * If we fail beyond this point we don't free the allocated
 		 * futex hash map. We assume that another thread will be created

Sebastian

