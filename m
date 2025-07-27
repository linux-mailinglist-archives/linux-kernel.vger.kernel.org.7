Return-Path: <linux-kernel+bounces-746986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848CB12DF3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643B77A7680
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 06:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69B11DC997;
	Sun, 27 Jul 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IS75fva5"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF71A83FB
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753599138; cv=none; b=dp0VEV+7BI/JAAttw80K9fx/IkbWEhyMNI4DVa92MtSFf9kDcXBv6udNE8B1PA+w8YmLytEr3crQYiXFyGFTvNk86dUehvyQVKfdBXPk+vrrKXhNw3XygNJjOwEHZA3Phkap0zbYrygopiPePgYL7CsQ84xbx9eABIrZZCZ0EeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753599138; c=relaxed/simple;
	bh=9PpkV4enf5TEkS23PH/SR14tNUZPKHoOap+G+AMjY34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YStRUFCDIZYAyemfGP2qq7GXj9bqNglHhrl/oaEzF9sNWpyCMrN5jjY2TlCvhiDOqO2p/LNXZrCc58kudl0ebaIXKAfDxFf1Wx9eDj4LnVITPIBeKMOMCvKamgPx1lLoEkuutPZVhbvUx8BRrC5kjMZ/Pu5ycujXB47m4hlOWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IS75fva5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78776fb25so44909f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753599134; x=1754203934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHxzh6y8MXrb6J9PTI49jeC2fj1UoRizV4OaU4qLR0w=;
        b=IS75fva5pJ9zY1jF766/xsKpDpimm76zMHVfNEE30oqRzPmYKkfTy9PQo271fyQfr+
         WCgZaoDpdVsnMcf4TyPF9vYhaZWPcWtoXTaRAvDlSO53kvuAZ/snOjCVwYypK9gochwy
         vr1VEcT1OWBNGONyRJjYDvu2rGF7u6LBZQY8W0Ax/AlVqSwMUSEfp54WVXLxSrHn4tN5
         1sFfvk0o+nFMPyHMKeP5M4BaXMOLVOBPWMyawru1hnKNw8j0wguGQRO0ZGQ0BpOp25Iz
         2Pg65/PTXeBAeQ35KETxV3lQfb0ZOAng8y/rP8hQsJ5BnDtQLEmEXFEHiCIWQn/9cY9M
         YWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753599134; x=1754203934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHxzh6y8MXrb6J9PTI49jeC2fj1UoRizV4OaU4qLR0w=;
        b=JnBRGj2wkwRikW2LkFDa/6ecSxdB2S8n1H359L+Nu7Kvd/aQz8AdjDrd368dA7p2uL
         EDRg1h7QZ4h8oxl5I0WOI1U4Whyj3xEjhGcp5Y1BSrH6hzaVeq2azUz5GydbdhpGPQBN
         66ovAqP01zG/ET+ICRNIkwdINRbgYCY615xVWEVeTkN1o4gqJnC5vLBKJWH7Kt/g/g52
         uhfZAOSX9LNDltjWgA7IAcw8iHWZfGz6QTzuwM7KKGiDBg76rEUpkCzFbhox0JFwlRyU
         mKL3y+YwB08Y0lQyLteAZl9rpl2Vy5gUD7fEY1WSnSKZEHVQGEI8FOiDYaesJiOvguzZ
         Jung==
X-Forwarded-Encrypted: i=1; AJvYcCU1hqw9VjeiNzQk/JB26FZ5EyJBxudOKqH3SsQch8P7BHxBrOpFREOSpKQkUByCoJWRD9yqKwo/ssxVrdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3DBjVjeJI04jXxub1IjqHA0u0DAQmuXVchVdGInxq2K3Ah1z
	1HpuFKv6n3OneU/Pt2YtyXV0HmPWp2rFiRY+iENdqwekarp5G+0kxVLWyZyeSHu/1TJUypH6Co4
	md355+yuxzX2Ph/xEBl4fA7pqrQoqItZU4b6evn3J
X-Gm-Gg: ASbGncsx7uIj4IlCG0a+syGy8NFfiop6/oLXRb1uZpsJ5+ALJqvqnGLC9S0SiSWiXp5
	qgdzjzUX7hyd833g/NLIXbMZ+nXp/R6cR7o95fRG0EGRrwPnegvgyWRUBnE72SSXYDUZRnEIGi6
	uULnSXOwoavdJxqPridUgVviTrR323PDJqKbBtp5BAyexYmCfXM3e+amznQEqNC/emLZicXXUdZ
	WUIhuDL
X-Google-Smtp-Source: AGHT+IFzA3zIZL6grZHKyniaHmoKbqlVArhdIEEhaN9YkdDqsWFdOmboHL4q+RLBLQqCi398VjsEH/yX9hwu6iDbSdw=
X-Received: by 2002:a05:6000:40db:b0:3b7:79a5:3e53 with SMTP id
 ffacd0b85a97d-3b779a53ee3mr3062052f8f.45.1753599133715; Sat, 26 Jul 2025
 23:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
In-Reply-To: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 27 Jul 2025 08:52:00 +0200
X-Gm-Features: Ac12FXzxAKuUJXT8WArPLUiJwTxk1R_0MtQGsAdqJVkVvCI7zkWTYx6de61yRlY
Message-ID: <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes` trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Christian S. Lima" <christiansantoslima21@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Every type that implements `AsBytes` should be able to provide its byte
> representation. Introduce the `as_bytes` method that returns the
> implementer as a stream of bytes, and provide a default implementation
> that should be suitable for any type that satisfies `AsBytes`'s safety
> requirements.
>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> This is the sister patch of [1], providing an `as_bytes` method for
> `AsBytes`.
>
> It is going to be used in Nova, but should also be universally useful -
> if anything, it felt a bit strange that `AsBytes` did not provide this
> method so far.
>
> [1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christ=
iansantoslima21@gmail.com/
> ---
> Changes in v3:
> - Use `ptr::from_ref` instead of `as *const T`.
> - Link to v2: https://lore.kernel.org/r/20250725-as_bytes-v2-1-c6584c211a=
6c@nvidia.com
>
> Changes in v2:
> - Use `size_of_val` to provide a default implementation for both `Sized`
>   and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
> - Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a3744f=
69@nvidia.com
> ---
>  rust/kernel/transmute.rs | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2abc5801=
564cacda232218c 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>  ///
>  /// Values of this type may not contain any uninitialized bytes. This ty=
pe must not have interior
>  /// mutability.
> -pub unsafe trait AsBytes {}
> +pub unsafe trait AsBytes {
> +    /// Returns `self` as a slice of bytes.
> +    fn as_bytes(&self) -> &[u8] {
> +        let data =3D core::ptr::from_ref(self).cast::<u8>();
> +        let len =3D size_of_val(self);
> +
> +        // SAFETY: `data` is non-null and valid for `len * sizeof::<u8>(=
)` bytes.
> +        unsafe { core::slice::from_raw_parts(data, len) }
> +    }
> +}

Let's also have an as_bytes_mut() method. I would require the type to
also implement FromBytes as it lets you replace the value with another
set of bytes.

Alice

