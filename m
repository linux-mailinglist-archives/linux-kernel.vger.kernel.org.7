Return-Path: <linux-kernel+bounces-824436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D22B89342
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A47A9D66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8429309EE7;
	Fri, 19 Sep 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="p4tCX+ub"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024227E041
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280252; cv=none; b=MaavRDODmrysB12IrI2dsg+b4ZqC4SWQugAGfeZDqYZziZXJvc8ZMnMnUNGWsvTTAb73X8jr8o5Rvu/4yNwuMCODnw7iLBzbg2hk/Gp1FyUXrkrhq+JKl36LMRLWGgKO4ZHqX9uOtyz44/NyioITP/S4g0yJ8Q0+hHJ5z146GFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280252; c=relaxed/simple;
	bh=qgSI/SizjNc6NOgvWEGFvsBJ2fPLeO8XzcDKOukhT08=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PQFv71lG4fesMxlWpUS5D0FCG2edfODtVuMp+M7mCrsvbuGEknJZApZXp5lmO0Mua6xvNz5FbgG1G3n9j3OhMRyfWtQbcsA/M5BrBzj18Au7+4O4Yth/vpUhyrX6+Uc4TgI4HC8EUQoDBFYOayiaVqramrP2NQpe/os7D9wRf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=p4tCX+ub; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ibydpGMGio6n4lyZbcEK3dMQYodU+nVYshvyrSrOyw8=; b=p4tCX+ubB88ADNRYWyUlFGx77r
	j/tEGiD9No647ej0tPBs9mDWr6ap93kMjkiQDYSVEUh9xZ/NXWlA+uOKvYD6xzJ6oVlIaqyOG2Kld
	tzFQlAR+oPd+krfxhjGK0+f/4M5QwDf7s/ypMwfun9ZoB4HiOkCcDI4dc2xSciVEbaYH+owxZ/Iyp
	BlMWMumNZJMFkWemS96Jkr79y3AuIjS5WkW/5dIZtiCUyU1XtoX/BDZosvJHbI/67+AUTgTfWjvS7
	hGEzmo3pp5RRzs/Bqn90X/6KkoMqDVikIAOojXwdhGawb01r1ADVn9ZVK2E0udmXG0ylFN5VyfySj
	xTHF1VaA==;
Received: from [167.98.27.226] (helo=[10.35.4.166])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uzZ0c-001qi1-AD; Fri, 19 Sep 2025 12:10:34 +0100
Message-ID: <3308bca2-624e-42a3-8d98-48751acaa3b3@codethink.co.uk>
Date: Fri, 19 Sep 2025 12:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: BUG/WARN issues in kernel/sched/rt.c under stress-ng with crgoup-v2
Organization: Codethink Limited.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

We are doing some testing with stress-ng and the cgroup-v2 enabled
(CONFIG_RT_GROUP_SCHED) and are running into WARN/BUG within a minute
related to user-space calling sched_setattr() and possibly other calls.

At the moment we're not sure if the WARN and BUG calls are entirely
correct, we are considering there may be some sort of race condition
which is causing incorrect assumptions in the code.

We are seeing this kernel bug in pick_next_rt_entity being triggered

	idx = sched_find_first_bit(array->bitmap);
	BUG_ON(idx >= MAX_RT_PRIO);

Which suggests that the pick_task_rt() ran, thought there was something
there to schedule and got into pick_next_rt_entity() which then found
there was nothing. It does this by checking rq->rt.rt_queued before it
bothers to try picking something to run.

(this BUG_ON() is triggered if there is no index in the array indicating
  something there to run)

We added some debug to find out what the values in pick_next_rt_entity()
with the current rt_queued and the value it was when pick_task_rt()
looked, and we got:

    idx 100 bigger than MAX_RT_PRIO 100, queued = 0 (queued was 1)

This shows the code was entered with the rt_q showing something
should have been queued and by the time the pick_next_rt_entity()
was entered there seems to be nothing (assuming the array is in
sync with the lists...)

I think the two questions we have are:

- Is the BUG_ON() here appropriate, should a WARN_ON_ONCE() and
   return NULL be the best way of handling this? I am going to try
   this and see if the system is still runnable with this.

- Are we seeing a race here, and if so where is the best place to
   prevent it?

Note, we do have a few local backported cgroup-v2 patches.

Our systemd unit file to launch the test is here:

[Service]
Type=simple
Restart=always
ExecStartPre=/bin/sh -c 'echo 500000 > 
/sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
ExecStartPre=/bin/sh -c 'echo 500000 > 
/sys/fs/cgroup/system.slice/stress-sched-long-system.service/cpu.rt_runtime_us'
ExecStart=sandbox-run /usr/bin/stress-ng --temp-path /tmp/stress-ng 
--timeout=0 --verify --oom-avoid --metrics --timestamp 
--exclude=enosys,usersyscall --cpu-sched 0 --timeout 60 --verbose 
--stressor-time
Environment=SANDBOX_RO_BINDMOUNTS="/usr/share/stress-ng"
Environment=SANDBOX_RW_BINDMOUNTS="/var/log /sys /proc /dev /tmp/stress-ng"
Environment=SANDBOX_EXTRA_ARGS="--cwd /tmp/stress-ng --keep_caps 
--disable_rlimits --disable_clone_newuser"
Slice=system.slice
OOMPolicy=continue

I added this to dump the array and confirm at-least the array-v-list
was in sync at the point of the bug:

static inline void debug_pick_next(struct rt_rq *rt_rq, int idx, 
unsigned qs)
{
	struct rt_prio_array *array = &rt_rq->active;
	unsigned int nr;

	pr_err("rt_q %px: idx %d bigger than MAX_RT_PRIO %d, queued = %d (was 
%u)\n",
	       rt_rq, idx, MAX_RT_PRIO, rt_rq->rt_queued, qs );

	for (nr = 0; nr < MAX_RT_PRIO; nr += sizeof(array->bitmap[0])*8) {
		pr_info("  bitmap idx %u: %lx\n", nr, 
array->bitmap[nr/(sizeof(array->bitmap[0])*8)]);
	}

	// check that the bitmap and array match
	for (nr = 0; nr < MAX_RT_PRIO; nr += 1) {
		bool l_empty = list_empty(array->queue + nr);
		bool a_empty = !test_bit(nr, array->bitmap);

		if (l_empty != a_empty) {
			pr_err(" bitmap idx %u: array %s, bitmask %s\n", nr,
			       a_empty ? "empty" : "full",
			       l_empty ? "empty" : "full");
		}
	}
}
	


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html



