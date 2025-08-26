Return-Path: <linux-kernel+bounces-787077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E336BB3710A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22B73672BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493112DA762;
	Tue, 26 Aug 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CiuFKZ5F"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39131A57E;
	Tue, 26 Aug 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228546; cv=pass; b=NXXya4rrT6TSn4+MxK7asXVacPGPLC4IxVxeB9vTOoLHhArPHvzhaHwmEqu2hZqK4TSF4QpsvBvpsGBQUICx6MpxQBdjJTryDwTHWTYTh85fQ4APVrEBEBjifpw/UODDCyTiu7xVQUp2iL9RaPy+IsUjydKHcLcATNcpAhHKEVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228546; c=relaxed/simple;
	bh=Sh+NjZ/naDny50Zx1WTfa2bQtHKOXqvls5rGtFfGOvM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R4V2PQG77ew9fi3awFHEkOnugMsjff5Z16WoXILfx9S8qLgCRsO4jB6WoQUuHsvg7fI2j54EpNTYihTSJlpgn2S5b90BjFp/gl8uYwMeNOZF3KGEpHBQGU4hFrsXXyFHiScJWN3GgysITUODzQFmPdzRd4fULMUr9oraHXR96vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CiuFKZ5F; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756228522; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mwK/2GGoOJgAgdZvaQMbTQJ8JOcHU+9ve3483/xga58I9kA8ElTFVrSeb+X6UlkxULWBfy9ghr+bZuhgQHjJbNjamDG6NRR0HyC/x8bZlBTRL1vrBWYyxFKXTDKhY2H27oUXikifQC7t88qT3uoFckdATgsOpxC3fwBN2iTOWb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756228522; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uqKDFBZpg+VErHO5pz8rIuMWqciIibMM6p45aamN6os=; 
	b=aETwDiLyAj1DHegJySS0wtZViiHF9OK1fDf4kI3DXkrtv524kZ2eVqO80sC7rM2MAt/HPll1llkyXIMcmFoUxpT6BA2H9E8LEzF3VB7dKi9rMEshQEBjHwAPY68bdFoo9/xUgXlY2BvxlYi0Rh+CNlQl082qAjKX+jwaFg7QCU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756228522;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=uqKDFBZpg+VErHO5pz8rIuMWqciIibMM6p45aamN6os=;
	b=CiuFKZ5FErTaHkeIKfM8s7uY5siI/lsg8SG6lYbQ339Uid4yapmNVfmikpuzGhh+
	c7+CZXo2QRv/wytp+CfLJO+ITxhe5++umkl0pNLIcVDGwejwJGirFDl2psXwXRjbOSW
	qDYt8hJ9df4TQu2nHAvYZWl+8v7+SgI+wb7IUwkM=
Received: by mx.zohomail.com with SMTPS id 1756228521125889.7134116417392;
	Tue, 26 Aug 2025 10:15:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 2/5] rust: dma: add type alias for bindings::dma_addr_t
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250825132539.122412-3-dakr@kernel.org>
Date: Tue, 26 Aug 2025 14:15:04 -0300
Cc: akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE0E1F73-69CE-4629-979E-9AE5B6AB055E@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-3-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 25 Aug 2025, at 10:24, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add a type alias for bindings::dma_addr_t (DmaAddress), such that we =
do
> not have to access bindings directly.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> drivers/gpu/nova-core/falcon.rs |  4 ++--
> rust/kernel/dma.rs              | 18 ++++++++++++++----
> 2 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/nova-core/falcon.rs =
b/drivers/gpu/nova-core/falcon.rs
> index 50437c67c14a..aa36ed8c04ed 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -4,8 +4,8 @@
>=20
> use core::ops::Deref;
> use hal::FalconHal;
> -use kernel::bindings;
> use kernel::device;
> +use kernel::dma::DmaAddress;
> use kernel::prelude::*;
> use kernel::time::Delta;
> use kernel::types::ARef;
> @@ -443,7 +443,7 @@ fn dma_wr<F: FalconFirmware<Target =3D E>>(
>                 fw.dma_handle_with_offset(load_offsets.src_start as =
usize)?,
>             ),
>         };
> -        if dma_start % bindings::dma_addr_t::from(DMA_LEN) > 0 {
> +        if dma_start % DmaAddress::from(DMA_LEN) > 0 {
>             dev_err!(
>                 self.dev,
>                 "DMA transfer start addresses must be a multiple of =
{}",
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 27b25f041f32..b2a6282876da 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -13,6 +13,16 @@
>     types::ARef,
> };
>=20
> +/// DMA address type.
> +///
> +/// Represents a bus address used for Direct Memory Access (DMA) =
operations.
> +///
> +/// This is an alias of the kernel's `dma_addr_t`, which may be `u32` =
or `u64` depending on
> +/// `CONFIG_ARCH_DMA_ADDR_T_64BIT`.
> +///
> +/// Note that this may be `u64` even on 32-bit architectures.
> +pub type DmaAddress =3D bindings::dma_addr_t;
> +
> /// Trait to be implemented by DMA capable bus devices.
> ///
> /// The [`dma::Device`](Device) trait should be implemented by bus =
specific device representations,
> @@ -343,7 +353,7 @@ fn from(direction: DataDirection) -> Self {
> // entire `CoherentAllocation` including the allocated memory itself.
> pub struct CoherentAllocation<T: AsBytes + FromBytes> {
>     dev: ARef<device::Device>,
> -    dma_handle: bindings::dma_addr_t,
> +    dma_handle: DmaAddress,
>     count: usize,
>     cpu_addr: *mut T,
>     dma_attrs: Attrs,
> @@ -444,7 +454,7 @@ pub fn start_ptr_mut(&mut self) -> *mut T {
>=20
>     /// Returns a DMA handle which may be given to the device as the =
DMA address base of
>     /// the region.
> -    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +    pub fn dma_handle(&self) -> DmaAddress {
>         self.dma_handle
>     }
>=20
> @@ -452,13 +462,13 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t =
{
>     /// device as the DMA address base of the region.
>     ///
>     /// Returns `EINVAL` if `offset` is not within the bounds of the =
allocation.
> -    pub fn dma_handle_with_offset(&self, offset: usize) -> =
Result<bindings::dma_addr_t> {
> +    pub fn dma_handle_with_offset(&self, offset: usize) -> =
Result<DmaAddress> {
>         if offset >=3D self.count {
>             Err(EINVAL)
>         } else {
>             // INVARIANT: The type invariant of `Self` guarantees that =
`size_of::<T> * count` fits
>             // into a `usize`, and `offset` is inferior to `count`.
> -            Ok(self.dma_handle + (offset * core::mem::size_of::<T>()) =
as bindings::dma_addr_t)
> +            Ok(self.dma_handle + (offset * core::mem::size_of::<T>()) =
as DmaAddress)
>         }
>     }
>=20
> --=20
> 2.51.0
>=20

Hmm, I wonder if this shouldn=E2=80=99t be its own type, instead of an =
alias. This
will be handy if we want to enforce that a given address is, in fact, a =
bus
address.

In any case, this can be a separate patch. This one is good.


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

