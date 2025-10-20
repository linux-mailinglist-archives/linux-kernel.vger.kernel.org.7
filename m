Return-Path: <linux-kernel+bounces-859954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998BBEF090
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58FE189531E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB041C8611;
	Mon, 20 Oct 2025 01:52:27 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832D19B5B1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925147; cv=none; b=e0AHbuDU75sI+OnORIGgOOf+Bo1rv1dlXWN1t8X8qbciGIerFCQ06yasAQLdnKUW7+GnPtOTm7X7/6560eYrhxNgj9dXt19m4l8l2vGnIWB9fsdMRhnHgMv9evmwSBmOGKp6yeESXHwdM5mdHtVrrAW3ZuAlZ+/bCtrEGS5hWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925147; c=relaxed/simple;
	bh=7adGGVF9tdW1YJFMPKEmSFylgttva22iP01hwiRYwow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XfBTeZ8cfNcFbkTqvxPz2fILIsfqUu/0cU798B96x1GXUjhwajqzsOPG7QY3iq5ie9uDGX4IsLJ4/eI+RHt5+8/JDfx63666zNeQyeM90I7Wq/mDsdK3X8kcsHn38qLbPOq2bF6eFYDe9ZVPcQAk0Ez2LcesKycI9rPIt8SGtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93e4da7a183so348214939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760925145; x=1761529945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFUqgO/1X4tGf013zyFKn87MJvA/QpMdKd1TaPnKCjc=;
        b=QnnFVG9o33lkk0BBhsPO7dU1nPJ1d6r4JlxqxuyoGGjAHMtKal2nCPxOCGYy3eGPBT
         Xvzciz73nVgFihJipHdSH5mRo0H9+f2bOd+nTUHIGNOi+ZXveoYtAc5nPbaie+jrcUa+
         Hftba1TkAaF0C5x147DZ0d3h/3mCW2UBKQ25ew9E7qDvdrzlvk6gopkdiT3dqPh7Zsvp
         RbezH/XfJERDfMZL8yeuzbqFgooCCWwgQRUFDr7pJ29Ba2uy/7NcNT6hoBPPbz0FcwL4
         ZL3zFZBPx7O4Ct40HNUMRE9FmIVYDmhk/83EUMDTvldWZjH7SQLKKvyXdjLweJsNSHxV
         CEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtyelbJcMgAIPsE+MKum674MxwG92L4yb0YRX1ZSAukdvL1DukHC2Bu1VPrKnBKwQ/fqF5PyLKkmVSbVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2kUrtBozuvgtM2KFXToATKXkWBvIYm+naWhg/rcUi5ty/cjR
	kbf/EaDpqDh1ARSakpCBwIzpYkjCW0qPm9isQxqzz1yzq2vk9K9st//TyXxw37Vqdlcx2XpPMsr
	B7GRJX6oxRp2o68EpGJiiZl5gGmpTdcsMlvGyBK0VV68m84ztc0WX7UIDFjU=
X-Google-Smtp-Source: AGHT+IGEOGgAhJ/VqxDKE9fKEFF/jaq3tSnh+we7qLzZ2LAHPDAXshaEsuvm4ccKBJLGxkBNcROv4yDvfOrJP5YcURXXt2nQ2uHU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6409:b0:901:3363:e663 with SMTP id
 ca18e2360f4ac-93e76451522mr1784937939f.13.1760925145012; Sun, 19 Oct 2025
 18:52:25 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:52:25 -0700
In-Reply-To: <66f49736.050a0220.211276.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f595d8.050a0220.91a22.043c.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: task hung in wg_netns_pre_exit (5)
From: syzbot <syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, jason@zx2c4.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    88224095b4e5 Merge branch 'net-dsa-lantiq_gswip-clean-up-a..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b28de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=913caf94397d1b8d
dashboard link: https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10796b04580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3cb46a2b9fc/disk-88224095.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d43ffbc738d/vmlinux-88224095.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9817e4fdd10a/bzImage-88224095.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com

INFO: task kworker/u8:8:6081 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:8    state:D stack:23424 pid:6081  tgid:6081  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:760
 wg_netns_pre_exit+0x1c/0x1d0 drivers/net/wireguard/device.c:419
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x990 net/core/net_namespace.c:234
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:696
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor:6161 blocked for more than 147 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25608 pid:6161  tgid:6161  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

