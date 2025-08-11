Return-Path: <linux-kernel+bounces-763676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4CB2188B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E6019044D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607BD2253F9;
	Mon, 11 Aug 2025 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bndVqZO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722F1F948;
	Mon, 11 Aug 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952313; cv=none; b=qsNalOWeofWXWkzl6EF1gFv5JLMSK1seFygmjlxx/tCi5fQzrPb1NPL7iqW2/syejCMCBlV8HYKpsSUR/4DafM3zycDZkiPhKvj5FSLGZ6nW2nMFRVoHNfa39psvQtjp/RjtZoDNTcBBP4+bHMsSbwhssZKQDZ9chFxqRdPqfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952313; c=relaxed/simple;
	bh=i4h8G1OYpYeLJk6avTosK176BkneaD6DUhNIdsA8UUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i8fKW0E6ZIS/eqh5ePWwbHJkPisnxrNO2577pksX/ZnOc/3c+iOBH6ytUou/Sl/+mGFzcKmuG8xoOsx0c380lzQKDZGtzbIs7z7MPcKFOld3MxwvNGOrK7ScWlwnbodhIBBq9dHO7kVivKUZWLhVVBNmoMkBSUtNF1ARy0T5UUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bndVqZO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A64BC4CEED;
	Mon, 11 Aug 2025 22:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754952313;
	bh=i4h8G1OYpYeLJk6avTosK176BkneaD6DUhNIdsA8UUM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bndVqZO70lO664Lt0MZI6NYsKGzTI6/JLUM7zB8FY4MMoDFDC4obS6j3p4OkJXIti
	 CKbMQZ7J0nzqtZfCzRS5cHrkTXA+KGhO4OMAu0J0AY3MK+azLGTFl+rkHGgel6yDqi
	 D8AlREm0/OEMvFSCi5aMLfVIIu58p+4x3nsn6K//5MQMwRdL6qVf6KWB9bKqHb77Ol
	 /PVePyHfxnpM7rRmhgFvtGoJUqAVxDsngTcUJaDtcNcO4Xsm03rTs4iGk8InxP0QI3
	 ZXGEgc33QFpTVz489Bw4ujkzDznIFc5/Loj1IjHoguoLeBxvb0KyUd8PXxSn/lo+kO
	 sq/vNDDe5RDMA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 00:45:08 +0200
Message-Id: <DBZYO8O9YTO3.10MKWPYN8YEOB@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: devres: fix leaking call to devm_add_action()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>
X-Mailer: aerc 0.20.1
References: <20250811214619.29166-1-dakr@kernel.org>
In-Reply-To: <20250811214619.29166-1-dakr@kernel.org>

On Mon Aug 11, 2025 at 11:44 PM CEST, Danilo Krummrich wrote:
> When the data argument of Devres::new() is Err(), we leak the preceding
> call to devm_add_action().
>
> In order to fix this, call devm_add_action() in a unit type initializer i=
n
> try_pin_init!() after the initializers of all other fields.
>
> Cc: stable@vger.kernel.org
> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index da18091143a6..bfccf4177644 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -119,6 +119,7 @@ pub struct Devres<T: Send> {
>      // impls can be removed.
>      #[pin]
>      inner: Opaque<Inner<T>>,
> +    _add_action: (),
>  }
> =20
>  impl<T: Send> Devres<T> {
> @@ -140,7 +141,15 @@ pub fn new<'a, E>(
>              dev: dev.into(),
>              callback,
>              // INVARIANT: `inner` is properly initialized.
> -            inner <- {
> +            inner <- Opaque::pin_init(try_pin_init!(Inner {
> +                    devm <- Completion::new(),
> +                    revoke <- Completion::new(),
> +                    data <- Revocable::new(data),
> +            })),
> +            // TODO: Replace with "initializer code blocks" [1] once ava=
ilable.
> +            //
> +            // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
> +            _add_action: {
>                  // SAFETY: `this` is a valid pointer to uninitialized me=
mory.
>                  let inner =3D unsafe { &raw mut (*this.as_ptr()).inner }=
;
> =20
> @@ -153,12 +162,6 @@ pub fn new<'a, E>(
>                  to_result(unsafe {
>                      bindings::devm_add_action(dev.as_raw(), Some(callbac=
k), inner.cast())
>                  })?;

I have some bad news, I think this is also wrong: if the
`devm_add_action` fails, we never drop the contents of `inner`, since
the destructor of `Opaque` does nothing and we never finished
construction of `Devres`, so its `Drop` will never be called.

One solution would be to use `pin_chain` on the initializer for `Inner`
(not opaque). Another one would be to not use opaque, `UnsafePinned`
actually looks like the better fit for this use-case.

This also made me re-think `Opaque::pin_init`. It seems wrong and
probably shouldn't exist, as `Opaque` violates the drop guarantee
required by pinned data. So it cannot structurally pin the data inside.

---
Cheers,
Benno

> -
> -                Opaque::pin_init(try_pin_init!(Inner {
> -                    devm <- Completion::new(),
> -                    revoke <- Completion::new(),
> -                    data <- Revocable::new(data),
> -                }))
>              },
>          })
>      }
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585


