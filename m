Return-Path: <linux-kernel+bounces-585616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED14A79573
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 20:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23223ACF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086E1DB92A;
	Wed,  2 Apr 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GoFAAjPT"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3938DE1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619778; cv=none; b=Z7bG5ZAyxbNw28KFXvZowSVdldTukg+HNp0pGeeRgClY4fejVX+y7c/boxKnqfTjmuTzoapAdaxDio4SUBkcmWEesZASDJYazb+5rzOtjHHnHtrNwHCqNAiixSanOjPo7L1ecWSLUPi7KCPjt/J3o0S4p4Hj/yOt9ITt24STgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619778; c=relaxed/simple;
	bh=DTgOX/151O8AkIoG0weYiwor68xFKUhgPCcZqlnQvkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izlvlXmdAlxF9grd6dmMxIoBQM9CoVzwUZljVpymQMww5PpWXQIQO52FujhzwVL0gdhXKwnQ+J0/m3oCSo5w/7sHpLwNr/o5LFxHngkEibdoDIyeY/GT22riwboj1BQhd/YksIwU7ci6IN36LN9fiMz3h/CxtgS1qtiuP8pJRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GoFAAjPT; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 14:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743619761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cl6AmJc4QSFewNJX9IUpcE3oBggxGDnS2myz9NtWjEs=;
	b=GoFAAjPTdcU+aED178JtfBJmVkJnY4ZB3NybpI+ZgfAYshDEI4O1spjDmx6rW4ax+mkRq5
	/Mwgshz4L18edmVwotEQf4QpVqVUUHNy6fJUDs91XQUcEdynrbs4RC0z4bktjzjtctFIvO
	Gyi9XMbGgSq1lZB1z44AFZExwhtgQ2o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+64fe47118b53a051c3d7@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_opt_check_may_set
Message-ID: <iviif2qfocn5yap7os2ddltfi6p7a3ogs3yxalw4sjupajh75s@zhmmu4ayc4qm>
References: <67eb568b.050a0220.e5efe.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67eb568b.050a0220.e5efe.0001.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix bcachefs: Recovery no longer holds state_lock

On Mon, Mar 31, 2025 at 07:59:23PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4fa118e5b79f Merge tag 'trace-tools-v6.15' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101d3804580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14976ddc05593f
> dashboard link: https://syzkaller.appspot.com/bug?extid=64fe47118b53a051c3d7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4fa118e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75d19710545a/vmlinux-4fa118e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8e9456ff5bb7/bzImage-4fa118e5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+64fe47118b53a051c3d7@syzkaller.appspotmail.com
> 
>   u64s 8 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 0, fixing
> snapshot points to missing/incorrect tree:
>   u64s 8 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 0, fixing
>  done
> bcachefs (loop0): check_subvols... done
> bcachefs (loop0): check_subvol_children... done
> bcachefs (loop0): delete_dead_snapshots... done
> bcachefs (loop0): check_inodes... done
> bcachefs (loop0): check_extents... done
> bcachefs (loop0): check_indirect_extents... done
> bcachefs (loop0): check_dirents... done
> bcachefs (loop0): check_xattrs... done
> bcachefs (loop0): check_root... done
> bcachefs (loop0): check_unreachable_inodes... done
> bcachefs (loop0): check_subvolume_structure... done
> bcachefs (loop0): check_directory_structure... done
> bcachefs (loop0): check_nlinks... done
> bcachefs (loop0): resume_logged_ops... done
> bcachefs (loop0): delete_dead_inodes... done
> bcachefs (loop0): set_fs_needs_rebalance... done
> bcachefs (loop0): Fixed errors, running fsck a second time to verify fs is clean
> bcachefs (loop0): check_alloc_info... done
> bcachefs (loop0): check_lrus... done
> bcachefs (loop0): check_btree_backpointers... done
> bcachefs (loop0): check_backpointers_to_extents... done
> bcachefs (loop0): check_extents_to_backpointers...
> bcachefs (loop0): scanning for missing backpointers in 1/128 buckets
>  done
> bcachefs (loop0): check_alloc_to_lru_refs... done
> bcachefs (loop0): bucket_gens_init... done
> bcachefs (loop0): check_snapshot_trees... done
> bcachefs (loop0): check_snapshots... done
> bcachefs (loop0): check_subvols... done
> bcachefs (loop0): check_subvol_children... done
> bcachefs (loop0): delete_dead_snapshots... done
> bcachefs (loop0): check_inodes... done
> bcachefs (loop0): check_extents... done
> bcachefs (loop0): check_indirect_extents... done
> bcachefs (loop0): check_dirents... done
> bcachefs (loop0): check_xattrs... done
> bcachefs (loop0): check_root... done
> bcachefs (loop0): check_unreachable_inodes... done
> bcachefs (loop0): check_subvolume_structure... done
> bcachefs (loop0): check_directory_structure... done
> bcachefs (loop0): check_nlinks... done
> bcachefs (loop0): resume_logged_ops... done
> bcachefs (loop0): delete_dead_inodes... done
> bcachefs (loop0): set_fs_needs_rebalance... done
> bcachefs (loop0): done starting filesystem
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5325 at fs/bcachefs/opts.c:485 bch2_opt_check_may_set+0x189/0x1c0 fs/bcachefs/opts.c:485
> Modules linked in:
> CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted 6.14.0-syzkaller-07318-g4fa118e5b79f #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:bch2_opt_check_may_set+0x189/0x1c0 fs/bcachefs/opts.c:485
> Code: e8 fc a1 3f fd eb 0c e8 f5 a1 3f fd eb 05 e8 ee a1 3f fd 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 d8 a1 3f fd 90 <0f> 0b 90 e9 f3 fe ff ff 48 c7 c1 30 04 5e 90 80 e1 07 80 c1 03 38
> RSP: 0018:ffffc9000d505e88 EFLAGS: 00010283
> RAX: ffffffff8483e478 RBX: 0000000000000000 RCX: 0000000000100000
> RDX: ffffc9000ea2a000 RSI: 0000000000007706 RDI: 0000000000007707
> RBP: 0000000000000041 R08: ffffffff8483e360 R09: 1ffffffff20bbaae
> R10: dffffc0000000000 R11: fffffbfff20bbaaf R12: ffff888053380000
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007efcdf4256c0(0000) GS:ffff88808c5f1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000001240 CR3: 000000004348a000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bch2_xattr_bcachefs_set+0x3a7/0xb10 fs/bcachefs/xattr.c:526
>  __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
>  __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
>  vfs_setxattr+0x223/0x430 fs/xattr.c:321
>  ovl_do_setxattr fs/overlayfs/overlayfs.h:315 [inline]
>  ovl_copy_xattr+0x861/0xb60 fs/overlayfs/copy_up.c:156
>  ovl_copy_up_metadata+0x269/0xef0 fs/overlayfs/copy_up.c:668
>  ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:893 [inline]
>  ovl_do_copy_up fs/overlayfs/copy_up.c:999 [inline]
>  ovl_copy_up_one fs/overlayfs/copy_up.c:1202 [inline]
>  ovl_copy_up_flags+0x20b2/0x47f0 fs/overlayfs/copy_up.c:1257
>  ovl_open+0x14f/0x320 fs/overlayfs/file.c:211
>  do_dentry_open+0xdec/0x1960 fs/open.c:956
>  vfs_open+0x3b/0x370 fs/open.c:1086
>  dentry_open+0x61/0xa0 fs/open.c:1109
>  ima_calc_file_hash+0x16a/0x1af0 security/integrity/ima/ima_crypto.c:553
>  ima_collect_measurement+0x52b/0xb20 security/integrity/ima/ima_api.c:293
>  process_measurement+0x1353/0x1fb0 security/integrity/ima/ima_main.c:375
>  ima_file_check+0xdb/0x130 security/integrity/ima/ima_main.c:603
>  security_file_post_open+0xb9/0x280 security/security.c:3130
>  do_open fs/namei.c:3847 [inline]
>  path_openat+0x2cf7/0x35d0 fs/namei.c:4004
>  do_filp_open+0x284/0x4e0 fs/namei.c:4031
>  do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x249/0x2a0 fs/open.c:1455
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efcde58d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007efcdf425038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007efcde7a5fa0 RCX: 00007efcde58d169
> RDX: 0000000000000083 RSI: 0000200000000000 RDI: ffffffffffffff9c
> RBP: 00007efcde60e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007efcde7a5fa0 R15: 00007fffc7b7c218
>  </TASK>
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

