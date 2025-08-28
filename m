Return-Path: <linux-kernel+bounces-790027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F000FB39E64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E81A013A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C29312831;
	Thu, 28 Aug 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="iEEf0NFR"
Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FC3112CF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386821; cv=none; b=s5NuH5ndas2690s20DpDXCXOKaMREjHknJOsyu1yAOQ3yCi+SE6uLJ6rJOV6tEGXjn78cNiQyCApCRteIm9Tb4hn3AhBEDEcsltOzBgMYW0GPVBUzaajTolcW09qV0MrvS9awPcLMmVz6gnBwRzEBPJ+cDoGYMUXAXSO87s3GBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386821; c=relaxed/simple;
	bh=W67vRk3Q8pM7hN4ZC5rVtOQfnvj6ISoOcTncs2HvPSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U38bEsOezaX0NHneL3l4bHm+P04mqtQOOFX2kLLtCJnqVfeU5fakMWlk7TwNrOAvokAmqqGGUiX08dUPl28u0y2tOIq0vT0TEHjotDKBFCaKwKRRi5W/zbnE48s2d4qHPHfgqmhEtgTj/oWaUNDCRC4Od0KU/KpaVe6wSimfue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=iEEf0NFR; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756386812;
	bh=UfczMGMfameg5t5XspoijThbHapqSsEAVcgmCYwa720=;
	h=From:Subject:Date:Message-ID;
	b=iEEf0NFRTbKm3G7AUg1arFRxB5q9FtqDXm7eEW+VHtrjo7RAgpu842Ab6p9VpkWDJ
	 FyWz2cAZDCuk6mlYDF0Ri/9AGVs2xHg6UkWrKR0NW7ExMIBtXxqDuxRGoz6w3KjKc+
	 lef82MyFNIYpEL8ujvNpV/tyWvvwTzqM+W748n6A=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68B055CD000035C2; Thu, 28 Aug 2025 21:12:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7291006685211
X-SMAIL-UIID: 1F1ACEAFEED84F25A86B1A630A3B358E-20250828-211247-1
From: Hillf Danton <hdanton@sina.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in copy_process
Date: Thu, 28 Aug 2025 21:12:34 +0800
Message-ID: <20250828131235.6007-1-hdanton@sina.com>
In-Reply-To: <04adff83-3771-4a51-95bc-cc11bb169e35@redhat.com>
References: <68abd1c8.050a0220.37038e.0083.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 17:50:15 +0200 David Hildenbrand wrote:
> On 25.08.25 05:00, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    41cd3fd15263 Merge tag 'pci-v6.17-fixes-2' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13d8b3bc580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
> > dashboard link: https://syzkaller.appspot.com/bug?extid=69c74d38464686431506
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ea83f558e101/disk-41cd3fd1.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a35b75cdd97b/vmlinux-41cd3fd1.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/37d76e9636c2/bzImage-41cd3fd1.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+69c74d38464686431506@syzkaller.appspotmail.com
> > 
> > oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0-1,oom_memcg=/syz1,task_memcg=/syz1,task=syz.1.3237,pid=23388,uid=0
> > Memory cgroup out of memory: Killed process 23388 (syz.1.3237) total-vm:101828kB, anon-rss:940kB, file-rss:21532kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:1000
> 
> Here we are killing 23388 (syz.1.3237)
> 
> > ------------[ cut here ]------------
> > pvqspinlock: lock 0xffff88803512c0c0 has corrupted value 0x0!
> > WARNING: CPU: 0 PID: 23388 at kernel/locking/qspinlock_paravirt.h:504 __pv_queued_spin_unlock_slowpath+0x237/0x330 kernel/locking/qspinlock_paravirt.h:504
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 23388 Comm: syz.1.3237 Tainted: G     U              syzkaller #0 PREEMPT(full)
> 
> And here we are still in the process ...
> 
> > Tainted: [U]=USER
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> > RIP: 0010:__pv_queued_spin_unlock_slowpath+0x237/0x330 kernel/locking/qspinlock_paravirt.h:504
> > Code: 03 0f b6 14 02 4c 89 e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 67 41 8b 55 00 4c 89 ee 48 c7 c7 00 81 ad 8b e8 fa aa e6 f5 90 <0f> 0b 90 90 e9 64 ff ff ff 90 0f 0b 48 89 df 4c 89 04 24 e8 71 15
> > RSP: 0018:ffffc9000e9c79c8 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: ffff88803512c0c0 RCX: ffffffff817a02c8
> > RDX: ffff88802fa9bc00 RSI: ffffffff817a02d5 RDI: 0000000000000001
> > RBP: ffff88803512c0c8 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 00000000000d4550 R12: ffff88803512c0d0
> > R13: ffff88803512c0c0 R14: 00000000003d0f00 R15: ffff88802ab43c00
> > FS:  0000555568154500(0000) GS:ffff8881246c4000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f86cc8e86ec CR3: 0000000060c0e000 CR4: 00000000003526f0
> > Call Trace:
> >   <TASK>
> >   __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
> >   .slowpath+0x9/0x18
> >   pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:562 [inline]
> >   queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
> >   do_raw_spin_unlock+0x172/0x230 kernel/locking/spinlock_debug.c:142
> >   __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
> >   spin_unlock include/linux/spinlock.h:391 [inline]
> 
> ... busy during clone.
> 
> I assume that it is 23388 calling clone() and not getting cloned (it 
> should not get scheduled yet).
> 
> So likely, the OOM is shooting something down that kernel_clone() still 
> depends on ... maybe?
> 
Difficult to understand the oom shot given tasklist_lock held for write
also in release_task(), weird.

