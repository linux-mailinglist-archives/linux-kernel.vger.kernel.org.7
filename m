Return-Path: <linux-kernel+bounces-750839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F06B161A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB0F7A3AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A22D46CA;
	Wed, 30 Jul 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Cd3pxApB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84485293454;
	Wed, 30 Jul 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882638; cv=pass; b=JRyWkOrxy6EIngV1dLcYDdWV0UdRf0hawXZB08XbCrnSJUaGa25GU17JmPDmz+EAlJCwyaUBrzpb28yIQ3g3aua4tUetxOUXC4FkB61MSEEKjXVXOk9DRgSEoeXx2/SqlV+RDGjb7d3TCLJSxowslNNELEGSG+aecR8/EBN4T1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882638; c=relaxed/simple;
	bh=0KmMvxy+SwDmjTd5hYeEPgp70c7lySC5m8i2ZH16PSM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sfZUel6CT//inmt6nMtE8AUV+4JJWZpbtUyHTtiItvOEQjY0B/K5WmaStU5TqcDPjXq6pNS8huDhpnWDl8VLwK18a8aQvw+7rtortTXmLzs2W7zHeIPER4zZz5MBISOM5DKzMcl8UWd9rge3rBR4uI5e2Vc4HE1acwXYLdYoqvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Cd3pxApB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753882611; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KeGIAGDAWludj9s2OsBdrrpPcSWLcy/g6IcjI2qEQumzqvim3m0+G5U7zV7FiK/mOzBgOJNkz7kIKeZ49zTzg03nu97CuV45VQa30koNkQOl8zlsxHUlK2jFKDDYAljNgotAtb3sKOH878EkJQgpF/R1reW6UCALridvm2cpOWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753882611; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ipBuX+007QmZGVBwckpwz4LW/7znlRX+ZLBlKNFcy5A=; 
	b=J/ZEP3VHk8nmnH6k2vfTzTwFl+F2gxWoxYKo1chVvFgh5rRwjGekMPhVMz/olxLfL7H9vDFMb6ogFOyBmREVtvqvpOua0wSu7qXUNAYys/KqKeo37I33JpIm1TvkLKb1ykph41RW9lDxsPMOEF50hbMhPigm3qMFO/1rOO1xCDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753882611;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ipBuX+007QmZGVBwckpwz4LW/7znlRX+ZLBlKNFcy5A=;
	b=Cd3pxApBJw0djL6h99BVSWsO9A9AWTc/OwKTpEyNOcnPgGsKbcdtPZl4LPotcWsU
	pHMcLpg0/FBAdfZM6MEW/nowl/7f9nNCclIPLvgsXZSgy2EUx8UgyGq3C5/4VsXT5XX
	1M6ZOA84lCqZ6YzylpwMZr74fCcBfirrXRc7pCBc=
Received: by mx.zohomail.com with SMTPS id 1753882609215993.1319746622694;
	Wed, 30 Jul 2025 06:36:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 0/3] Fix broken `srctree/` links and warn about them
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250730130716.3278285-1-ojeda@kernel.org>
Date: Wed, 30 Jul 2025 10:36:33 -0300
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CCB36E4-4C5D-4E2F-BC58-255770AA4904@collabora.com>
References: <20250730130716.3278285-1-ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Miguel, this is indeed nice!

> On 30 Jul 2025, at 10:07, Miguel Ojeda <ojeda@kernel.org> wrote:
>=20
> This fixes a handful of broken links and introduces a warning to
> prevent them from happening in the future.
>=20
> Relatedly, we could also perhaps check the other side of the links, =
but
> perhaps there are cases we want to customize. Alternatively, we could
> also in the future introduce custom syntax for these that avoids
> repetition or a fancier preprocessing step.
>=20
> Miguel Ojeda (3):
>  rust: block: fix `srctree/` links
>  rust: drm: fix `srctree/` links
>  rust: warn if `srctree/` links do not exist
>=20
> rust/Makefile                    | 6 ++++++
> rust/kernel/block/mq/gen_disk.rs | 2 +-
> rust/kernel/drm/device.rs        | 2 +-
> rust/kernel/drm/driver.rs        | 2 +-
> rust/kernel/drm/file.rs          | 2 +-
> rust/kernel/drm/gem/mod.rs       | 2 +-
> rust/kernel/drm/ioctl.rs         | 2 +-
> 7 files changed, 12 insertions(+), 6 deletions(-)
>=20
> =E2=80=94
> 2.50.1

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Patch 3 alone indeed produces the following warnings:

warning: srctree/ link to include/linux/blk_mq.h does not exist
warning: srctree/ link to include/linux/drm/drm_device.h does not exist
warning: srctree/ link to include/linux/drm/drm_ioctl.h does not exist
warning: srctree/ link to include/linux/drm/drm_file.h does not exist
warning: srctree/ link to include/linux/drm/drm_drv.h does not exist
warning: srctree/ link to include/linux/drm/drm_gem.h does not exist

So you can add my Tested-by for that one.

Cheers,
=E2=80=94 Daniel=

