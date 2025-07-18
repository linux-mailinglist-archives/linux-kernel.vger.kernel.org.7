Return-Path: <linux-kernel+bounces-736858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4EB0A441
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ECE169CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3B2D94B4;
	Fri, 18 Jul 2025 12:32:11 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032723A563
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841930; cv=none; b=lcIuUotwR5On44shYlWZI0vGIR1pbg+ymbDLvPLxLjsR/aEJ83cPFI7gSik/FZZfvqdWouXYxn7Pnnh0yFLOudGl9lH+CJilttWYMtcpG5z1rcp3+8qmaFnAd+rnoShnpAqLqP83HNRMdzr3iOYU79rDSfmyk0XacTlT5bBDLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841930; c=relaxed/simple;
	bh=xae8LVKWg1fIHINPBQjUY4iE4WoaH2hpqNOblOGZ2og=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HeM2JXjaewjyFC96Lt6SdhO6NojttnwDaGrBr3RgaYH8PEabHXu3tTTv7Gk5iLK+3i0b4NVVuzyI7G3A+6ktTss9FLnN7qi+/UxTGyrwu3aJe6mZYRfHcuk6FxaxljzHQT5Tw86TmzAoOq9MKk5r9TVvuW2hjGRE3AdkoUAsjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-873fd6e896bso184655839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752841927; x=1753446727;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TvcPMcLI0cELSdG3BfYjkD2JWzixa8Vc6/unDcxz2k=;
        b=Mv5irUS4JE7pKPgHy48QAzE2mtbMa/UgfrT3mZeRxtuswxmmwq8/uNH/u5DrcGrGNt
         VneuuvN5nz4tNKGmxn3tUjjRUv4haAjjm3De6P8DboIiBFW5C5OV//dVzgc1Xx4D2stH
         dKVMa1hJU4qi3k8KLr38TkRznLqfF7GibZnjOtZ2KlAMQEiaoAGNk5IDM/ioWV5G5/WZ
         hBIe0CvlDZJaNU2LFe0jkhg5Rcpak0b/c9wYbzL2uYkRAYZ+YlCLJl83QGf85JirAvg9
         UVozC7uy7rbCtTphlfqs9B+c7CjmF0av0Whc4zoOlOBgKP70jopeMXGhOPUQY9LcrUgr
         W0DA==
X-Gm-Message-State: AOJu0YyxQP2xbDlZ+s1f+zYwa6woSwbK3FRZemh5xOJMHgJGKEUFVGPj
	kyiE97U80eU6w6kwSTf7M8nK2SRsJmlH4YYtZurXdwDGDbRDanlnI6XLlcRnrEbfRBrO384RKBn
	+nJJ0VVtE27bSMfQEudFCZkOHVa49/4l/LXBDRiDr8D3pnVhE23GauHDXvQ824w==
X-Google-Smtp-Source: AGHT+IFWZwBi1dUEvhtLgq5JbRIkLqX2RZo3gKjAozXGMxhTUPVd3dvgqW6h8KzfsTBQ3vGI2SLNJFZpHp0NqNC+6dsohyXb+5iO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6ccd:b0:86c:ee8b:c088 with SMTP id
 ca18e2360f4ac-87c01420cf3mr734201939f.11.1752841927551; Fri, 18 Jul 2025
 05:32:07 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:32:07 -0700
In-Reply-To: <68794b99.a70a0220.693ce.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a3ec7.a00a0220.3af5df.002a.GAE@google.com>
Subject: Forwarded: Private message regarding: [syzbot] [fs?] KASAN:
 use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Private message regarding: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
Author: kapoorarnav43@gmail.com

#syz test 
From: Arnav Kapoor <kapoorarnav43@gmail.com>
Date: Fri, 18 Jul 2025 12:00:00 +0000
Subject: [PATCH] hpfs: fix use-after-free in hpfs_get_ea

Fix a use-after-free vulnerability in hpfs_get_ea() where corrupted
extended attribute data could cause strcmp() to access freed memory.

The issue occurs in the EA iteration loop where next_ea() can produce
invalid pointers due to insufficient validation of ea->namelen and
the calculated next EA position. This can lead to accessing memory
that has been freed or is outside valid boundaries.

Add proper bounds checking to ensure:
1. EA namelen is reasonable (< 256)
2. EA structure doesn't exceed the EA area bounds  
3. next_ea() result stays within valid EA boundaries

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 fs/hpfs/ea.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 123456789abc..abcdef123456 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -135,8 +135,29 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *s
  secno a;
  struct extended_attribute *ea;
  struct extended_attribute *ea_end = fnode_end_ea(fnode);
- for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+ for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea)) {
+ /* Validate EA structure bounds */
+ if ((char *)ea + sizeof(*ea) > (char *)ea_end) {
+ hpfs_error(s, "EA structure exceeds bounds");
+ return NULL;
+ }
+ 
+ /* Validate namelen to prevent overflow */
+ if (ea->namelen >= 256) {
+ hpfs_error(s, "EA namelen too large: %d", ea->namelen);
+ return NULL;
+ }
+ 
+ /* Ensure name field is within bounds */
+ if ((char *)ea + 5 + ea->namelen > (char *)ea_end) {
+ hpfs_error(s, "EA name field exceeds bounds");
+ return NULL;
+ }
+ 
+ /* Validate next_ea() result will be within bounds */
+ if (next_ea(ea) > ea_end) {
+ hpfs_error(s, "next EA exceeds bounds");
+ return NULL;
+ }
+ 
  if (!strcmp(ea->name, key)) {
  if (ea_indirect(ea))
  return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = 
ea_len(ea));
@@ -147,6 +168,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *s
  memcpy(ret, ea_data(ea), ea_valuelen(ea));
  ret[ea_valuelen(ea)] = 0;
  return ret;
+ }
  }
  a = le32_to_cpu(fnode->ea_secno);
  len = le32_to_cpu(fnode->ea_size_l);



On Friday, 18 July 2025 at 00:44:34 UTC+5:30 syzbot wrote:

Hello, 

syzbot found the following issue on: 

HEAD commit: 155a3c003e55 Merge tag 'for-6.16/dm-fixes-2' of git://git... 
git tree: upstream 
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166d6382580000 
kernel config: https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22 
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844 
compiler: Debian clang version 20.1.7 
(++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 
20.1.7 
syz repro: https://syzkaller.appspot.com/x/repro.syz?x=14b20d8c580000 
C reproducer: https://syzkaller.appspot.com/x/repro.c?x=16ebe58c580000 

Downloadable assets: 
disk image: 
https://storage.googleapis.com/syzbot-assets/8b4489a1d2de/disk-155a3c00.raw.xz 
vmlinux: 
https://storage.googleapis.com/syzbot-assets/1c498d4c0c85/vmlinux-155a3c00.xz 
kernel image: 
https://storage.googleapis.com/syzbot-assets/ea8acdf1d890/bzImage-155a3c00.xz 
mounted in repro: 
https://storage.googleapis.com/syzbot-assets/e47f2d7541be/mount_0.gz 

IMPORTANT: if you fix the issue, please add the following tag to the 
commit: 
Reported-by: syzbot+fa88eb...@syzkaller.appspotmail.com 

hpfs: filesystem error: warning: spare dnodes used, try chkdsk 
hpfs: You really don't want any checks? You are crazy... 
hpfs: hpfs_map_sector(): read error 
hpfs: code page support is disabled 
================================================================== 
BUG: KASAN: use-after-free in strcmp+0x6f/0xc0 lib/string.c:283 
Read of size 1 at addr ffff8880116728a6 by task syz-executor411/6741 

CPU: 1 UID: 0 PID: 6741 Comm: syz-executor411 Not tainted 
6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 05/07/2025 
Call Trace: 
<TASK> 
dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120 
print_address_description mm/kasan/report.c:378 [inline] 
print_report+0xca/0x230 mm/kasan/report.c:480 
kasan_report+0x118/0x150 mm/kasan/report.c:593 
strcmp+0x6f/0xc0 lib/string.c:283 
hpfs_get_ea+0x114/0xdb0 fs/hpfs/ea.c:139 
hpfs_read_inode+0x19d/0x1010 fs/hpfs/inode.c:63 
hpfs_fill_super+0x12bd/0x2070 fs/hpfs/super.c:654 
get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1681 
vfs_get_tree+0x92/0x2b0 fs/super.c:1804 
do_new_mount+0x24a/0xa40 fs/namespace.c:3902 
do_mount fs/namespace.c:4239 [inline] 
__do_sys_mount fs/namespace.c:4450 [inline] 
__se_sys_mount+0x317/0x410 fs/namespace.c:4427 
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline] 
do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94 
entry_SYSCALL_64_after_hwframe+0x77/0x7f 
RIP: 0033:0x7f718b86112a 
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff 
ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 
RSP: 002b:00007ffee99fcba8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5 
RAX: ffffffffffffffda RBX: 00007ffee99fcbc0 RCX: 00007f718b86112a 
RDX: 0000200000009e80 RSI: 0000200000009ec0 RDI: 00007ffee99fcbc0 
RBP: 0000200000009ec0 R08: 00007ffee99fcc00 R09: 0000000000009dfd 
R10: 0000000000000041 R11: 0000000000000286 R12: 0000200000009e80 
R13: 0000000000000004 R14: 0000000000000003 R15: 00007ffee99fcc00 
</TASK> 

The buggy address belongs to the physical page: 
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11672 
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff) 
raw: 00fff00000000000 ffffea0001ff38c8 ffffea0001ff3908 0000000000000000 
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000 
page dumped because: kasan: bad access detected 
page_owner tracks the page as freed 
page last allocated via order 0, migratetype Movable, gfp_mask 
0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5213, tgid 5213 (udevd), ts 
38150701195, free_ts 195740390996 
set_page_owner include/linux/page_owner.h:32 [inline] 
post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704 
prep_new_page mm/page_alloc.c:1712 [inline] 
get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669 
__alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959 
alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419 
folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2438 
shmem_alloc_folio mm/shmem.c:1851 [inline] 
shmem_alloc_and_add_folio+0x447/0xf60 mm/shmem.c:1890 
shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2536 
shmem_get_folio mm/shmem.c:2642 [inline] 
shmem_write_begin+0xf7/0x2b0 mm/shmem.c:3292 
generic_perform_write+0x2c7/0x910 mm/filemap.c:4112 
shmem_file_write_iter+0xf8/0x120 mm/shmem.c:3467 
new_sync_write fs/read_write.c:593 [inline] 
vfs_write+0x54b/0xa90 fs/read_write.c:686 
ksys_write+0x145/0x250 fs/read_write.c:738 
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline] 
do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94 
entry_SYSCALL_64_after_hwframe+0x77/0x7f 
page last free pid 6740 tgid 6740 stack trace: 
reset_page_owner include/linux/page_owner.h:25 [inline] 
free_pages_prepare mm/page_alloc.c:1248 [inline] 
free_unref_folios+0xcd2/0x1570 mm/page_alloc.c:2763 
folios_put_refs+0x559/0x640 mm/swap.c:992 
folio_batch_release include/linux/pagevec.h:101 [inline] 
shmem_undo_range+0x49e/0x14b0 mm/shmem.c:1125 
shmem_truncate_range mm/shmem.c:1237 [inline] 
shmem_evict_inode+0x272/0xa70 mm/shmem.c:1365 
evict+0x501/0x9c0 fs/inode.c:810 
__dentry_kill+0x209/0x660 fs/dcache.c:669 
shrink_kill+0xa9/0x2c0 fs/dcache.c:1114 
shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141 
shrink_dcache_parent+0xa1/0x2c0 fs/dcache.c:-1 
do_one_tree+0x23/0xe0 fs/dcache.c:1604 
shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1621 
generic_shutdown_super+0x67/0x2c0 fs/super.c:621 
kill_anon_super fs/super.c:1282 [inline] 
kill_litter_super+0x76/0xb0 fs/super.c:1292 
deactivate_locked_super+0xbc/0x130 fs/super.c:474 
cleanup_mnt+0x425/0x4c0 fs/namespace.c:1417 
task_work_run+0x1d4/0x260 kernel/task_work.c:227 

Memory state around the buggy address: 
ffff888011672780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ffff888011672800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
>ffff888011672880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
^ 
ffff888011672900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ffff888011672980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
================================================================== 


--- 
This report is generated by a bot. It may contain errors. 
See https://goo.gl/tpsmEJ for more information about syzbot. 
syzbot engineers can be reached at syzk...@googlegroups.com. 

syzbot will keep track of this issue. See: 
https://goo.gl/tpsmEJ#status for how to communicate with syzbot. 

If the report is already addressed, let syzbot know by replying with: 
#syz fix: exact-commit-title 

If you want syzbot to run the reproducer, reply with: 
#syz test: git://repo/address.git branch-or-commit-hash 
If you attach or paste a git patch, syzbot will apply it before testing. 

If you want to overwrite report's subsystems, reply with: 
#syz set subsystems: new-subsystem 
(See the list of subsystem names on the web dashboard) 

If the report is a duplicate of another one, reply with: 
#syz dup: exact-subject-of-another-report 

If you want to undo deduplication, reply with: 
#syz undup 


