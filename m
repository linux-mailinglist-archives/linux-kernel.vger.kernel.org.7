Return-Path: <linux-kernel+bounces-756729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC99B1B865
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9EC625D09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0168292B26;
	Tue,  5 Aug 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb2N/TB5"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5C28BABE;
	Tue,  5 Aug 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410959; cv=none; b=Kg5ql/zlBinpQPEDz38oXqbi/thRNzgAcmdNxHm3Nm1LxSSxfAWWLki+OFtb1PEHquK24UQveJSHxUmi35aa9Bm+04fsXi3NDalD2UhLyssgFwwz9klnLsh4fZD6fxH0N9thUCEZmZ/+onkP19xHp5ljcjYr25rBZhBuy4b4zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410959; c=relaxed/simple;
	bh=mBObML7qDsoT9AiQdzoB+Qj9F5wyYXGWLHp2MwvtArE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcDhlmwccn56FNkItvrE1AvRs3SBvMkrCLCfKBqzGsdUoIRivh85943YwBpGDCCkDXjepUUeTUy0POd2VKHcqZKee/T90QtB7vUuZUK4oQqktvhTBS0NDreacCJrUlVqCLAQgImeOjW4SlonNDqEXD5ZBwR6cBlrYdlwolDeJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb2N/TB5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b070e57254so19394041cf.3;
        Tue, 05 Aug 2025 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410955; x=1755015755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uHEx7ksgGA+ZZAbvISIZeprCMBbheroJgs7Yg2rMN8=;
        b=Fb2N/TB5AWCHseyzX9wBwNH+uEMHAD8fo7Zz5a+Ttdi6KofSHzsrgQFeEkO2T3sudm
         XZj6tg9Ld6rPg3sZPfLjrMBx118vmzMt6jGTK1RvF4lRBKiXBeQWz3Nb+kgXFxWmHPsk
         fkFSJO10X6ABzR5vU2DAo/+kYYzkddtg17ig0gTIQ1SUcaFqYx18X3KCKK10mBAlCpKN
         CpYGOzXuBmW0frjhlyr9v4CbchIHtn5FkC4DHg6CFEQUhtTJfM8b0p4p8GqVjh7KcXVp
         paWgnpxiXsfLT05knk/JV+KaSOeLmgq+ILTcj5aFbuPN3dbbwO8yis/lp2aLGkADyP3G
         Id9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410955; x=1755015755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uHEx7ksgGA+ZZAbvISIZeprCMBbheroJgs7Yg2rMN8=;
        b=AD2aJSZHfJHW/rMLeNY0XC5HDZ4189scDVxIXej7owTq8ZxohP6abm+EG0QzLwwfWW
         /afqwNiSMjGxgmwbTut4183DpIBfGCRZtnA+/12KBvZNZWNdvr6kHrmTV8fmK6d5Xrs9
         vuSwhHpGN083m/+PgEGCltGn4m/c7vhZBUXc2sm2XrcYIZgiHpG78zZkkDetBMSbe30v
         h3iJ5Zh/mEvUlWQc0PyhzKxpQt3AYWNwZm0l2vtGojOpf6PILnOpvb0WWayjI8y2NIng
         G3h5sfDQkNeiwuzYHUnJExCx2Rpaml6GKntybdaqsouZvOrJu6p3RUtCGc62wyKZp46R
         6gPg==
X-Forwarded-Encrypted: i=1; AJvYcCVLV0ajudBk3rCOtPPhAmTerWw/QQR9Hlh0BqKKxLYeMdak9YxML0Zm2yt5P/Z1++Jx5RoTJS+OROfeHtEXAtc=@vger.kernel.org, AJvYcCXusxykKhWURW0leBu1TDOEPYoYb4ICIohJCX2AJMp4KDxdL9bXGvXis+ogAtHF6W8AZJDYTAdDg+OwjdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6br0P0huIF783BzqgZQtiLOINNgg8wtgo2wm9WZyaohKDrH7
	SLy75h4dqtoiybSglAjYzBH2VEHiIzioxihyeQgcp1H1Xf8+z3w9MtEY
X-Gm-Gg: ASbGncu25S9TLPHBW7zNpGpOU/V4UVlT0W+V5L6LCnkP/fhn12oV6evZHNIcVHwKbRv
	fadxADT6D9KWAd29+0QK/989LSB5pCa3+LE2SdYle9HbDtGfnB2OdNbJwVYGjbFU6Rd/IKxe6H8
	k746Ey5puzu0nObysc0L6i8NRI0k/QNnRLt2EV5PPMFYUqZq4d/oIRh2SUCZLtI44lQU2jz+k+m
	NvezpdddCm+cWFPEH7G/bPZ0p2Gp75A28M5HuJEiICMkoY7H+d7gFkmztPr/97bXhl+eydidMab
	ltAQTxFEOtL+pTPTS47YTHmLVyXxEx4u2uoATJp2ize+LYA/NoC62fZjJ2pdy3LMGlj+JUKiMLn
	evFdjrFT9pS5h+xZWZPjhQOTxNCSfzJEuxkmKIo3XFGcJ
X-Google-Smtp-Source: AGHT+IHZqQDby+0Nn82o1JH83l6sjDPbt2o4+BonnaDPZXLHlgr4LxMoI2fRNvj7l1pA/H9r9KDVkw==
X-Received: by 2002:ac8:7d88:0:b0:4b0:7a70:d742 with SMTP id d75a77b69052e-4b07a70dc33mr86317241cf.36.1754410955182;
        Tue, 05 Aug 2025 09:22:35 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c70:a300::bb3? ([2600:4040:5c70:a300::bb3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b079509237sm17671111cf.50.2025.08.05.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:22:34 -0700 (PDT)
Message-ID: <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: Lyude Paul <thatslyude@gmail.com>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, 	tmgross@umich.edu, dakr@kernel.org,
 peterz@infradead.org, mingo@redhat.com, 	will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev, 
	bjorn3_gh@protonmail.com
Date: Tue, 05 Aug 2025 12:22:33 -0400
In-Reply-To: <20250724165351.509cff53@nimda.home>
References: <20250621184454.8354-1-work@onurozkan.dev>
	 <20250724165351.509cff53@nimda.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey! Onur, if you could make sure that future emails get sent to

lyude at redhat dot com

That would be appreciated! I usually am paying much closer attention to tha=
t
email address. That being said, some comments down below:

On Thu, 2025-07-24 at 16:53 +0300, Onur =C3=96zkan wrote:
> Hi again,
>=20
> Just finished going over the C-side use of `ww_mutex` today and I
> wanted to share some notes and thoughts based on that.
>=20
> To get the full context, you might want to take a look at this thread
> [1].
>=20
> - The first note I took is that we shouldn't allow locking without
> `WwAcquireCtx` (which is currently possible in v5). As explained in
> ww_mutex documentation [2], this basically turns it into a regular
> mutex and you don't get benefits of `ww_mutex`.

I disagree about this conclusion actually, occasionally you do just need to
acquire a single mutex and not multiple. Actually - we even have a
drm_modeset_lock_single_*() set of functions in KMS specifically for this
purpose.=20

Here's an example where we use it in nouveau for inspecting the atomic disp=
lay
state of a specific crtc:

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/dispn=
v50/crc.c#L682

This isn't actually too unusual of a usecase tbh, especially considering th=
at
the real reason we have ww_mutexes in KMS is to deal with the atomic
transaction model that's used for modesetting in the kernel.

A good example, which also doubles as a ww_mutex example you likely missed =
on
your first skim since all of it is done through the drm_modeset_lock API an=
d
not ww_mutex directly:

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/dispn=
v50/crc.c#L544

drm_modeset_acquire_init() is a wrapper around ww_mutex_init() which actual=
ly
does pretty much exactly what Daniel is describing lower in the thread:
keeping track of a list of each acquired lock so that they can be dropped o=
nce
the context is released.

drm_atomic_get_crtc_state() grabs the CRTC context and ensures that the crt=
c's
modeset lock (e.g. a ww_mutex) is actually acquired

drm_atomic_commit()=C2=A0performs the checking of the atomic modeset transa=
ction,
e.g. going through the requested display settings and ensuring that the
display hardware is actually capable of supporting it before allowing the
modeset to continue. Often times for GPU drivers this process can involve n=
ot
just checking limitations on the modesetting object in question, but
potentially adding other modesetting objects into the transaction that the
driver needs to also inspect the state of. Adding any of these modesetting
objects potentially means having to acquire their modeset locks using the s=
ame
context, and we can't and don't really want to force users to have an idea =
of
exactly how many locks can ever be acquired. Display hardware is wonderful =
at
coming up with very wacky limitations we can't really know ahead of time
because they can even depend on the global display state.

So tracking locks is definitely the way to go, but we should keep in mind
there's already infrastructure in the kernel doing this that we want to be
able to handle with these APIs as well.

>=20
>  From what I have seen on the C side, there is no real use-case for
>  this. It doesn't make much sense to use `ww_mutex` just for
>  single-locking scenarios. Unless a specific use-case comes up, I think
>  we shouldn't support using it that way. I am planning to move the
>  `lock*` functions under `impl WwAcquireCtx` (as we discussed in [1]),
>  which will make `WwAcquireCtx` required by design and also simplify
>  the implementation a lot.
>=20
> - The second note is about how EDEADLK is handled. On the C side, it
> looks like some code paths may not release all the previously locked
> mutexes or have a special/custom logic when locking returns EDEADLK
> (see [3]). So, handling EDEADLK automatically (pointed
> in [1]) can be quite useful for most cases, but that could also be a
> limitation in certain scenarios.

Note too - in the example I linked to above, we actually have specific
functions that we need to call in the event of a deadlock before retrying l=
ock
acquisitions in order to make sure that we clear the atomic state transacti=
on.

>=20
>  I was thinking we could provide an alternative version of each `lock*`
>  function that accepts a closure which is called on the EDEADLK error.
>  This way, we can support both auto-release locks and custom logic for
>  handling EDEADLK scenarios.
>=20
>  Something like this (just a dummy code for demonstration):
>=20
>     ctx.lock_and_handle_edeadlk(|active_locks| {
>         // user-defined handling here
>     });
>=20
>=20
>  That would let users handle the situation however they want if they
>  need to.
>=20
>=20
> Would love to hear your thoughts or suggestions on any of this.
>=20
> [1]: https://lore.kernel.org/all/DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org/#t
> [2]:
> https://www.kernel.org/doc/Documentation/locking/ww-mutex-design.txt
> [3]:
> https://github.com/torvalds/linux/blob/25fae0b93d1d7/drivers/gpu/drm/drm_=
modeset_lock.c#L326-L329
>=20
> Regards,
> Onur


