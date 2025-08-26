Return-Path: <linux-kernel+bounces-786154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C96B355B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F8E7A8272
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9AC28725F;
	Tue, 26 Aug 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiimnQsL"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D6129E6E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193588; cv=none; b=NX2vlf/RVDL14r9Re8dgRGlrj3qKfJP+VXyBAV3PL53Jd/YsAbsHgOIqsKFaO4RXHHffpIBOSe6Bd1IAgAVy5nlQM8hQQj2UwRqlHyalgTLEGwF26vXwt1yo+HPbMfZxlwPiDfjz4zAYg7EcZqGzXQU0EzrpdNWun6VN1R1NopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193588; c=relaxed/simple;
	bh=t90MfFrKu26OKxnDhpKftUytsoBlhBGSaaj4mS0CDdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzbafBXWvIzWw+WbUNbJGjy4+Bm0pyh3z5vNLMLPFG+vBOejOYIVnvRHxuIE8/qAe0+ixbCxP01F6ltQDm/FL+VC9Dfm0AHkeDE5+x1t3K8cfFar//ip1pX55xr2gyTyjHtY/Scn8hTdImURaZ//EP9bLXBKwcffzXV6bUU9U+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiimnQsL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109912545so69427271cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756193586; x=1756798386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deY2yrxUFegHzxxk7U7oCkHMbww3xqSyI5T2Ryg9WEk=;
        b=EiimnQsL8y+07NiEz3ZSjyhr27hDlvJQP8hCCQbUZ2d4dC9/i0VRyJwtYaVQ/1ktVq
         4LlA3YUgpTbUUlqD9vUEnLn+Hbg+ZnwTTx2ynpQael/UaYUyfLN+xfHRKyVyOY1Jndz8
         IB7gwN1gRhls997WSLx/SWuwgJUpyEZpyTQmWGYPjX86zQXqISsTkArG9wleDfqXiqYx
         lWeIsGhW3guGjpOg2HZxiZjHY4qWqcw+vIW09oqmhB+l+cuAsmPMubrtqpof3f2Zs4lu
         qvNYgRIFD/0OUw4NamBm8cwQXPGU9Z5zBNh0evrOc0k0yZNZ/yNfHYmhX2XqtZfCi9Bq
         HEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193586; x=1756798386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deY2yrxUFegHzxxk7U7oCkHMbww3xqSyI5T2Ryg9WEk=;
        b=hN+EJ+s+UEdfNlwTwSqpPV3pm9ntzqA7TomNJuEueOZrssmKABJIZB95ClxOmmFxKp
         QOTjiXuUOv8Rb6ZFcCsY4pWAT1bF2qTxEtW/PcGyBYimAQv7kdVUhC/Llyb/ubYXBQQm
         nA+TK86KOlLK8X/NSILjt9hZRy2SJQPir6+/r+NW8GxyYocBPoTmTR5Gbzoo//nQRJwt
         I8RJGs5vVHxbaTGOLeRFD68K8YMPhEYWuEThWCf8QVW8bM2joP1TRt+g2uaFmAaWrhdY
         Z9qG6DLDHI1I2qvoUu2NdHtCo5qIDGt8D5qinqT2kpnvN6LxU7EuNUGBSgII8fx1nu7R
         82kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8OPCqR4CDb1KxJP6qOtg0y7zkb+8ZC7O6F2SWVrwCq+IkJ7iwML/SBf68qeJM1GU91Oujcl68WvWB24k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OeraVAZcXgGPgUpWkBhIugHYSu0k051VZYplUfom7N9KWigz
	3XPTbCLCNIF0GPtv5qr5GSYkRCOEgEZvIs/xiZaG9thul1Uxj/i2xyiq6F5nhDCokCpxAjVi6yz
	2ak4Ozfj3GmFg293ivJiyM/1QvWCS6E+7E45r1dbv
X-Gm-Gg: ASbGncux+kxf4joP8xWjhZju/9Mp9Rjx4UP+3tB5uxvPPZ/wdweno60t351gR4FCCxQ
	UWy7CcTh+vhqDJCsy/2Bg5TQpHQcy2G3QCsbl3XVnUJVUFLfCO8J1Qzsw3stayINMFUSwn7Awwd
	ruN4KzWzVzqnuAlpxPgV/jvYxjL37XgSAacMhud5EfwRdvPg8ktZtLtE3XcRp4EEHtSjOL623ln
	DyJp6UfjZMnWl05owJxIuvRyYY3zf2+xn6z
X-Google-Smtp-Source: AGHT+IHlIh4Xl7Oz79WbCpz7KNmgFS72lNM4EOKBNeHe7sO8z3/LYDLd6NZAEq2o/vVJPd1tFfh2fBVBmToUtljK/28=
X-Received: by 2002:a05:622a:1c11:b0:4ae:751e:e4ef with SMTP id
 d75a77b69052e-4b2aaa2dfb0mr176590281cf.30.1756193585303; Tue, 26 Aug 2025
 00:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826023346.26046-1-dqfext@gmail.com>
In-Reply-To: <20250826023346.26046-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 00:32:53 -0700
X-Gm-Features: Ac12FXzBtCRsUpuJEN9ybDqrxqSHBaucm7Kmce9MibixcCK5G4g74MBAQnkY8u8
Message-ID: <CANn89iLZUkQrsfqvEZGmz9ZVoVk1CNQzaZyCcJ53o9e2-1GTPQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] pppoe: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:34=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Like ppp_generic.c, convert the PPPoE socket hash table to use RCU for
> lookups and a spinlock for updates. This removes rwlock usage and allows
> lockless readers on the fast path.
>
> - Mark hash table and list pointers as __rcu.
> - Use spin_lock() to protect writers.
> - Readers use rcu_dereference() under rcu_read_lock(). All known callers
>   of get_item() already hold the RCU read lock, so no additional locking
>   is needed.
> - Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
>   period.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c  | 83 ++++++++++++++++++++++------------------
>  include/linux/if_pppox.h |  2 +-
>  2 files changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 410effa42ade..f99533c80b66 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -100,8 +100,8 @@ struct pppoe_net {
>          * as well, moreover in case of SMP less locking
>          * controversy here
>          */
> -       struct pppox_sock *hash_table[PPPOE_HASH_SIZE];
> -       rwlock_t hash_lock;
> +       struct pppox_sock __rcu *hash_table[PPPOE_HASH_SIZE];
> +       spinlock_t hash_lock;
>  };
>
>  /*
> @@ -162,13 +162,13 @@ static struct pppox_sock *__get_item(struct pppoe_n=
et *pn, __be16 sid,
>         int hash =3D hash_item(sid, addr);
>         struct pppox_sock *ret;
>
> -       ret =3D pn->hash_table[hash];
> +       ret =3D rcu_dereference(pn->hash_table[hash]);
>         while (ret) {
>                 if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
>                     ret->pppoe_ifindex =3D=3D ifindex)
>                         return ret;
>
> -               ret =3D ret->next;
> +               ret =3D rcu_dereference(ret->next);
>         }
>
>         return NULL;
> @@ -177,19 +177,20 @@ static struct pppox_sock *__get_item(struct pppoe_n=
et *pn, __be16 sid,
>  static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
>  {
>         int hash =3D hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
> -       struct pppox_sock *ret;
> +       struct pppox_sock *ret, *first;
>
> -       ret =3D pn->hash_table[hash];
> +       first =3D rcu_dereference_protected(pn->hash_table[hash], lockdep=
_is_held(&pn->hash_lock));
> +       ret =3D first;
>         while (ret) {
>                 if (cmp_2_addr(&ret->pppoe_pa, &po->pppoe_pa) &&
>                     ret->pppoe_ifindex =3D=3D po->pppoe_ifindex)
>                         return -EALREADY;
>
> -               ret =3D ret->next;
> +               ret =3D rcu_dereference_protected(ret->next, lockdep_is_h=
eld(&pn->hash_lock));
>         }
>
> -       po->next =3D pn->hash_table[hash];
> -       pn->hash_table[hash] =3D po;
> +       RCU_INIT_POINTER(po->next, first);
> +       rcu_assign_pointer(pn->hash_table[hash], po);
>
>         return 0;
>  }
> @@ -198,20 +199,24 @@ static void __delete_item(struct pppoe_net *pn, __b=
e16 sid,
>                                         char *addr, int ifindex)
>  {
>         int hash =3D hash_item(sid, addr);
> -       struct pppox_sock *ret, **src;
> +       struct pppox_sock *ret, __rcu **src;
>
> -       ret =3D pn->hash_table[hash];
> +       ret =3D rcu_dereference_protected(pn->hash_table[hash], lockdep_i=
s_held(&pn->hash_lock));
>         src =3D &pn->hash_table[hash];
>
>         while (ret) {
>                 if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
>                     ret->pppoe_ifindex =3D=3D ifindex) {
> -                       *src =3D ret->next;
> +                       struct pppox_sock *next;
> +
> +                       next =3D rcu_dereference_protected(ret->next,
> +                                                        lockdep_is_held(=
&pn->hash_lock));
> +                       rcu_assign_pointer(*src, next);
>                         break;
>                 }
>
>                 src =3D &ret->next;
> -               ret =3D ret->next;
> +               ret =3D rcu_dereference_protected(ret->next, lockdep_is_h=
eld(&pn->hash_lock));
>         }
>  }
>
> @@ -225,11 +230,9 @@ static inline struct pppox_sock *get_item(struct ppp=
oe_net *pn, __be16 sid,
>  {
>         struct pppox_sock *po;
>
> -       read_lock_bh(&pn->hash_lock);
>         po =3D __get_item(pn, sid, addr, ifindex);
>         if (po)
>                 sock_hold(sk_pppox(po));

Are you sure that RCU rules make sure sk_refcnt can not be zero ?

sock_hold()  will crash otherwise.

if (po && !refcount_inc_not_zero(&sk_pppox(po)->sk_refcnt))
    po =3D NULL;

I will send fixes to drivers/net/pptp.c, net/l2tp/l2tp_ppp.c,
net/phonet/socket.c, net/qrtr/af_qrtr.c, net/tipc/socket.c

