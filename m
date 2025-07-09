Return-Path: <linux-kernel+bounces-723096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E79AFE2D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B114E0DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E527FB10;
	Wed,  9 Jul 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvzskZy/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827B27FD46;
	Wed,  9 Jul 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050252; cv=none; b=hBtVgq7y0bb6W4c2h0JQQWUsLh9PWmuqzqs9BmjQN82A0Yy5ZyH86xN7thTVVtfTgtB0xdl0dlVEK9ksvTTRBVO941eb71srBty3geRFwZ1XGT6ksv4z96t/itwcGZ8wZbcIuolZ8/a7NETN48x6TVG9R9QjuSax6WgrPzzhonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050252; c=relaxed/simple;
	bh=LLQjysnRiHtmo3Y3bXAK6ROSPC0ENAZLmFpRcnIZmHE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GJXmXr3UehAHTtKIT9gxW4y2roEgNhexKirjQZG8N+A6mIWXZcbC7hqIz4jn20uFp7XvY2qG1BQrqaUfxGFV/MvDN/m4t9Hrf5O0/PNCQSr0FnqIuDiIqMkaStdXRCeBP9wajoGmLsxI9efvVfsiqBstWNHQCFHXy8Spdw0ZqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvzskZy/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752050250; x=1783586250;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LLQjysnRiHtmo3Y3bXAK6ROSPC0ENAZLmFpRcnIZmHE=;
  b=kvzskZy/vCO0nQE7oMZLGNCpP7fZ71PPIWufEKNGxc9+ndqAVUq19qDS
   P6ze6/WfenVCzRtgsPRUHk9S0I/1YcSRMdCYU6nP+0P4xnjcGAXxV4Mch
   AURpCPL266Gnw+dXA+b/rcqoEDbvvsUU6nk1v6Iu6JmPpS4AFzL+OBzn8
   jflplwPsiSboB8hHNfZbyk7lp4+PYXM8sTwvLVelL8DBHpn4lIAWu1Fi8
   9fnHvu8fbhSj3ywkT958483YxT7B3AVkz5e7VF6yGMrLnYgRUNeDwHG3i
   bPHDz9XKUyfdNL7RVJZcLqz5bu28gSYnKMjMpz5aex2VgFaL+xjFHpeMd
   A==;
X-CSE-ConnectionGUID: VuBhhhNsSmKx92VF8XWdPA==
X-CSE-MsgGUID: 89Rd1eYpTyO5vf8whnSICw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65365127"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65365127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:37:30 -0700
X-CSE-ConnectionGUID: NQmxbEnLRDmW3gfDAG789g==
X-CSE-MsgGUID: mv/DpZ6sQmCrbNkkttsY9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160025570"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:37:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Jul 2025 11:37:23 +0300 (EEST)
To: Nathan Chancellor <nathan@kernel.org>, 
    Randy Dunlap <rdunlap@infradead.org>
cc: "David E. Box" <david.e.box@linux.intel.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel/pmt/discovery: Fix size_t specifiers
 for 32-bit
In-Reply-To: <20250708-discovery-pmt-fix-32-bit-formats-v1-1-296a5fc9c3d4@kernel.org>
Message-ID: <71dac82f-1809-413b-de00-fc37cb408a72@linux.intel.com>
References: <20250708-discovery-pmt-fix-32-bit-formats-v1-1-296a5fc9c3d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Jul 2025, Nathan Chancellor wrote:

> When building i386 allmodconfig, there are two warnings in the newly
> added discovery code:
> 
>   drivers/platform/x86/intel/pmt/discovery.c: In function 'pmt_feature_get_feature_table':
>   drivers/platform/x86/intel/pmt/discovery.c:427:35: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>     427 |         if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
>         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~
>         |                                                               |
>         |                                                               size_t {aka unsigned int}
>   ...
>   drivers/platform/x86/intel/pmt/discovery.c:427:53: note: format string is defined here
>     427 |         if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
>         |                                                   ~~^
>         |                                                     |
>         |                                                     long int
>         |                                                   %d
> 
>   drivers/platform/x86/intel/pmt/discovery-kunit.c: In function 'validate_pmt_regions':
>   include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>   ...
>   drivers/platform/x86/intel/pmt/discovery-kunit.c:35:17: note: in expansion of macro 'kunit_info'
>      35 |                 kunit_info(test, "\t\taddr=%p, size=%lu, num_rmids=%u", region->addr, region->size,
>         |                 ^~~~~~~~~~
> 
> size_t is 'unsigned long' for 64-bit platforms but 'unsigned int' for
> 32-bit platforms, so '%ld' is not correct. Use the proper size_t
> specifier, '%zu', to resolve the warnings on 32-bit platforms while not
> affecting 64-bit platforms.
> 
> Fixes: d9a078809356 ("platform/x86/intel/pmt: Add PMT Discovery driver")
> Fixes: b9707d46a959 ("platform/x86/intel/pmt: KUNIT test for PMT Enhanced Discovery API")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/platform/x86/intel/pmt/discovery-kunit.c | 2 +-
>  drivers/platform/x86/intel/pmt/discovery.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/discovery-kunit.c b/drivers/platform/x86/intel/pmt/discovery-kunit.c
> index b4493fb96738..f44eb41d58f6 100644
> --- a/drivers/platform/x86/intel/pmt/discovery-kunit.c
> +++ b/drivers/platform/x86/intel/pmt/discovery-kunit.c
> @@ -32,7 +32,7 @@ validate_pmt_regions(struct kunit *test, struct pmt_feature_group *feature_group
>  		kunit_info(test, "\t\tbus=%u, device=%u, function=%u, guid=0x%x,",
>  			   region->plat_info.bus_number, region->plat_info.device_number,
>  			   region->plat_info.function_number, region->guid);
> -		kunit_info(test, "\t\taddr=%p, size=%lu, num_rmids=%u", region->addr, region->size,
> +		kunit_info(test, "\t\taddr=%p, size=%zu, num_rmids=%u", region->addr, region->size,
>  			   region->num_rmids);
>  
>  
> diff --git a/drivers/platform/x86/intel/pmt/discovery.c b/drivers/platform/x86/intel/pmt/discovery.c
> index e72d43b675b4..1a680a042a98 100644
> --- a/drivers/platform/x86/intel/pmt/discovery.c
> +++ b/drivers/platform/x86/intel/pmt/discovery.c
> @@ -424,7 +424,7 @@ pmt_feature_get_feature_table(struct pmt_features_priv *priv,
>  	size = sizeof(*header) + FEAT_ATTR_SIZE(header->attr_size) +
>  	       PMT_GUID_SIZE(header->num_guids);
>  	res_size = resource_size(&res);
> -	if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
> +	if (WARN(size > res_size, "Bad table size %zu > %pa", size, &res_size))
>  		return -EINVAL;
>  
>  	/* Get the feature attributes, including capability fields */
> 
> ---

Thanks for the patch, I've applied this to the for-next branch. I added 
a few tags based on the report from Randy.

-- 
 i.


