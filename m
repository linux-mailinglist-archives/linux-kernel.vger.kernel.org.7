Return-Path: <linux-kernel+bounces-845295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4070CBC44C6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE3A9350229
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A62C2F5A3F;
	Wed,  8 Oct 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS8v4XQi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C82F5A28;
	Wed,  8 Oct 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919029; cv=none; b=k8hw0FW0Qty+brCPR7fWllABpA2dw30s6WwSi87Rxb8jGO0i/uHsUZjA48tDD43BwptwDU63V1nkpiZS93X6sZPVkx8Jj4LE2kGtr9htuTOYuHVG3mf05RKQSOYHs+rdSe/8/OhKWT1OeaKqcGzuJhga/HxN1TVgwfszvBUyj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919029; c=relaxed/simple;
	bh=pgyDd5U4lx90hBvX9nM6Mbf+EYCdvQf0+HPHy40vgt8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OQ6aPlHgggx3HnIy9uKt50dIFjDSa9Pe1UVHLsCrDn/EyKcBIACPFO1nBsbebI7I8mA61AAsDWs0vrd65FtTDVU7sIh26O5kEI2yhWBO4NY1f6nGBCwHeeaXoWvSN/YDft7WF/RNQvIS0NcUTyyxfslrFzsghsFZu19zHPoj2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS8v4XQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29291C4CEF4;
	Wed,  8 Oct 2025 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759919027;
	bh=pgyDd5U4lx90hBvX9nM6Mbf+EYCdvQf0+HPHy40vgt8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mS8v4XQiuMI+8/hdm6D67HTsv1lFRpRqd/9dRgiHCxvNhfGJGffAnfXAyBU3f1KF4
	 B+UnqCXC9/h9TkG8O9cV6GDttVb0OzlwKlnXZ2oyTsxn62YX++8u0zrsFjvSL/9fNC
	 yLK8DnXfSEnCCg4ZPFT/WChXNGS+7N0Z+DeUrhF6Ap+7DkD1GUibu7rNr3FAh0cp4F
	 ywYU+xVIL85CcLiofN7oZKB2g4vpo0hyWk6foZJygmi0aymK1mmahHFQJ5ieY2dVfS
	 1n/MiYDhJfv4gmQ2s5L5F3AmGTToHgoSPiSaP4FBDtEStM8KSqboEWwyobwR4Zr7Pf
	 NdWDLDJHhQylA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 12:23:40 +0200
Message-Id: <DDCV84IJHUML.126CB1CT0XMX5@kernel.org>
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Alistair Popple" <apopple@nvidia.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Andrea Righi" <arighi@nvidia.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <695CCDCE-A205-4557-AA15-6F102B8CCF0C@nvidia.com>
In-Reply-To: <695CCDCE-A205-4557-AA15-6F102B8CCF0C@nvidia.com>

On Wed Oct 8, 2025 at 1:37 AM CEST, Joel Fernandes wrote:
> The Nvidia GPU architecture is little-endian (including MMU structures in=
 VRAM).

Yes, I'm aware (and I'd assume that there is no reason to ever change that)=
.

Just for the complete picture, there's also some endianness switch in the
NV_PMC_BOOT_1 register I think?

> All the CPU architectures our drivers support are expected to be little-e=
ndian.

Technically, all Rust supported architectures are indeed little-endian.

However, the only constraint for the Nova project as by now is 64-bit only.

