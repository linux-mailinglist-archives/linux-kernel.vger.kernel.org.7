Return-Path: <linux-kernel+bounces-873750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD3C149D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6914F7C53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593F32D421;
	Tue, 28 Oct 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkCkaKgU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE572D7D47;
	Tue, 28 Oct 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654336; cv=none; b=Ysga3/FQNaSteOXsxz5pQ++yGR3u4VbsqgUUxFw1sfLIEGWEka/JGR5Wsr+5vQHxrINfruaiNXerM9Pxl3o7aEWMieVkqBkMLGtlbbBMlpvMoEnvgHIWh2I7TYLYgdhBcMeBSowA3lkug5vNpn9BuzEgdi0SdjWcRnnvws2Pii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654336; c=relaxed/simple;
	bh=O3rrBgUppSWO5V6RBh3WFUXiqJ2WOAiNVe9eUEytpLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jiXkhfK3EK0JOxUCiQu4uOyAjahGXYcjrrDFCW6+je/KpPpR6sSqik/zZZIY3xgtyQQIYRBp47xd4XdBR+BilGkbxbQa4Wc+X6VbpCQhOmd0Yj5+QhtsCRKKlUB5M9Dg7CQKjndj6iVvEn3QzVFL7EtOpgKeNcVnXFfqE7YttvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkCkaKgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D242C4CEE7;
	Tue, 28 Oct 2025 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654336;
	bh=O3rrBgUppSWO5V6RBh3WFUXiqJ2WOAiNVe9eUEytpLs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nkCkaKgUtJmi0jENBGtAEa7GZdUeq8CF1abVMc663PiYN+cAyRA/JvQKcIlZ5F+wb
	 E6FfvhpsuHBryNfWCH1P0bMxVDRYeX+BFhH4fGTD56fJTplRK61O3Mf9gkUjqaKKsd
	 0qXX8YDk/R28atBJEPF3I887qTNTqvLDugOkbCDSX/Xc+mOLeal8dx3nGg46FXQc/T
	 lY0LxHgRHO0usuNdOOi21sZaBILsS49bNEhOOYvaeE2r7JftuSV4aC5w9Wklcn8LCJ
	 SnjXF8AoetwDCUGiWaOYmHH4OJ8/p4HyygyUoQ3PfkqA4T/qvmC6I/NTcuLkdBTIqf
	 1rVnVf9aVXnnA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 13:25:30 +0100
Message-Id: <DDTYCAZWUZL5.36Y1LKLB8EUD6@kernel.org>
Subject: Re: [PATCH v2 1/2] gpu: nova-core: merge the Revision type into the
 Spec type
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
References: <20251028023937.1313108-1-jhubbard@nvidia.com>
 <20251028023937.1313108-2-jhubbard@nvidia.com>
In-Reply-To: <20251028023937.1313108-2-jhubbard@nvidia.com>

On Tue Oct 28, 2025 at 3:39 AM CET, John Hubbard wrote:
> -pub(crate) struct Revision {
> -    major: u8,
> -    minor: u8,
> -}
> -
> -impl Revision {
> -    fn from_boot0(boot0: regs::NV_PMC_BOOT_0) -> Self {
> -        Self {
> -            major: boot0.major_revision(),
> -            minor: boot0.minor_revision(),
> -        }
> -    }
> -}
> -
> -impl fmt::Display for Revision {
> -    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> -        write!(f, "{:x}.{:x}", self.major, self.minor)
> -    }
> -}
> -
> -/// Structure holding the metadata of the GPU.
> +/// Structure holding a basic description of the GPU: Architecture, Chip=
set and Revision.
>  pub(crate) struct Spec {
>      chipset: Chipset,
> -    /// The revision of the chipset.
> -    revision: Revision,
> +    major_revision: u8,
> +    minor_revision: u8,
>  }

Why not keep the Revision type and its Display impl as well?

> =20
>  impl Spec {
> @@ -162,11 +142,25 @@ fn new(bar: &Bar0) -> Result<Spec> {
> =20
>          Ok(Self {
>              chipset: boot0.chipset()?,
> -            revision: Revision::from_boot0(boot0),
> +            major_revision: boot0.major_revision(),
> +            minor_revision: boot0.minor_revision(),
>          })
>      }
>  }
> =20
> +impl fmt::Display for Spec {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(
> +            f,
> +            "Chipset: {}, Architecture: {:?}, Revision: {:x}.{:x}",
> +            self.chipset,
> +            self.chipset.arch(),
> +            self.major_revision,
> +            self.minor_revision
> +        )

This could just be:

	write!(
	    f,
	    "Chipset: {}, Architecture: {:?}, Revision: {}",
	    self.chipset,
	    self.chipset.arch(),
	    self.revision,
	)

> +    }
> +}
> +
>  /// Structure holding the resources required to operate the GPU.
>  #[pin_data]
>  pub(crate) struct Gpu {
> @@ -193,13 +187,7 @@ pub(crate) fn new<'a>(
>      ) -> impl PinInit<Self, Error> + 'a {
>          try_pin_init!(Self {
>              spec: Spec::new(bar).inspect(|spec| {
> -                dev_info!(
> -                    pdev.as_ref(),
> -                    "NVIDIA (Chipset: {}, Architecture: {:?}, Revision: =
{})\n",
> -                    spec.chipset,
> -                    spec.chipset.arch(),
> -                    spec.revision
> -                );
> +                dev_info!(pdev.as_ref(),"NVIDIA ({})\n", spec);
>              })?,
> =20
>              // We must wait for GFW_BOOT completion before doing any sig=
nificant setup on the GPU.
> --=20
> 2.51.1


