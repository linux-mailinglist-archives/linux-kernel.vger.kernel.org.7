Return-Path: <linux-kernel+bounces-890105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BACC3F39B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFCBD34D58A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96CD319859;
	Fri,  7 Nov 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZN7wrus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEE319604;
	Fri,  7 Nov 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508575; cv=none; b=pWcoxT1q+9sO7VE6A8lUex7HApYNbkVFHiWDVdip9Qn+fcbB2UXQNPhjQXmy5nVc8HS9RATEorVBAo3W0Q7qHjpz+jRW8NbBJqJDsHQN/Pc+MokL9uD7yNvK5K5dB8hpdQpoZzG2PnaakSk4vP4bg2VMO6f//DipMdVLMmXo1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508575; c=relaxed/simple;
	bh=9ZMD++yk3gyPxg7lu0dYQuNvvC4ocprc4MAaAT8RRdI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=O22GnX/Huh4nEwZoPEq6LmauHp4LTr1fmYnNitY+nFs4fLik5pggzNJLY9v6AbMkGcfYKmPvI+ZF6uAr2/Nls9uMZw2NGJbB84tXOaDtZssF3boBmBvervHlYbgXQ5A7XWLcmvqsVwaJUKjhWQmnO8kTYGdCU0LFzKbr5Un4oRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZN7wrus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965BDC2BCB3;
	Fri,  7 Nov 2025 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762508574;
	bh=9ZMD++yk3gyPxg7lu0dYQuNvvC4ocprc4MAaAT8RRdI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KZN7wrusq4dGgvNuEuNLZd49NQG5vWE9VIQqZvDmsHIytcXYjf6+MY5LpgQCsRI6h
	 1zJIMJzu8m+TX+Fhfs4wnCbr6+j0cEbGBIIq3W7mshJaKDYePwJXjUdAfQ2SFKP2I+
	 vjU+qPMy/yS7A15UxRmtNuBqu8ar4Zxaxg1xVyn9c9KrN6AYa98a/Uigyktc1/mppU
	 gNZ66Ts25R1YVd4cyF+leXMdQG87Q6vDj7YxvPLyJr41FMlfhioXgbBgu01fxQe13t
	 RETXwUI1KNiXfqM/3ZJTlWc0YQ6nHVE34250CZ68xpOJg5Elk9EbFZZOew4e+10L74
	 8YUl48XYe0vJw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Nov 2025 10:42:48 +0100
Message-Id: <DE2D56N69NP8.2X1SGEBDM92DG@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: apply the one "use" item per line
 policy
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
References: <20251107021006.434109-1-jhubbard@nvidia.com>
In-Reply-To: <20251107021006.434109-1-jhubbard@nvidia.com>

On Fri Nov 7, 2025 at 3:10 AM CET, John Hubbard wrote:
> As per [1], we need one "use" item per line, in order to reduce merge
> conflicts. Furthermore, we need a trailing ", //" in order to tell
> rustfmt(1) to leave it alone.
>
> This does that for the entire nova-core driver.
>
> [1] https://docs.kernel.org/rust/coding-guidelines.html#imports
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Thanks for doing this!

Few nits below, I assume Alex will fix them up on apply, so no need to rese=
nd.

With those fixed,

Acked-by: Danilo Krummrich <dakr@kernel.org>

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 27d9edab8347..53e718510568 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -2,16 +2,24 @@
> =20
>  use core::ops::Range;
> =20
> -use kernel::prelude::*;
> -use kernel::ptr::{Alignable, Alignment};
> -use kernel::sizes::*;
> -use kernel::sync::aref::ARef;
> -use kernel::{dev_warn, device};
> -
> -use crate::dma::DmaObject;
> -use crate::driver::Bar0;
> -use crate::gpu::Chipset;
> -use crate::regs;
> +use kernel::{
> +    dev_warn,

Should be in prelude and hence can be dropped.

> +    device,
> +    prelude::*,
> +    ptr::{
> +        Alignable,
> +        Alignment, //
> +    },
> +    sizes::*,
> +    sync::aref::ARef, //
> +};
> +
> +use crate::{
> +    dma::DmaObject,
> +    driver::Bar0,
> +    gpu::Chipset,
> +    regs, //
> +};

<snip>

> diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/fi=
rmware.rs
> index 4179a74a2342..895309132ae0 100644
> --- a/drivers/gpu/nova-core/firmware.rs
> +++ b/drivers/gpu/nova-core/firmware.rs
> @@ -3,18 +3,24 @@
>  //! Contains structures and functions dedicated to the parsing, building=
 and patching of firmwares
>  //! to be loaded into a given execution unit.
> =20
> -use core::marker::PhantomData;
> -use core::mem::size_of;
> -
> -use kernel::device;
> -use kernel::firmware;
> -use kernel::prelude::*;
> -use kernel::str::CString;
> -use kernel::transmute::FromBytes;
> -
> -use crate::dma::DmaObject;
> -use crate::falcon::FalconFirmware;
> -use crate::gpu;
> +use core::{
> +    marker::PhantomData,
> +    mem::size_of, //

Should be in prelude.

> +};
> +
> +use kernel::{
> +    device,
> +    firmware,
> +    prelude::*,
> +    str::CString,
> +    transmute::FromBytes, //
> +};
> +
> +use crate::{
> +    dma::DmaObject,
> +    falcon::FalconFirmware,
> +    gpu, //
> +};
> =20
>  pub(crate) mod booter;
>  pub(crate) mod fwsec;
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index b4ff1b17e4a0..4d2a6502a879 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -4,20 +4,38 @@
>  //! running on [`Sec2`], that is used on Turing/Ampere to load the GSP f=
irmware into the GSP falcon
>  //! (and optionally unload it through a separate firmware image).
> =20
> -use core::marker::PhantomData;
> -use core::mem::size_of;
> -use core::ops::Deref;
> -
> -use kernel::device;
> -use kernel::prelude::*;
> -use kernel::transmute::FromBytes;
> -
> -use crate::dma::DmaObject;
> -use crate::driver::Bar0;
> -use crate::falcon::sec2::Sec2;
> -use crate::falcon::{Falcon, FalconBromParams, FalconFirmware, FalconLoad=
Params, FalconLoadTarget};
> -use crate::firmware::{BinFirmware, FirmwareDmaObject, FirmwareSignature,=
 Signed, Unsigned};
> -use crate::gpu::Chipset;
> +use core::{
> +    marker::PhantomData,
> +    mem::size_of,

Same here...

> +    ops::Deref, //
> +};
> +
> +use kernel::{
> +    device,
> +    prelude::*,
> +    transmute::FromBytes, //
> +};
> +
> +use crate::{
> +    dma::DmaObject,
> +    driver::Bar0,
> +    falcon::{
> +        sec2::Sec2,
> +        Falcon,
> +        FalconBromParams,
> +        FalconFirmware,
> +        FalconLoadParams,
> +        FalconLoadTarget, //
> +    },
> +    firmware::{
> +        BinFirmware,
> +        FirmwareDmaObject,
> +        FirmwareSignature,
> +        Signed,
> +        Unsigned, //
> +    },
> +    gpu::Chipset, //
> +};

<snip>

> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 9d182bffe8b4..de87efaf09f1 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -1,13 +1,27 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -use kernel::{device, devres::Devres, error::code::*, fmt, pci, prelude::=
*, sync::Arc};
> -
> -use crate::driver::Bar0;
> -use crate::falcon::{gsp::Gsp as GspFalcon, sec2::Sec2 as Sec2Falcon, Fal=
con};
> -use crate::fb::SysmemFlush;
> -use crate::gfw;
> -use crate::gsp::Gsp;
> -use crate::regs;
> +use kernel::{
> +    device,
> +    devres::Devres,
> +    error::code::*,

That's also in prelude.

> +    fmt,
> +    pci,
> +    prelude::*,
> +    sync::Arc, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    falcon::{
> +        gsp::Gsp as GspFalcon,
> +        sec2::Sec2 as Sec2Falcon,
> +        Falcon, //
> +    },
> +    fb::SysmemFlush,
> +    gfw,
> +    gsp::Gsp,
> +    regs, //
> +};

<snip>

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index aec9166ffb45..b4711126038b 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -2,16 +2,27 @@
> =20
>  //! VBIOS extraction and parsing.
> =20
> -use crate::driver::Bar0;
> -use crate::firmware::fwsec::Bcrt30Rsa3kSignature;
> -use crate::firmware::FalconUCodeDescV3;
>  use core::convert::TryFrom;
> -use kernel::device;
> -use kernel::error::Result;
> -use kernel::prelude::*;
> -use kernel::ptr::{Alignable, Alignment};
> -use kernel::transmute::FromBytes;
> -use kernel::types::ARef;
> +
> +use kernel::{
> +    device,
> +    error::Result,

prelude

> +    prelude::*,
> +    ptr::{
> +        Alignable,
> +        Alignment, //
> +    },
> +    transmute::FromBytes,
> +    types::ARef, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    firmware::{
> +        fwsec::Bcrt30Rsa3kSignature,
> +        FalconUCodeDescV3, //
> +    }, //
> +};

