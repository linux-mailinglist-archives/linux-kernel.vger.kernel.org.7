Return-Path: <linux-kernel+bounces-851523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA410BD6A75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB48B4E1AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4362D94A2;
	Mon, 13 Oct 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLuzqSym"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE72AD1F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395532; cv=none; b=HmkVq79VP8BSLkkR9f8tunngKR9kIwOIUu3x3yMXBpqXZw4ypYQ16QzqIoV3s3Scn2h3VQJkBCIMW+i6hSFMhhxhgy2gT06Vgyc32JPAGCnA3reU5s30orfuVhq/QYl0tmPQu1O0l6hPbYv2+GUpfSbIAsd8+PGf7CNAHX3yx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395532; c=relaxed/simple;
	bh=RfuMQXyjPOT3ma5AnLtDpYmf16fg8dWi97XBTX6XRfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3HeBmhOUmMYfgt6Adw2zOA6UpvoizgYambIUFI534j85PTjGIXtpRXlgrfpfD9ynl+1yGZprH5ztqFGsMJSNv1hKlFGHkON2MFllPuMBIw89P8pnEbs1T9R4mvOE8RFrKgTj2RQSi9+cjlPGkMMtTMvN+OqjNBiqp7fZW2nVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLuzqSym; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-86420079b01so673923985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760395529; x=1761000329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRmnGZ/zy42nYZ59qh1y+RW5G0WN1Gjc0jyym9RgbUs=;
        b=sLuzqSymwpGrNgcnyDTuZ2n37T1BSb6jCqW/RE1g0Id3nZ6RvU+B+ZgfqFfmQTmpCT
         MCyzzkVy6qc0PKlIChAL6kq7IzdknBmqEIvSEOSknHdiYqm5Y5Dons9olsn3Qqht+/fb
         TuduuX82KxfXqi5cD12S8lznGl1u0J6mYYyS6e71uOg7ZdVHexUQZMgHg+lxf3i9mYKB
         EdTc95NTf1hBU5Fy+MwAPsCbD1mNZwSTEFifWMEGTROm9+N3EwHIpmcQ7/yKNoINnIPC
         yi/fHbfdlbyCUwU7nbPQV61GRq/IZUp6PtfHxd4A2JcnmIRLV7JtCSMUSfOUAIz6Z+kb
         3JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760395529; x=1761000329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRmnGZ/zy42nYZ59qh1y+RW5G0WN1Gjc0jyym9RgbUs=;
        b=DdtN1F8c2pA6XKgy/BLsxRraSrXVaOgwHtigldcSXeZsUhPVGwe/MaUjOXWbLTQkz9
         XFLcaYeeFgprsDOqtjQ+16gjTaXPctt/NRbXXx6NJGT4XqwsK12YWuy8yP3LpDXWgATr
         V7Glz1RKPH907KYYhLxbUjVNN4OZTYruG8WF7e6egVhtFsjiMSFr+kqjU6IJh8EiQL+n
         RfEEUhcGw6UyTpyUFhi7iRYblztfeEiZlspM5zUQHK+fwQa5X1cADupooQGE9Cbd/ieV
         smlwAmI9kCCqr2vZL1nvtJpgUWrb3/lGBMkfymgGX0Yu5BvrFdIlKCYUeFKOIAA/UBnQ
         I95w==
X-Forwarded-Encrypted: i=1; AJvYcCVAuHU5HBmW17ImRvdsMWnYdZOi3TnQlceTWgh80ZzprqmKcUcZlLYdP4iXmR1XzskvGM3jdbsD29BztqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uRnX4ClQKmWs+cAUPKF9uFIe1i1B0ciKfySjkk1YqAXRgWcK
	92ciZST/a8b9xXytedP+Bew5ijVBJCzYbvJEZDsvUixbFA7NuFisZUYN/dKlLonr2AFsZefuDmY
	Ck9d5+1OOoyVIc2j1KQo86cR6Sv5hCahQC/4BaCKB
X-Gm-Gg: ASbGncvMav07X8dWBjTjoM1yeannW4JBhGBH0a6wcGkeZViyi86b+SZwTFV59mMWKZG
	jERFhj5LSHJxqNX0GNeZhPgQ1411TWek8p8YafosIqvozVjYHyy+cbgq1ownZthOv7GDS4KR5h+
	4rew+cAocewZcB3qKcziilLdeq+zlT04IkjBxBTyLfrgU7W4c01dIo6ep23gQ6/LCD4vIntkvpr
	FfkPaYWe3g9M+IizTFwpWHgbNEySEg0
X-Google-Smtp-Source: AGHT+IEyBQJ9+NgnI6Vwc1iMLsIARDSgmDHZG2d0g69sBmPQuXWvD8cfj/l8HU8MSPv7cgoRhl3h7KQQsaUDkW61vS4=
X-Received: by 2002:a05:622a:5a14:b0:4e5:8d07:ce80 with SMTP id
 d75a77b69052e-4e6ead542d9mr346004041cf.41.1760395528701; Mon, 13 Oct 2025
 15:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68ec1f21.050a0220.ac43.000f.GAE@google.com>
In-Reply-To: <68ec1f21.050a0220.ac43.000f.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 15:45:17 -0700
X-Gm-Features: AS18NWCFTriU73j-H3EExYu3Yo_Vbc9WWcxv9a8UY6yK3Ksi9QNsg56Zjms1Scc
Message-ID: <CANn89iKbof0PsFsPgdhMFeizu9uEkgmqWSQggDQ8EXA5jfxMRg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
To: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 2:35=E2=80=AFPM syzbot
<syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ffce84bccb4d Merge branch 'bpf-avoid-rcu-context-warning-=
w..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D112559e258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e0e0bf7e5156=
5cd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D999eb23467f83f9=
bf9bf
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1514d304580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cd489c5f530a/dis=
k-ffce84bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e4a06e8e5022/vmlinu=
x-ffce84bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c1111b7581ab/b=
zImage-ffce84bc.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 36 at net/xfrm/xfrm_state.c:3306 xfrm_state_fini+0x2=
6d/0x2f0 net/xfrm/xfrm_state.c:3306
> Modules linked in:
> CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT=
(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> Workqueue: netns cleanup_net
> RIP: 0010:xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3306
> Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 4b f0 36 f8 48 8b 3b 5b 4=
1 5c 41 5d 41 5e 41 5f 5d e9 99 e1 16 f8 e8 64 4d d1 f7 90 <0f> 0b 90 e9 fd=
 fd ff ff e8 56 4d d1 f7 90 0f 0b 90 e9 60 fe ff ff
> RSP: 0018:ffffc90000ac7878 EFLAGS: 00010293
> RAX: ffffffff89edd6ec RBX: ffff888058e08000 RCX: ffff88801ce99e40
> RDX: 0000000000000000 RSI: ffffffff8d9cc7ae RDI: ffff88801ce99e40
> RBP: ffffc90000ac7990 R08: ffffffff8f9db437 R09: 1ffffffff1f3b686
> R10: dffffc0000000000 R11: fffffbfff1f3b687 R12: ffffffff8f5d4bc0
> R13: 1ffff92000158f3c R14: ffff888058e094c0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888125e27000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007eff78efa6b0 CR3: 000000007788c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4354
>  ops_exit_list net/core/net_namespace.c:199 [inline]
>  ops_undo_list+0x497/0x990 net/core/net_namespace.c:252
>  cleanup_net+0x4d8/0x820 net/core/net_namespace.c:695
>  process_one_work kernel/workqueue.c:3263 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>  kthread+0x70e/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

#syz test

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..17240503a366 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1744,6 +1744,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)

        atomic_add(size, &udp_prod_queue->rmem_alloc);

+       secpath_reset(skb);
+
        if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
                return 0;

