Return-Path: <linux-kernel+bounces-773534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4412BB2A18F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B801896669
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C431B119;
	Mon, 18 Aug 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWN7HxN+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A08326D40;
	Mon, 18 Aug 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519690; cv=none; b=oI1H5WPN3RJocSipsiKO1ffMPayLfObRVqstXg52c0V0tVbPWQK3eoPv6qGLzA0hS7VndF1TUYF4r6ZII28RzVFYNeAe3Ff4z6XowaFH1MgR/vV1RrZ6NqcohwCuSNXblrgfBsFA4dxmqvEQJpIJVx1iyGWgt9MOJSzwaFfz6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519690; c=relaxed/simple;
	bh=nFse0zkoUjk0pi4tTpzGzJI0NOIoCRIkPTkLSDjBFEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=R8wAt8HiYPEe0mrShK8G2Kyddwv81mTN4XuPTkbeTxQL4jARxKYSUn7oSUsO2gvgdmKRuyy8F0rLoMjcMrg+VkH4i2NXjHe+j5iyfkg2iFcZyW95FBVkGm+9H9kKMVNs7F0uejtku6vgWSxQ5YGXlU+JJij9Jeoz+4/yIdFD7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWN7HxN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D7DC4CEEB;
	Mon, 18 Aug 2025 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755519690;
	bh=nFse0zkoUjk0pi4tTpzGzJI0NOIoCRIkPTkLSDjBFEE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uWN7HxN+TUTQn1G1qSbsc95NJ1u/nnjf7/dOl5rM4WwQuPxCQt/byHwlYd5lZbrKu
	 /Uv3bRuntJUzR3shHKdUxnWmy9Y81jhcvbxY+1r85o8/e0N5gJJ5mQ4Hd/KfXo5SPn
	 wLA8pteAT0HmvcKoGF0iUILIXg3AqknvE75wpw2h/AM6/Mw/kh3KaO1dqDoUv4FPN9
	 fVVArqWvgfs2+43R8p1C1DKN0BJhmlX2p+MgKxu9OPopeNZLN/KUTNo2WXWPvjLgwa
	 76VMN8yQZq/LOQb5SNV46IuclIIxTk8sDRsQOcKKmkngUhaRC1i2RhzEUaQrhZPGia
	 kSiWUXsYSogcA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 14:21:25 +0200
Message-Id: <DC5JSHSVPY3P.2HXRIGE8IZOIE@kernel.org>
Subject: Re: [PATCH 2/4] rust: scatterlist: Add type-state abstraction for
 sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-3-dakr@kernel.org> <aKL338gQ7qPNKoBu@google.com>
 <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org>
In-Reply-To: <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org>

On Mon Aug 18, 2025 at 1:16 PM CEST, Danilo Krummrich wrote:
> On Mon Aug 18, 2025 at 11:52 AM CEST, Alice Ryhl wrote:
>> On Fri, Aug 15, 2025 at 07:10:03PM +0200, Danilo Krummrich wrote:
>>> +impl<P> Owned<P>
>>> +where
>>> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + 's=
tatic,
>>
>> If you specifically require the iterator type to be VmallocPageIter,
>> then I would hard-code that in the trait instead of specifying it here.
>
> I do not follow, hard-code in which trait?
>
>> But I think you just want `P: AsPageIter`.
>
> Yeah, I thought for now it's probably good enough to require VmallocPageI=
ter and
> revisit once we get more implementors of AsPageIter, but I think we can a=
lso do
> it right away.
>
> I think we'd need a trait PageIterator, which implements page_count(), si=
nce we
> technically can't rely on Iterator::size_hint(). Though, in this case I t=
hink we
> can also just make AsPageIter::Iter: ExactSizeIterator?

Forgot to mention this [1] as for why we expect VmallocPageIter (at least f=
or
now).

[1] https://lore.kernel.org/rust-for-linux/958ef505-8713-4f88-9f24-5971ce8a=
08ce@kernel.org/

