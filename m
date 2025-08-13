Return-Path: <linux-kernel+bounces-766317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92EB24512
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B642C7B0A82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D22F0691;
	Wed, 13 Aug 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRKHttQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C92D0C71;
	Wed, 13 Aug 2025 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076471; cv=none; b=VC70/OreNcBCAwaOktQ/mMJF19oD+isZIfHtZrFNCZ8JeJN2JSv1uCAVaf9IOMpYv+Eonzj7EcGbtEkDtjUnEJ2cROGpkHlho8XwODL/BhEUESNIG0o5q7cz0h0B51H2WjTn5SCL/jc4Xikz45bfP1CnIIOpz7BrCzOSQCp36G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076471; c=relaxed/simple;
	bh=yfqXjIkaXYenRYERwnQVa9mqrbvMdVxPjhgytxo1X6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=W7cXU8LHisUg449UfZxRGnCPlLjgaLd6oe5g6gzd8kD9fWl4LjLxYMTrJFWZzIVsD/unELlenoapysGd+T2buWbXHOBvwF1dwkRn+XFvBWmuqxsHyc+oaI9ZNsjmItw+5/hqwJon5+2daici7EFFw8Fnen2OEEM5Rgo5MKCAs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRKHttQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA76C4CEEB;
	Wed, 13 Aug 2025 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755076471;
	bh=yfqXjIkaXYenRYERwnQVa9mqrbvMdVxPjhgytxo1X6o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=kRKHttQw38ZbAGPNs2QpX7S53I8G96CiLQMTrugzJbW8O2wdDfqrhhsiFc478xzCb
	 HOBOacVlXZadDj4lmlinm7nDoq9nHD3GQOjBm1NxLKiLO7pynjsWVRPSfBLeQ/LNiZ
	 G0CApe/Gy7yxx8ikzIJGp0gFEvuY3LrTeUeC5iHlskqLA24izYiL/X5S9A7Ix5h6jG
	 jtLBXrMZbnXponpfsvKwFtZUnGAjBdn6N3dv+5oUnZaFC6V6GERWhclJxl3XqSGL1d
	 /SMA+6+T9RA45JISScXd93cJ59A4FAjh18TEWE3VsSsVREFpxFrQkUjwL8XXsPPsvA
	 IaOWcuP65zG8A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 11:14:26 +0200
Message-Id: <DC16OLU29VX3.16T0QDJF7Q18P@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: alloc: specify the minimum alignment of
 each allocator
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Tamir Duberstein"
 <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
 <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com>
 <DC0N2SBVHIS7.2P91EJSTIT1FM@kernel.org> <aJxESG0l4-kyUHXg@google.com>
In-Reply-To: <aJxESG0l4-kyUHXg@google.com>

On Wed Aug 13, 2025 at 9:52 AM CEST, Alice Ryhl wrote:
> On Tue, Aug 12, 2025 at 07:52:35PM +0200, Danilo Krummrich wrote:
>> On Mon Aug 11, 2025 at 2:31 PM CEST, Alice Ryhl wrote:
>> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/alloca=
tor.rs
>> > index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08d77=
130b374bd1397f7384 100644
>> > --- a/rust/kernel/alloc/allocator.rs
>> > +++ b/rust/kernel/alloc/allocator.rs
>> > @@ -17,6 +17,8 @@
>> >  use crate::bindings;
>> >  use crate::pr_warn;
>> > =20
>> > +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIG=
N as usize;
>>=20
>> I think this needs the following diff:
>>=20
>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_he=
lper.h
>> index 84d60635e8a9..4ad9add117ea 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -84,6 +84,7 @@
>>=20
>>  /* `bindgen` gets confused at certain things. */
>>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIG=
N;
>> +const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLOC_M=
INALIGN;
>>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>>  const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
>>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocato=
r.rs
>> index 25fc9f9ae3b4..5003907f0240 100644
>> --- a/rust/kernel/alloc/allocator.rs
>> +++ b/rust/kernel/alloc/allocator.rs
>> @@ -17,7 +17,7 @@
>>  use crate::bindings;
>>  use crate::pr_warn;
>>=20
>> -const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIGN =
as usize;
>> +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIGN;
>>=20
>>  /// The contiguous kernel allocator.
>>  ///
>>=20
>>=20
>> No need to resend I can fix it up when applying the patch.
>
> Hmm. Maybe that depends on the configuration? The constant was generated
> for me. Either way, happy with the suggested change.

That is a bit odd, I'd like to understand this before merging.

All of the definitions in the kernel are defines that shouldn't be picked u=
p by
bindgen. Are you sure you do not have additional local changes?

