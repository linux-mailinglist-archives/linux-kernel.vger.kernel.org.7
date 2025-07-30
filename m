Return-Path: <linux-kernel+bounces-750804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767BDB16131
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8884E49D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328C298CC4;
	Wed, 30 Jul 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="PI779EIV"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3A29827E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881253; cv=none; b=X/gQLcqfe/zU5dlBGwVdqmg5sRxIyeqrDQdjeRaw9LUYBwtMdnCjeWb7QrEyCN0qvbzqURz606Sxc80v8Cu5+NS5nHlClvGZNN4lZQFWe3m94jDsY69RMFS4q7xl8xjGSC/BbXgET7GdNEwirIxkOz8/gnR61Icc8oEZJzq7a0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881253; c=relaxed/simple;
	bh=8nkgal3AIaXczY5z99W/HkPcv+g+U7dayeXCbOAYDks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpFw2mr8AlHJe3gN840YM3BuMh/tOZArcqcTu4IFzWIE7mjudxp6t2nbs0B5C9KYIxbVIRIoawKNKNT084SIsx7dAGNNAFcVirKM8BDvsCyAcTlEcywSJXNM7oFqpqWJtq2WkED5Xlk/bMpr0ctiv01bvtr+zJwAu8TKZ3J196g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=PI779EIV; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753881245;
	bh=z5dhJmX+9OjAgm/uNX1/FlLd/cNgHlyqaAP65twpnO0=;
	h=From:Subject:Date:Message-ID;
	b=PI779EIVAEw7aJ80rKnpKSa6R1y1aPGxgxum8nRaTm77LZOFR0xQJnEtW1xGoNN1q
	 B5ERXY1J0N2f7+u73huaTQ4vrfkzzrOK6PwCZ+jjAPE8Cvpz0L+L/8BWcZ7PnxtOkY
	 NFBo+cXDpk3bJYNtlBfFH+XW5rGh+YshBW5QRPk0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 688A1A920000044B; Wed, 30 Jul 2025 21:13:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2460526816259
X-SMAIL-UIID: F5B70426B811491AB650D5663F35F1C1-20250730-211356-1
From: Hillf Danton <hdanton@sina.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	syzbot <syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs@googlegroups.com,
	Valentin Schneider <valentin.schneider@arm.com>,
	John Stultz <jstultz@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [syzbot] [dri?] WARNING in __ww_mutex_wound
Date: Wed, 30 Jul 2025 21:13:44 +0800
Message-ID: <20250730131345.3530-1-hdanton@sina.com>
In-Reply-To: <61b68b13-2482-499b-a550-a11580a61e9d@amd.com>
References: <68894443.a00a0220.26d0e1.0015.GAE@google.com> <8ab72592-7e16-4d79-9e26-f98a1938cb2a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 15:20:39 +0530 K Prateek Nayak wrote:
> On 7/30/2025 1:57 PM, Maarten Lankhorst wrote:
> > Hey,
> > 
> > This warning is introduced in linux-next as a4f0b6fef4b0 ("locking/mutex: Add p->blocked_on wrappers for correctness checks")
> > Adding relevant people from that commit.
> > 
> > Kind regards,
> > ~Maarten
> > 
> > Den 2025-07-29 kl. 23:59, skrev syzbot:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    d086c886ceb9 Add linux-next specific files for 20250718
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=161204a2580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=69896dd7b8c4e81e
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=602c4720aed62576cd79
> >> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fff4f0580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111204a2580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/54504fbc2437/disk-d086c886.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/b427b00abffe/vmlinux-d086c886.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/5a87731b006b/bzImage-d086c886.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com
> >>
> >> ------------[ cut here ]------------
> >> WARNING: ./include/linux/sched.h:2173 at __clear_task_blocked_on include/linux/sched.h:2173 [inline], CPU#1: syz.1.8698/395
> >> WARNING: ./include/linux/sched.h:2173 at __ww_mutex_wound+0x21a/0x2b0 kernel/locking/ww_mutex.h:346, CPU#1: syz.1.8698/395
> >> Modules linked in:
> >> CPU: 1 UID: 0 PID: 395 Comm: syz.1.8698 Not tainted 6.16.0-rc6-next-20250718-syzkaller #0 PREEMPT(full) 
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> >> RIP: 0010:__clear_task_blocked_on include/linux/sched.h:2173 [inline]
> >> RIP: 0010:__ww_mutex_wound+0x21a/0x2b0 kernel/locking/ww_mutex.h:346
> 
> When wounding the lock owner, could it be possible that the lock
> owner is blocked on a different nested lock? Lock owner implies it
> is not blocked on the current lock we are trying to wound right?
> 
> I remember John mentioning seeing circular chains in find_proxy_task()
> which required this but looking at this call-chain I'm wondering if
> only the __ww_mutex_check_waiters() (or some other path) requires
> __clear_task_blocked_on() for that case.
> 
It is buggy to read and clear owner->blocked_on without
owner->blocked_on->wait_lock held, no?

