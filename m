Return-Path: <linux-kernel+bounces-783064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E84B328F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F633BF5F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E121B8F5;
	Sat, 23 Aug 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6tQsC0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C8111BF;
	Sat, 23 Aug 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957444; cv=none; b=NLYQ+LJStAlP1UG8v4Lbo3QUCDOJq1E3eO61VZjLjDpwOyE/S9deuRQl0iwLEjUFIRKr4qY/AggpjucIrjQP8Ybc39sxig6i0MQXW9x1NwhNPXd6QFvQGDSHZ6RtNxBmWe/4zsoyUSLbYSKvewONnWxeKuo/hZL9wwfS4KSbI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957444; c=relaxed/simple;
	bh=WEYZMYvb3E7pRkxiRNIRiagqsZ+9wO8HnO5/w0JGG4o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=FsKZ90AqqxS4/YPvIOAO9kN56JM/Wsup2ZHBjpKZS7FocVLHse1DViF41hvU1BbDE/XvkXOFA2rmkds4/DCBRkGkQw0j+gULhn6bWArMKXhKB68xfgdSpFfS10VhADOgALUsuJ0SR6T5I6Z2TgGbpBtXtrmEHko3Pj1MHqLA1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6tQsC0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF3CC4CEE7;
	Sat, 23 Aug 2025 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755957443;
	bh=WEYZMYvb3E7pRkxiRNIRiagqsZ+9wO8HnO5/w0JGG4o=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=d6tQsC0p4guuZ93dC9NzAMbkc+7z65pV/C71qcORQB8nxe4l6r16hRL0U8uLy+Zia
	 zbCO1x0oOEZ/cpivEacIdJnxYDcyqGfUw892dAxXvktveSLpCefymSPO3RxtCXlhDw
	 GDxRMPTpBqZViNXTGVLSefm7Pg+/vOJpv3Ma3pKSpx4ii8jVHvQkcWjwrY+bVKY/t8
	 nNQ833ivnAHCCFKptfz4Y69tHUwDnbxmr8WnLqYAjJza/mMJ02vqw5HJWkSBPmC4G8
	 a9i2OiQzj1E7CKtEfKNal7um2JqSZaleFMB70ikDCLDGOH88d5rF11zHIaBQqLojpg
	 7Bz106prap5JA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 15:57:18 +0200
Message-Id: <DC9UYN56HBRZ.XRDXQHO2QQQ1@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9UR87GP16E.2K9E9SSTHEBRB@nvidia.com>
In-Reply-To: <DC9UR87GP16E.2K9E9SSTHEBRB@nvidia.com>

On Sat Aug 23, 2025 at 3:47 PM CEST, Alexandre Courbot wrote:
> Oops, forgot to mention a couple more things:
>
> On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
>> Add a safe Rust abstraction for the kernel's scatter-gather list
>> facilities (`struct scatterlist` and `struct sg_table`).
>>
>> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
>> pattern to provide compile-time guarantees about ownership and lifetime.
>
> Is this actually a typestate? From my understanding, the typestate
> pattern implies transitions from one state to the other (such as
> Unmapped -> Mapped), but in this version there are no such transitions
> (the previous ones had, though). We are just using a generic parameter,
> so mentioning typestate sounds a bit misleading to me.

I'd argue that it's still kind of a typestate. You can derive &SGTable (i.e=
.
&SGTable<Borrowed>) from SGTabe<Owned>. So, technically there is an
uni-directional transition I guess.

> Another random thought, in the owned case, do we want to provide an
> accessor to the provider of the backing pages? Or do we expect the
> caller to take dispositions to keep such a reference if they need to
> access the backing buffer post-mapping?

That's not going to work that easily. Once the backing pages are DMA mapped=
, the
backing buffer can be accessed safely an more.

See also the safety requirements of dma::CoherentAllocation::as_slice() and
dma::CoherentAllocation::as_slice_mut().

If we want to support that, we have to provide a new type for this and mayb=
e
want to define a common trait for DMA mapped memory accessors, etc.

Not the scope for this series, I believe. :)

