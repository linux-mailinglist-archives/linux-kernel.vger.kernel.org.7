Return-Path: <linux-kernel+bounces-839648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D10BB213D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00C0320C50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52BF29CB52;
	Wed,  1 Oct 2025 23:41:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D971EB5C2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362066; cv=none; b=k+PLjOaqatcWMVhgcJB468igsIPz0mq2a79k+qZ4zQ3x6xNdGrEtsBjYxxNSNUCtH2zdyFB+F326qO36i5yMGpGx9wnykhzF4I5BALMxyQX2emnTZROGKjBot7Re+5AO20eF7X7HtkW1okZ6xREDP9bgJS3w2ToXlaq9wFStSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362066; c=relaxed/simple;
	bh=MJ8fkrFiS0xu6KEhHPAhW+SZaZD8DJ7Ww7gGC4x5CHQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DjvMhdEZG9/4VYwmq4QySmVhSwZc/rLUKnFoH0PwGJMcZ51EVsFbI1IQbTWTaxtfAvSzrufPVde0QCLEdsumrBLfjcX+WTG1yK/G93jOxDQGaNhb49AC6cuwaBHm68vjt5eByJBRefbbnou72ytfNufEJeM1JcL3drAI6jhWw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42d8b990b00so9780225ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 16:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759362064; x=1759966864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLhPoz0Tqw9MdNT1i2rLyi/fCgbMYY5k/FjQQhSw5ys=;
        b=xHvCAIYvvPOENxZzPNNqqn8soCbVAVpHra5ka6Eu1aUPvx2g0AKursyfGKmS3R7VXW
         Goo4DClIWtZiq/vwd7sV2dlY/4+S1adaR8/YgKbChVQXki/4OVMjNvjaFbjf8l7/S1/J
         ujBVZRWSE2cla8POuOmTngn0Lz4UZUacgszq+HZ1hCUxpNN12HUxno1Eg5wVVPnoA3qm
         b8X/UIBE4UW9oCOTs+aKqd9AcWqI8HSwCXjQfj7WtPuXVsBB4sl8Tuq5VABrLdk46lON
         F3GWgT7IMKk+qQQDC/wATkVnqmrMRjUzETbqucY3Jh7xUFnMPYdXL5NAupAnOVnCtH4r
         52Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXhjRFKzyY+p1HcJahxNlLMWmh6m9Rhe+IXtibfeSJp3f29x9wT8ZzR+qd1Ia7Sp6uQKKfj0W1PqUmsOOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEdt3FcYaQf/ExEp3V/RZATUu5QCuitN8NHxamu/H9NdFtOgw
	1iqFWPFp8LpWHBoFnYYU6kmEeg9Z+nC31GnO6fBwPSDkDy37fQME42T44Ylk3kgazipIcyzg2ZN
	uC/qDIGithyxtvWgH8h401hWAzeka4ZLTdB9rJGf3qNRu4nttU9Nwn60DLDQ=
X-Google-Smtp-Source: AGHT+IFxnJzcfmcySSHS6RX5vJNkRAWl2a9QzoDd3qCTFeteeJRfDMb4Bt2EYc74emiOBwf+achL8JP5M3L/sJO1tSHmE4WkbCtE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:424:64c:5b5d with SMTP id
 e9e14a558f8ab-42d81612c16mr78643965ab.13.1759362064083; Wed, 01 Oct 2025
 16:41:04 -0700 (PDT)
Date: Wed, 01 Oct 2025 16:41:04 -0700
In-Reply-To: <20251001220831.7873-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddbc10.a00a0220.102ee.006c.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in free_nsproxy

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fa688de6038 R14: 00007fa688de5fa0 R15: 00007fffb55a1f68
 </TASK>
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 6516 at lib/refcount.c:28 refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 6516 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Code: c0 14 9e 8b e8 87 7b fd fc 90 0f 0b 90 90 eb d7 e8 0b 0e 3a fd c6 05 f4 66 c2 0a 01 90 48 c7 c7 20 15 9e 8b e8 67 7b fd fc 90 <0f> 0b 90 90 eb b7 e8 eb 0d 3a fd c6 05 d1 66 c2 0a 01 90 48 c7 c7
RSP: 0018:ffffc90003d2fa98 EFLAGS: 00010246
RAX: b510e5eecce46500 RBX: 0000000000000003 RCX: ffff88802e82bc80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90003d2fc30 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1b7a138 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88807dbeca1c R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888126475000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f663fff CR3: 000000002fe8a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_nsproxy+0x3e/0x350 kernel/nsproxy.c:188
 do_exit+0x6b0/0x2300 kernel/exit.c:960
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa688b8eec9
Code: Unable to access opcode bytes at 0x7fa688b8ee9f.
RSP: 002b:00007fa689a0a0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fa688de5fa8 RCX: 00007fa688b8eec9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa688de5fa8
RBP: 00007fa688de5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa688de6038 R14: 00007fffb55a1e80 R15: 00007fffb55a1f68
 </TASK>


Tested on:

commit:         080ffb4b Merge tag 'i3c/for-6.18' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179785cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a792dde4ff127ac
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bb85cd980000


