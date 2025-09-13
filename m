Return-Path: <linux-kernel+bounces-815089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B44B55F36
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FA75884E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F22E92AB;
	Sat, 13 Sep 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALcc9yeG"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2D2E7BAB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757751073; cv=none; b=jjs7FACeDeY/vgRPmmMvlOuoiY2eC4LB2l0GWgLi4YbXRmXxxa/zWHhGRwXfQ+mCv7CdkW7oJCbnA78TAnjthHnwiXz9Tjj8ByFJgI6+FilSzp3UF1gvtL5uSNWQX22sijRiNgBbNViSFUp3pvL8Pm4LYcFoHXlCS6XKqcmYBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757751073; c=relaxed/simple;
	bh=yk1BOJDCKQDhTz8EirmmbNV++Ukm7Mv/8yPoyaaNmYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFVZqRmulYsVFc7WshaGmWGthtWqMldYF/EkYbOT1HJh71Q747RrZPQVh78U9cQJ1YYl6/60YhbQ8/AbHjngGq8pSoCSIxbske3wWiF0gNUtWnsTYND1CuyGHCefgLQSLken+a7j6D695niaE2VfsNx8hqMxoLX4QzomyDmLL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALcc9yeG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b33f71bb1dso34882791cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757751070; x=1758355870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPMZIHH0Rrm1soiTq3K7uQpKE0IL8W76Rdylalgci7Q=;
        b=ALcc9yeG1ECpYkvunGJU+moqByS2Cvlj2eYYdzOKGM3EB+oq03Wk+Ra/r8WPhvmgoc
         0jzIsj4o6+LUbKpJSVFqvnGVL+mgkXwwnV3uYT+8if4hQcMa00YLGm6Ptt7ktid8WnRE
         IcTTlAVArCEhRefub35SC28GryMJfYFek1OBGPnOqU4xfGkghBmND6hkg+jB2S/lUOJo
         xdLgHlsbf8QS20+TR2nBg7nK+/67aqi6Nca5iZrUhPNKgd0zfv65XURGJxTuK1LwXHpj
         K3MtVD4SSVhjw+BJTBmotBmFAJVMwm4VpPgbbpJUPJVbBL9l2KVkOutyngTxDtPpYGEe
         kD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757751070; x=1758355870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPMZIHH0Rrm1soiTq3K7uQpKE0IL8W76Rdylalgci7Q=;
        b=seGaOkmIiXJ4SiodtoJ6aBFcXLvkKx+vV73KMjgRt7f79zfKDKuZ6pkNh5mj4jR45l
         DdOk6ZJ1PTMRC1Tek6ZkwSO/4XNdcEaTriUr9JEtvZyA+CFZRmmcxwy1OtzkgmBWEyiG
         PpFHNy0aPxHu6Y6rFk179aX97U9FHprZBxG/7tw8E0GVtjanthAgYYPDR/Q1pdAyuamR
         WDEIJWzZFxB0EEKtYe00MMzGyln2rHLbTNGNHmvQ35LhAynCV2rLqNLiv1gkV8xYazHX
         MVNHdZAov0w4vessn9nXBOejogkAq/tc3ZYHx06t9V6ybtxSzENuMxvUSAjyc15ivNyV
         m4SA==
X-Forwarded-Encrypted: i=1; AJvYcCWdI6Vib+1xVBImofgZnqdHG8475rZDg59ekPtB7pKxbyHzbemWIO1bfId54RJyr3RQDc78D+gVQ6bdYtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7emptE72DQNDiElDXQKSiG2fBRw1EfBxuMlFpcDWADSQvNY3n
	dsbeIpR+Qqq1s79Nf8ylKCMbHjWpcqfSBFfYuifv4nVkxsrt4DIJ35qWhtsPnry3dzrrEFzBbyS
	3s4AaSrbdllF4X5gF28wJ/cf2uNZYdtvlf5GFU9V0
X-Gm-Gg: ASbGncvct7XPe7R9xBHF8sGehxO9G5HuaJ/hxhmgipeaXxEk1u29jF1FA1qK0DssjEs
	aDjIyeWe24BcXDG7+/CFGDBjX5kfAAdydm9VjmVBj8GuGHGM4yOK4KFo+cQyvXmlE+f3KUZ6nEO
	t6Y4xbUnCGnp/MnOPyvErmfpsNb/NA8HGRaUZUIMiVKiuZUhnzoee1J1WrrfJ8PquQb62gixPhP
	G/saxzLL1NPQiHXUCUBPEgAWw==
X-Google-Smtp-Source: AGHT+IF2/DG7z3teZ9UviBtYAqKXIPu5V8UphD3aq8FCBkZBiBWvEJFQN4pQ/D5brNfyYNGVGZvylFYdLkgX9HysvuY=
X-Received: by 2002:a05:622a:255:b0:4b3:7ec:d22d with SMTP id
 d75a77b69052e-4b6347e7880mr115083651cf.20.1757751069813; Sat, 13 Sep 2025
 01:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912212216.66338-1-rodgepritesh@gmail.com>
In-Reply-To: <20250912212216.66338-1-rodgepritesh@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 13 Sep 2025 01:10:58 -0700
X-Gm-Features: Ac12FXxkWZabCKCN7Y4OupdTdqOowSJPhntrI8BJrv50Bw_akyD4N7KJIte9DmI
Message-ID: <CANn89i+6naPhD_XJ-qjQ8mRGN1aQdSzMy1446d+0iOk_UjpMOw@mail.gmail.com>
Subject: Re: [PATCH] net/rose: Fix uninitialized values in rose_add_node
To: rodgepritesh@gmail.com
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, kuba@kernel.org, 
	pabeni@redhat.com, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:22=E2=80=AFPM <rodgepritesh@gmail.com> wrote:
>
> From: Pritesh Rodge <rodgepritesh@gmail.com>
>
> The rose_add_node() function uses kmalloc to allocate a new rose_node
> but only initializes the first element of the 'neighbour' array. If
> the node's count is later incremented, other parts of the kernel may
> access the uninitialized pointers in the array.
>
> This was discovered by KMSAN, which reported a crash in
> __run_timer_base. When a timer tried to clean up a resource using
> one of these garbage pointers.
>
> Fix this by switching from kmalloc() to kzalloc() to ensure the
> entire rose_node struct is initialized to zero upon allocation. This
> sets all unused neighbour pointers to NULL.

Which part exactly of rose node being not initialized would lead to
the syzbot report ?

BUG: KMSAN: uninit-value in __hlist_del include/linux/list.h:980 [inline]
BUG: KMSAN: uninit-value in detach_timer kernel/time/timer.c:891 [inline]
BUG: KMSAN: uninit-value in expire_timers kernel/time/timer.c:1781 [inline]
BUG: KMSAN: uninit-value in __run_timers kernel/time/timer.c:2372 [inline]
BUG: KMSAN: uninit-value in __run_timer_base+0x690/0xd90
kernel/time/timer.c:2384
 __hlist_del include/linux/list.h:980 [inline]
 detach_timer kernel/time/timer.c:891 [inline]
 expire_timers kernel/time/timer.c:1781 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x690/0xd90 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0x3a/0x80 kernel/time/timer.c:2403
 handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]



>
> [1] https://syzkaller.appspot.com/bug?extid=3D7d660d9b8bd5efc7ee6e
>
> Reported-by: syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com
> Signed-off-by: Pritesh Rodge <rodgepritesh@gmail.com>
> ---
>  net/rose/rose_route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
> index a1e9b05ef6f5..6ca41cbe867a 100644
> --- a/net/rose/rose_route.c
> +++ b/net/rose/rose_route.c
> @@ -148,7 +148,7 @@ static int __must_check rose_add_node(struct rose_rou=
te_struct *rose_route,
>                 }
>
>                 /* create new node */
> -               rose_node =3D kmalloc(sizeof(*rose_node), GFP_ATOMIC);
> +               rose_node =3D kzalloc(sizeof(*rose_node), GFP_ATOMIC);
>                 if (rose_node =3D=3D NULL) {
>                         res =3D -ENOMEM;
>                         goto out;

I doubt this will fix anything really, given this code is followed by :

rose_node->address      =3D rose_route->address;
rose_node->mask         =3D rose_route->mask;
rose_node->count        =3D 1;
rose_node->loopback     =3D 0;
rose_node->neighbour[0] =3D rose_neigh;

rose is certainly full of bugs, but I do not see your patch fixing one of t=
hem.

