Return-Path: <linux-kernel+bounces-747059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC28B12F37
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0181A189537B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00B207A26;
	Sun, 27 Jul 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/4zY23I"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CE1FBE80
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753611816; cv=none; b=oDg+RjIgjhDSNm3r7taAcXn8OIDcu9qACknTzwhz3/C0UhDX8EoOovh16iS/TL3aj5djaJkym3PrgT4jhqFRrKJossLfAUHMKD+fE2LOkY+UoypxApFWZGdUSvRLE0BxFUi8jH1VP4YoiWJhrJsgXnG2LODBbnv4iGKmdgihg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753611816; c=relaxed/simple;
	bh=wKZ+wdSVT2zLismPrTnYeNtClZj0rpeLkvM39+Aizn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tV5q7us13JF6GaZkie9H34lDkJ8w7A1mNPvzhuYagnvNRnh17X+sp4EJdfD5i5DvLoIity6rVtOvwkU+/5+PilZjsqi3XicEweOS7uetkUAoXtiYzMCQxAKBOL1sdd1gJS7zvmjYdrb7+Te2WzJkTxkCNBfJ7KaeGOwAOSmZkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/4zY23I; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-456013b59c1so18641225e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753611813; x=1754216613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4iTebxkYeknnu3eio38CNOGaV1IEcupvHvkpN3fyAc=;
        b=o/4zY23IOf05RsQzHpr6pBNhFgfvnPFk9+uawAzHjOlPUzu6yhGHbLg+/niV8LGwos
         hrr2rAvEreo9NrF03mE+JB1mEjYRg/GO5PUsigRWlwq4fbEbI28NN18p9A6oBUxNfIjG
         VVdoUcJNNwgCDjikooma4ZIs/r9wN1UA3B71/PSUAopq+w3Bbq9bVgVSL0hmx/act2B5
         782+0vye8tT9MlRth0uuBsFac18hohbkxTsmUe3FIcPaxiBqAX+yr9m4kmfE6jkl32r5
         DjqE7uNJ23RXtMAHiiQwi6pwM9jtrv0yQms6ZuOnIFgOvry7hjzqzBi2q8DL6cjTPJgV
         X01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753611813; x=1754216613;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t4iTebxkYeknnu3eio38CNOGaV1IEcupvHvkpN3fyAc=;
        b=qsxfiTXQq9pTUZBXpZs+4CqRhG5fiolS2jVoUq5PRJaX8Lg6OGJCzWpK1XP6dyDTH7
         iulcBjiEluBv5hujfFiguIMF9l8ctJdYOvONB3da+M/QocfJNI2uCRdkoBoPXXMVKTVR
         AwYXcQ7LwfZUaNva4rvrf/gOhDLaHZOnA+SvoYWJeTF2ycgE2QmZFpH83vRzQA0k0/a3
         UYy0FrVX476ZGIWBHJVXg6Fbym6YpJwVMvKTD5qKv8/AhBiNI1imzcrmardKqceUqW+t
         6ViYI0xsCta4ppa5Icr4PMOUOxE2Nn/eCZvrun4cxs80kY1OcC8vvoIcH4yk4P9rwQnr
         QteA==
X-Forwarded-Encrypted: i=1; AJvYcCXmBKjlLHKAb2iHvz7ytwiCM63+/+LE2mOF30TzODNJ7evbFerOPgLQtuV5POojC80hcs0l9NoJA2AMA40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LT11ZshYjG+2oeXCgx4BBc1ptaz83eMEQN7u1IzQbQJ7POKW
	TsO3nG+BaUGu63aW1AqMXwwSwQXuLfT14pEJ3ktYcuf4B5GVl28V/zCxTmk8b64+CPj4a7l//p5
	8fYw81iWxgWgxQTiEaw==
X-Google-Smtp-Source: AGHT+IFcALmF/+LSBw+Is6iiYMTn1WPw/8ZrhL7tFBQSfUm+sfoyiXw3npeFqmKQRVU7yPgTjyXYfaMGGkptdUQ=
X-Received: from wmbem10.prod.google.com ([2002:a05:600c:820a:b0:458:6553:5a99])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450e:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-4587630f5a6mr81488465e9.10.1753611813207;
 Sun, 27 Jul 2025 03:23:33 -0700 (PDT)
Date: Sun, 27 Jul 2025 10:23:32 +0000
In-Reply-To: <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com> <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
Message-ID: <aIX-JDehurnGYppE@google.com>
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes` trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 08:52:00AM +0200, Alice Ryhl wrote:
> On Sat, Jul 26, 2025 at 4:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
> >
> > Every type that implements `AsBytes` should be able to provide its byte
> > representation. Introduce the `as_bytes` method that returns the
> > implementer as a stream of bytes, and provide a default implementation
> > that should be suitable for any type that satisfies `AsBytes`'s safety
> > requirements.
> >
> > Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> > This is the sister patch of [1], providing an `as_bytes` method for
> > `AsBytes`.
> >
> > It is going to be used in Nova, but should also be universally useful -
> > if anything, it felt a bit strange that `AsBytes` did not provide this
> > method so far.
> >
> > [1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-chri=
stiansantoslima21@gmail.com/
> > ---
> > Changes in v3:
> > - Use `ptr::from_ref` instead of `as *const T`.
> > - Link to v2: https://lore.kernel.org/r/20250725-as_bytes-v2-1-c6584c21=
1a6c@nvidia.com
> >
> > Changes in v2:
> > - Use `size_of_val` to provide a default implementation for both `Sized=
`
> >   and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
> > - Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a374=
4f69@nvidia.com
> > ---
> >  rust/kernel/transmute.rs | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> > index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2abc58=
01564cacda232218c 100644
> > --- a/rust/kernel/transmute.rs
> > +++ b/rust/kernel/transmute.rs
> > @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
> >  ///
> >  /// Values of this type may not contain any uninitialized bytes. This =
type must not have interior
> >  /// mutability.
> > -pub unsafe trait AsBytes {}
> > +pub unsafe trait AsBytes {
> > +    /// Returns `self` as a slice of bytes.
> > +    fn as_bytes(&self) -> &[u8] {
> > +        let data =3D core::ptr::from_ref(self).cast::<u8>();
> > +        let len =3D size_of_val(self);
> > +
> > +        // SAFETY: `data` is non-null and valid for `len * sizeof::<u8=
>()` bytes.
> > +        unsafe { core::slice::from_raw_parts(data, len) }
> > +    }
> > +}
>=20
> Let's also have an as_bytes_mut() method. I would require the type to
> also implement FromBytes as it lets you replace the value with another
> set of bytes.

s/I would/It would/

FromBytes is needed only for as_bytes_mut(), not for the existing
method.

Alice

