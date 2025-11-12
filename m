Return-Path: <linux-kernel+bounces-897142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E477AC5220A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AC014F6399
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291E3148D0;
	Wed, 12 Nov 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFnED4kS"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B33002BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948310; cv=none; b=Y3CVxXYdZf+JNxq4wvO7iAP5vLZ6Rr4yXX98dmkZKBLc/GAEtIH6SHYvXyAIS4n5bUma4GhBgIormgCsOBGa12jo23NBTp8ypFJzcdbvOXkiDbHFcCl3FwcKv8FSRM8etq5hvG54l692IJe2GCA/QOkrPgfsyc1MukL0A90zaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948310; c=relaxed/simple;
	bh=b1rILryB2M3fbQ634EIP/osVeulPKMjm/jpw3Ez0zjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqhVod23L/JtvKUhuN+6cWSLhYwHp+0eiUScy9N0+ncJ8jPzoK53E7KDpWkAHP6/VVPZWIjiugLWr2+WWnAMDaFDSSmQaU9I9no58UjApKpMIl++NQcEU6jC0xChEwvsIXOp/KDhbhy6yt4trkNs9tlnFsLytUPNyW5KEXKohdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFnED4kS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eda6a8cc12so8185241cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762948308; x=1763553108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SHnnORyfGe29KbIMnvLbNalHewh1m61HuorXDqf++c=;
        b=EFnED4kSlRnGAjvhkINDDoLqRPjKTKea0sZh8xnMoRcGz2lP8Q1RokIC0vmEX4xV03
         rSlHOAcFic345MFd9G03mzqooKDbvj9ZAvI+HGNK7oXkjSx5YibqcgfL3OP9DP5EiduC
         pvzPDCXa9rUCXAxwr8ML6dmScuFqonUlm/kdr4GZhYEFf1ZbdhTiSSkh4SmkNlDPvljv
         siXFVS84hJim2UF+jFLOoHah6xBjevHtzCc9QFr98rrgxFz5sQwL04PPMVh8HEdouN2f
         KJ6WjlMN/ZdsY+kK9jT0kBthA1BRTNj3MnqMzpb6WDAIcdm/U4FBNccDRmTwBgzADI+P
         8SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948308; x=1763553108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SHnnORyfGe29KbIMnvLbNalHewh1m61HuorXDqf++c=;
        b=VTf/o4W3/wDnl3kDTycFCR3waSkXD1fvWRE1GQPJQJw9l+sA/8xRC64nio6dT52wyd
         lDTiCLw8ch7twc4cWdSJ4sgtwpPJ0z/8KxF2Rr2SSNjet4XsLEWT0UfhYhvFcgluXEgX
         1G0XJ/BFnnesw1PBvp+ozdqWC+vBcIoB7u1cGH8wa5MtvqwkqCmhu3nBfWaznYa65rA+
         SKlHrbPWv8+EXag1G8GlANE4Uh+i85II7bAs3fStjfuA+FVwU9eDYh7uu0s1l6DT3Wpd
         hgEGZHdASwcH8Q6QlryAk8Y9/a1Iflk07Ct5tDG1eHhNU/aqELaxKa43JHJj2+2rB7Ro
         XMBg==
X-Forwarded-Encrypted: i=1; AJvYcCXyZLjXySlNaqK6JxSLvXNaHkZiz0GLX3jdJ07htIFIaCkhc+wRkTR04fvn/j89LkQ92vbDygXBwc9XZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT7PRqmBW1yji9rb5J5PDOV9bbTrKs9B5DRX4K68xn9JELy3xB
	u0zAZfyqq99iV1es4fGbkjgPOgSjcepwoYQbe5d8090yjqBFMlYV6DjcsLd4jSf/7TWFQ74yZ0q
	9BMyuza2XG+R5pFRUhTrJGjj+RCwGYZUe+Ex+Oq8E
X-Gm-Gg: ASbGncuqFBU+6tYnw255GDdqEn5juWF3oCi6b7Govsukf+5PqPkaYO/WD1MwF3cogpg
	UTckSeV9xj+g4zpc9xN5wpJeO8L8G4RUyTQhe6KYszc6N3UEiQYbdUMzLQxiFmSqzRkIegzXGR+
	mE6mpbhJI6vU/JcgTaLIwpjbyq8hWAAiKtlVrZ75fe5m2uXQtwfm7n4/7VGRWlvAIEMOudNqcMH
	vQ+mVHfYHpCVIDtCvK1w8gDaB/jx+v6+v7JJ4hv9rQEMtTSPi1qfputfrs8XZcrA3TFblh0
X-Google-Smtp-Source: AGHT+IFEItPI7vSPRRHkiLmJY63z1/ByvM74LRYVl9zPbVKDpOXr+k9akJ9znapxG2LuAr/FlYJkD2JD0iARiVXxn5w=
X-Received: by 2002:a05:622a:552:b0:4e8:a51e:cdbc with SMTP id
 d75a77b69052e-4eddbdab80emr29447671cf.43.1762948307682; Wed, 12 Nov 2025
 03:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111164205.77229-1-m.lobanov@rosa.ru>
In-Reply-To: <20251111164205.77229-1-m.lobanov@rosa.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 03:51:36 -0800
X-Gm-Features: AWmQ_bnDD_Nqi7mF-JEZnEFKUvg8l_pC0pT8ENximYQLAL7RG-EOvRY8jzzXLGs
Message-ID: <CANn89iJ_FtPGg-a8s-2QY+KxJVYku4BMcK7dE=-NnMu5ufvHLQ@mail.gmail.com>
Subject: Re: [PATCH net] net: fix double dst_release() on sk_dst_cache race
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:39=E2=80=AFAM Mikhail Lobanov <m.lobanov@rosa.ru>=
 wrote:
>
> A reproducible rcuref - imbalanced put() warning is observed under
> IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
> imbalance in dst reference counting for routes cached in
> sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
> issue between the helpers that validate and drop cached dst entries.
>
> rcuref - imbalanced put()
> WARNING: CPU: 0 PID: 899 at lib/rcuref.c:266 rcuref_put_slowpath+0x1ce/0x=
240 lib/rcuref.c:266
> Modules linked in:
> CPSocket connected tcp:127.0.0.1:48148,server=3Don <-> 127.0.0.1:33750
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian=
-1.16.3-2 04/01/2014
> RIP: 0010:rcuref_put_slowpath+0x1ce/0x240 lib/rcuref.c:266
>
> Call Trace:
>  <TASK>
>  __rcuref_put include/linux/rcuref.h:97 [inline]
>  rcuref_put include/linux/rcuref.h:153 [inline]
>  dst_release+0x291/0x310 net/core/dst.c:167
>  __sk_dst_check+0x2d4/0x350 net/core/sock.c:604
>  __inet6_csk_dst_check net/ipv6/inet6_connection_sock.c:76 [inline]
>  inet6_csk_route_socket+0x6ed/0x10c0 net/ipv6/inet6_connection_sock.c:104
>  inet6_csk_xmit+0x12f/0x740 net/ipv6/inet6_connection_sock.c:121
>  l2tp_xmit_queue net/l2tp/l2tp_core.c:1214 [inline]
>  l2tp_xmit_core net/l2tp/l2tp_core.c:1309 [inline]
>  l2tp_xmit_skb+0x1404/0x1910 net/l2tp/l2tp_core.c:1325
>  pppol2tp_sendmsg+0x3ca/0x550 net/l2tp/l2tp_ppp.c:302
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg net/socket.c:744 [inline]
>  ____sys_sendmsg+0xab2/0xc70 net/socket.c:2609
>  ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2663
>  __sys_sendmmsg+0x188/0x450 net/socket.c:2749
>  __do_sys_sendmmsg net/socket.c:2778 [inline]
>  __se_sys_sendmmsg net/socket.c:2775 [inline]
>  __x64_sys_sendmmsg+0x98/0x100 net/socket.c:2775
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fe6960ec719
>  </TASK>
>
> The race occurs between the lockless UDPv6 transmit path
> (udpv6_sendmsg() -> sk_dst_check()) and the locked L2TP/pppol2tp
> transmit path (pppol2tp_sendmsg() -> l2tp_xmit_skb() ->
> ... -> inet6_csk_xmit() =E2=86=92 __sk_dst_check()), when both handle
> the same obsolete dst from sk->sk_dst_cache: the UDPv6 side takes
> an extra reference and atomically steals and releases the cached
> dst, while the L2TP side, using a stale cached pointer, still
> calls dst_release() on it, and together these updates produce
> an extra final dst_release() on that dst, triggering
> rcuref - imbalanced put().
>
> The Race Condition:
>
> Initial:
>   sk->sk_dst_cache =3D dst
>   ref(dst) =3D 1
>
> Thread 1: sk_dst_check()                Thread 2: __sk_dst_check()
> ------------------------               ----------------------------
> sk_dst_get(sk):
>   rcu_read_lock()
>   dst =3D rcu_dereference(sk->sk_dst_cache)
>   rcuref_get(dst) succeeds
>   rcu_read_unlock()
>   // ref =3D 2
>
>                                             dst =3D __sk_dst_get(sk)
>                                     // reads same dst from sk_dst_cache
>                                     // ref still =3D 2 (no extra get)
>
> [both see dst obsolete & check() =3D=3D NULL]
>
> sk_dst_reset(sk):
>   old =3D xchg(&sk->sk_dst_cache, NULL)
>     // old =3D dst
>   dst_release(old)
>     // drop cached ref
>     // ref: 2 -> 1
>
>                                   RCU_INIT_POINTER(sk->sk_dst_cache, NULL=
)
>                                   // cache already NULL after xchg
>                                             dst_release(dst)
>                                               // ref: 1 -> 0
>
>   dst_release(dst)
>   // tries to drop its own ref after final put
>   // rcuref_put_slowpath() -> "rcuref - imbalanced put()"
>
> Fix this by making the locked __sk_dst_check() use the same =E2=80=9Cstea=
l
> from sk->sk_dst_cache=E2=80=9D pattern as the lockless path: instead of
> clearing the cache and releasing a potentially stale local dst,
> it atomically exchanges sk->sk_dst_cache with NULL and only calls
> dst_release() on the pointer returned from that exchange. This
> guarantees that, for any given cached dst, at most one of the
> competing helpers (sk_dst_check() or __sk_dst_check()) can acquire
> and drop the cache-owned reference, so they can no longer
> double-release the same entry; the atomic operation runs only in the
> obsolete path and should not affect the main path.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: d14730b8e911 ("ipv6: use RCU in inet6_csk_xmit()")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
> ---
>  net/core/sock.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index dc03d4b5909a..7f356f976627 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -607,14 +607,15 @@ INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_ds=
t_check(struct dst_entry *,
>  struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
>  {
>         struct dst_entry *dst =3D __sk_dst_get(sk);
> +       struct dst_entry *old_dst;
>
>         if (dst && READ_ONCE(dst->obsolete) &&
>             INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_c=
heck,
>                                dst, cookie) =3D=3D NULL) {
>                 sk_tx_queue_clear(sk);
>                 WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
> -               RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
> -               dst_release(dst);
> +               old_dst =3D unrcu_pointer(xchg(&sk->sk_dst_cache, RCU_INI=
TIALIZER(NULL)));
> +               dst_release(old_dst);
>                 return NULL;
>         }
>

This is not a correct fix.

Please take a look at sk_dst_check() vs __sk_dst_check() , and why we have =
both.
(Same for __sk_dst_get() vs sk_dst_get())

inet6_csk_xmit() is reserved for sockets holding their socket lock.

Please fix l2tp instead.

Thank you.

