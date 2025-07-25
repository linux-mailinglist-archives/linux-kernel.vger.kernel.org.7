Return-Path: <linux-kernel+bounces-745524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC923B11B23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF723A4D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01392D375A;
	Fri, 25 Jul 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/hkvOSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196B23185E;
	Fri, 25 Jul 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437046; cv=none; b=S2RFZgNYyYNO5grWi0qXxHzZ1mCUQA7v3dWx9BgOAixwCKrzebtYM170zxhlbl6iTt+7tMsSb+uu7CeYRS3UGT+pwroKEl2cVflvE82vtNnMBF8Cz8ZugbsSzCxi/v9FGtsAel0g6ro6W9+XdyTPbFqPNHk9FeSs+pLh6uFaupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437046; c=relaxed/simple;
	bh=xQePQ+N/+DWWopIaG3p9/3wx8Et2IPVT55boRDl0mEw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ixIb0m52TBqxGUjEc519de5syR/Hy13QloISLeEeYNNA8CA/kPRQtbOJ0eZyRGJxiYAFg283OhDi1g4res4Bt2FJpOo39HJXCdcVOI9Y1mAvbpAH6IHFT6DjXxeUixWjjCkat6Muh2OwDrGoRyuG8sakGo5kIwso3MzxLgeGtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/hkvOSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B2AC4CEE7;
	Fri, 25 Jul 2025 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753437044;
	bh=xQePQ+N/+DWWopIaG3p9/3wx8Et2IPVT55boRDl0mEw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=l/hkvOSsOscC7li9Ye1qQv6t8QsDGX/dQ4jUQ5txc7H9OIRR1FhTnswDzSHYr2+CE
	 6x+2J6tk2r+0v8KpJcfuejNYcJIyv8OLUDCjnA+kg2XqQp/7FfiZhw2voehdGWCh3l
	 7QaZgCXOxxmKhTGFdBRrD/GtcYF+ulHvmwUoaxnC8z0gD2rH8F93V2FxdizZaDaTa1
	 rEKdgdfTRErqa7WvcEftRIeF56cISKwGTlDg37Clm2XkrpAQbyTLsHOhx0eScSWewD
	 YnwVa1ZwpjRL5lk+7NiQU3db3BQ1xQnEHAE5tg3z0VuOF/m2OLXHV1d3RMv3qHmwBS
	 3NjdCypQ7HhXA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 11:50:39 +0200
Message-Id: <DBL1JZEZB87H.1IMYO79R3H9UM@kernel.org>
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
Subject: Re: [PATCH v5 1/2] rust: allocator: add KUnit tests for alignment
 guarantees
References: <cover.1753423953.git.zhuhui@kylinos.cn>
 <da9b2afca02124ec14fc9ac7f2a2a85e5be96bc7.1753423953.git.zhuhui@kylinos.cn>
In-Reply-To: <da9b2afca02124ec14fc9ac7f2a2a85e5be96bc7.1753423953.git.zhuhui@kylinos.cn>

On Fri Jul 25, 2025 at 9:02 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add comprehensive tests to verify correct alignment handling in Rust
> allocator wrappers. The tests validate:
>
> That kmalloc respects both standard (128-byte) and page-size
> (8192-byte) alignments when allocating structs with explicit alignment
> attributes.
>
> That vmalloc correctly handles standard alignments but intentionally
> rejects allocations requiring alignments larger than its capabilities.
>
> That kvmalloc mirrors vmalloc's constraints, accepting standard
> alignments but rejecting excessive alignment requirements.
>
> The test infrastructure uses specialized aligned structs (Blob and
> LargeAlignBlob) and a test harness (TestAlign) to validate pointer
> alignment through different allocation paths. This ensures our Rust
> allocators correctly propagate kernel allocation constraints.
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Thanks, this looks good. I think it would be good to rebase onto [1], since=
 it
will likely land in the same cycle. Additionally, two nits below.

As a follow-up we could also test alignment in the context of
Allocator::realloc(), i.e. when growing and shrinking buffers or requesting=
 a
different NUMA node.

[1] https://lore.kernel.org/lkml/20250715135645.2230065-1-vitaly.wool@konsu=
lko.se/

> ---
>  rust/kernel/alloc/allocator.rs | 58 ++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index aa2dfa9dca4c..bcc916240f11 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -187,3 +187,61 @@ unsafe fn realloc(
>          unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, fl=
ags) }
>      }
>  }
> +
> +#[macros::kunit_tests(rust_allocator_kunit)]
> +mod tests {
> +    use super::*;
> +    use core::mem::MaybeUninit;
> +    use kernel::prelude::*;
> +

--8<--

> +    const TEST_SIZE: usize =3D 1024;
> +    const TEST_LARGE_ALIGN_SIZE: usize =3D kernel::page::PAGE_SIZE * 4;
> +
> +    // These two structs are used to test allocating aligned memory.
> +    // they don't need to be accessed, so they're marked as dead_code.
> +    #[allow(dead_code)]

This should be #[expect(dead_code)].

> +    #[repr(align(128))]
> +    struct Blob([u8; TEST_SIZE]);
> +    #[allow(dead_code)]
> +    #[repr(align(8192))]
> +    struct LargeAlignBlob([u8; TEST_LARGE_ALIGN_SIZE]);
> +
> +    struct TestAlign<T, A: Allocator>(Box<MaybeUninit<T>, A>);
> +    impl<T, A: Allocator> TestAlign<T, A> {
> +        fn new() -> Result<Self> {
> +            Ok(Self(Box::<_, A>::new_uninit(GFP_KERNEL)?))
> +        }
> +
> +        fn alignment_valid(&self, align: usize) -> bool {
> +            assert!(align.is_power_of_two());
> +
> +            let addr =3D self.0.as_ptr() as usize;
> +            if addr & (align - 1) !=3D 0 {
> +                false
> +            } else {
> +                true
> +            }

This can just be

	addr & (align - 1) =3D=3D 0

instead of the conditional clause.

> +        }
> +    }

We could move all the above into test_alignment() given that it's likely on=
ly
needed from there.

> +
> +    #[test]
> +    fn test_alignment() -> Result<()> {
> +        let ta =3D TestAlign::<Blob, Kmalloc>::new()?;
> +        assert!(ta.alignment_valid(128));
> +
> +        let ta =3D TestAlign::<LargeAlignBlob, Kmalloc>::new()?;
> +        assert!(ta.alignment_valid(8192));
> +
> +        let ta =3D TestAlign::<Blob, Vmalloc>::new()?;
> +        assert!(ta.alignment_valid(128));
> +
> +        assert!(TestAlign::<LargeAlignBlob, Vmalloc>::new().is_err());
> +
> +        let ta =3D TestAlign::<Blob, KVmalloc>::new()?;
> +        assert!(ta.alignment_valid(128));
> +
> +        assert!(TestAlign::<LargeAlignBlob, KVmalloc>::new().is_err());
> +
> +        Ok(())
> +    }
> +}
> --=20
> 2.43.0


