Return-Path: <linux-kernel+bounces-773582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B90B2A1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBDB2A7553
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0B3218D0;
	Mon, 18 Aug 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4F9fHBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A373218BF;
	Mon, 18 Aug 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520640; cv=none; b=Aq+gDotaaeCYQ/mzc4LPtrkbGChSMhVDl2T2m9KTdJwj1Ne7XMxb39yt2jnmO8FSMeUVxRQinNyemTN9o+wYIqkAQl2HzHxcNMwY5hVE75srxqv99uyXoZCoiivrbSxvlfw2NTE2jCX1yThISnhRfY3eQQmU5kzvQWczyzSUsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520640; c=relaxed/simple;
	bh=1FPIbN0q+6sKO/Cq1SGIMpTlewV8QV4WIFDaJwRFQO0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=l2bho3q/xisssTUg83z01sNsWSJS5wZYWVBeUgl8YCrXnE88MrciHmaCF6++RZsb51a+XsdGuFhdJYNjCALANFmjs0BZOIayogc+UMUgmGpXeXfbR6Jn4ImH0qMShbnpyc90F+MbxfxFatsqp5R445eKUp+c8lst2L9oOvnJQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4F9fHBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CAAC4CEEB;
	Mon, 18 Aug 2025 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755520640;
	bh=1FPIbN0q+6sKO/Cq1SGIMpTlewV8QV4WIFDaJwRFQO0=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=l4F9fHBmwL46+OLOEX21tLfcKox9ZW5RvsKcrXYtApMmSw9/1IJeVLm3cKpVzQYga
	 FOjtnx8VT94mVnvqwAZjpxl7tM5g/ArdJJNL4f0dt5ARpS/u+M6sjLJQfsKo+zalEK
	 3Xqp5DS+bbL+HmWjQuK+m00cDTyM5MOQuKcJZfMHZtGwp2t90Ow8zLk9NjzSCCoWlc
	 3+n9hT/OPwIVGtrCDwrGbyVEin/p2a2Rn4Z1gUDjsrgWrJAzQua8dEbS5M4HiOOOTt
	 UaO+qKH/xhZSxUU1caoTRHvvL3npTvMlB+LdV8wTS0s+BM/A1eL9Knr2M6Ru4SUHKF
	 q3Ufxn1ue/klA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 14:37:15 +0200
Message-Id: <DC5K4M9BQORO.1P8RCL0R7350D@kernel.org>
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
 <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org> <aKMcSWXEFZXIkwG6@google.com>
In-Reply-To: <aKMcSWXEFZXIkwG6@google.com>

On Mon Aug 18, 2025 at 2:27 PM CEST, Alice Ryhl wrote:
> On Mon, Aug 18, 2025 at 01:16:55PM +0200, Danilo Krummrich wrote:
>> On Mon Aug 18, 2025 at 11:52 AM CEST, Alice Ryhl wrote:
>> > On Fri, Aug 15, 2025 at 07:10:03PM +0200, Danilo Krummrich wrote:
>> >> +{
>> >> +    fn new(
>> >> +        dev: &Device<Bound>,
>> >> +        mut pages: P,
>> >> +        dir: dma::DataDirection,
>> >> +        flags: alloc::Flags,
>> >> +    ) -> Result<impl PinInit<Self, Error> + use<'_, P>> {
>> >
>> > We would probably want to move the logic into the initializer so that =
we
>> > don't have the double Result here.
>>=20
>> That'd be nice, but I think it's not possible.
>>=20
>> We can't borrow from pages in the initializer closure while at the same =
time
>> store pages with another initializer, can we?
>>=20
>> Either way, it's not that big a deal I think, since this constructor is =
not
>> exposed to the outside world. Which is also why it didn't bother me too =
much.
>
> Ok. Shrug.

I mean, don't get me wrong, if you see a way to avoid the double Result, I'=
m
happy to change it.

(What I meant is, given the above, I thought it's not possible. But at the =
same
time I did not spend too much brain cycles, since the constructor is privat=
e
anyways.)

