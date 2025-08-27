Return-Path: <linux-kernel+bounces-787814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6251B37BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED42E1B6650A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636EB3164DE;
	Wed, 27 Aug 2025 07:26:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63930C601
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279567; cv=none; b=YJC8ooP/kOfLNtuNAtMgto5YvkRvKg/x9z9A2PY72N4HC6ZgmY75YrJrAMQMZHxgX8HlEKuKgcWj7Qh68D5Dt026Qz/GKhT4qW5wbTlgFz6zD3VWYvodel/kzpwfRnp1pzWZ3tmpetQB5czizyBEm5Uen7Xy6y34JlWSnKHVMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279567; c=relaxed/simple;
	bh=M1Fv8zBkm4DQy47QdQG+BPLOCxAofKVgLoxqOA89g3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FmPJkA5mzkpT+pUIUPW+s9nSYKaYbnKJFCsmxKL43OBAO9PaKqqWTnApdIBiV7ILDflQ7LR/JKH4UjP5DBgyILPL+duqC4oNnFwYVjb2pMJ/Obacns25ClScqy/w3OT4fpIeRRMMKdonKu7EpRDL6Jxpll1rcGcpbIdIHGPRPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3eab737b99cso41369755ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756279564; x=1756884364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBiTkX+LtWr30x8kXfSExaJcqbSKjWmR0Tbn5ArzxGM=;
        b=QjfSlu8omhuE3ItCErqtbIFj8hYF3uCHyiRjdIMBPVuabF1ri5lWjygEuCUWE9Sk+z
         SaZ5XDh3BhNx7UH9Ht++HKyitgVVhDi2ye2DNLiiKHD4G30W1lUOzE0mLyOlc1Z01eLP
         FjMkH7l/LdruarrKte26HYk4uqFqu5oDSAVmaTFbLVHZhK32nzyos73C1GZ+VpKAGFWh
         fT5dNM6HSofBqowZmBE1OurfRlmoMdyp0VPHSWT+WyAIJVQ/Eoafl9fyzVNdyOWt/+bL
         FP1ERAtlpI/C5KX99f0w2qv27UmGse/nymDrglmwzvC8QNyxXbtpBpHZeGEap3pYsjiR
         qbJw==
X-Forwarded-Encrypted: i=1; AJvYcCXTGgIJdx/fCYMUqELbPNIqP5492YDQGUqiCuzfLxF0X6uNoR/ijGYoJ0WlzbLO4zNbkeMGAWl9u6LXRFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzE52Mj9Sk1aDbg7X18yH8QC33lR1HOOh1VAwRyXKtJTe+N6xl
	TO0Q+lzsq6NqbpdnJJRDPDlsIz/cTxAW+jYZ43uRaW2ISmvxMrfk7buA/NPw+ivBnq1Upb6ahYi
	NmKkDYAKmgljwgsC3AKnDI3yJI+O+ZYeyRYbM94C9E6yRcvWXD1+0YEW10mg=
X-Google-Smtp-Source: AGHT+IEZb5d0s2IkpWwHJvc23r9bl2MZsB7DiUHsHaibJ9/mRYBEW1DYdQQS+44E9MZylGS9Mbc7TXlByucUb70rq1xl0TJfRYfK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3e5:52a3:dade with SMTP id
 e9e14a558f8ab-3e921f3872bmr266156105ab.16.1756279564726; Wed, 27 Aug 2025
 00:26:04 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:26:04 -0700
In-Reply-To: <tencent_1D289EA31B164B411B652567BA75BB2D3308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aeb30c.a70a0220.3cafd4.0010.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in xfrm_state_fini

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2132 at net/xfrm/xfrm_state.c:3303 xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3303
Modules linked in:
CPU: 0 UID: 0 PID: 2132 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net

RIP: 0010:xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3303
Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 fb b1 00 f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b9 72 e1 f7 e8 14 46 9d f7 90 <0f> 0b 90 e9 fd fd ff ff e8 06 46 9d f7 90 0f 0b 90 e9 60 fe ff ff
RSP: 0000:ffffc90004827898 EFLAGS: 00010293
RAX: ffffffff8a22651c RBX: ffff888023d54880 RCX: ffff888029618000
RDX: 0000000000000000 RSI: ffffffff8be33660 RDI: ffff888029618000
RBP: ffffc900048279b0 R08: ffffffff8fa38437 R09: 1ffffffff1f47086
R10: dffffc0000000000 R11: fffffbfff1f47087 R12: ffffffff8f631480
R13: 1ffff92000904f40 R14: ffff888023d55d00 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125c1a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055be456ece28 CR3: 000000007da92000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4354
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11279ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eb9ef0580000


