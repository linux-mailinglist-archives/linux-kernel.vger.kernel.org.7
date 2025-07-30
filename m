Return-Path: <linux-kernel+bounces-750162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE29B157F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E82546526
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7201AAE13;
	Wed, 30 Jul 2025 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qsHaJBmx"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DD4642D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753847979; cv=none; b=dWJOJbZal3jhR43F8auV9HFGt6pd0JmniqsUmXMYQn3dCvLBeAPAQaEKCZfTt2QBaCEaBtwe5ySkfZGo6VKMwc+vcJi80wWQ13gBlKiHbNQW5LkP66lZ1hMy8Do1rPawtmcyMjwdDatkABtKiUhKCAmJGvBX1aQEpAOWc9fWOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753847979; c=relaxed/simple;
	bh=2Vx+OVkIDNsjIzjIyltCRx3+scY2So6yx83lQF+SMmM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gz7kkbZPDYMOtfADVNwjcOR4PHX8M58nNrLG6iQnlVtJxvwXEmzlduO8CM507U/ARU6u4IhSQkd2umyiAyAj0frQbBp2O2F3l4svgkKP10xoBekxp74UhMaaAtDMyRvF/4xevWF55KCZ22FY6xYatzjhUkp3v65yBZkzQS0XeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qsHaJBmx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753847965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlYZtGZVyCi4PinlFv9/1yDi5aJSz0ey8B3bkRTTyFE=;
	b=qsHaJBmxhNoF2T/EbYommxMEZ+IY8yJCw8kJsFysiXkkO3j20a7sw4TMtISwGuvcFZD7d0
	Ebw72OWXpqSTHNgnAagiVcvB/ME2a2qm/+R3vWuEdNHeV8CS8F7kY7zh0V4xJ+/CDY1Q4i
	vf1D5ZIRZApKPrjt2AD7oNItYUeK2f8=
Date: Wed, 30 Jul 2025 03:59:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Hui Zhu" <hui.zhu@linux.dev>
Message-ID: <a1c1724a7796be559c89bb32c1e8ab38a37d5c4c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v5 1/2] rust: allocator: add KUnit tests for alignment
 guarantees
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Uladzislau  Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice  Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>, "Geliang
 Tang" <geliang@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 vitaly.wool@konsulko.se
In-Reply-To: <DBL1T0JY1LUX.1606LM78FACYM@kernel.org>
References: <cover.1753423953.git.zhuhui@kylinos.cn>
 <da9b2afca02124ec14fc9ac7f2a2a85e5be96bc7.1753423953.git.zhuhui@kylinos.cn>
 <DBL1JZEZB87H.1IMYO79R3H9UM@kernel.org>
 <DBL1T0JY1LUX.1606LM78FACYM@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B47=E6=9C=8825=E6=97=A5 18:02, "Danilo Krummrich" <dakr@kernel=
.org mailto:dakr@kernel.org?to=3D%22Danilo%20Krummrich%22%20%3Cdakr%40ker=
nel.org%3E > =E5=86=99=E5=88=B0:


>=20
>=20(Cc: Andrew)
>=20
>=20On Fri Jul 25, 2025 at 11:50 AM CEST, Danilo Krummrich wrote:
>=20
>=20>=20
>=20> On Fri Jul 25, 2025 at 9:02 AM CEST, Hui Zhu wrote:
> >=20
>=20> >=20
>=20> > From: Hui Zhu <zhuhui@kylinos.cn>
> > >=20
>=20> >  Add comprehensive tests to verify correct alignment handling in =
Rust
> > >  allocator wrappers. The tests validate:
> > >=20
>=20> >  That kmalloc respects both standard (128-byte) and page-size
> > >  (8192-byte) alignments when allocating structs with explicit align=
ment
> > >  attributes.
> > >=20
>=20> >  That vmalloc correctly handles standard alignments but intention=
ally
> > >  rejects allocations requiring alignments larger than its capabilit=
ies.
> > >=20
>=20> >  That kvmalloc mirrors vmalloc's constraints, accepting standard
> > >  alignments but rejecting excessive alignment requirements.
> > >=20
>=20> >  The test infrastructure uses specialized aligned structs (Blob a=
nd
> > >  LargeAlignBlob) and a test harness (TestAlign) to validate pointer
> > >  alignment through different allocation paths. This ensures our Rus=
t
> > >  allocators correctly propagate kernel allocation constraints.
> > >=20
>=20> >  Co-developed-by: Geliang Tang <geliang@kernel.org>
> > >  Signed-off-by: Geliang Tang <geliang@kernel.org>
> > >  Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> > >=20
>=20>  Thanks, this looks good. I think it would be good to rebase onto [=
1], since it
> >  will likely land in the same cycle. Additionally, two nits below.
> >=20
>=20Please also Cc: Andrew for subsequent submissions, since this will, d=
ue to the
> interaction with [1] likely go through his tree.
>=20
>=20>=20
>=20> As a follow-up we could also test alignment in the context of
> >  Allocator::realloc(), i.e. when growing and shrinking buffers or req=
uesting a
> >  different NUMA node.
> >=20
>=20>  [1] https://lore.kernel.org/lkml/20250715135645.2230065-1-vitaly.w=
ool@konsulko.se/
> >=20
>=20> >=20
>=20> > ---
> > >  rust/kernel/alloc/allocator.rs | 58 ++++++++++++++++++++++++++++++=
++++
> > >  1 file changed, 58 insertions(+)
> > >=20
>=20> >  diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/=
allocator.rs
> > >  index aa2dfa9dca4c..bcc916240f11 100644
> > >  --- a/rust/kernel/alloc/allocator.rs
> > >  +++ b/rust/kernel/alloc/allocator.rs
> > >  @@ -187,3 +187,61 @@ unsafe fn realloc(
> > >  unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flag=
s) }
> > >  }
> > >  }
> > >  +
> > >  +#[macros::kunit_tests(rust_allocator_kunit)]
> > >  +mod tests {
> > >  + use super::*;
> > >  + use core::mem::MaybeUninit;
> > >  + use kernel::prelude::*;
> > >  +
> > >=20
>=20>  --8<--
> >=20
>=20> >=20
>=20> > + const TEST_SIZE: usize =3D 1024;
> > >  + const TEST_LARGE_ALIGN_SIZE: usize =3D kernel::page::PAGE_SIZE *=
 4;
> > >  +
> > >  + // These two structs are used to test allocating aligned memory.
> > >  + // they don't need to be accessed, so they're marked as dead_cod=
e.
> > >  + #[allow(dead_code)]
> > >=20
>=20>  This should be #[expect(dead_code)].
> >=20
>=20> >=20
>=20> > + #[repr(align(128))]
> > >  + struct Blob([u8; TEST_SIZE]);
> > >  + #[allow(dead_code)]
> > >  + #[repr(align(8192))]
> > >  + struct LargeAlignBlob([u8; TEST_LARGE_ALIGN_SIZE]);
> > >  +
> > >  + struct TestAlign<T, A: Allocator>(Box<MaybeUninit<T>, A>);
> > >  + impl<T, A: Allocator> TestAlign<T, A> {
> > >  + fn new() -> Result<Self> {
> > >  + Ok(Self(Box::<_, A>::new_uninit(GFP_KERNEL)?))
> > >  + }
> > >  +
> > >  + fn alignment_valid(&self, align: usize) -> bool {
> > >  + assert!(align.is_power_of_two());
> > >  +
> > >  + let addr =3D self.0.as_ptr() as usize;
> > >  + if addr & (align - 1) !=3D 0 {
> > >  + false
> > >  + } else {
> > >  + true
> > >  + }
> > >=20
>=20>  This can just be
> >=20
>=20>  addr & (align - 1) =3D=3D 0
> >=20
>=20>  instead of the conditional clause.
> >=20
>=20> >=20
>=20> > + }
> > >  + }
> > >=20
>=20>  We could move all the above into test_alignment() given that it's =
likely only
> >  needed from there.
> >=20
>=20> >=20

Hi=20Danilo,

Thanks!

I sent v6 version that rebased on [1].

Best,
Hui

[1] https://lore.kernel.org/lkml/20250715135645.2230065-1-vitaly.wool@kon=
sulko.se/

> > > +
> > >  + #[test]
> > >  + fn test_alignment() -> Result<()> {
> > >  + let ta =3D TestAlign::<Blob, Kmalloc>::new()?;
> > >  + assert!(ta.alignment_valid(128));
> > >  +
> > >  + let ta =3D TestAlign::<LargeAlignBlob, Kmalloc>::new()?;
> > >  + assert!(ta.alignment_valid(8192));
> > >  +
> > >  + let ta =3D TestAlign::<Blob, Vmalloc>::new()?;
> > >  + assert!(ta.alignment_valid(128));
> > >  +
> > >  + assert!(TestAlign::<LargeAlignBlob, Vmalloc>::new().is_err());
> > >  +
> > >  + let ta =3D TestAlign::<Blob, KVmalloc>::new()?;
> > >  + assert!(ta.alignment_valid(128));
> > >  +
> > >  + assert!(TestAlign::<LargeAlignBlob, KVmalloc>::new().is_err());
> > >  +
> > >  + Ok(())
> > >  + }
> > >  +}
> > >  --=20
>=20> >  2.43.0
> > >
> >
>

