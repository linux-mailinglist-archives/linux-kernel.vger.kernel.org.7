Return-Path: <linux-kernel+bounces-764485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1339B223AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADF43B0A23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F42EA466;
	Tue, 12 Aug 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZcl5DJE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEC2EA162;
	Tue, 12 Aug 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992073; cv=none; b=lls+LcrT/2m1h5P7n/hG+Pdic2YQoswEO1VxT+9ALU61Dc0TBoi3Ktgnef4CuIVyUN9k/c1LiDRhh1PoZIPHwLybzRy8wypJVrrUGLuu8iNBt+HlBU9cEbzdvKXMCVys2Vfz7HLDohqwEA2PDUrsKos1DaeD0JzkGkMBuI/g09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992073; c=relaxed/simple;
	bh=gBGz6JJ6cRgbUBJIFDCaSAVfdTTaWH+QXuZPhWp/Rkc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VgjijW6bKmu43y+m/WZwaadd3g24PD+FYKiW02fkRdfFooKKj25aJI1/jp0N0/0toVsajvCcJns+LZMrpPRNBdQ/W1ei8fVYKqXyekDVhtXUr0Ls6t/lGf9k9hIqtjaI8QHwcPoOrJbToMqWZDbwVOPxBsOSclQVQoFXrFalD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZcl5DJE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754992071; x=1786528071;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gBGz6JJ6cRgbUBJIFDCaSAVfdTTaWH+QXuZPhWp/Rkc=;
  b=nZcl5DJE7ULEKlCUgOyrFZ/PRFyQTFA8er9Gq7u9thsVCXMFtYrvqroB
   QOeI37vGOM1+fdefAqwiBwJqTF9vUywxjDSNijr5LCe5P3RxzyQp7PNNh
   VESxt5P2HJRliNA+y+NMnCYcZoNHwyLof19U/keB8d3WBUYJGKJZ4t5yu
   7qcA9RyKkhqkopC4ODkH7EymrXltIn2Zpb5dDtXKOnLCrd4mPFFzNaF+m
   ohPHDfOsR6TbVXroTsbgqUTwrBEN61WgP82dR5Rw3Ywc7llYlK1rEoHW+
   rgWaVjId0U90ERef74SnkmKvSzfv154TX32cZeHYJljJkFa38W/i8swbH
   A==;
X-CSE-ConnectionGUID: dCE2AO5qSs228Z43RnnPHg==
X-CSE-MsgGUID: HHe3XKF6RsaemJNn6EDcUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67525923"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67525923"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 02:47:51 -0700
X-CSE-ConnectionGUID: b3huImeqR1O4Dn2mjiUvdA==
X-CSE-MsgGUID: B1BW/SVmRVOa19rSNi1MAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165342077"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 02:47:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Aug 2025 12:47:44 +0300 (EEST)
To: Ron Li <xiangrongl@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, vadimp@nvidia.com, 
    alok.a.tiwari@oracle.com, kblaiech@nvidia.com, davthompson@nvidia.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] platform/mellanox/mlxbf_pka: add __free(kfree)
 to handle memory allocation
In-Reply-To: <20250811153934.671070-5-xiangrongl@nvidia.com>
Message-ID: <d4c48d92-e064-c050-d275-2d03f320c98b@linux.intel.com>
References: <20250811153934.671070-1-xiangrongl@nvidia.com> <20250811153934.671070-5-xiangrongl@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Aug 2025, Ron Li wrote:

> Used __free(kfree) attribute to call kzalloc for allocating the 'data'

Hi Ron,

Grammar problems, but this patch won't be necessary, see below.

> variable in mlxbf_pka_drv_ring_ioctl(). So that the variable can be
> released automatically.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> Signed-off-by: Ron Li <xiangrongl@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
> index 0f93c1aa7130..2dd773ec1dc3 100644
> --- a/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
> +++ b/drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
> @@ -3,12 +3,14 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/cdev.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/hw_random.h>
>  #include <linux/idr.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/ioport.h>
> +#include <linux/kdev_t.h>
>  #include <linux/kernel.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> @@ -438,7 +440,6 @@ static long mlxbf_pka_drv_ring_ioctl(void *device_data, unsigned int cmd, unsign
>  		struct mlxbf_pka_dev_shim_s *shim;
>  		bool trng_present;
>  		u32 byte_cnt;
> -		u32 *data;
>  		int ret;
>  
>  		shim = ring_dev->ring->shim;
> @@ -456,25 +457,21 @@ static long mlxbf_pka_drv_ring_ioctl(void *device_data, unsigned int cmd, unsign
>  		 */
>  		byte_cnt = round_up(trng_data.count, MLXBF_PKA_TRNG_OUTPUT_CNT);
>  
> -		data = kzalloc(byte_cnt, GFP_KERNEL);
> +		u32 *data __free(kfree) = kzalloc(byte_cnt, GFP_KERNEL);
>  		if (!data)
>  			return -ENOMEM;
>  
>  		trng_present = mlxbf_pka_dev_has_trng(shim);
> -		if (!trng_present) {
> -			kfree(data);
> +		if (!trng_present)
>  			return -EAGAIN;
> -		}
>  
>  		ret = mlxbf_pka_dev_trng_read(shim, data, byte_cnt);
>  		if (ret) {
>  			dev_dbg(ring_dev->device, "TRNG failed %d\n", ret);
> -			kfree(data);
>  			return ret;
>  		}
>  
>  		ret = copy_to_user((void __user *)(trng_data.data), data, trng_data.count);
> -		kfree(data);
>  		return ret ? -EFAULT : 0;
>  	}

Please make the code to use the up-to-date conventions right from the 
start. We try to avoid changing same lines back and forth within the same 
series.

In general, anything newly introduced should use the most recent 
conventions. I might occassionally allow exceptions to this rule for 
a pre-existing file to remain consistent within that file but that
won't apply here.

-- 
 i.


