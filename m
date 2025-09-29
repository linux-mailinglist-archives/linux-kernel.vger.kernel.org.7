Return-Path: <linux-kernel+bounces-835860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F9ABA836B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CA71896A77
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B052BEFE0;
	Mon, 29 Sep 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iviEzko9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6E1E0E14;
	Mon, 29 Sep 2025 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129607; cv=none; b=lkYMP5besbx+CBYxSe1zkg08b+/Yl5qWqABYgEI/FeqokRmbgWMHDLriYvHSR4tiStOFkap0l4KzmDUykoidyVQJq8ksjPYMeMImXRNBHl6YDw6OVjQeYEaqRdbVXMpGpsuerq0aGSOgie0O5x8O/HM/Wlki8DFsyB3GeBecvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129607; c=relaxed/simple;
	bh=zGQHYFZJRxNF9v5B5ZQ3iTL2YoC48kcSK/AH+EjsG5U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=MY9E/kHD4mQTdWyHAJXb9/U/qasDG0aIGdaShWg2kbEHaQ5QDCI248/c4NE/dbSBRoqsAphvb/dKABm969uHcFe1JF3JcM2opHCmEkhKupjusAfmrz3brLckSSf19Sxo+F7EF8PUhG2tgVQzamwww/MnmSTV7eVM4rZSfUuveyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iviEzko9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866FBC4CEF4;
	Mon, 29 Sep 2025 07:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759129606;
	bh=zGQHYFZJRxNF9v5B5ZQ3iTL2YoC48kcSK/AH+EjsG5U=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=iviEzko9domWThvZHdlyfdupWopKBEIfZuNVwFPjeQjoAC5yTE4we4GeFteDsTbUg
	 6tF3ksuAgXkfHfCp6tS+iR2gZ69JSQ5o6DvTC9W6MtwxVjZowMdr855aiUcizdcg+b
	 zbn+61CiJtWtX36a4+uYg00mlK9VAhv2mHzOoEWrzOM5Yyfrhqh3ZP+ksx8iJF9+vM
	 VKsBQohjCnFbVH1FYUpgBnm6atq9Jds2x44XsScUntR+gVPH6V5Whww/WAiK4pCWf4
	 oU/o4Xh/7xFFAxttR3oEmGT6IN/bY977SJJS9VRjaz77vXeuNhcA84izTmaPXqSvK1
	 Jgx2YPtPNgorQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 09:06:40 +0200
Message-Id: <DD53EE5HJUZY.2EMREPXQ9P090@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 01/10] gpu: nova-core: Set correct DMA mask
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-2-apopple@nvidia.com>
 <7fb081e9-e607-401b-937f-f4e3a78a2874@kernel.org>
 <0dbc8f78-5cee-4741-8d33-df3358dd5383@nvidia.com>
 <eblaubjmsesi6gh64ekm74qyzvfk23vjcmotc33upkc5w6edin@rbsezy6f7bai>
 <DD2PRD2XEZRE.1YACAPZWRYLZO@kernel.org>
 <um3463eyjtecebxdgjpegankwxgezqgeiqff6xy5wducnv7ayf@pnjhxbro2sh5>
In-Reply-To: <um3463eyjtecebxdgjpegankwxgezqgeiqff6xy5wducnv7ayf@pnjhxbro2sh5>

On Mon Sep 29, 2025 at 2:19 AM CEST, Alistair Popple wrote:
> On 2025-09-26 at 22:00 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Tue Sep 23, 2025 at 6:29 AM CEST, Alistair Popple wrote:
>> > On 2025-09-23 at 12:16 +1000, John Hubbard <jhubbard@nvidia.com> wrote=
...
>> >> On 9/22/25 9:08 AM, Danilo Krummrich wrote:
>> >> > On 9/22/25 1:30 PM, Alistair Popple wrote:
>> >> >> +        // SAFETY: No DMA allocations have been made yet
>> >> >=20
>> >> > It's not really about DMA allocations that have been made previousl=
y, there is
>> >> > no unsafe behavior in that.
>> >> >=20
>> >> > It's about the method must not be called concurrently with any DMA =
allocation or
>> >> > mapping primitives.
>> >> >=20
>> >> > Can you please adjust the comment correspondingly?
>> >
>> > Sure.
>> >
>> >> >> +        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<47=
>())? };
>> >> >=20
>> >> > As Boqun mentioned, we shouldn't have a magic number for this. I do=
n't know if
>> >> > it will change for future chips, but maybe we should move this to g=
pu::Spec to
>> >>=20
>> >> It changes to 52 bits for GH100+ (Hopper/Blackwell+). When I post tho=
se
>> >> patches, I'll use a HAL to select the value.
>> >>=20
>> >> > be safe.
>> >> >=20
>> >> > At least, create a constant for it (also in gpu::Spec?); in Nouveau=
 I named this
>> >> > NOUVEAU_VA_SPACE_BITS back then. Not a great name, if you have a be=
tter idea,
>> >> > please go for it. :)
>> >
>> > Well it's certainly not the VA_SPACE width ... that's a different addr=
ess space :-)
>>=20
>> I mean, sure. But isn't the limitation of 47 bits coming from the MMU an=
d hence
>> defines the VA space width and the DMA bit width we can support?
>
> Not at all. The 47 bit limitation comes from what the DMA engines can phy=
sically
> address, whilst the MMU converts virtual addresses to physical DMA addres=
ses.

I'm well aware -- what I'm saying is that the number given to
dma_set_mask_and_coherent() does not necessarily only depend on the physica=
l bus
and DMA controller capabilities.

It may also depend on the MMU, since we still need to be able to map DMA me=
mory
in the GPU's virtual address space.

> So the two address spaces are different and can have different widths. In=
deed
> most of our current GPUs have a virtual address space of 49 bits whilst o=
nly
> supporting 47 bits of DMA address space.

Now, it seems that in this case the DMA engine is the actual limiting facto=
r,
but is this the case for all architectures or may we have cases where the M=
MU
(or something else) becomes the limiting factor, e.g. in future architectur=
es?

