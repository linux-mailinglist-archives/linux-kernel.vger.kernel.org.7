Return-Path: <linux-kernel+bounces-823133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7CB8597E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90CA4A1C22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924A30DEC8;
	Thu, 18 Sep 2025 15:29:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261927F728
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209364; cv=none; b=ffK3PdFxAS7gzT2a2oH0FRQRac3TnJSLaXvHavK9fqaRfgGARPP3rLoGyVS0/BMNfVMaaPJ2ZwG/8oxZJFNKYBHsicY0WXdJRntXKtCGNM/oTVXra4Zlat8msSJDwS2/QoFOzzWeSESYiPZEJxcI26rufOeN4t6ZeyGAvq7/ml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209364; c=relaxed/simple;
	bh=sDMDXNY1hWb9fsZOcN2pIaFGdr46kYiycsZq7EIn0Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fo635qRoSvedLAcENH4Ib4m4NfyjnOuoWMxuC9Sb7EhbdDOY7W7BvOZfJgXc7C9qlJmanUwdZJ6i4DGfmgbs0hCosm1mayVuf+I9zkvLwGuEwYVFHC6B6eDwaU+1Z4kj8ojvUxQO/3vqNqGdW4xaYW48gYILndEody1uDw77mbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 159DB57397;
	Thu, 18 Sep 2025 15:29:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 8923330;
	Thu, 18 Sep 2025 15:29:14 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:30:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, syzbot
 <syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, bsegall@google.com,
 david@redhat.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 kees@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, rppt@kernel.org, surenb@google.com,
 syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org,
 vschneid@redhat.com
Subject: Re: [PATCH] futex: Use correct exit on failure from
 futex_hash_allocate_default()
Message-ID: <20250918113022.1b97d977@gandalf.local.home>
In-Reply-To: <20250918130945.-7SIRk8Z@linutronix.de>
References: <68cb1cbd.050a0220.2ff435.0599.GAE@google.com>
	<867144d3-b05e-4ce2-8bb6-da01e10fbd73@suse.cz>
	<20250918130945.-7SIRk8Z@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5k3m8kciftd13nqeeizubc5uj35nansc
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8923330
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+TTPLGd6WX6aq3rap/uZBpfrnji4VecK0=
X-HE-Tag: 1758209354-859747
X-HE-Meta: U2FsdGVkX1/urWqjcd2GFQknJ54dZpoXNJwoQqbuoC0perxLalFSrYy7kgiLvkmLA8YVWi6aGxg4bBNLTzGZ8BkLZKhgn9VtkWHRwcN81nmT7hUTth99wPdPbHq7dUSpNOz+uBYU2BNyfLKGy1dXqjXZOEVcOyod3Tr3ctFjSjm3MW3hmYF5b+bl4i5c0vn9qdPhJKlKV2i0Ye/HVqkXMEOf66vD1KSjP8pdk4bbLvaVSpLGYPTmtofZnOoGL+yjgmBQznEKfyXoRbdo9ewufM62EB/SNVcAYkZnlp3lEgQAkB0JHKhXkJu/EtzJc187JPtT99aGZfZ8/EgOZVKW3odD+3YZZo2ZFvlrRcPHinZFtq/qKaBaW7r5dgdn4v7AV9j9nqKyiVpRW5LhzEibPOnyGCg/Va5B0PpgX//V24mdY22wZpJiDkhxalHzhvS2JJ+qs9MiKKSt8xQDs0kDWGDyLzEjOZJPumDQxRLTGbw=

On Thu, 18 Sep 2025 15:09:45 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> copy_process() uses the wrong error exit path from
> futex_hash_allocate_default().
> After exiting from futex_hash_allocate_default(), neither tasklist_lock
> nor siglock has been acquired. The exit label bad_fork_core_free unlocks
> both of these locks which is wrong.
> 
> The previous label, bad_fork_cancel_cgroup, is the correct exit.
> sched_cgroup_fork() did not allocate any resources that need to freed.
> 
> Use bad_fork_cancel_cgroup on error exit from
> futex_hash_allocate_default().

	if (need_futex_hash_allocate_default(clone_flags)) {
		retval = futex_hash_allocate_default();
		if (retval)
			goto bad_fork_core_free;
		[..]
	}
	[..]
	write_lock_irq(&tasklist_lock);
	[..]
	klp_copy_process(p);

	sched_core_fork(p);

	spin_lock(&current->sighand->siglock);

	[..]

 bad_fork_core_free:
	sched_core_free(p);
	spin_unlock(&current->sighand->siglock);
	write_unlock_irq(&tasklist_lock);
 bad_fork_cancel_cgroup:
	cgroup_cancel_fork(p, args);

Yep, looks bad to me!

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> 
> Fixes: 7c4f75a21f636 ("futex: Allow automatic allocation of process wide futex hash")
> Reported-by: syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68cb1cbd.050a0220.2ff435.0599.GAE@google.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>

