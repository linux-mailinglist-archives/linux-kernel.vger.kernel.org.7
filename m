Return-Path: <linux-kernel+bounces-894345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C619EC49CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6092434946A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E172FCC17;
	Mon, 10 Nov 2025 23:43:07 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCD23504B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818187; cv=none; b=WU3xW7IgLNd+Fi90IZGDsCYodyGNdhaJL+YjWYnGawl37yzlirfj4a/DbHhS3H+YfeP1HPKv6zZefaieSPAKiHq4yvWjBl0go2y86MAJvf6UKVV5DJ+QR9qa5nY5Zwz0KkaZt19OlnQxxot0+WOa0H/+0RKBuSUqNFr90GI1jB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818187; c=relaxed/simple;
	bh=1Tm7dI8rO1qCZWzjTuJV98GFa5zGkLa0WpgnqXvU9P8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h/hMclogyypPJR/e1bk4wpbCtFgCGHQU2j3f21TjQmNYjVTUzQw+EjGDl6DzcdJjUFm0sEMMQIwsYlzNjd2MoMX9xwreNiOYXUWWYYdsCVBb5XBk9eSCEEI5XiPXQI3Sp0cFjLwbY7FAmhbqifim2mhQ/u6D/ws5LrTWIqMKD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4337b5c3388so69008355ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762818184; x=1763422984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1KON7NApelTWlL/ZiB/7Rnk5iXtVVNjGOekd8Sqn+s=;
        b=fqqcTIozFzNydx7/xZpb9XXiOHI3gEGyPr4zOfKHS8W/Xiygv2EcPvRYSm4f/LApt2
         fheidsH8++ua1JgioHfy5Ns4k7PBq81xL8HPUQjvYUMWWMXtkQ2S53/IlblPR/vOSFMs
         hI4wlNZHiwIbj43bBGv1lq5sOZ4uDZEEkfP36rm8Kz3api+SSGlhrMr+oRxAvYYWwNdS
         xYRb/2l04rtyYfxdEVmLezDfhwxf0aoisiKz6WSO97U9fw5r247vPJ3uHQmjJMZ7Yn5l
         Jm2Lumd5pXaEx1KsO1fSsAOXQjxnvuUkFTcq/AWOuaOKdTW8VQK4KW0+lpX5fUdtMULT
         VfZw==
X-Gm-Message-State: AOJu0Yyd0qCQ+VnX4f4FOf4q5qgv/qfJMANzbgRfTg8WaLBCECQzJARW
	naBLdXcJj+z7A76cRnAoi8fJAqeEZlkPm36uTiNjpiuVC9lhlSJ78V7qaQ006PdYkPna/Q+1vf2
	/IPOpv8Zy6X10Ian33p+byX8uH3xrMfAz7WLeQvv1BQYiG/r/42pnbcHjbcJSCQ==
X-Google-Smtp-Source: AGHT+IH4EnwuZEFO5PBWCxNX2lf00xEri5LP24VFqJPkVyiK7vZcMcB7y00RyaLVfEIBlj/y4Dq9tnQlZJeUox/TaW/fHcQGMf7v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3389:b0:433:7c86:74e7 with SMTP id
 e9e14a558f8ab-4337c867a00mr82036175ab.19.1762818184001; Mon, 10 Nov 2025
 15:43:04 -0800 (PST)
Date: Mon, 10 Nov 2025 15:43:03 -0800
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69127887.a70a0220.22f260.0112.GAE@google.com>
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
index 885130e4ab0d..f9081de43689 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -480,7 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = min_t(u32, trace_nr, size / elem_size);
+	trace_nr = min_t(u32, trace_nr, max_depth - skip);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;

-- 
Regards,
listout

