Return-Path: <linux-kernel+bounces-824686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CEB89DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062AE1B22C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076931328D;
	Fri, 19 Sep 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbilZ7fB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5430EF9A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291623; cv=none; b=AHADIXRfBuNob9FpUKPtPFJfbBmEdRe1EG2ydVQo5bYSZiJB0X3S8mhlf5WBcan/cHqXpYtYThHSKtYVaSxGJi8lFqLZT0lD3z+li+G29KuFHxOFtTYGKGUPauqijKBb+J8Dd8oOshZp1XtmPNdKJGAH+GuUP3wLB5hHFri0s3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291623; c=relaxed/simple;
	bh=6wDeHUaSUio29Qn/e4s536kpfjYEfOUMdmScH+L/QMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn/ALMhOFryxEiQtwomq9VaxxoyDX8NLLoHccJ0eBPmL/LVmkjvGROLk9XeBm9I4QGytwStNWCQyZRS9HgTwizLyY6+hnCTpR7tArfpyIzGLJRuLiYWU5fzdSW+ZP8XZ11poDA4FNqV7QDrhDabE2SKoUuOwp6OPDy0wiDdrz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbilZ7fB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-467f6fd4e82so3503105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758291620; x=1758896420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwZsIOSn14ICQwFAa5DOImIhKXyqsEoAydL0O68SlV8=;
        b=lbilZ7fBOxZ4Y/YyLzD3Jdy/vS48LuCYCQTDrGZe9G278T53TOvmZHBHKtHJ4D37QK
         p9ZZKv/I1RDQwA1ImQqYzrZ4/m505aT3a2FjfWkYIAnxFF8ik885wUla+grgwyxbe+S/
         ZCnoGYVQYnYBrbsnDkXGMZB08mgdu2iwj2MXh6PLcpkeHX4TB+wUjpsGErdA61VqN7BB
         zUibWJ1FQSk7sBF/V0LMGPYTe3ZgfgTaCENkHKBYySDTg51sWLF18nH6AZn2dayhhent
         jYJVkQ84W5Q+OazGyNvUIVBmb0bDhdG7f7/iv8WZGU+BfQQPk9Y4QuHO+O7+6x2+rVvJ
         F+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291620; x=1758896420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwZsIOSn14ICQwFAa5DOImIhKXyqsEoAydL0O68SlV8=;
        b=XkGSW+OzukENV9Wxyt963Lhmfn8HRIE7EGluFicW2/D4h9madCk3H2xNRpAX3cdhpb
         olNecslWQFS9P+R+Dvdjl7Xfj7T15QLMME6YcAPVS2jLwaV8S+w7Oht5AGXq26cBxixA
         N060+vHeio2J4ybYqsLd5gQpyAq/EcSUq47PA6tD6xz1RN6Zw6PkWX9X8+4i7T8XurIj
         c1/9zPIZfnCRHiGogueoEvO7JQPKN/8txIxAI50RuMTaDJW2DlM+D+CHb4Q58vzEiOZx
         9nMWHLfrtkd/f6lPIE3TbBLnKWO2ZGfCTn4VT79a49KhjqRJMh0kAWK5MnrDmT2EZKxz
         Parw==
X-Forwarded-Encrypted: i=1; AJvYcCW/lYtMd9mBtqzlCyld4jix2lMCxsB02Csi6UPUFGUzzgUbKLstHDKUa1fdED/X2Iy1L/jc1RbJnsmeT7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt722xax7oatK5kSNv/nzym705T8H3+YXXNqS6py6Z8hIDTbse
	YSHgQgJfCm+mLJjow3f1J5Z60NXo0/JuvN2H3EgWHEqSDR5LI3y69LBp
X-Gm-Gg: ASbGncuzpiKxa9W7bOkKi4dVQyMqZhGN6OFS1v4YdBre8IOVj9P3+MQY+NjqB2f+eIe
	xgFvk46BSDrV+r5z/inxHmXDhcHpxxnw9gREsps5oCsKIFMWdlgiDEXz8T/lB+xH78cgzMg+T0b
	mPGdB+SNHqSG0+P+ZzTG3fG+qIhOh8vOA5egYiSnm/Rre31vmQq6iTnzpTPamQ/xUkI7QZ1ph04
	vS921yKx53iUNG7myd9mevAuH41iOobAru4thC8TsHPSbRM7LCuMCHHfsNq6eAXaadyP2G2SHYc
	uiHyt/kvW9TyuZ69Q5tFHhNQlhSLFRKlW8Ls4DNAP+DsTLgR8RFeWCWCqbFAeOFHoujLYoKQlwL
	g0VhWuoRANpOuqSKBG9tfpBQtW7SMVG6eYwmx04CenYNrOPL1vfkUuCgGULtyA8a6SSBx6OswLF
	VMsuWDViB01xxDpCGI4oAI
X-Google-Smtp-Source: AGHT+IEQ8XLrwES86GvYknJbSfQ9Bw+mDu0IdySopny8gUe/JXAb4h9n1e2tnUdp11KM6xRFzKInkg==
X-Received: by 2002:a05:600c:4708:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-467ead67be0mr25268725e9.19.1758291619463;
        Fri, 19 Sep 2025 07:20:19 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b45186decf855713.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b451:86de:cf85:5713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac439sm101908225e9.5.2025.09.19.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:20:18 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:20:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
Message-ID: <aM1moP0fr7GrlbWZ@mail.gmail.com>
References: <68c85b0d.050a0220.2ff435.03a5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c85b0d.050a0220.2ff435.03a5.GAE@google.com>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git a3c73d629ea1373af3c0c954d41fd1af555492e3

On Mon, Sep 15, 2025 at 11:29:33AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f83ec76bf285 Linux 6.17-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d1947c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355f934580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12170e42580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8eff1302251/disk-f83ec76b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1009d8f3246e/vmlinux-f83ec76b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5ba227871658/bzImage-f83ec76b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> verifier bug: scc exit: no visit info for call chain (1)(1)
> WARNING: CPU: 0 PID: 6062 at kernel/bpf/verifier.c:1950 maybe_exit_scc kernel/bpf/verifier.c:1949 [inline]
> WARNING: CPU: 0 PID: 6062 at kernel/bpf/verifier.c:1950 update_branch_counts kernel/bpf/verifier.c:2040 [inline]
> WARNING: CPU: 0 PID: 6062 at kernel/bpf/verifier.c:1950 do_check+0xe228/0xe520 kernel/bpf/verifier.c:20135
> Modules linked in:
> CPU: 0 UID: 0 PID: 6062 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> RIP: 0010:maybe_exit_scc kernel/bpf/verifier.c:1949 [inline]
> RIP: 0010:update_branch_counts kernel/bpf/verifier.c:2040 [inline]
> RIP: 0010:do_check+0xe228/0xe520 kernel/bpf/verifier.c:20135
> Code: c6 05 35 d3 b6 0d 01 90 48 8b 7c 24 10 48 8b b4 24 e0 00 00 00 e8 28 8e 00 00 48 c7 c7 80 f6 91 8b 48 89 c6 e8 a9 a1 ac ff 90 <0f> 0b 90 90 e9 a8 fc ff ff e8 9a 04 e9 ff c6 05 c1 d2 b6 0d 01 90
> RSP: 0018:ffffc90003b9f1c0 EFLAGS: 00010246
> RAX: bb0e1817e9dd7600 RBX: 0000000000000000 RCX: ffff88802faf0000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: ffffc90003b9f528 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1bfa22c R12: dffffc0000000000
> R13: ffffc90000a7e0a0 R14: 0000000000000000 R15: ffff88805b1ebd00
> FS:  00005555720d8500(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000003000 CR3: 0000000075b7d000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  do_check_common+0x1949/0x24f0 kernel/bpf/verifier.c:23264
>  do_check_main kernel/bpf/verifier.c:23347 [inline]
>  bpf_check+0x1746a/0x1d2d0 kernel/bpf/verifier.c:24707
>  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2979
>  __sys_bpf+0x528/0x870 kernel/bpf/syscall.c:6029
>  __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff4c0d8eba9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeb05e37d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ff4c0fd5fa0 RCX: 00007ff4c0d8eba9
> RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
> RBP: 00007ff4c0e11e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ff4c0fd5fa0 R14: 00007ff4c0fd5fa0 R15: 0000000000000003
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

