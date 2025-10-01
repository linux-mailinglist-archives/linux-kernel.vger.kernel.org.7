Return-Path: <linux-kernel+bounces-839556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14902BB1DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C523AC162
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF59306B04;
	Wed,  1 Oct 2025 21:48:34 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F0145355
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355314; cv=none; b=AnseVl/wqQev6y8gFlPc7ywfYIbMskkB+kHjVBO1i175ShNnPs/gk01dwSn16ZLsH8PEVQYRSuJD1bKSiHIbwawmBegw4ZLLJoLrI/XkkRllNRsuurKseJqexC6TUKVxlYBoxJri51o4zkc/c1npLMOo3AeVkJFBHFe2fHxFmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355314; c=relaxed/simple;
	bh=pEhOwT1X7in50Kr5GHnScokN5PKyai0jXz2LjZohrqQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hgzHTgmJGkPIGYCYu5peU+QoOUpAxs0EAxv1WNTDmCCZjOPW7jlLzTxCYz2wnEZwJCYoB3yMyu8htTnNWRkfhItgtKqnREZlXvYiVOVDWKUdJMFMLUvMR7YNKIF6OlYdSgHNfp34Lyd7djYXIz/1AYn7wNhiHhp705l3wSUUV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42d8c210d84so4159225ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759355311; x=1759960111;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xa3U68yYOKHDPpIJxyjQuvshkNBKqLyHda+ZM1Ox+M=;
        b=YrB64TOX+8BNH+ahFt8bDj3y3EHnrnyNhjbJWDs6GkrTK98BPMF78zXUeE3BVNshN3
         sJLq7YKqAlwyh8DZft6hN9qf7MXWOV4yTqVp5JYTY6bI5vgwKmea9+qzMaKi59VwVMb6
         T6m+NaM1m03M14Rtvnhvunb1QBrlHkD9Gfh10mbJIAnyixC1RpJmZLePWRfC1LVGifV+
         IIVpSzvbHkbviRnjsk9NaB0d5srn5iUCRQiH3oP59ap77/y49Xg5hAmQmEZmmktlX9YP
         eM+Ll3nG4OFJJf4eyY+kCHfm77/6k2oMKD5dR8HJOmrW5pKrnu78YgX/JE2ZZft8oiKk
         skRA==
X-Forwarded-Encrypted: i=1; AJvYcCVhqKdgsUyme+s9+ReKBPmnCMMMQzG5sz8ZmF2rlmoj4nLykfITFtumm8Klr/8C887cdqOiA7EzP+KC3WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVd/9wu0wXVrGVVMWqpQjuS7DwysOF/QCFGYRIJMJFiAvoBxYd
	zaj2AGlmGgabEt2IDRbmCloGUK+TlgxRXJdlEm2hTiU9an2Pog9jqJzzenpDlIAGuvYOERSCovX
	8zEaCZQ6VydpfozH8SyH0D9qGA2pCrI1vlak9S4V5L9C82JwVLpHAkN+AQIA=
X-Google-Smtp-Source: AGHT+IE5wIakhy9YKOvGa4bItMlG+QqKT5ISj5Gtsed52/sYxurOGRNJvjOCqe0+edpB/pU6Trd6c1gaRWScAELTJYj6aQy/Ow/o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa7:b0:428:f19b:2947 with SMTP id
 e9e14a558f8ab-42d8159ea64mr82287515ab.6.1759355310914; Wed, 01 Oct 2025
 14:48:30 -0700 (PDT)
Date: Wed, 01 Oct 2025 14:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dda1ae.a00a0220.102ee.0065.GAE@google.com>
Subject: [syzbot] [arm?] WARNING in copy_highpage
From: syzbot <syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec734e8d564 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12187d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13bd892ec3b155a2
dashboard link: https://syzkaller.appspot.com/bug?extid=d1974fc28545a3e6218b
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-fec734e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7e18b408aea/vmlinux-fec734e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b7984f47117/Image-fec734e8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 25189 at arch/arm64/mm/copypage.c:55 try_page_mte_tagging arch/arm64/include/asm/mte.h:93 [inline]
WARNING: CPU: 1 PID: 25189 at arch/arm64/mm/copypage.c:55 copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55
Modules linked in:
CPU: 1 UID: 0 PID: 25189 Comm: syz.2.7336 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 00402009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55
lr : copy_highpage+0xb4/0x334 arch/arm64/mm/copypage.c:25
sp : ffff800088053940
x29: ffff800088053940 x28: ffffc1ffc0acf800 x27: ffff800088053b10
x26: ffffc1ffc0acf808 x25: ffffc1ffc037b1c0 x24: ffffc1ffc037b1c0
x23: ffffc1ffc0acf800 x22: ffffc1ffc0acf800 x21: fff000002b3e0000
x20: fff000000dec7000 x19: ffffc1ffc037b1c0 x18: 0000000000000000
x17: fff07ffffcffa000 x16: ffff800080008000 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000003 x12: 000000000006d9ad
x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800088053b18 x4 : ffff80008032df94 x3 : 00000000ff000000
x2 : 01ffc00003000001 x1 : 01ffc00003000001 x0 : 01ffc00003000001
Call trace:
 try_page_mte_tagging arch/arm64/include/asm/mte.h:93 [inline] (P)
 copy_highpage+0x150/0x334 arch/arm64/mm/copypage.c:55 (P)
 copy_mc_highpage include/linux/highmem.h:383 [inline]
 folio_mc_copy+0x44/0x6c mm/util.c:740
 __migrate_folio.constprop.0+0xc4/0x23c mm/migrate.c:851
 migrate_folio+0x1c/0x2c mm/migrate.c:882
 move_to_new_folio+0x58/0x144 mm/migrate.c:1097
 migrate_folio_move mm/migrate.c:1370 [inline]
 migrate_folios_move mm/migrate.c:1719 [inline]
 migrate_pages_batch+0xaf4/0x1024 mm/migrate.c:1966
 migrate_pages_sync mm/migrate.c:2023 [inline]
 migrate_pages+0xb9c/0xcdc mm/migrate.c:2105
 do_mbind+0x20c/0x4a4 mm/mempolicy.c:1539
 kernel_mbind mm/mempolicy.c:1682 [inline]
 __do_sys_mbind mm/mempolicy.c:1756 [inline]
 __se_sys_mbind mm/mempolicy.c:1752 [inline]
 __arm64_sys_mbind+0xd0/0xd8 mm/mempolicy.c:1752
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
---[ end trace 0000000000000000 ]---


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

