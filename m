Return-Path: <linux-kernel+bounces-812006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A09B53196
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41261B276FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6832142A;
	Thu, 11 Sep 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C6hOtEBq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807D31D759;
	Thu, 11 Sep 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591884; cv=none; b=AMstZ6X9nFS/g1dMdFJF/45HnddkocU5AcjWYQDvv3QH9SBhaANf8USSfROhfwjL4VNpIH8+R+eu2bjWsKyJfyX4PTcZeougbH/LoeDHTYtLFc6hoDT36Vhleq5YPMxjCb8GZrALrU3qiK58PP+fA3QyBl0ZJZssTfYZ9szE6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591884; c=relaxed/simple;
	bh=pcaHstFzYxqGaTfJg3M7eqTaxmtEuy1ikYgs5QwdX2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APh2Zm7HO1gXRS8Yv9jF1p+4aH5JKg3zVluu9zGLXZyZBp0yTnSROL+BeLWrUgv4piCmrk8cxpFswgJN1vFEEXBroVXD29m0Gt3VwTdcE8IoU1DlvduNigD/si9ng0U+fsTXZGhZjr1h2U7Rzxgv3nLlL5T8C2/WXXGJ4IhPKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C6hOtEBq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757591879;
	bh=pcaHstFzYxqGaTfJg3M7eqTaxmtEuy1ikYgs5QwdX2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C6hOtEBq7MSKfaphh2bb0DqY6YAg3GQqAuP48zEjPoIzUVWKFYoNSICa5EB5Aa/Cv
	 od5BczDgXxDE/OcflJ3/GYIXrMXv4zQcssG8we/Jj6EMlg0qPSrzz34J2LN/iofYGL
	 +a0wqfCslHiwEvINiAJz30muYwX70TgxM1X32sl9jmI4JoRl/Boc0rmgt/yXTvpS7c
	 PZTaGPzLHnerlEg7bUz8aID9p4PMgv2I95ydg/Ukbsfn9xEtg2+02CNDE6+5HilBXW
	 oGLE1BklAFJsynfq6oOB/NIeisktDtjy7Ys342cxq9W+L/1k4nbpeR/dFmHUKnc+um
	 RNczzzWu/j0Cw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4EA6117E0100;
	Thu, 11 Sep 2025 13:57:59 +0200 (CEST)
Date: Thu, 11 Sep 2025 13:57:46 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, "Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?="
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/gpuvm: add deferred vm_bo cleanup
Message-ID: <20250911135746.1c9cdd4b@fedora>
In-Reply-To: <aMAuGy6Rc55mkqCW@google.com>
References: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
	<20250909-vmbo-defer-v2-1-9835d7349089@google.com>
	<aMAuGy6Rc55mkqCW@google.com>
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

On Tue, 9 Sep 2025 13:39:39 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Tue, Sep 09, 2025 at 01:36:22PM +0000, Alice Ryhl wrote:
> > When using GPUVM in immediate mode, it is necessary to call
> > drm_gpuvm_unlink() from the fence signalling critical path. However,
> > unlink may call drm_gpuvm_bo_put(), which causes some challenges:
> > 
> > 1. drm_gpuvm_bo_put() often requires you to take resv locks, which you
> >    can't do from the fence signalling critical path.
> > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often going
> >    to be unsafe to call from the fence signalling critical path.
> > 
> > To solve these issues, add a deferred version of drm_gpuvm_unlink() that
> > adds the vm_bo to a deferred cleanup list, and then clean it up later.
> > 
> > The new methods take the GEMs GPUVA lock internally rather than letting
> > the caller do it because it also needs to perform an operation after
> > releasing the mutex again. This is to prevent freeing the GEM while
> > holding the mutex (more info as comments in the patch). This means that
> > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>  
> 
> I'm not sure if we came to a conclusion on the gpuva defer stuff on v1,
> but I found a less confusing way to implement the locking. Please check
> it out.

Yep, I think I prefer this version too.

