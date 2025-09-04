Return-Path: <linux-kernel+bounces-801134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871AB4403D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8596A1C8367A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34530ACEE;
	Thu,  4 Sep 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6j+bWyk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E63093DE;
	Thu,  4 Sep 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998845; cv=none; b=RLd+ZuYfBHShZhQywMueWJxEt6s+RHjaZes5R9QDA0Q3FkhhdSI3e73+lHNWTIABGydtzF7HfH0vbJBs94kuLcqEtAsaUU+3Jn0kK1quimDxmwqcdiB+VJNV7lYj45suBxk+xY7hmPn8w2VeapaM2qCxBftW2yKniPAcKyupZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998845; c=relaxed/simple;
	bh=4fVS3KGyqeV1lJidHPJr6bN+eqPLHXknjcJUCvpAUoY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kxFKwd84DLdaWei/UruNDKPY++ZiNllwatASYViHD6gAjsP02i8wCy6wv6znt9Ehr4J8RxGep0px4jqXhpUdG3l9esGaDRoVbsLepnHPPSq4iV3bxfC4+LpCO93zBA6m4/G1qOCkSpdAijrvtwRVtObvZ/FMYPl7jIE9X3VMGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6j+bWyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5E4C4CEF0;
	Thu,  4 Sep 2025 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756998844;
	bh=4fVS3KGyqeV1lJidHPJr6bN+eqPLHXknjcJUCvpAUoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6j+bWyko5gK169Obq4LmmzKSaeTeANs8R/x48tgrdKK5zKoDDrkC/DSgmkDDIKXF
	 m/fLhNqIv2udrIyScLA16vVnYjSZ/pxa5Suy+R4cetPyv006C4Z/4MrnzAzb1xcgUM
	 jPcVygqgQeSh8DMfYsnpBBEgg0PhdWA7lW4xg++It3gwrVDoV1ZCIdIYiBmSzDrRra
	 Bl7rk0obV1oelJ7ezRTRfroQ/mefmhAM3ZCZoyR0qe1IJl5AbKKoptZjRXis0jrlKW
	 MzUal3kdJmiNztBfqoIohkpg7vitrbxG/qCz43DIZszpOa/FK4Tzz+x2sl95w98Sq3
	 M5UP1ROdCNy9w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 17:13:59 +0200
Message-Id: <DCK43W485VCY.3KE72NNMDP32D@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Waiman Long"
 <longman@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rust: lock: add a Pin<&mut T> accessor
X-Mailer: aerc 0.20.1
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com> <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>
In-Reply-To: <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>

On Thu Aug 28, 2025 at 10:52 PM CEST, Daniel Almeida wrote:
> In order for callers to be able to access the inner T safely if T: !Unpin=
,
> there needs to be a way to get a Pin<&mut T>. Add this accessor and a
> corresponding example to tell users how it works.
>
> This is not useful on its own for now, because we do not support pin
> projections yet. This means that the following is not going to compile:
>
>     let mut data: MutexGuard<'_, Data> =3D mutex.lock();
>     let mut data: Pin<&mut Data> =3D data.as_mut();
>     let foo =3D &mut data.foo;
>
> A future patch can enable the behavior above by implementing support for
> pin projections. Said patch is in the works already and will possibly
> land on 6.18.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1181
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/sync/lock.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 9242790d15dbf65d66518d060a8a777aac558cfc..7191804a244da05db74294fde=
c598f1a4732682c 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -245,6 +245,31 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnO=
nce() -> U) -> U {
> =20
>          cb()
>      }
> +
> +    /// Returns a pinned mutable reference to the protected data.
> +    ///
> +    /// The guard implements [`DerefMut`] when `T: Unpin`, so for [`Unpi=
n`]
> +    /// types [`DerefMut`] should be used instead of this function.
> +    ///
> +    /// [`DerefMut`]: core::ops::DerefMut
> +    /// [`Unpin`]: core::marker::Unpin
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::sync::{Mutex, MutexGuard};
> +    /// # use core::pin::Pin;
> +    /// struct Data;
> +    ///
> +    /// fn example(mutex: &Mutex<Data>) {
> +    ///   let mut data: MutexGuard<'_, Data> =3D mutex.lock();
> +    ///   let mut data: Pin<&mut Data> =3D data.as_mut();
> +    ///  }

The formatting looks off in this one, there should be 4 spaces of
indentation here; there are also 2 spaces in front of the `}`.

Also `Data` implements `Unpin`, so you're not following your own
recommendation from above :)

---
Cheers,
Benno

> +    /// ```
> +    pub fn as_mut(&mut self) -> Pin<&mut T> {
> +        // SAFETY: `self.lock.data` is structurally pinned.
> +        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
> +    }
>  }
> =20
>  impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {


