Return-Path: <linux-kernel+bounces-838543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC5CBAF717
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D71017E0A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2867273D66;
	Wed,  1 Oct 2025 07:38:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4812737F9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304286; cv=none; b=KRVxaYpNcT9gdZbSi9Wlid2yfmHMamJf2oDR80hhGFlxaYxQ2x6su8bqe43CdiVXVCzAgqxxtdZ1G7R45ww6+GWx7wKGkhnJ/gTG2SsyoO1e3d6e1NJHbUJiIupEVgkocy1+qkdTIrTiFicE8ouyNpbjr4EhyhB+WSsxIWxxRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304286; c=relaxed/simple;
	bh=I4u5xaY0Luh7jX4esy+AxhQHp09E9Ible/+NAHHz5q4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l8vxRPt4L3PF5TNOiaN8dNCBtauE8v9L6Zmo3DUArhqB5GE/6G9GjBQWjKFHbs1iuPZ9U3aXKIhe7JIJk2B4WjTCtrg5GW73Cb1Ijq/IZus0ZsqRm81VjG5GGxZJn+Kxxd4Il62e+KpP1UPgEZgZZ/8garme/cMA+kGtYqDii5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-911c5f72370so591878439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304284; x=1759909084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OREYbr2SohCutRKeooB/L3mTaYG/kfnowNM7w12SB0=;
        b=SHbhtFuQ+o4PmLO+2OXhftLMb/doGpDg5PoxCJsgxgoIlZr+E5joelpUx6g7ofdLl+
         Oqt4LAB3adJf+tB4t7X7HB+prxM13TMsu6JxoZs3NF1nerTHWJ4yFPKTY/RfakIA42Ps
         oqfZSqlEgIkDAoScXXJkrOhiNnyoAnarUZnpJllvhj6qwouYYJ+SOau2LjJRJpyDF7gK
         fwL6cL+9tTPETTJBRPWP5bGnNvtXRfcfmoDVPMHRs/u8F82PKddXDCT7I5qYfXGDcUTO
         9QAbv+36HIJvgefHBCOUdRviDV/l3fNMVQNpyO0rGcX7f6Ym3m6AaVOvo7BiXevUyfh2
         BFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUZmk9Z4fV6ju1BqgnE/8yyc9yStXvH2wDEeYpSxF6k7fQZpjTZrlW+JWbFSEZg3bytDcDeB+YtuTiuYWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIF3DK8iNfNtp4aocOCQPRYlJATTUHhMAl14Y105yHzKqcESXb
	/GjIzLGLNH2q+nwXjhF/mDowgjcIymOxIo3EYjtfqEQgTTwvV3orXyTojk5FZ2bnUtGZtV7kFXC
	3M0DrGslJtIxWyjex6aq02a/nJ5ryQxMMUC+e4OvxuvFnHHGbdeXcp744TmM=
X-Google-Smtp-Source: AGHT+IGuoDVdNQN0nZqJYAgLUmUML/2/aisnKBFAp1DjxlwPiSzm2qW+lNhCQHGV/DD8uvLTSX7ym6pOPkZcdZaA/YYO1zoLMDDK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a01c:b0:886:fa71:f544 with SMTP id
 ca18e2360f4ac-937aeba94bfmr323752539f.17.1759304283992; Wed, 01 Oct 2025
 00:38:03 -0700 (PDT)
Date: Wed, 01 Oct 2025 00:38:03 -0700
In-Reply-To: <20251001072016.7814-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dcda5b.050a0220.25d7ab.0772.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ns_common_free

------------[ cut here ]------------
ida_free called for id=1016 which is not allocated.
WARNING: CPU: 0 PID: 6533 at lib/idr.c:592 ida_free+0x1f9/0x2e0 lib/idr.c:592
Modules linked in:
CPU: 0 UID: 0 PID: 6533 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x1f9/0x2e0 lib/idr.c:592
Code: 77 f6 41 83 fe 3e 76 72 e8 d4 eb 77 f6 48 8b 7c 24 28 4c 89 ee e8 07 39 0d 00 90 48 c7 c7 e0 cf cf 8c 89 ee e8 a8 c5 36 f6 90 <0f> 0b 90 90 e8 ae eb 77 f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc90003417968 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff92000682f2e RCX: ffffffff81796528
RDX: ffff888033f83c80 RSI: ffffffff81796535 RDI: 0000000000000001
RBP: 00000000000003f8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888140ea3000
R13: 0000000000000293 R14: 00000000000003f8 R15: ffff888140ea3078
FS:  0000000000000000(0000) GS:ffff888124e79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8b525b7230 CR3: 0000000076170000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __ns_common_free+0x7d/0xa0 kernel/nscommon.c:80
 free_mnt_ns+0xe0/0x110 fs/namespace.c:4096
 namespace_unlock+0x542/0x920 fs/namespace.c:1701
 put_mnt_ns fs/namespace.c:6135 [inline]
 put_mnt_ns+0xf5/0x120 fs/namespace.c:6126
 free_nsproxy+0x3a/0x400 kernel/nsproxy.c:188
 put_nsproxy include/linux/nsproxy.h:107 [inline]
 switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:241
 do_exit+0x86a/0x2bf0 kernel/exit.c:960
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x7a/0x100 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x419/0x4b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f96f758eec9
Code: Unable to access opcode bytes at 0x7f96f758ee9f.
RSP: 002b:00007f96f83e3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: fffffffffffffff4 RBX: 00007f96f77e5fa0 RCX: 00007f96f758eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000020000
RBP: 00007f96f7611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f96f77e6038 R14: 00007f96f77e5fa0 R15: 00007ffc0945e908
 </TASK>


Tested on:

commit:         50c19e20 Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121a8092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b28601618dc289ee
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11fb7c14580000


