Return-Path: <linux-kernel+bounces-784229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E8B33865
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2086E7AAB60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C0C29992A;
	Mon, 25 Aug 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuwIYx1I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA411F542E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108841; cv=none; b=Zqhip2D0NBnY6h9fISYykExNyowytewkIdg5BJd8ZSqvk8k04tAsbxwLK62V1FPt/ejhm0hmNwJuURs9XnFyFG+RX81cFj+W9l3jbXjjMfzvTFP8fj/HOatDa0K5c51eoevhCzvwO0jzhm7RPYOrTFmU94tVvn7N5824hxA5BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108841; c=relaxed/simple;
	bh=GG2c4odGFlYu4f5bVIygyXxOEmLBFST+MhVghFfMPEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WyRvXFNbfHLugI0urSaVkoDYunq12ZPhlnkMBrGe0Ec/AhpAE5+RRyJE6LlwOwIo8FEpJsSOukQOC+BT8W+7n+Hx4hOEpzZbHu4GiQmrw9K+e3DbHxvVR9Q/z1g00FTHYkFjiLyWBtzBeB4NeSLtPBbUGEd3wnQ8+4DZOelD3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuwIYx1I; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756108840; x=1787644840;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GG2c4odGFlYu4f5bVIygyXxOEmLBFST+MhVghFfMPEY=;
  b=cuwIYx1I/oGEXoKAeDAeFMhVy+YN6iMQMJQ//R5xVAHqYyLD41OH0l3V
   AlQ6ius0RG7u28+7qMv+TRPkCioy+mzLQJxBrzWVZzcZn9TCXQiqOkbIg
   YG+r8S+BepjX+82XZxIteODDnlvtT4wyRNthje9a+IdYw4vNyX+8hkBxu
   XIaYxPnaiLhJMsdJ5Vk6tMzJpeJaIAjD5+W92Qyq125shE05w+sjgYFoA
   AmwvKskOyat6Cdohr9KPrQVpIObzEqnUFmfzOBp06oDBAczM3KIj21Q8N
   YjXP/kMiBbstz8KZNwfvvFzWuP1TYLzp5ky1i1d4dsS6+8YuNWYVQCrdb
   w==;
X-CSE-ConnectionGUID: Px6ufsvMTuSyUJtaq3W/rA==
X-CSE-MsgGUID: O45HBOB5RPC8D+FRzcJEbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="61957770"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61957770"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 01:00:39 -0700
X-CSE-ConnectionGUID: LB2Q77Q+QEi6EpNo701nVQ==
X-CSE-MsgGUID: cAmGS6RTTg6CQYfx//dxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168731238"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 01:00:35 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Javier Garcia <rampxxxx@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Javier
 Garcia <rampxxxx@gmail.com>
Subject: Re: [PATCH 2/2] drm: fix kernel-doc struct tag for `drm_modeset_lock`.
In-Reply-To: <20250823075139.34797-2-rampxxxx@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250823075139.34797-1-rampxxxx@gmail.com>
 <20250823075139.34797-2-rampxxxx@gmail.com>
Date: Mon, 25 Aug 2025 11:00:33 +0300
Message-ID: <704edc3cae07cf09f27ff476ff11ca5dd2779520@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 23 Aug 2025, Javier Garcia <rampxxxx@gmail.com> wrote:
> - Add needed "@" to avoid warn messages about duplicated symbols
> as there is function and struct with the same name.
> - The fixed warning is:
>
> 	./Documentation/gpu/drm-kms:476: ./drivers/gpu/drm/drm_modeset_lock.c:377: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48.
> 	Declaration is '.. c:function:: int drm_modeset_lock (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'. [duplicate_declaration.c]

Please look into why adding @ here appear to fix the issue.

The problem is deeper than what this patch makes it seem, and this
papers over the issue in a way that sets the wrong example for the
future.


BR,
Jani.

>
> Fixes: f3a808817fdb ("drm: fix drm_modeset_lock.h kernel-doc notation")
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
>  include/drm/drm_modeset_lock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_modeset_lock.h b/include/drm/drm_modeset_lock.h
> index ec4f543c3d95..0de7046dc653 100644
> --- a/include/drm/drm_modeset_lock.h
> +++ b/include/drm/drm_modeset_lock.h
> @@ -75,7 +75,7 @@ struct drm_modeset_acquire_ctx {
>  };
>  
>  /**
> - * struct drm_modeset_lock - used for locking modeset resources.
> + * @struct drm_modeset_lock - used for locking modeset resources.
>   * @mutex: resource locking
>   * @head: used to hold its place on &drm_atomi_state.locked list when
>   *    part of an atomic update

-- 
Jani Nikula, Intel

