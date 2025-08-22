Return-Path: <linux-kernel+bounces-781674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B91B3155D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928411BA883A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E82E719B;
	Fri, 22 Aug 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQbflZrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463F2E3AE2;
	Fri, 22 Aug 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858340; cv=none; b=h8PO75r9JU5QPab5kbOGtZ9Ps7KQTkg2+o/9wgsC1aYvyNjgafn4w01g2ImDdIW/GFxjQ2D6wvnNkqDLuMmUpCxPHy7OXOHAOCpwtg7XvCiPJT8XZqNZsBnM9Xq33UEsUGjidEZAhQhlNit0iidqzj+xI4bsb56MoszTJpr1gSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858340; c=relaxed/simple;
	bh=3eipDB3UV6BUjIS7lwaxbO4H/ODhWWsXLvXxzUmsIok=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XMTw9nrYrrUOQ2coG3CRtVXxs6TUvNFNKgdnSoiGM6eN8La4m0Dg2FASdhuuxO9o8F3r8Of3MBmlNKx7wTieL6dF2GKacfnvaMSmUZVGRqxsNvcqkBhCefUkn4wnTCRzC3m0YOKaDlzaNVw35dBNXyQc3Pu4U6DjF0yFkyplLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQbflZrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38943C4CEED;
	Fri, 22 Aug 2025 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755858340;
	bh=3eipDB3UV6BUjIS7lwaxbO4H/ODhWWsXLvXxzUmsIok=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UQbflZrsG0DI7acJsysqxKhAY1Uk8uHRpKNB/krK9xE4EsrpRHE2XkzEb8WCPhzxq
	 S/5Y337V2804diMfBItjtmYaf9kLOg4kzmjPbKG2Didug9Nc80LfTfrvf/HeyYTbGI
	 qaIYqxUyEXWkA+tLt2nPe+cv1e5QmR4gfcqoukn77oCm+1r6sRzGYLqKqJQ0kYpf3W
	 +RYm+S85PVZozgJP4BJZTtUqVWMp115+fZrFkU5IpeX1QX9c9JhdFRgfo9pa9LMPnU
	 V7ECy9n5/OmLzymQTwuSz747J6gO3w37KK4OUOPV3Z9O+T1mkczAicLBTI2nyg8fOJ
	 1L1w6jkslUZiw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 12:25:34 +0200
Message-Id: <DC8VTZ5OZY42.1OCS3QJHZGPAK@kernel.org>
Subject: Re: [PATCH v2 3/3] gpuvm: remove gem.gpuva.lock_dep_map
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Steven Price" <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Rob Herring" <robh@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
 <20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com>
In-Reply-To: <20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com>

On Fri Aug 22, 2025 at 11:28 AM CEST, Alice Ryhl wrote:
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index 4a22b9d848f7b3d5710ca554f5b01556abf95985..598ba376b9430cdd4ab7bacdc=
15de031a887cf71 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -196,10 +196,20 @@ enum drm_gpuvm_flags {
>  	 */
>  	DRM_GPUVM_RESV_PROTECTED =3D BIT(0),
> =20
> +	/**
> +	 * @DRM_GPUVM_IMMEDIATE_MODE: use the locking scheme that makes it safe
> +	 * to modify the GPUVM during the fence signalling path

I think this isn't entirely true yet or at least can be ambiguous for now,
because it doesn't prevent users from having DRM_GPUVM_RESV_PROTECTED set, =
which
requires the DMA resv lock to destroy a struct drm_gpuvm_bo, which may happ=
en
from drm_gpuva_unlink().

So, for now, until we have the deferred drop idea in place, it also
requires DRM_GPUVM_RESV_PROTECTED to not be set.

(Eventually, we of course want both to be represented as a single flag, suc=
h
that it becomes an either or.)

I also wouldn't say "makes it safe to", but rather "makes it possible to
safely". We have no control over what the users do with the mutex. :)

NIT: missing period

> +	 *
> +	 * When set, gpuva.lock is used to protect gpuva.list in all GEM
> +	 * objects associated with this GPUVM. Otherwise, the GEMs dma-resv is
> +	 * used.
> +	 */
> +	DRM_GPUVM_IMMEDIATE_MODE =3D BIT(1),
> +
>  	/**
>  	 * @DRM_GPUVM_USERBITS: user defined bits
>  	 */
> -	DRM_GPUVM_USERBITS =3D BIT(1),
> +	DRM_GPUVM_USERBITS =3D BIT(2),
>  };

