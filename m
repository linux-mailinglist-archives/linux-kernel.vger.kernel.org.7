Return-Path: <linux-kernel+bounces-894365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F9BC49DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F6A3A8BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0017A2EA;
	Tue, 11 Nov 2025 00:21:52 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D715624B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820512; cv=none; b=jPdXce5SHL8kVsHHHiT/Vrflvm4aIr/hNTUuK4Kitl6wm/PROsUfWbCM7G6OeMqpLLHhCyE4Y6Uhd18ZXf+3AbKhV2XcZPhq2jjxzpZGP9ATtFpqss/8io8TLM1kTu/mUDxSRm9MWXzsMGzqVOqiE63Fwuqk8Ec+prmcFSHQxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820512; c=relaxed/simple;
	bh=6mjUXX5ty2an74jDZFj1hCBeBjb6w7rSpmsewjca1fU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M9kK4GQNx9XvfCXabi75SvKGDn1OT2yHE5uOlj6Y7Btd5boD5KR/SqKNrTTJVhzZcKs1V0GbVCQleAo+L1z4B5j/6AX5tcacZbszipCEy/xcbJeHVRnAd659OdNUbbVAL5cbHeiT9/syP+wIT004RvBfkCF6bcMPXhySr2Rnm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-9489c73d908so209432039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820510; x=1763425310;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7B4mQWkQEHGJTBAkWyDvxLatGB7Acj+QxRCPB3XOPk=;
        b=JaHfpqLkVgYngUyD/BK4tMS1x85jJpGvCln5ZzrgYZVZMearpnPrrTvFvH/9+BOi78
         XD+7es76jVmCsUOkrRY5fJALfhzyfSxHd6l5PwPkoEgRSqqRsKUqbIIDYy+1mwdSJWbB
         u+ly44QOTjVogNw4kaaZmtF1tOCEDbs+RLtt0Lzqlmk4FzDo4gcBuW5sTje4qbS3cXcH
         uR+Dpht4HBsSHrOV29Z02W8Y7gMBgkBxyL8oK1lpWgi7Oa3TlXP76F6LTmey2pGXUE/X
         PJDe72CBjVp1E3mrN7Qlwm+hvCkeNOrooMYP2qe9umojwZzPlktTbWjmkcW7QStBaPNZ
         GSOw==
X-Gm-Message-State: AOJu0Yxv4YfQKV+wNOqHbHUlzQVF6ejqud3TfehwVf+dEqep40uvmEbt
	U0GBa+JoYbsb/LWxXMAT7vNljqicercSncgXIWYo2ReFkZy+Dna51VPV4JbLOf+oR2e9paDkhJQ
	i0GvENaCqj49w0KYeAPVz8fwxpUh/E0EWcYYiGnebJiLj6JzbNcyAXLoUWtlreg==
X-Google-Smtp-Source: AGHT+IHuDwCHxSv2/DnICH7NuHisW0Ujx2ahjlGQk5/xPoZ/znZzDmmc53eedsKPZM/b9RKqjiqRSD2Z4lXIOdwHE1W7iQzLx5xW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:433:29c3:c4f6 with SMTP id
 e9e14a558f8ab-43367e46ac6mr148752655ab.15.1762820510153; Mon, 10 Nov 2025
 16:21:50 -0800 (PST)
Date: Mon, 10 Nov 2025 16:21:50 -0800
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912819e.a70a0220.22f260.0114.GAE@google.com>
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
index 2365541c81dd..f9081de43689 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -480,6 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
+	trace_nr = min_t(u32, trace_nr, max_depth - skip);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;

-- 
Regards,
listout

