Return-Path: <linux-kernel+bounces-833632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AAABA27D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B23A4C39FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31927A907;
	Fri, 26 Sep 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK8ABTI0"
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76434BA5F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866658; cv=none; b=sSucFzVxpmvPlFM52sgc4YlJDd+3BrUW8esOYWbfKo/gv65V/s9bhHSKSu3cOAKCa/VQdiMdydfH0chc21xnNUgF5jSf9IBdoLtJnzxAwCAngmD91mUDeXi4IMHtBruqHvCgNhgWAziSY0zjCPsEl5bawL6x0bJ32Qt6IDORCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866658; c=relaxed/simple;
	bh=15IRCIhsbMtksIEBPAtWUBg1v6M0alPNiSjplbzX2Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMNW1DPXnUfKbF/r3i3ov0uV6EvHAlnbUNvJwQkpqU74vpnWfx9QTquFABFmcpFyS9GeLFka/sbkjIQpKCnRaFrWy/quzvX1ba6hf+Y24EDV9YqFy0aqZjvrCup0XzNTJVCwo14wO4joQqVNDzMVWtcVKWrL/oB/oudVeZKybKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK8ABTI0; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-635380a4a67so1570651d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758866655; x=1759471455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H/gn2bXgyEZpagQYajtzENYtfpKhUj6jXIrNVLa+ts=;
        b=AK8ABTI0wUNBOMsWuY+DWkYWxgRNplY47xmI16NgCx2uRMD3E+AP1zYjRKlBnQNjOH
         048Xh7VQOUmuLm6giqSTKqJBfcPtic8YDZLXAeP2QcLTpffZF1AiNgQ+CpXv4vshKN/y
         qu7ie863tX/N3BJ2SiQUOd0emtnIKMgglfM92kXqcgC721U7ijfjikL9c3BN7wlqxVKT
         Kv71P7fD991OREWO/W+MtOmWVHpqdn6ctRpJ9iiex/V4F4s0MahFEPhtn5lFJrGXAB5+
         9M50Xd+F3ZeOj6gRTh9DKK0ELqrEe+6CENBRZG08VKlovqJVd5A6jouIWQYObOyCuhgO
         UqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758866655; x=1759471455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H/gn2bXgyEZpagQYajtzENYtfpKhUj6jXIrNVLa+ts=;
        b=jxIRkkGOXGOFOdmXKgEspBQU7NnJrb1eETAytOdebdOol9JUkAV94vdUKY9facDR3y
         jsg8ipf1Q/4gTMZiCqDEzAHon1VL8TR6hotlFCBlQMcue4vAiIMvyw638s9MtKmu0dwm
         tsNLyvRIjaHkrCIOc7bwTCzNssy06F5+L1KX4dYV10ZXvz+aELDfIboCgoBld2FBfZxT
         mgK+gcaxtg/F52bBqVg/kE/NHfqdtTckmc76Nav2+uGt8K4GxDgR4Q+RgylmyRyaL0On
         df1fUX3mtPhVWCGlpoxk1HKCvHWgRgk8Th6sYokdKT92To7WgMWQA0KDQRnKr1rY0cxZ
         wCdw==
X-Forwarded-Encrypted: i=1; AJvYcCXvSTo4FQ+i6gXQYjILt1tBobdLY+OLoOE46OaHs/Ym0b6IKtwouOxtbzMVIFRGtTHWszZG7jTLTVqKt40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKGCXDQcjEnU/T1pG0ZcxXE5CQ1x488c+3w2kgj1CAXyHNGUf
	PLDiJ412I8nkpsKSoXaBRUL6bQLqP8dCSZTnpswG3e3Bs2Ukcfz6U4Bo18pE1cfXb8KNy5oqmuc
	uVYn4ChaOZbF/qa1h5kiLXGZBa5Em6TQzrosHItxKXA==
X-Gm-Gg: ASbGncs8LYVW+0CKd2k20hGQpcifwj9UpVL8Bh26vOaFS/3XvexsrjcHA/ppobpY9nb
	ho8L4UiYcYDfgUdiXYK4SambBInnGaenJ3T7+eSjaDN75ST/wAMs8trkI5OYrfg4q5u8HeyyvC6
	sEyYyRAwmEkWsYOeU/tGUfP2jP/YEWd3PNVx41GpCEab6wD5xYBEe6sd8rhRYpxJk+9liV5EJ3u
	lZW/mA=
X-Google-Smtp-Source: AGHT+IFLKqa96SN32ucZyftcaFR3mfhPDDNAMHzDSvk2jt4uz+Ewxi9Sy+yvSExYS1gIFclZKPr1gm/c12BhL0elJOc=
X-Received: by 2002:a05:690e:88:b0:635:4ed0:5714 with SMTP id
 956f58d0204a3-6361a8203fcmr3880524d50.46.1758866654962; Thu, 25 Sep 2025
 23:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923060614.539789-1-dongml2@chinatelecom.cn>
 <aNI_-QHAzwrED-iX@gondor.apana.org.au> <CADxym3YMX063-9S7ZgdMH9PPjmRXj9WG0sesn_och5G+js-P9A@mail.gmail.com>
 <175862707333.1696783.11988392990379659217@noble.neil.brown.name>
 <CADxym3ZA7FsdeA3zz34V7mHHjBC358UoJjrpV6wieZ1LF2aFxA@mail.gmail.com> <175884658630.1696783.7712739490823387474@noble.neil.brown.name>
In-Reply-To: <175884658630.1696783.7712739490823387474@noble.neil.brown.name>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 26 Sep 2025 14:04:04 +0800
X-Gm-Features: AS18NWD-s8rMNpkwFnMzAuRNTEnbQ9ytZZMmmUUayZWUbFpKwJunKSpvUDw_lL0
Message-ID: <CADxym3bFCuiDWtpEVVSpEt9wmO_6cigCjz8385Ty2h0F8_4sWw@mail.gmail.com>
Subject: Re: [PATCH] rhashtable: add likely() to __rht_ptr()
To: NeilBrown <neil@brown.name>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, tgraf@suug.ch, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:29=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Wed, 24 Sep 2025, Menglong Dong wrote:
> > On Tue, Sep 23, 2025 at 7:31=E2=80=AFPM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > On Tue, 23 Sep 2025, Menglong Dong wrote:
> > > > On Tue, Sep 23, 2025 at 2:36=E2=80=AFPM Herbert Xu <herbert@gondor.=
apana.org.au> wrote:
> > > > >
> > > > > Menglong Dong <menglong8.dong@gmail.com> wrote:
> > > > > > In the fast path, the value of "p" in __rht_ptr() should be val=
id.
> > > > > > Therefore, wrap it with a "likely". The performance increasing =
is tiny,
> > > > > > but it's still worth to do it.
> > > > > >
> > > > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > > > ---
> > > > > > include/linux/rhashtable.h | 5 +++--
> > > > > > 1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > It's not obvious that rht_ptr would be non-NULL.  It depends on t=
he
> > > > > work load.  For example, if you're doing a lookup where most keys
> > > > > are non-existent then it would most likely be NULL.
> > > >
> > > > Yeah, I see. In my case, the usage of the rhashtable will be:
> > > > add -> lookup, and rht_ptr is alway non-NULL. You are right,
> > > > it can be NULL in other situations, and it's not a good idea to
> > > > use likely() here ;)
> > >
> > > Have you measured a performance increase?  How tiny is it?
> > >
> > > It might conceivably make sense to have a rhashtable_lookup_likely() =
and
> > > rhashtable_lookup_unlikely(), but concrete evidence of the benefit wo=
uld
> > > be needed.
> >
> > I made a more accurate bench testing:  call the rhashtable_lookup()
> > 100000000 times.
> >
> > Without the likely(), it cost  123697645ns. And with the likely(), only
> > 84507668ns.
>
> a 30% speedup is impressive, even though it is a micro-benchmark.
>
> >
> > I add the likely() not only to the __rht_ptr(), but also rht_for_each_r=
cu_from()
> > and rhashtable_lookup().
>
> I suggest you create a patch which adds rhashtable_lookup_likely(),
> __rhashtable_lookup_likely(), rht_for_each_rcu_from_likely(),
> rht_ptr_rcu_likely() etc.
> So that no existing code changes, but the new function uses likely
> everywhere that you think is important.

OK, sounds great! I'll send such a patch.

>
> I had a bit of a look at callers of rhashtable_lookup().  Some return
> -EEXIST if they find something. Other return -ENOENT if they don't.
> Using rhasthable_lookup_likely() for those that return -ENOENT probably
> makes sense.

I'll do it.

Thanks!
Menglong Dong

>
> Thanks,
> NeilBrown
>
>
> >
> > Below is the part code of the testing:
> >
> >     for (i =3D 0; i < num_elems; i++) {
> >         objs[i] =3D kmalloc(sizeof(**objs), GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, objs[i]);
> >         objs[i]->key =3D i;
> >         INIT_RHT_NULLS_HEAD(objs[i]->node.next);
> >         ret =3D rhashtable_insert_fast(&ht, &objs[i]->node, bench_param=
s);
> >         KUNIT_ASSERT_EQ(test, ret, 0);
> >     }
> >
> >     /* for CPU warm up */
> >     for (i =3D 0; i < 1000000000; i++) {
> >         u32 key =3D 0;
> >         struct bench_obj *found;
> >
> >         found =3D rhashtable_lookup(&ht, &key, bench_params);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, found);
> >         KUNIT_ASSERT_EQ(test, found->key, key);
> >     }
> >
> >     rcu_read_lock();
> >     t0 =3D ktime_get();
> >     for (i =3D 0; i < 100000000; i++) {
> >         u32 key =3D 0;
> >         struct bench_obj *found;
> >
> >         found =3D rhashtable_lookup(&ht, &key, bench_params);
> >         if (unlikely(!found)) {
> >             pr_info("error!\n");
> >             break;
> >         }
> >     }
> >     t1 =3D ktime_get();
> >     rcu_read_unlock();
> >
> > >
> > > Thanks,
> > > NeilBrown
> >
>

