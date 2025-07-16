Return-Path: <linux-kernel+bounces-733249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C8B0721D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E64B1895C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2606F2F0E49;
	Wed, 16 Jul 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFdWCxZO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786828C872
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659184; cv=none; b=Wq3pe7aDDDRdTORamfvnl4VnqZyNqyNNgE9SMNdfcWo0LOApsR/AOwvw3YX4zXcQpxSHW4qquqHl/XUzzuU2gmrOmEWDGHcOiu2lf8QUNirZfMmBqgoVhEc60/S3EHBNT261HxLak6hDpy5u4cDzY1b7hL6fMo9TNU38SrnLeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659184; c=relaxed/simple;
	bh=sK9WdAzJkT35n2OrnV74SnqD1oF6VrhrbQmeYrx4i6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXoJ484gxXSCxzTQ3iJROvzfmzOVQJwq551IYpilq64SQodXKEAjtaagILcLxE113z7INwe65Pa0HKw+ehB5/DZ98mkdQGO6IQtUMhcxeB3WIdrGKkw1L4GBv+Sjbu3wjoK+AMvjKYjxwsAyCbdmA2O60nAX0iFZ2mupZ1iAjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFdWCxZO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45617887276so25882725e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752659181; x=1753263981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unJc0BdBQI7iWQUSRrhzhQU8c9VKJ16+VGuE1/wwC/M=;
        b=jFdWCxZO/PWYEvCk3nk0q2hbPkOGwrsJD/viZjcHSiSpS5vGSVGXap6Va+ugR7wRqH
         hqVtn+K8KecePgedmF7iCmSXVLG58zTrFNhCFTKrjls/6FRkrhFUe1uaCHz1iiqA4TgN
         G0bsAJTvtQ4yCh9WEYSo9k4WoU1TVZg5fn34n1QkCNizJDhP3RNz58Ez3wtkLGzRyaTY
         p5vpPbH8r02mgTbH1aL1yYH7e9/9/0TzLqwhncQrLxOLwiWbu2posmQ/swQsq96WvSuF
         tt9ftwVRsKPadpBoDiSQtruzsFVuU7RmTbSGd0qtFRflM1XVw5jWrv7hsVHjD566c2dd
         lhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659181; x=1753263981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unJc0BdBQI7iWQUSRrhzhQU8c9VKJ16+VGuE1/wwC/M=;
        b=L73DvoC/oRPgF2HrbqRal/tmRorPrk16Sw+pTtmCFTcCMjDeDmO/GrjUgHvVx5FkGS
         e5+/nKs2sZ53nx86IOAnjnxoTNLjmjrRZ1oACyj4i1ggFyqIriYIoJjRSDxicgXPN2d6
         RQ5n2qmUQ8lMT88io7+wQpTEPpEz1rzLRxs67DLttN3yhb1j0OBe9TC/HYwapuPGbcba
         FXmIBwgfK5LOgpQpSNDHy4eA7jlcOwmiGyfNZAWkNk8QxTKDz0IEaLXRFPZ7qVTQb39v
         OL9pHAby9hIlJxt3/GisJiWMpOMi2hXNBUSt3vgyGBoClseMUW3cR0HMPDwGgGalMSbx
         01bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjypL2W7swzARwWh7Vy04mEYPAJ3pqsGHruV0I2KL0HpT9MYHRKXfrgTcz1ykrI7e2sDuHgnoEb7srkrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjra3jUvbNCWJzfOqHmjCIWk2DUVsc0noZzqv4BPtNFTiV1Ebl
	TLXj1LXP6L3qnU4MsT4CsjSxi7sM+Zm61UbXuUp69Sjqu38+JDYglSTObccb/l/Ta4PzIgA1tD3
	F5MQlMBi8Jv28XpUViDGXzL1h+HtDHG51r42t/lKC
X-Gm-Gg: ASbGnctqPB2XWIAg4sGwbL/8+zKsRourG+pgLmyMmK8Itk21SAeEYB8j+aeD0MULaXq
	mkoxQznIJWr06tPEoK7bzmxTfjtCgNXRcIZBgHYfJ4U79UP+uxGKA7S73DwhT9uUCsX5c74rowO
	11Tvuijipic/88QSwBkStuZjow+1CBKAD5/M9PPk/75+AJ/H6eWIOuvALboy+COMDndZCfvBfKP
	uinA32s
X-Google-Smtp-Source: AGHT+IGJvynLQXA/LQk6fcdvOGBEcRDrc5pxDlC+y97uzcPtpCoY1GOnLHBKt5EXqBGMRmyPCzJQVsWFQZFmSoofD4Y=
X-Received: by 2002:a05:600c:c174:b0:456:1752:2b44 with SMTP id
 5b1f17b1804b1-4562e39126cmr18086275e9.23.1752659181173; Wed, 16 Jul 2025
 02:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com> <DBCP0OLEAHAW.JC4AQHMVQW81@kernel.org>
In-Reply-To: <DBCP0OLEAHAW.JC4AQHMVQW81@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Jul 2025 11:46:08 +0200
X-Gm-Features: Ac12FXzX7ouyqpx1LVbRHdVZq8jMUt7yI_ccMl1Rky0bxaMou6U-Kfx8iWXzP3g
Message-ID: <CAH5fLgim-L2nDwrV689-0uizgpLy2pZL1BT3vyBbW7syejn1NA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: take the allocator into account for FOREIGN_ALIGN
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 4:19=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > index bffe72f44cb33a265018e67d92d9f0abe82f8e22..fd3f1e0b9c3b3437fb50d8f=
1b28c92bc7cefd565 100644
> > --- a/rust/kernel/alloc/kbox.rs
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -400,12 +400,19 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flag=
s) -> Result<Self, E>
> >  }
> >
> >  // SAFETY: The pointer returned by `into_foreign` comes from a well al=
igned
> > -// pointer to `T`.
> > +// pointer to `T` allocated by `A`.
> >  unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
> >  where
> >      A: Allocator,
> >  {
> > -    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> > +    const FOREIGN_ALIGN: usize =3D {
> > +        let mut align =3D core::mem::align_of::<T>();
> > +        if align < A::MIN_ALIGN {
> > +            align =3D A::MIN_ALIGN;
> > +        }
> > +        align
> > +    };
>
> Pretty unfortunate that core::cmp::max() can't be used from const context=
. :(
>
> What do you think about
>
>         const FOREIGN_ALIGN: usize =3D
>             if core::mem::align_of::<T>() < A::MIN_ALIGN {
>                 A::MIN_ALIGN
>             } else {
>                 core::mem::align_of::<T>()
>             };
>
> instead? I think that reads a bit better.

I don't mind doing that instead.

Alice

