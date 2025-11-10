Return-Path: <linux-kernel+bounces-893527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6AC47B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5554254DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1131A57A;
	Mon, 10 Nov 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b68PVF8D"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFC31A54B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789185; cv=none; b=k0OmMTL6I0kE0WAZMxv5BkoKe1qza2pEf2wlcYDqvyD1GIAAEpLIu1mlXVu3k6is0BbJ+1FnQW1hi1O0I5V4BkYoc1Yuwig8z8L6hx+zgrTJVrKHGmuBELLX/tI0KWo3OTFH4y4xuPRii5WluYEMk0TuBq1pEn0fDEOB7Wnegcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789185; c=relaxed/simple;
	bh=y8+oW4BpVSbnPDBWDAyNy/quFhwrkHTE4fZvjIexV5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACAL7M/kvyEq7mLXMJlTZDHxcQYnQyQSSY2iTITbixj0SBxEQIS41H/0A9P/u++79p6u+U96SI7/OUTXy8YgHticUzlOBgpwFA765aWb3AaHCEJCGV80xXb1ufIyzz1apnhFPBnAZhl9tMzVeYHS0J3UDa/1YdcfiQn0m8g6e/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b68PVF8D; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f9beb27b9so2730468d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762789183; x=1763393983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FASU4dx6EURy+M2e80Z0Nb9yY0ZSNLb5gz2QX4rhDlA=;
        b=b68PVF8DZMYMREQ7S0VUW7LKwDZQGfMvQt+ubsxDGeBhSKmWLcjGfulXxPyVzl44iO
         nGdmm09XG1lW17hIseQ8CDRQwQocEX8+srV8C0sBAQ+Ev+n6NkGRXjqO8zIBY62xHlho
         yAKdnKg0RNoOiAiTgVR3jb0071E1x3LPf/7QVbh92UIvywDxIN7EztHuluCXWkqM9ESa
         mamO1IJ1NWPDg7l1qRrpBjhw+1UwDRux1F1kc+n/f6wSVIhbNQSh7x8bj+N5h1B3IIUa
         pBNk+AWv4IXa08zz855t7aGihpLme+YYYRKe05LkFObtVXk40Z27GUL3LWvDzjpQ0yC4
         KIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789183; x=1763393983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FASU4dx6EURy+M2e80Z0Nb9yY0ZSNLb5gz2QX4rhDlA=;
        b=SkwmYSe9S7wXFW9tH1mPbEaLaVh5UsuvYWF26yumg8AZ029uDtSvW92Ig5xnalSbKN
         wIp4/gmibzDjaFXEEclNa+KOyD6Am73b3vkmdbojS1/FS1ZssUQZNdR/jfK1Pd1KG4BU
         3Zi914CjWctI7+Z9kPGhKCKhuIcP1wu38EwyNsV2VMBHoXKrGlbI4oz2ClPngYcG3cbg
         nGmvk+nx2BVJt2dGQnUbllYYmt/dGuq7jCctzPvpc1YelVBSyrTSA8howx7nE4W+ITIc
         ppaRq4sY0B5d8xERIBs/x0J04bVu0rksZ/Juzo08KF+xAlr1Z+7XE+u9doZ8edZ3Fdw/
         QG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvgLhe9MF8UmjYsXQEV7rktiWr+zevc4jMOX1+GWsy1FodCepI2l5I6JDiYPQs1nswG0ulOfKaSrOStNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxIj9kLSx0O3NwyJbTZenqX1A0H0Ff9cz8Pq4VCmYSUVLGrMR
	eu1Nh+sXqkb5MvoLG4uFyiHCxVeYNP9GRwp1D0sx0VQ54Esmwpxf59In
X-Gm-Gg: ASbGnct58ZNcDLxnypUvkicXq5/Bv6du5rUKe2+X/GBRGGfXihkv7EnKcpHlz/n5Apk
	Q2a9FpEDcajgKDxyqdBS6SobVSmF5XA4Bp/7t61dHRMhWHlttjbWjAWv0alwXFjAz7OdJD8tZxS
	cbvW4hMTY/t6Tpf8ud5xMmFnF3OySnN/OrpBuyHh0kbsMR0wJG3UJJk2oDI+pElNDJ0AuOOb5Tk
	UyIXKpd1JNMP8PbP4maEbRNmqgG56yKnFL5Cwgzn/JBQmp8wlqPRFbKvf8PxkwRIMNh4/SRj8y6
	8PxJpah6mdSqk5kIqtIL0rvpWUHyG9Pl+nyu2oPVOZFgHuSzLWrcH4NvzUmXop4DlhtyRnWHoBc
	+1M0h5ocw18obFRTP3bJOj2Pc2GsLooZFlkbIymgHG8QzlJIAYVYn+JGbYnYFu66JssbZrtEgm8
	PyEd+sbRvSokamhWRXeGhslcuzOD0b7LSh
X-Google-Smtp-Source: AGHT+IGCUox57ngzJKqlz8EasfckHVK3H0DWRuy+AMjhHC6RYsh5rw1IdG+SJKTmex3hRuvNLSgzLw==
X-Received: by 2002:a05:690e:251b:10b0:63f:b4a1:5408 with SMTP id 956f58d0204a3-640d45cef1bmr6789933d50.42.1762789182727;
        Mon, 10 Nov 2025 07:39:42 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640d31fc898sm2797916d50.2.2025.11.10.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:39:42 -0800 (PST)
Date: Mon, 10 Nov 2025 10:39:41 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN
 constants
Message-ID: <aRIHPX4d_CF-wfhY@yury>
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
 <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com>
 <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
 <aRH0oRU5JXKpAKpB@google.com>
 <aRH-ScufjvGYPx5W@yury>
 <aRIAp3LHs0NsEKvL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRIAp3LHs0NsEKvL@google.com>

On Mon, Nov 10, 2025 at 03:11:35PM +0000, Alice Ryhl wrote:
> On Mon, Nov 10, 2025 at 10:01:29AM -0500, Yury Norov wrote:
> > On Mon, Nov 10, 2025 at 02:20:17PM +0000, Alice Ryhl wrote:
> > > On Mon, Nov 10, 2025 at 08:59:36AM -0500, Tamir Duberstein wrote:
> > > > On Mon, Nov 10, 2025 at 8:06 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > > > >
> > > > > To avoid hard-coding these values in drivers, define constants for them
> > > > > that drivers can reference.
> > > > >
> > > > > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > > > > Reviewed-by: Burak Emir <bqe@google.com>
> > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > > ---
> > > > >  rust/kernel/bitmap.rs | 16 +++++++++++-----
> > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > > > index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b9272415fcc000e3e3b52c74d7c1 100644
> > > > > --- a/rust/kernel/bitmap.rs
> > > > > +++ b/rust/kernel/bitmap.rs
> > > > > @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
> > > > >  ///
> > > > >  /// # Invariants
> > > > >  ///
> > > > > -/// * `nbits` is `<= i32::MAX` and never changes.
> > > > > +/// * `nbits` is `<= MAX_LEN`.
> > > > >  /// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
> > > > 
> > > > Should this and other references to bindings::BITS_PER_LONG be
> > > > `NO_ALLOC_MAX_LEN` instead?
> > > 
> > > Ah yeah it probably makes sense to update this in a bunch of places.
> > 
> > Yes, please. 
> > 
> > NO_ALLOC sounds a bit weird in exported API. Maybe NBITS_INPLACE
> > or similar?
> 
> Ah, good point. We started using the "inplace" wording in other places,
> so lets also do so here.
> 
> > Also, at this point we're really close to:
> > 
> >    pub const NBITS_INPLACE: usize = CONFIG_NBITS_INPLACE;
> > 
> >    union BitmapRepr {
> >        bitmap: [usize, BITS_TO_LONGS(NBITS_INPLACE)]
> >        ptr: NonNull<usize>,
> >    }
> > 
> > That would be a very useful addition for some particular scenarios,
> > I believe. Even if you don't want to make it configurable, let's
> > keep this option in mind?
> 
> Actually, one option here is to define BitmapVec like this:
> 
> pub struct BitmapVec<const INPLACE_LEN: usize = 1> {
>     repr: BitmapRepr<INPLACE_LEN>,
>     nbits: usize,
> }
> 
> union BitmapRepr<const INPLACE_LEN: usize> {
>     bitmap: [usize; INPLACE_LEN],
>     ptr: NonNull<usize>,
> }
> 
> This way, the driver can specify this by saying: BitmapVec<4> for a
> BitmapVec where the inline capacity is 4 longs.
> 
> And if Binder wanted to make that configurable, Binder could define a
> constant based on a Binder specific CONFIG_* that controls what value
> Binder passes.
> 
> Since I wrote `= 1` in the struct, you may also write BitmapVec without
> specifying any number and get the default.
> 
> It may be possible to specify the number in bits rather than longs too,
> but then we have to decide what to do if it's not divisible by
> BITS_PER_LONG.
> 
> (But in the case of Rust Binder, the value we want is one long worth of
> bits.)

It's better to define the actual number of bits. One reason is 32 vs
64 bit portability. Another one is readability - when dealing with
bit structures, it's better to think of it as a set of bits.

Those providing unaligned defaults... - you can drop a comment for
them. :)

