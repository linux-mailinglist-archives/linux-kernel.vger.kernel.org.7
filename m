Return-Path: <linux-kernel+bounces-869879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4551C08EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E558A4EB2C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA92E9EA6;
	Sat, 25 Oct 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX/iBvtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565B2E8E00;
	Sat, 25 Oct 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761386502; cv=none; b=qBaMk34GqDLVyI7PHDHgI6kdqiu4rr5xzsxKck/s7KO7Nf6v6PeiaOTR1NF5TsNGtXTXSVd6lmP6CXz9kY0wAHYzUJSdvQFVPlvjJOemam+eE0UAz25xRpFEbLe9nuU4E2I5SakFC2Xo/X3E3eETUyMvXvhxAdkHABeYGxRIg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761386502; c=relaxed/simple;
	bh=3E7nHw8V7OYWwjNd0Xu+uiIJixZZRRqw5azWYjFeTZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=T6EjjdbORxKwKsnh+xWLuBbzyoVCYr4FLRC7q4iKfTmLXcGyHQKhr3e+u4kUzK4mSRlkg3a52Uri9KBMZUIm4lQq5TSgzCExnxBE7keHW8JSQjdXf/Aq8eMzBlbJm09/k1CgP2jRJ5rL0s/gTPQq5xSf78ilXJ4Wcr/ESbMCips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX/iBvtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7352EC4CEFF;
	Sat, 25 Oct 2025 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761386501;
	bh=3E7nHw8V7OYWwjNd0Xu+uiIJixZZRRqw5azWYjFeTZE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HX/iBvtleCf1FBOOrjFnSbkSXc03KfQ6PgjFCCUoTRVb81LQQuOZff8TZCR6ELHjZ
	 xxIQNjAvEwEo9HyjO7ecC3FqWP1NMz0lwW+u3thfVpbUH6OqFwIcO8aHF1nn6vIcXR
	 WoFZIOJYbMW8oI0Le8+VQfOTEKRrfjdBdO/1HC4QpEO4cp7fUovdI1mppeMYbRwos1
	 VAwIliZQPL6FIy0JiV5TSCVQwxCpEQT7j2sNWstMu/E26AvF+70vXooGnDuw5Lwor0
	 mGdwiakNZ5qUthPK02oGRkFI57Qodc3vZmFBqby+/N1fDQBg7KFDtFVMC9+cste767
	 VIWbVqZkrZdxg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Oct 2025 12:01:35 +0200
Message-Id: <DDRBEHGSMDFM.X7RQC8XCC7C8@kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova: add boot42 support for next-gen GPUs
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251025001459.491983-1-jhubbard@nvidia.com>
 <20251025001459.491983-3-jhubbard@nvidia.com>
In-Reply-To: <20251025001459.491983-3-jhubbard@nvidia.com>

On Sat Oct 25, 2025 at 2:14 AM CEST, John Hubbard wrote:
> +        // "next-gen" GPUs (some time after Blackwell) will zero out boo=
t0, and put the architecture
> +        // details in boot42 instead. Avoid reading boot42 unless we are=
 in that case.
> +        let boot42 =3D if boot0.is_next_gen() {
> +            Some(regs::NV_PMC_BOOT_42::read(bar))
> +        } else {
> +            None
> +        };
> +
>          try_pin_init!(Self {
>              chipset: {
> -                let chipset =3D boot0.chipset()?;
> +                // Some brief notes about boot0 and boot42, in chronolog=
ical order:
> +                //
> +                // NV04 through Volta:
> +                //
> +                //    Not supported by Nova. boot0 is necessary and suff=
icient to identify these
> +                //    GPUs. boot42 may not even exist on some of these G=
PUs.
> +                //
> +                // Turing through Blackwell:
> +                //
> +                //     Supported by both Nouveau and Nova. boot0 is stil=
l necessary and sufficient
> +                //     to identify these GPUs. boot42 exists on these GP=
Us but we don't need to use
> +                //     it.
> +                //
> +                // Future "next-gen" GPUs:
> +                //
> +                //    Only supported by Nova. Boot42 has the architectur=
e details, boot0 is zeroed
> +                //    out.
> +
> +                // NV04, the very first NVIDIA GPU to be supported on Li=
nux, is identified by a
> +                // specific bit pattern in boot0. Although Nova does not=
 support NV04 (see above),
> +                // it is possible to confuse NV04 with a "next-gen" GPU.=
 Therefore, return early if
> +                // we specifically detect NV04, thus simplifying the rem=
aining selection logic.
> +                if boot0.is_nv04() {
> +                    Err(ENODEV)?
> +                }
> +
> +                // Now that we know it is something more recent than NV0=
4, use boot42 if we
> +                // previously determined that boot42 was both valid and =
relevant, and boot0
> +                // otherwise.
> +                let (chipset, major_rev, minor_rev) =3D if let Some(boot=
42) =3D boot42 {
> +                    (
> +                        boot42.chipset()?,
> +                        boot42.major_revision(),
> +                        boot42.minor_revision(),
> +                    )
> +                } else {
> +                    // Current/older GPU: use BOOT0
> +                    (
> +                        boot0.chipset()?,
> +                        boot0.major_revision(),
> +                        boot0.minor_revision(),
> +                    )
> +                };

Why open code all of the above in the struct Gpu constructor? This could al=
l
happen within Spec::new().

If we *really* don't want to store the Spec, but only the Chipset, you can =
also
do:

	try_pin_init!(Self {
	    chipset: {
	        let spec =3D Spec::new(bar);

	        dev_info!(pdev.as_ref(), "{}\n", spec);

	        spec.chipset
	    },
	    [...],
	}

