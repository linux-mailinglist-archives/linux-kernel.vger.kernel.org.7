Return-Path: <linux-kernel+bounces-724327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCF8AFF164
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EF41C84C85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111423D28E;
	Wed,  9 Jul 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDK671J3"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77322256F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087871; cv=none; b=V5ELFSI4a2Ux26Wo7tmBA3fvmbwHzb8B4Yg04DuXBx7Y4eZtvIPQdtJS+edRJ2PNcbpTaNRWXnCiB5TiAzoYDsAUcW2Akv/9vLsBiYvXUHB1fVH8pB9C5lGVC0mBCS2/CESoZdE/kyRd2cQGeNk1OPAY++o8Xd/QZT9w/cTFC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087871; c=relaxed/simple;
	bh=uHlcs8Omf3CS1KytlE/VWNw38oTCNOswfZed0aZbJ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnO14qb8F9mXmlx9JqnTVKWBjihg2hRl9IEG09A6rPcJlx5pQdZPHBa7fmibW3lbr6GYJU2X7hrH4dXDBqDbLF7scyx6ldl/EfGHaZD0kff3K5zpIF3Tvu0+8TkBphS4W//2UJu4Nw1EUga26DXDc0rcKrAwDeMtNfyTfHnVrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDK671J3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3139027b825so280182a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752087869; x=1752692669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3NdMvV7Oc0jzRHM6vAQiXa6oLCVEsrYO5UT07DX7LY=;
        b=CDK671J3auRipQv2SDFQPPdMU0QCMJqCurqC1Uuij31stAyBLNHZ7TaUVU0wMvrnVC
         eA/ZY8TMuaI3cjFf5Ej6Vbsgkws0gqXp4OjB8ECSGOYYY9NvrsmBf/v7udHDyBeOt1Fz
         ira8udH/h0E61sydoIcjANouAH/vje/lm0GS9NTQ2ye3rtRiD0vbO9Ww9or2WbYG8doI
         Fu3/nCIe6krvySkKnpxZ4xiXdGXk06A55TDlt5zvv75KeQnLeydn7d/S9iEx82+z2jUL
         b2uM/esmnbf+4cv5uw4a+iIUihzvXrmm/kNx/yi5S1DSLGey/eycVkiXt9ERhVlefWc2
         twhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087869; x=1752692669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3NdMvV7Oc0jzRHM6vAQiXa6oLCVEsrYO5UT07DX7LY=;
        b=C48FCZBUaNXLGiSAtx08QM2jaJfLK+rCFAuFq3HTmbjXr62MSPbugUNTeuPx2+VX7s
         CZ4aT6gHrDmf0N7YETh4p+Nv7RgBvbS7ddghhACs1VlmJ+4opo0/dQZvr7j9JuTLeIFE
         lU4jGJLAdPj9SwyLTubLXVkzFs35AOQFNz9XlJzwvZFqAga816YHLQITXAnPivdyIf4G
         3hDTvgum609gIg21AZBmBiqCP0chE4L5TawaHXhcOD3cPBGbfpxZW8SKfcYG3KwRPQa+
         aIHF1L9++CWWy57ISbk9uQlv52aouNTT8wXlhsSeZEZgTQ9a+ZJyb/thHkIovOY6q19w
         okoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7zCDHV5MCIxirZh7vgIZRhDyxtMznQtB9u7NxXvnaKJP0xHpfxosh5IAOb7YJVHkn0LQXwkNhv1n9T5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjEf4nU7QsgY2SMOKdF0qfkE0fojKF4HoVSd1I04kywLJ06AT
	2wjo8fuDov1in+jTw1rQ3qYTwQyKgjPhZEnRHYby1UlkJsB5Li2GI2wm86Y4dMd4rUnsfiHKaHs
	tEIVboB+hdZKPUcenHd6f+yvq77yZdh8xruHwcumv
X-Gm-Gg: ASbGnct8STsdTFqqRFLFXCYN0LYEo1q4ufGt6JwdMtA4udxbJNavcHLWlYCkJT1gsI7
	F6uOomEAInD+Hvg6ugF1UEO60/u91BZ867rQn8JFIpNKYvFToiVgQ1x7n6uOjfitpStm5ezyrsf
	sr9E5pyfpSS1x0OWEb2olXYM7XXr7yJUgdDtGZh0mRuvN+igLLLxeFmpC1koJlJibIGKhknrQNr
	21MtJB5i3AK
X-Google-Smtp-Source: AGHT+IHjN+1YxOoz4O6LpAmMlFJ5M/5Ec/pilG+KyM/ehzIbHUQ+C6XFZVejUv39ao1Y6bYfM9TS7h0QcJIqOVktj7s=
X-Received: by 2002:a17:90b:3a8a:b0:311:c5d9:2c79 with SMTP id
 98e67ed59e1d1-31c3c2d4797mr1345957a91.21.1752087868873; Wed, 09 Jul 2025
 12:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705085228.329202-1-yuehaibing@huawei.com> <20250709185626.GN721198@horms.kernel.org>
In-Reply-To: <20250709185626.GN721198@horms.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Jul 2025 12:04:15 -0700
X-Gm-Features: Ac12FXzwUGGf7Mqw_5B3tPLa70x7c-uCFjkKyti--bnUncsh7gDOXqKvAtUzOSY
Message-ID: <CAAVpQUBkD7zH9Ki6m2=xXFus5TbTXRqtv13AtEr7_Koqv_j9bA@mail.gmail.com>
Subject: Re: [PATCH v2 net] atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
To: Simon Horman <horms@kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 11:56=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> + Iwashima-san

Thank you, Simon :)

>
> On Sat, Jul 05, 2025 at 04:52:28PM +0800, Yue Haibing wrote:
> > atmarpd_dev_ops does not implement the send method, which may cause cra=
sh
> > as bellow.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > PGD 0 P4D 0
> > Oops: Oops: 0010 [#1] SMP KASAN NOPTI
> > CPU: 0 UID: 0 PID: 5324 Comm: syz.0.0 Not tainted 6.15.0-rc6-syzkaller-=
00346-g5723cc3450bc #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:0x0
> > Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > RSP: 0018:ffffc9000d3cf778 EFLAGS: 00010246
> > RAX: 1ffffffff1910dd1 RBX: 00000000000000c0 RCX: dffffc0000000000
> > RDX: ffffc9000dc82000 RSI: ffff88803e4c4640 RDI: ffff888052cd0000
> > RBP: ffffc9000d3cf8d0 R08: ffff888052c9143f R09: 1ffff1100a592287
> > R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff92001a79f00
> > R13: ffff888052cd0000 R14: ffff88803e4c4640 R15: ffffffff8c886e88
> > FS:  00007fbc762566c0(0000) GS:ffff88808d6c2000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffffffffffd6 CR3: 0000000041f1b000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  vcc_sendmsg+0xa10/0xc50 net/atm/common.c:644
> >  sock_sendmsg_nosec net/socket.c:712 [inline]
> >  __sock_sendmsg+0x219/0x270 net/socket.c:727
> >  ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
> >  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
> >  __sys_sendmmsg+0x227/0x430 net/socket.c:2709
> >  __do_sys_sendmmsg net/socket.c:2736 [inline]
> >  __se_sys_sendmmsg net/socket.c:2733 [inline]
> >  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+e34e5e6b5eddb0014def@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/682f82d5.a70a0220.1765ec.0143.GAE@g=
oogle.com/T
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

v2 looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

