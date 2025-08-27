Return-Path: <linux-kernel+bounces-787793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC52B37B29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D087682F93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEC314A69;
	Wed, 27 Aug 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIwdyiPy"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA53128C6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277962; cv=none; b=muclYb0ZwSzckafUJtL2lkHJmhzqKmyQlXfH15S4CYbz3qPYGR9h3mK/qI/Jeb6YoF8gqwi2QTB5MM4eKfuyjXffKVy797M72WFwpoiSs54+5Cu2lLJUtlKinMRaoeL5T8IJ6HlgaTAUBWon8xzYsL3QtY9HjU0TyYiOJtTuBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277962; c=relaxed/simple;
	bh=IazXTORiwmrxESh5ChR6Z1IBifIP08ze93TJKoaMpmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAHwaLheVOvJ/jrZaVTisNyxo/CB9aOv14l47wm77gZ0AtYrLNwkz774B+kcS0RIuVYIo1nBKWB16eMwKfi/yEsRk3czinOW6tclqaXtKayoDAbs8FQs0FAapS7v+P5tEUah/fRNtFAZEgY0BliMmI71YeQKsNOPEkC4fTMshl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIwdyiPy; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b2979628f9so71527591cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756277960; x=1756882760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHp4MGuOmcKjsLZf2Q1ESubrloQvz8piEgYbn0AKW0A=;
        b=xIwdyiPyuPmjfEvJPOo3QT5XmRXk67Ipwuo1+HzVOIWuMuzda8bSGXKTQ9WoCiC30u
         Sv+zMsVhaUXjYi8BZiKSi52XCmR/phNpwtw53vvs2aD8+tq8lxyaUzef3q7cM2I+xPqQ
         MgTeVqNaQm7UIVBKcYlRWmeXViZX8qa8sT03Hk2Cn+x0U/uaguZytYrG8OOrGKAnubfS
         AjLGoAUJos/RlWuLpDAu2l4KZ4xUdyE7YWJxddXMeHiLSFN2r3oz4yP5R15TdnlgAOAu
         rfQI+0cH+LAtBVwLIiq9usa++tbgmTL4exrEUT7oZkW8Dj1lSTusamt2qBO/BY1HbLP/
         6q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277960; x=1756882760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHp4MGuOmcKjsLZf2Q1ESubrloQvz8piEgYbn0AKW0A=;
        b=Nqoz2MY2N3YLDHitzuDikzb32YHIr1rwaj5Ozyra1x+MoI1sIkK8UCwkUIvoJMcMnv
         79u2F4eAkz3cd4zhNJ+cFUaV4jqbCzYwC4rci0VpJbYYHFwuGMcbt2RHOMUcKStqS3kO
         /wkVx84hPtqcVQb/7rXbxPiLy15Nx7AII9MH/pz+T707Z8epd0Po/PHy9VGz7xpP8B+n
         fsT6yJ3SWQIi6U13Qot8hKh6+Baj0QFSRJzNLh0vQny1It1WneAMxecw1sU/P5veu4kU
         2kVWT7l/nO+lJFFJQ68cJHmFOetgNN5r4cKr5wYEaYaFrHI+W7bpB3DSDoNzQl6ID+T7
         aMRg==
X-Forwarded-Encrypted: i=1; AJvYcCV+TLW5LMK+AZJ1NSggLGFVBGAXEOOrtYTjbLEYSBnzBJV3M+Xgk6kYUlC4FaPOEz5Ugn+pPpdSKUgFpjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AxTvboa/OycZeXCiyaS9rREcJ2PQfzX73XByoM+jbxqsTF0t
	y5jKeOm6FF5LgeSfnTX1AHaNf4YBYcca4rMt3UioIgHq5QvQTyUaTp3XZIfY5e/X5mFY/7mRRZT
	oZQuGzuOHU7RoWV8UxGgUZ6+jgkEUmp3HrcWt8RmxhaC+CbdwR3TV1u94LqM=
X-Gm-Gg: ASbGncssL7BIFTcNmj6cx8xic5PQJ5H/JRqyovgBKKuV6SCL5o6n8dvh8uR/ElWhUtF
	gMY7r0iZxY4sBCnJaTssX3lFp/E3MJLcwxbDa+xc2iOo/2iMG8HH9NRxWp7ktlbzMzqYUlwe/Of
	UZDxw9UOVQ6bD8EWFSfjsgra0ydxD+4Bo3ZAUDUkWvlRVG92oXZJgc2PNSaBYF6k3rMyuuH95XW
	ebNny1KQcw6G1pA8wO+Dj5X
X-Google-Smtp-Source: AGHT+IEjOOAu5Ao9ZPzoy9ljOE/xOyIGwWLnSnWvQwChaKBA8ux2u/LmXY6UN9XKHoYYk3GUUXEW49Ugq1FkeV7FQUE=
X-Received: by 2002:a05:622a:2cf:b0:4b0:616f:919b with SMTP id
 d75a77b69052e-4b2aab394c5mr243346541cf.39.1756277959684; Tue, 26 Aug 2025
 23:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827023045.25002-1-dqfext@gmail.com>
In-Reply-To: <20250827023045.25002-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 23:59:07 -0700
X-Gm-Features: Ac12FXyTke3m65fEaT_MeRq7h5ymQgWCkAGU2EQT7tgR8-dDBTvQOzBGpU98Ws0
Message-ID: <CANn89iKpWu8WyM2rfFYtSjovs7SwkcFo187Rgx6Rzpf-TJ-LGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] pppoe: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:31=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
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
> - get_item() now uses refcount_inc_not_zero() instead of sock_hold() to
>   safely take a reference. This prevents crashes if a socket is already
>   in the process of being freed (sk_refcnt =3D=3D 0).
> - Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
>   period.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v2:
>  Use refcount_inc_not_zero() in get_item() to avoid taking a reference of
>  a zero refcount socket.

Please next time include a pointer to other versions

  as in:
 v1 : https://lore.kernel.org/netdev/CALW65jZwrO5hQs_rm1Qo_+p-6yiKm+AdC9Zjk=
fjZnoWAm+i=3DBg@mail.gmail.com/T/#m0c2d63508ec072f7a0079a8b22ddc35f622f051e
 v2: https://lore.kernel.org/netdev/20250827023045.25002-1-dqfext@gmail.com=
/T/#t

This allows reviewers to better follow the changes/suggestions.

I think there is one more problem with sockets destroying time.

sk->sk_destruct being the default (sock_def_destruct),
we will eventually leave some packets in sk->sk_receive_queue, and
kmemleak will fire.

You will need to add this part to make sure purge happens after RCU
grace period.

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42adef0f8dd2adec59dfe9f7d9f4a9339..763dea35fbcf4b30e09fb1e9c46=
386fdd9b5bc21
100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -528,6 +528,11 @@ static struct proto pppoe_sk_proto __read_mostly =3D {
        .obj_size =3D sizeof(struct pppox_sock),
 };

+static void pppoe_destruct(struct sock *sk)
+{
+       skb_queue_purge(&sk->sk_receive_queue);
+}
+
 /***********************************************************************
  *
  * Initialize a new struct sock.
@@ -542,6 +547,7 @@ static int pppoe_create(struct net *net, struct
socket *sock, int kern)
                return -ENOMEM;

        sock_init_data(sock, sk);
+       sk->sk_destruct =3D pppoe_destruct;

        sock->state     =3D SS_UNCONNECTED;
        sock->ops       =3D &pppoe_ops;
@@ -599,7 +605,6 @@ static int pppoe_release(struct socket *sock)
        sock_orphan(sk);
        sock->sk =3D NULL;

-       skb_queue_purge(&sk->sk_receive_queue);
        release_sock(sk);
        sock_put(sk);

