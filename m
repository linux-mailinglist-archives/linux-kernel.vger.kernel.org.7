Return-Path: <linux-kernel+bounces-779711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC755B2F79A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B60B3A8AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA143101B5;
	Thu, 21 Aug 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBcd87qH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3F266EFC;
	Thu, 21 Aug 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778332; cv=none; b=XyQGvs6Ca5qY7mQkwavgbt73lLUlWgMmy8xz3UW5zQZBQcrCNhfD8YcgsSxUaEh2/CgDnu/zqnna/uRF8hFQhZ8seUTZ1VjG9L4vT6pG6eAUKOguHmR1Es71oiHhhgSAt8PJSDJtvdLucA1fzadoFbtx5yAHAyWwJlVMUsoHJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778332; c=relaxed/simple;
	bh=4mcQIE67L3WL6O7IfA8tS3LP/sxMDdtd6haYhNPZpVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2tLpDYi2pQaDWsbxqqzHAv2dsPwwBcnDU5lCmZQOaKAJe8luhj+d3CXJqM6NM8O5wwonzIeEuV+YwM0r2un7jJVsYs3Ma4T3cesIWkuCXJSZo/4jh8F8Ab8mEfYLcuCTdGf4CPImBFvHjJefctQdPbpRmrx2YMw6HdlANpdh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBcd87qH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB5EC4CEEB;
	Thu, 21 Aug 2025 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755778332;
	bh=4mcQIE67L3WL6O7IfA8tS3LP/sxMDdtd6haYhNPZpVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBcd87qHT4yiIVTOIS5r4ZoI6LAXKOQaKe2wDc02vGrP9K8weG2h++7j804DSRG3W
	 O1iTO5lV1PqPABjKyxZP8LkzTwpKc2j0yTPlEm2c/e8+x8MekbefdNN64kiJUGnBSz
	 EgxsPy1eEAxmH+8R9QgYiaOm6NSHaf2jALg+IppesXAoEECIh31IVp5AIqQSDV35fN
	 gvHFVASnH/1I5KwXAM7l2+YwB38CjRNuHOQb7RjFxG1sG36RpGKwbAV+dLPpmlSacx
	 aI0wwHnquXFbIkt2Ls6rbMTVwjA5y9qNrfEMuXfbZh8QSdL7YfR6tYkiaYcyHNfNAU
	 TOZUp6j8kUNaA==
Date: Thu, 21 Aug 2025 11:12:07 -0100
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lkp@intel.com" <lkp@intel.com>, "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, 
	"oliver.sang@intel.com" <oliver.sang@intel.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"tursulin@ursulin.net" <tursulin@ursulin.net>
Subject: Re: [PATCH 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Message-ID: <zzkl4ozxohkkz6w6himarcecvsvboswwda3bypyj3nv7p56wia@2zn3cvfmzt6i>
References: <nd2sd2vdwif242wslgkaonuvskawho36bp6j6a4caghauzx6f5@dgkaow5idqxt>
 <20250821032156.4946-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821032156.4946-1-chentaotao@didiglobal.com>

Hi Taotao,

...

> >> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> >> index e3d188455f67..2b53aad915f5 100644
> >> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> >> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> >> @@ -514,6 +514,11 @@ static int __create_shmem(struct drm_i915_private *i915,
> >>  	if (IS_ERR(filp))
> >>  		return PTR_ERR(filp);
> >>  
> >> +	/*
> >> +	 * Prevent -EFBIG by allowing large writes beyond MAX_NON_LFS on shmem
> >> +	 * objects by setting O_LARGEFILE.
> >> +	 */
> >> +	filp->f_flags |= O_LARGEFILE;
> >
> > I don't have anything against this, but is it really fixing the
> > issue? I thought that O_LARGEFILE is ignored in 64 bit machines,
> > while here the failure is happening in 64 bit machines.
> 
> As mentioned in the commit body, without O_LARGEFILE, file->f_op->write_iter
> calls generic_write_check_limits(), which enforces the 2GB (MAX_NON_LFS) limit
> and causes -EFBIG on large writes.
> 
> On 64-bit systems O_LARGEFILE is still set when opening files (e.g. via open()),
> so we also need to set it here for shmem objects created inside the kernel.
> 
> However, on older 32-bit systems, setting O_LARGEFILE unconditionally may be risky.
> Previously I did not check this, but to reduce the risk a safer approach is to wrap
> it in a check, for example:
> 
> +	if (force_o_largefile())
> +		filp->f_flags |= O_LARGEFILE;

Ack!

> > Besides, where do you see in the LKP logs the -EFBIG error
> > message?
> >
> 
> Due to the previous return order in shmem_pwrite(), this -EFBIG was being overwritten
> by -EIO on short writes. This issue will be fixed in PATCH 2/2.

Yes, correct :-)

Thanks,
Andi

