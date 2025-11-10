Return-Path: <linux-kernel+bounces-893203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B412DC46C68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60BBB3454D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AC30C609;
	Mon, 10 Nov 2025 13:07:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D0307482
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780028; cv=none; b=lm67d4UcP+E17N9m23P+YvuGyVZ4aW0CCYIaMSAPxnX7IHy3Uh/zksnPQBGx6RJSmU55/B78aXIJw+0LZgWRhYL68UBlse+OddTng3X1jJZOcBCp1fZdIn3+6VY9EFmS2T1NlmMFvSdhH1htn7Ytk0kUA4mNR6jF4hs+eoNvHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780028; c=relaxed/simple;
	bh=6qGFH5HDfCMxYD4WKwQAYalH85XXMYVZ/ZsIl7iata8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KAntIGWkFaO1Ba0TJd+fa4sx+raeijDVR6CUj++Xa7aqXmkC0g0eCVlktTLQAObR+MmylSgLoAevvUdf5Y4RPDPW5dNSCBg72BLIN2qPT0cnVICgnFvIwCg9rm0ijDuan2gTr74cbZJ9TRvTiJKNYWPC8yws2cCzmoZwZmsTmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-948af64c58dso33364739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780022; x=1763384822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKNKGGxh9kfvtglH61quUSLnkQl2GBNH6gWhaXGNHmc=;
        b=XlnVMbTFqZta7rhQ74mDz5qNRpUa+3u2a6SCVmat9z/W4/FvQ6iEhg43T87zkaP7X/
         2p2i4bGqqiwFUOmB6q8UReKt0L37y99iqnKjoPYwopmrB69vBPZxN4DmY/NLpIilIQ/U
         4EbeYGzvCoFin+EoXehOymyE5ZaUkNRQdZu8IeLmZezes5BWOrvG9/bJriQt00YGXIMc
         nQjKRDyFPKsDNpBFUHsXeKygSBNZXug+OvCVe5iPiDVLdvedhMWS6lhvGoX+OQENVXZy
         jnlF7WDO9GsbjmgWKDsQT1l0PdZUKmn6HDLjd4gOkvzonyZOPpaHnG2h+gpMnK1TRrZ1
         QN/A==
X-Gm-Message-State: AOJu0YyspLZUBzByOS+paD77aJGpknp2UiKfHZLNHWm8tATo1B2a6CuM
	2gsB0vm13e8qv5Pbg+Jcu6N6pXsyoDr5FOpdfUwmdSUITa+xtfOpbmFqbpHYTohdE8MtEhozn/r
	5UZO8uDlY/fpy/eGL078mKEFAeMZ1Pf87E+Kra1k4aNKyzZx6gxh3nWhQuMU=
X-Google-Smtp-Source: AGHT+IHmI2ikfG2wlNrmcw9qKRIU2v/D3k9y0LrNkFNjrWXIM4MmfTz0T4NRDXstLj3fQpK6Cp7k6+nTDZYX/2o8INj2jZw6c3W4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b86:b0:433:7964:d83a with SMTP id
 e9e14a558f8ab-4337964dacfmr62609845ab.8.1762780022019; Mon, 10 Nov 2025
 05:07:02 -0800 (PST)
Date: Mon, 10 Nov 2025 05:07:02 -0800
In-Reply-To: <912d60c8-e898-4113-b167-9549bc15f026@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911e376.a70a0220.22f260.00f0.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in dtInsertEntry

loop0: detected capacity change from 0 to 32768
UFO tlock:0xffffc900034f9048
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:3707:8
index -1 is out of range for type 'struct dtslot[128]'
CPU: 0 UID: 0 PID: 6833 Comm: syz.0.58 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 dtInsertEntry+0x936/0x1430 fs/jfs/jfs_dtree.c:3707
 dtInsert+0x931/0x6000 fs/jfs/jfs_dtree.c:894
 jfs_create+0x6c8/0xa80 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x1500/0x3840 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2c965f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2c8cce038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fa2c98b5fa0 RCX: 00007fa2c965f6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000580
RBP: 00007fa2c96e1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa2c98b6038 R14: 00007fa2c98b5fa0 R15: 00007ffe646c1968
 </TASK>
---[ end trace ]---


Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17265412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9489c9f9f3d437221ea2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bbb084580000


