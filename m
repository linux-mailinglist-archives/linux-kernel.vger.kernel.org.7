Return-Path: <linux-kernel+bounces-744624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B9B10F49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692A81C22A87
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21A22EA756;
	Thu, 24 Jul 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijTHgvxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D32EA46F;
	Thu, 24 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372785; cv=none; b=FLjb6JctT50wE5/ghbRArwnaQmejQxDH7RwnYujNfDDdb9Ds6f6XRGL0NlJSyn9iB5VDUuo0hvOgUk1vvEke7lzAEw6WGLdHtZ6QIgx4s1roSqSygNAP2R3P1/Bn8jNGcPLTnzbCD707dRbN33zj5OVGSnz4bu/MaFBLi/y0xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372785; c=relaxed/simple;
	bh=vPgkIaLtjO1doCUcrl0hhXAj1VPgpSa7jaQfRG4kgro=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ofMiEHnM0w2bTFQpqy+5bwlRz8yuqBPbkowbngjBKULEG3DrLqzW+RqIP5AGVLQvjOvIuQShtwFnz773ki8Ghx7gdvhyuWkpI7USTzgoayLiGp/ILvQtZ4XjgVupoBebhCHwum21FD2+B+s6r0MD7txmBnOWDBR2JsadAs/Iqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijTHgvxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35589C4CEED;
	Thu, 24 Jul 2025 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372784;
	bh=vPgkIaLtjO1doCUcrl0hhXAj1VPgpSa7jaQfRG4kgro=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ijTHgvxxBLYxWJrky7SjcjcSkfm674OWc9WFlt2Ils/p2hq+T733wF93tMVvo0NbB
	 K2WBua7zsgMNBKY38prUVdzSGEgLVbYZiLWYlQfot71oPRnUPqVmQSG8EcYBdHAkNo
	 mXSKS3W0qadGqSH3Wpyk1JEC2an3o+MpULAxu1MUfdV8GYn+hR1AdEnUPZzZSM57Yn
	 JNNmKYhrNnxQMDXjU2iwD8SvldhEuehkJZHru2Xy2BJarsrE1Gp7fkkp0KP2GgsNMg
	 V/O5y8LMsmMoG0U1mA0sutg5qm1C/52/B8bfIS2cEOyC3kX1E8XvGhNDXZBEuftYlL
	 2CCPWRSMwhF7A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 17:59:39 +0200
Message-Id: <DBKERZ03P2WS.3HQ0NZC9OO5AZ@kernel.org>
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>
To: "Hui Zhu" <hui.zhu@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/2] rust: allocator: add unit tests of kmalloc,
 vmalloc and kvmalloc
References: <cover.1753348867.git.zhuhui@kylinos.cn>
 <32d7663b7d07d13564bdfb6a1ec4cde1be8b8f80.1753348867.git.zhuhui@kylinos.cn>
In-Reply-To: <32d7663b7d07d13564bdfb6a1ec4cde1be8b8f80.1753348867.git.zhuhui@kylinos.cn>

On Thu Jul 24, 2025 at 11:25 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add KUnit test cases to validate the functionality of Rust allocation
> wrappers (kmalloc, vmalloc, kvmalloc).
>
> The tests include:
> Basic allocation tests for each allocator using a 1024-byte Blob
> structure initialized with a 0xfe pattern.
> Large alignment (> PAGE_SIZE) allocation testing using an 8192-byte
> aligned LargeAlignBlob structure.
> Verification of allocation constraints:
> - kmalloc successfully handles large alignments.
> - vmalloc and kvmalloc correctly fail for unsupported large alignments.
> Content verification through byte-by-byte pattern checking.
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Thanks for the patch, additional test are always welcome! :)

> ---
>  rust/kernel/alloc/allocator.rs | 57 ++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index aa2dfa9dca4c..430d1f664fdf 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -187,3 +187,60 @@ unsafe fn realloc(
>          unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, fl=
ags) }
>      }
>  }
> +
> +#[macros::kunit_tests(rust_allocator_kunit)]
> +mod tests {
> +    use super::*;
> +    use kernel::prelude::*;
> +
> +    const TEST_SIZE: usize =3D 1024;
> +    const LARGE_ALIGN_TEST_SIZE: usize =3D kernel::page::PAGE_SIZE * 4;
> +    #[repr(align(128))]
> +    struct Blob([u8; TEST_SIZE]);
> +    // This structure is used to test the allocation of alignments large=
r
> +    // than PAGE_SIZE.
> +    // Since this is not yet supported, avoid accessing the contents of
> +    // the structure for now.
> +    #[allow(dead_code)]
> +    #[repr(align(8192))]
> +    struct LargeAlignBlob([u8; LARGE_ALIGN_TEST_SIZE]);
> +
> +    #[test]
> +    fn test_kmalloc() -> Result<(), AllocError> {
> +        let blob =3D KBox::new(Blob([0xfeu8; TEST_SIZE]), GFP_KERNEL)?;

Since those are now actual unit tests on the Allocator implementations, it =
would
be fine to use them directly. However, for the case you are testing here, i=
.e.
alignment using Box is perfectly fine.

Having that said, I wouldn't call those tests test_*malloc(), since they're=
 not
really testing all aspects of a certain allocator, but only the success to
allocate with certain alignment arguments.

Instead, I propose to write just a single test, test_alignment(), with a fe=
w
helper functions.

For instance, your Blob test structure could have a constructor that is gen=
eric
over A: Allocator.

However, given that you really only want to check alignment, you probably w=
ant a
structure like this instead.

	struct TestAlign<A: Allocator>(Box<MaybeUninit<[u8; TEST_SIZE]>, A>);

	impl<A: Allocator> TestAlign<A> {
	   fn new() -> Result<Self> {
	      Box::<_, A>::new_uninit(GFP_KERNEL)
	   }

	   fn alignment_valid(&self) -> bool {
	      ...
	   }
	}

and then test_alignment() can just do

	let test =3D TestAlign::<Kmalloc>::new()?;
	assert!(test.alignment_valid());

	...

Given that this is now a unit test I also think that actually validating th=
e
alignment of the pointer Box wraps makes sense, similar to what you had in =
v2.

> +        for b in blob.0.as_slice().iter() {
> +            assert_eq!(*b, 0xfeu8);
> +        }

I don't think that this has any valid in the context of testing alignment.

> +        let blob =3D KBox::new(LargeAlignBlob([0xfdu8; LARGE_ALIGN_TEST_=
SIZE]), GFP_KERNEL)?;

For the large alignment case, you can consider to let TestAlign take a cons=
t
generic, additional to A: Allocator, e.g.

	struct TestAlign<A: Allocator, const SIZE: usize>(Box<MaybeUninit<[u8; SIZ=
E]>, A>);

This way you can keep test_alignment() function very compact.

- Danilo

