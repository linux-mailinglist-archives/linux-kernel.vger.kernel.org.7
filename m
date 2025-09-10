Return-Path: <linux-kernel+bounces-809469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28D9B50E05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8272A3B78E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1D2DF151;
	Wed, 10 Sep 2025 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tn0iQe1v"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994342C08D7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485592; cv=none; b=cqaESUPw3j5efTQK1mgDQ2A2X6nyB/93hp01CTVRBUPvER0d3XHrOrmrha2Gn56l5ViuIttViki3zs3wL/JFL7unWcQ9EAVgMqI5VTmEZ1G1uMBypyiCD9ZDc2HBs6Y/oygQatwo+6gb+MAuNyRu4z6NtnPBPyp37phxCCe96Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485592; c=relaxed/simple;
	bh=O+byhjgn9O3fhX401NYy6R/T+AFXl8YLi+Ts9OFY7yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVhkTuW+NXiyaVbd/yUCOba5hE/TU8f6bbrXaLRPkaL8G2UHZh6nQb+Irx7PFeid7ouJcz8wxvOi9mYI2Py7bypmgGXCc3IrYIb8zvoEftcAaJbmLFCMZOzAupR1QMhA6kyDMSpNHRG8CPAhYhGhwwNVmLH7GluMNMVB+Fb6/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tn0iQe1v; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dde353979so24631075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757485589; x=1758090389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaEKyJoMmj0za4RAONLaAHEr1xwODIsSeqBAMEZRNJM=;
        b=tn0iQe1vaFYDf4pfdKVtZHDkSzApz3DK/ycmPEsDUwUksI0O8Zn+nZpYn3Twvz3y+M
         7WDnSSMLOGkJ2mLVJSg9S814BondyMJ/z1YWAur5eVktQ5/RHIKlmDscwnXcMZc8ybsD
         OHMBnttQ5byy3ReSPjTDEKE3JEmuYQZ7ex3R+9Fbu+zN9XFG7N7vrEycdsDBNKsWzush
         Vm3qu3kQVAeQoFR8eokQYIggpwb2nhoVihhBb0dnW3GJ4qZPRm1mUDvPm9P00zVkcDbR
         H3KW2ltQo8b9s4Ct24hwnIIbE+nQ9SOG5acQqwTcHXjOy4HQu2d4SnrW9NQ/6dZqB9BK
         SbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485589; x=1758090389;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HaEKyJoMmj0za4RAONLaAHEr1xwODIsSeqBAMEZRNJM=;
        b=IST8SvO4+owxwwdNBNngFlFm2c346wLGPulPUfOh++USaqPAlOdyvTOQNsNREs44rB
         y2P+Ll47XCujGme3lGxF28IIAjd8D6aDVfRvuECrmvjWn6HUDzjLQVyt37rjViwEy0rV
         etKhB9xMFaOgxWrPWPWQJwJ+CiWqMCV3uFdFVj+NkvH08glBf+lkf2FcvYzSiqZ+pflA
         eVvZHGaFld+9LknaC82H+k7QGveZk2B4/KCslzcge0BBopCq1PaEHnUsN/oX6N/LcnJa
         yzueGkoUZzP96/Y8wx1tZZ1UNEjZCAqeDPX12ZlDlNXEVy11X1iJykPl4ZpXDZNi8xNA
         ToDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+9iXU3NMXAPTiWzc3RlaFQ2oRSBnfqTzsYYyTYDc4o67GW9FlSO2bXiXfw0gfjUlrj1qPxboBl8BNKOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+uT87qVwnM5nk3iZfg/hdulmkemmeek4yog4pxMoqMmL6iFn
	RehTaWbTRUGFgfytOiW2HivF2O9cYj1ZtCj9D0k2JOi+Lgn4itcPXTrH9VNJpMhU/SK6VDgPXl/
	JQqaReZSmAKaU6OiZPA==
X-Google-Smtp-Source: AGHT+IGcagabav8zZiy45Vz4TefE5UhpdZHnIpq9OhxA7rq8VMdc20fFBHdrydW+7kWkVPLfzhk+We3NdNBIug0=
X-Received: from wmbep22.prod.google.com ([2002:a05:600c:8416:b0:45b:883d:4704])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3549:b0:45d:d3a4:8416 with SMTP id 5b1f17b1804b1-45dddec3240mr123947175e9.15.1757485589024;
 Tue, 09 Sep 2025 23:26:29 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:26:27 +0000
In-Reply-To: <20250909170013.16025-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909170013.16025-1-work@onurozkan.dev> <20250909170013.16025-2-work@onurozkan.dev>
Message-ID: <aMEaE2NEU2FctgH2@google.com>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original value
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, a.hindborg@kernel.org, 
	lossin@kernel.org, bjorn3_gh@protonmail.com, gary@garyguo.net, 
	boqun.feng@gmail.com, alex.gaynor@gmail.com, ojeda@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 08:00:13PM +0300, Onur =C3=96zkan wrote:
> Current `to_result` helper takes a `c_int` and returns `Ok(())` on
> success and this has some issues like:
>=20
>     - Callers lose the original return value and often have to store
> 	it in a temporary variable before calling `to_result`.
>=20
>     - It only supports `c_int`, which makes callers to unnecessarily
> 	cast when working with other types (e.g. `u16` in phy
> 	abstractions). We even have some places that ignore to use
> 	`to_result` helper because the input doesn't fit in `c_int`
> 	(see [0]).
>=20
> [0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
>=20
> This patch changes `to_result` to be generic and also return the
> original value on success.
>=20
> So that the code that previously looked like:
>=20
>     let ret =3D unsafe { bindings::some_ffi_call() };
>     to_result(ret).map(|()| SomeType::new(ret))
>=20
> can now be written more directly as:
>=20
>     to_result(unsafe { bindings::some_ffi_call() })
> 	.map(|ret| SomeType::new(ret))
>=20
> Similarly, code such as:
>=20
>     let res: isize =3D $some_ffi_call();
>     if res < 0 {
> 	    return Err(Error::from_errno(res as i32));
>     }
>=20
> can now be used with `to_result` as:
>=20
>     to_result($some_ffi_call())?;
>=20
> This patch only fixes the callers that broke after the changes on `to_res=
ult`.
> I haven't included all the improvements made possible by the new design s=
ince
> that could conflict with other ongoing patches [1]. Once this patch is ap=
proved
> and applied, I am planning to follow up with creating a "good first issue=
" on [2]
> for those additional changes.
>=20
> [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> [2]: https://github.com/Rust-for-Linux/linux
>=20
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x=
/near/536374456
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index a41de293dcd1..6563ea71e203 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -376,12 +376,19 @@ fn from(e: core::convert::Infallible) -> Error {
>  pub type Result<T =3D (), E =3D Error> =3D core::result::Result<T, E>;
>=20
>  /// Converts an integer as returned by a C kernel function to an error i=
f it's negative, and
> -/// `Ok(())` otherwise.
> -pub fn to_result(err: crate::ffi::c_int) -> Result {
> -    if err < 0 {
> -        Err(Error::from_errno(err))
> +/// returns the original value otherwise.
> +pub fn to_result<T>(code: T) -> Result<T>
> +where
> +    T: Copy + TryInto<i32>,
> +{
> +    // Try casting into `i32`.
> +    let casted: crate::ffi::c_int =3D code.try_into().unwrap_or(0);
> +
> +    if casted < 0 {
> +        Err(Error::from_errno(casted))
>      } else {
> -        Ok(())
> +        // Return the original input value.
> +        Ok(code)
>      }
>  }

I don't think this is the best way to declare this function. The
conversions I would want are:

* i32 -> Result<u32>
* isize -> Result<usize>
* i64 -> Result<u64>

Your commit messages mentions i16, but does the error types even fit in
16 bits? Maybe. But they don't fit in i8. That is to say, I think it
should support all the types larger than i32 (the errors fit in those
types too), but for the ones that are smaller, it might not make sense
if the type is too small. That's the reverse of what you have now.

We probably need a new trait. E.g.:

trait ToResult {
    type Unsigned;
    fn to_result(self) -> Result<Self::Unsigned, Error>;
}

impl ToResult for i32 {
    type Unsigned =3D u32;
    fn to_result(self) -> Result<u32, Error> {
        ...
    }
}

impl ToResult for isize {
    type Unsigned =3D usize;
    fn to_result(self) -> Result<usize, Error> {
        ...
    }
}

pub fn to_result<T: ToResult>(code: T) -> Result<T::Unsigned> {
    T::to_result(code)
}

> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 6373fe183b27..22b72ae84c03 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinIni=
t<Self, Error> {
>                  // the destructor of this type deallocates the memory.
>                  // INVARIANT: If this returns `Ok(())`, then the `slot` =
will contain a registered
>                  // misc device.
> -                to_result(unsafe { bindings::misc_register(slot) })
> +                to_result(unsafe { bindings::misc_register(slot) }).map(=
|_| ())

This still uses the `map` pattern. Please change it too.

Alice

