Return-Path: <linux-kernel+bounces-828397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F265FB94899
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629AB3A5440
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D930F547;
	Tue, 23 Sep 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uA3UD+QC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAD272E5A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608410; cv=none; b=DgYpmhSoSYvxWrqPMn3VLXDmVF4PDvpeSVzpAVgEISfGQC9Q6P7WfECXNQikUonrxlN8gTy5l+YLRXr3laiHsp39oTaHcxj91kvYyL0VYhfLdCydtZXqXrqTa6poLKNi2xo5iXFKC6XcFsKGXrmyL7UIfNTnfGnqmvRcNZfyswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608410; c=relaxed/simple;
	bh=kXzi/AdDm9R6kXPjOOiL+ob+ybXp/Y+U1Y3WEsgDI+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IETmEslaqJE8n65lvYjG6jnKh7zWLiBgf0Do6wtjV93pt2aL5t/1Q713U9BbJaE9wzOe9hXrcp2968roNVCaVS3j5Y18BGyUJVIWvWAEIYKfBNj7xlHt1lg2fxdXbOoceKof6r04ETAQwRajJWbSTscyxLZpoXefRX2idTcFIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uA3UD+QC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2570bf6058aso69992815ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758608407; x=1759213207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jizzFJog81LkXEjDC1RwUD25CL88gs7khraRRR3EjFw=;
        b=uA3UD+QCUzA7bero17Fgt2mGmF9lo4iefiBYyrzw1E9cXbFXbsCngawhqmkyvfCi95
         q2QhWr8qYIZSGh8KBehpTUYZRyaIQKhgbzaW7F/8xa0yOyzpRREcENxXQ58a/mdbTHK2
         wBla0x7wqYeq6JmUXEFiU+X3cogj2XR2wflQ+kpv/F53VCEcHVLWExTHID1A5b4CRQsD
         bUvQiNrm2offs4FG+JALqrE0zFp06klu/gJJte+oRkZg9KkUhwP1SkBBh5rLLCxQwv0h
         H4+iUfCbakzdgrjCkgDJ2llMcG013BuERYc8RP4I16j2tu4PuVqXDOnRFwgDUNxDHEGZ
         XfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608407; x=1759213207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jizzFJog81LkXEjDC1RwUD25CL88gs7khraRRR3EjFw=;
        b=aBmGQ5JJaV5dnMVTL3Xw3AwyE3bMcMEm1giy8lWKaKKZ7zjY+p27MTivecW3Bj/krx
         3XmZsksnt+ixgj3X0wjzgu3nO//eI//C59c8QPtDSwBGzQEYDWcljVPIs1qW39FP1tZI
         wl0qZJkukDLKNSZn7pd5f7VJgiq8hyNz/7WHYoDlAZ2WCZhWDsUiZTrgEXQaa7BonV6/
         AYF2E0D8r4wJzmLjlRAUwmInZgnjpS5WUCuKO5i0Gvzpl880PUvur7u+cFPk81AlHNr6
         4z1t398wQuDG+c4L6zo1un1CusB+2R2Xjt2uCgXupR3a1IsTFVQG65ogsnHy7si+KcAH
         iYmw==
X-Forwarded-Encrypted: i=1; AJvYcCU0mrHxpMbdqnu0WUNNMrXqowIyrEGKcCEzItD0UgOYHhnke1sBuaWsV35msYAv8Sm7TeHqLHa75ai6SDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3h4giErlUFnmmc0UyoMbFDUz3x/fbqd3NZuflrBlv3YpkO+fn
	6Q3tyju4Ur1MlxP39oSlam1hMWf3u5s/xKSBbHc9Cd16NWxzLu7TE0AIl2Gt187jmoU=
X-Gm-Gg: ASbGncvS8h6+v1RV22IA6Kd2t3pbgJNwLhyGkA18swOEyD0Uj4GvNyZQwHF81sDvH1/
	9LaGXtOWTlWbf+IC0XTj15PhDDn6Dvykv3E2yObLfcs3Hi9NLyLSBsTf9jiQMLsmMIp9iWaAoaD
	4ud6uW2JxWjWORHIlJDhnqOA1g+cGdFQk2D0oIcEZbrImzAv4WdDuEuU8vLEQYpHYxIR2/oSuzI
	uHNEzd94ST/CT8C8pdJvBFfWeADZlpyLBPc0w8xLgdhjf1FXRp8JEeQAVvJyFzQKL8NCwtoUvA/
	MwypGS74IwP59UnITOx2qkRMlgdi7vnNBI3QGjwqW8/0HOMyAadh0GwXeGuY5GRMNGrOPX1lQSH
	89Xg3heZGVWyJbdkEh9b5
X-Google-Smtp-Source: AGHT+IEP1Lmeml2cRAXKqLL1cgxIeVeR00wZuCWETxKJlCGo0WOv+ZkRLV4ISZCg8IuXG96nps50aw==
X-Received: by 2002:a17:902:f605:b0:262:4878:9e13 with SMTP id d9443c01a7336-27cc499895amr20309075ad.26.1758608407584;
        Mon, 22 Sep 2025 23:20:07 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de963sm148614525ad.77.2025.09.22.23.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 23:20:07 -0700 (PDT)
Message-ID: <4d1fd301-cd8b-496b-b5da-de8b9f17d44e@kernel.dk>
Date: Tue, 23 Sep 2025 00:20:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] general protection fault in
 blk_mq_free_tags_callback
To: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Ming Lei <ming.lei@redhat.com>
References: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68d1b079.a70a0220.1b52b.0000.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/25 2:24 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c238e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e427c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bb8142580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c53d48022f8a/disk-846bd222.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/483534e784c8/vmlinux-846bd222.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/721b36eec9b3/bzImage-846bd222.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 UID: 0 PID: 5962 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Workqueue: rcu_gp srcu_invoke_callbacks
> RIP: 0010:__list_del_entry_valid_or_report+0x25/0x190 lib/list_debug.c:49
> Code: 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 89 fb 49 bd 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 af 58 47 fd 4c 8b 7b 08 48 89 d8 48 c1 e8
> RSP: 0018:ffffc90003d2f8e8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88802f573c80
> RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000008
> RBP: dffffc0000000000 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
> R10: dffffc0000000000 R11: ffffffff84b089f0 R12: 1ffff11004cb1e1f
> R13: dffffc0000000000 R14: ffff88802658f0a0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055946acdc950 CR3: 000000007a708000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:132 [inline]
>  __list_del_entry include/linux/list.h:223 [inline]
>  list_del_init include/linux/list.h:295 [inline]
>  blk_mq_free_tags_callback+0x5a/0x180 block/blk-mq-tag.c:593
>  srcu_invoke_callbacks+0x208/0x450 kernel/rcu/srcutree.c:1807
>  process_one_work kernel/workqueue.c:3263 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid_or_report+0x25/0x190 lib/list_debug.c:49
> Code: 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 89 fb 49 bd 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 05 e8 af 58 47 fd 4c 8b 7b 08 48 89 d8 48 c1 e8
> RSP: 0018:ffffc90003d2f8e8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88802f573c80
> RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000008
> RBP: dffffc0000000000 R08: ffffffff8fe4db77 R09: 1ffffffff1fc9b6e
> R10: dffffc0000000000 R11: ffffffff84b089f0 R12: 1ffff11004cb1e1f
> R13: dffffc0000000000 R14: ffff88802658f0a0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055946acdc950 CR3: 000000007a708000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:	90                   	nop
>    1:	90                   	nop
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	f3 0f 1e fa          	endbr64
>    9:	41 57                	push   %r15
>    b:	41 56                	push   %r14
>    d:	41 55                	push   %r13
>    f:	41 54                	push   %r12
>   11:	53                   	push   %rbx
>   12:	48 89 fb             	mov    %rdi,%rbx
>   15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
>   1c:	fc ff df
>   1f:	48 83 c7 08          	add    $0x8,%rdi
>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
>   2f:	74 05                	je     0x36
>   31:	e8 af 58 47 fd       	call   0xfd4758e5
>   36:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
>   3a:	48 89 d8             	mov    %rbx,%rax
>   3d:	48                   	rex.W
>   3e:	c1                   	.byte 0xc1
>   3f:	e8                   	.byte 0xe8
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

Adding Ming, looks related to the SRCU changes perhaps?

-- 
Jens Axboe


