Return-Path: <linux-kernel+bounces-859136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2ACBECDAE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E217A4E22AF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA862F5A23;
	Sat, 18 Oct 2025 10:48:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EA33EC
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784510; cv=none; b=tyTxqhvFsNZUsr8WTpBcHcGNa88n6whgRA2SRXLx7sesm6iVMu/gPrzOTX6WtN7PoVaHxJXb1PGby4SsGxKD3zgAjRLA34bfwwugwlD7hw6p7KboehOKSFCFyb47CfshKSEl/873hddMNPU2k3FzzeMcai7TkUqLrkwU/ZvBf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784510; c=relaxed/simple;
	bh=iPrE54t1CALNjGXhCE/EQwFxJKmStxK75hrCa8luASY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XbZA/SD54daysCY53WFyYfYVI+qfesyWfWLB/BZvtJ/z9lqL+WIGBhQDZg5DnRWLrn5ASj12dD4IKTujfdqbHcEcaAv10hUgbSd91uHrLFaChaIvqBPtZRRVuDJd6r0EmAnKQhakuU21msnGhiSRW6IU6XQI+bmBTw+F5q7HpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93e7ff77197so397639639f.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760784508; x=1761389308;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z8Z7wpUESyU9qTjYOdzliE7Gf4wtyzwNh9GC9p20fc=;
        b=ZFQEt4D0IbZPeabMHSL0XXaNjS7W4L7UBNgTlpge1UXz5bZ3wt1CBV9b62eMgDS+3F
         RBDF4rdPSBJq/059oYkdND+72kcAPKmXF7vZVfcZLFgnp1ytuJqPQN6BLuzEpaw+oIBg
         7fEyotUbllR291Oz+aaxkDABVUhnOfJlf8yjoAZLiJkGpC9Dypmzu1X43Zpz0UV3WFtX
         PQXaeyGs3t4e4dyI7TO51KijJb+FeA4eIoqowfHLB8oydEw2AvNUnyJKkp+UBT3Wez2E
         gz4lGqYERqdGrmsDL4WCjtD+lQ+bSnIVdwdNcvRYVcs5CUI/CFytIJlrAuWEz4oRRAhS
         iJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURiCzLhXinnYXdsuKRaH2Lrj1ch2VHQWbxq2tnXASBxd7xEx4tF6UoK32W9LIpceXjzeMMbs3OGOQj+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TzJxffrhO+7I2UyVapxtKVkAuelTZFonGHAoMh3E+K2W0js9
	No2jKoHxWpNkyuy40NromvEb6lXRwueoKup6faeTeOjHL71+IN/rrgc7NFKUkxVYMs1WrjfRqxX
	8xIc5ZJo6VcfsigCVndIMsh0EgxHDz1IrTFZPa/sckz5j2zgRPcBiDZODPXY=
X-Google-Smtp-Source: AGHT+IHaEenMDW07VDHQBXqbPDTCMwDWNfTxHkOeWoGcu0uIlQa2XedpuI2L4t3P0IkVQLQER5qCRZM7eXY+38yZ4e34eSTjRS+c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:430:b7c4:6617 with SMTP id
 e9e14a558f8ab-430c527bc80mr107915955ab.15.1760784508525; Sat, 18 Oct 2025
 03:48:28 -0700 (PDT)
Date: Sat, 18 Oct 2025 03:48:28 -0700
In-Reply-To: <68ec1f21.050a0220.ac43.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f3707c.050a0220.1186a4.051f.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm6_tunnel_net_exit (4)
From: syzbot <syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cf1ea8854e4f Merge tag 'mmc-v6.18-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b96492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c3de2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6a5b37662b9/disk-cf1ea885.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b4d732ae480/vmlinux-cf1ea885.xz
kernel image: https://storage.googleapis.com/syzbot-assets/acd7feec5537/bzImage-cf1ea885.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at net/ipv6/xfrm6_tunnel.c:341 xfrm6_tunnel_net_exit+0x7e/0x100 net/ipv6/xfrm6_tunnel.c:341
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm6_tunnel_net_exit+0x7e/0x100 net/ipv6/xfrm6_tunnel.c:341
Code: e8 66 90 f8 4b 83 3c 2c 00 75 19 e8 dc b4 2e f8 49 81 fd f8 07 00 00 74 1d e8 ce b4 2e f8 49 83 c5 08 eb c9 e8 c3 b4 2e f8 90 <0f> 0b 90 49 81 fd f8 07 00 00 75 e3 48 81 c3 00 08 00 00 45 31 f6
RSP: 0018:ffffc90000117890 EFLAGS: 00010293
RAX: ffffffff8990486d RBX: ffff888030f5c000 RCX: ffff88801ba9da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000117990 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1deee6f R12: ffff888030f5c000
R13: 00000000000003f0 R14: ffff888038a38000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126bc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd8ab2e0890 CR3: 00000000338be000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4de/0x820 net/core/net_namespace.c:695
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

