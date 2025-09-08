Return-Path: <linux-kernel+bounces-805994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D15B49070
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6397A45B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207030C615;
	Mon,  8 Sep 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljhMwkZQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F830C367
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339684; cv=none; b=BrbAveQB5VRpaIi/vjLvCrKrFr5v+KyazuoMXRrnHIkYTnAeP2XDlTBu1t1JiLK/BaK1N+FudezpaI0hxOHE/v/KQ/V/FSMKjnXN3Hgb9b58YJAiFWiJz9EHN89XcTfhdKyZUUbQdNlQiN7Vd/6WUfPqkU5Ig4LDM3iN2QeYMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339684; c=relaxed/simple;
	bh=iN2/lQ++ZDF+izGUll/I6adfFDW2jaPw93X0MLkqja8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TwvLT1qyaqAZL2MQnlaAPMTJC//CCRQXRWSgxV/K+S+7GILDuFWl7DBYY5mh+nXjZKgVx9l7hhNJFl+Js/uAizCxvS9w/KDqtba2VHpwLkdgt6KQjykk2LwDY/EYQvGZMczaV//dyiuRY1m0VHBlz1gdmQ1UOelTEVLHg2XeLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljhMwkZQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757339682; x=1788875682;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=iN2/lQ++ZDF+izGUll/I6adfFDW2jaPw93X0MLkqja8=;
  b=ljhMwkZQzrWzodPY4x8g2TZOFrJp3PLgO/fGrhVa3zjGdL22EXoyy9Hn
   V7ulFtNlCO80i7I5qrdmcgs3YJ/zHcu2z/asJoXh7TZ9SQAVZFuABZXse
   a/9k4YgKSl5EhNJzNH4MRjeXxYwmwEpXWpjkxV58mefxowTHzO9d7D/1z
   lls9C+4EBkeRXV3FxUy1WZQbrimRYY4Gmo7Z22dGojaPqdfD48FWas7D6
   lWJlSejg7XdiRwmll7ilOPmClPPxdKzE87odvqR8FljPW0tAPypdBoiXP
   tf9LMClo+Cl4K06PGnYX69YupmYQMNvd2hcY94XvSu9Hb9Kgc5fMnFlTi
   g==;
X-CSE-ConnectionGUID: r5u5VOPMRz2tUs3kAxaaqA==
X-CSE-MsgGUID: +iqMGupXRcWzQpPcw23znA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="58636166"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="58636166"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 06:54:41 -0700
X-CSE-ConnectionGUID: RhE2Gfh7QSOyr/2x3p+/xA==
X-CSE-MsgGUID: IG9biy9DRrG4F1E2IYMzFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173254002"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 06:54:38 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Zilin Guan <zilin@seu.edu.cn>, maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, Zilin Guan
 <zilin@seu.edu.cn>
Subject: Re: [PATCH] drm: Use kvmemdup/kvfree for EDID data
In-Reply-To: <20250905151156.844758-1-zilin@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250905151156.844758-1-zilin@seu.edu.cn>
Date: Mon, 08 Sep 2025 16:54:35 +0300
Message-ID: <2040b1e245eb0166079ff985c52775e9ade9eab5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 05 Sep 2025, Zilin Guan <zilin@seu.edu.cn> wrote:
> The drm_edid_alloc() function uses kmemdup() to copy raw EDID data,
> which can be loaded from firmware. A problem exists because the firmware
> subsystem uses vfree() to release its data buffer. This implies the
> buffer may be allocated with vmalloc() and can thus be larger than
> kmalloc() typically supports. Since kmemdup() uses kmalloc() internally,
> attempting to duplicate a large, vmalloc'd EDID buffer can lead to an
> allocation failure.

Real world EDIDs are usually under 1 kB and if the user provides a much
bigger EDID via the firmware loader it's okay to fail at the allocation
time.

BR,
Jani.

>
> To fix this mismatch and robustly handle EDID data of any size, this
> patch replaces kmemdup() with kvmemdup(). The kvmemdup() function is
> designed for this scenario, as it can safely handle a vmalloc'd source
> and choose an appropriate allocator for the destination. The corresponding
> free calls are therefore updated to kvfree().
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/gpu/drm/drm_edid.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index e2e85345aa9a..97142bfc45ad 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2530,13 +2530,13 @@ const struct drm_edid *drm_edid_alloc(const void *edid, size_t size)
>  	if (!edid || !size || size < EDID_LENGTH)
>  		return NULL;
>  
> -	edid = kmemdup(edid, size, GFP_KERNEL);
> +	edid = kvmemdup(edid, size, GFP_KERNEL);
>  	if (!edid)
>  		return NULL;
>  
>  	drm_edid = _drm_edid_alloc(edid, size);
>  	if (!drm_edid)
> -		kfree(edid);
> +		kvfree(edid);
>  
>  	return drm_edid;
>  }
> @@ -2568,7 +2568,7 @@ void drm_edid_free(const struct drm_edid *drm_edid)
>  	if (!drm_edid)
>  		return;
>  
> -	kfree(drm_edid->edid);
> +	kvfree(drm_edid->edid);
>  	kfree(drm_edid);
>  }
>  EXPORT_SYMBOL(drm_edid_free);

-- 
Jani Nikula, Intel

