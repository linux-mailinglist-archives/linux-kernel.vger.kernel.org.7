Return-Path: <linux-kernel+bounces-845306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18EBC4526
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A5744E9D75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011029B8D3;
	Wed,  8 Oct 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqqNoT/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A51183CA6;
	Wed,  8 Oct 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919432; cv=none; b=or2ZolMw+0TRxoJ2ol4jDdNIEnh2zWIWAhNVoyVaGs5MKoKyk1zZf6Ypbx5oCn+IilOf3GYDRCxie64xwFS8Wv8KJMXliA0BmFRS68pYb7wMoBTJERcQNk7fW4491MnvApURRFnvhDTr0Pm4J0F+KP8EimQCacUiiVZXWj+Kn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919432; c=relaxed/simple;
	bh=AXcMqvG7cWe67YMt9/vHX2AYm8W1c2Xwkevu9/LVcgA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D+/0UwSN5K4Au3LlK2Tg9CZR9HkVNOu+X3rpGR4ANUYyqjWeCcVdbBGV6nucnZ5Vdya94J3d1kDramimVTdbkMYpYuFTJ426T7r+41hZnZE17CF8xlY+AsMLll8VA45inUyU/3n5kgt5mxSX5839YHz8MOCOL9fwPQbnU4qyFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqqNoT/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD1C4CEF4;
	Wed,  8 Oct 2025 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759919432;
	bh=AXcMqvG7cWe67YMt9/vHX2AYm8W1c2Xwkevu9/LVcgA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iqqNoT/aMi/YEka2R9fqbhXzM6g7OQ3F8JZv1/EXkGXevjj/VkdLMnjYD8rnf59gn
	 cTTPtm9/zxzcMRCP4HZk7f7lJeLzBXK8s4F2/Iif/dIusIkQP/2IuvttpkdhVGym0J
	 pti/VdjbRO9en5lKB2V9n/4I3Ay5MkN0W/+7LGUJdQCHqU+uTWCcngcGkko7gxf6ih
	 CMqjKg8iOzBDIxin/1aEHaGV7uuXfO6tTDN+Qr4OS80WOjJsHpqjtBRM759svJ3Vss
	 Qz5etPE9MLXJLKor7BByDjHbJM4z2mtoFrfLnRonF9NGv5WdqEmFtDNfcigUIbbjSb
	 USRw9mZj8hUNw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 12:30:25 +0200
Message-Id: <DDCVDASJNW9T.BUT6XK1WXD0A@kernel.org>
Subject: Re: [PATCH v4 01/13] gpu: nova-core: Set correct DMA mask
Cc: <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <acourbot@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251008001253.437911-1-apopple@nvidia.com>
 <20251008001253.437911-2-apopple@nvidia.com>
In-Reply-To: <20251008001253.437911-2-apopple@nvidia.com>

On Wed Oct 8, 2025 at 2:12 AM CEST, Alistair Popple wrote:
> Set the correct DMA mask. Without this DMA will fail on some setups.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>
> ---
>
> Changes for v4:
>  - Use a const (GPU_DMA_BITS) instead of a magic number
>
> Changes for v2:
>  - Update DMA mask to correct value for Ampere/Turing (47 bits)
> ---
>  drivers/gpu/nova-core/driver.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index edc72052e27a..84fe4a45eb6a 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -3,6 +3,8 @@
>  use kernel::{
>      auxiliary, c_str,
>      device::Core,
> +    dma::Device,
> +    dma::DmaMask,
>      pci,
>      pci::{Class, ClassMask, Vendor},
>      prelude::*,
> @@ -20,6 +22,10 @@ pub(crate) struct NovaCore {
>  }
> =20
>  const BAR0_SIZE: usize =3D SZ_16M;
> +
> +// For now we only support Ampere which can use up to 47-bit DMA address=
es.
> +const GPU_DMA_BITS: u32 =3D 47;

IIRC, the idea was to abstract this properly with a subsequent patch worked=
 on
by John. In that case, please add a TODO.

>  pub(crate) type Bar0 =3D pci::Bar<BAR0_SIZE>;
> =20
>  kernel::pci_device_table!(
> @@ -57,6 +63,9 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo=
) -> Result<Pin<KBox<Self
>          pdev.enable_device_mem()?;
>          pdev.set_master();
> =20
> +        // SAFETY: No DMA allocations have been made yet

I think you forgot to address my comment from v2:

	It's not really about DMA allocations that have been made previously, ther=
e is
	no unsafe behavior in that.
=09
	It's about the method must not be called concurrently with any DMA allocat=
ion or
	mapping primitives.
=09
	Can you please adjust the comment correspondingly?

In general, I recommend having a look at the safety requirements of the
corresponding function.

NIT: Please end with a period.

> +        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_DMA_B=
ITS>())? };
> +
>          let devres_bar =3D Arc::pin_init(
>              pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/ba=
r0")),
>              GFP_KERNEL,
> --=20
> 2.50.1


