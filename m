Return-Path: <linux-kernel+bounces-748152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AAB13D26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73CA162489
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C22260C;
	Mon, 28 Jul 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU/PGOjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526A191F72;
	Mon, 28 Jul 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713010; cv=none; b=QQ6UUM+vhajjPMMCe1dq5gwDs0XRM0Ls7EdhXzsX4iJkb5pOWEcOO9M8nVtHVI0CBS912J7tFEqyrHIx2NTXBZvNSQetkaEjzHkiSBtK7YjvRfGZ3N8hu83ILA0V6XETdkaJASN79ZJRg0vfaBb7hl2Yo1QQUVFjM3OLddEwjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713010; c=relaxed/simple;
	bh=Jsp1PSdNuht/3bc6yOidFiAtl9gDuEyS8bh42nDpH8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=nRTqjWGxRrMn/0gOylTTaW3OHJRyD3EXvPKUIUrsME/B2ynViJFCTnGyvPskKDmKLuPMXCcmb4DhRNrnbU0hgYs+pJdW4ubmTLJLaXPmdxH7GizGdbdZdsq1QXVPswRLSfpdnRjaoTTtHT/uBY7ma6DPa8cwQ9xT1n0wTypRoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU/PGOjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D8C4CEE7;
	Mon, 28 Jul 2025 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753713010;
	bh=Jsp1PSdNuht/3bc6yOidFiAtl9gDuEyS8bh42nDpH8c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=XU/PGOjXt1FSAJFuuMOWArHxVq24rDzISv4E4e+yfmeUrofqrdAMI4z9tpzrG//up
	 u/o5iO/B4bNe0m3COxCUUU8O3yFFe3fOvpFwuoi/j3uPg97jKcg/CmIxctuZW5FVGk
	 Xv7kuiSHboT7o5ZeqjEmxVlzMJRfGZC7TSanGnaDADuc8B2URRWNbGLq8JxTbZa4Pe
	 RVQQ/YahkqciWeNL/9lkm0dWVekSHIVcwgElAxZh+1k3K8F/huIK91UoyXEJVQiTd+
	 OQmeKPqr5vE1c03UvXfWEAcj05lXTeDHXVoxXR525eTm4pmzTxhdZgos/d4mnohL3d
	 BQ6VpBVjyC8iA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 16:30:05 +0200
Message-Id: <DBNRDKQBN1TK.6Y8U7XN2G15H@kernel.org>
Subject: Re: [PATCH v4 1/2] rust: transmute: add `as_bytes` method for
 `AsBytes` trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
 <20250728-as_bytes-v4-1-b9156af37e33@nvidia.com>
In-Reply-To: <20250728-as_bytes-v4-1-b9156af37e33@nvidia.com>

On Mon Jul 28, 2025 at 2:47 PM CEST, Alexandre Courbot wrote:
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37b90150de86699f114a2ffb84db91..d541c9960904d8c7f755351f2=
2d06e4e8dbd546a 100644
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

Let's add a `CAST` comment above this that says:

    // CAST: `Self` implements `AsBytes` thus all bytes of `self` are initi=
alized.

> +        let len =3D size_of_val(self);
> +
> +        // SAFETY: `data` is non-null and valid for reads over `len * si=
zeof::<u8>()` bytes.

s/over/of/

---
Cheers,
Benno

> +        unsafe { core::slice::from_raw_parts(data, len) }
> +    }
> +}
> =20
>  macro_rules! impl_asbytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) =3D> {


