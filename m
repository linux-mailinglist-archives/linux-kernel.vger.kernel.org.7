Return-Path: <linux-kernel+bounces-865338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366FBBFCD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12FA1A01F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842534B43C;
	Wed, 22 Oct 2025 15:21:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57332B983
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146465; cv=none; b=WqTu4cca5+bDQETmx0L3oi34pmX+SZxIABneSrxaMLlOsgrnhXn5FuLkbwfkJvrJHkTkyLd+d7ATWph4lMYPjNPefML1WZm8lqW9DcaBkXGpUOIWrX0sRRe0mMl3iq1MYQU3T1YHhzqWCPwJMzvwveQGiFqFhUsFX0LRhL4g/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146465; c=relaxed/simple;
	bh=1WdfQBW36mIHUKlYc/CuT5OLiKxusVk27raIU+VTvIc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i+HWFlPCc1p0AHk2bTMoUAnQnwZEhFZ6n54jPoDD+zb5MTTiQkTiHF49uCPKA4P2GKYJUuAGch7bhM6DT+VpRg8CjM2ggybfyFy4FbAX0gTKAdbp5TOHdVU2BOFxhxEitfc9XJLXEEm34lWdIKmPz5dv2NrE4EkseCBPYdsb60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so16065425ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146463; x=1761751263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYdOGsPVpBpj6GYv47r5k71TsK0WoT1u0jBFZsV8s0k=;
        b=WlRznrNBgMxZ4c9Z0QhHyJnl2K0EBvMrrV4lpTgbISr8Ht+DN6T0ddiqH8/Y+tEiDZ
         JUJ4+m2xoFLHrss0zYA5WkAgy65N1VAcFG2RdONVjDg42SiURf6352Z5loUpeDCmmvoR
         h9gfPg4LIQMIFFRBe9eYzCPEl8wNltGNM4GosJsKVIf3lZ9mhaYtIPoprxcOS4TY7Asy
         ak6z1U7qIDv9R7sygZ6SZwiaUV1Z1IHfY2HnCQj15/Acp1VLj6lfiIpzjFjVh70DDCPv
         0F9i2HTJ7OB7iAGkdjwbmsPxbKAIuEsyof57LKiRDi1+A1RFI7FcJRJAgQJwHArsPwuQ
         8tug==
X-Forwarded-Encrypted: i=1; AJvYcCVPevToDdECwsDXatQgDEnS/7c5LT9NCol69Zw4hzz/1R+5Ni+AGTfhE8HCBxy3wJU1SF01ZDN4n6xQt/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/q0JPSCA52gPEI9bIt7Ylhvn4dLIBrowK1bDzExG9/p1KrLv
	KF3gLqV9rGUe/pJRfaLuy/1Rt0u4kq0Tc4my7P9tdoI2XiXYNydRf2Cpq6xqo6RO76m5tX1n74m
	PXh0ZKY9xv0+lXKSTVS+5LMqu8IPZsMZMhK3Gzy2L2AF9A+/Z/JRjrI8j4nk=
X-Google-Smtp-Source: AGHT+IFxIXCeVvjc4LEldfhDqJ/N2cmDCceVwutQojrChJ1DtSb7Vl5IIMmdeEk7Ou3eiyjrwqwbDAcA38cHxiqyTqHKMmvwsOgX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:430:b2a8:a9eb with SMTP id
 e9e14a558f8ab-431d3190d6dmr46361505ab.1.1761146463143; Wed, 22 Oct 2025
 08:21:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:21:03 -0700
In-Reply-To: <20251022150444.jHFNw%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8f65f.a70a0220.3bf6c6.001f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_remove_extent
From: syzbot <syzbot+8882b2f5f48a7170a726@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_remove_extent

------------[ cut here ]------------
kernel BUG at fs/ocfs2/alloc.c:5581!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5971 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_remove_extent+0x2050/0x21a0 fs/ocfs2/alloc.c:5581
Code: f9 ff ff 48 8b 4c 24 08 80 e1 07 fe c1 38 c1 0f 8c 27 fa ff ff 48 8b 7c 24 08 e8 db 38 8a fe e9 18 fa ff ff e8 61 fa 22 fe 90 <0f> 0b f3 0f 1e fa 65 44 8b 3d 06 58 cf 0e bf 07 00 00 00 44 89 fe
RSP: 0018:ffffc90002a5e620 EFLAGS: 00010293
RAX: ffffffff839cb81f RBX: 0000000000000007 RCX: ffff888035d2a480
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000007
RBP: ffffc90002a5e970 R08: ffff888035d2a480 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88808d75f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0a8a6eb4c CR3: 0000000042743000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ocfs2_remove_btree_range+0xdef/0x1540 fs/ocfs2/alloc.c:5778
 ocfs2_commit_truncate+0xba7/0x2250 fs/ocfs2/alloc.c:7373
 ocfs2_truncate_for_delete fs/ocfs2/inode.c:699 [inline]
 ocfs2_wipe_inode fs/ocfs2/inode.c:866 [inline]
 ocfs2_delete_inode fs/ocfs2/inode.c:1155 [inline]
 ocfs2_evict_inode+0x1138/0x4100 fs/ocfs2/inode.c:1295
 evict+0x504/0x9c0 fs/inode.c:810
 ocfs2_dentry_iput+0x247/0x370 fs/ocfs2/dcache.c:407
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:40 [inline]
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 irqentry_exit_to_user_mode+0x7e/0x110 kernel/entry/common.c:73
 exc_page_fault+0xab/0x100 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f95a3d8ebf1
Code: Unable to access opcode bytes at 0x7f95a3d8ebc7.
RSP: 002b:00000000fffffeb0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f95a3fb5fa0 RCX: 00007f95a3d8ebe9
RDX: 0000000000000000 RSI: 00000000fffffeb0 RDI: 0000000002000400
RBP: 00007f95a3e11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007f95a3fb6038 R14: 00007f95a3fb5fa0 R15: 00007ffc4e081d38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_remove_extent+0x2050/0x21a0 fs/ocfs2/alloc.c:5581
Code: f9 ff ff 48 8b 4c 24 08 80 e1 07 fe c1 38 c1 0f 8c 27 fa ff ff 48 8b 7c 24 08 e8 db 38 8a fe e9 18 fa ff ff e8 61 fa 22 fe 90 <0f> 0b f3 0f 1e fa 65 44 8b 3d 06 58 cf 0e bf 07 00 00 00 44 89 fe
RSP: 0018:ffffc90002a5e620 EFLAGS: 00010293
RAX: ffffffff839cb81f RBX: 0000000000000007 RCX: ffff888035d2a480
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000007
RBP: ffffc90002a5e970 R08: ffff888035d2a480 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88808d75f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37f9a6d000 CR3: 000000003623c000 CR4: 0000000000352ef0


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16099b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb89820a01e5d251
dashboard link: https://syzkaller.appspot.com/bug?extid=8882b2f5f48a7170a726
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1116ce7c580000


