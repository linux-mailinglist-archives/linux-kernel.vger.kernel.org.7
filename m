Return-Path: <linux-kernel+bounces-814029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD1B54E67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729B4BA0B41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8030E839;
	Fri, 12 Sep 2025 12:48:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2330CD8E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681312; cv=none; b=A0f+MwdZMdIbXbKnEWYUUeCl9QQ7YTBquQHzyqlZ2dKYdg13gjkkVdqruSH+SIGQoEYBkBqVcosv9zqwzit1nTriAiS/afxYbjDLhIBWN5TCni51soZSI3IZt9/8h0uV/3M3sTfoj5YCLuPrkkVlgxMDQBxxqnr2TvrcmPcdGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681312; c=relaxed/simple;
	bh=sqG8ltcUqtrhPOqloui6ucpxbwTPuPvlp3XF+wPlJeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oGPtcwwTKRlsB26MW3UmRg0h5PWwS8l9jgPY7+FBEYM7u4AQpc9ApG8aUPzsGt04hN1iyj8Od2lQFz1M2x9PNwfhWo5Z4ktXPMJm5dgBh8VSjzNnBEhdXc4EEG4YtHhP+qLJ4ylUMCCVPN8t4jnxwr+tvGVbly9xBDCikvO4KJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-889b8d95367so210245539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757681309; x=1758286109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBHBRQY65vunaP8XwbVeQmjpY4/Cq4UlcXQJUZRzu9w=;
        b=hEW0chAJTW5JpOKV86uurEb2daQh0WjquTz1PdxhAW0SmVuhXRFa25IfYzvEJpnlAu
         SMnlh6Gn0UaLgtyux0Wb0EYbHDZREtVsuWJn3gl57vOR1BT1OhXDsJQ/HmT3qgWXEnxy
         AqabpUpyanXLauaJ6Nt7l8XHQVd2R0wl4z8hXJW5yQBgXR6r1djCLU/eujfRrWVoviPF
         N9NGq52fLU1kgVb+Fflh3Y2Lv1JG6tURPZn8MBsUi7BZEutkZXOobNsBs3XO+tE9gLUi
         6V4fqXx/U5U8zkwpF+0GD/keB5+h2QOsROECPR3SOjuiD0F7eA3bB1C7/WWC8Pst/SmZ
         JLbA==
X-Forwarded-Encrypted: i=1; AJvYcCXK9SdJXkvVwfQ6SCAi4lSof3h4pBXtEvvMgMdF9F5TfRYhLgT2DmC90eZDcl7V7ewMtvSWMWqmCMgJrVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMvQyFp7fQiseGYhlvueCtavbGOurrc4p43HJxE0awB9gFMn/
	TQhkQk2Vh2MGuI80Dpae4ajbU8cGdr4uvuKp1j9u6C/6gRsZTJrolQHVlrzb2sL/keawKIAomOJ
	RQ/fvbWwFXjTuiqsoU8iSJZf5H67SR+tssr35AwKhD0UsqOrlI/hGmN0UZW4=
X-Google-Smtp-Source: AGHT+IE+HtdYnecs7vnU2oMP5ydYptJshp+W6yDGKLCRxZ0upyGNOY+Gv5b9EKhUjFk5qWL1zYh3XHgRelntzCtAzZexuVfoOYiQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:40e:9e8c:b48c with SMTP id
 e9e14a558f8ab-420a311fe64mr46696465ab.15.1757681309403; Fri, 12 Sep 2025
 05:48:29 -0700 (PDT)
Date: Fri, 12 Sep 2025 05:48:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c4169d.050a0220.2ff435.035c.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_quota_transfer (2)
From: syzbot <syzbot+86d3938ade3c1d827514@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    76eeb9b8de98 Linux 6.17-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1483f312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7f605fd273c8220
dashboard link: https://syzkaller.appspot.com/bug?extid=86d3938ade3c1d827514
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-76eeb9b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/658515dceee8/vmlinux-76eeb9b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee40b9e4370a/bzImage-76eeb9b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86d3938ade3c1d827514@syzkaller.appspotmail.com

  /, fixing
 done
bcachefs (loop0): check_xattrs...
bcachefs (loop0): key in missing inode, found keys:
  u64s 7 type xattr 1073741824:945502502804528484:U32_MAX len 0 ver 0: user.xattr2:xattr2
  u64s 7 type xattr 1073741824:3442546108204556527:U32_MAX len 0 ver 0: user.xattr1:xattr1
  , fixing
bcachefs (loop0): key in missing inode, found keys:
  u64s 7 type xattr 1073741824:3442546108204556527:U32_MAX len 0 ver 0: user.xattr1:xattr1
  , fixing
 done
bcachefs (loop0): check_root... done
bcachefs (loop0): check_unreachable_inodes... done
bcachefs (loop0): check_subvolume_structure... done
bcachefs (loop0): check_directory_structure... done
bcachefs (loop0): check_nlinks... done
bcachefs (loop0): check_rebalance_work... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): set_fs_needs_rebalance... done
bcachefs (loop0): Fixed errors, running fsck a second time to verify fs is clean
bcachefs (loop0): check_alloc_info... done
bcachefs (loop0): check_lrus... done
bcachefs (loop0): check_btree_backpointers... done
bcachefs (loop0): check_backpointers_to_extents... done
bcachefs (loop0): check_extents_to_backpointers... done
bcachefs (loop0): check_alloc_to_lru_refs... done
bcachefs (loop0): check_snapshot_trees... done
bcachefs (loop0): check_snapshots... done
bcachefs (loop0): check_subvols... done
bcachefs (loop0): check_subvol_children... done
bcachefs (loop0): delete_dead_snapshots... done
bcachefs (loop0): check_inodes... done
bcachefs (loop0): check_extents... done
bcachefs (loop0): check_indirect_extents... done
bcachefs (loop0): check_dirents... done
bcachefs (loop0): check_xattrs... done
bcachefs (loop0): check_root... done
bcachefs (loop0): check_unreachable_inodes... done
bcachefs (loop0): check_subvolume_structure... done
bcachefs (loop0): check_directory_structure... done
bcachefs (loop0): check_nlinks... done
bcachefs (loop0): check_rebalance_work... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): set_fs_needs_rebalance... done
bcachefs (loop0): reading quotas
bcachefs (loop0): quotas done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
kernel BUG at fs/bcachefs/quota.c:319!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5353 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bch2_quota_transfer fs/bcachefs/quota.c:319 [inline]
RIP: 0010:bch2_quota_transfer+0xa29/0xa50 fs/bcachefs/quota.c:367
Code: ff ff 89 f9 80 e1 07 38 c1 0f 8c 72 f7 ff ff 48 89 d3 e8 0a fc d1 fd 48 89 da e9 62 f7 ff ff e8 cd 54 29 07 e8 68 0c 6d fd 90 <0f> 0b e8 60 0c 6d fd 90 0f 0b e8 58 0c 6d fd 90 0f 0b e8 50 0c 6d
RSP: 0018:ffffc9000f40f700 EFLAGS: 00010283
RAX: ffffffff8452b228 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000dbd2000 RSI: 00000000000008db RDI: 00000000000008dc
RBP: ffffc9000f40f8b0 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1f47807 R12: 0000000000000000
R13: ffff8880343d7c28 R14: 1ffff11007ff820a R15: dffffc0000000000
FS:  00007f3e39d976c0(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000004000 CR3: 0000000043f9a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_fs_quota_transfer+0x27d/0x4f0 fs/bcachefs/fs.c:183
 bch2_setattr_nonsize+0x3a6/0x10e0 fs/bcachefs/fs.c:1122
 notify_change+0xb33/0xe40 fs/attr.c:552
 chown_common+0x40c/0x5c0 fs/open.c:791
 vfs_fchown fs/open.c:859 [inline]
 ksys_fchown+0xea/0x160 fs/open.c:871
 __do_sys_fchown fs/open.c:876 [inline]
 __se_sys_fchown fs/open.c:874 [inline]
 __x64_sys_fchown+0x7a/0x90 fs/open.c:874
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e38f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e39d97038 EFLAGS: 00000246 ORIG_RAX: 000000000000005d
RAX: ffffffffffffffda RBX: 00007f3e391c5fa0 RCX: 00007f3e38f8ebe9
RDX: 000000000000000a RSI: 000000003a736e6f RDI: 0000000000000006
RBP: 00007f3e39011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3e391c6038 R14: 00007f3e391c5fa0 R15: 00007ffd7c15f018
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_quota_transfer fs/bcachefs/quota.c:319 [inline]
RIP: 0010:bch2_quota_transfer+0xa29/0xa50 fs/bcachefs/quota.c:367
Code: ff ff 89 f9 80 e1 07 38 c1 0f 8c 72 f7 ff ff 48 89 d3 e8 0a fc d1 fd 48 89 da e9 62 f7 ff ff e8 cd 54 29 07 e8 68 0c 6d fd 90 <0f> 0b e8 60 0c 6d fd 90 0f 0b e8 58 0c 6d fd 90 0f 0b e8 50 0c 6d
RSP: 0018:ffffc9000f40f700 EFLAGS: 00010283
RAX: ffffffff8452b228 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000dbd2000 RSI: 00000000000008db RDI: 00000000000008dc
RBP: ffffc9000f40f8b0 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1f47807 R12: 0000000000000000
R13: ffff8880343d7c28 R14: 1ffff11007ff820a R15: dffffc0000000000
FS:  00007f3e39d976c0(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e39d75fc8 CR3: 0000000043f9a000 CR4: 0000000000352ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

