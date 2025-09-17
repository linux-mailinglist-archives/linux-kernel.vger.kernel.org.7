Return-Path: <linux-kernel+bounces-819924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACEB7FA57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7332A35E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A92F3C22;
	Wed, 17 Sep 2025 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYMJUlLy"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DC1D7E41
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079759; cv=none; b=FKmyK7POJ2FZv0fNBvm7CFkJqetux8sukErH5LnoJgZEjR39UBEmbuWzBKzlRFIxNX5NuzjofRVciSMaJiEkenBZaQDjF9OOjWLaybHuEWhvjVfyq7bA9K9vTeL32Z0ylLmyr4XBNIzd4PZhkZqVs6sDSJb1wjpNyAPuMmHUTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079759; c=relaxed/simple;
	bh=N3JfVah2P6XQPN4lz77tBvAHJXrDFSUZNEmxFiuW8Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU+d9yPDyRCWDusGOSGpUt6QfcnnTNyRvjIfrHSwzcReDVIQw6XsC0NdEc28TF04gvHAQOYn/DqxDF2X7Rp2FjLuxWzPIEXPyppZbdGQUDlbUKC8Le4bmHXa2foThIc8vc3y4JeaiRq57Qn9xfDXbp5ir6f558EptJVPuZk/9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYMJUlLy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5607c2f1598so7011325e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758079754; x=1758684554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcpWUIr1iLGYih9SljEBhD+HhzbTpTNlOZj3vDSjgeM=;
        b=KYMJUlLysD3niVVByho0FhOUPvsSapYAWVxjOC434oIRNA1gqNqCePe3ll5NyKKZhF
         P3Xag7XmB6AltY0KVjETj+IREuPaAS8CbjvkIGaOtrxqKNjTQ1q0pCQn/tnrmfSXr8GY
         BESyx/KpxCSr62i68cy7abllVG+0nOPVaGrnk9kiZCS+Fl9QBIw56Aa9/WV0UDQyGhHT
         JfwkQHu+reReVJdCu1Pt7SL5FxfHW44plSBWHnsCtSt3XB/8uGOngeBZeMV9LHYLCulM
         d9YaBlRhyFt6yVUYOwKqVk5GZp5NSLe74mBLPCAEquN5VdfxD9/071gO0JG0vfZv1aQY
         owdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079754; x=1758684554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcpWUIr1iLGYih9SljEBhD+HhzbTpTNlOZj3vDSjgeM=;
        b=v8W5fqEKqAgA7L7Z5+tzXDkXW/QMPitejeDNdNZjrp5QEROBlCXwq/pGT9DE2cE6sq
         7Zm5CWa1TMXNwQZEhNAhk43f0sSDmEmZGwPDFBTSxscgavccKUGzzZVhpZXki8DYr3wl
         kXEFZeb+3GS7lBz5vSqG9N6RYuHn60yrpeMak5h6qdcKnBwScyMaV2ww+Yk03qr3XuA5
         8bgU2nOk9eK6J93rBcKEHnm3zXorgZiU5ceTZmS4FFPHuyiM4lQgPWU6UcFJKpQlgNa7
         tMgLaiMR6JbZluoFhdBuESa9kcqzVxHA4BlrBShbuJNDHg27hdG2KTjRADdLfhHDQHuq
         9N5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu51emx927kwyJQHWtVUnD+PFmQ3QjsUIMuFOf4ImoYAuVw20HYLKB3Y/Z+/xDp//ZW7gjSbKcI1YTVMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNxQfx26x4FbV7j079wX8h6Ghw+sgdEig1Xofc+90GWxitGgU
	i3aGUKqCcwqovmktZsW7rJvu1zjFzgzyO/l9+4APWMSPAlGJCKBQbKqbRjqJQtXHxmhjV0Mjb2C
	e44nxXUjN2GyLD50za3pnYKzb9Jx6spU0FiTWm9M=
X-Gm-Gg: ASbGncunVztx53QCkqImYeLx4Lwwtk5mGEnmwW0OeCdMPfY0ECj7cgtiAcf1julV+hR
	mNrxCi0tgpwWpwljdcc437z848NykB80C346QKb0Z9OkRaboSdnA5t0fbATWu4nDcbGs9DaRIjZ
	pYGDz43UblDaxGQRDVNHIlrSVwnTeeKmZNwFOPjU4NLPdXaPwOXOfQ623MvhqSdC+G0zSnGa/pH
	KiFs72KgErbH3CNMTQKkA4qSFgcqc8vNp1b/n/pxwU=
X-Google-Smtp-Source: AGHT+IHvdK6YJxJ14DmmoPlrCIACrpjbO8WYwtjNhRIdVFhwRVCMJLqH6ycTr3Nz9g0eC7R87YcBGArVaTHmbz4RtU4=
X-Received: by 2002:a05:6512:2205:b0:569:a257:c6d6 with SMTP id
 2adb3069b0e04-5779a470e5cmr145658e87.49.1758079754046; Tue, 16 Sep 2025
 20:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com> <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com> <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
In-Reply-To: <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Tue, 16 Sep 2025 20:29:01 -0700
X-Gm-Features: AS18NWBHUeA_rL6s1DRuniVFHWpsmvyQJtxXIDkDm_Xw6ZxYEv0pKI25raWouFw
Message-ID: <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Suleiman Souhlal <suleiman@google.com>, Qais Yousef <qyousef@layalina.io>, 
	Joel Fernandes <joelagnelf@nvidia.com>, kuyo chang <kuyo.chang@mediatek.com>, 
	hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:30=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Tue, Sep 16, 2025 at 10:35:46AM -0700, John Stultz wrote:
> > I of course still see the thread spawning issues with my
> > ksched_football test that come from keeping the dl_server running for
> > the whole period, but that's a separate thing I'm trying to isolate.
>
> So what happens with that football thing -- you're saying thread
> spawning issues, so kthread_create() is not making progress?
>
> You're also saying 'keeping the dl_server running for the whole period',
> are you seeing it not being limited to its allocated bandwidth?
>
> Per the bug today, the dl_server does get throttled, not sufficiently?

So yeah, I think this is a totally different issue than the lockup
warning problem, and again, I suspect my test is at least partially
culpable.

You can find my test here:
https://github.com/johnstultz-work/linux-dev/commit/d4c36a62444241558947e22=
af5a972a0859e031a

The idea is we first start a "Referee" RT prio 20 task, and from that
task we spawn NR_CPU  RT prio 5 "Offense players" which just spin
incrementing a value ("the ball"), then NR_CPU RT prio 10 "Defense
players" that just spin (conceptually blocking the Offense players
from running on the cpu). Once everyone is running, the ref zeros the
ball and sleeps for a few seconds. When it wakes it checks the ball is
still zero and shuts the test down.

So the point of this test is very much for the defense threads to
starve the offense from the cpu.  In doing so, it is helpful for
validating the RT scheduling invariant that we always (heh, well...
ignoring RT_PUSH_IPI, but that's yet a different issue) run the top
NR_CPU RT priority tasks across the cpus. So it inherently stresses
rt-throttling as well.

Note: In the test there are also RT prio 15 "crazy-fans" that sleep,
but occasionally wake up and "streak across the field" trying to
disrupt the game, as well as low priority defense players that take
either proxy-mutex or rt_mutexes that the high priority defense
threads try to aquire to ensure proxy-exec & priority inheritance
boosting is working - but these can be mostly ignored for this
problem.

Each time the ref spawns a player type, we go from lowest to highest
priority, calling kthread_create(), sched_setattr_nocheck() and then
wake_up_process(), for NR_CPUs, and then the Ref repeatedly sleeps
waiting for NR_CPU tasks to check-in (incrementing a player counter).

The problem is that previously the tasks were spawned without much
delay, but after your change, we see each RT tasks after the first
NR_CPU take ~1 second to spawn. On systems with large cpu counts
taking NR_CPU*player-types seconds to start can be long enough (easily
minutes) that we hit hung task errors.

As I've been digging, part of the issue seems to be kthreadd is not an
RT task, thus after we create NR_CPU spinner threads, the following
threads don't actually start right away. They have to wait until
rt-throttling or the dl_server runs, allowing kthreadd to get cpu time
and start the thread.  But then we have to wait until throttling stops
so that the RT prio Ref thread can run to set the new thread as RT
prio and then spawn the next, which then won't start until we do
throttling again, etc.

So it makes sense if the dl_server is "refreshed" once a second, we
might see this one thread per second interlock happening.  So this
seems likely just an issue with my test.

However, prior to your change, it seemed like the the RT tasks would
be throttled, kthreadd would run and the thread would start, then with
no SCHED_NORMAL tasks to run, the dl_server would stop and we'd run
the Ref, which would immediately eneueued kthreadd, which started the
dl_server and since the dl_server hadn't done much, I'm guessing it
still had some runtime/bandwidth and would run kthreadd then stop
right after.

So now my guess (and my apologies, as I really am not familiar enough
the the DL details) is that since we're not stopping the dl_server, it
seems like the dl_server runtime gets used up each cycle, even though
it didn't do much boosting. So we have to wait the full cycle for a
refresh.

I've used a slightly modified version of my test (simplifying it a bit
and adding extra trace annotations) to capture the following traces:

New behavior: https://ui.perfetto.dev/#!/?s=3D663e6a8f4f0ecdbc2bbde3efdc601=
dc980f7b333
This shows the clear 1 second delay interlock with kthreadd for each
thread after the first two, creating a clear stair-step pattern.

Old behavior: https://ui.perfetto.dev/#!/?s=3D3d6a70716c6a66eb8d7056ef2c640=
838404186c2
This shows how there's a 1 second delay after the first two threads
spawn, but then the rest of the created threads quickly interleave
with kthreadd, allowing them to start off quickly

I still need to add some temporary trace events around the dl_server
so I can better understand how that interleaving used to work. As it
may have been just luck that my test worked back then.

However, interestingly if we go back to 6.11, before the dl_server
landed, it's curious because I do see the 1 second stair steps, but
with larger cpu counts there seems to be more of them working in
parallel, so each second, the ref will manage to interlock with
kthreadd 4 to 8 times, and that many of threads will start up.  So its
behavior isn't exactly like either the new or old behavior with
dl_server, but it escaped hitting the hung task errors.

But as the new dl_server logic is much slower for spawning rt threads,
I probably need to find a new way to start my test. But I just want to
raise the issue in case others hit similar problems with the change.

thanks
-john

