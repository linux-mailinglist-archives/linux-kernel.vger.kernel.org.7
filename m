Return-Path: <linux-kernel+bounces-894144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92584C495A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565F73A8C55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530902F617C;
	Mon, 10 Nov 2025 20:58:38 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F132F3638
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808317; cv=none; b=Gq0au8iYjCIRzQWWthSNhwAtMms3tQ2GxpMdInvrd6y5w1ECm71MNQZHE42HBbDGionwfkz8EbW6A+w/kRUlRf6xhANdW37r9cwHaMgRZJf92kXoTlPHPvZS6SxcW8BRWPzW8laFSRyKRM/kh2FT7Hb3pXO6wa2QgLN/gdW0nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808317; c=relaxed/simple;
	bh=851bXe5aQTwdZty53jaIVbICFA09xB27jhrqcmzMOeo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PviEH+sBsPouLUW0p/e16PYkcQLBiN1WxSMId90eSuyfldPPKh9liXpbsGPOVPCoz2iUIq1caC8lk1NVr0ioK6fEUcjkZwPubEbItb3aodxZwGq9lKHTMm3ydOZTMsdNH6o79+uNLw55hUtN7w91LdoF3HG4DNitSaeGnQGo8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4337853ffbbso24296595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808315; x=1763413115;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewq5bkR2w0X36y1ORHARtnHAU9dh8AjYpqdGWpuZkcU=;
        b=FPreqNnOGzm4aXr/IO9RczURiWp/K0NIzechasE008O90B3txpJvA1XlLvZKlC1hri
         9rC2bAPHpcSD3gAUgTMopVZzP/K0VaeV7yfNnXEhNpk7zs6YAk+xZqa7DnO8g9DujMaD
         zc5rL2TZDXEXcQ1hlQI42UK0L1HlJCTexDA+ZCJpWvQ42boYCFYz/FE7J9tiKUFcEqlN
         /6lNcePVkbyaPPR3OH/oCDPqkshmHyh/JzY3w/qEnlaEWbn026fTRhRBBiujZAG4Zy2n
         9bJEdQ7dWlezv43DdF6+XMN9Xa12tPl2EzGRY4al+6kz+yyBMG5FEcULr/nsouE4TTkU
         4KhA==
X-Gm-Message-State: AOJu0YwkfxjIO1OQjcFqvIZAjJTI0HIC/QirMlLYmWR/ChULhduWeisu
	Cj2ZOSjOVNM/KHVEf9xlV1JbZLceEVxLpl48VBqHCT5oYn/eZtT7HN8vS7VF03KsyQ0iUhAZs18
	NqtiEVaqHiqhipzM21P/O94hOMZX2BKD/ECJxSM106eVqkgp2SlrTRqX1XbPKoQ==
X-Google-Smtp-Source: AGHT+IFs8PmXv1l0MCHu7y8xC2O43VtMVeNlEDUBcALH6HzyoOfwZVS0gNRgK5upRzWjAbyu1RXZ+96miWUetA8+MKFhyqLGl75K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:433:7b4f:f8c3 with SMTP id
 e9e14a558f8ab-4337b502724mr85243475ab.17.1762808314620; Mon, 10 Nov 2025
 12:58:34 -0800 (PST)
Date: Mon, 10 Nov 2025 12:58:34 -0800
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691251fa.a70a0220.22f260.010a.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
Author: listout@listout.xyz

On 10.11.2025 10:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f8c67d8550ee bpf: Use kmalloc_nolock() in range tree
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=121a50b4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12270412580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128bd084580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d9e95bfbe4ee/disk-f8c67d85.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0766b6dd0e91/vmlinux-f8c67d85.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/79089f9e9e93/bzImage-f8c67d85.xz
> 
> The issue was bisected to:
> 
> commit e17d62fedd10ae56e2426858bd0757da544dbc73
> Author: Arnaud Lecomte <contact@arnaud-lcm.com>
> Date:   Sat Oct 25 19:28:58 2025 +0000
> 
>     bpf: Refactor stack map trace depth calculation into helper function
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1632d0b4580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1532d0b4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1132d0b4580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> 
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x5a3/0xaa0 kernel/bpf/stackmap.c:493
> Write of size 168 at addr ffffc900030e73a8 by task syz.1.44/6108

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2365541c81dd..885130e4ab0d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -480,6 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
+	trace_nr = min_t(u32, trace_nr, size / elem_size);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;

-- 
Regards,
listout

