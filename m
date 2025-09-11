Return-Path: <linux-kernel+bounces-812008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB48B531A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B26487690
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842131D381;
	Thu, 11 Sep 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yqx60noG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E12E6CD4;
	Thu, 11 Sep 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592066; cv=none; b=SsMZKRLXbdP34RQLr4wQAlOBfHfzAlc1e8aOI2APQWQlfXsEeDxlfOoA3npJE379Ojk6tNFYylnuJwHi0twuBIZjb+nHfHXwYJgd/NDSGUkXs0Tc7PP8W/SHyFmn3+kodkOLXaGf8v1vTgQ7ubCuKffcKs2CsPY02M/X9kM6oo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592066; c=relaxed/simple;
	bh=pcaHstFzYxqGaTfJg3M7eqTaxmtEuy1ikYgs5QwdX2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQeRzkJWgrqYK0oGm6QwQUXs0lGUSMPzBTBCW8mCfNk7x6gUS/R0qvqWTZGnuksWhbZJxxr+cydY3wuOoGsezkPFfvDbtuZf5So7DvfpYwqjFkoBYGV2udzHP0a80UR6llUOAQWnYAdTu+dUwwHxMalVqTfnO+KLHque4nV06js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yqx60noG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757592062;
	bh=pcaHstFzYxqGaTfJg3M7eqTaxmtEuy1ikYgs5QwdX2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yqx60noGx/UImP7ay1n8DUyqf7rs/kFaCgaJusroLlAFLqO8CcIh5N69BuKbit17T
	 qXAPnONlwaZsTE1+cUgoTX/9k3Vp5Q2gawVmavhj28OOfEC8iIoXBeprHLDOHZ/kvd
	 Glsn0+sNp1X/1VxpygOw7m0gWuhYVGou7jOa1DRHpuYC/gJ/wPrjSUNlDst4OEfa6F
	 58qUWUqt9qxopEg0ZY53zPikXb2tF8FwkJyoxG9uyckcu3J+yAcjFXT+y0Ny+Y476U
	 qRwLDdgEwy89fgUKKQ0R7iWUyOqHD1VwD1BD+P7EfpiBgdAOfUETZBg7G8qdefdUxP
	 BYT3ExRbCJZmg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BCA3517E0C96;
	Thu, 11 Sep 2025 14:01:01 +0200 (CEST)
Date: Thu, 11 Sep 2025 14:00:40 +0200
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
Message-ID: <20250911140040.06885642@fedora>
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

