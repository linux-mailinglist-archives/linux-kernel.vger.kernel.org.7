Return-Path: <linux-kernel+bounces-890912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F33C415F5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D6189EA60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F133F371;
	Fri,  7 Nov 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7FLUTii"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67433CE86
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541965; cv=none; b=eoVQV1/tShHgbPEKakHANBIFoZVOuJUVfY80vGv+O9NRGdIbQFhCx3J62eemgXE1wUmBcPZi6UsKzvgL6nj5loNAuhetroRi7keYI6/fWSdRZ9BPioBfBDRRqtFMmmbSffdzkFtpnT6AhERPCIuty3JIJQCuxyIGcWzZL5w77LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541965; c=relaxed/simple;
	bh=4QZQ0tYqAfqGb6pJqJdH0IqBpH4SUtRNGTp6WgcBHzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X75XVcJA2+GKlEr8mSMal3EJzSCgjwlinPyG5WAAX3Fc+S4JeDNdHVNCh4k7VFGaSyTUX9AY00qDCqY64o22UNYz08BcfGNNHFHhOIQodBCBfXsaYLAIBOwuHs7Cz0YB/pUGOytPuKaDsoX15w0DkeJQcWMbJ5aXqb5L6LO4eV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7FLUTii; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6cff817142so1372934a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762541962; x=1763146762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3EjyvPOdATJCrf6iEkwp5f3Nmf35StgvmIvvVwbGNY=;
        b=J7FLUTiib73iBus3k6XGwqLQg74srbqksZ7nnKujrckcbJXPM5qF429Hc2kuYwvWyE
         wG5twO1yYsMUA7PVU7Si8dmO+KQVC2MgzQtfLaiuNHkikQTVlIZt+KaPVE9ibEHIf5mf
         4+HiM0EWtmQOFLMmOGNr5OfUqcYoTCeII6ESpaUtJ+pE6B+hK71C4V/vxlc7bX1M35FG
         tMfaWLTmnXQkNBu7RYy5HeLnnp4FzbPa+1s9FP6aXJiYA2SD+JB8c/Urqj3pR7vakF0W
         roQfu03np7K3M7eULW0/k/0lh4+YstlZR9cXcGZjAMkxp9INNKDxY6m9AZ2v7sT5sPP9
         qCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541962; x=1763146762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3EjyvPOdATJCrf6iEkwp5f3Nmf35StgvmIvvVwbGNY=;
        b=HG85F650O2FB0BgT3cGIz2eUb0obRbWc/M/kpQwICCFiASd/7xSCEQZN8qk2l3Fr8X
         hJB1KilLQ1LY940nuGlhWn86IypyEXqpZ84KmSvvZaGqXbFi6IbV1MUivbIDbsN5nJB8
         E+dJjOMxiADXAbnBGxENnYzjeeRqj8i0e70EJTEAhkG96xzEgA9LTO+wxT5GpPX328nf
         RAHqnYtl1bngrQSHlZcV75LJvfGtq+RYr5O9roj8aYi93gsqfo7OEMmYIftE6tuCh9Na
         S2OFNvp2m4gT0CCoLQtYrCe49pDskABFDEz4OIeYy7+h/Lo4sulcC+J4RrQ3r+PJNxZI
         h71w==
X-Forwarded-Encrypted: i=1; AJvYcCV8nRO3XKoSSn0cbML2Gqcm5rDneueSsxTbsysPh+ODsAejrDB/8GK9N3ii8caqltnhGKqgrTrw3p90nGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oxR4OPhQqponxBAtx299EupNCa3wOPDH61ntgvUsv0hN2u3r
	mFslb18zac55YviFMtUx5hB8SCWdQN9YiwHwLFTi8CVbqqrArb+Pe1P2Ceb9U/IwX7tsZp1Euhw
	5++zJmA==
X-Google-Smtp-Source: AGHT+IF0qsHz/W4ruaoPoUNgsNRlI9dg6Q1KxJ3doX3TWqUOAcyX6InMoydoaL0wMNT5EnILC3E6gDJbdn4=
X-Received: from pljs5.prod.google.com ([2002:a17:903:3ba5:b0:269:740f:8ae8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8a:b0:297:d4a5:64e5
 with SMTP id d9443c01a7336-297e56be279mr1930385ad.30.1762541962031; Fri, 07
 Nov 2025 10:59:22 -0800 (PST)
Date: Fri, 7 Nov 2025 10:59:20 -0800
In-Reply-To: <690e0be4.a70a0220.22f260.0050.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <690e0be4.a70a0220.22f260.0050.GAE@google.com>
Message-ID: <aQ5BiLBWGKcMe-mM@google.com>
Subject: Re: [syzbot] [kvm-x86?] WARNING in kvm_arch_can_dequeue_async_page_present
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+6bea72f0c8acbde47c55@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 07, 2025, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9c0826a5d9aa Add linux-next specific files for 20251107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a67012580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4f8fcc6438a785e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=6bea72f0c8acbde47c55
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e110b4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ab1114580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6b76dc0ec17f/disk-9c0826a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/522b6d2a1d1d/vmlinux-9c0826a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4a58225d70f3/bzImage-9c0826a5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6bea72f0c8acbde47c55@syzkaller.appspotmail.com
> 
> kvm_intel: L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
> ------------[ cut here ]------------
> WARNING: arch/x86/kvm/x86.c:13965 at kvm_arch_can_dequeue_async_page_present+0x1a9/0x2f0 arch/x86/kvm/x86.c:13965, CPU#0: syz.0.17/5998
> Modules linked in:
> CPU: 0 UID: 0 PID: 5998 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:kvm_arch_can_dequeue_async_page_present+0x1a9/0x2f0 arch/x86/kvm/x86.c:13965
> Code: 00 65 48 8b 0d 58 81 72 11 48 3b 4c 24 40 75 21 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3e af 20 0a cc e8 48 e1 79 00 90 <0f> 0b 90 b0 01 eb c0 e8 4b c1 1d 0a f3 0f 1e fa 4c 8d b3 f8 02 00
> RSP: 0018:ffffc90003167460 EFLAGS: 00010293
> RAX: ffffffff8147eee8 RBX: ffff888030280000 RCX: ffff88807fda1e80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000009
> RBP: ffffc900031674e8 R08: ffff88803028003f R09: 1ffff11006050007
> R10: dffffc0000000000 R11: ffffed1006050008 R12: 1ffff9200062ce8c
> R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055556a8c3500(0000) GS:ffff888125a79000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000072cc2000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  kvm_check_async_pf_completion+0x102/0x3c0 virt/kvm/async_pf.c:158
>  vcpu_enter_guest arch/x86/kvm/x86.c:11209 [inline]
>  vcpu_run+0x26be/0x7760 arch/x86/kvm/x86.c:11650
>  kvm_arch_vcpu_ioctl_run+0x116c/0x1cb0 arch/x86/kvm/x86.c:11995
>  kvm_vcpu_ioctl+0x99a/0xed0 virt/kvm/kvm_main.c:4477
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1588b8f6c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdfcd816a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f1588de5fa0 RCX: 00007f1588b8f6c9
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
> RBP: 00007f1588c11f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f1588de5fa0 R14: 00007f1588de5fa0 R15: 0000000000000003
>  </TASK>

/facepalm

This is due to a new WARN[*] that was added to yell if KVM tries to process an
async #PF after the guest disables *PV* async #PFs.  But I completely forgot that
KVM uses the same paths for non-PV async #PF (KVM doesn't inject anything into
the guest and instead puts the vCPU into a "synthetic" HLT state so that if an
IRQ/NMI comes along for the vCPU, KVM can immediately delivery the interrupt).

I'll simply drop the patch.

[*] https://lkml.kernel.org/r/20251015033258.50974-2-mlevitsk%40redhat.com

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

