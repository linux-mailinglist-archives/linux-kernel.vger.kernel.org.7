Return-Path: <linux-kernel+bounces-822823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9230B84BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C8D17A0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB73308F15;
	Thu, 18 Sep 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTX6KrkY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tdOkm30R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39AF215077
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200991; cv=none; b=GQ/XsZt3U0v+IS8cy17SFXW6IrEXd6LeyAee28/t8QljaS5uoFbn8FfyVfU+BTArQZGzX7nPWVXpuOmVbmiqxsR0SIYd93/iwNtIu2Cti0YMxhPVQNNQ7v0BCn7DCKcVZWCIiulj0XU4SAI+y6JK7810Sg/8dHiFTl/Ic6nVd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200991; c=relaxed/simple;
	bh=t6xibxhhT/0whJwLDLf/oVWhpayhunfw21S8biaanP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+RzpVkJXtBf0aYvf4VPzjpMYGCIGvXWUzIYtx4rV8LZ0g9fZC/xAy3xHtdEhtEvZ2nUb56iz0IZdcEE9wOHEjk4sNTIjrqm2vR/+JBk7jCYXKO5hKeG645drFo9Z43QPx03lQEi4C4pkCAOht+ocWr9k0NcB9Q6aY3zI2ZbxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTX6KrkY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tdOkm30R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 15:09:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758200987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0J+w7XlEgDChzOKAEy+PX0pTTOKKOEyFY5Vzd9kDbSY=;
	b=zTX6KrkYmVroC46eQBs3JS5bEyH8szRWeWSvGOPCS91GmIK/n8BTlP/39L082XQ7+2bRgu
	tBCITLfJ89+m5XCmKBpl0L1R4/zCwGnNa7KDSe0Cxwwgto/zhhO3OsOQ5ZE5ci9Ed5sRIo
	R5eyi5pdeMxlgLKNZMzDbM0dwQRRbv1licZtdsTbhWHwinj5DEkTnjzXN5geCN3L8u7ifg
	oUxwfaCLfGIjg5HJDAxOFdG1mereO6jZGQ1D4C3ywdoWJx33GzoHS7q/LYEO+SCjd8aegJ
	A36gcub6kEP7n5ou5foc6cXbKyfAoskNiiAX2LJxi00URilmx05eBMPXcGunMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758200987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0J+w7XlEgDChzOKAEy+PX0pTTOKKOEyFY5Vzd9kDbSY=;
	b=tdOkm30Rs9bK/JvdJRMJpwNr3FGqtWbyjXpEQeZSi+EXIHZA6mWA82YEhYGLuIt3vVXwzo
	VX6Zt1sm+LzjNQAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: syzbot <syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com,
	juri.lelli@redhat.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	rppt@kernel.org, surenb@google.com, syzkaller-bugs@googlegroups.com,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: [PATCH] futex: Use correct exit on failure from
 futex_hash_allocate_default()
Message-ID: <20250918130945.-7SIRk8Z@linutronix.de>
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

copy_process() uses the wrong error exit path from
futex_hash_allocate_default().
After exiting from futex_hash_allocate_default(), neither tasklist_lock
nor siglock has been acquired. The exit label bad_fork_core_free unlocks
both of these locks which is wrong.

The previous label, bad_fork_cancel_cgroup, is the correct exit.
sched_cgroup_fork() did not allocate any resources that need to freed.

Use bad_fork_cancel_cgroup on error exit from
futex_hash_allocate_default().

Fixes: 7c4f75a21f636 ("futex: Allow automatic allocation of process wide futex hash")
Reported-by: syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68cb1cbd.050a0220.2ff435.0599.GAE@google.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

That private-futex code was marked BROKEN in v6.16 and re-enabled in
v6.17. It could use
  56180dd20c19e ("futex: Use RCU-based per-CPU reference counting instead of rcuref_t")

as Fixes: instead to avoid backporting to v6.16.

 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.51.0


