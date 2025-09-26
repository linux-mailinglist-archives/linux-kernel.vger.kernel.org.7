Return-Path: <linux-kernel+bounces-834248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B87BA443A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56E47B1919
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFBE199E94;
	Fri, 26 Sep 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6TG9Eoy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzFQXXJU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6TG9Eoy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzFQXXJU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987D83CC7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897474; cv=none; b=h9ser1EhMqel3Rmuh4wLxSLc3Tql01Ahizr2DGQ5qt/qp8tWtDp3cjhQaknjy9CVizs66n7BaPj3hK6nNmkgy/9r/2i3dbUzvcfCKr59xBpBMTL/gAqVyEM3Fm3C9XsNKLuVYOSAm8tF2BppNoQyEEH23zy//6xQV4k0BulW+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897474; c=relaxed/simple;
	bh=h/0LhH5+OseNLPg2mleVtocs6NC/+aYByQuS1wXI9CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZY+CLoZ1Xrf5VZVYC2inj06WA6pHFOsh69VEvzGbBslcuMzYV4YQHQoE96UTKBzmO48DRpZxP0RKIZJifzyKxUV3lB8fvxprA+ERVVpotlh3ZpD7TC/F+xyRp9fNZGt2M0ju/0alOQQgV4ysg4Ym4ntmgSZeB+VthM0jK3rnK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6TG9Eoy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzFQXXJU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6TG9Eoy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzFQXXJU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C7942431A;
	Fri, 26 Sep 2025 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758897470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GGIQLrXDPKGC8xmzMADzKuCcFHSQrQzy7Q8kZsslKZA=;
	b=y6TG9EoymoauKo3CTy1bnoBESDn8UU+RJpTRGuD9Ou+tJPtnilXQgeclLzaTm8io3mC5le
	F49Vnn+9L9KrYvYOr/5y6V75+WO0AV9FHNSyVsKQbTdwUjE0RnrofLIP5gyzWaAbqgmcEc
	No9xma1IvGHpyjifTnZDvo9hIBuLcO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758897470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GGIQLrXDPKGC8xmzMADzKuCcFHSQrQzy7Q8kZsslKZA=;
	b=OzFQXXJUeHH8fQQIC4qoi9541ycr+X1t37cWHrKCyawkwJRMiVNllAi5hshhlt8jY3aex0
	tz3re3292+azLUBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758897470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GGIQLrXDPKGC8xmzMADzKuCcFHSQrQzy7Q8kZsslKZA=;
	b=y6TG9EoymoauKo3CTy1bnoBESDn8UU+RJpTRGuD9Ou+tJPtnilXQgeclLzaTm8io3mC5le
	F49Vnn+9L9KrYvYOr/5y6V75+WO0AV9FHNSyVsKQbTdwUjE0RnrofLIP5gyzWaAbqgmcEc
	No9xma1IvGHpyjifTnZDvo9hIBuLcO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758897470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GGIQLrXDPKGC8xmzMADzKuCcFHSQrQzy7Q8kZsslKZA=;
	b=OzFQXXJUeHH8fQQIC4qoi9541ycr+X1t37cWHrKCyawkwJRMiVNllAi5hshhlt8jY3aex0
	tz3re3292+azLUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 236131386E;
	Fri, 26 Sep 2025 14:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yEFSCD6l1mhRbwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Sep 2025 14:37:50 +0000
Message-ID: <522d9c39-b0a2-4630-947b-802b0f96eaf8@suse.cz>
Date: Fri, 26 Sep 2025 16:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KCSAN: data-race in try_to_compact_pages /
 try_to_compact_pages
Content-Language: en-US
To: syzbot <syzbot+20dd68d4ba19e8242c26@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 surenb@google.com, syzkaller-bugs@googlegroups.com, ziy@nvidia.com
References: <68d63689.050a0220.25d7ab.00d9.GAE@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <68d63689.050a0220.25d7ab.00d9.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6e0c213d0735f5dd];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,suse.cz:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[20dd68d4ba19e8242c26];
	RCPT_COUNT_SEVEN(0.00)[10];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On 9/26/25 08:45, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12448f12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6e0c213d0735f5dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=20dd68d4ba19e8242c26
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/10b7c8fdfdec/disk-cec1e6e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cbecc36962db/vmlinux-cec1e6e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/214f107d0a3e/bzImage-cec1e6e5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+20dd68d4ba19e8242c26@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in try_to_compact_pages / try_to_compact_pages
> 
> read-write to 0xffff88823fffacf0 of 4 bytes by task 6757 on cpu 1:
>  compaction_deferred mm/compaction.c:149 [inline]

Yeah data races for zone->compact_considered and zone->compact_order_failed
can happen but are not a problem. Somebody motivated enough might annotate them.

>  try_to_compact_pages+0x1be/0x940 mm/compaction.c:2838
>  __alloc_pages_direct_compact+0x65/0x1d0 mm/page_alloc.c:4066
>  __alloc_pages_slowpath+0x360/0x5f0 mm/page_alloc.c:4787
>  __alloc_frozen_pages_noprof+0x270/0x360 mm/page_alloc.c:5161
>  alloc_pages_mpol+0xb3/0x250 mm/mempolicy.c:2416
>  alloc_frozen_pages_noprof+0x90/0x110 mm/mempolicy.c:2487
>  ___kmalloc_large_node+0x52/0x100 mm/slub.c:4317
>  __kmalloc_large_node_noprof+0x16/0xa0 mm/slub.c:4348
>  __do_kmalloc_node mm/slub.c:4364 [inline]
>  __kmalloc_noprof+0x2ab/0x3e0 mm/slub.c:4388
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  io_vec_realloc io_uring/rsrc.c:1327 [inline]
>  io_import_reg_vec+0x645/0xe80 io_uring/rsrc.c:1520
>  io_sendmsg_zc+0x91/0x550 io_uring/net.c:1545
>  __io_issue_sqe+0xfb/0x2e0 io_uring/io_uring.c:1771
>  io_issue_sqe+0x53/0x970 io_uring/io_uring.c:1794
>  io_queue_sqe io_uring/io_uring.c:2023 [inline]
>  io_submit_sqe io_uring/io_uring.c:2283 [inline]
>  io_submit_sqes+0x675/0x1060 io_uring/io_uring.c:2396
>  __do_sys_io_uring_enter io_uring/io_uring.c:3463 [inline]
>  __se_sys_io_uring_enter+0x1c1/0x1b70 io_uring/io_uring.c:3397
>  __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3397
>  x64_sys_call+0x2de1/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> write to 0xffff88823fffacf0 of 4 bytes by task 6696 on cpu 0:
>  compaction_deferred mm/compaction.c:150 [inline]
>  try_to_compact_pages+0x207/0x940 mm/compaction.c:2838
>  __alloc_pages_direct_compact+0x65/0x1d0 mm/page_alloc.c:4066
>  __alloc_pages_slowpath+0x360/0x5f0 mm/page_alloc.c:4787
>  __alloc_frozen_pages_noprof+0x270/0x360 mm/page_alloc.c:5161
>  alloc_pages_mpol+0xb3/0x250 mm/mempolicy.c:2416
>  alloc_frozen_pages_noprof+0x90/0x110 mm/mempolicy.c:2487
>  ___kmalloc_large_node+0x52/0x100 mm/slub.c:4317
>  __kmalloc_large_node_noprof+0x16/0xa0 mm/slub.c:4348
>  __do_kmalloc_node mm/slub.c:4364 [inline]
>  __kmalloc_noprof+0x2ab/0x3e0 mm/slub.c:4388
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  io_vec_realloc io_uring/rsrc.c:1327 [inline]
>  io_import_reg_vec+0x645/0xe80 io_uring/rsrc.c:1520
>  io_sendmsg_zc+0x91/0x550 io_uring/net.c:1545
>  __io_issue_sqe+0xfb/0x2e0 io_uring/io_uring.c:1771
>  io_issue_sqe+0x53/0x970 io_uring/io_uring.c:1794
>  io_queue_sqe io_uring/io_uring.c:2023 [inline]
>  io_submit_sqe io_uring/io_uring.c:2283 [inline]
>  io_submit_sqes+0x675/0x1060 io_uring/io_uring.c:2396
>  __do_sys_io_uring_enter io_uring/io_uring.c:3463 [inline]
>  __se_sys_io_uring_enter+0x1c1/0x1b70 io_uring/io_uring.c:3397
>  __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3397
>  x64_sys_call+0x2de1/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00000005 -> 0x00000004
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 6696 Comm: syz.2.1234 Not tainted syzkaller #0 PREEMPT(voluntary) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> ==================================================================
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


