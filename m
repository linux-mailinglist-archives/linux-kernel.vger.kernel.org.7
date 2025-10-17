Return-Path: <linux-kernel+bounces-858050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A26BE8AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BC26204EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9D33032A;
	Fri, 17 Oct 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiJZQm3P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75E330319;
	Fri, 17 Oct 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705957; cv=none; b=XmpnoP98TR8KXEdzSJ12tH1I52Vu8uhoOfe3UVsYRiUk9iQjzpd/8PimknjJwsTb7EG6IM/TUtZ9IuJo4d7BP8Nap8lfQLtFMRvktd5faoU8/+l7tlgqOFwNjnXDA2+kXJir5bss+zRwtO/sdIMYipbgzfrEbSO8FnVYvzfGQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705957; c=relaxed/simple;
	bh=/ewWVoHtvu2gqEokYQjprSJRHU9Bdk4eyA56nxvQlsw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KJ01/JhgNGEpYJB3pY3fdA7C6jbVTNEsYJ1jTzcet1jVKKBPzScKxL6uAZfJMJyKGoEJalcdAzfWxvLadW8vADfcoESo4QJXAYhhvB4xW3VHM+NCr+vU0NzMy38e5ewiqGo+uHAtEc+u7BB1TUvIpbjhP1JFn3o/qLTlYp379Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiJZQm3P; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760705956; x=1792241956;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/ewWVoHtvu2gqEokYQjprSJRHU9Bdk4eyA56nxvQlsw=;
  b=kiJZQm3PyLdjF6H1dfj51EZTbjGrKqHg9aTFB2mXhVZBiBP2Ji6UeDlB
   szOrgV8wcEpuPDCzDB84lf1qIN7Ea+Ev/xzmIU0GZ4BqS/C0lTE2pCkFl
   QPGjGgYCNHROCb3hekwvzStfjrxvzMHxgUiwD854h4j0H5vpAdYm6PNgR
   LTx7HxTEcQz+H+3s6+d0CBFRSvdtjJIcgWMbv09JQgdShS+kiYKms0kT9
   8PF72kxs0grn7cuER6+4ZBfosKCeLqgMKdLFtysHYWAEKbnn+Hr9hkPN8
   8DcAm0F+FF0+gg2rGaO6sa4DT5Wy0pI7JJ7fm5q91dZxFMUCGMBecilaj
   A==;
X-CSE-ConnectionGUID: iCEN1SWWTs6O4+em4LeXCg==
X-CSE-MsgGUID: MWxbWwMWTEKFjNCROMdmvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74357950"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="74357950"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:59:15 -0700
X-CSE-ConnectionGUID: dmsbIuXkRSOPr9E1Ao2qxA==
X-CSE-MsgGUID: fE+Ev3AESYeLo7CPKhkvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182730810"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:59:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Oct 2025 15:59:07 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 8/9] platform/x86: asus-wmi: rename
 ASUS_WMI_DEVID_PPT_FPPT
In-Reply-To: <20251015014736.1402045-9-benato.denis96@gmail.com>
Message-ID: <22ecdffb-d92c-3a71-6869-3b74f7db67fe@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <20251015014736.1402045-9-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Denis Benato wrote:

> As pointed out in [1], in order to maintain a naming consistency with

Please rephrase without that part before comma. That is, just state what 
this change does, the Link tag will be there for those who want to read 
extra details about how it came to be.

> ASUS_WMI_DEVID_PPT_PL2_SPPT and ASUS_WMI_DEVID_PPT_PL1_SPL
> rename ASUS_WMI_DEVID_PPT_FPPT to ASUS_WMI_DEVID_PPT_PL3_FPPT.
> 
> [1] https://lore.kernel.org/all/cad7b458-5a7a-4975-94a1-d0c74f6f3de5@oracle.com/

Please change to:

Link: https://.../

You may want to also add:

Suggested-by: ALOK TIWARI <alok.a.tiwari@oracle.com>

> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c            | 4 ++--
>  include/linux/platform_data/x86/asus-wmi.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3727ae00133d..8b5ac4636623 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1211,7 +1211,7 @@ static ssize_t ppt_fppt_store(struct device *dev,
>  	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
>  		return -EINVAL;
>  
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_FPPT, value, &result);
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL3_FPPT, value, &result);
>  	if (err) {
>  		pr_warn("Failed to set ppt_fppt: %d\n", err);
>  		return err;
> @@ -4595,7 +4595,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  	else if (attr == &dev_attr_ppt_pl1_spl.attr)
>  		devid = ASUS_WMI_DEVID_PPT_PL1_SPL;
>  	else if (attr == &dev_attr_ppt_fppt.attr)
> -		devid = ASUS_WMI_DEVID_PPT_FPPT;
> +		devid = ASUS_WMI_DEVID_PPT_PL3_FPPT;
>  	else if (attr == &dev_attr_ppt_apu_sppt.attr)
>  		devid = ASUS_WMI_DEVID_PPT_APU_SPPT;
>  	else if (attr == &dev_attr_ppt_platform_sppt.attr)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 260796fee301..3d236f8498d8 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -108,7 +108,7 @@
>  #define ASUS_WMI_DEVID_PPT_PL1_SPL		0x001200A3
>  #define ASUS_WMI_DEVID_PPT_APU_SPPT		0x001200B0
>  #define ASUS_WMI_DEVID_PPT_PLAT_SPPT	0x001200B1
> -#define ASUS_WMI_DEVID_PPT_FPPT			0x001200C1
> +#define ASUS_WMI_DEVID_PPT_PL3_FPPT		0x001200C1
>  #define ASUS_WMI_DEVID_NV_DYN_BOOST		0x001200C0
>  #define ASUS_WMI_DEVID_NV_THERM_TARGET	0x001200C2
>  
> 

-- 
 i.


