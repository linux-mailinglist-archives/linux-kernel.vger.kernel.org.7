Return-Path: <linux-kernel+bounces-760533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC24B1EC86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A835817A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A2286421;
	Fri,  8 Aug 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ofet/XCe"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB5286416
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668487; cv=none; b=ESuomDxbmASm66pHcasidx1dZX9WC1EPr+hSsIZUIbSfwPJ9tErIlsLacUcpMrPbjklxnFVRlp1i85tKs9RWcZ7Qo3lvP21yYXtINPWW156n7W8Cbe+OBRwVQ6Gsj5EuWw2vy5u4zp85mg3nSBA+aoCtka2ekIEDv+2VQf4R3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668487; c=relaxed/simple;
	bh=DUU5qqr+SiBf+YehfMeDWDzCCPe7oyrgmsIOPjGiRSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfoWwllooSX/WcN3/MXkg6lNiBuSgg5DflFNd/pqqr1I1IQ54rOI+8Kaztu3UNNo6Nj2C2iI88wSPRROTKH0AXe8LsbFy1on/WxOqqpfWH1qEAkxcGbomXarxuUKhHywMl44eb7F0uw0/FlQku8nEaABW27gkQq8fC1P7q1nZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ofet/XCe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4245235a77so1915005a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754668485; x=1755273285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpOieFkdjSEzpj+coZ/Qt1sSItr/enZbIpfI674jskc=;
        b=Ofet/XCewpiia0ecurm+bYsNSpJ6ZYRJezTJf5/o1noq2I8jIX3uN2c7ZUuXIYvhoN
         NgkwPGBopTR8QIY2prZ17eN8WmH91GpDtaUM0ya+rPV3bR0dw9Gr40ej+QdCwv2OnSIl
         OJyoQmUyPZ0rEEwr9YX2a8QgXpehpWp5dMqFFtatyU0aR58jc+kpueWshZCs2xFJ9plW
         v5Eml1kpqTZfuEOf8UU/q23q3gud4s33W3WoWp37SugF/5Qnj7c8BsaN8xO5gOuIV9ZJ
         T+DowjqP0QYVgRZe5dJdQDDJ1ptlQ+p9CfHTbOi1GYjP9EpwN5xuQT2akWA+8UGPB8rN
         WGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754668485; x=1755273285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpOieFkdjSEzpj+coZ/Qt1sSItr/enZbIpfI674jskc=;
        b=O1wsGrpW74aNMQUlVcq6mWZ2q0WnN4qRGFPkzM+TcJJO9ZeorIegOzgc1cdE2WNp7v
         Ktn7eZj52SmoSBgqBXhDVH5i0QxWDBJCmpSf7SN9lEYWiCiTAxZllRdn+c+CsWHYMHQ4
         nCUt9i8Tyjv73jt2ZuUjjYpGCDSiVU1APcQKfq2FXJQQkpfdBRcZvZYV0u74BrPek2uS
         kCYrC2BCir6AbPiiRFyzF+riAinxI6tp06CUWnDxYvq8RkQyjp/ZJmE2AhOC4KCT23UX
         hGLGz+ZSeqN0iheJTPDETsM7VYKApl6ApjogzZHgQRxUR5sfux/f3dGIEhm5+TFjLPcc
         jltw==
X-Forwarded-Encrypted: i=1; AJvYcCX1pb8jfCE8lYQMPDyY4db9ef1EQpcfFCzjoF/FQ4AwwZM/nnggBwYJhQtfwoGeJXInFqU6LMmVO1RCJi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtOmNGdP+w3mGjByo0jtXH0bStx6YnAHbCm400WA0bnB2kXhX
	H+Ph1M0nIkTy/y5IJatPiM+XOWHZAOZss85QrFzDFc+a+GbWoLuxzhNDNQWxsnhOHPGW/Uksg8m
	uBbDFggvjvjfueHVej1dkWqPmxvVhzkGaFNkW0j5l
X-Gm-Gg: ASbGncveKXXMfkbpQg2ePLZ0wjGs6oqqLaHaNt8G43jAACPscnWHtFb7vAUrvhONI6m
	xyfP10oGTUhtAT9MmDcnRsT8KU88GJc4el1gexvD4KBSP7XMJjfpwfRSfO5WnhFxgmUG5A1Bl9v
	5MWm6lqVtYIByMRVFo5nz9DeNPocMzv/NtqjWGUJQosQpwOwgITKeSgDOPyYFQ/1RJErdM9jxhm
	7iYkiwc52CKBVVvU000U15oW7rRDWbmH5FbPLyP
X-Google-Smtp-Source: AGHT+IEzw7BUEN0Uhci/G4prKpQQPttY3LXuO09ZmP5WGzpS1BiARM47KqGidgOOkSKfPxJX8puhJaiZx7EqP/kufu0=
X-Received: by 2002:a17:902:ce8d:b0:240:bc10:804a with SMTP id
 d9443c01a7336-242c224bffbmr52506245ad.43.1754668484816; Fri, 08 Aug 2025
 08:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704054824.1580222-1-kuniyu@google.com> <20250808-parent-noise-53b1edaa@mheyne-amazon>
In-Reply-To: <20250808-parent-noise-53b1edaa@mheyne-amazon>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 Aug 2025 08:54:33 -0700
X-Gm-Features: Ac12FXx4KEIvPaVYVTmGQU87z_XR0FVzyeP1yPP3q3DezBGeg_2x4JsFxDiwpNk
Message-ID: <CAAVpQUAi6sQ+=S-5oYOPkuPEFk68g2zG81YOA3MYVnTSvTxcjg@mail.gmail.com>
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Jason Baron <jbaron@akamai.com>, "Ahmed, Aaron" <aarnahmd@amazon.com>, 
	"Kumar, Praveen" <pravkmr@amazon.de>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	"linux-audit@redhat.com" <linux-audit@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 6:59=E2=80=AFAM Heyne, Maximilian <mheyne@amazon.de>=
 wrote:
>
> On Fri, Jul 04, 2025 at 05:48:18AM +0000, Kuniyuki Iwashima wrote:
> > Netlink has this pattern in some places
> >
> >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> >       atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> >
> > , which has the same problem fixed by commit 5a465a0da13e ("udp:
> > Fix multiple wraparounds of sk->sk_rmem_alloc.").
> >
> > For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
> > is always false as the two operands are of int.
> >
> > Then, a single socket can eat as many skb as possible until OOM
> > happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.
> >
> > Let's fix it by using atomic_add_return() and comparing the two
> > variables as unsigned int.
> >
> > Before:
> >   [root@fedora ~]# ss -f netlink
> >   Recv-Q      Send-Q Local Address:Port                Peer Address:Por=
t
> >   -1668710080 0               rtnl:nl_wraparound/293               *
> >
> > After:
> >   [root@fedora ~]# ss -f netlink
> >   Recv-Q     Send-Q Local Address:Port                Peer Address:Port
> >   2147483072 0               rtnl:nl_wraparound/290               *
> >   ^
> >   `--- INT_MAX - 576
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Jason Baron <jbaron@akamai.com>
> > Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akam=
ai.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Hi Kuniyuki,
>
> We're seeing soft lockups with this patch in a variety of (stable)
> kernel versions.
>
> I was able to reproduce it on a couple of different EC2 instances also
> with the latest linux kernel 6.16-rc7 using the following steps:
>
> systemctl start auditd
> sudo auditctl -D
> sudo auditctl -b 512
> sudo auditctl -a always,exit -F arch=3Db64 -S mmap,munmap,mprotect,brk -k=
 memory_ops
> sudo auditctl -e 1
>
> Then execute some programs that call some of these memory functions,
> such as repeated calls of "sudo auditctl -s" or logging in via SSH.
>
> These settings are set in a way to create a lot audit messages. Once the
> backlog (see auditctl -s) overshoots the backlog_limit, the system soft
> lockups:
>
> [  460.056244] watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kauditd=
:32]
> [  460.056249] Modules linked in: mousedev(E) nls_ascii(E) nls_cp437(E) s=
unrpc(E) vfat(E) fat(E) psmouse(E) atkbd(E) libps2(E) vivaldi_fmap(E) i8042=
(E) serio(E) skx_edac_common(E) button(E) ena(E) ghash_clmulni_intel(E) sch=
_fq_codel(E) drm(E) i2c_core(E) dm_mod(E) drm_panel_orientation_quirks(E) b=
acklight(E) fuse(E) loop(E) dax(E) configfs(E) dmi_sysfs(E) efivarfs(E)
> [  460.056272] CPU: 1 UID: 0 PID: 32 Comm: kauditd Tainted: G            =
EL      6.16.0-rc7+ #3 PREEMPT(none)
> [  460.056275] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
> [  460.056276] Hardware name: Amazon EC2 t3.medium/, BIOS 1.0 10/16/2017
> [  460.056277] RIP: 0010:_raw_spin_unlock_irqrestore+0x1b/0x30
> [  460.056284] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 4=
4 00 00 e8 16 07 00 00 90 f7 c6 00 02 00 00 74 01 fb 65 ff 0d b5 23 b6 01 <=
74> 05 c3 cc cc cc cc 0f 1f 44 00 00 e9 14 23 00 00 0f 1f 40 00 90
> [  460.056285] RSP: 0018:ffffb762c0123d70 EFLAGS: 00000246
> [  460.056287] RAX: 0000000000000001 RBX: ffff9b14c08eafc0 RCX: ffff9b14c=
3337348
> [  460.056288] RDX: ffff9b14c3337348 RSI: 0000000000000246 RDI: ffff9b14c=
3337340
> [  460.056289] RBP: ffff9b14c3337000 R08: ffffffff93cea880 R09: 000000000=
0000001
> [  460.056290] R10: 0000000000000001 R11: 0000000000000080 R12: ffff9b14c=
1b72500
> [  460.056291] R13: ffffb762c0123de0 R14: ffff9b14c3337340 R15: ffff9b14c=
3337080
> [  460.056294] FS:  0000000000000000(0000) GS:ffff9b1563788000(0000) knlG=
S:0000000000000000
> [  460.056296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  460.056297] CR2: 00007f36fd5d21b4 CR3: 000000010241a002 CR4: 000000000=
07706f0
> [  460.056298] PKRU: 55555554
> [  460.056299] Call Trace:
> [  460.056300]  <TASK>
> [  460.056302]  netlink_attachskb+0xb7/0x2f0
> [  460.056308]  ? __pfx_default_wake_function+0x10/0x10
> [  460.056313]  netlink_unicast+0xea/0x3b0
...
>
> We've bug reports from many users, so the issue is rather wide-spread.
>
> So far I don't know why the commit is causing this issue and will keep
> investigating. However, when reverted (together with its 2 follow-up
> patches), the issue goes away and host do not lock up.

Thanks for the report, Max!

Does your tree have this commit ?  This is the 3rd follow-up patch.

commit 759dfc7d04bab1b0b86113f1164dc1fec192b859
Author: Fedor Pchelkin <pchelkin@ispras.ru>
Date:   Mon Jul 28 08:06:47 2025

    netlink: avoid infinite retry looping in netlink_unicast()

