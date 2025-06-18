Return-Path: <linux-kernel+bounces-692839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79DADF780
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019115612E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531B021ADC6;
	Wed, 18 Jun 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8eTqS6W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C621ABB0;
	Wed, 18 Jun 2025 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277677; cv=none; b=JpAjTUDf+WJ1S+C8zouUocfI2d9LlIjDJUnCgjccBaLklvQbAC6uymeefA/BN0rfwV8aCj7TXCq6i/V4V2NyJbL8COH6qt6IBI4WHPLl4FI5C31+/WA+SWDmscLj6GqqEQ3SpQza6thm4af9exZKnv/QLrLFAuBC8Rpm7sriPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277677; c=relaxed/simple;
	bh=sw9XPuoboz5Zyke7ap1VbtdqXBQ7MhGyKF3T4RxE9i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNQ/udMbJ+bC+qAXOOzOu8d9s8g3ZbEkexUUR3MNwk6VwOVNPfT1jBCDKtADmtdR5NfBTTW8rz2gn1tfFXYi1ByMm17ChTJPIcXWIfEeYYjNZr2oHDdFhHUQx9JIidNmPhCV0mLzPxKxBNPW2VKbanXLwkDplYpD3Mud0xdcwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8eTqS6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61985C4CEE7;
	Wed, 18 Jun 2025 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750277677;
	bh=sw9XPuoboz5Zyke7ap1VbtdqXBQ7MhGyKF3T4RxE9i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8eTqS6WvGvFBZrIQPLraPRlTbl0S0z0BTl8mIebLfLJ3O+wHSv8NCUXxLEHFxgik
	 6K1Wcto63lQ6YY1UAs6jphHEWg4f7ddLy1Mj86GI9kD26KJjL1Vo/vdXoyGJw6T6rm
	 BNY8PN34EBJfqGsDjVmQ5qm4zWEeQlIEU21C0wlAIsluCpOMusX849rt8HIVsCbvDa
	 U6Fd0u+8peyGlw6eZgJ3K7AhKX8HrnB9boAXpvPlIZC67NVDkwRlFogpaSh5CZI/Pl
	 /TaooLWSainf8sDgGY3D4plh+nzj823JCKWeRM6FYMZXeOsDVHpsDIgF4ES9fxh6Vl
	 8x4/tjGvjPhAQ==
Date: Wed, 18 Jun 2025 22:14:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Benno Lossin <lossin@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Shirish Baskaran <sbaskaran@nvidia.com>
Subject: Re: [PATCH v5 00/23] nova-core: run FWSEC-FRTS to perform first
 stage of GSP initialization
Message-ID: <aFMeJZuXsBRhUxJC@cassiopeiae>
References: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>

On Thu, Jun 12, 2025 at 11:01:28PM +0900, Alexandre Courbot wrote:
> Hi everyone,
> 
> The feedback on v4 has been (hopefully) addressed. I guess the main
> remaining unknown is the direction of the `num` module ; for this
> iteration, following the received feedback I have eschewed the extension
> trait and implemented the alignment functions as methods of the new
> `PowerOfTwo` type. This has the benefit of making it impossible to call
> them with undesirable (i.e. non-power of two) values. The `fls` function
> is now provided as a series of const functions for each supported type,
> generated by a macro.
> 
> It feels like the `num` module could be its own series though, so if
> there is still discussion about it, I can also extract it and implement
> the functionality we need in nova-core as local helper functions until
> it gets merged at its own pace.
> 
> As previously, this series only successfully probes Ampere GPUs, but
> support for other generations is on the way.
> 
> Upon successful probe, the driver will display the range of the WPR2
> region constructed by FWSEC-FRTS with debug priority:
> 
>   [   95.436000] NovaCore 0000:01:00.0: WPR2: 0xffc00000-0xffce0000
>   [   95.436002] NovaCore 0000:01:00.0: GPU instance built
> 
> This series is based on v6.16-rc1 with no other dependencies.

If compiled with rustc 1.78 there are missing imports of size_of() and
align_of() which break the build.

There are also a few warnings still:

warning: unreachable `pub` field
  --> drivers/gpu/nova-core/fb.rs:79:5
   |
79 |     pub fb: Range<u64>,
   |     ---^^^^^^^^^^^^^^^
   |     |
   |     help: consider restricting its visibility: `pub(crate)`
   |
   = note: requested on the command line with `-W unreachable-pub`

warning: unreachable `pub` field
  --> drivers/gpu/nova-core/fb.rs:80:5
   |
80 |     pub vga_workspace: Range<u64>,
   |     ---^^^^^^^^^^^^^^^^^^^^^^^^^^
   |     |
   |     help: consider restricting its visibility: `pub(crate)`

warning: unreachable `pub` field
  --> drivers/gpu/nova-core/fb.rs:81:5
   |
81 |     pub frts: Range<u64>,
   |     ---^^^^^^^^^^^^^^^^^
   |     |
   |     help: consider restricting its visibility: `pub(crate)`

warning: 3 warnings emitted

