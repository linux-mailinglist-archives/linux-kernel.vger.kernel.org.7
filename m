Return-Path: <linux-kernel+bounces-845719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42EBC5ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFDDE4F9B40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E9E2BD034;
	Wed,  8 Oct 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE/MAz4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985A25EFB6;
	Wed,  8 Oct 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939316; cv=none; b=hOW3cW8Z0RE8OjW2VugRWbsXuroKwv9+Tq1VdGCOxlMAk8FdK67KAjrdX6EfPwJtrhbdjyZ7vv9ISqK46WLIDS+QcyGpSWu8ZT023SrDgD+mtjRJhTtJTbwDQy43QeVZnnArvhCnXcBUiNv05Nbnp5KOPA+++wgH/j7FYyqmoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939316; c=relaxed/simple;
	bh=Z/pj9EeEZpiRWDMECyNi+t/QOBBplB0dNcZFdOYufDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YHDJx++LnA/QDu2Anuq62e3n+NP94Id9Ygw7f3wIENKM37TzO9fQYLqBwFmqhUbDGZPdiURIIvDQNfXLPhOiBuoQ+yXD6VTPtjCEH4tdMQwp+rKVyCAtNv5bPGLOCMO/m4ZxyQoDyOb4rAPZZVs+NWK5MPInWfontPxVvkAHSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE/MAz4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22906C4CEE7;
	Wed,  8 Oct 2025 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759939316;
	bh=Z/pj9EeEZpiRWDMECyNi+t/QOBBplB0dNcZFdOYufDo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jE/MAz4+Nz4X3fT4mtJ3cMIdN4wPoZHinJvgnfIAk9QPL4FOJhWLZ4qI+oip4xdef
	 tCYXw292xXo5ZiaIMREIpNY88NFlwD52X0X+EEZh0LOWF/3IEfgwRNFacnf6Lkd3qs
	 qjB4Vs06mgAg+RBSHu6ajV1Jyu+kYwdeXna1AjhCAfCGp4m1SvJ6LlWACdxRJisT8/
	 wFxrPJPo1LI76WAghoEMLk8iMlIIc3gy0vBX5IsB4iJClG/bXIwrDLp1L27mZuBDoG
	 8IH36Zom0hPrchFgv9GMEimHKlSIJRnEaoVWTYLOrp1H8hBu1xfzCWe5Bwu33C3PwC
	 mgEOPDeIiT/JQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 18:01:50 +0200
Message-Id: <DDD2F1NSSTVN.1VDRSX5O9ZIKM@kernel.org>
Subject: Re: [PATCH v4 02/13] gpu: nova-core: Create initial Gsp
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
 <20251008001253.437911-3-apopple@nvidia.com>
In-Reply-To: <20251008001253.437911-3-apopple@nvidia.com>

On Wed Oct 8, 2025 at 2:12 AM CEST, Alistair Popple wrote:
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 221281da1a45..63099df77348 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -2,25 +2,94 @@
> =20
>  mod boot;
> =20
> +use kernel::device;
> +use kernel::dma::CoherentAllocation;
> +use kernel::dma::DmaAddress;
> +use kernel::dma_write;
> +use kernel::pci;
>  use kernel::prelude::*;
>  use kernel::ptr::Alignment;
> +use kernel::transmute::AsBytes;
> =20
>  pub(crate) use fw::{GspFwWprMeta, LibosParams};
> =20
>  mod fw;
> =20
> +use fw::LibosMemoryRegionInitArgument;
> +
>  pub(crate) const GSP_PAGE_SHIFT: usize =3D 12;
>  pub(crate) const GSP_PAGE_SIZE: usize =3D 1 << GSP_PAGE_SHIFT;
>  pub(crate) const GSP_HEAP_ALIGNMENT: Alignment =3D Alignment::new::<{ 1 =
<< 20 }>();

This looks like it could depend on the firmware version in the future, henc=
e it
should probably defined somewhere in fw/ with a corresponding comment. The
actual version switch is fine to omit for now of course (we agreed to add t=
he
infrastructure for the version switch subsequently).

> +/// Number of GSP pages to use in a RM log buffer.
> +const RM_LOG_BUFFER_NUM_PAGES: usize =3D 0x10;

Why 0x10? Is there a specific reason?

> +
>  /// GSP runtime data.
> -///
> -/// This is an empty pinned placeholder for now.
>  #[pin_data]
> -pub(crate) struct Gsp {}
> +pub(crate) struct Gsp {
> +    libos: CoherentAllocation<LibosMemoryRegionInitArgument>,
> +    pub loginit: CoherentAllocation<u8>,
> +    pub logintr: CoherentAllocation<u8>,
> +    pub logrm: CoherentAllocation<u8>,

This creates warnings for older compiler version, please use pub(crate) ins=
tead.

> +}
> +
> +#[repr(C)]
> +struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
> +/// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper=
 around it.
> +unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> =
{}

Please separate struct definitions and impl blocks with an empty line.

> +impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
> +    fn new(handle: DmaAddress) -> Self {

No check that NUM_PAGES actually fits the size of the DMA buffer handle pas=
sed
in? What happens if they do not match?

> +        let mut ptes =3D [0u64; NUM_PAGES];
> +        for (i, pte) in ptes.iter_mut().enumerate() {
> +            *pte =3D handle + ((i as u64) << GSP_PAGE_SHIFT);

I think this should be handle.checked_add(). Additionally we should add the
following compile time check to make sure that the shift can never overflow=
:

	const _MAX_OFFSET: usize =3D NUM_PAGES << GSP_PAGE_SHIFT;

> +        }
> +
> +        Self(ptes)
> +    }
> +}
> +
> +/// Creates a new `CoherentAllocation<A>` with `name` of `size` elements=
, and
> +/// register it into the `libos` object at argument position `libos_arg_=
nr`.
> +fn create_logbuffer_dma_object(
> +    dev: &device::Device<device::Bound>,
> +) -> Result<CoherentAllocation<u8>> {
> +    let mut obj =3D CoherentAllocation::<u8>::alloc_coherent(
> +        dev,
> +        RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE,
> +        GFP_KERNEL | __GFP_ZERO,
> +    )?;
> +    let ptes =3D PteArray::<RM_LOG_BUFFER_NUM_PAGES>::new(obj.dma_handle=
());
> +
> +    // SAFETY: `obj` has just been created and we are its sole user.
> +    unsafe {
> +        // Copy the self-mapping PTE at the expected location.
> +        obj.as_slice_mut(size_of::<u64>(), size_of_val(&ptes))?
> +            .copy_from_slice(ptes.as_bytes())
> +    };
> +
> +    Ok(obj)
> +}

I think we should just create a new gsp::Logbuffer type for this rather tha=
n
have a function as object constructor.

> =20
>  impl Gsp {
> -    pub(crate) fn new() -> impl PinInit<Self> {
> -        pin_init!(Self {})
> +    pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> Result<impl =
PinInit<Self, Error>> {
> +        let dev =3D pdev.as_ref();
> +        let libos =3D CoherentAllocation::<LibosMemoryRegionInitArgument=
>::alloc_coherent(
> +            dev,
> +            GSP_PAGE_SIZE / size_of::<LibosMemoryRegionInitArgument>(),
> +            GFP_KERNEL | __GFP_ZERO,
> +        )?;
> +        let loginit =3D create_logbuffer_dma_object(dev)?;
> +        dma_write!(libos[0] =3D LibosMemoryRegionInitArgument::new("LOGI=
NIT", &loginit))?;
> +        let logintr =3D create_logbuffer_dma_object(dev)?;
> +        dma_write!(libos[1] =3D LibosMemoryRegionInitArgument::new("LOGI=
NTR", &logintr))?;
> +        let logrm =3D create_logbuffer_dma_object(dev)?;
> +        dma_write!(libos[2] =3D LibosMemoryRegionInitArgument::new("LOGR=
M", &logrm))?;
> +
> +        Ok(try_pin_init!(Self {
> +            libos,
> +            loginit,
> +            logintr,
> +            logrm,
> +        }))
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 181baa401770..dd1e7fc85d85 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -7,8 +7,10 @@
> =20
>  use core::ops::Range;
> =20
> +use kernel::dma::CoherentAllocation;
>  use kernel::ptr::Alignable;
>  use kernel::sizes::SZ_1M;
> +use kernel::transmute::{AsBytes, FromBytes};
> =20
>  use crate::gpu::Chipset;
>  use crate::gsp;
> @@ -99,3 +101,40 @@ pub(crate) fn wpr_heap_size(&self, chipset: Chipset, =
fb_size: u64) -> u64 {
>  /// addresses of the GSP bootloader and firmware.
>  #[repr(transparent)]
>  pub(crate) struct GspFwWprMeta(bindings::GspFwWprMeta);
> +
> +#[repr(transparent)]
> +pub(crate) struct LibosMemoryRegionInitArgument(bindings::LibosMemoryReg=
ionInitArgument);

Please add some documentation for the type.

> +
> +// SAFETY: Padding is explicit and will not contain uninitialized data.
> +unsafe impl AsBytes for LibosMemoryRegionInitArgument {}
> +
> +// SAFETY: This struct only contains integer types for which all bit pat=
terns
> +// are valid.
> +unsafe impl FromBytes for LibosMemoryRegionInitArgument {}
> +
> +impl LibosMemoryRegionInitArgument {
> +    pub(crate) fn new<A: AsBytes + FromBytes>(
> +        name: &'static str,
> +        obj: &CoherentAllocation<A>,
> +    ) -> Self {
> +        /// Generates the `ID8` identifier required for some GSP objects=
.
> +        fn id8(name: &str) -> u64 {
> +            let mut bytes =3D [0u8; core::mem::size_of::<u64>()];
> +
> +            for (c, b) in name.bytes().rev().zip(&mut bytes) {
> +                *b =3D c;
> +            }
> +
> +            u64::from_ne_bytes(bytes)
> +        }
> +
> +        Self(bindings::LibosMemoryRegionInitArgument {
> +            id8: id8(name),
> +            pa: obj.dma_handle(),
> +            size: obj.size() as u64,
> +            kind: bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CO=
NTIGUOUS as u8,
> +            loc: bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_=
SYSMEM as u8,

Please prefer into() if possible.

