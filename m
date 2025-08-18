Return-Path: <linux-kernel+bounces-773651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F1B2A448
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD11B62622
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E412631E11C;
	Mon, 18 Aug 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH1mWBKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FA31CA5C;
	Mon, 18 Aug 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522742; cv=none; b=fJD0/olk/nxQfwZ2cPDX/srGOzbKsWHGKOCpsOlc1k/CY8ShQIhPx2NZ0LkBxsykR9Ys6lH/jD80SOVg2643Q3Tclm1kYygGJoS8LUO3y0LqZ5TthTsvcqAeEqmB30fDHJ9kkT3mCGbYZTix5lP/dHNqPe8mgba/lm4JCos/7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522742; c=relaxed/simple;
	bh=2tIXN0fNWJiknNThfJvGJ1SxNII1Vsykywl1aWMuu5s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=YoBLesf1eGjA8E7WbOzvZDTclj+784d1f7yTfNzmxYVL43SHqflNQ5TypTJYWrpBAXeqUJO70O9DRrdpBvXzJi+NAtqCEMfJ2IlbW7i+9Bd4vZ0TZci7zNI5N/S6siCQTXEpU/3zwJN0LdFOExQQi8vsrrY4YUW//+lvkr11/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH1mWBKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23ECC4CEF1;
	Mon, 18 Aug 2025 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755522742;
	bh=2tIXN0fNWJiknNThfJvGJ1SxNII1Vsykywl1aWMuu5s=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=mH1mWBKzZk04ZwuafIFUFna2IGwP8ve3HvFTIu7KXTB8A6N+44LWC0g+FJvPb5C6O
	 K3g13mH5ntHcbhDC0whIchkVe7I3pCAPY/bmtGOZkycye6QAcLxXPQDaMlX9n4fBrE
	 xlwPeijy+H1576sX98YhF6lLSKzuELQnTqIapPnAhiwGE+j9Hon1uTIIcNo9xP68N0
	 pTiJlbym3tY64hIe8m5x5+UTVtf1n1S/GNICUxf79i49A6n5MghIt9icozM+hgFlJL
	 eFBauFoItBpMNSk5xElq+em2WROQai3RlikVQCqn4Nm0z+8+taQadfhBxyVBowiBTO
	 fvN4HxWCWCung==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 15:12:17 +0200
Message-Id: <DC5KVFUTRCA6.3Q3YQD4L026D2@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/4] rust: scatterlist: Add type-state abstraction for
 sg_table
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-3-dakr@kernel.org> <aKL338gQ7qPNKoBu@google.com>
 <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org>
 <DC5JSHSVPY3P.2HXRIGE8IZOIE@kernel.org>
In-Reply-To: <DC5JSHSVPY3P.2HXRIGE8IZOIE@kernel.org>

On Mon Aug 18, 2025 at 2:21 PM CEST, Danilo Krummrich wrote:
> On Mon Aug 18, 2025 at 1:16 PM CEST, Danilo Krummrich wrote:
>> On Mon Aug 18, 2025 at 11:52 AM CEST, Alice Ryhl wrote:
>>> On Fri, Aug 15, 2025 at 07:10:03PM +0200, Danilo Krummrich wrote:
>>>> +impl<P> Owned<P>
>>>> +where
>>>> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + '=
static,
>>>
>>> If you specifically require the iterator type to be VmallocPageIter,
>>> then I would hard-code that in the trait instead of specifying it here.
>>
>> I do not follow, hard-code in which trait?
>>
>>> But I think you just want `P: AsPageIter`.
>>
>> Yeah, I thought for now it's probably good enough to require VmallocPage=
Iter and
>> revisit once we get more implementors of AsPageIter, but I think we can =
also do
>> it right away.
>>
>> I think we'd need a trait PageIterator, which implements page_count(), s=
ince we
>> technically can't rely on Iterator::size_hint(). Though, in this case I =
think we
>> can also just make AsPageIter::Iter: ExactSizeIterator?
>
> Forgot to mention this [1] as for why we expect VmallocPageIter (at least=
 for
> now).

Actually, let me expand on this a bit:

What I mean is that for some generic page::AsPageIter we don't know anythin=
g
about the semantics of the order of the pages; this is implementation speci=
fic
to the actual Iterator implementation, such as VmallocPageIter.

(For instance, VmallocPageIter iterates pages in the order as they are
virtually contiguous mapped by Vmalloc. VmallocPageIter documents this in t=
he
context of a guarantees section.)

Thus, before allowing any AsPageIter::Iter in SGTable::new(), I'd like to s=
ee
actual implementations and subsequently figure out if it makes sense to add
additional (empty) traits providing such kind of guarantees.

> [1] https://lore.kernel.org/rust-for-linux/958ef505-8713-4f88-9f24-5971ce=
8a08ce@kernel.org/

