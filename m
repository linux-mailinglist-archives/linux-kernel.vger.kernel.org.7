Return-Path: <linux-kernel+bounces-756091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D15FB1AFE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723143AEF3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF625229C;
	Tue,  5 Aug 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+6BV0sl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DDF218AB3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380338; cv=none; b=BBgt2fKpZ9R5tJKTkGeaeDkXvWUMbbou5XvL4MtS7MjD2f9GHIkbMG4rTIeChBRoyU/2nZ9WchBtMARC4JF30OsAGlav3MHI2K0jHv2siJacv4ii7HxLMRWxgo7w4B61lI3bE+9BUVEvyYnQlcfCoReHgk9UV3ISQQjR3NqvHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380338; c=relaxed/simple;
	bh=ZxDtzQhbIvVvZp84dwGhfiyrstUOa2vcXtEDlKWH4eo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0uIIdiaXEKlkRhJJh+l9ntAISgxoox0LiOXqqbvyi/SwsfOeY80W9YlpNE8Z5znRf4mK4BhweWIe85VzCrGPuUt2WqRd2Vf/xnB3a4VDOgNET4VKf/D4YSgrkSAYvRoglYUS12NeMEUCrxDavEihMdfMgHACrDrufbAwT5IVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+6BV0sl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754380337; x=1785916337;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=ZxDtzQhbIvVvZp84dwGhfiyrstUOa2vcXtEDlKWH4eo=;
  b=B+6BV0slYC+7YG6qwklYNfQdceCKtkOYbehhtub9hgRqp9Y6QqJf1V+k
   TC+UtCqQF8NWtAVeMmqoYDimW7CU7+ffHk6XqEqHjLto5M7d3MUavQHl/
   m59IvAktqrSwXW0KtkBI1Xl0BQJcEOZgW9GNQYsFJbAi33vOfesKrK+0B
   SzjuQzcldQ495RLuL9Rr3pES1ZXtF0oosW8K3A+kAivajUM8pMi24FQe7
   S8aOCMm0dYUygT4HipHIOvE33e61HsQi1hjG1bx8B4Y5W53ibEYKhKCNg
   BOOMM4qRSo3BvIwfKQGwUpx6rvDZ7CKdyavn5xF/FgI0SwRWad8qdbVFe
   A==;
X-CSE-ConnectionGUID: SQnojOmxS1KpzGsdh7YCCA==
X-CSE-MsgGUID: fSf2GEpERCuSZmAu7z3e0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56801609"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56801609"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 00:52:16 -0700
X-CSE-ConnectionGUID: WDUPPRAkTOmyB3rkbVWD+w==
X-CSE-MsgGUID: RgDcaYgfQGiVzMQduUd1fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="201590793"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 00:52:12 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Liao Yuanhong <liaoyuanhong@vivo.com>,
 Nitin Gote <nitin.r.gote@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/i915/gem: Remove goto label that are only used
 once
In-Reply-To: <20250805074645.625911-2-liaoyuanhong@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250805074645.625911-1-liaoyuanhong@vivo.com>
 <20250805074645.625911-2-liaoyuanhong@vivo.com>
Date: Tue, 05 Aug 2025 10:52:09 +0300
Message-ID: <3c436b32da8d76df7eace4dbbde79e808058ad8b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 05 Aug 2025, Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
> Remove unnecessary goto labels to improve code readability. 

Please don't. It's fine as it is.

> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_region.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c b/drivers/gpu/drm/i915/gem/i915_gem_region.c
> index 636768d0f57e..539d1716d454 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
> @@ -92,15 +92,13 @@ __i915_gem_object_create_region(struct intel_memory_region *mem,
>  		flags |= I915_BO_ALLOC_PM_EARLY;
>  
>  	err = mem->ops->init_object(mem, obj, offset, size, page_size, flags);
> -	if (err)
> -		goto err_object_free;
> +	if (err) {
> +		i915_gem_object_free(obj);
> +		return ERR_PTR(err);
> +	}
>  
>  	trace_i915_gem_object_create(obj);
>  	return obj;
> -
> -err_object_free:
> -	i915_gem_object_free(obj);
> -	return ERR_PTR(err);
>  }
>  
>  struct drm_i915_gem_object *

-- 
Jani Nikula, Intel

