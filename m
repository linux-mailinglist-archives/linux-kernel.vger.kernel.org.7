Return-Path: <linux-kernel+bounces-833653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A04FBA28FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E624656032D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4927B500;
	Fri, 26 Sep 2025 06:44:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E027A469
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869072; cv=none; b=LCL3FO3za8glPoysTyutdEM/0HsU+IGCdDcEd694jdfEBck+6itc7/guuHa+ccmBKm0TAAhQawWL0X0ceN2i14sXWaz6C+rGag7vlB0UWy/gY0zxaF107Yv/1VQuKClOi7jbW7zq6ollKr+yl1ZLmB+uiIrCmT1wuYZ/Rq8NWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869072; c=relaxed/simple;
	bh=35LtL1bxlTC2/4BZNnXJappmyaq42CNrvMjSRyPsOVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Chl77VulDM9HxzlRFufKN9HHuOhC1oTSbpc41mcfjIX9midRwnBzPU5zVXHj5GnJKd63cHdC3Zu2vtFOdCa5pqy3TV09WNqDbScWOUXNfqlurYBW4LmmQPQTk8dyW+Lt6NmXzw2z/3toDvUpA0wmI4vYZJVgRslaNCxLmfA/oig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42721b7023eso6457945ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869070; x=1759473870;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ML2Io1cPjRbrmnvCa63vi8bMKEa3pezrQiaB8ZHL8bE=;
        b=s4jRAJBC9h46/DTeOpGgGRKeglExaayh5vEyLytaLyAzLGjMMa/41rL24yenDgyL03
         aERunmR4DyeYbH8tXBsLCOpQZnYNJzaM61JZINz4fPXpVjzNOcbqY2/hbGJgrkiVwZvV
         bb9QYWZVXWVd11yIcrQvdLCJUzHSnvMkVgvU9/FHCHMvI8ySmS0o/vNJB94Usc0L4gjy
         Eva4bCUx9+xpuWW16FmQEyc+6NbrOgspMf+NuGfSsk6QFlhE5fhA9E6BfOcQ/iSxqz7e
         80zzriwnXvMd3UvpGJYURkwNRi3Z4DvjpBFUdOsBj85TTHAZxLUZfhbi06idiSRSq/nH
         Kz4w==
X-Forwarded-Encrypted: i=1; AJvYcCW13RKUFrEAg8l9/d6xtTcXcKsFb+JB7m8KH3ifEZ7w8znyHNBF+NXAEshoJv3ufPkV4n/FsiAcNF38UPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrMnHi4KfdZQbyocuytV+uMrfqNxaTjEg73WLPNRV9fHYwqUJ
	uJ/XzBEpf1lZcxMmbHj0J6bVbNVLn6cegLT88wGqFK4TmsPoghQOj3YDoEfSEn9ueUfzCgczEFB
	5ScCrP5bmb7MpGFOy7lCNIofU1nsxKYnxS6654ZkM7sHvCtPvd771aJjvGrI=
X-Google-Smtp-Source: AGHT+IEh0ISwvbUJiv+mpukhrPiqeMyVANfxx6o4d/yrYP7YDpxEDyf7zuRPEIGw30+QVeJNnc0H2Lq5Lr+uCQozfoYv21+QTlnw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:425:8744:de7d with SMTP id
 e9e14a558f8ab-4259566cf61mr88463325ab.30.1758869070198; Thu, 25 Sep 2025
 23:44:30 -0700 (PDT)
Date: Thu, 25 Sep 2025 23:44:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d6364e.050a0220.3390a8.000d.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in try_to_migrate_one / zap_page_range_single_batched
From: syzbot <syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	harry.yoo@oracle.com, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, riel@surriel.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145d4f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e0c213d0735f5dd
dashboard link: https://syzkaller.appspot.com/bug?extid=60192c8877d0bc92a92b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10b7c8fdfdec/disk-cec1e6e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbecc36962db/vmlinux-cec1e6e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/214f107d0a3e/bzImage-cec1e6e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in try_to_migrate_one / zap_page_range_single_batched

write to 0xffff88810adfd798 of 8 bytes by task 13594 on cpu 1:
 update_hiwater_rss include/linux/mm.h:2657 [inline]
 try_to_migrate_one+0x918/0x16e0 mm/rmap.c:2455
 __rmap_walk_file+0x1ec/0x2b0 mm/rmap.c:2905
 try_to_migrate+0x1db/0x210 mm/rmap.c:-1
 migrate_folio_unmap mm/migrate.c:1324 [inline]
 migrate_pages_batch+0x6e1/0x1ae0 mm/migrate.c:1873
 migrate_pages_sync mm/migrate.c:1996 [inline]
 migrate_pages+0xf5f/0x1770 mm/migrate.c:2105
 do_mbind mm/mempolicy.c:1539 [inline]
 kernel_mbind mm/mempolicy.c:1682 [inline]
 __do_sys_mbind mm/mempolicy.c:1756 [inline]
 __se_sys_mbind+0x975/0xac0 mm/mempolicy.c:1752
 __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1752
 x64_sys_call+0x2932/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:238
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff88810adfd798 of 8 bytes by task 13595 on cpu 0:
 update_hiwater_rss include/linux/mm.h:2657 [inline]
 zap_page_range_single_batched+0x182/0x450 mm/memory.c:2007
 zap_page_range_single mm/memory.c:2041 [inline]
 unmap_mapping_range_vma mm/memory.c:4020 [inline]
 unmap_mapping_range_tree+0xfd/0x160 mm/memory.c:4037
 unmap_mapping_pages mm/memory.c:4103 [inline]
 unmap_mapping_range+0xe4/0xf0 mm/memory.c:4140
 shmem_fallocate+0x262/0x840 mm/shmem.c:3746
 vfs_fallocate+0x3b6/0x400 fs/open.c:342
 madvise_remove mm/madvise.c:1049 [inline]
 madvise_vma_behavior+0x192d/0x1cf0 mm/madvise.c:1346
 madvise_walk_vmas mm/madvise.c:1669 [inline]
 madvise_do_behavior+0x5b7/0x970 mm/madvise.c:1885
 do_madvise+0x10e/0x190 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __x64_sys_madvise+0x64/0x80 mm/madvise.c:1985
 x64_sys_call+0x1f1a/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:29
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000001645 -> 0x0000000000002165

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 13595 Comm: syz.1.3492 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
==================================================================


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

