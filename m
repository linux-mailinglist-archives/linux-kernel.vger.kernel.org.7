Return-Path: <linux-kernel+bounces-887582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACC8C38A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F279518822DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337581DFE26;
	Thu,  6 Nov 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yb8xCoCE"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F991D432D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390902; cv=none; b=a3/txqfeRhoyuvvwp8N58yBp48vHT/YXDBqCVHCWvGrdKxaPS7gq4EfU27/n4XRPnTIyVE8KOuuFSe5a9h4I9HYi52YFEAnbUVbDkoAMW0i2ZVK6PNEnK/JNjdNeAqZd0PVI3PoUNBio8txykx4t0PKloH9p6Gb2UHHbNnHj6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390902; c=relaxed/simple;
	bh=xpG9Zav16fud/P52o1Y9zAwELbKSECPWkC24FTEbdjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq6gYyIUHL+kyIF2BLZ0h0q5W87MXIsZLwqK6vqB18HFZPXX1Kv8vkqLWNo3fbXs42duwzIcUkDfHB9hrqOXulAXvSLt+Vh/bdVchIIreJwwkYJ5pgK5cPOwX1PFyqcino2f75Umk4j2nltXyIvdukdKNwa15A0EI7MNrB/nQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yb8xCoCE; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 17:01:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762390897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQfdmpUSD1hX31VIG1OBvzN1GUZmtq8PPgwQWApEGTY=;
	b=Yb8xCoCENlLsywjcHKAPc/SaG8taUl44Z7xyNOa7KDVduX7lD6mFZo4pR12UEFqGNP0FgC
	kOEb4ZIp5VPvRfgv9bncZkNhu6VlQYo+stYzk5CVbmmRmd0o4pucmEpxHsb7x7mFGsN9YR
	3e4FaPql+KWMRO6ivC18HHG3Jpkn/h0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: syzbot <syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com, 
	Kairui Song <kasong@tencent.com>
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg (2)
Message-ID: <fcikaqlrbqzc6utdbd3utgkkw52474l2hom5lzpbmh6wsvbb3n@tpex3btkz34q>
References: <690b99ab.050a0220.baf87.0057.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690b99ab.050a0220.baf87.0057.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

+Kairui

On Wed, Nov 05, 2025 at 10:38:35AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ba36dd5ee6fd Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16515704580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=c5b060ce82921a2fd500
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/62471ef815ed/disk-ba36dd5e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e7a72af6e621/vmlinux-ba36dd5e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/352eec7dbce0/bzImage-ba36dd5e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13908 at mm/list_lru.c:100 lock_list_lru_of_memcg+0x30c/0x4c0 mm/list_lru.c:100

This is VM_WARN_ON(!css_is_dying(&memcg->css)) in
lock_list_lru_of_memcg(). It is unexpected as it can only happen if
(1) list_lru_from_memcg_idx() returns NULL or (2) lock_list_lru()
find l->nr_items is LONG_MIN which is set after CSS_DYING is set.

I don't see how (2) can happen. For (1) to happen, somehow someone has
deleted the given alive memcg's list_lru_memcg from shadow_nodes
list_lru. Not sure how that can happen without some memory corruption or
unsafe updates to shadow_nodes.

I think we need to wait for syzbot to generate a reproducer to debug
further.

> Modules linked in:
> CPU: 0 UID: 0 PID: 13908 Comm: syz.0.1878 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:lock_list_lru_of_memcg+0x30c/0x4c0 mm/list_lru.c:100
> Code: 42 80 3c 30 00 74 0b 48 89 fb e8 2f 40 1d 00 48 89 df 48 8b 3f 48 8b 54 24 10 48 8b 74 24 28 e9 0a fe ff ff e8 e5 8a b7 ff 90 <0f> 0b 90 eb be 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 1e fe ff ff 48
> RSP: 0018:ffffc9000fb165c0 EFLAGS: 00010083
> RAX: ffffffff82087bab RBX: 0000000000000000 RCX: 0000000000080000
> RDX: ffffc9000f013000 RSI: 00000000000127d4 RDI: 00000000000127d5
> RBP: 0000000000000001 R08: ffff88801e3b8000 R09: 0000000000000002
> R10: 0000000000000406 R11: 0000000000000002 R12: ffffffff997ec9a0
> R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88812613e000(0063) knlGS:00000000f541bb40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000f74089b4 CR3: 000000002ef4a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  list_lru_add+0x58/0x270 mm/list_lru.c:167
>  list_lru_add_obj+0x191/0x270 mm/list_lru.c:190
>  workingset_update_node+0x1d5/0x260 mm/workingset.c:629
>  xas_update lib/xarray.c:357 [inline]
>  update_node lib/xarray.c:765 [inline]
>  xas_store+0xac4/0x1880 lib/xarray.c:852
>  page_cache_delete mm/filemap.c:141 [inline]
>  __filemap_remove_folio+0x3c7/0x500 mm/filemap.c:227
>  __remove_mapping+0xb06/0xe40 mm/vmscan.c:811
>  shrink_folio_list+0x2896/0x4c70 mm/vmscan.c:1553
>  reclaim_folio_list+0xeb/0x500 mm/vmscan.c:2233
>  reclaim_pages+0x454/0x520 mm/vmscan.c:2270
>  madvise_cold_or_pageout_pte_range+0x1974/0x1d00 mm/madvise.c:565
>  walk_pmd_range mm/pagewalk.c:130 [inline]
>  walk_pud_range mm/pagewalk.c:224 [inline]
>  walk_p4d_range mm/pagewalk.c:262 [inline]
>  walk_pgd_range+0xfe9/0x1d40 mm/pagewalk.c:303
>  __walk_page_range+0x14c/0x710 mm/pagewalk.c:410
>  walk_page_range_vma+0x393/0x440 mm/pagewalk.c:717
>  madvise_pageout_page_range mm/madvise.c:624 [inline]
>  madvise_pageout mm/madvise.c:649 [inline]
>  madvise_vma_behavior+0x311f/0x3a10 mm/madvise.c:1352
>  madvise_walk_vmas+0x51c/0xa30 mm/madvise.c:1669
>  madvise_do_behavior+0x38e/0x550 mm/madvise.c:1885
>  do_madvise+0x1bc/0x270 mm/madvise.c:1978
>  __do_sys_madvise mm/madvise.c:1987 [inline]
>  __se_sys_madvise mm/madvise.c:1985 [inline]
>  __ia32_sys_madvise+0xa7/0xc0 mm/madvise.c:1985
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>  __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
>  do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf706d539
> Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f541b55c EFLAGS: 00000206 ORIG_RAX: 00000000000000db
> RAX: ffffffffffffffda RBX: 0000000080000000 RCX: 0000000000600000
> RDX: 0000000000000015 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    4:	10 07                	adc    %al,(%rdi)
>    6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    a:	10 08                	adc    %cl,(%rax)
>    c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
> * 2a:	5d                   	pop    %rbp <-- trapping instruction
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	90                   	nop
>   33:	90                   	nop
>   34:	90                   	nop
>   35:	90                   	nop
>   36:	90                   	nop
>   37:	90                   	nop
>   38:	90                   	nop
>   39:	90                   	nop
>   3a:	90                   	nop
>   3b:	90                   	nop
>   3c:	90                   	nop
>   3d:	90                   	nop
>   3e:	90                   	nop
>   3f:	90                   	nop
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

