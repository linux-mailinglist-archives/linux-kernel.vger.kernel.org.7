Return-Path: <linux-kernel+bounces-797266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C977B40E24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB421B65571
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88D34F494;
	Tue,  2 Sep 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCW3q19f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1D26C3A5;
	Tue,  2 Sep 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842799; cv=none; b=sGlse85mCSsK/UHwWeA9ZV4rXdk5oiFXhpE3YlZHiChb8h26y9HE1TwIzkH21bBzQLD7x9mnUJ+DZWkeSiHQncpmFuTrJoRWovk7q6wjmKRCvLXYD1LRnhNSNg7/QUTpa/i9uIxEBKKzTAtUBgoBBmm3UuxijER+H3kpWAU8EWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842799; c=relaxed/simple;
	bh=EES9E4p0II9pKq1UKkB0kITaMd3S6hMDx8aHEP9YBYM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=qKSJukQF5H7st5IMVtCO/uYTjw2TxzQozhpmiQytKtIKEYe4D9FrN/0KocvnGF2Cwf1f9RfCa636omUIpjhOzT75/H1/CCERtJs9kkRrIFPMxWXNs9bxTDpTph1iAWvVIUE+yZ64scLEs8IwFc/JM4pTOqo0ckqDJD8Q+C56vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCW3q19f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAF6C4CEED;
	Tue,  2 Sep 2025 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756842798;
	bh=EES9E4p0II9pKq1UKkB0kITaMd3S6hMDx8aHEP9YBYM=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=CCW3q19f1yy6u796iT5OMmZJMQLz+bWmn4U6nlUY7VzI2NWzyHxVfjszhxKJ93DmH
	 ci8C/CpnQ5DDiJLgd0Q82xyrht1moay6Tn+b29iioYmVATBhO3UiDJ+yRVSBkmhSf/
	 aNcG9zBu6bQpx7D4GL+hFKD50p6ue0RUxM8Rb6uTuLTDRT2adLnXhJQqRTIyl+md46
	 ybLvLczL+ZeDR5e0Nb3f/1QyIQVX6Ow4VY5+gMGwOpbCvMS98XakCbuSiB4zsFDg+m
	 kQFCbyjmGMUl+xAnJ/J4IBXXqtBKmBXqZn8emdVArub4WIhnBs/xk5elo0IQ/kz/+u
	 lmO2IXDyaNg2Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 21:53:12 +0200
Message-Id: <DCIKSL18GE9A.2R4BAGR56YVPF@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 02/11] gpu: nova-core: move GSP boot code out of
 `Gpu` constructor
References: <20250902-nova_firmware-v3-0-56854d9c5398@nvidia.com>
 <20250902-nova_firmware-v3-2-56854d9c5398@nvidia.com>
In-Reply-To: <20250902-nova_firmware-v3-2-56854d9c5398@nvidia.com>

On Tue Sep 2, 2025 at 4:31 PM CEST, Alexandre Courbot wrote:
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 274989ea1fb4a5e3e6678a08920ddc76d2809ab2..1062014c0a488e959379f009c=
2e8029ffaa1e2f8 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -6,6 +6,8 @@
> =20
>  #[pin_data]
>  pub(crate) struct NovaCore {
> +    // Placeholder for the real `Gsp` object once it is built.
> +    pub(crate) gsp: (),
>      #[pin]
>      pub(crate) gpu: Gpu,
>      _reg: auxiliary::Registration,
> @@ -40,8 +42,14 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInf=
o) -> Result<Pin<KBox<Self
>          )?;
> =20
>          let this =3D KBox::pin_init(
> -            try_pin_init!(Self {
> +            try_pin_init!(&this in Self {
>                  gpu <- Gpu::new(pdev, bar)?,
> +                gsp <- {
> +                    // SAFETY: `this.gpu` is initialized to a valid valu=
e.
> +                    let gpu =3D unsafe { &(*this.as_ptr()).gpu };
> +
> +                    gpu.start_gsp(pdev)?
> +                },

Please use pin_chain() [1] for this.

More in general, unsafe code should be the absolute last resort. If we add =
new
unsafe code I'd love to see a comment justifying why there's no other way t=
han
using unsafe code for this, as we agreed in [2].

I did a quick grep on this series and I see 21 occurrences of "unsafe", if =
I
substract the ones for annotations and for FromBytes impls, it's still 9 ne=
w
ones. :(

Do we really need all of them?

Otherwise, I really like this, it's a great improvement over initializing
everything into the Gpu struct -- thanks for the refactoring!

[1] https://rust.docs.kernel.org/kernel/prelude/trait.PinInit.html#method.p=
in_chain
[2] https://docs.kernel.org/gpu/nova/guidelines.html#language

