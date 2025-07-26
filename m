Return-Path: <linux-kernel+bounces-746661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07643B129C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D0AA7504
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0121B9C3;
	Sat, 26 Jul 2025 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0H05aPm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342D41A8F;
	Sat, 26 Jul 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753519759; cv=none; b=NSz05SUS0+xcksGYnoQ2Ft61IaWIzrvN8Vns6TuLrNm0bw2s+LBdCgFnGlIn+QWtntFv5nPRmlO0HR0eNeH15A00tFMclS8x6emN8JWoquhLRR0wDm2HllLE1sV0OTulVJIseOA/PsfvYuImvOD0l71CekUPpnRBkt2jgdL6u9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753519759; c=relaxed/simple;
	bh=hKrUWNearcp4ZIDYya1VMgL+4p01kQmkj7tuzh5MZKE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ojmQObBPZMaDz2OY6kUfA1LccvoTdk2fWAtkfqmyPeIgQooV8HmwHD1uPOTWR0zabNpZKRkXlbvU/Idrntguoy3EOYjbpzbU5aK5bcz4hc9H9m74DQiHMy919FRbi7WyMnQAz4h1PqZ+OcCkcFo1vet4ui4gPwwJN75vDe5hzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0H05aPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B890FC4CEED;
	Sat, 26 Jul 2025 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753519757;
	bh=hKrUWNearcp4ZIDYya1VMgL+4p01kQmkj7tuzh5MZKE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=G0H05aPmgiV0g//LKUm9nDS3UJ1BUdM6ovhr3DV9Xlakw290JXIbr0WqtAqPFdSNu
	 ighP4H12T1UT4QmCgVk1ZS5MxYQifn1Ob7UObk7M3sUTL87ho2IzatTUrP5FQm5cqH
	 ibl00gxX4PLhq+t1c7M4mFReErnkl56F1Ic9QW6O4aWxypLFKUhhNpuG9fFB+B/gcn
	 Htjn3vy+A+7gIBGIUA7zhU6Z/50dTbRGRUwfTcl2Rzj+biwPK4oQvLOGBgmpz/n4hD
	 VOu7+V044k8oIpxMnuruiHtsMbzpLzFE0qqDUwjenpdC53odJ0E2nBU96o7K71Yq9i
	 gYEO7J8ObHfCg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Jul 2025 10:49:12 +0200
Message-Id: <DBLUVHKRGVCO.19XQMAX6S1M7W@kernel.org>
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
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
In-Reply-To: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>

On Sat Jul 26, 2025 at 4:47 AM CEST, Alexandre Courbot wrote:
> Every type that implements `AsBytes` should be able to provide its byte
> representation. Introduce the `as_bytes` method that returns the
> implementer as a stream of bytes, and provide a default implementation
> that should be suitable for any type that satisfies `AsBytes`'s safety
> requirements.
>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

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
> =20
>  macro_rules! impl_asbytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) =3D> {
>
> ---
> base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105

Normally I'd expect this to be `rust-next` or an `-rc` tag... I did find
this in one of the trees that I fetch, so no worries, but maybe in the
future use one of those? Thanks!

---
Cheers,
Benno

> change-id: 20250725-as_bytes-6cbc11f2e8c3
>
> Best regards,


