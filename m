Return-Path: <linux-kernel+bounces-776902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2EB2D2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088531BA80EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C185A202F93;
	Wed, 20 Aug 2025 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="iN4wyHl4"
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D01C862E;
	Wed, 20 Aug 2025 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661859; cv=none; b=HxrgeQslzpyNFA25eawIMVhoCf4SeE9bO8kWEmbYG6ZYpe2xHmdpgG5DNLCWI1jjGQqehDD5IbnxY9DBTJ3XUxaKuI9yBFh2eOt7Sd2BP3OGVJos5wlVpTMR/T0V5WKEuhLnr2r5ro5I7bdsNzcuVKvL/qnwT8wz886dgENuG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661859; c=relaxed/simple;
	bh=CWLihZiq5DZ+BtWOx3p4ga02FpdbSI3rbYrSMDo+0Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XseMTjiiWY/NaTYL95zQnS0omuMZkIq1n/RejpxIAIfxjgbEIf19SjfUlQ0R2G0jneQzm6gdFPKhy39IBQlxa+3R0ay8Bb9Vg3F74PLWD+1JfgxRxIQZCM+mKG9AxSofjBoatnjeJTNNF6jwIHjuQiwRwydfB0URwUIE6s1VMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=iN4wyHl4; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755661849; x=1755921049;
	bh=Pcc0kL2+l9Pmm6KFyVG73R66uWz7dqU0MavY6sZy6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iN4wyHl49SXYoo53Uk5Gv10Pdv8gmbqWjP6t/XOahDK1Zd5b8JnMiAEZDhzcMfjXU
	 q2bW3kwrjQuPCaWTe/Rj5BHmxIiOB3yoXdgIh1Wu8sZ4tFT/1MK8+rxphnvzt97bLT
	 tX+lzE8NJDfAr7kc209VeF0V9HEwanB9bHCMiiYZdvIwGoyB4BtLZCqTy0gn0cITxg
	 lQ8tyIBL3cR7NgQ4x+hh0XhvauDMHZfnb/ekYLaSmkYGVij4p3dylQIGM+4now+Qlu
	 8JJmsdLsWFO2GNM7Nr60E+dEnEFRH1tPUO2p3jnGCPTZqByGRBdrJme312MutMMi7m
	 NqG6apNiGXStg==
X-Pm-Submission-Id: 4c6CCq1vDSz1DDrj
Date: Wed, 20 Aug 2025 03:50:44 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] gpu: nova-core: avoid probing non-display/compute
 PCI functions
Message-ID: <aKVGFC4UVpjyAXWO@archiso>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-3-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818013305.1089446-3-jhubbard@nvidia.com>

On Sun, Aug 17, 2025 at 06:33:04PM -0700, John Hubbard wrote:
> NovaCore has so far been too imprecise about figuring out if .probe()
> has found a supported PCI PF (Physical Function). By that I mean:
> .probe() sets up BAR0 (which involves a lot of very careful devres and
> Device<Bound> details behind the scenes). And then if it is dealing with
> a non-supported device such as the .1 audio PF on many GPUs, it fails
> out due to an unexpected BAR0 size. We have been fortunate that the BAR0
> sizes are different.
> 
> Really, we should be filtering on PCI class ID instead. These days I
> think we can confidently pick out Nova's supported PF's via PCI class
> ID. And if not, then we'll revisit.
> 
> The approach here is to filter on "Display VGA" or "Display 3D", which
> is how PCI class IDs express "this is a modern GPU's PF".
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 274989ea1fb4..4ec5b861a345 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
> +use kernel::{
> +    auxiliary, bindings, c_str, device::Core, pci, pci::Class, prelude::*, sizes::SZ_16M, sync::Arc,
> +};
>  
>  use crate::gpu::Gpu;
>  
> @@ -18,10 +20,25 @@ pub(crate) struct NovaCore {
>      PCI_TABLE,
>      MODULE_PCI_TABLE,
>      <NovaCore as pci::Driver>::IdInfo,
> -    [(
> -        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_NVIDIA, bindings::PCI_ANY_ID as u32),
> -        ()
> -    )]
> +    [
> +        // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
> +        (
> +            pci::DeviceId::from_class_and_vendor(
> +                Class::DISPLAY_VGA,
> +                Class::MASK_CLASS_SUBCLASS,
> +                bindings::PCI_VENDOR_ID_NVIDIA
> +            ),
> +            ()
> +        ),
> +        (
> +            pci::DeviceId::from_class_and_vendor(
> +                Class::DISPLAY_3D,
> +                Class::MASK_CLASS_SUBCLASS,
> +                bindings::PCI_VENDOR_ID_NVIDIA
> +            ),
> +            ()
> +        ),
> +    ]
>  );
>  
>  impl pci::Driver for NovaCore {
> -- 
> 2.50.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

