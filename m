Return-Path: <linux-kernel+bounces-833996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09738BA38F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A2E3A2315
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE02EB5CB;
	Fri, 26 Sep 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnw2Ux0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22538296BDF;
	Fri, 26 Sep 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888009; cv=none; b=ZgwBmuVAXCpvTmAuz63IAMBd5SqeV56BFufw5sLM6VvaI+gg0fOIyXzAEb9jvBURTJ+eDE8iBcjDUeLOoTk8OU0ifdadRz1hzB4bGFeznbIpPMpBHiESk2H86Xem59cBohl2+R4ZFmmnO9Dmt8IxPtOKdjWDQMv/Pged4AxJLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888009; c=relaxed/simple;
	bh=SxKEpvT1xfQHA95My4WDzhWTJSuoe5gKWO8GLmU6P/4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=YYuAvaaiH7BVKcjjQevMgLDUziCAyea+V8Mhd5gBOZZWxtmb6MdeISDot7o2mY3dly3scZPTF4AypeekdPSBG+v9CjEWfNyJ4lGXRslJ/rHlK3I8b4K/UkecGj3QRuPQPtJOvuDSYulWc4mHR3Xt1rTuiSMir8Co3QakC0H4FX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnw2Ux0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DEAC4CEF4;
	Fri, 26 Sep 2025 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758888007;
	bh=SxKEpvT1xfQHA95My4WDzhWTJSuoe5gKWO8GLmU6P/4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=Tnw2Ux0FXaCZhG83mBnRs5GzQ2vXUEIMniK7JrrcK5fARqbzP5qZ5mW02eke7Jzcm
	 ZKthAQLJPdnvYpSUIEIcvMeS7KPuoq3XbIvqXO43QWeNU+4Ui4WD+BjSi37u+JhkQb
	 F8dKR4fyEyI9yb0ZmrlODwNyZxHP9fBOIo2hkmQrDeEf/COMrfD5oncP/gk0Do+OOp
	 I1pTwnfu5Ily1OmwrnNHcJe24td5/dAXD2TDke5WxoPj3WBnyXYFpIDy+z4Hd6BbdD
	 bj2H2XVCsKRYHpS9wr/N4o18onL+ecm6fnxWY+oxaCtUiTkwVdArjlo0Gq8mN+siYr
	 DhXhyFiOOkK7g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 14:00:01 +0200
Message-Id: <DD2PRD2XEZRE.1YACAPZWRYLZO@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 01/10] gpu: nova-core: Set correct DMA mask
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
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-2-apopple@nvidia.com>
 <7fb081e9-e607-401b-937f-f4e3a78a2874@kernel.org>
 <0dbc8f78-5cee-4741-8d33-df3358dd5383@nvidia.com>
 <eblaubjmsesi6gh64ekm74qyzvfk23vjcmotc33upkc5w6edin@rbsezy6f7bai>
In-Reply-To: <eblaubjmsesi6gh64ekm74qyzvfk23vjcmotc33upkc5w6edin@rbsezy6f7bai>

On Tue Sep 23, 2025 at 6:29 AM CEST, Alistair Popple wrote:
> On 2025-09-23 at 12:16 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
>> On 9/22/25 9:08 AM, Danilo Krummrich wrote:
>> > On 9/22/25 1:30 PM, Alistair Popple wrote:
>> >> +        // SAFETY: No DMA allocations have been made yet
>> >=20
>> > It's not really about DMA allocations that have been made previously, =
there is
>> > no unsafe behavior in that.
>> >=20
>> > It's about the method must not be called concurrently with any DMA all=
ocation or
>> > mapping primitives.
>> >=20
>> > Can you please adjust the comment correspondingly?
>
> Sure.
>
>> >> +        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<47>()=
)? };
>> >=20
>> > As Boqun mentioned, we shouldn't have a magic number for this. I don't=
 know if
>> > it will change for future chips, but maybe we should move this to gpu:=
:Spec to
>>=20
>> It changes to 52 bits for GH100+ (Hopper/Blackwell+). When I post those
>> patches, I'll use a HAL to select the value.
>>=20
>> > be safe.
>> >=20
>> > At least, create a constant for it (also in gpu::Spec?); in Nouveau I =
named this
>> > NOUVEAU_VA_SPACE_BITS back then. Not a great name, if you have a bette=
r idea,
>> > please go for it. :)
>
> Well it's certainly not the VA_SPACE width ... that's a different address=
 space :-)

I mean, sure. But isn't the limitation of 47 bits coming from the MMU and h=
ence
defines the VA space width and the DMA bit width we can support?

> I thought from the context that the magic number was pretty obviously the
> supported DMA address width in bits, especially given the extra decoratio=
n
> of the DmaMask type. Certainly that's been the accepted practice for the =
rest
> of the kernel where pretty much all drivers just use something of the for=
m
> dma_set_mask(drm_dev->dev, DMA_BIT_MASK(44)) or whatever DMA address widt=
hs
> they support.
>
>> GPU_DMA_BIT_WIDTH, for now?
>
> Works for me.
>
>> thanks,
>> --=20
>> John Hubbard
>>=20


