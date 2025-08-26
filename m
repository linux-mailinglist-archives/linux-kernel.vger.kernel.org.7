Return-Path: <linux-kernel+bounces-787268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223D3B373CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FA936317B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03C2DEA90;
	Tue, 26 Aug 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1KOkJ9w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A322083;
	Tue, 26 Aug 2025 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240011; cv=none; b=CFgO0lOaQeKxy6TU0zOc09lnxVa6fAg1sRz+j19dtUmLFxteHigUECmypNlYwgrcpa+AekJdqZH15OGTGd9+iPxf0+tfZLOnaZCAPEc6b6ijQJ3Hxgt3tN3Lazz/S8nixoE0vtkyK6c/RrLb8n91SvA8uc8VqS9ObdubGJZme2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240011; c=relaxed/simple;
	bh=TF5yLey0lHFiiJblnHEpBqd9VxhtBoWQnLnmvVRV1Fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kl+emulVlgYduazlZ6zX30B12zAExn8AYNTORUA5btl6RhAhfVAdNsZiJBz05LgXuDu33hXJTiJloPUHSEQ9f0K9cqiNGyNnDr89ZMzn0K4J0nas9F2325lxF93yG5xH4bqFCRrV5eoU2zeHSlVlmwv3vhW/fN22NkY1MVBCnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1KOkJ9w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756240009; x=1787776009;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TF5yLey0lHFiiJblnHEpBqd9VxhtBoWQnLnmvVRV1Fg=;
  b=k1KOkJ9w9Fcyhy5BHUWRecsMp8/NNXE8dceWP+e6Y+OYeD70/UCWj75m
   XRpy9+0O/Oh3JM3NP6mkJiq4T9P23HK3uvikcoZTpnlj67aJYD8Pp3/+c
   bj+42lEQStLSWv6I0Kr0++in+DyhtCJu6HgYaKdlXRQpjPWHVTI9FsX2g
   UR8D2Q08YFCMgWR+fS/m2jK2sMZx50Xt/m/aOq8mJUPHX28YmBY0mrB1T
   OF/QUKim0mt8mdlDt8cTAHn3fZKkEPwqkcR+vo04CJGNR8UDR2fw4qnhA
   q1Ggutn1TQyIIKnYH9NWnYrWwO+NARErwATEDjN3dvivRGwpGgjg8mC/S
   Q==;
X-CSE-ConnectionGUID: 3qWRd8A6QVyw45az1B5U8w==
X-CSE-MsgGUID: yQZiHeDPSoaWE/YwWtUzuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="75942149"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75942149"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:26:49 -0700
X-CSE-ConnectionGUID: sChyl/SsS+CeBXKNA0p7Ug==
X-CSE-MsgGUID: LOg42TxKTmCUzKOOsQV00Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168953588"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.13])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:26:48 -0700
Message-ID: <00466c7a41bd4a0120a7798318ac5bba8878ada5.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel: power-domains validate domain in
 tpmi_cpu_online()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Arcari <darcari@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tero Kristo
 <tero.kristo@linux.intel.com>,  linux-kernel@vger.kernel.org
Date: Tue, 26 Aug 2025 13:26:46 -0700
In-Reply-To: <20250826164331.1372856-1-darcari@redhat.com>
References: <20250826164331.1372856-1-darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

On Tue, 2025-08-26 at 12:43 -0400, David Arcari wrote:
> Although tpmi_get_power_domain_mask() calls tpmi_domain_is_valid()
> prior to indexing tpmi_power_domain_mask[],
Because this an API call so that caller parameter needs to be
sanitized.

>  tpmi_cpu_online() does
> not.
This is hotplug callback, which should have correct topology
information.

>  In the case where a VM creates non-contiguous package ids the
> result can be memory corruption. This can be prevented by adding
> the same validation in tpmi_cpu_online().
>=20

This driver is getting loaded means MSR 0x54 is virtualised otherwise
this driver will not load.
Not sure this is an upstream kernel or not.

Some comments below.

> Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU
> mapping")
>=20
Andy already pointed about new line here.

> Cc: Hans de Goede <hansg@kernel.org>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Tero Kristo <tero.kristo@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
> ---
> =C2=A0drivers/platform/x86/intel/tpmi_power_domains.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c
> b/drivers/platform/x86/intel/tpmi_power_domains.c
> index 9d8247bb9cfa..ae5b58679e29 100644
> --- a/drivers/platform/x86/intel/tpmi_power_domains.c
> +++ b/drivers/platform/x86/intel/tpmi_power_domains.c
> @@ -194,6 +194,9 @@ static int tpmi_cpu_online(unsigned int cpu)
> =C2=A0	if (ret)
> =C2=A0		return 0;
> =C2=A0
Need some more information.

The only case this check is required if
topology_physical_package_id(cpu) is returning greater or equal to
topology_max_packages(). If this true in this case, please check the
value of info->pkg_id. If this is bad then then some other places also
this may have issue. info->punit_domain_id is already checked for valid
value in tpmi_get_logical_id().


Thanks,
Srinivas

> +	if (!tpmi_domain_is_valid(info))
> +		return 0;
> +
> =C2=A0	index =3D info->pkg_id * MAX_POWER_DOMAINS + info-
> >punit_domain_id;
> =C2=A0
> =C2=A0	guard(mutex)(&tpmi_lock);


