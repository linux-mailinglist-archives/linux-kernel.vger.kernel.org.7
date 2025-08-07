Return-Path: <linux-kernel+bounces-759386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39628B1DCDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCFB624043
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B156A221DAC;
	Thu,  7 Aug 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jY1NQlkV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4420299E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590034; cv=none; b=oRwoxoFlPr0Ri+acGnWcFgkm61efdu7lEJ2IlJCxu3ESbxOTxCnXcyU4T5NXl1NAEMX99NV3kKmSkLT2Oo2hY1CRadbrOLwgYQE88iAgJEQxEzp80j364fo7nMjNacReJyvWlcPsyS3iVybHBotxv8Je5QQrBY1UhOK7lDnQlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590034; c=relaxed/simple;
	bh=xHKkV4DD2DuoLr05gEBrQk1TLxEWU/M1iyMdw4ivK30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RoR7qtIPb3cPJPWqZ5bIfesJvFMzRZhkNRuBJIsAvcg6xD1BiLCLMEPAGGI5oOU5PpzrdWGYBUZ80w/3KJqZdkZQgXqTCZOohpELnqTnsm+7fWMZEcZXe5FxvRBMtF6UpdS9BWP8K23wfSLl/j2OuUxvaAJ0FufYZVqA+poZ7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jY1NQlkV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754590032; x=1786126032;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xHKkV4DD2DuoLr05gEBrQk1TLxEWU/M1iyMdw4ivK30=;
  b=jY1NQlkVhQ3e8xbZr/HfpZNHve3e60pjjRBVKK6AYb+tb60rOLZ6l5Pu
   U/64K57WNq4eOiiCiVPRM5LoSShnkACRxJFiDi1wESyM0Sy3I4PsPtNW3
   4Q44UbBCbDIprTazpKNIlzAWtAOeoaLidLIvga2mPeDNkv8ytYoQrENJg
   2ZFEEMZZrA04JQcDew2kU1if07QHrlRgXETPtcxWaKZlNleNv9CfjeXwg
   NXT8XQ4R14crXwTRAdx67pyaC5kjnq9cdVqr0mpfQTUmWVczEsaswkNKb
   kBvC9F6Fs3IKREV56MwNeFhwsh1xa3/Qfhs37KuCKG42eFsp5g9oOY7hx
   g==;
X-CSE-ConnectionGUID: g+z4LcJzRoqtA46g0R3iuQ==
X-CSE-MsgGUID: W35pXe4tRKGhVVkJgMP2Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="79489022"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="79489022"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 11:07:10 -0700
X-CSE-ConnectionGUID: hanbwvowSUi97SDYIz70dA==
X-CSE-MsgGUID: Bkhc8bHqTnm6cysL/dVeCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169338011"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.96])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 11:07:07 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Qianfeng Rong <rongqianfeng@vivo.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: willy@infradead.org
Subject: Re: [PATCH v2 2/2] drm/i915: remove redundant __GFP_NOWARN
In-Reply-To: <20250807143919.575439-3-rongqianfeng@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250807143919.575439-1-rongqianfeng@vivo.com>
 <20250807143919.575439-3-rongqianfeng@vivo.com>
Date: Thu, 07 Aug 2025 21:07:03 +0300
Message-ID: <0a744ae4266a0e240a8d6e4c3a1ab4998b7404e8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 07 Aug 2025, Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
> __GFP_NOWARN.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c | 4 ++--
>  drivers/gpu/drm/i915/i915_active.c               | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> index 8d4bb95f8424..22432912db2e 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
> @@ -220,7 +220,7 @@ static void heartbeat(struct work_struct *wrk)
>  		goto out;
>  	}
>  
> -	rq = heartbeat_create(ce, GFP_NOWAIT | __GFP_NOWARN);
> +	rq = heartbeat_create(ce, GFP_NOWAIT);
>  	if (IS_ERR(rq))
>  		goto unlock;
>  
> @@ -282,7 +282,7 @@ static int __intel_engine_pulse(struct intel_engine_cs *engine)
>  	GEM_BUG_ON(!intel_engine_has_preemption(engine));
>  	GEM_BUG_ON(!intel_engine_pm_is_awake(engine));
>  
> -	rq = heartbeat_create(ce, GFP_NOWAIT | __GFP_NOWARN);
> +	rq = heartbeat_create(ce, GFP_NOWAIT);
>  	if (IS_ERR(rq))
>  		return PTR_ERR(rq);
>  
> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index 0dbc4e289300..402043cd84d5 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -727,7 +727,7 @@ int i915_request_await_active(struct i915_request *rq,
>  static int sw_await_fence(void *arg, struct dma_fence *fence)
>  {
>  	return i915_sw_fence_await_dma_fence(arg, fence, 0,
> -					     GFP_NOWAIT | __GFP_NOWARN);
> +					     GFP_NOWAIT);
>  }
>  
>  int i915_sw_fence_await_active(struct i915_sw_fence *fence,

-- 
Jani Nikula, Intel

