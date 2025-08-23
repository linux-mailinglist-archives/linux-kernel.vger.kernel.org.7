Return-Path: <linux-kernel+bounces-783072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF8B32910
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FF17A9940
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536C1E0E14;
	Sat, 23 Aug 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqaA0ZO/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999F8635C;
	Sat, 23 Aug 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958824; cv=none; b=aUd3eI4Wm8Kt7zFnYt4LKxRsus2WtNcdWn5kprBKnfKuRc4y83JEdRnn7oyn9C9Qaid/iEkCfbSkkSXxR3J1eKcBNcqfn237wL+N2lDAMUNOacFc5U5/hSje/fOj7muuOz/Lp31gyQhK/wL7kZGqXHfeddCqiUxVtt2SLcpjZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958824; c=relaxed/simple;
	bh=doIkryewG++KcZ/8n01iugYF07GnEYqj+GObh4QeXms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Sw0bjO0NwHWVFd9xRHmF4txpE4SjzJ+924sXecbRqo0JXdR2jH5/iKJSDsBOrKmeVovwrvP+PXlVddn2cDhGh1ClyeYkxI5ca2Fk9KWGyJb13m7vUZnwekjA41iLL4g0+Pl2CXSQP032ss9qL5zMIt82XUS1TjlCE9ccZENAjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqaA0ZO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3865C4CEE7;
	Sat, 23 Aug 2025 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755958824;
	bh=doIkryewG++KcZ/8n01iugYF07GnEYqj+GObh4QeXms=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=TqaA0ZO/eycjrUduGzXqXhlcQMI2tNhBA82pg6jzXIv0cVnMYR3dGSapvvdq6He+3
	 HdHisuFFuoENK5GNWTZW9TiRrWT10wQq8a/OJ7MPxcmwVd/tCLj09DmanBBnU1GfEp
	 xEB4jUCXYio7ASBVRoeGLCyNemfhvE6YeYd7bWLwzzUa2kMv+9vy5IsZRiEqwImlzN
	 7yKxQDDZ/CMpcBPMQ+8ovEZAL01HwPrk/PTFVt3YU1DUcEDInXLFdQXhMJjJ7LTpmY
	 zf5jFUEHBvzV65XuepjzGrWwRpHg8/bPAPjXDZu2G2LCu0Ma9EJNTECCONF8yFpTtG
	 d0FhwLGDD8YGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 16:20:19 +0200
Message-Id: <DC9VG96PR778.4L9WNCE521AV@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9UR87GP16E.2K9E9SSTHEBRB@nvidia.com>
 <DC9UYN56HBRZ.XRDXQHO2QQQ1@kernel.org>
 <DC9VD4LXAK9R.1RIJYWF1MFCMS@nvidia.com>
In-Reply-To: <DC9VD4LXAK9R.1RIJYWF1MFCMS@nvidia.com>

On Sat Aug 23, 2025 at 4:16 PM CEST, Alexandre Courbot wrote:
> On Sat Aug 23, 2025 at 10:57 PM JST, Danilo Krummrich wrote:
>> On Sat Aug 23, 2025 at 3:47 PM CEST, Alexandre Courbot wrote:
>>> Oops, forgot to mention a couple more things:
>>>
>>> On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
>>>> Add a safe Rust abstraction for the kernel's scatter-gather list
>>>> facilities (`struct scatterlist` and `struct sg_table`).
>>>>
>>>> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
>>>> pattern to provide compile-time guarantees about ownership and lifetim=
e.
>>>
>>> Is this actually a typestate? From my understanding, the typestate
>>> pattern implies transitions from one state to the other (such as
>>> Unmapped -> Mapped), but in this version there are no such transitions
>>> (the previous ones had, though). We are just using a generic parameter,
>>> so mentioning typestate sounds a bit misleading to me.
>>
>> I'd argue that it's still kind of a typestate. You can derive &SGTable (=
i.e.
>> &SGTable<Borrowed>) from SGTabe<Owned>. So, technically there is an
>> uni-directional transition I guess.
>
> That's technically correct, but is also not the intent of the design, at
> least compared to something like Unmapped <-> Mapped. Not a big problem
> if you prefer to keep the current naming though.

I don't mind to name / call it differently, any suggestion?

>>
>>> Another random thought, in the owned case, do we want to provide an
>>> accessor to the provider of the backing pages? Or do we expect the
>>> caller to take dispositions to keep such a reference if they need to
>>> access the backing buffer post-mapping?
>>
>> That's not going to work that easily. Once the backing pages are DMA map=
ped, the
>> backing buffer can be accessed safely an more.
>>
>> See also the safety requirements of dma::CoherentAllocation::as_slice() =
and
>> dma::CoherentAllocation::as_slice_mut().
>
> Yup. So couldn't similar accessors (marked unsafe of course) be
> convenient?

Absolutely! But I think we want them represented by a common trait that can=
 be
used by SGTable and dma::CoherentAllocation.

>>
>> If we want to support that, we have to provide a new type for this and m=
aybe
>> want to define a common trait for DMA mapped memory accessors, etc.
>>
>> Not the scope for this series, I believe. :)
>
> I've had a few thoughts in that direction as well, but completely agree
> we should debate about this *after* this series is merged. :)

Yeah, let's add this feature subsequently.

