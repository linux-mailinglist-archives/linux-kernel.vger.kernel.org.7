Return-Path: <linux-kernel+bounces-745549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234ABB11B76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BAA3BB25F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46472D542B;
	Fri, 25 Jul 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd5/fkN4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36712242D6E;
	Fri, 25 Jul 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437752; cv=none; b=HNjHQHnoRha5Ndkby/7GR9bp0sH4IyZnR3LOTyFtCBv1z9zGKXSYu+/I5ZnUwk+TnXVSn76LWtCfr5YFgD18sO05FzIG4rPKyzE9x4gMmuHzwvxahcQCoNl1dLeR6O0FD3xWsPLnJeDO1diGTKweh8C7V4V+ep9B2g5HYdl+WGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437752; c=relaxed/simple;
	bh=rjdf1EmEcZLC6LUqKHlIFrwJuxOuWTkU2p37sKAKiis=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=rYw5zWgKFZ3f1V59uqN6MTgtb3CCBeqjkqljEWlXLNGOsG3PHebX4wQFgphYijs1QVNyzMjAswNygkzEBz4dBAv4R83v3EpJiV1Am6s8o7ZHIm3MVbeb3lRs7jfU8K8sripO4SR5R8RzOUZwqbw9q63Ke5uhxGma52IjY9sZsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd5/fkN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93586C4CEE7;
	Fri, 25 Jul 2025 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753437752;
	bh=rjdf1EmEcZLC6LUqKHlIFrwJuxOuWTkU2p37sKAKiis=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Kd5/fkN4PhQysLsk06x3QhJ4weGZYlCjYFlO3DwEkc6hbXK1FosBcSxvNHXeKKxZF
	 n9xCj4lB+xB5wCgYbN0os8/z81eS2oNprhrtnkUcy7S2uPgD/JAyBhAceKiqIfz85y
	 qdWAQNdD3YsbqciM0yOXspobV2WVradUvzRBUvWZaq5eEblGWGR3mToJ69WbephaOd
	 I3zmvM8zqZx5VGqDAZUCei48GvxEhQJod9aD2WHcv+AjAC33WNSskD1VY9QcfAkAms
	 SIBCRhLSFV0l+dTE3BwL3Y/i6lCeWmJYCPakP5c63tYaCoANCwEiKiN5omiRmBb5Z1
	 TNJXUY5OvkD5w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 12:02:26 +0200
Message-Id: <DBL1T0JY1LUX.1606LM78FACYM@kernel.org>
Subject: Re: [PATCH v5 1/2] rust: allocator: add KUnit tests for alignment
 guarantees
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
To: "Hui Zhu" <hui.zhu@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1753423953.git.zhuhui@kylinos.cn>
 <da9b2afca02124ec14fc9ac7f2a2a85e5be96bc7.1753423953.git.zhuhui@kylinos.cn>
 <DBL1JZEZB87H.1IMYO79R3H9UM@kernel.org>
In-Reply-To: <DBL1JZEZB87H.1IMYO79R3H9UM@kernel.org>

(Cc: Andrew)

On Fri Jul 25, 2025 at 11:50 AM CEST, Danilo Krummrich wrote:
> On Fri Jul 25, 2025 at 9:02 AM CEST, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> Add comprehensive tests to verify correct alignment handling in Rust
>> allocator wrappers. The tests validate:
>>
>> That kmalloc respects both standard (128-byte) and page-size
>> (8192-byte) alignments when allocating structs with explicit alignment
>> attributes.
>>
>> That vmalloc correctly handles standard alignments but intentionally
>> rejects allocations requiring alignments larger than its capabilities.
>>
>> That kvmalloc mirrors vmalloc's constraints, accepting standard
>> alignments but rejecting excessive alignment requirements.
>>
>> The test infrastructure uses specialized aligned structs (Blob and
>> LargeAlignBlob) and a test harness (TestAlign) to validate pointer
>> alignment through different allocation paths. This ensures our Rust
>> allocators correctly propagate kernel allocation constraints.
>>
>> Co-developed-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>
> Thanks, this looks good. I think it would be good to rebase onto [1], sin=
ce it
> will likely land in the same cycle. Additionally, two nits below.

Please also Cc: Andrew for subsequent submissions, since this will, due to =
the
interaction with [1] likely go through his tree.

> As a follow-up we could also test alignment in the context of
> Allocator::realloc(), i.e. when growing and shrinking buffers or requesti=
ng a
> different NUMA node.
>
> [1] https://lore.kernel.org/lkml/20250715135645.2230065-1-vitaly.wool@kon=
sulko.se/
>
>> ---
>>  rust/kernel/alloc/allocator.rs | 58 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>
>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocato=
r.rs
>> index aa2dfa9dca4c..bcc916240f11 100644
>> --- a/rust/kernel/alloc/allocator.rs
>> +++ b/rust/kernel/alloc/allocator.rs
>> @@ -187,3 +187,61 @@ unsafe fn realloc(
>>          unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, f=
lags) }
>>      }
>>  }
>> +
>> +#[macros::kunit_tests(rust_allocator_kunit)]
>> +mod tests {
>> +    use super::*;
>> +    use core::mem::MaybeUninit;
>> +    use kernel::prelude::*;
>> +
>
> --8<--
>
>> +    const TEST_SIZE: usize =3D 1024;
>> +    const TEST_LARGE_ALIGN_SIZE: usize =3D kernel::page::PAGE_SIZE * 4;
>> +
>> +    // These two structs are used to test allocating aligned memory.
>> +    // they don't need to be accessed, so they're marked as dead_code.
>> +    #[allow(dead_code)]
>
> This should be #[expect(dead_code)].
>
>> +    #[repr(align(128))]
>> +    struct Blob([u8; TEST_SIZE]);
>> +    #[allow(dead_code)]
>> +    #[repr(align(8192))]
>> +    struct LargeAlignBlob([u8; TEST_LARGE_ALIGN_SIZE]);
>> +
>> +    struct TestAlign<T, A: Allocator>(Box<MaybeUninit<T>, A>);
>> +    impl<T, A: Allocator> TestAlign<T, A> {
>> +        fn new() -> Result<Self> {
>> +            Ok(Self(Box::<_, A>::new_uninit(GFP_KERNEL)?))
>> +        }
>> +
>> +        fn alignment_valid(&self, align: usize) -> bool {
>> +            assert!(align.is_power_of_two());
>> +
>> +            let addr =3D self.0.as_ptr() as usize;
>> +            if addr & (align - 1) !=3D 0 {
>> +                false
>> +            } else {
>> +                true
>> +            }
>
> This can just be
>
> 	addr & (align - 1) =3D=3D 0
>
> instead of the conditional clause.
>
>> +        }
>> +    }
>
> We could move all the above into test_alignment() given that it's likely =
only
> needed from there.
>
>> +
>> +    #[test]
>> +    fn test_alignment() -> Result<()> {
>> +        let ta =3D TestAlign::<Blob, Kmalloc>::new()?;
>> +        assert!(ta.alignment_valid(128));
>> +
>> +        let ta =3D TestAlign::<LargeAlignBlob, Kmalloc>::new()?;
>> +        assert!(ta.alignment_valid(8192));
>> +
>> +        let ta =3D TestAlign::<Blob, Vmalloc>::new()?;
>> +        assert!(ta.alignment_valid(128));
>> +
>> +        assert!(TestAlign::<LargeAlignBlob, Vmalloc>::new().is_err());
>> +
>> +        let ta =3D TestAlign::<Blob, KVmalloc>::new()?;
>> +        assert!(ta.alignment_valid(128));
>> +
>> +        assert!(TestAlign::<LargeAlignBlob, KVmalloc>::new().is_err());
>> +
>> +        Ok(())
>> +    }
>> +}
>> --=20
>> 2.43.0


