Return-Path: <linux-kernel+bounces-737470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB9B0AD21
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 02:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1CD5A4CB8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEAE86250;
	Sat, 19 Jul 2025 00:58:12 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015053FE4
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886691; cv=none; b=TUyvr3AOIINBZZU6aqnfcOWiM7U936M+HnsJmX6Nv9FWM6cpVHSekZTMXtofX7+754To/cHaK0LrwiBIle91XxcynLn4GX9aE6vNJssKWQbBzslNwm2I4ltXjrx/ZScX/uyXGnansh0LAD6cp2PZZzpdeXut9v0PQRH5+zGiA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886691; c=relaxed/simple;
	bh=OAiscgrxrADoN7F0c9yx2PNeYUdbT0KU9CJCNnVBhmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RihcMbJ5FvY2W8fFkC1C+A0Pp6X66G/h6PwP6AKhrR+VmYotopCeOfBAQMyXV1A4akg289hCm5AAyFTd6nkWjl/fjerXevufjjGlo0s6/8mIuMM4UoAWduT6aZlrd6VUMOufu+zmKTnqTNT/e2apaiNuREFBs++lk07v3ZqrHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-879489ddf11so538059539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752886689; x=1753491489;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyzwZTlMvaYuuTXqHJqdJahpCDaQ4l5nO2gF4ygXnH0=;
        b=NLoW/GCOtg99XDzXy+AhStIAKR7wvkXO7QrTIEszv5jhIAQE/hnUptzRjfuojlEoKl
         1LdN+Iu3CLY0VSgCRJlYG0YyA935/1nryret8Q19oM1zO2PzdcOXythSmYFseJrZHDAx
         nSsqM2FdrKa4JbCj+mzkKQecW1etPKqQ1z9WzGxQbui6Tj54R/jwd5T/wXJngkU2cluX
         D5lAft65uhqgI6rXBwROFda4m/FLzbaE7DNTnfPvXlbbn7kpkzrlrbsnT1FmlkTSdvJA
         wd/DpnXBxt15JdcCSithsByHG+LNeGA0EoIzW4+cKt7guhdg5WClaIVD9/+LqQi7rKUk
         Uf2A==
X-Gm-Message-State: AOJu0YyVXMyEW8xU3bjgk8G+Y5sw1QdkNDr76th7y7w0GEnsM6L/Y+B9
	GgQFrFiY7T6RmwtBKHq6iUdDNoE4/to5F3mehLffsrTS+XdMiMU/fe+yrKNAuB0Ux64WepBNGL/
	Sp0p2QXZ9pTN7XRE/0zk6k2z2CARNzoFQ8NntEzzp28zyczyNKLCmcsa2kqk=
X-Google-Smtp-Source: AGHT+IHtPkcl/XkPcjBi0JGxEvmLkVqVQBNMVoQgn16+IFqDHxVnvJ/YHrD58dvzMzGW0bFsNYtPhtJL2E3UONxD8yfwQng7NsbE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c5:b0:869:d4de:f7 with SMTP id
 ca18e2360f4ac-879c0935f49mr1799816839f.12.1752886689136; Fri, 18 Jul 2025
 17:58:09 -0700 (PDT)
Date: Fri, 18 Jul 2025 17:58:09 -0700
In-Reply-To: <68794b99.a70a0220.693ce.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687aeda1.a70a0220.693ce.0072.GAE@google.com>
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

Subject: [PATCH] hpfs: fix use-after-free in hpfs_get_ea

Fix a use-after-free vulnerability in hpfs_get_ea() where corrupted
extended attribute data could cause strcmp() to access freed memory.

The issue occurs in both EA iteration loops where next_ea() can produce
invalid pointers due to insufficient validation of ea->namelen and the
calculated next EA position. This can lead to accessing memory that has
been freed or is outside valid boundaries.

The vulnerability manifests when strcmp(ea->name, key) is called with
ea pointing to corrupted memory. Add comprehensive bounds checking:

1. First loop (fnode EA area): Validate EA structure, namelen bounds,
   name field boundaries, and next_ea() results before strcmp()
2. Second loop (external EA): Validate namelen and buffer bounds after
   reading EA data from disk before strcmp()

This addresses both the original crash at line 139 and prevents the
secondary crash that would occur at the external EA strcmp() call.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>

---
 fs/hpfs/ea.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 102ba18e561f..ab1234567890 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -135,7 +135,31 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *si
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
@@ -147,6 +171,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *si
  ret[ea_valuelen(ea)] = 0;
  return ret;
  }
+ }
  a = le32_to_cpu(fnode->ea_secno);
  len = le32_to_cpu(fnode->ea_size_l);
  ano = fnode_in_anode(fnode);
@@ -162,6 +187,14 @@ char *hpfs_get_ea(struct super_block *s, struct fnode 
*fnode, char *key, int *si
  if (hpfs_ea_read(s, a, ano, pos, 4, ex)) return NULL;
  if (hpfs_ea_read(s, a, ano, pos + 4, ea->namelen + 1 + (ea_indirect(ea) ? 
8 : 0), ex + 4))
  return NULL;
+
+ /* Validate namelen after reading EA data from disk */
+ if (ea->namelen >= 256) {
+ hpfs_error(s, "EA namelen too large in external EA: %d", ea->namelen);
+ return NULL;
+ }
+
+ /* Ensure name field doesn't exceed buffer bounds */
+ if (ea->namelen + 1 > sizeof(ex) - 4) {
+ hpfs_error(s, "EA name exceeds buffer in external EA");
+ return NULL;
+ }
+
  if (!strcmp(ea->name, key)) {
  if (ea_indirect(ea))
  return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = 
ea_len(ea));
-- 
2.34.1


On Friday, 18 July 2025 at 18:57:03 UTC+5:30 syzbot wrote:

Hello, 

syzbot has tested the proposed patch but the reproducer is still triggering 
an issue: 
KASAN: use-after-free Read in hpfs_get_ea 

hpfs: filesystem error: warning: spare dnodes used, try chkdsk 
hpfs: You really don't want any checks? You are crazy... 
hpfs: hpfs_map_sector(): read error 
hpfs: code page support is disabled 
================================================================== 
BUG: KASAN: use-after-free in hpfs_get_ea+0x1f7/0xca0 fs/hpfs/ea.c:146 
Read of size 1 at addr ffff8880719ea8a3 by task syz.0.16/6612 

CPU: 0 UID: 0 PID: 6612 Comm: syz.0.16 Not tainted 
6.16.0-rc6-syzkaller-00121-g6832a9317eee-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 05/07/2025 
Call Trace: 
<TASK> 
dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120 
print_address_description mm/kasan/report.c:378 [inline] 
print_report+0xca/0x230 mm/kasan/report.c:480 
kasan_report+0x118/0x150 mm/kasan/report.c:593 
hpfs_get_ea+0x1f7/0xca0 fs/hpfs/ea.c:146 
hpfs_read_inode+0x19d/0x1010 fs/hpfs/inode.c:63 
hpfs_fill_super+0x12bd/0x2070 fs/hpfs/super.c:654 
get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1681 
vfs_get_tree+0x8f/0x2b0 fs/super.c:1804 
do_new_mount+0x24a/0xa40 fs/namespace.c:3902 
do_mount fs/namespace.c:4239 [inline] 
__do_sys_mount fs/namespace.c:4450 [inline] 
__se_sys_mount+0x317/0x410 fs/namespace.c:4427 
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline] 
do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94 
entry_SYSCALL_64_after_hwframe+0x77/0x7f 
RIP: 0033:0x7fb45e3900ca 
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff 
ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 
RSP: 002b:00007fb45f2c9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5 
RAX: ffffffffffffffda RBX: 00007fb45f2c9ef0 RCX: 00007fb45e3900ca 
RDX: 0000200000009e80 RSI: 0000200000009ec0 RDI: 00007fb45f2c9eb0 
RBP: 0000200000009e80 R08: 00007fb45f2c9ef0 R09: 0000000000000041 
R10: 0000000000000041 R11: 0000000000000246 R12: 0000200000009ec0 
R13: 00007fb45f2c9eb0 R14: 0000000000009e02 R15: 0000200000009fc0 
</TASK> 

The buggy address belongs to the physical page: 
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fdaad200 
pfn:0x719ea 
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff) 
raw: 00fff00000000000 ffffea0001c67988 ffffea0001c61d88 0000000000000000 
raw: 00000007fdaad200 0000000000000000 00000000ffffffff 0000000000000000 
page dumped because: kasan: bad access detected 
page_owner tracks the page as freed 
page last allocated via order 0, migratetype Movable, gfp_mask 
0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 6566, tgid 6566 
(sed), ts 134996856935, free_ts 135030622689 
set_page_owner include/linux/page_owner.h:32 [inline] 
post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704 
prep_new_page mm/page_alloc.c:1712 [inline] 
get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669 
__alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959 
alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419 
folio_alloc_mpol_noprof mm/mempolicy.c:2438 [inline] 
vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2473 
folio_prealloc+0x30/0x180 mm/memory.c:-1 
alloc_anon_folio mm/memory.c:5014 [inline] 
do_anonymous_page mm/memory.c:5071 [inline] 
do_pte_missing mm/memory.c:4249 [inline] 
handle_pte_fault mm/memory.c:6069 [inline] 
__handle_mm_fault+0x2c88/0x5620 mm/memory.c:6212 
handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381 
do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336 
handle_page_fault arch/x86/mm/fault.c:1476 [inline] 
exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532 
asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623 
page last free pid 6566 tgid 6566 stack trace: 
reset_page_owner include/linux/page_owner.h:25 [inline] 
free_pages_prepare mm/page_alloc.c:1248 [inline] 
free_unref_folios+0xcd2/0x1570 mm/page_alloc.c:2763 
folios_put_refs+0x559/0x640 mm/swap.c:992 
free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:264 
__tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline] 
tlb_batch_pages_flush mm/mmu_gather.c:149 [inline] 
tlb_flush_mmu_free mm/mmu_gather.c:397 [inline] 
tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404 
tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497 
exit_mmap+0x44c/0xb50 mm/mmap.c:1297 
__mmput+0x118/0x410 kernel/fork.c:1121 
exit_mm+0x1da/0x2c0 kernel/exit.c:581 
do_exit+0x648/0x22e0 kernel/exit.c:952 
do_group_exit+0x21c/0x2d0 kernel/exit.c:1105 
__do_sys_exit_group kernel/exit.c:1116 [inline] 
__se_sys_exit_group kernel/exit.c:1114 [inline] 
__x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1114 
x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232 
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline] 
do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94 
entry_SYSCALL_64_after_hwframe+0x77/0x7f 

Memory state around the buggy address: 
ffff8880719ea780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ffff8880719ea800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
>ffff8880719ea880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
^ 
ffff8880719ea900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ffff8880719ea980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
================================================================== 


Tested on: 

commit: 6832a931 Merge tag 'net-6.16-rc7' of git://git.kernel... 
git tree: upstream 
console output: https://syzkaller.appspot.com/x/log.txt?x=155f38f0580000 
kernel config: https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22 
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844 
compiler: Debian clang version 20.1.7 
(++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 
20.1.7 
patch: https://syzkaller.appspot.com/x/patch.diff?x=1644fd8c580000 


