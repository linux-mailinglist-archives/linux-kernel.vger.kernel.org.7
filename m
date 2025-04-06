Return-Path: <linux-kernel+bounces-590252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7ECA7D0A8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 23:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1279D3AC558
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA64205E34;
	Sun,  6 Apr 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FuNaB/S1"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371512CD8B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Apr 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743974415; cv=none; b=Vi8Jr84cH/pPVLmUypFbXJBtCHD6d3rReJIoriFm9Aq3t5UnwMmAjCza+LhMRLNAr6AQ4FIPMIcdszKbdf+m9ES+15YrCWBg3aMZ85bMOuv2aa97awUBqvSTFuToofGOssUVpUH3yh2Dqczp23fX1gk2WF+ToRE/XTQQLPYe2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743974415; c=relaxed/simple;
	bh=PyFrLn1ZRmBZdr8DfkqFfNRBCKXeRx1HB1EyOUtlsMU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3tQ/7Y5akz8Yl7mjD4piBxUt3gP9vbpsQDzWdexbLcaGGoYGLAuCnlPusIWrdHswPEAljQMSaZNTJXdJ6Kzz7szh04OdsQhPjxXe1JLu7h9NSajkYRL7Kiluj+lvULCPJ6PfZZWVSfBGBIccruKoYRbFTejcdIVdXDuvoJRHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FuNaB/S1; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743974411; x=1744233611;
	bh=VjtiCRKfB7f+HKgO+++z1B2Y9LXniRlvLa5qqbU96Eo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FuNaB/S151RHep4ocV/gJrMOptXBHFA6Ivx6pNn9GmNnqDXyyT3POkawXPP05NugN
	 pyt20vzGF8sax7l6R4OQjupWMxsPjjHQ0om3JfRZIzUG5b+T9vO1ifiE4QIMdDFtzN
	 9kJ6Rsd5uMTk55bGTFF8z9L5+Iu9uiXtkGsCUQmoGKOSAJaAy7VcFRIHQTrBUVCPCZ
	 wr7zT+r+4y+Iy0gTPQ7SwGPBcNy+snEkyJTExAe8rZCh++tR8ksZ6qWfRHV0MSYrNp
	 q3CFh8Z4ZRjDqm6eBiILlNdhfhyEh26as5EafEsqRth9DCCXMkvsqscFMDDciYjoHW
	 JOVfPmEQoKdmw==
Date: Sun, 06 Apr 2025 21:20:04 +0000
To: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust/revocable: add try_access_with() convenience method
Message-ID: <D8ZVBUTCJXYZ.1X3I8HOSTXIA7@proton.me>
In-Reply-To: <20250406-try_with-v3-1-c0947842e768@nvidia.com>
References: <20250406-try_with-v3-0-c0947842e768@nvidia.com> <20250406-try_with-v3-1-c0947842e768@nvidia.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a7d4bffa04a67fd0a076c3a270c46353ee889dd1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 6, 2025 at 3:58 PM CEST, Alexandre Courbot wrote:
> Revocable::try_access() returns a guard through which the wrapped object
> can be accessed. Code that can sleep is not allowed while the guard is
> held; thus, it is common for the caller to explicitly drop it before
> running sleepable code, e.g:
>
>     let b =3D bar.try_access()?;
>     let reg =3D b.readl(...);
>
>     // Don't forget this or things could go wrong!
>     drop(b);
>
>     something_that_might_sleep();
>
>     let b =3D bar.try_access()?;
>     let reg2 =3D b.readl(...);
>
> This is arguably error-prone. try_access_with() provides an arguably
> safer alternative, by taking a closure that is run while the guard is
> held, and by dropping the guard automatically after the closure
> completes. This way, code can be organized more clearly around the
> critical sections and the risk of forgetting to release the guard when
> needed is considerably reduced:
>
>     let reg =3D bar.try_access_with(|b| b.readl(...))?;
>
>     something_that_might_sleep();
>
>     let reg2 =3D bar.try_access_with(|b| b.readl(...))?;
>
> The closure can return nothing, or any value including a Result which is
> then wrapped inside the Option returned by try_access_with. Error
> management is driver-specific, so users are encouraged to create their
> own macros that map and flatten the returned values to something
> appropriate for the code they are working on.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/revocable.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> index 1e5a9d25c21b279b01f90b02997492aa4880d84f..b91e40e8160be0cc0ff8e0699=
e48e063c9dbce22 100644
> --- a/rust/kernel/revocable.rs
> +++ b/rust/kernel/revocable.rs
> @@ -123,6 +123,22 @@ pub fn try_access_with_guard<'a>(&'a self, _guard: &=
'a rcu::Guard) -> Option<&'a
>          }
>      }
> =20
> +    /// Tries to access the wrapped object and run a closure on it while=
 the guard is held.
> +    ///
> +    /// This is a convenience method to run short non-sleepable code blo=
cks while ensuring the
> +    /// guard is dropped afterwards. [`Self::try_access`] carries the ri=
sk that the caller will
> +    /// forget to explicitly drop that returned guard before calling sle=
epable code; this method
> +    /// adds an extra safety to make sure it doesn't happen.
> +    ///
> +    /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible, or the
> +    /// result of the closure wrapped in `Some`. If the closure returns =
a [`Result`] then the
> +    /// return type becomes `Option<Result<>>`, which can be inconvenien=
t. Users are encouraged to
> +    /// define their own macro that turns the `Option` into a proper err=
or code and flattens the
> +    /// inner result into it if it makes sense within their subsystem.

I personally wouldn't have mentioned this in the docs, since to me such
a helper would be obvious, but I don't mind it either.

---
Cheers,
Benno

> +    pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option=
<R> {
> +        self.try_access().map(|t| f(&*t))
> +    }
> +
>      /// # Safety
>      ///
>      /// Callers must ensure that there are no more concurrent users of t=
he revocable object.



