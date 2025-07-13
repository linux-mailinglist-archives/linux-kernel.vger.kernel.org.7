Return-Path: <linux-kernel+bounces-729170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F37DB032BE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894101897D34
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0364428850C;
	Sun, 13 Jul 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFHcL88Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB07A48;
	Sun, 13 Jul 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752435469; cv=none; b=e8fx+vB+rfQQZkwEq9hwurY0LZuMfyk86UWySvOOQKUZGmzR3MAEPBb0ba8pjFsByh+YV9ZynzHCByqEsa/o67okctKRNbGBZz3ozzgLWPu5wCjqDZd6hQgP5Cm/hvrV6X80sgyW85e3oyaSAIOCvTRUybvNuiV2mf+TyE1EUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752435469; c=relaxed/simple;
	bh=GRwcDlfeqpyYFr4w3k3mKT4xSq51fkU/G+qiFumqLIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IJdeYLZ2pgEBnkHw8mH4wazv6CcxZguvhZR+mgRxwv9VP7GtFtU+FMGepVAKACeueQHiPrtri8Yoh4FcnZDDPZKq03iHhMUwxkPRAPy2IfGDWZ2qrUJSE/oodalRUFI/J6JH+zVLRypzWz8Bfgxm1NHdJKBxSWGU9xxvob8j5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFHcL88Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C0DC4CEE3;
	Sun, 13 Jul 2025 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752435468;
	bh=GRwcDlfeqpyYFr4w3k3mKT4xSq51fkU/G+qiFumqLIQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=MFHcL88Q6GEnfaHWQG/9iCmlJ3RH3IKtz/nWwI5FcenKUjYLXTc9vq7xeeTmLgboP
	 AJewxoqcPXcD7tu+aYO3ILfhaDqa7SPliCXZGeMlMosGyFMcG+ZYZfsidF6BB25bWV
	 SmSfVvajxGZCJ3vBI/ebU/RW/OG1fnDH/BElZweQU0xslaomHb8r7nBjEJUwy7yA9P
	 x7M/AEKlJgsM0Qz2JtLPY0mRCcXHJJo+Tj+/+10y2p4NqIgCuCnDeYKiO3A6OZBXIn
	 WekBzg3Cef0lqdVM+VMCmMO8ymbO1aKHy82woCzPQ9wDRCJv5S5FjcLmBL0jERStM5
	 LMQUu2SUYmVcA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 21:37:44 +0200
Message-Id: <DBB6IYG2VS1O.1TO1VO223ZXZ5@kernel.org>
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <m.wilczynski@samsung.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
In-Reply-To: <20250713182737.64448-2-dakr@kernel.org>

On Sun Jul 13, 2025 at 8:26 PM CEST, Danilo Krummrich wrote:
> Provide an unsafe functions for abstractions to convert a regular
> &Device to a &Device<Bound>.
>
> This is useful for registrations that provide certain guarantees for the
> scope of their callbacks, such as IRQs or certain class device
> registrations (e.g. PWM, miscdevice).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index d527ceef829e..4d9b052afe92 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -60,6 +60,25 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -=
> ARef<Self> {
>          // SAFETY: By the safety requirements ptr is valid
>          unsafe { Self::as_ref(ptr) }.into()
>      }
> +
> +    /// Convert a [`&Device`](Device) into a [`&Device<Bound>`](Device<B=
ound>).
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller is responsible to ensure that the returned [`&Device<=
Bound>`](Device<Bound>)
> +    /// only lives as long as it can be guaranteed that the [`Device`] i=
s actually bound.
> +    pub unsafe fn as_bound(&self) -> &Device<Bound> {
> +        let ptr =3D core::ptr::from_ref(self);
> +
> +        // CAST: By the safety requirements the caller is responsible to=
 guarantee that the
> +        // returned reference only lives as long as the device is actual=
ly bound.
> +        let ptr =3D ptr.cast::<Device<Bound>>();
> +
> +        // SAFETY:
> +        // - `ptr` comes from `from_ref(self)` above, hence it's guarant=
eed to be valid.
> +        // - Any valid `Device` pointer is also a valid pointer for `Dev=
ice<Bound>`.
> +        unsafe { &*ptr.cast() }
> +    }
>  }

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 4d9b052afe92..b6b81546a0da 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -72,12 +72,12 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {

         // CAST: By the safety requirements the caller is responsible to g=
uarantee that the
         // returned reference only lives as long as the device is actually=
 bound.
-        let ptr =3D ptr.cast::<Device<Bound>>();
+        let ptr =3D ptr.cast();

         // SAFETY:
         // - `ptr` comes from `from_ref(self)` above, hence it's guarantee=
d to be valid.
         // - Any valid `Device` pointer is also a valid pointer for `Devic=
e<Bound>`.
-        unsafe { &*ptr.cast() }
+        unsafe { &*ptr }
     }
 }

