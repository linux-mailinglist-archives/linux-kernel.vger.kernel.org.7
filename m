Return-Path: <linux-kernel+bounces-752494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3BCB17640
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBA77B809E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA324A055;
	Thu, 31 Jul 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEEFQxqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBA195B1A;
	Thu, 31 Jul 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987982; cv=none; b=DOdsm0HhkfLfGayloMk/sNruVvKwdnkuDnG54HkMuolWb4peY0Z5e4HHhlZDX7kslu0dug6MiqrvWGqcD93kYhVuUu8DTc8QVOr6Gva2UqRDd8AM+Mo+cYLmDwKmOTW3JJNSyxGk5cfR/k6/nQl6tJJGOQT6rDGt2cFxcjhZvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987982; c=relaxed/simple;
	bh=3bGvNdloMZXweX7qeoxxVDPdsQDj9y0BrPcnclvVAG8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=JiFXqudHcAO4S1q9iNzBDkjQdw3E42GSPd+z1Ccn3Vs1SEhCMHj++oR8mvft3euilTkXDlU/OT+30GKqh+iGOACPug/H6bzuWlE9BUdbSVSnYwr9pYac5EJh16mBuaBBdD1vW+tu6L1hsIUgvNmNsUWz/oI81hBD7PH2XOs8O4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEEFQxqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4264FC4CEEF;
	Thu, 31 Jul 2025 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753987981;
	bh=3bGvNdloMZXweX7qeoxxVDPdsQDj9y0BrPcnclvVAG8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=rEEFQxqKqRzdgYivXTv1QYmxttZCKOy1jGMwGuUDO26sEzKLbtNFgryw1Z1Jhdw3d
	 eWjryuvfVnbT6yYNRTmivW15o3bCAvWDsFzfkuG1YQSqZMpVSSXt0x5VGWvB3JJWcK
	 +rJ2bn8FY2rwfi+BZhPGy1fb8J4xHkPaVybd1zxTpPTMUAO1N33NYcIvD+15duhSwU
	 PJcL1f6hYv+IBbzH6CcddNf6qbvL5wNtt+KErvnK+iSyKkR72YuWvJncz40BdhVEZR
	 sMCv861a3w7n7IGyNucIQPhS0zgIbJWJIYazMFRObjTHzHQZA4gjHxbwqZVZpn2p3L
	 Ga7F3YGkizNgw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 20:52:56 +0200
Message-Id: <DBQGUGG933BD.3VRM2CTO2WL3Z@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Waiman Long"
 <longman@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: lock: add a Pin<&mut T> accessor
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com> <20250730-lock-t-when-t-is-pinned-v1-3-1b97d5f28aa2@collabora.com>
In-Reply-To: <20250730-lock-t-when-t-is-pinned-v1-3-1b97d5f28aa2@collabora.com>

On Wed Jul 30, 2025 at 7:14 PM CEST, Daniel Almeida wrote:
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
> pin projections.

I am currently working on a patch that adds pin projections to
`#[pin_data]`. It will most likely land in v6.18.

> Link: https://github.com/Rust-for-Linux/linux/issues/1181
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/sync/lock.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 087bc0391f92a73b9af18ca31461b513bb5a9bcd..27857659a7f1ba4a8b844bb18=
d009d037e0c5b03 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -243,6 +243,25 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnO=
nce() -> U) -> U {
> =20
>          cb()
>      }
> +
> +    /// Returns a pinned mutable reference to the protected data.
> +    ///

I would mention that the guard implements `DerefMut` when `T: Unpin`, so
in that case it is probably easier to use that instead of calling this
function.

> +    /// # Examples
> +    ///
> +    /// ```
> +    ///     # use kernel::sync::{Mutex, MutexGuard};
> +    ///     # use core::pin::Pin;
> +    ///     struct Data;
> +    ///
> +    ///     fn example(mutex: &Mutex<Data>) {
> +    ///         let mut data: MutexGuard<'_, Data> =3D mutex.lock();
> +    ///         let mut data: Pin<&mut Data> =3D data.as_mut();
> +    ///     }

No need to indent the code in the example.

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


