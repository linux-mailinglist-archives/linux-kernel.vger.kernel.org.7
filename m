Return-Path: <linux-kernel+bounces-857861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C50BE818B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB9506C04
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D448313267;
	Fri, 17 Oct 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtfpcKa6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C44312811;
	Fri, 17 Oct 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697588; cv=none; b=EaLWvgD4l6uKjo+pwiR1SrT6JaTBOrcXrG/e0XAV13U2BKn/CVRgs7ZpgcP79ymkgQc2TJ7FSJr+kjEwQLHdkjp2ewHGg5ZY/9EwFid+a3OZseEeGEwdQOa5obm6RpbJHTYsv5UPNU2KpGXIUCi7iSEpjltQox9scJysDYk1rpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697588; c=relaxed/simple;
	bh=RprQ24Rtq4TN2VnVsUyJn/KZ51hCTF6QCkb5xO6r6UQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KSyWQGTKlP85h577W1S4vgwzLpDKRRiWDd3ADMzTgMxIf1p1H3MzhRKyClKQkluuokAInqKQJhOih73DDd5+KsGtmIiP/UQljq3snSuDSo7OBSX3OkuNJnHtHCZbSoLzrbWR7Gtu3ssuVxLlx3bNBbeQroB/Y+6P4PRkPloJ848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtfpcKa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF588C4CEE7;
	Fri, 17 Oct 2025 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760697588;
	bh=RprQ24Rtq4TN2VnVsUyJn/KZ51hCTF6QCkb5xO6r6UQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OtfpcKa6PADCrYcmtw+fZoMJAbmridwn+1wDlyfExy4QDleWi4+KSH7EtJH27VPSa
	 lUkD9tW/P81U2V7+3rnYZx9KSdSOQNvIfBdI++Z0z4mKAK3qQFtRJY8qoKuW52Rwyg
	 9G3gfBMDP0LUB7wmtEB2xUmsWun9sw4m9iYO1LbY0nGPk4OpuoOlkT5nf1zuHoIYA2
	 6D3015o9H3A0uLjHCVEl146PSYMEpP6weoXbiqFFF24m7aRTlPsC25t8lpKsWtl/ul
	 eKhYzbJaoUXm0z1YmT3vexRnx5Vgx+VaNhfmmteutkS0moN/C5r4FVcJTrO34aLPf/
	 74gzhxl5dxvbw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 12:39:42 +0200
Message-Id: <DDKJ7AWIL0CN.32FB27N70K2YS@kernel.org>
Subject: Re: [PATCH v5 03/14] gpu: nova-core: gsp: Create wpr metadata
Cc: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251013062041.1639529-1-apopple@nvidia.com>
 <20251013062041.1639529-4-apopple@nvidia.com>
 <DDJJ4ECCSE2I.1EUAJRU9JBGNI@nvidia.com>
 <zwaefk62to77b5nyakeiboyj53fge3lysc3z7arp54tyyherdo@nsqhuig7bmbc>
 <DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org>
 <DDK6IHKS13RS.3UVIM301BBFUP@nvidia.com>
 <ckwuxk7ohtkbpqk345kzypkafu6bkshwbgshie2bq2vzwhj4pv@5wu4u6htkcuq>
 <DDK7OP7VPVD0.1G6XJ4WCFFF02@nvidia.com>
In-Reply-To: <DDK7OP7VPVD0.1G6XJ4WCFFF02@nvidia.com>

On Fri Oct 17, 2025 at 3:38 AM CEST, Alexandre Courbot wrote:
> On Fri Oct 17, 2025 at 10:15 AM JST, Alistair Popple wrote:
>> On 2025-10-17 at 11:43 +1100, Alexandre Courbot <acourbot@nvidia.com> wr=
ote...
>>> On Fri Oct 17, 2025 at 8:11 AM JST, Danilo Krummrich wrote:
>>> > On Fri Oct 17, 2025 at 1:03 AM CEST, Alistair Popple wrote:
>>> >> On 2025-10-16 at 17:23 +1100, Alexandre Courbot <acourbot@nvidia.com=
> wrote...
>>> >>> On Mon Oct 13, 2025 at 3:20 PM JST, Alistair Popple wrote:
>>> >>> > +impl GspFwWprMeta {
>>> >>> > +    pub(crate) fn new(gsp_firmware: &GspFirmware, fb_layout: &Fb=
Layout) -> Self {
>>> >>> > +        Self(bindings::GspFwWprMeta {
>>> >>> > +            magic: r570_144::GSP_FW_WPR_META_MAGIC as u64,
>>> >>> > +            revision: u64::from(r570_144::GSP_FW_WPR_META_REVISI=
ON),
>>> >>> > +            sysmemAddrOfRadix3Elf: gsp_firmware.radix3_dma_handl=
e(),
>>> >>> > +            sizeOfRadix3Elf: gsp_firmware.size as u64,
>>> >>>=20
>>> >>> Very unfortunately I'm afraid we will need to replace the `as` in t=
his
>>> >>> method with `u64::try_from` and make it return a `Result` for now.
>>> >>
>>> >> And presumably most of the other `as` keywords in this function deal=
ing with
>>> >> usize as well? Have made the change but would you mind quickly expla=
ining
>>> >> why this is needed? Is the concern that usize might be more than 64 =
bits or
>>> >> something?
>>>=20
>>> Indeed, the concern is that `as` performs a lossy conversion without
>>> warning, which could catch us off-guard if e.g. some type changes in th=
e
>>> bindings.
>>>=20
>>> >
>>> > Since nova-core depends on CONFIG_64BIT, I think we want a helper fun=
ction that
>>> > converts usize to u64 infallibly.
>>> >
>>> > This helper function can simply generate a compile time error, when
>>> > !CONFIG_64BIT, etc.
>>> >
>>> > We can do this locally in nova-core, but it could also find it's plac=
e in the
>>> > generic infrastructure. nova-core clearly won't be the last driver ru=
nning into
>>> > this inconvinience.
>>>=20
>>> That would definitely be the correct way to address this.
>>
>> Sure. Although I don't really have a problem with the binding constructo=
rs being
>> fallible as plenty of the others are anyway.
>
> I think we can address the non-fallible conversions as a separate task
> (as there are many sites that could be similarly optimized in the
> nova-core code), so fallible constructors are acceptable imho.

The infallible conversion function is trivial to implement.

If you prefer, we can also add it in nova-core first and subsequently move =
it to
generic infrastructure.

I prefer not to introduce more as-casts or fallible conversions we have to =
clean
up subsequently.

