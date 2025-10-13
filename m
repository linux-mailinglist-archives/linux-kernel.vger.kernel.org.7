Return-Path: <linux-kernel+bounces-850844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE55BD461E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC34056E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5757C30F7E8;
	Mon, 13 Oct 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OH9EGB77"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6630B515;
	Mon, 13 Oct 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367850; cv=none; b=oVhf2hbB5dcMFYYzl7pDcBlmAsfSnIHD8GBL+XtbE2LQ2reXjERCwyCwbzbDh5WsftHF2nH3JZWxO5dbSoy0bqbQAx1NdaXuztmYf6RUzSYdIQwWmtqvpDp37JTOLWDnQY4AGjsmVPrMJoHqVLklBMTO33YgRofE0BqkhV6f5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367850; c=relaxed/simple;
	bh=WwSOjcPmv4A2YQFyBHaWXsd2+3pnG4YO7nsZv/3LT8I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nia9HcjSALzu071NuPUDbGf7fyosBZlMs1Lm09vVk7PlTVtB7PcZ1pBVH5eq4dJWxqKVMUZxbwLQvVQQjpd6Lx75VTI3QL0LVFJIrNKKGn6roHROnhwIUWIL1tPmb8eIEUwZHCvjvFKS33eB59Gf2qhLVHSayyI1gh2FbDU134A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OH9EGB77; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760367849; x=1791903849;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WwSOjcPmv4A2YQFyBHaWXsd2+3pnG4YO7nsZv/3LT8I=;
  b=OH9EGB770bYhK+Xybrt1kwMS5MRFIUKSn88hFwW+HZkV0pbLNd1QjVBO
   Kz38gFbZIllV+Q9wFSUygHUBLvP4LMPPNXs4awfXabWEuWylFVhQF0ape
   b//w+j4Ev2VHoDYhHrmhkiWHGAL6cuDmqqLJI4fHyuU90Qjz5CyVlZa/o
   2F492YX4TFvlCOf28/4jW2G4iF3Uvj5GBNHjBbzisy+h7l21MzpulNfEC
   Wmw261YPAaYgW4To2BEOfnpgoxP86yIY1/7k3unysRx1CyBo8YGyYI0Gn
   52F1+rBUKLPLXtl4AUmRzp96bvHKN8psHus3A5Yt8gTvSiZ/15kkJtabV
   w==;
X-CSE-ConnectionGUID: oT4YeI+6SMSYD+t97VB96w==
X-CSE-MsgGUID: McaUuqCASGq4qSD4XQY0Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62210573"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62210573"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:04:06 -0700
X-CSE-ConnectionGUID: 8/TtlDaQTbe3P3ZVtk1d8A==
X-CSE-MsgGUID: tgM/c+olQxO7kR0SKEF22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="182380409"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:04:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 18:03:59 +0300 (EEST)
To: David Thompson <davthompson@nvidia.com>
cc: Hans de Goede <hansg@kernel.org>, vadimp@nvidia.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: Re: [PATCH] platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to
 count_clock init
In-Reply-To: <20251013134335.26191-1-davthompson@nvidia.com>
Message-ID: <78ff1cd0-0000-c514-3a73-8f31f2b86454@linux.intel.com>
References: <20251013134335.26191-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Oct 2025, David Thompson wrote:

> The lock-related debug logic (CONFIG_LOCK_STAT) in the kernel is noting
> the following warning when the BlueField-3 SOC is booted:
> 
> [   10.231318] BUG: key ffff00008a3402a8 has not been registered!
> [   10.237249] ------------[ cut here ]------------
> [   10.241914] DEBUG_LOCKS_WARN_ON(1)
> [   10.241927] WARNING: CPU: 4 PID: 592 at kernel/locking/lockdep.c:4801 lockdep_init_map_type+0x1d4/0x2a0
> [   10.254700] Modules linked in: mlxbf_pmc(+) mlxbf_pka mlxbf_bootctl cppc_cpufreq(+) sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua drm ip_tables x_tables virtio_net crct10dif_ce ghash_ce sha2_ce net_failover sha256_arm64 failover sha1_ce nvme nvme_core vitesse gpio_mlxbf3 sdhci_of_dwcmshc sdhci_pltfm sdhci mlxbf_gige i2c_mlxbf pinctrl_mlxbf3 mlxbf_tmfifo pwr_mlxbf autofs4 aes_ce_blk crypto_simd cryptd aes_ce_cipher
> [   10.282360] mlxbf_gige MLNXBF17:00 oob_net0: renamed from eth0
> [   10.292917] CPU: 4 PID: 592 Comm: systemd-udevd Not tainted 5.15.189+ #2
> [   10.292922] Hardware name: https://www.mellandx.com BlueField-3 DPU/BlueField-3 DPU, BIOS 4.13.0.13780 Sep 30 2025
> [   10.292922] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   10.292925] pc : lockdep_init_map_type+0x1d4/0x2a0
> [   10.292931] lr : lockdep_init_map_type+0x1d4/0x2a0
> [   10.292932] sp : ffff8000096a3350
> [   10.292933] x29: ffff8000096a3350 x28: 00000000000001a4 x27: 00000000ffffee4b
> [   10.292937] x26: ffff00008a3402e0 x25: 0000000000000000 x24: 0000000000000000
> [   10.292939] x23: ffff00008a3402a8 x22: 0000000000000000 x21: ffffd1acf2833000
> [   10.292941] x20: ffff00008a3402a8 x19: ffff00008c10d378 x18: ffffd1acf1d3d000
> [   10.292944] x17: 000000007bba6d3c x16: ffffd1acef416114 x15: ffff0003dd914d88
> [   10.292946] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
> [   10.292949] x11: 656820747563205b x10: 0000000000000029 x9 : ffffd1acef49deb4
> [   10.292951] x8 : ffffd1acf0e93008 x7 : 0000000000000001 x6 : 0000000000000001
> [   10.385410] x5 : ffff8000096a31a0 x4 : ffff2e56eca7f000 x3 : ffff0003d20a5e80
> [   10.385412] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0003d20a5e80
> [   10.385415] Call trace:
> [   10.385417]  lockdep_init_map_type+0x1d4/0x2a0
> [   10.385423]  __kernfs_create_file+0x84/0x140
> [   10.385428]  sysfs_add_file_mode_ns+0xcc/0x1cc
> [   10.385431]  internal_create_group+0x110/0x3d4
> [   10.385434]  internal_create_groups.part.0+0x54/0xcc
> [   10.385436]  sysfs_create_groups+0x24/0x40
> [   10.385438]  device_add+0x6e8/0x93c
> [   10.444559]  device_register+0x28/0x40
> [   10.448299]  __hwmon_device_register+0x4b0/0x8a0
> [   10.452907]  devm_hwmon_device_register_with_groups+0x7c/0xe0
> [   10.458641]  mlxbf_pmc_probe+0x1e8/0x3e0 [mlxbf_pmc]
> [   10.463598]  platform_probe+0x70/0x110

Please trim this splat to only contain the relevant part of the 
information.

> The mlxbf_pmc driver must call sysfs_attr_init() during the
> initialization of the "count_clock" data structure to avoid
> this warning.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> 
> Fixes: 5efc800975d9 ("platform/mellanox: mlxbf-pmc: Add support for monitoring cycle count")

Please place this before your S-o-b line and don't leave empty lines in 
between the tags.

--
 i.

> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 4776013e0764..16a2fd9fdd9b 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -2015,6 +2015,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
>  	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
>  		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
>  		attr = &pmc->block[blk_num].attr_count_clock;
> +		sysfs_attr_init(&attr->dev_attr.attr);
>  		attr->dev_attr.attr.mode = 0644;
>  		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
>  		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
> 

