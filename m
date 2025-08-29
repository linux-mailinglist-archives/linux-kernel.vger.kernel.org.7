Return-Path: <linux-kernel+bounces-791732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E96B3BB18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03292082DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3A314B68;
	Fri, 29 Aug 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoCpZ/4K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4A1D5CD1;
	Fri, 29 Aug 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469978; cv=none; b=POK2qlj2zIBb+xVf1dIaJnv3WgkxVxaLCDcYr4fJ+oEF6f8vZlHAdIzcST+bgL0WUv8vCLZeJHTK6dYasniZHElzsZp6/GQhbGRUhqcJkijCo3fdoXK/BQ8K6xx9ZTIR4G3HEQ1RMAsNG59M04RlAw2CpERpA5CsDHWWs4JFBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469978; c=relaxed/simple;
	bh=TW9ww/OJ96DkQ4jnsZMuk/RiQgbviuSM68aPie1Vb1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZKb9UMhoPsly0uEPwkVfEqP2QFs1VnF/uHcE1qo40UfpqNlaCoXmdk36jWw3X8+AA8/61kav5e8RAPCweiatPs9IPQjoALU+I3uOn5TArFDwotAhW1mf4IrByV5CQaAjLG3vDfNunKAwErJBQRRRTuu/6jGvvMooQvV57HK7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoCpZ/4K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756469977; x=1788005977;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TW9ww/OJ96DkQ4jnsZMuk/RiQgbviuSM68aPie1Vb1Y=;
  b=AoCpZ/4Kzi+U40NeyH2+HzIi30FiWYgLa8zN7JRq0duWtKgo4wtVQ3Bl
   dlULctLYsB4+eRf1Vx6wb2+1y9TzW1GaQB6mNSCDLS6PHjeeHJt9YtYMK
   OADkisFS6gb5PwJhTV2YohbueP9MD1GytdMBPdri1rPrzMfBUu5yXmYP4
   uYCUxjNY/YDUjh1sCt/Eaj8x9gNdlWXGJ0cUSrZJbXssjOOKJIbpM9QlT
   ohmHVwyFPs6DxkiLjNm7ui9pwRMYzLpsPvyGerYUSkR8fFkoYJrwh9gBv
   10yb7ck3mTfQBfNztyNT7iwozZQzIz7pa+XX+//Aq10KZa1sYn2vabpej
   Q==;
X-CSE-ConnectionGUID: 3ypNout4RQ2cCvbhCF090g==
X-CSE-MsgGUID: r4OjR0CuQ6CdPgwlr5Ia8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58696968"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58696968"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 05:19:36 -0700
X-CSE-ConnectionGUID: D+4io8c1RvGAwvomgKaZyg==
X-CSE-MsgGUID: kTCHItCbQN+w0Zdjv2z7lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170540779"
Received: from spandruv-mobl4.amr.corp.intel.com ([10.125.109.134])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 05:19:35 -0700
Message-ID: <c0cf2c2fefaed36fbb68d682f2fc368607f90da8.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86/intel: power-domains: Use
 topology_logical_package_id() for package ID
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Arcari <darcari@redhat.com>, platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tero Kristo
 <tero.kristo@linux.intel.com>,  linux-kernel@vger.kernel.org
Date: Fri, 29 Aug 2025 05:19:33 -0700
In-Reply-To: <20250829113859.1772827-1-darcari@redhat.com>
References: <20250826164331.1372856-1-darcari@redhat.com>
	 <20250829113859.1772827-1-darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-29 at 07:38 -0400, David Arcari wrote:
> Currently, tpmi_get_logical_id() calls topology_physical_package_id()
> to set the pkg_id of the info structure. Since some VM hosts assign
> non
> contiguous package IDs, topology_physical_package_id() can return a
> larger value than topology_max_packages(). This will result in an
> invalid reference into tpmi_power_domain_mask[] as that is allocatead
> based on topology_max_packages() as the maximum package ID.
>=20
> Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU
> mapping")
> Signed-off-by: David Arcari <darcari@redhat.com>
    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> v2: fixed underlying issue in tpmi_get_logcal_id() instead of
> =C2=A0=C2=A0=C2=A0 preventing access in tpmi_cpu_online().
>=20
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
> =C2=A0drivers/platform/x86/intel/tpmi_power_domains.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c
> b/drivers/platform/x86/intel/tpmi_power_domains.c
> index 9d8247bb9cfa..8641353b2e06 100644
> --- a/drivers/platform/x86/intel/tpmi_power_domains.c
> +++ b/drivers/platform/x86/intel/tpmi_power_domains.c
> @@ -178,7 +178,7 @@ static int tpmi_get_logical_id(unsigned int cpu,
> struct tpmi_cpu_info *info)
> =C2=A0
> =C2=A0	info->punit_thread_id =3D FIELD_GET(LP_ID_MASK, data);
> =C2=A0	info->punit_core_id =3D FIELD_GET(MODULE_ID_MASK, data);
> -	info->pkg_id =3D topology_physical_package_id(cpu);
> +	info->pkg_id =3D topology_logical_package_id(cpu);
> =C2=A0	info->linux_cpu =3D cpu;
> =C2=A0
> =C2=A0	return 0;


