Return-Path: <linux-kernel+bounces-868488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA1C054C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807BF1A64D39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A0309F19;
	Fri, 24 Oct 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4D48iXqt"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383C309EE2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297599; cv=none; b=qz/xkRag/G/G06ftgbVsXwC8N6SxEiRDQCdeSHyGC83QN4kfYCPYk1oVprs6+10muQUqWmrk7+FzKD+W77RD1+S7VsrZimPSzodAcCkdfKYYY1evD97JUnlUegs3WyD7f7e2TlOOSsMTUXYlykjujEwsOe+TNkbLyFXBucZRJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297599; c=relaxed/simple;
	bh=tj9sY++LZkzvHe1f64tI96u/mkvypwjhfSQvuJM76Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2joVtgRYJ1mSciVmHgV1aVtWhUHXDoIBVTTtaPoIFyNd1A+BhFX9CS1KSvswfX36Ykp86Da0OJwl0KPinMJNmC8HCpeirZ/yGxdnGpcMrDx7mQknW3RM64pJPaD3HIIjay6uvo2+2oRvTTPk4rSftlgzGI7y4QIf2daV2fMNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4D48iXqt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8901a7d171bso183279785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761297597; x=1761902397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twcKB1hm/Ie/5PoJp3KEG1N7Jytbx89hSg/ow35Xqp8=;
        b=4D48iXqtJ/CDumG4qSxPqy8EIgOclzgrsybfSh6StSQDn8gyMu2k1KSlU1bMDpGpHN
         tP5krKDZ9dj6WObINDjRKw2lW4CkU659Ro+XNSZHtVUUVTdl1pXpM5NxMlsywW6FnrtF
         59qBU/fCu9y5ctyEHzLKeDmKj23xZ6/3mETCnZWE6PLX8JtHEP1T8WIHkPYbG0ADiF79
         I4fDj5tD7JHALxCFR/iGKJ/DcxfRsGQ8VM+RSWZd+G4KYguF2xx+Ovxd9iXLO+Mmss2q
         HZkwQQR8Fy0Pk/iRkX1XESW7XlbWCV+jHa1iYxNm2NKO4RS8x7aOZM8OHSWPH8egpA2o
         VtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297597; x=1761902397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twcKB1hm/Ie/5PoJp3KEG1N7Jytbx89hSg/ow35Xqp8=;
        b=l0c6bAQnO4bgA7xKLlxyM17Gi6alc0gWQQheZOPYPZz0sQ5W0NCe4xaYGRnUGeKul7
         NxygHqrHgaIuVFInioPg7Ox58EmodH8WhJ5FW7zRtmO5gk/TzSsnHSRIYLhQ5J5OdS7I
         PFRjWcUOoKDAZUMOjlIyTFXeMKkMxZLqv6G9WvJqoUuxopH7XsgPSRUrIMTBQitPjK23
         656vZPn7Qi57TVg8h5ck9dcVId2KBWEuQs8h0bRinGuFBzUdV5KhGtsEvJp/yYDtye/s
         /rXBAcu3kQy4apMlL5TgeVt9cSrgVfWyJ8YEzw6s7q2eKCqyalwEEMCldCTvqoUq3EXN
         tBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUbCd+pCL+Z6KhGvB4o9ZpfoSAc5l5vDEmHgOAZ97tcF+v2BlRgiMwCsuGW22CyCAa80MEYmMhsUcuoP68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9ohBhKw/eDDLLqPAWq57VKiGHmqvDKNnrZ88kCwacpkyvK55
	Jvj++47KHSpZtO9X7vB5Oj1MDa8+XZKFwV7sviLAVPnoQFoGUE9ciz8MkqVK4WwyfY9c7VsIq9i
	7Xmgo9Kkm0LqPL+sYXEzs8zhsU1eUr400R/Ra5/NM
X-Gm-Gg: ASbGncue/FxmVUyoO3aHFvGO/L/KYjf7dJrKVCfdAFrXkhXu8MQLu0pS2NOTdJu6Mi0
	OcvFpgqQ4zZOgiOiE/9TwOMHphbZEt6KrwLIdiS8dMPHMgZkcfcA72hJnECUKUHvX7BeNulomit
	3fK3+dt+xDXVdl2MkBtH994/bSM9CxMGj6pY7iDMciqW1Ylr9Uyb5aFChqVaxBZlSqBpdzaCWce
	8vIIC62PtIji6l7ajB+oHZqg+36HfDuODY+QJ6dVOyurvQVGp1JMO8l1DrfYyjXZIfzGw==
X-Google-Smtp-Source: AGHT+IELThhQ8ILVw5nuo5976ycY9bB+OZ/LcmK2ueQZ09CwFSYkjJaTgg0wCVkT81qczhOxurRBwaO1v9J6HO5i8hI=
X-Received: by 2002:a05:620a:31a4:b0:893:b99:7114 with SMTP id
 af79cd13be357-8930b997cabmr2102715285a.82.1761297596672; Fri, 24 Oct 2025
 02:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024090630.1053294-1-lizhi.xu@windriver.com>
In-Reply-To: <20251024090630.1053294-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 02:19:45 -0700
X-Gm-Features: AS18NWDEKpX6DxQFX-E95G22l0XMZHGoUhV3IsKo9AGOEPWAGImfkcQ19Hdmzz8
Message-ID: <CANn89iKS3ZOSva0EUjLFD+CmJeT=JgX3-7bHxgHChMMQpx+7=g@mail.gmail.com>
Subject: Re: [PATCH V2] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: kuniyu@google.com, davem@davemloft.net, horms@kernel.org, jreuter@yaina.de, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:06=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2=
.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat=
,
> a UAF is triggered.
>
> To avoid this UAF, defer the put operation to rose_t0timer_expiry() and
> stop restarting t0timer after putting the neighbor.
>
> When putting the neighbor, set the neighbor to NULL. Setting neighbor to
> NULL prevents rose_t0timer_expiry() from restarting t0timer.
>
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_a=
x25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
>
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>
> Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: Putting the neighbor stops t0timer from automatically starting
>
>  include/net/rose.h   | 1 +
>  net/rose/rose_link.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..ecf37c8e24bb 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -164,6 +164,7 @@ static inline void rose_neigh_put(struct rose_neigh *=
rose_neigh)
>                         ax25_cb_put(rose_neigh->ax25);
>                 kfree(rose_neigh->digipeat);
>                 kfree(rose_neigh);
> +               rose_neigh =3D NULL;

What is the purpose of this added line ?

@rose_neigh is a local variable. Setting it to NULL while this
function no longer uses it is
going to be optimized out by the compiler. Even if not optimized, this
has no effect.


>         }
>  }
>
> diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
> index 7746229fdc8c..524e7935bd02 100644
> --- a/net/rose/rose_link.c
> +++ b/net/rose/rose_link.c
> @@ -43,6 +43,9 @@ void rose_start_ftimer(struct rose_neigh *neigh)
>
>  static void rose_start_t0timer(struct rose_neigh *neigh)
>  {
> +       if (!neigh)
> +               return;

This will never fire. callers would have crashed already it neigh was NULL.

> +
>         timer_delete(&neigh->t0timer);
>
>         neigh->t0timer.function =3D rose_t0timer_expiry;
> @@ -80,10 +83,12 @@ static void rose_t0timer_expiry(struct timer_list *t)
>  {
>         struct rose_neigh *neigh =3D timer_container_of(neigh, t, t0timer=
);
>

Can you explain (in a comment) why this is needed ?
What is the precise scenario you want to avoid ?

> +       rose_neigh_hold(neigh);
>         rose_transmit_restart_request(neigh);
>
>         neigh->dce_mode =3D 0;
>
> +       rose_neigh_put(neigh);

I am pretty sure this patch fixes nothing at all.

>         rose_start_t0timer(neigh);
>  }
>
> --
> 2.43.0
>

