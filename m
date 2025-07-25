Return-Path: <linux-kernel+bounces-745357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C1CB118D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2021617287C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3E28FFC6;
	Fri, 25 Jul 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Amp2Czwq"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B126B2D2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427145; cv=none; b=qok7yTet238TJyJep1tNFkaqktspYdnH96uIVMq5BRQefmnmINz/fXCW2Dut0MDtxJYP6ln0MlEG8lTN0M41+KAikrtY1ik03ABz+fmDcY+fz36Qni+7F6KhhqFIFROOsPoTyG1Jj1E5fYEQsAsQ1T7vdYyDgcn4HHRAliuR6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427145; c=relaxed/simple;
	bh=Vky7jQoA9kpj0hrdkJQfui+4eJW/uww4NZANfwOsX/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNY6KSU82+R7Xu/UJhoCFSYvqFp/n6ejV40t0bQggJ3e6am/NCioxP0NRD2l/Wqcifb1Br2byv8+gN14HRKow5cOovagdlSRUDalZRzuHykcb/RI0KAtQNsdcjHl4YRexpSFw/mPbyIcCn+mmv3gif0/feCUA7xJZUsVbBnO+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Amp2Czwq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Jul 2025 15:05:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753427141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/J2rAka31JUlEF/90YWFdrFVosETQBHcCeJLJq3OPw=;
	b=Amp2CzwqLyWfSPazZt0IACQoO7dWoWzI57vW8bNJIX5uu724Vpn34l8x1zOZ366YBovRB9
	5euhz0P9mL53I8rTIoT5/REJ1/3WjS8+38ZbPajCk0nm7aeNR9ZcqsLF2beYIGnPSnf/VZ
	S9J80eXzlk2tuI/FoCVEFeVomVTzqHQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hui Zhu <hui.zhu@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH v4 1/2] rust: allocator: add unit tests of kmalloc,
 vmalloc and kvmalloc
Message-ID: <aIMsuS5XTvKpr-a6@teawaterdeMacBook-Pro.local>
References: <cover.1753348867.git.zhuhui@kylinos.cn>
 <32d7663b7d07d13564bdfb6a1ec4cde1be8b8f80.1753348867.git.zhuhui@kylinos.cn>
 <DBKERZ03P2WS.3HQ0NZC9OO5AZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBKERZ03P2WS.3HQ0NZC9OO5AZ@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Danilo,

On Thu, Jul 24, 2025 at 05:59:39PM +0200, Danilo Krummrich wrote:
> On Thu Jul 24, 2025 at 11:25 AM CEST, Hui Zhu wrote:
> > From: Hui Zhu <zhuhui@kylinos.cn>
> >
> > Add KUnit test cases to validate the functionality of Rust allocation
> > wrappers (kmalloc, vmalloc, kvmalloc).
> >
> > The tests include:
> > Basic allocation tests for each allocator using a 1024-byte Blob
> > structure initialized with a 0xfe pattern.
> > Large alignment (> PAGE_SIZE) allocation testing using an 8192-byte
> > aligned LargeAlignBlob structure.
> > Verification of allocation constraints:
> > - kmalloc successfully handles large alignments.
> > - vmalloc and kvmalloc correctly fail for unsupported large alignments.
> > Content verification through byte-by-byte pattern checking.
> >
> > Co-developed-by: Geliang Tang <geliang@kernel.org>
> > Signed-off-by: Geliang Tang <geliang@kernel.org>
> > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> 
> Thanks for the patch, additional test are always welcome! :)

Great!

> 
> > ---
> >  rust/kernel/alloc/allocator.rs | 57 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index aa2dfa9dca4c..430d1f664fdf 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -187,3 +187,60 @@ unsafe fn realloc(
> >          unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
> >      }
> >  }
> > +
> > +#[macros::kunit_tests(rust_allocator_kunit)]
> > +mod tests {
> > +    use super::*;
> > +    use kernel::prelude::*;
> > +
> > +    const TEST_SIZE: usize = 1024;
> > +    const LARGE_ALIGN_TEST_SIZE: usize = kernel::page::PAGE_SIZE * 4;
> > +    #[repr(align(128))]
> > +    struct Blob([u8; TEST_SIZE]);
> > +    // This structure is used to test the allocation of alignments larger
> > +    // than PAGE_SIZE.
> > +    // Since this is not yet supported, avoid accessing the contents of
> > +    // the structure for now.
> > +    #[allow(dead_code)]
> > +    #[repr(align(8192))]
> > +    struct LargeAlignBlob([u8; LARGE_ALIGN_TEST_SIZE]);
> > +
> > +    #[test]
> > +    fn test_kmalloc() -> Result<(), AllocError> {
> > +        let blob = KBox::new(Blob([0xfeu8; TEST_SIZE]), GFP_KERNEL)?;
> 
> Since those are now actual unit tests on the Allocator implementations, it would
> be fine to use them directly. However, for the case you are testing here, i.e.
> alignment using Box is perfectly fine.
> 
> Having that said, I wouldn't call those tests test_*malloc(), since they're not
> really testing all aspects of a certain allocator, but only the success to
> allocate with certain alignment arguments.
> 
> Instead, I propose to write just a single test, test_alignment(), with a few
> helper functions.
> 
> For instance, your Blob test structure could have a constructor that is generic
> over A: Allocator.
> 
> However, given that you really only want to check alignment, you probably want a
> structure like this instead.
> 
> 	struct TestAlign<A: Allocator>(Box<MaybeUninit<[u8; TEST_SIZE]>, A>);
> 
> 	impl<A: Allocator> TestAlign<A> {
> 	   fn new() -> Result<Self> {
> 	      Box::<_, A>::new_uninit(GFP_KERNEL)
> 	   }
> 
> 	   fn alignment_valid(&self) -> bool {
> 	      ...
> 	   }
> 	}
> 
> and then test_alignment() can just do
> 
> 	let test = TestAlign::<Kmalloc>::new()?;
> 	assert!(test.alignment_valid());
> 
> 	...
> 
> Given that this is now a unit test I also think that actually validating the
> alignment of the pointer Box wraps makes sense, similar to what you had in v2.
> 
> > +        for b in blob.0.as_slice().iter() {
> > +            assert_eq!(*b, 0xfeu8);
> > +        }
> 
> I don't think that this has any valid in the context of testing alignment.
> 
> > +        let blob = KBox::new(LargeAlignBlob([0xfdu8; LARGE_ALIGN_TEST_SIZE]), GFP_KERNEL)?;
> 
> For the large alignment case, you can consider to let TestAlign take a const
> generic, additional to A: Allocator, e.g.
> 
> 	struct TestAlign<A: Allocator, const SIZE: usize>(Box<MaybeUninit<[u8; SIZE]>, A>);
> 
> This way you can keep test_alignment() function very compact.
>

I sent new patches according to your comments.
 
> - Danilo

Best,
Hui

