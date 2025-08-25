Return-Path: <linux-kernel+bounces-784729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C3B34067
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6065D3AEF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06C21257B;
	Mon, 25 Aug 2025 13:11:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D91E521B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127466; cv=none; b=WkwfT4DWBw5mj14rGavUYqjdH/JGfQ6BthuMuPZuUOfKFWt7BWMbSgdXSbAzDCOPIdrOtyghNiTVyLeGaSF243I1OKu/dEHqD1gtqqvK61Kqu/PXXSTOekFnYOfj+hos+w2n2hneuw9kbpWlIAY/0MLwvRt4S+S1+llE2GJmexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127466; c=relaxed/simple;
	bh=HlxQnHlQFRuE5FoILgC2Nm6E09D+N5ertzJH4RrTrfE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nrHORmIz6i9UkTYr8mX3y8oO1ijotKV1yMfoT0jd6/GC8zgTUwsKpF7lqcsAbF4JW706Hs+Zk7WKB9fvzQjr6rBfBzZHKpg/V1F3fWSxX9ceTtiSKuNRLFucwF0Rs8B6mGMdvRsLqU6NdnIVnWraGrOaTonCrI+leKOCu7piXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e6e61caf71so115432815ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127464; x=1756732264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opxHGaiDOlxogcqIGQ2cl2DVoSl/501Xq1OSPoum9Wc=;
        b=kxjz9kxf7OFstNoJzYCPyJ8zdBoBLq2T4OqQNXcCGM/PqnV8TqQB1LwRwxYLcbT7bk
         Snj6qt+lTqNC5T+iIHdMjL+tycJ//NRDMCMltcEUBmWa2MIgdg4cI63QA0vr8l5U8aJo
         ayuHPGa1jnxp4lzyq//pThu8yZ0YCiymJVj7MYdEYzGBVdCDNtMMA/ovK0dlemck2a1Y
         8c2yUM/Vo0UAnwIDXxNunn/xPQBKa+XG6oc5U0sYwSvH2Yx5xYi0AU6fzt+J+PP/PQke
         OTpnNMieNLg8ox7tIOHQTm7LcUtL1zh+bioQUjcL/cCu16O46yKSqcy3d/tHQO2tfgiM
         MkYw==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ/Lkh6FeH55VJzafrZBQ5A4feARlwjY872Sh1ms4gEnBG9D8f+o5Ldvbs3ZE5FNrKSXNADXiTGbl/iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLtT03WXg3CAWQ0q3GZ/5VjYt4XtdPpLoKCzoWRLLgbiR60P6
	Th+DQ4Ono1fz3EAlYquA+MAbB2IqBcqKwdBWBTP8cmuGczOe5gCt1e7FgzHSo8TSxOVxNLVAaqa
	a78ZY1SWnzBbGMJQtwAYdtKoJ44ghhazrSTmnHLxc1d/FEP3iBkLhdbr/pFw=
X-Google-Smtp-Source: AGHT+IGHA2+eDYwXP/7CSJzDMBjaOsrR2gBDaSTlxmaT2JPzfFXfWHK/Yf8oqZQFCGdNJARks5Jds2hMBdJKYEJ4m72ZvXK+OFuD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2507:b0:3eb:84f0:a866 with SMTP id
 e9e14a558f8ab-3eb84f0aa75mr89473735ab.9.1756127463760; Mon, 25 Aug 2025
 06:11:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:11:03 -0700
In-Reply-To: <20250825104155.5420-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac60e7.a70a0220.303e5.0003.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
From: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: locking bug in ext4_truncate

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(subclass >= MAX_LOCKDEP_SUBCLASSES)
WARNING: CPU: 0 PID: 6286 at kernel/locking/lockdep.c:5103 __lock_acquire+0x10ba/0x1ce0 kernel/locking/lockdep.c:5103
Modules linked in:
CPU: 0 UID: 65534 PID: 6286 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__lock_acquire+0x10ba/0x1ce0 kernel/locking/lockdep.c:5103
Code: 41 83 bd d4 0a 00 00 01 19 f6 83 e6 02 83 c6 03 e9 5b f9 ff ff 90 48 c7 c6 80 a8 c8 8d 48 c7 c7 0c 44 e1 8d e8 b7 7f e2 ff 90 <0f> 0b 90 90 e9 5b f8 ff ff 90 48 c7 c6 f6 98 e2 8d 48 c7 c7 0c 44
RSP: 0018:ffffc90002eb7920 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffffff817a3358
RDX: ffff88807ad25a00 RSI: ffffffff817a3365 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 000000009af27c01
R13: ffff88807ad25a00 R14: 0000000000000000 R15: ffff88805d1b6210
FS:  0000555565c94500(0000) GS:ffff8881246bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcca85bf18 CR3: 000000005dcbb000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 down_write_nested+0x96/0x210 kernel/locking/rwsem.c:1706
 ext4_truncate+0xdec/0x1220 fs/ext4/inode.c:4640
 ext4_evict_inode+0x7a8/0x18e0 fs/ext4/inode.c:261
 evict+0x3e6/0x920 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput fs/inode.c:1923 [inline]
 iput+0x521/0x880 fs/inode.c:1909
 d_delete_notify include/linux/fsnotify.h:377 [inline]
 vfs_rmdir fs/namei.c:4474 [inline]
 vfs_rmdir+0x487/0x690 fs/namei.c:4438
 do_rmdir+0x2e8/0x3c0 fs/namei.c:4516
 __do_sys_unlinkat fs/namei.c:4690 [inline]
 __se_sys_unlinkat fs/namei.c:4684 [inline]
 __x64_sys_unlinkat+0xef/0x130 fs/namei.c:4684
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f43c538e1c7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcca85c6c8 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007f43c538e1c7
RDX: 0000000000000200 RSI: 00007ffcca85d810 RDI: 00000000ffffff9c
RBP: 00007f43c5411c05 R08: 0000555565ca754b R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000207 R12: 00007ffcca85d810
R13: 00007f43c5411c05 R14: 0000000000026c6d R15: 00007ffcca85d850
 </TASK>


Tested on:

commit:         1b237f19 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1525ec42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da02162f945f3311
dashboard link: https://syzkaller.appspot.com/bug?extid=c5c9c223a721d7353490
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1636fa34580000


