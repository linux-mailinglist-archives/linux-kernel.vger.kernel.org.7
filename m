Return-Path: <linux-kernel+bounces-772323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5126B29139
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AB22086D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D781C1F12;
	Sun, 17 Aug 2025 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="BA4K8ktN"
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C12EEA8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755399310; cv=none; b=ezlLtSNHLs1BkhGrlGgGkRLRVT5/2R7r5lKXzY13e4Rl7/UEHtO0+6YPIj/4QoR5QuHtPqSqQ6b9Vv1Dl3beFofBXwUWTT7DXYJLgLVcYorWtWLZw4jH2LSeEwmhrgNZTaamozHPmsyOGmOFsCctXOsqlMcSIaZmJByPf2zGeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755399310; c=relaxed/simple;
	bh=xiHb5R2Xz2iisIz0D4Ww8xTzFkbohh3hOxPIBl+HOfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooCXHPNeaGgrDkH348g7cN6grrd0cBlXCXDy+SeFvralSfAffoh79EKzlnYc3MWh3u/8x6GwgzuSepfcDiZJ2GQnMHcJaGu7/mWnQoKigYCNY8CIfy6FMWoCsmGOPwfUJDY1JHM/oT2DH8Hf5VjoCMBZAkdvdlBKp0TkSP3e9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=BA4K8ktN; arc=none smtp.client-ip=185.70.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755398901; x=1755658101;
	bh=4f14UHlASZVUziWFh99eMbEfCZAlv2WbhRYGxjgiuL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BA4K8ktN9i5BjeG7AC459t4GXzCSXO4vC75Horq/n5W5tPWHGp82zyk69DWbh5uPH
	 jip6JjTvzvH6oB/PmUSFJrN6vtjixZuAA+jVE5QeLv+G2raH7Y+H6V3aQvs11Pt/3e
	 fAEjRnR5VNRTJ0W6/XwmLLRpT+HoaQzlomAzaQ0rMuy783vo4C4iPY9JNHplTXmFCg
	 53MSuiubawv5FDAHAyLayYz7H+Xz478WcN3iMUrZxljBe9tQVy5QViOfIb7z7mkFEq
	 TOFBqeGfpJB9wYoNZBlHwGL5PqbYMjO6nWkXiEAhubATe666MKpbbcGz8WSfMHePeg
	 MZTaZuAc1uu4A==
X-Pm-Submission-Id: 4c4Kz75Lzpz1DDL2
Date: Sun, 17 Aug 2025 02:48:17 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: drm: update ARef and AlwaysRefCounted imports from
 sync::aref
Message-ID: <aKFBdMOHxlvTOmPn@archiso>
References: <20250815161706.1324860-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815161706.1324860-1-shankari.ak0208@gmail.com>

On Fri, Aug 15, 2025 at 09:47:06PM +0530, Shankari Anand wrote:
> Update call sites in drm to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintenance.
> 
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> 
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/drm/device.rs  | 3 ++-
>  rust/kernel/drm/driver.rs  | 2 +-
>  rust/kernel/drm/gem/mod.rs | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 3bb7c83966cf..4a62f9fd88b7 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -10,7 +10,8 @@
>      error::from_err_ptr,
>      error::Result,
>      prelude::*,
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::Opaque,
>  };
>  use core::{mem, ops::Deref, ptr, ptr::NonNull};
>  
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index fe7e8d06961a..8fefae41bcc6 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -8,7 +8,7 @@
>      bindings, device, devres, drm,
>      error::{to_result, Result},
>      prelude::*,
> -    types::ARef,
> +    sync::aref::ARef,
>  };
>  use macros::vtable;
>  
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index b71821cfb5ea..a822aedee949 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -10,7 +10,8 @@
>      drm::driver::{AllocImpl, AllocOps},
>      error::{to_result, Result},
>      prelude::*,
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::Opaque,
>  };
>  use core::{mem, ops::Deref, ptr::NonNull};
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

