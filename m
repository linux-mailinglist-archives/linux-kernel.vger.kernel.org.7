Return-Path: <linux-kernel+bounces-753139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7514B17F21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4B1188208D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EF221D9E;
	Fri,  1 Aug 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuVu5+OU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B92221723
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040069; cv=none; b=sOQ+qSU8VVWlLskFalorrUAQYlPqnDUubUkQTljXVlIcYpXGb9RRKIAyl8ltNbVawghsiZ17TZthwcgUm1HE4SDQ1N/+Z6RuXlzBpZXewxZ6BboQV2VwoRuh2qjwniNiKNSpb6KBaxm5uIsKSOakxlcswzQIFL+Z6q8Ul164IZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040069; c=relaxed/simple;
	bh=cKEMaZ3xwUu+fSWQ2Hl9xASFWa0pTzYBZ3KKX3hjrm0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaIBdTgmGBDmierr+JAIGLxqLnwFQ5PVWNu9ZLUXRYVZy4hKrzRvmRkrjlVBdmgD63u/YrS62mLf9ZO6K5+NncJEWozuo0W60+BiDEifs4JdCRqwgUJ9rvq4TiaMkp70gYhpHe6O4BSQqRNnIei0mhR4POi1edWbslm75ySSTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuVu5+OU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754040068; x=1785576068;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=cKEMaZ3xwUu+fSWQ2Hl9xASFWa0pTzYBZ3KKX3hjrm0=;
  b=ZuVu5+OUjkzkF0nunhHwIh1rmweLMdLO8m5Dm+Ng5eq8GCRxb7CEZnvn
   anP9ku5PCBmztwt0CmsTPAZ32D/3PjOvn803LMiPzViCycDyTvdcZ/5/q
   0bEqQdp10KoWG3My05mskmS7Jhu+aD9rYnAG4JQRUDVmSou9z8UFiNuDZ
   S1+WDHpCPrjcjIoE5KemZ430CVEpgZ6yJ/LTTi0gVUA0/Sfvn5tWJDT+y
   puKy41oLzsZTDkIy9jW2RkB4yeKi+eflaY1R0L79T2K3V1Ua+AdauLlf3
   A/GIa/LumE/8ubiR92IY5XSAeb9+WZ76l2hAMP6wJnSHrCNOGr5k3ujBv
   A==;
X-CSE-ConnectionGUID: jbRO7FgTSBi+bpz44GCO3w==
X-CSE-MsgGUID: o48dCQvlSh6V4e8YqSYazA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56252216"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56252216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 02:21:07 -0700
X-CSE-ConnectionGUID: 63UaVF4bTeCXP614Ugu8xQ==
X-CSE-MsgGUID: yBhDIk81QAqE2hjylSFGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163083171"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.137]) ([10.245.244.137])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 02:21:05 -0700
Message-ID: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/1] Mark xe driver as BROKEN if kernel page size is
 not 4kB
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>,
 intel-xe@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Fri, 01 Aug 2025 11:20:40 +0200
In-Reply-To: <20250727070413.9743-2-Simon.Richter@hogyros.de>
References: <20250727070413.9743-1-Simon.Richter@hogyros.de>
	 <20250727070413.9743-2-Simon.Richter@hogyros.de>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-27 at 16:04 +0900, Simon Richter wrote:
> This driver, for the time being, assumes that the kernel page size is
> 4kB,
> so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with
> 64kB
> pages.
>=20
> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> Cc: stable@vger.kernel.org

This looks reasonable to me. During your testing, did you notice
whether there were compilation errors on !4K as well? If not, what do
you thing on allowing !4K also for COMPILE_TEST?

Thanks,
Thomas


> ---
> =C2=A0drivers/gpu/drm/xe/Kconfig | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 2bb2bc052120..7c9f1de7b35f 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -1,7 +1,7 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0config DRM_XE
> =C2=A0	tristate "Intel Xe2 Graphics"
> -	depends on DRM && PCI
> +	depends on DRM && PCI && (PAGE_SIZE_4KB || BROKEN)
> =C2=A0	depends on KUNIT || !KUNIT
> =C2=A0	depends on INTEL_VSEC || !INTEL_VSEC
> =C2=A0	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)


