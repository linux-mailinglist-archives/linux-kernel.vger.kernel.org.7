Return-Path: <linux-kernel+bounces-732005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A1B0607B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868FE7B6573
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FAD286D46;
	Tue, 15 Jul 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Cx702X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428524DD0C;
	Tue, 15 Jul 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588329; cv=none; b=Pm9VpcnlU6mTEKtg4Lhw/+mWlfdQLZg9Qjc7tE8YnPhAm1V5I4iTHfPhOQKGVIg+cbojCtkgA5FHcuWVsOrvvsgJidICXWKMgsrijTORvYNmhYYv43CZcGTaR0D1CEwCsezxRA0Fr6OFYY7auwevtukTyFNjhiTksuSkq1mcr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588329; c=relaxed/simple;
	bh=I3uWJic5PlcugyOwNoTXQW2P5Q0NMSqDZK8jdTD0Xjk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=m0rt2C6DXzv38L8jzhL2YTg6A/pi6Se2HIJKwA1jO4+XESlL0jV9nd/jiclPuYqXR8s2IalAvo9zk9AHJykK816Ai/m1sJfDj8H1GiHvjAvHmUhZcI9wJ5YoHfkHXzw5QrHpRrj6gD6hjsnLuuORhgmSxlXgzmFjnP/fa5P1hC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Cx702X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CCFC4CEE3;
	Tue, 15 Jul 2025 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752588328;
	bh=I3uWJic5PlcugyOwNoTXQW2P5Q0NMSqDZK8jdTD0Xjk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=Z8Cx702XURCbhLzdgLEEQoJ6/u0vlVw4gNkJjrkGVcexyEOgcIx8EoUnCtJmDFoCs
	 aq6VFKRfpz3Y1pzMUFiUnmfju+Nkye2nVZzAMcJZAD2KO/QDCzwYYWl3jMWj1KsiaA
	 rY3nFRWp9Lu2hhryjvs+ck7KI7CuDW6CVyuh2N4iI2sEfTK8KyZP2INlKsyxgLDYHG
	 G4Q2zoFw08+G52KYyAyuXw/oQiB///SohWlfJC9zeKH1MSLf5Qx54g9ym4z001AJfS
	 EWzPvNcGYjZT3ryPIX8rMOvFGtvCTwIjL+JADM+k1iCj2vdl2p357bwo5EYDPuWNYS
	 R1J+yd4r3e9tw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 16:05:23 +0200
Message-Id: <DBCOPL040H7H.2MZO6ZBIR0Z2T@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: alloc: specify the minimum alignment of each
 allocator
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Tamir Duberstein"
 <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com>
In-Reply-To: <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com>

On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index a2c49e5494d334bfde67328464dafcdb31052947..c12753a5fb1c7423a40635536=
74b537a775c860e 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -137,6 +137,14 @@ pub mod flags {
>  /// - Implementers must ensure that all trait functions abide by the gua=
rantees documented in the
>  ///   `# Guarantees` sections.
>  pub unsafe trait Allocator {
> +    /// The minimum alignment satisfied by all allocations from this all=
ocator.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// Any pointer allocated by this allocator must be aligned to `MIN_=
ALIGN` even if the
> +    /// requested layout has a smaller alignment.

I'd say "is guaranteed to be aligned to" instead, "must be" reads like a
requirement.

Speaking of which, I think this also needs to be expressed as a safety
requirement of the Allocator trait itself, which the specific allocator
implementations need to justify.

> +    const MIN_ALIGN: usize;
> +
>      /// Allocate memory based on `layout` and `flags`.
>      ///
>      /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the layout
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08d77130=
b374bd1397f7384 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -17,6 +17,8 @@
>  use crate::bindings;
>  use crate::pr_warn;
> =20
> +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIGN a=
s usize;
> +
>  /// The contiguous kernel allocator.
>  ///
>  /// `Kmalloc` is typically used for physically contiguous allocations up=
 to page size, but also
> @@ -128,6 +130,8 @@ unsafe fn call(
>  // - passing a pointer to a valid memory allocation is OK,
>  // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has t=
he same.
>  unsafe impl Allocator for Kmalloc {
> +    const MIN_ALIGN: usize =3D ARCH_KMALLOC_MINALIGN;
> +
>      #[inline]
>      unsafe fn realloc(
>          ptr: Option<NonNull<u8>>,
> @@ -145,6 +149,8 @@ unsafe fn realloc(
>  // - passing a pointer to a valid memory allocation is OK,
>  // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has t=
he same.
>  unsafe impl Allocator for Vmalloc {
> +    const MIN_ALIGN: usize =3D kernel::page::PAGE_SIZE;
> +
>      #[inline]
>      unsafe fn realloc(
>          ptr: Option<NonNull<u8>>,
> @@ -169,6 +175,8 @@ unsafe fn realloc(
>  // - passing a pointer to a valid memory allocation is OK,
>  // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has t=
he same.
>  unsafe impl Allocator for KVmalloc {
> +    const MIN_ALIGN: usize =3D ARCH_KMALLOC_MINALIGN;
> +
>      #[inline]
>      unsafe fn realloc(
>          ptr: Option<NonNull<u8>>,


