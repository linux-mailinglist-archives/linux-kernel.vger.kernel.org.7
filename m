Return-Path: <linux-kernel+bounces-893465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE4C477EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A2144EF193
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC531A553;
	Mon, 10 Nov 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHYgGko0"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D454313E0D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787499; cv=none; b=pkMbG4inSh0xIUyoya9DPpJ1x2yd9kbcuAupvyCuu8hGt4lK3KfXQusT8uSyCkYghVJcv/zyi7vIda3W5pwRl68LBYm3TKPT/CCyhqlTWb9vOi27dBVJ0Gg278xFnOV3BipLNxqN5RFmznHi7gCOXykUqE4kEmr0jpxWlLnvw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787499; c=relaxed/simple;
	bh=e41KUEQkCI83Pj0eBDnULI9EieLfc+PrPGbBZCQVW34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d1A1VZJLGtDZAnZpqpCSTIQ8DbDsLSnGjBULuTlICL/Ok09rCiL2HDXV2EKszw+kR450C/gYBSve2gRjdOYeE2r1J2mFJVd+gMOrqPf3D71OkjaFP1skNdARpgTfcV5A1aBlM62VPxzhgdYHx68Ctg3OjsU6zAKFb5P4po1Yl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHYgGko0; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-640cdaf43aeso2825164a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762787496; x=1763392296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVuIBWwz8TeHXsPjnU/vf4FRd0BvXZesO2CMM5Oe16o=;
        b=AHYgGko0XqrhEA1vif2W2eAIEnrMJQ9otUv4QFV8jJ6u9ADBg74mVqSFw0vXAirAQG
         vqrbxCA7ZIwUJtdwRhwmK2nHGauxaDAJ+D5v/adfwK2iwKBBoqFC2/UnUnxZnMxyrHzr
         cLFkD5WH7TPZUWOeRoPYk6kDensha1an8XMHXL7hqLfguKAtzSxnSh1KN2LzTPnCiENc
         LxebE0Wqn1a0z/zpSQR6bk7LRR6xBMGhtiKQnn6SHebbab0K0OzxWlIUas8nIcHiOikS
         yX+LLG1N9WMWfbmju+EROFvmXENxp3fE0uLSW8aqRurrFdrTCQXM+0QU8G85MF7GInsz
         kkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787496; x=1763392296;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVuIBWwz8TeHXsPjnU/vf4FRd0BvXZesO2CMM5Oe16o=;
        b=FqQzMDm+8qZ1gY0OkZ8jWRfia5mRRcSAvfavJhuQF4+m4eWHme3jU7RVsEoWSmm3mU
         ywn6oVMX7WZMqLuRDvg1GLfXR6bm48hVCIhtVhthtAZKi0X769BKHaDSNdzBwW3jq0JY
         1k1VMgK+sB7kqu8d+iuyMCLkHhu9hOOLamMbNeY7LpftRvt3Q4jyaLtZNFbD0TmhQ936
         HihwDXS1Zqm7Ms2fFjgF6pvCwl6Slp4CTHWWl1AuZe2Izh3gGpnQSPJF4Qxph+c8AC7w
         +tkl799Ru/BEHzQBA0HLDEZpSAKzaIDxRJ9QF6IYPatlCETeoNa4xiR5RedvyN/sXeI9
         hMEw==
X-Forwarded-Encrypted: i=1; AJvYcCV0A5eI+5X25scwU+BVw0iqwjI02fgAN7OjCOylYMMufBCSbgqUQ9Eo96F/DASy9MlZRKguCtbKzhgNdqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyla+XUxT3xJL5gNcvxCLavPlvig1AJIGEG72v0G+NinlyGzQ++
	TgeSOuMucQTWfhKtVQJBGDiiPlq1vPEQH+BYsPGU142d7bFjxixTVy4Mq2UA/DSFHKl75vBk8nO
	8uFzrUF0riOYgTUIs/Q==
X-Google-Smtp-Source: AGHT+IFcz9xhXtdSWWsSNnakXTmc94w8f4qYVgDYqMrImPS2rfopKwtNGIQ99/JJqYZQESgV4WJXhLDpColfHEE=
X-Received: from edr25.prod.google.com ([2002:a05:6402:44d9:b0:641:1f23:7304])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4408:b0:63e:600b:bc86 with SMTP id 4fb4d7f45d1cf-6415dc19b19mr6937044a12.14.1762787495992;
 Mon, 10 Nov 2025 07:11:35 -0800 (PST)
Date: Mon, 10 Nov 2025 15:11:35 +0000
In-Reply-To: <aRH-ScufjvGYPx5W@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
 <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com> <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
 <aRH0oRU5JXKpAKpB@google.com> <aRH-ScufjvGYPx5W@yury>
Message-ID: <aRIAp3LHs0NsEKvL@google.com>
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:01:29AM -0500, Yury Norov wrote:
> On Mon, Nov 10, 2025 at 02:20:17PM +0000, Alice Ryhl wrote:
> > On Mon, Nov 10, 2025 at 08:59:36AM -0500, Tamir Duberstein wrote:
> > > On Mon, Nov 10, 2025 at 8:06=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > To avoid hard-coding these values in drivers, define constants for =
them
> > > > that drivers can reference.
> > > >
> > > > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > > > Reviewed-by: Burak Emir <bqe@google.com>
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > ---
> > > >  rust/kernel/bitmap.rs | 16 +++++++++++-----
> > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > > index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b927241=
5fcc000e3e3b52c74d7c1 100644
> > > > --- a/rust/kernel/bitmap.rs
> > > > +++ b/rust/kernel/bitmap.rs
> > > > @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
> > > >  ///
> > > >  /// # Invariants
> > > >  ///
> > > > -/// * `nbits` is `<=3D i32::MAX` and never changes.
> > > > +/// * `nbits` is `<=3D MAX_LEN`.
> > > >  /// * if `nbits <=3D bindings::BITS_PER_LONG`, then `repr` is a `u=
size`.
> > >=20
> > > Should this and other references to bindings::BITS_PER_LONG be
> > > `NO_ALLOC_MAX_LEN` instead?
> >=20
> > Ah yeah it probably makes sense to update this in a bunch of places.
>=20
> Yes, please.=20
>=20
> NO_ALLOC sounds a bit weird in exported API. Maybe NBITS_INPLACE
> or similar?

Ah, good point. We started using the "inplace" wording in other places,
so lets also do so here.

> Also, at this point we're really close to:
>=20
>    pub const NBITS_INPLACE: usize =3D CONFIG_NBITS_INPLACE;
>=20
>    union BitmapRepr {
>        bitmap: [usize, BITS_TO_LONGS(NBITS_INPLACE)]
>        ptr: NonNull<usize>,
>    }
>=20
> That would be a very useful addition for some particular scenarios,
> I believe. Even if you don't want to make it configurable, let's
> keep this option in mind?

Actually, one option here is to define BitmapVec like this:

pub struct BitmapVec<const INPLACE_LEN: usize =3D 1> {
    repr: BitmapRepr<INPLACE_LEN>,
    nbits: usize,
}

union BitmapRepr<const INPLACE_LEN: usize> {
    bitmap: [usize; INPLACE_LEN],
    ptr: NonNull<usize>,
}

This way, the driver can specify this by saying: BitmapVec<4> for a
BitmapVec where the inline capacity is 4 longs.

And if Binder wanted to make that configurable, Binder could define a
constant based on a Binder specific CONFIG_* that controls what value
Binder passes.

Since I wrote `=3D 1` in the struct, you may also write BitmapVec without
specifying any number and get the default.

It may be possible to specify the number in bits rather than longs too,
but then we have to decide what to do if it's not divisible by
BITS_PER_LONG.

(But in the case of Rust Binder, the value we want is one long worth of
bits.)

Alice

