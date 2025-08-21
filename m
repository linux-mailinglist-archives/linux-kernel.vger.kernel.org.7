Return-Path: <linux-kernel+bounces-779716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE694B2F7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3321D6876CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBAE2D3744;
	Thu, 21 Aug 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LlldnUvb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A09258CDC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778748; cv=none; b=CGlQl9YdGUMaxS2WnCKqW0Tgzeo8j8m6sYxK+bxrRSUQkq3Zl4BVamlfBedsyjI+EkFnhIx/SxovY23OXN2deGF6bPNVSnZAIF49PLIbEGahIrWGDLheoQOKIA473mw9ixgDBwUzVcjEr3PCEyV1cYHmfNa2Vg3IKF9bKLRgfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778748; c=relaxed/simple;
	bh=bFU9XiPsxjfmEfPRcMGGVE6IuhV4+uSXPKLukn2eMZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH0Ix999awmuZF6oIabHKT5qpVuUs9/1CmuLaMPulTh0BBmlqG05TXpo9d3230/SaxxB/Ny24i71ErvLBbBIpdEmKA3orQqr/KT9QMC+SU41iXuPLM3GR62POAVZ++51kwY89pfjK106sP5w0NpPX2yWImkc2250JD7m0W763wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LlldnUvb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755778744;
	bh=bFU9XiPsxjfmEfPRcMGGVE6IuhV4+uSXPKLukn2eMZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LlldnUvbdDItwIr0fva3L0VBACLEsvOo3kfYmC7RsQ2UjHiJhshdjDobOyLxiRj95
	 axyQ4+VFtMviqwLn9VciweCumcVNmY+Y5HOivhZ+LSywkQgO0lhl6GVM1g+S6Wgt4A
	 QSxMF5m9vh6T/uluedoz7qexQNjpID8VvKl+ddoCNBlhwo2iPDiHobTVP8jKDe4Ikg
	 eOIPpy1GUjwG5d2D3RSVzUoqwq/ot2bzJI/QhiYKa+nQRKMXAy0JjRv94OT3x2j+e1
	 h45hhdqxmoERCXz988lEmo41O7MOa/iok5tILLQXsebmkDBFYchBRZpvGrbDqfa4nh
	 /8MbJjFNbkz5A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96E7317E0071;
	Thu, 21 Aug 2025 14:19:03 +0200 (CEST)
Date: Thu, 21 Aug 2025 14:18:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Caterina Shablia" <caterina.shablia@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Binns"
 <frank.binns@imgtec.com>, "Matt Coster" <matt.coster@imgtec.com>, "Karol
 Herbst" <kherbst@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Steven
 Price" <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Lucas
 De Marchi" <lucas.demarchi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <asahi@lists.linux.dev>, "Asahi Lina"
 <lina@asahilina.net>
Subject: Re: [PATCH v4 4/7] drm/gpuvm: Add a helper to check if two VA can
 be merged
Message-ID: <20250821141857.26721bd6@fedora>
In-Reply-To: <DB6240Y4VP7Y.2U5ERJO5J7F2W@kernel.org>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
	<20250707170442.1437009-5-caterina.shablia@collabora.com>
	<DB61ZHDINPNE.1VFXNF2XXSJPA@kernel.org>
	<DB6240Y4VP7Y.2U5ERJO5J7F2W@kernel.org>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Jul 2025 21:06:50 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Mon Jul 7, 2025 at 9:00 PM CEST, Danilo Krummrich wrote:
> > On Mon Jul 7, 2025 at 7:04 PM CEST, Caterina Shablia wrote:  
> >> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> >> index 05978c5c38b1..dc3c2f906400 100644
> >> --- a/drivers/gpu/drm/drm_gpuvm.c
> >> +++ b/drivers/gpu/drm/drm_gpuvm.c
> >> @@ -2098,12 +2098,48 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void *priv,
> >>  	return fn->sm_step_unmap(&op, priv);
> >>  }
> >>  
> >> +static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *a,
> >> +		      const struct drm_gpuva *b)
> >> +{
> >> +	/* Only GEM-based mappings can be merged, and they must point to
> >> +	 * the same GEM object.
> >> +	 */
> >> +	if (a->gem.obj != b->gem.obj || !a->gem.obj)
> >> +		return false;
> >> +
> >> +	/* Let's keep things simple for now and force all flags to match. */
> >> +	if (a->flags != b->flags)
> >> +		return false;  
> 
> Forgot to mention, this can include driver specific flags. How do we know from
> the generic code whether this condition makes sense? *At least* it would need to
> be documented.

You're right, it should have been:

	if ((a->flags & DRM_GPUVA_MERGEABLE_FLAGS_MASK) !=
	    (b->flags & DRM_GPUVA_MERGEABLE_FLAGS_MASK))
		return false;

with DRM_GPUVA_COMMON_FLAGS_MASK set to the set of flags that matter
when merging.

> 
> However, I think it would be better to provide an optional callback for drivers
> to check whether merge makes sense or not. This doesn't mean we need drivers to
> do those common checks, this can remain here in the common code.

Seems a bit premature to me. Again, if there's a need for drivers to add
extra checks we can always add a callback at this point, but until
this is the case, I'd rather stick to these common checks.

