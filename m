Return-Path: <linux-kernel+bounces-781861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94410B317E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F33BA208B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBA2ED866;
	Fri, 22 Aug 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWQbTRGI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9A287508
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865999; cv=none; b=LcSnfDqbP0IRIsYAsrt7OcaFcjp+n6+jLHiStXrHkLqI7kWDkym12+Vi9XT1jBtpRRn9D4dSRjaxFh3XQbNDKqc06pksmdm393Ty+ZuUGPPBLwLIw12+xFwplboPBzocj7TzUbZjvP+d9Qwh+CQhZ0ocMLVLKES3dwDaym+kxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865999; c=relaxed/simple;
	bh=Kvnel9XyEbfV5QjKOr536zHuHkDHJiMkaAOEXL1llWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VG917tNUPFTLoSp6IW3oFfDa/c0IhfXRWKBex1QURGJ6dz91JnbzYw3Qr+N8nMQdBymO8o8XRD8Gt5Z9Up6yZz9oQxWFg7A7XLPeqr4KIutLPY37Btzyrf+8cZTDB+twh3UtE9TQ5rj/bC4j6S5rLvXSWqo2jVumsloEsiapx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWQbTRGI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755865997; x=1787401997;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Kvnel9XyEbfV5QjKOr536zHuHkDHJiMkaAOEXL1llWg=;
  b=TWQbTRGIZ/Leygj91FwSiTQySasbrXf7Adp4nTPV8ShzQKRVIKXXPEns
   a5aA+cwlwdD7gEFnkukzB0mT/CMldTGvLIUKhaIzJ+ivSCNmr/ewUVhY6
   VUtAQKoZPwd/zPpsMA+/qJ8hyr6ZmWQLXAnwRF0BL27sGCwoz1XZJoHnz
   9mV+tVMLUIumQJzryH/UWDJ9jOkAx+UCyEYE4yMQTUD5xQmLichopEKyd
   sxRJuT1hlwtx7KHfBgA7WgusCOok+nupDdNux73JFr9FQMLTYBb5zL0BA
   GpR3KgwBEflTmWkI2mgoE4Lpmd6NUlz8n8iXpKkC/fZd/L6vFgJ7bWEkR
   g==;
X-CSE-ConnectionGUID: rw9zD/YiSZSgXp1eRq2q5g==
X-CSE-MsgGUID: hRG9jIfWQPi6bcqxHaumMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60798365"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60798365"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:33:16 -0700
X-CSE-ConnectionGUID: UcW83+0/SL23tcU+MEOH0g==
X-CSE-MsgGUID: JP9eDJpESMabFyaoW6Ya4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169520920"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.190])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:33:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 willy@infradead.org, sidhartha.kumar@oracle.com
Subject: Re: [PATCH v2 0/6] DRM IDR to Xarray conversions
In-Reply-To: <20250821145429.305526-1-sidhartha.kumar@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250821145429.305526-1-sidhartha.kumar@oracle.com>
Date: Fri, 22 Aug 2025 15:33:10 +0300
Message-ID: <f69669c873dbb99c239e9f2ddf154e983baa61e3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 21 Aug 2025, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> From: Sidhartha <sidhartha.kumar@oracle.com>
>
> v1[1] -> v2:
>   - rebase onto latest mainline v6.17-rc2
>   - fix build error in patch 1 per Intel Test Robot
>
> This series is part of a project to depcrecate the IDR in favor
> of the Xarray. This simplifies the code as locking is handled by
> the Xarray internally and removes the need for a seperate mutex to
> proect the IDR.

It would be great if the commit messages mentioned whether the
identifiers are expected to remain the same in the conversion.

BR,
Jani.

>
> The patches are from this tree and have been rebased to v6.17-rc2
> https://git.infradead.org/?p=users/willy/xarray.git;a=shortlog;h=refs/heads/xarray-conv
>
>
> The series has been compiled and tested with drivers/gpu/drm/tests/.kunitconfig
> and passes all tests.
>
> [15:22:04] Testing complete. Ran 608 tests: passed: 608
> [15:22:04] Elapsed time: 34.792s total, 3.086s configuring, 31.541s building, 0.141s running
>
> [1]: https://lore.kernel.org/dri-devel/20250818190046.157962-1-sidhartha.kumar@oracle.com/
>
> Matthew Wilcox (6):
>   drm: Convert aux_idr to XArray
>   drm: Convert object_name_idr to XArray
>   drm: Convert syncobj_idr to XArray
>   drm: Convert magic_map to XArray
>   drm: Convert lessee_idr to XArray
>   drm: Convert tile_idr to XArray
>
>  drivers/gpu/drm/display/drm_dp_aux_dev.c | 38 ++++++--------
>  drivers/gpu/drm/drm_auth.c               | 22 ++++----
>  drivers/gpu/drm/drm_connector.c          | 26 ++++------
>  drivers/gpu/drm/drm_debugfs.c            | 19 +++----
>  drivers/gpu/drm/drm_gem.c                | 11 ++--
>  drivers/gpu/drm/drm_lease.c              | 15 +++---
>  drivers/gpu/drm/drm_mode_config.c        |  3 +-
>  drivers/gpu/drm/drm_syncobj.c            | 64 ++++++++----------------
>  include/drm/drm_auth.h                   |  9 ++--
>  include/drm/drm_device.h                 |  4 +-
>  include/drm/drm_file.h                   |  6 +--
>  include/drm/drm_mode_config.h            | 12 ++---
>  12 files changed, 86 insertions(+), 143 deletions(-)

-- 
Jani Nikula, Intel

