Return-Path: <linux-kernel+bounces-779744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEFB2F814
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271E68013B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A52C11DA;
	Thu, 21 Aug 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCQggHcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93A2F5E;
	Thu, 21 Aug 2025 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779570; cv=none; b=FaKFQCBPugfdqh4U68CwxKBVMVApsdkh9CREEDxdm1XMWU8/lFBB6gmBHAscwYGIqXaRfn6+NW4Na52faffgKzYbZekak644uLrjIg8Qe0JtHPN1JAWaMDC7upR6opBwoHy3saesEU+4eS/kiU5YxFHn0gEumEhgXYZm8haQ924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779570; c=relaxed/simple;
	bh=SrTqUvmK+NpBlB3NybcMH+08tW6CxEGC7b7hfNmTs+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qaD7D2GP3USc/1HFnE4wr6yhZr31qV3io1hKVwb5FMCXA7f0nanFyZPF2coBW9mMmZFtBI873RQx89CSmLo9DEkrU6kYzuJNDOHZOI+Gcuvc/287WbNwaHmk5HqVJkrNW2D/flmJbqK/zcYPcC2c68SqaKFdqDZQy9b9qIScx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCQggHcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD5AC4CEEB;
	Thu, 21 Aug 2025 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755779570;
	bh=SrTqUvmK+NpBlB3NybcMH+08tW6CxEGC7b7hfNmTs+o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uCQggHcA5Li5qLEFUvSJkmHidXQNxNdMzvaTqeAw29JRR9pkLETXDXfe08yyby1cU
	 jVDiELhFQAVMpMSslcmgWwO8sHb6M0J9GqGT29uI0UB2ILITqHU5Hr9u/n+2xxzUZt
	 RsqrBROsXWPY03PYjVcFjbBF/otcl0NvdUtvnJZnDTuZMNmFcIpYRuFzhMkcwuziQJ
	 tuNs4MMlFfsLQVZG7dhWb0lRWYDNt6pEwhmL299fAMqRKPu8oj7zrcJ9ZX+mrAUmzQ
	 TT7MYIYJK6aMRtQap+bRB7fBadnrIesb6mDbR84FskI7npl1Rswn+1gv8kLsChp6t/
	 hIPmY9joAf4TQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 14:32:44 +0200
Message-Id: <DC83WSYHY3K1.1D3XEES0BIKGS@kernel.org>
Subject: Re: [PATCH v2] rust: zpool: add abstraction for zpool drivers
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Johannes Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>,
 <linux-mm@kvack.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821111718.512936-1-vitaly.wool@konsulko.se>
 <DC83A2M3G8EH.12FRM3C05ABCR@kernel.org>
In-Reply-To: <DC83A2M3G8EH.12FRM3C05ABCR@kernel.org>

On Thu Aug 21, 2025 at 2:03 PM CEST, Danilo Krummrich wrote:
> On Thu Aug 21, 2025 at 1:17 PM CEST, Vitaly Wool wrote:
>> +    /// preferred NUMA node `nid`. If the allocation is successful, an =
opaque handle is returned.
>> +    fn malloc(
>> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
>> +        size: usize,
>> +        gfp: Flags,
>> +        nid: NumaNode,
>> +    ) -> Result<usize>;
>
> I still think we need a proper type representation of a zpool handle that
> guarantees validity and manages its lifetime.
>
> For instance, what prevents a caller from calling write() with a random h=
andle?
>
> Looking at zsmalloc(), if I call write() with a random number, I will mos=
t
> likely oops the kernel. This is not acceptable for safe APIs.
>
> Alternatively, all those trait functions have to be unsafe, which would b=
e very
> unfortunate.

I just noticed that I confused something here. :)

So, for the backend driver this trait is obviously fine, since you have to =
implement
the C ops -- sorry for the confusion.

However, you still have to mark all functions except alloc() and total_page=
s()
as unsafe and document and justify the corresponding safety requirements.

>> +    /// Free a previously allocated from the `pool` object, represented=
 by `handle`.
>> +    fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle:=
 usize);
>
> What happens if I forget to call free()?
>
>> +    /// Make all the necessary preparations for the caller to be able t=
o read from the object
>> +    /// represented by `handle` and return a valid pointer to the `hand=
le` memory to be read.
>> +    fn read_begin(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, h=
andle: usize)
>> +        -> NonNull<u8>;
>
> Same for this, making it a NonNull<u8> is better than a *mut c_void, but =
it's
> still a raw pointer. Nothing prevents users from using this raw pointer a=
fter
> read_end() has been called.
>
> This needs a type representation that only lives until read_end().
>
> In general, I think this design doesn't really work out well. I think the=
 design
> should be something along the lines of:
>
>   (1) We should only provide alloc() on the Zpool itself and which return=
s a
>       Zmem instance. A Zmem instance must not outlive the Zpool it was al=
located
>       with.
>
>   (2) Zmem should call free() when it is dropped. It should provide read_=
begin()
>       and write() methods.
>
>   (3) Zmem::read_begin() should return a Zslice which must not outlive Zm=
em and
>       calls read_end() when dropped.

This design is obiously for when you want to use a Zpool, but not implement=
 its
backend. :)

