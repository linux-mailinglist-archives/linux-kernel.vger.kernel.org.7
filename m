Return-Path: <linux-kernel+bounces-893977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C605C48F45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 764A14E62D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787A32F762;
	Mon, 10 Nov 2025 19:17:45 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68B2F998D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802264; cv=none; b=esx3XiJw5aeNr2JxkI/nil+tuSJlSRibUJ/qZO1TMVug6OaqMUYFaiXgCBkduY/1wsqB1c3uqT9nxC5gAO8F1dSHW4XlfB5X0OF3EkWjQOz8UPhSJ64wQA/SU+08xoEXcAK+4Bdi2GgsAcNScazRtm96NVin50Ko45D0VMMT88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802264; c=relaxed/simple;
	bh=7ohetOPU9prv4mlmaLaH231JyuqfOgFwKopQ/P2r/kM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AxjgA97Wyairu5w0YnFegA1aCAZjm2u1Eg0RPkhhdxMmNxcQ6eG/J19ItxDbw5jOCcxRnFMP+tv4hjgTHnPHPoEdd8puFP3pMSmuFybv8IG+eqmYL1nmGXgc/5s9ONdrNdJqL4F5do5rK1Ay63BQY3MHihga9qU7SCTbDClalOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43330d77c3aso125254765ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802260; x=1763407060;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+Dh0ealzLswN7Gxp1zzcu4/uoupEjjUgbERz4XZ1Sg=;
        b=j49Tpl5KyRkrqiv/hUB1CQfPY3VpRosn7gB85R0gi7DO2lMpXC9KuQs79kjoDu+Qd5
         T91iftwi7X4NywdvGCRaDDevmUq73XePmmluTjOzB1AfDm24KXx11C3ybLRsaSTyjRMI
         q/VpqVJrKyAGvf/IT2HrbTQzcB4zgufxTFq9J0h6bMgpaC+ATlu4JDx0NolYgm6QsiNS
         QXZwrp3bXTUJHYdkXSWt71OWmhfbr2upir9Q8KPIqm97kI8HQiTfD/a+PQI5rzdvdHYz
         Z5bLEPeOg+KwJSHUuy/3YbypGjLnj9hamClz+QxM0BcS5wkZmGxqjNUbXQXlbeTVZYPi
         Vz6g==
X-Gm-Message-State: AOJu0YwUZtpQvluJBhIiTFwReYUoycuhcI38jH/cMFmx79UYLzaA1XAc
	RvKZKdfREuFeMS4vQgcuBGR6AbjA6Ld9RTEOXtN42vRde4Pjwby7eqhFr89ZLrEmfNzo5B93ZDs
	5FIX25NExZ2A0enF85nfj2YbtJRB2835ZKuZhjBAjC2ykM9VXssAiLKhoYemigg==
X-Google-Smtp-Source: AGHT+IH9OChcdileBDQQgNqD0jYcbx5Tm8L5dA5BY9/3WEhH4uM/YXtub4bfO0nDIpcQfNv9cAy5r6Eno3hWNcoC0rs2DnhHXq8o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:433:7d68:d579 with SMTP id
 e9e14a558f8ab-4337d68d630mr79207255ab.31.1762802260072; Mon, 10 Nov 2025
 11:17:40 -0800 (PST)
Date: Mon, 10 Nov 2025 11:17:40 -0800
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69123a54.a70a0220.22f260.0104.GAE@google.com>
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

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2365541c81dd..2db09ce39828 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -480,7 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	copy_len = trace_nr * elem_size;
+	/*copy_len = trace_nr * elem_size;*/
 
 	ips = trace->ip + skip;
 	if (user_build_id) {
@@ -490,7 +490,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		for (i = 0; i < trace_nr; i++)
 			id_offs[i].ip = ips[i];
 	} else {
-		memcpy(buf, ips, copy_len);
+		memcpy(buf, ips, trace_nr);
 	}
 
 	/* trace/ips should not be dereferenced after this point */

-- 
Regards,
listout

