Return-Path: <linux-kernel+bounces-830582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A95B9A08A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A0D189F67B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69B30214B;
	Wed, 24 Sep 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Jw7hSh"
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B013FEE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720671; cv=none; b=eIiSD0qLIYtf+DhfjF+gwAPnnVhz8zfjffm2x5W4DtMApzZZwg3kPzAzfc4i2LsM4AtYn/DHjnD7aQadSfXplJZzUwjA2/fVtCFtPt88J+VByNDEEkqhfUdrsWBGWCJqk2Fn9eOlMNK0tICHq630b9BE0EKccpqe0dKRLBJuZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720671; c=relaxed/simple;
	bh=46Xxj40QWyWAnu3jMesyuN/ZQk0DISGVbez5MDqEi+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPZlj6HWYgYm+Rby6ENeanzpDMqhZIjmXZxaF4q6zBAw1O8kJu3+yeKWE90CufPR2bE2s7sewBVmSV3W8MB6/6du8f2Bujit40rHCwY28QE+Vm6wYG3z3ogfHd79kr4Jhxjsa1X1oE2LpeQ7BLAmkCD/+v6XF71B/OqW9lwdL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Jw7hSh; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-72ce9790acdso63831557b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758720667; x=1759325467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o/bKsm97JI+1qdk5N1JW8cXmeYcYmwcOzqbBYKqO7k=;
        b=R4Jw7hShU4EUiHUiSodMZuOyEFRG1unHDRJWdejF0JnHlXLNrZgqg5wFW1FecSTPJy
         ptBEqwezJ7D8PrPBCr+v0AzIdsQTM1SdolplSumzKwHFgVKAVS5OvZFnL6tOCGTBnFTw
         BYyYks7VE75GfKnG97DEbruHvYYTyS96iuTvzE6BFgP8B6XfZfbESaCKT4I8urnN/+Mi
         D0iZu5DyE4rgA9jPkxRXh0SXKsQ/HAYiaBmYp31Iqq5Gg9fFTT3hVCNB+xq8hET5wKDh
         eeqzuC1pKVF6/4+rYzrsSEaLb7gMpgmru4a1Sy83/mhRjcFXJmPPwPwz347hO7lhTBRj
         QnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758720667; x=1759325467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o/bKsm97JI+1qdk5N1JW8cXmeYcYmwcOzqbBYKqO7k=;
        b=G0V+hNo2mFzlVVIzYInoRrK37P84Ed5uNw0JY4EBk6zAYbyC/4xkmyi/+CkWE5JEzO
         IR/Jlub49o4LDHVqrnwI8U7Hebqc6/3auGASlUKwkAXkxKYTqFx+WW0k6ECEN2gbSSAO
         9/RtlZoqxFrJYcxqPemBW5ItWbsYg7DzyxO7QI9QGFiddEStgDpnZGCUtln03bvirpnB
         Hn/0jQHtJKwww5ZhphWVd0xfi6rKKzwa22OaimpNVBo+TtyNEynVHdUBW7qf8R8031PW
         5eJZS3aB7covwbjw997CHRXB9UIZYX+V8tNmzf/pycJIbgChHNEKbtYDpxowQu0jeqit
         ArXA==
X-Forwarded-Encrypted: i=1; AJvYcCUPGGZRi6yAMCHboI2OdUdkU6WvfgYDbeBntRZXjtnNJu91I+EkTdkeCxsSESwVGEEQARNTnSdRpvKS2fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdozLZPWoVRxWFmxpFseLImJ4oVdKFE7k9QPswad5+rvwVOwM
	erQPJDPrCYmbGc2uJlxsjOCVdRgsfSiC5Gy+U5tEILY0Qkm7B2/ko/HTGQ8I9l14FQ/seQjtrAp
	dro3kagJX6CDPaTuJN3gxTLcX6p+snIc=
X-Gm-Gg: ASbGncvvu4Gp+lUj4804J6HlXwfFCw1Fba0akyKyGEyHxFZ7h913abTQNIk2LWpoIvD
	ekwDr5QdVVLPc74Dk4p7i8bVrMqukwymw9upQsgoLX7W47QJlY2LWtarAshddEu6oiZJFLJF5Wk
	tMDT7XZdWTDy+6VuEPWbf8CUQhizO89fexNJjSrjgEtsV+fypqx5MXj5EO522OnMrMvZNFH4ujd
	J8FLFCywq3aBQ0ywQ==
X-Google-Smtp-Source: AGHT+IHigQU1SwnbWbVt1/aemZ0rPCMfZqnHtTtQdJGn9ZTnDZqlnur9YC7rS9LNtus8SBzPJRH3iPXI+diPpCNf4V4=
X-Received: by 2002:a05:690c:2c0d:b0:762:772b:917d with SMTP id
 00721157ae682-762772b94b8mr7441717b3.49.1758720667090; Wed, 24 Sep 2025
 06:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923060614.539789-1-dongml2@chinatelecom.cn>
 <aNI_-QHAzwrED-iX@gondor.apana.org.au> <CADxym3YMX063-9S7ZgdMH9PPjmRXj9WG0sesn_och5G+js-P9A@mail.gmail.com>
 <175862707333.1696783.11988392990379659217@noble.neil.brown.name>
In-Reply-To: <175862707333.1696783.11988392990379659217@noble.neil.brown.name>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 24 Sep 2025 21:30:55 +0800
X-Gm-Features: AS18NWA1CfSWZmw6na-YTZ-8p6J_kZkV2o8XdVYVoFzGsKTU8FazQhmxkraJz4g
Message-ID: <CADxym3ZA7FsdeA3zz34V7mHHjBC358UoJjrpV6wieZ1LF2aFxA@mail.gmail.com>
Subject: Re: [PATCH] rhashtable: add likely() to __rht_ptr()
To: NeilBrown <neil@brown.name>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, tgraf@suug.ch, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:31=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Tue, 23 Sep 2025, Menglong Dong wrote:
> > On Tue, Sep 23, 2025 at 2:36=E2=80=AFPM Herbert Xu <herbert@gondor.apan=
a.org.au> wrote:
> > >
> > > Menglong Dong <menglong8.dong@gmail.com> wrote:
> > > > In the fast path, the value of "p" in __rht_ptr() should be valid.
> > > > Therefore, wrap it with a "likely". The performance increasing is t=
iny,
> > > > but it's still worth to do it.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > > include/linux/rhashtable.h | 5 +++--
> > > > 1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > It's not obvious that rht_ptr would be non-NULL.  It depends on the
> > > work load.  For example, if you're doing a lookup where most keys
> > > are non-existent then it would most likely be NULL.
> >
> > Yeah, I see. In my case, the usage of the rhashtable will be:
> > add -> lookup, and rht_ptr is alway non-NULL. You are right,
> > it can be NULL in other situations, and it's not a good idea to
> > use likely() here ;)
>
> Have you measured a performance increase?  How tiny is it?
>
> It might conceivably make sense to have a rhashtable_lookup_likely() and
> rhashtable_lookup_unlikely(), but concrete evidence of the benefit would
> be needed.

I made a more accurate bench testing:  call the rhashtable_lookup()
100000000 times.

Without the likely(), it cost  123697645ns. And with the likely(), only
84507668ns.

I add the likely() not only to the __rht_ptr(), but also rht_for_each_rcu_f=
rom()
and rhashtable_lookup().

Below is the part code of the testing:

    for (i =3D 0; i < num_elems; i++) {
        objs[i] =3D kmalloc(sizeof(**objs), GFP_KERNEL);
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, objs[i]);
        objs[i]->key =3D i;
        INIT_RHT_NULLS_HEAD(objs[i]->node.next);
        ret =3D rhashtable_insert_fast(&ht, &objs[i]->node, bench_params);
        KUNIT_ASSERT_EQ(test, ret, 0);
    }

    /* for CPU warm up */
    for (i =3D 0; i < 1000000000; i++) {
        u32 key =3D 0;
        struct bench_obj *found;

        found =3D rhashtable_lookup(&ht, &key, bench_params);
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, found);
        KUNIT_ASSERT_EQ(test, found->key, key);
    }

    rcu_read_lock();
    t0 =3D ktime_get();
    for (i =3D 0; i < 100000000; i++) {
        u32 key =3D 0;
        struct bench_obj *found;

        found =3D rhashtable_lookup(&ht, &key, bench_params);
        if (unlikely(!found)) {
            pr_info("error!\n");
            break;
        }
    }
    t1 =3D ktime_get();
    rcu_read_unlock();

>
> Thanks,
> NeilBrown

