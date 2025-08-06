Return-Path: <linux-kernel+bounces-757517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C272B1C312
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFDA1636D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3892882C1;
	Wed,  6 Aug 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuSXq1PQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857B1D63F7;
	Wed,  6 Aug 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471835; cv=none; b=u7CTNIioLp0zGGk/iGG8h/CvojRMqMuowwbxXHgU7oloDoyxH6XxmCWqgHcdJweMdh9A7K/ks9AQH/McueMRfpNFLr61281yuPy3lQ0AZn0k7Ux9khCmU279ZQH/TpR7wO+b/Wk1opJ0vreNssLFrYkcNcvugEbbLz2CcuH37lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471835; c=relaxed/simple;
	bh=2pYDtRe3Zvc28necsuByBOgarBqT07RbfR1O34mvi38=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PVy4M52vye+Ln9Fhvfgkdr5Z0h3YWvwufeP/RdOu4kqi2OjZ/m27YzLMZmUs5mmDQl3rbhaPfErYFYUAQIgje3UP7RbW/gzzJ6SqFuHDXKivswH09ee6bCiwFaKHVS8gbHcNZjf/IkDVM9ZYNd1hDAy9WRMUxihr0agodgD4peU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuSXq1PQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754471833; x=1786007833;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2pYDtRe3Zvc28necsuByBOgarBqT07RbfR1O34mvi38=;
  b=TuSXq1PQkIe9wJUY8EeRnq/d9hRooK4T41CWiypoaZawxflYEGjzcLDa
   jEUC/Romu3HZO+FRk6lCJEKlN2gULvZuHWByzVaKG9dM0vEdV3N0gOujP
   PNBAU6i4Z2JCwAeZil2tHmnEgdHpCNW9YU4nwwGtMs7CVZ2l5MUvKSQGj
   jKLMKYZZxyI73YQHx+kTrKAt96O65tnc7kUmDpJqe4ZSCakrQWrHzDSND
   swwreHPKxwYdlNq6dQRDotNA1YdlgCS3+2RXLVsA7+Keph55oAzEwS6bn
   8txC6AAP8C3S3N1aFbciAIMmzIgq+V9uIAgu7nUhtu7Er4q67C1XFyznB
   g==;
X-CSE-ConnectionGUID: 3asywbc8QMqJxWNReSInGg==
X-CSE-MsgGUID: XuMEFtxqQ6yDrw/qjrwUmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="79331673"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="79331673"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 02:17:13 -0700
X-CSE-ConnectionGUID: U9WNVMdqTnOqADmYYkRcqw==
X-CSE-MsgGUID: am2KrjJpT9CiBKOAM+AieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="163947661"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 02:17:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Aug 2025 12:17:07 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Present unique domain
 ID per package
In-Reply-To: <20250727211051.2898789-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <f762f6a9-74cc-0299-0bea-6d1ab6c88e41@linux.intel.com>
References: <20250727211051.2898789-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Jul 2025, Srinivas Pandruvada wrote:

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
> Rebased on
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> for-next
> 
>  .../uncore-frequency/uncore-frequency-tpmi.c  | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index bfcf92aa4d69..563e215b4076 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -411,6 +411,47 @@ static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncor
>  	return -EOPNOTSUPP;
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
> +static void update_domain_id(struct tpmi_uncore_cluster_info *cluster_info,
> +			     struct oobmsm_plat_info *plat_info, int num_resource)
> +{
> +	u8 max_dies = topology_max_dies_per_package();
> +	u8 cdie_cnt;
> +
> +	/* For non partitioned system or invalid partition number, return */

non-partitioned

> +	if (!plat_info->cdie_mask || max_dies <= 1 || plat_info->partition >= MAX_PARTITIONS)
> +		return;
> +
> +	if (cluster_info->uncore_data.agent_type_mask & AGENT_TYPE_CORE) {
> +		cluster_info->uncore_data.domain_id = cluster_info->cdie_id;
> +		return;
> +	}
> +
> +	cdie_cnt = fls(plat_info->cdie_mask) - ffs(plat_info->cdie_mask) + 1;

Is it intentional that you didn't use hweight here? (unfortunately,
I don't recall details of the cdie_mask).

> +	guard(mutex)(&domain_lock);
> +
> +	if (!io_die_index_next)
> +		io_die_index_next = max_dies;
> +
> +	if (!io_die_start[plat_info->partition]) {
> +		io_die_start[plat_info->partition] = io_die_index_next;
> +		io_die_index_next += (num_resource - cdie_cnt);
> +	}
> +
> +	cluster_info->uncore_data.domain_id += (io_die_start[plat_info->partition] - cdie_cnt);

I failed to wrap my head around what this math aims to do (mainly what 
cdie_cnt has to do with this). Can you explain (might be useful to have a 
comment if it's something particularly tricky / non-obvious)?

It could be that to make this simpler, one shouldn't assign value in 
uncore_probe() to .domain_id at all but pass the index here (and rename 
this function to set_domain_id()).

> +}
> +
>  /* Callback for sysfs write for TPMI uncore data. Called under mutex locks. */
>  static int uncore_write(struct uncore_data *data, unsigned int value, enum uncore_index index)
>  {
> @@ -614,6 +655,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  			cluster_info->uncore_data.cluster_id = j;
>  
>  			set_cdie_id(i, cluster_info, plat_info);
> +			update_domain_id(cluster_info, plat_info, num_resources);
>  
>  			cluster_info->uncore_root = tpmi_uncore;
>  
> 

-- 
 i.


