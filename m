Return-Path: <linux-kernel+bounces-893321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D50C470FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8DB1893D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BAE3128CF;
	Mon, 10 Nov 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGN2IhBl"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1623128A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783216; cv=none; b=nPBs/2HBNTt/37C1x7IwA/OagOheiPE6I4GS4hnMiLZFYcCb+jFYP33NS8jiD67YtpHwnF1XS62b9rxCW68a5bJSilOQ9DiBMkfRMsfQI8JP1GSurQzdkPhsxeCKEAmkXci1iE2BvOYpQhGUIVZudb5ZUHc7Yq7gWlRNbtUCqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783216; c=relaxed/simple;
	bh=eJov8sxXTi+Gh2pduYWspNCV5kJK7k2jP3ctRTuMhbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVB9wlMw7kH8hH9VMKG4+2LqcEoR8lQhZhgh9VBExjQJI+SGIxkgyRkTEb8OHGY3k2XaMZo0qxfzIlS03aJxd9J0kPUHUGuQCQ+qPcHJ4uxloyevsgIFypZ8Xv2JETEIm1/oBHafH034tRHfgSRQ5be25j+kRaxTLXk9zJGenR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGN2IhBl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378e8d10494so39119571fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762783213; x=1763388013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVYT/VhEIVxQzUBJybe7sV/3JdR14wUuU6Ka/GjxVLk=;
        b=TGN2IhBlaTEbjc22PmaK5T3Uv0PWywKRJxaFXHacGXNmZak5RuwMau/1w93gK7eMUo
         ElWkdtx382OBMgX8bXNYeujzuI3x70CGbYur5MCsVoFjHfusgIg7PglzerJsZKbNrCkU
         wq2uXmV+azNguZdkRqMjFuKJBf+eLz2hZtIIeyxt4WpOKuMgFwnm9FlardHreLrXPgvz
         dYzgprn5TTn+bcxo3/igcRQWKXWa1qYxSLTGxNNq6zM7X0YFZe1BiWTusjEEsjKp0R6E
         jgCSYgiREwoyYHrV1B+LMvCHI8xXhkIcTQYMYXwAISp/n3FltuzG7glB54wB+gl5ZZjK
         QdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783213; x=1763388013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVYT/VhEIVxQzUBJybe7sV/3JdR14wUuU6Ka/GjxVLk=;
        b=w8E0lU2NYORXNNQhi/BiElm154XAslbc3WRfpHivzgry5V9b/T9x/u0/gF2YDjy2wn
         LlWNLRq9v+4aRMlotjppRyIl5cA963Wjdc7zCkfKuK/v4dkNGPjfi+Mo526juntRjvaV
         ZB0qQvLOr5mHEN14JBMsJHlgM1cWLCHrwdOAMG3GoACqGgUi6+/bK4sL3obnWkvWjvIl
         wI45epsBmBT+7X6uVR56AKFlZKY3EhIOS/gji27WZw3Z4UEIyQMvqayMj9XAxRAKzsha
         tf2GN58M/2NyGT8kpJZpueyrVQQNKCtp3XjspQLC5fPf2JmF4XGb0rw6TO9kbiMueyCs
         gV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWEf3nIt6vB/x8jAp3LlvoJElg28swUlsY6bqrHTVSLEpD+r/BJAMuM2LqpKt4DMBxjNweKtvXvBkqOYSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+rfpwnMyH4wHd/CJ68gbm1xWM6Abvu10Cht3yF4fhB2GeRz9
	CWdJ+B4R/YcZ92JnzglsHKeiJb+rq6FK0hcTvexxLmD0Pcns4aQ3TTYWmc2wDfe+OBgScpYjOOv
	NXdtEQ5Z1KqS/5rb8eApTK/j3yJZhXzU=
X-Gm-Gg: ASbGncvY0PxHm/aBZR3TrfBOQ8e1s1dMwkajJxss9KgsyXmIgqiUY4rAKd+KlitqETb
	nX6ML2QAw8oU0w8DC/ZVuFlbzH6uVLYe7BYGtGs/jzPeemWoVq7mNNqE07FzdKHQU0oxJpHOiYn
	tYiXBtqbHwr7Ndhj+y3Pe/mqX9RDoIcWBpnFCATDWrhQMonG214L++11phETl0BW3/bo/C3KIDu
	j3i6Eg4Xp3DQ6LletOqOe4TTba/xKTNDvAAjGTKLz54VTeDDCPBSc5zeX+8rCRsYiIuxHMB/zXp
	Klizayg2UAu3t7Cp8Nc2bE0iecew51bei4QNhhW0ryxgKYpY4qrBg1dTm+O+jx314MEmGjJI09v
	HSP2tGNPOLGOIlGcZwV0xQcyYYv2zjPg=
X-Google-Smtp-Source: AGHT+IFDSVuabqggh+mSc9Cv0gLX88JlD+yln8mfSrZ8kHv17LjSYjMkiPz68si9VVh7YDPXvAkd3eIBuIqRDwIHPn0=
X-Received: by 2002:a05:651c:1108:10b0:373:a465:292c with SMTP id
 38308e7fff4ca-37a7b1f8bedmr17249661fa.21.1762783212505; Mon, 10 Nov 2025
 06:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com> <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com>
In-Reply-To: <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Nov 2025 08:59:36 -0500
X-Gm-Features: AWmQ_bnU77btn6iIIiqDuiXBr5_iNKPL8eMsWf2Y-R6Qo-sEwQVCFdTpga5wfIs
Message-ID: <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:06=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> To avoid hard-coding these values in drivers, define constants for them
> that drivers can reference.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Burak Emir <bqe@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/bitmap.rs | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b9272415fcc00=
0e3e3b52c74d7c1 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
>  ///
>  /// # Invariants
>  ///
> -/// * `nbits` is `<=3D i32::MAX` and never changes.
> +/// * `nbits` is `<=3D MAX_LEN`.
>  /// * if `nbits <=3D bindings::BITS_PER_LONG`, then `repr` is a `usize`.

Should this and other references to bindings::BITS_PER_LONG be
`NO_ALLOC_MAX_LEN` instead?

>  /// * otherwise, `repr` holds a non-null pointer to an initialized
>  ///   array of `unsigned long` that is large enough to hold `nbits` bits=
.
>  pub struct BitmapVec {
>      /// Representation of bitmap.
>      repr: BitmapRepr,
> -    /// Length of this bitmap. Must be `<=3D i32::MAX`.
> +    /// Length of this bitmap. Must be `<=3D MAX_LEN`.
>      nbits: usize,
>  }
>
> @@ -226,10 +226,16 @@ fn drop(&mut self) {
>  }
>
>  impl BitmapVec {
> +    /// The maximum possible length of a `BitmapVec`.
> +    pub const MAX_LEN: usize =3D i32::MAX as usize;
> +
> +    /// The maximum length that avoids allocating.
> +    pub const NO_ALLOC_MAX_LEN: usize =3D BITS_PER_LONG;
> +
>      /// Constructs a new [`BitmapVec`].
>      ///
>      /// Fails with [`AllocError`] when the [`BitmapVec`] could not be al=
located. This
> -    /// includes the case when `nbits` is greater than `i32::MAX`.
> +    /// includes the case when `nbits` is greater than `MAX_LEN`.
>      #[inline]
>      pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
>          if nbits <=3D BITS_PER_LONG {
> @@ -238,11 +244,11 @@ pub fn new(nbits: usize, flags: Flags) -> Result<Se=
lf, AllocError> {
>                  nbits,
>              });
>          }
> -        if nbits > i32::MAX.try_into().unwrap() {
> +        if nbits > Self::MAX_LEN {
>              return Err(AllocError);
>          }
>          let nbits_u32 =3D u32::try_from(nbits).unwrap();
> -        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <=3D i32::MAX`.
> +        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <=3D MAX_LEN`.
>          let ptr =3D unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as=
_raw()) };
>          let ptr =3D NonNull::new(ptr).ok_or(AllocError)?;
>          // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` ch=
ecked.
>
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
>

