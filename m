Return-Path: <linux-kernel+bounces-789615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67928B39849
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D3F7B28DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5822F290A;
	Thu, 28 Aug 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMTyq+k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8562E229E;
	Thu, 28 Aug 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373258; cv=none; b=f2Frc3uMmK2ETn30M2KF98U0YdDP26btcsjQ4L8o4RQZ/6Bk5Vdw2XPnX3zS4keB1bO5NqL/CgjEYIwx1t6N/EkBhRe8BRbHB3vfptDjmqwDlteqm4HUG7WvYuImRV0N4PvUGFawZcpGK6rOM308xxopodWDZojbeR2ZSCgEaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373258; c=relaxed/simple;
	bh=r/M9f7QJp9Hkjjyl4KwvKc1dnUJA0dXw9egGgYD0RgI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gBQ01x0YOARoI0PDEr1rYCkRT/zl0zRbF+lPfMyZ3SUYb1hv2xGww/iP9z59o4MqZ5gbAVrBsG+CIhHZjLJTeoTZVXeYLx5+eTWd4ywHREXwgsPzXetrj6LM/75ILSPYnpeMARoU35gcBdZz3cGrj3dH7lm2cCpstY8I7I9kaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMTyq+k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC04C4CEF4;
	Thu, 28 Aug 2025 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756373258;
	bh=r/M9f7QJp9Hkjjyl4KwvKc1dnUJA0dXw9egGgYD0RgI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WMTyq+k2jCs5omx99TLS9vPAOlxhd6rtCZ68Eu+MheAwiGYH54rebvMyh6HMQIFDI
	 f5OZ9weYfDXvjRPDubWjfohiH4s4EEurx6tdQwozVtMQza8EWO0B1/1b/GSGd7ixuY
	 CueaEXLUO8eRXGUta8R8zgVjaSPYZR5GD/xKanv4Kgmv43iAsdqeg+NWh5sQQvgsZl
	 3lDeAH0ISnZTB9EWFS4BjWr5HFeVoGGkeV8wCRSaQyIV1zyxujJfHe6mmywkGTyCv+
	 t2l42e7+90zXuqpP/AgdqDukvL6jYCEs0XVHdO+jZwsVQZfS8Ny0wAVbOX/sTrvjr+
	 FCDfYs4tL7tGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 11:27:32 +0200
Message-Id: <DCDYCT8QSYGM.XIKU6FJ1ESAQ@kernel.org>
Subject: Re: [PATCH v3 3/3] gpuvm: remove gem.gpuva.lock_dep_map
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
References: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
 <20250827-gpuva-mutex-in-gem-v3-3-bd89f5a82c0d@google.com>
In-Reply-To: <20250827-gpuva-mutex-in-gem-v3-3-bd89f5a82c0d@google.com>

On Wed Aug 27, 2025 at 3:38 PM CEST, Alice Ryhl wrote:
>  #ifdef CONFIG_LOCKDEP
> -/**
> - * drm_gem_gpuva_set_lock() - Set the lock protecting accesses to the gp=
uva list.
> - * @obj: the &drm_gem_object
> - * @lock: the lock used to protect the gpuva list. The locking primitive
> - * must contain a dep_map field.
> - *
> - * Call this if you're not proctecting access to the gpuva list with the
> - * dma-resv lock, but with a custom lock.
> - */
> -#define drm_gem_gpuva_set_lock(obj, lock) \
> -	if (!WARN((obj)->gpuva.lock_dep_map, \
> -		  "GEM GPUVA lock should be set only once.")) \
> -		(obj)->gpuva.lock_dep_map =3D &(lock)->dep_map
> -#define drm_gem_gpuva_assert_lock_held(obj) \
> -	lockdep_assert((obj)->gpuva.lock_dep_map ? \
> -		       lock_is_held((obj)->gpuva.lock_dep_map) : \
> +#define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
> +	lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
> +		       lock_is_held(&(obj)->gpuva.lock.dep_map) : \

NIT: I think this can just be:

	lockdep_is_held(&(obj)->gpuva.lock)

If you want I can fix it up on apply.

>  		       dma_resv_held((obj)->resv))
>  #else
> -#define drm_gem_gpuva_set_lock(obj, lock) do {} while (0)
> -#define drm_gem_gpuva_assert_lock_held(obj) do {} while (0)
> +#define drm_gem_gpuva_assert_lock_held(gpuvm, obj) do {} while (0)
>  #endif

