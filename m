Return-Path: <linux-kernel+bounces-789773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0362B39A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130887BBD33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698730DD03;
	Thu, 28 Aug 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJexTDOv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919430DD25;
	Thu, 28 Aug 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377384; cv=none; b=dTxkVtCFq4OQ153hb9EZXIUmp+hrObi8/cR9e92OTFka1GI7h2V86Bx3VxWxa6HGu5Li+I5CJVmWckSvu6CUYwf8YsLJ/wVE/CLYNBVDiH7GmaHJHogef1x0EX3GK74fAmjcaF97WXQS6TVdAr7WL74qM1mbY/KqONpE/NByHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377384; c=relaxed/simple;
	bh=JmfXJoWVhregF+rcZc/FumkUUaVUaPaqquYwPH3lYLM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RBoU0lcZEDn8SrCXCMgkRCcnuwTWH92mALk/6mMQND/szm+xjeV+3izrL/lySlHPsG9xRRCmlgW13z1WaZwDbkrGo6Kdx1fQJw4ynJ3lZKZJ/R/8YfWRtNGicQJes4BkaiOR+CAZ/Vtz1DeeQqo5WDjDdvBaiF5bw2jBPmfgl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJexTDOv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756377382; x=1787913382;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JmfXJoWVhregF+rcZc/FumkUUaVUaPaqquYwPH3lYLM=;
  b=CJexTDOvXMTBlOlR3nrhaoLGvoDhWalXLSx32xRuHtnSYRxSVpEekfe7
   cjk3qMWj7+pDpGfozpEJusckjhTkwm9AALrFfOj7CwaX1Ln6XjmDr9D7d
   dklgCHlYV1GctqNQttd2CcWtdQAwqd1Iozth8sFvt6fEhQoJKFWpa/h7y
   qA3ezH4HgAm8LgKX2wIOTTvWIO86SlmEkMqAHJlcpDxSDKdjIxNy2YRTR
   chAjcu+R+QHgxrmIEKvZ1IXbjBQmNhPCDWgNLPoA++1XVjd6/Iv7TGeIl
   hQplDElKOMoNIAwj26QxqEA9y6axlEDt8lbs3duEUKTM/qPB0EWSlXUZS
   A==;
X-CSE-ConnectionGUID: zB3G/j06Q8+OCJ5FaKiTzg==
X-CSE-MsgGUID: MO++2n9FQoCCHJhu0ezSqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="57840517"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="57840517"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:36:22 -0700
X-CSE-ConnectionGUID: d2Vb2AWnRVSNbi9Es7Hv+Q==
X-CSE-MsgGUID: gFYAEwc7QGeDNyJLJw1YCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170249195"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:36:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 13:36:16 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86/intel-uncore-freq: Present unique domain
 ID per package
In-Reply-To: <20250825214336.410962-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <1fc59985-e56f-24dd-1015-95d4c2b8d6e7@linux.intel.com>
References: <20250825214336.410962-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Aug 2025, Srinivas Pandruvada wrote:

> In partitioned systems, the domain ID is unique in the partition and a
> package can have multiple partitions.
> 
> Some user-space tools, such as turbostat, assume the domain ID is unique
> per package. These tools map CPU power domains, which are unique to a
> package. However, this approach does not work in partitioned systems.
> 
> There is no architectural definition of "partition" to present to user
> space.
> 
> To support these tools, set the domain_id to be unique per package. For
> compute die IDs, uniqueness can be achieved using the platform info
> cdie_mask, mirroring the behavior observed in non-partitioned systems.
> 
> For IO dies, which lack a direct CPU relationship, any unique logical
> ID can be assigned. Here domain IDs for IO dies are configured after all
> compute domain IDs. During the probe, keep the index of the next IO
> domain ID after the last IO domain ID of the current partition. Since
> CPU packages are symmetric, partition information is same for all
> packages.
> 
> The Intel Speed Select driver has already implemented a similar change
> to make the domain ID unique, with compute dies listed first, followed
> by I/O dies.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Add some comments
> - Change update_domain_id() to set_domian_id() to set domain_id instead of update
> - cluster_info->uncore_data.domain_id += * is changed to add multiple steps to
> get to this equation
> - Handle case when only when no compute dies in partition 
> 
>  .../uncore-frequency/uncore-frequency-tpmi.c  | 76 ++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index cb4905bad89b..a30a99048db9 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -369,6 +369,79 @@ static void uncore_set_agent_type(struct tpmi_uncore_cluster_info *cluster_info)
>  	cluster_info->uncore_data.agent_type_mask = FIELD_GET(UNCORE_AGENT_TYPES, status);
>  }
>  
> +#define MAX_PARTITIONS	2
> +
> +/* IO domain ID start index for a partition */
> +static u8 io_die_start[MAX_PARTITIONS];
> +
> +/* Next IO domain ID index after the current partition IO die IDs */
> +static u8 io_die_index_next;
> +
> +/* Lock to protect io_die_start, io_die_index_next */
> +static DEFINE_MUTEX(domain_lock);
> +
> +static void set_domain_id(int id,  int num_resources,
> +			  struct oobmsm_plat_info *plat_info,
> +			  struct tpmi_uncore_cluster_info *cluster_info)
> +{
> +	u8 part_io_index = 0, cdie_range, pkg_io_index, max_dies;
> +
> +	if (plat_info->partition >= MAX_PARTITIONS) {
> +		cluster_info->uncore_data.domain_id = id;
> +		return;
> +	}
> +
> +	if (cluster_info->uncore_data.agent_type_mask & AGENT_TYPE_CORE) {
> +		cluster_info->uncore_data.domain_id = cluster_info->cdie_id;
> +		return;
> +	}
> +
> +	/* Unlikely but cdie_mask may have holes, so take range */
> +	cdie_range = fls(plat_info->cdie_mask) - ffs(plat_info->cdie_mask) + 1;
> +	max_dies = topology_max_dies_per_package();
> +
> +	/*
> +	 * If the CPU doesn't enumerate dies, then just current cdie range
> +	 * the max.

This sound broken grammar to my non-native ear. Did you mean:

..., then just use current cdie range as the max.

?


> +	 */
> +	if (cdie_range > max_dies)
> +		max_dies = cdie_range;
> +
> +	guard(mutex)(&domain_lock);
> +
> +	if (!io_die_index_next)
> +		io_die_index_next = max_dies;
> +
> +	if (!io_die_start[plat_info->partition]) {
> +		io_die_start[plat_info->partition] = io_die_index_next;
> +		/*
> +		 * number of IO dies = num_resources - cdie_range. Hence
> +		 * next partition io_die_index_next is set after IO dies
> +		 * in the current partition.
> +		 */
> +		io_die_index_next += (num_resources - cdie_range);
> +	}
> +
> +	/*
> +	 * Index from IO die start within the partition:
> +	 * This is the first valid domain after the cdies. If there are
> +	 * no cdies in a partition just start from 0.
> +	 * For example the current resource index 5 and cdies end at
> +	 * index 3 (cdie_cnt = 4). Then the io only index 5 - 4 = 1.
> +	 */
> +	if (cdie_range)

"start from 0" sounds a bit alarming to me as if that condition could 
happen also after starting, that is, more than once within a partition 
which would result in using part_io_index = 0 twice?

> +		part_io_index = id - cdie_range;
> +
> +	/*
> +	 * Add to the IO die start index for this partition in this package
> +	 * to make unique in the package.
> +	 */
> +	pkg_io_index = io_die_start[plat_info->partition] + part_io_index;
> +
> +	/* Assign this to domain ID */
> +	cluster_info->uncore_data.domain_id = pkg_io_index;
> +}
> +
>  /* Callback for sysfs read for TPMI uncore values. Called under mutex locks. */
>  static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncore_index index)
>  {
> @@ -605,11 +678,12 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  			cluster_info->uncore_data.package_id = pkg;
>  			/* There are no dies like Cascade Lake */
>  			cluster_info->uncore_data.die_id = 0;
> -			cluster_info->uncore_data.domain_id = i;
>  			cluster_info->uncore_data.cluster_id = j;
>  
>  			set_cdie_id(i, cluster_info, plat_info);
>  
> +			set_domain_id(i, num_resources, plat_info, cluster_info);
> +
>  			cluster_info->uncore_root = tpmi_uncore;
>  
>  			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >= UNCORE_ELC_SUPPORTED_VERSION)
> 

-- 
 i.


