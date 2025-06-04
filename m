Return-Path: <linux-kernel+bounces-672849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496FACD879
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C13E174B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 07:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782081F461D;
	Wed,  4 Jun 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReE5esUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA2C3246;
	Wed,  4 Jun 2025 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021674; cv=none; b=gvnwIxs+ZP/OfPlAuOsYX7U+ct4TA4lsR8H5bFdfbZTgMcUNfR31yALBobA/UGXURaLyeKARhMFgWBxS5+xoNEoIsE0/64IM5idL9isZDla3fBg6C4mh962lAvH0tBA84NBD+mOL+X+w0Np8Vsppkxu130CDwe3FjpECDxs5ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021674; c=relaxed/simple;
	bh=bv3plLMWlYqiLX7bbykrBWrHgekpaHQ8/VAfsukF9Y4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=pbAz7J1tuBsdoVqRhfPJ3tz0HSRDuHMJa52QqTG25hJ5Z2fidJJh3XP35o9mRIhTV6cBPD7JdXgZRbUQ5PsZkgVOeYAusupv6spBBpGPlTClXy6q3n1Zy3LNQu5l5LUffZVUbIRIz5VsUB37BHWqfe9A/Tol6d8mpNRajyqqy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReE5esUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978F5C4CEE7;
	Wed,  4 Jun 2025 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749021674;
	bh=bv3plLMWlYqiLX7bbykrBWrHgekpaHQ8/VAfsukF9Y4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=ReE5esUN24NKZGDizZih/Wi47yyBeivCQXlNEh7+dKc7W/mln6YWKC6G/WA6exjT7
	 RPGl9TCXMD0b85groLCDhRcejg9Z9Afl3yFqCTh1ECCVHP68DDLfVficbKQWwy8GtP
	 1ALltU25VugAwUYwpMrjMixo2W+GskAbnZ4Gimg+c6dq52wCKjt94M1P1lUr+Q0Vmm
	 hv4IKqICYaw7SW6kKJH2pbgue6YsIzTurZclRU7ygsUvhzdOxzD2a0RgQ5r3yaGVB2
	 3T7dGBeM4I4S4WNhiJv8vgpOQlWewseUzQavzgbRXP8NvBe5aQWNKlcg5yDE+wJ3YE
	 AraRyj45Y625g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Jun 2025 09:21:07 +0200
Message-Id: <DADKFPYCQTSB.11AEFJUAXVH1R@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Ben Skeggs" <bskeggs@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 04/20] rust: add new `num` module with useful integer
 operations
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250521-nova-frts-v4-0-05dfd4f39479@nvidia.com>
 <20250521-nova-frts-v4-4-05dfd4f39479@nvidia.com>
 <DA82KFLNAOG7.R7YT4BHCLNZQ@kernel.org>
 <DA88YHU4AZT7.B8JGZHW9P9L9@nvidia.com>
 <DA8GTD7LT7KO.1A3LBQGEQTCEW@kernel.org> <aD1xVkggDrCvA7ve@pollux>
 <DAD9NDFY2RXV.3LDMFVUYN0IKD@kernel.org>
 <DADAXGJLZ4LP.27P0GIQB2DKD0@nvidia.com>
In-Reply-To: <DADAXGJLZ4LP.27P0GIQB2DKD0@nvidia.com>

On Wed Jun 4, 2025 at 1:54 AM CEST, Alexandre Courbot wrote:
> On Wed Jun 4, 2025 at 7:53 AM JST, Benno Lossin wrote:
>> On Mon Jun 2, 2025 at 11:39 AM CEST, Danilo Krummrich wrote:
>>> On Thu, May 29, 2025 at 09:27:33AM +0200, Benno Lossin wrote:
>>>> That's also fair, but we lose the constness of `next_multiple_of`, so
>>>> you can't use `align_up` in a const function. That might confuse peopl=
e
>>>> and then they write their own const helper function... I'd prefer we u=
se
>>>> all functions that are available in the stdlib.
>>>
>>> Considering that, what's the suggestion for this trait?
>>>
>>> I don't think we should have a trait with align_down() and fls() only a=
nd
>>> otherwise use next_multiple_of(), i.e. mix things up.
>>
>> Agreed.
>>
>>> I think we should either align with the Rust nomenclature - whatever th=
is means
>>> for fls() - or implement the trait with all three methods.
>>
>> The longterm perspective would be to choose the Rust one. But I'd also
>> understand if people want the kernel's own terms used. Still I prefer
>> the Rust ones :)
>
> My understanding is that so far we have tried to match the names of C
> counterparts as much as possible when reimplementing stuff. I don't
> think this particular module warrants an exception, which could cause
> confusion to folks coming from the C part of the kernel.

There are instances of both, sometimes we have taken the Rust names,
sometimes we have taken the C names. While wrapping a C API, we have
mostly stuck to the C names, since that's what people are used to.

But for more "core" code that's used by everyone, we often have used the
Rust names. For example for the reference counting stuff, we have not
used the `_get` and `_put` names, as that is done very different in Rust
with `Drop`.

---
Cheers,
Benno

