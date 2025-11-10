Return-Path: <linux-kernel+bounces-893959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81069C48E88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91D31884B56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4032AAC7;
	Mon, 10 Nov 2025 19:01:44 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9430BB95
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801304; cv=none; b=AaNktvlQ1Y+3VuVcnXkhZCfjmJL+PPGs69dnQgc72DalfSKY5qCbAue90N4PmUuUwtdI3wvp6E71N1F58eg8Ox+gh0ah2uV74f70MxfRs7RkgdQGvDJsWaD6B3qlNpafeVG9RmhvrehIybQW8SiHDGGZVjQzi8mgj+Gun3uxFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801304; c=relaxed/simple;
	bh=CtJjIVCozGoxnl/YnDsJ9euvZLtczherF/NHaaFFE1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dFPKRn2OBSSDACcNwtqNMP9NNvbaN4k4PWdZt7scEzBM+wx/sdv/1PSDvSb8Rg8B2QbT2kfMdGwJt8OcpaZweNgaKt3IyYV73uRIVS0WT6oAHVE1zEdIcGxf8DgQZGiiJnx+9zPoce6zUT+8J2kc/AKSC02CO6/LDs6g30oUKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4337e902d2bso14587265ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801301; x=1763406101;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVoyYeuJL//FvxlkfjGcCf8LDeV1EsoUSvPnL0cwUqg=;
        b=Fw4CVn3Q+YmcGWM3zT0LFRdrbxbdXUZPk+knkBU3rnDRv9rdWdX7o88TagVwGSL8Ap
         CvBsqv9YQKCubMGxUWbCHpsHZxm5b7KxjHbPkbAaeb/ZpDwyeVNLqvDfWYJ08ZknAeUS
         a0k1KEbOmSv6WsirIldoifzcEj823mQR4clG5k714iVBBDyD1N1HohQfW8yoQ0AxSh4g
         RdLHCa8D1Dx+gMJdRWB7jRnuJThy9tRq41WvTswU8LQIL8kORtroR2K2UYo2psWQJ7w6
         zeeymOrJWiaHpUWH3gPQwUPt70eTQUlMFDDs/9vZi2pE8gEcQTW7qe3+FzFhXYxYvuZN
         yTVw==
X-Gm-Message-State: AOJu0Yx6yIr2/vN/J0k255gATSVss4bEuM1DDy7U55vQXJW09ZbLErGT
	klgrITHu3MlrAQIQa7Z+9+4+Uz2ttAjfbei6IkUiIfZOlqcrt84/QQzKGGXHxuD8THdgmgjY8c7
	Nk6zSRLzZX586z49JwTiosKZQm4nv+6oAGC4hsIe5kNKryuGljj6POi9gI/E/dg==
X-Google-Smtp-Source: AGHT+IElVkIjAazOhcfWzHB48JxAuMSzO9a5g+WwcLqU6yg31gZzETnGsBkMbcg+On3DL28BeT1OWsglNtlSfbbZIH1xGuBTWTU4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:430:aea6:833f with SMTP id
 e9e14a558f8ab-43367de82c6mr120562845ab.8.1762801301108; Mon, 10 Nov 2025
 11:01:41 -0800 (PST)
Date: Mon, 10 Nov 2025 11:01:41 -0800
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69123695.a70a0220.22f260.0103.GAE@google.com>
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
index 2365541c81dd..c68589d0f5f0 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -479,7 +479,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 	}
 
-	trace_nr = trace->nr - skip;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;

-- 
Regards,
listout

