Return-Path: <linux-kernel+bounces-841611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA17BB7D11
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B85919E5D80
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555A2DCBF4;
	Fri,  3 Oct 2025 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wid78YSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD62DC77F;
	Fri,  3 Oct 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514408; cv=none; b=gAaDmhj7E4DJIcyqBuwePIm4xzXMQZrdxJELfK+bAtWNbG2UDDnl5oh/uDRuTcPJ2O1Bw8g9Y6/MFdqYZYcHvZ7UTsD1BWcxOgjFiRTlj6SBkLnLmC6UAUPjzaUt460Dmr+HqI6zbVsxnnMwJ7lRuvEip1Xi4BeG+enPeOz+yQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514408; c=relaxed/simple;
	bh=I/qWDMKQv5qKzeMlqK751O9Q0IyCyXsvYmApunFN05k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VYgWQOwg1+9TU7XvhwaBCcMP7752PTYUDbqyDp0hmojahoUtVc/dQ93VuQLrn2U5cPR+KD98MnOpw6jBSSMOca9vaTaamAXLpAY7v8QZK5/iejsNj8pWsLTM6PWsDnxCxvsw8vxO39uy8SBUXCBs5Veqg0vc7NqqRtM5Neusyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wid78YSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB1DC4CEF5;
	Fri,  3 Oct 2025 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514406;
	bh=I/qWDMKQv5qKzeMlqK751O9Q0IyCyXsvYmApunFN05k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Wid78YSdBNA2CatxdLycAAbOphm7XEZslawm5fH4LIcQ9Y5wuvC1tWARj1iZ74ZTb
	 lxuTv20ujrbyvMnZ4WAUUVxxW+Z8JeFmPiUqqj6ra2InZMI9Eu/JI0Pmj/HyywN/Fj
	 yrh24wr0xbb+HWsMjUBznlus80UmGWPmix4KPmdBVv3hp4MxCta8vjhhPGinVHgKg3
	 9p8GItUsDDrJDUrLuffAXf+IYA2FisGjbs4ptSPi+XerKmrs+KtQc+kdOjNlAGi8JO
	 JOs6yg8i74hieXqEjbc20ojq7tYJ1hOBMwuS0yl6IKU2ULGrcdWjLaq7+aJZ6o9VG9
	 J7Va0OTAjeQLg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 19:59:59 +0200
Message-Id: <DD8VSSFRFC46.X5BFWEV3JAH2@kernel.org>
Subject: Re: [PATCH v3 08/13] gpu: nova-core: Add bindings and accessors for
 GspSystemInfo
From: "Benno Lossin" <lossin@kernel.org>
To: "Janne Grunau" <j@jannau.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <dakr@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20250930131648.411720-1-apopple@nvidia.com>
 <20250930131648.411720-9-apopple@nvidia.com>
 <DD7VU4239GS2.2MKVFPBFEY1R4@nvidia.com>
 <DD8TZ3TU57L3.2958OTC9UP4VF@kernel.org>
 <20251003172517.GA1574227@robin.jannau.net>
In-Reply-To: <20251003172517.GA1574227@robin.jannau.net>

On Fri Oct 3, 2025 at 7:25 PM CEST, Janne Grunau wrote:
> On Fri, Oct 03, 2025 at 06:34:12PM +0200, Benno Lossin wrote:
>> On Thu Oct 2, 2025 at 3:49 PM CEST, Alexandre Courbot wrote:
>> > Hi Alistair, (+Benno as this concerns the `init!` macros)
>> >
>> > On Tue Sep 30, 2025 at 10:16 PM JST, Alistair Popple wrote:
>> >> Adds bindings and an in-place initialiser for the GspSystemInfo struc=
t.
>> >>
>> >> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> >>
>> >> ---
>> >>
>> >> It would be good to move to using the `init!` macros at some point, b=
ut
>> >> I couldn't figure out how to make that work to initialise an enum rat=
her
>> >> than a struct as is required for the transparent representation.

Oh by the way, enums are not supported due to a language limitation,
see:

    https://github.com/Rust-for-Linux/pin-init/issues/59

>> > Indeed we have to jump through a few (minor) hoops.
>> >
>> > First the `init!` macros do not seem to support tuple structs. They
>> > match a `{` after the type name, which is not present in
>> > `GspSystemInfo`. By turning it into a regular struct with a single
>> > field, we can overcome this, and it doesn't affect the layout the
>> > `#[repr(transparent)]` can still be used.
>>=20
>> Yeah that's the correct workaround at the moment. I'm tracking support
>> for tuple structs in [1]. Essentially the problem is that it requires
>> lots of effort to parse tuple structs using declarative macros. We will
>> get `syn` this cycle, which will enable me to support several things,
>> including tuple structs.
>>=20
>> [1]: https://github.com/Rust-for-Linux/pin-init/issues/85
>>=20
>> > Then, due to a limitation with declarative macros, `init!` interprets
>> > `::` as a separator for generic arguments, so `bindings::GspSystemInfo=
`
>> > also doesn't parse. Here the trick is to use a local type alias.
>>=20
>> This one will also be solved when we switch to syn.
>
> I was planning to submit
> https://github.com/AsahiLinux/linux/commit/2d95fd3b6c359634a0976f27f7a3c6=
67826256da
> https://github.com/AsahiLinux/linux/commit/515638cb47cf0ebdac378686fcbbdc=
6a8364096a
> from the asahi downstream tree after 6.18-rc1. Does that still make
> sense timing wise?

Probably not, since I'll depend on the syn patches this cycle which will
mean that pin-init supports tuples in 6.19.

> Types with type paths are used extensively in the asahi driver but I can
> initially work around that.

Yeah they should be supported simply by moving to syn, hope it doesn't
introduce too much pain in the next cycle.

---
Cheers,
Benno

