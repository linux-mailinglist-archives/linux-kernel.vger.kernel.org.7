Return-Path: <linux-kernel+bounces-746804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28AB12B63
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E828D189CF8F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF6285072;
	Sat, 26 Jul 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPqGTQ45"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134ABCA5E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753546527; cv=none; b=uQno2QdQBkw9BYtNTRxYK2+83hy/IV7RUwmgQBBTbo6qaVDah5UMfPFMDgLjJAYMswIWFJ0IJJnTMfCMcsaM5CfZCb26H4BIcTu9ypht+MEgeneEZLklSl997msAQDuloD7mKT360KZ6LFbCtQcipUOGVYp2uOEUM5SDj7WnZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753546527; c=relaxed/simple;
	bh=/jh2NetYJEcS7y9hKl9u6ZhaS1tzUUoKm/tRaaJp65g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paE0exJDw3bTOPJh122bAGIcLSlq7yONDx/jj8iSSXBi02gRHQyjZyauuljClGwTgglXUnQyunBp/87cRweK/nBxr6CGEP30/gUYdHysma23v+RO6kOCVG4OkKBDy+jEibrFoqxrMR4EyaCQNyUrTO4L79AsF0LfLXgVNBkSzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPqGTQ45; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b77a4ad84cso357286f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753546524; x=1754151324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjXI2/7oThbWzLYU7IbCDr+QFqFWddGsPEoOiITUQfo=;
        b=wPqGTQ45BzFbcz5Ts5xKX6X++SaO6E7Wqt6mKbjbPRLWC9N003UVHG5zi7fSIIzKyM
         yyv3bwV+2ST8X0cVZrbk4M7OWr0DrnpAULHKDcshfdDdGWB0W8HBGMu8Manv/lAVx0W7
         WJmqaVJhigeTmCDR8jxxu02PSch2cQnqVm8h/nqtzCWt69djHo6UX5oD9oFwbTvyf94S
         PpiPbHsWZxIsYNrepz2SdTR7k1btee3gRaHgxFyE2zZy9mIzaf9EW9K70PEi0RKp2J7n
         D6mvLRi2fWaUt0+CkBXaFT9cMIzVXw9mESS6zbZ332ueSzulGAA+gKi0ypdGwxJyEbFI
         q2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753546524; x=1754151324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjXI2/7oThbWzLYU7IbCDr+QFqFWddGsPEoOiITUQfo=;
        b=uel1qMbsK2N/Uc8jlpUYxrFXl99TvuxyKs4ww1x8l3vGDPgGAg9K7N+GTouoTUgcsi
         i2fCGRE6DNAEHJUiNLLeG34OqQN0ttkPIyIaN71BgFy7y0R6XlxV3yAQNTIeuRNJD+sc
         cQ5UeCs5OAgk/e7/cVWG6OZL4jJ54+Fh4dnfJgBini5h6iGDyUUubIisfgNwsogMgee/
         jsR6O4O7dwZOnSjYdCK536INnRML9INub1xwClHfMPA5CjEiKy86Wr74HNBitmOuOt0F
         wA5H1CH1aCtvhEwVM19fc8UdBwLxFe6QL2+FxQ6wgKJKicseiL0iZqdjbS2jMPslGABI
         RugA==
X-Forwarded-Encrypted: i=1; AJvYcCWQGSMZzfsTHpvPCx8bmT6eU3bMPGvQoSPeELuZWqZyuZtv/gyu7yr37N1Q0WunhfZFcKcmaT/EsZUpbU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwReaMfBD+TRFCV/SSOZdS+WJ89ly+KoLDEM7paWGlvmRIIcHW9
	PlgB30MQsNxPnRa3K7SQH91yJ6pXNoyVv2d76xUie/rHKf4dwvtAIg+mXYu4ADwGz+/CnYZAraa
	gYHxTqE1sV6vo8WgDkrP7RQJuoP/Fs6ayELwwG4Ud
X-Gm-Gg: ASbGncvQd/mqiOUOfnjyEQvMhPZVLrGUOvBA5mecgUHbfRgXhnQ6hAwNEVKE63406M1
	hnjTXTcE0lwDrKcybBn7wdJ3/vaKrJBvrK796df2o5NfEpdMB0ddGlVd5aeHod3O2bZi4dwZIEW
	82VuBK0M4SbRJ3ppzKXXIPhPr623QXnpYZWM30gFWnZeQlmuIPfdO8NcPkcyKt/RZ5ADZynh3AE
	1JUXxCN
X-Google-Smtp-Source: AGHT+IGq6r0MeHgvQseFz5cMv43K6MbZdaH5JloddQpsWGT5eYrYGrycXYiguGwgXRqrUoDt0sDmanBfxCMNYLu8MmY=
X-Received: by 2002:a5d:438a:0:b0:3b7:8154:aa36 with SMTP id
 ffacd0b85a97d-3b78154e3camr932195f8f.7.1753546524220; Sat, 26 Jul 2025
 09:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com> <20250726165020.46880c31.gary@garyguo.net>
In-Reply-To: <20250726165020.46880c31.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 26 Jul 2025 18:15:11 +0200
X-Gm-Features: Ac12FXzISFN9wsDXMX_LgKfYNxwErnQbej7ZyIa_oJ8UfCOGwdNe7zdwJtk0UtI
Message-ID: <CAH5fLgi-3oT8+5Krzrg5JeagJMm6-8FNVr5G-UAszuhi0qZ1xA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
To: Gary Guo <gary@garyguo.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 26 Jul 2025 13:23:23 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > To load a value, one must be careful to hold the lock while accessing
> > it. To enable this, we add a lock() method so that you can perform
> > operations on the value before the spinlock is released.
> >
> > Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/maple_tree.rs | 94 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 94 insertions(+)
> >
> > diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> > index 0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c..c7ef504a9c78065b3d5752b=
4f5337fb6277182d1 100644
> > --- a/rust/kernel/maple_tree.rs
> > +++ b/rust/kernel/maple_tree.rs
> > @@ -206,6 +206,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
> >          unsafe { T::try_from_foreign(ret) }
> >      }
> >
> > +    /// Lock the internal spinlock.
> > +    #[inline]
> > +    pub fn lock(&self) -> MapleLock<'_, T> {
> > +        // SAFETY: It's safe to lock the spinlock in a maple tree.
> > +        unsafe { bindings::spin_lock(self.ma_lock()) };
> > +
> > +        // INVARIANT: We just took the spinlock.
> > +        MapleLock(self)
> > +    }
> > +
> > +    #[inline]
> > +    fn ma_lock(&self) -> *mut bindings::spinlock_t {
> > +        // SAFETY: This pointer offset operation stays in-bounds.
> > +        let lock =3D unsafe { &raw mut (*self.tree.get()).__bindgen_an=
on_1.ma_lock };
> > +        lock.cast()
> > +    }
>
> Could this return `&SpinLock<()>` using `Lock::from_raw`?
>
> I guess it has the drawback of having `MapleLock` needing to store
> `ma_lock` pointer but the guard is usually just all on stack and
> inlined so it probably won't make a difference?
>
> This way you remove `unsafe` from `lock` and gets a free `drop`.

I ended up going this way to avoid the extra field in MapleLock, like
you mention.

Alice

