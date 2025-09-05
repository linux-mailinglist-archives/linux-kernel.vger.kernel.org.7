Return-Path: <linux-kernel+bounces-803697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C74B463DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292127BE186
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25602853F9;
	Fri,  5 Sep 2025 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AV432Tef"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9727FD52
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101452; cv=none; b=FiJ2TF4Lwdjd3LhAuGKlsH4TppKNMlZ0AAPEh1j44MaXfh3VjxTkknp7dGXP/neFBicHIbIHaMO+Q6lRLB8NTTogOS1X4WAjtWAnnUrLQlXnQTKUm3Qw9hKp35WI6Fc2PFuz9Hnljn/InTYGCQXvmtnB3vFHT4bwnNu6ZAMrX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101452; c=relaxed/simple;
	bh=a5PCH555xh/FnPTh8KPDazTQ18vDk+HyzhpLL4LoL+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lg/rLbZuk7PXV/xeLoIOOkn8d5Yd8tlycHNwl/zc6emPqWLrGOBWZ2LfTL/eJ5fhyRzzTq6nSJkKYlVm9Zdi4OCqcWVdpWtsgkEVTUn6Ctj/opEah0Bp1vuMHJ4lG1IvYF6CYCuIP7hSrDMpUWl1tkQ7jqqcak3ZfGnspIOxMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AV432Tef; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so9918175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757101449; x=1757706249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEI7GQWEAkQYIFHGJfGFwyujQ5t6k8CCgPdx37+tNBE=;
        b=AV432TefHusWYetGiUdezU6pTpi+Lh/Q8NpGGuU8A3tuoqqYM4OxaeP1fPitVem7rq
         HVwxJuioy2UU6C0Ibzh4MF9Qu+wS0c+/58GH0ts8pjvQbCkf9ZhmiSIGswavxAaWeDQL
         imqfohX7rDBfRaRGXSC4jJmrmHWvgNd8pT5z2AtBG0DW0gBRPn5TycA4cJ3wiuKTRafn
         5oPy3UvneXb3c6Cfge15R7PfMxXBcSOgSUU9DD7wlXZuPzKD8+FfiI1SoTI63Ihmia3y
         lw6tJbBYAoYDQf7SMCq/cWpsN/nsnAtHrBmST6Upxe+SvcO14oiJUqN4g49VtXd+8TxO
         GCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101449; x=1757706249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEI7GQWEAkQYIFHGJfGFwyujQ5t6k8CCgPdx37+tNBE=;
        b=icKgnRTNbe44G71ktSMWX165epy0h9WQVGNRDwU5wZtbhJdUVIJdqUh8sSf89B0bN/
         Pce3q7v3qtCJz6GSWCVT6+SPYl176R+014k3/6cbQzupE+uBamF17US+MH1lX/7YI00t
         hgMjFofEc4IL9q5iSHg7zpdPZdQfjf7F3/81zD9g0YZpHavPPN5G04R8eglAjdN4Z5XA
         rhOp9rn78BMCmudjNivuUPn/30kHQ0+PwdzMY2codXFx1m7/FCG49h4U5hjzgdPMZqE2
         MGtZT/SGrp2KN3Ejyi3nAEV4He8bhX9E0GFNHBMAPa1G0iQQaBhQBg55LTO1M5aQrOus
         ot+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtXTbIMMdiCDLl0agQTO151stFIUOsUmKwhUhEV3vuqt42K2nvs/DGL+38BFT4kXEFB+TOL87cJxgDGvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBY5s6EhmLQElY5za3Dx+579d9gCqgIFDjUg5zV5m2GoOOJ5YG
	NOJHjFkenXMGD4ExBW2Qwfs3Y/Lt9CDCFjtqlsS6wvJdhChWH6teGBaJyOtpELclS+19DZsWmKW
	HFzdPxTWB+PThg0hMZ7u5keZPIX0Td1576NcrWyel
X-Gm-Gg: ASbGncth1zhtirdSvysDPcmqyRQc9cWcI84pI+73Yi3v2W+b/azxPM2uqHmu0iiMs8A
	b/8Ei47Lal7GLXANmmOKYceEfQq0onr6f8g0oNyIdq30dRxTRZC5CvnjtAlJR+uP6QUlsAaEi/5
	FkPA01j6ciGX9jQzlH26djmE85JmBiEstu9kmIt8PE6XaHpkBNpewTpoh+Yagy7vxFoBh3FBgXy
	rglnU15raeilzYhVfwfiq2HoPV5JPR31SaDMRxWLwikFrCcwWUJ2lmdNg==
X-Google-Smtp-Source: AGHT+IF6MaLna2TQSOHb7d4GBuMmNaoPsk+52ZYWmtEHN5XdVUvDZRZuUA+u39+Kqb9oYicCEfPk4c1s2sjBR7v5eMI=
X-Received: by 2002:a05:600c:8b5c:b0:45b:9b9f:88cb with SMTP id
 5b1f17b1804b1-45dd5b78584mr37184055e9.16.1757101448644; Fri, 05 Sep 2025
 12:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904142552.2790602-1-vitaly.wool@konsulko.se>
 <aLqmmKZMDAAFCBsX@google.com> <F53AA863-91B7-459E-98B2-74FA44BA48AB@konsulko.se>
In-Reply-To: <F53AA863-91B7-459E-98B2-74FA44BA48AB@konsulko.se>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Sep 2025 21:43:56 +0200
X-Gm-Features: Ac12FXxVtO11zadmXe8FVEHG0-wuqmIWGxxCK3572T8RsPB_M_OFAcLD5K9AUJc
Message-ID: <CAH5fLgi2UjihwmvdMqBMe0chNpA+OGex2=kLg2NWcXsKmD7wpA@mail.gmail.com>
Subject: Re: [PATCH] rust: rbtree: add immutable cursor
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:30=E2=80=AFPM Vitaly Wool <vitaly.wool@konsulko.se=
> wrote:
>
>
>
> > On Sep 5, 2025, at 11:00 AM, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Thu, Sep 04, 2025 at 04:25:52PM +0200, Vitaly Wool wrote:
> >> Sometimes we may need to iterate over, or find an element in a read
> >> only (or read mostly) red-black tree, and in that case we don't need a
> >> mutable reference to the tree, which we'll however have to take to be
> >> able to use the current (mutable) cursor implementation.
> >>
> >> This patch adds a simple immutable cursor implementation to RBTree,
> >> which enables us to use an immutable tree reference. The existing
> >> (fully featured) cursor implementation is renamed to CursorMut,
> >> while retaining its functionality.
> >>
> >> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> >
> > Overall looks good to me!
> >
> > A few comments below:
> >
> >> -// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, s=
o it is sufficient to require them to be `Send`.
> >> -// The cursor only gives out immutable references to the keys, but si=
nce it has excusive access to those same
> >> -// keys, `Send` is sufficient. `Sync` would be okay, but it is more r=
estrictive to the user.
> >> -unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
> >> +// SAFETY: The [`CursorMut`] has exclusive access to both `K` and `V`=
, so it is sufficient to
> >> +// require them to be `Send`.
> >> +// The cursor only gives out immutable references to the keys, but si=
nce it has excusive access to
> >> +// those same keys, `Send` is sufficient. `Sync` would be okay, but i=
t is more restrictive to the
> >> +// user.
> >> +unsafe impl<'a, K: Send, V: Send> Send for CursorMut<'a, K, V> {}
> >>
> >> -// SAFETY: The [`Cursor`] gives out immutable references to K and mut=
able references to V,
> >> +// SAFETY: The [`CursorMut`] gives out immutable references to K and =
mutable references to V,
> >> // so it has the same thread safety requirements as mutable references=
.
> >> -unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
> >> +unsafe impl<'a, K: Sync, V: Sync> Sync for CursorMut<'a, K, V> {}
> >
> > We should also have Send/Sync impls for the new immutable Cursor type.
> > They need to look like this since the immutable cursor only has shared
> > access and not exclusive access.
> >
> > unsafe impl<'a, K: Sync, V: Sync> Send for Cursor<'a, K, V> {}
> > unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
> >
> >> +    /// # Safety
> >> +    ///
> >> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> >> +    /// - The caller has immutable access to `node` for the duration =
of `'b`.
> >> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> (=
&'b K, &'b V) {
> >> +        // SAFETY: the caller guarantees that `node` is a valid point=
er in an `RBTree`.
> >> +        let (k, v) =3D unsafe { Self::to_key_value_raw(node) };
> >> +        // SAFETY: the caller guarantees immutable access to `node`.
> >> +        (k, unsafe { &*v })
> >> +    }
> >> +
> >> +    /// # Safety
> >> +    ///
> >> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> >> +    /// - The caller has immutable access to the key for the duration=
 of `'b`.
> >> +    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) =
-> (&'b K, *mut V) {
> >
> > The mutable cursor has `to_key_value_raw` because it needs both a &V an=
d
> > `&mut V` version, but the immutable Cursor doesn't have that so it
> > doesn't need a raw version either.
> >
> > That said, perhaps we could share this logic between the two cursor
> > types? We can make these methods standalone instead of being part of th=
e
> > cursor so that both cursors can use the same helper methods instead of
> > duplicating them.
> >
>
> I was thinking about doing some paste macro magic, but maybe it=E2=80=99s=
 better to go the way Boqun is suggesting in another reply and introduce a =
helper function returning Option<NonNull<..>>. What would you prefer?

I would prefer a helper function.

Alice

