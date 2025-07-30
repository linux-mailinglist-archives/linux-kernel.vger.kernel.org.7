Return-Path: <linux-kernel+bounces-750574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490BB15E37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A433AFAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C626E6ED;
	Wed, 30 Jul 2025 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlLcHO1U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2F7E0E4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871537; cv=none; b=TF6hU/DwKt/bEEPSVF7+exOeOwySae5Zv8oJyPw9ixQYdWszyU4zjlp7QZ6QJ2bCx+GnnrPfJ+eEG6XPX8no9RYTBQuLcI92lUxSk1LOvJ5R4VLTHIlAApXS5vtJcFak4qEcNoZqulDXDCC0KkXFd3207nvaaRKjsnixycUPqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871537; c=relaxed/simple;
	bh=xY0cGAduPMxd5tMAYBCMfqbxzSqavrO5JyNnwoCIJHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQ9+pQwyvQuIxvW5z83P+jDwBEEg6G1ZFbbQYg2E05C1DDmySMEbpb2JhtTmt4j2KLVU7cn23cN7gkDFWtVNR3EN3PTBytLZabCslDghgPhZC5MIa/21hUCZpcdjoAogd1Utcq5IBveMedHNQdJPg+jScD2Xg8kTkR6j/snxn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlLcHO1U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753871536; x=1785407536;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xY0cGAduPMxd5tMAYBCMfqbxzSqavrO5JyNnwoCIJHQ=;
  b=mlLcHO1UtPvyAkVEi6DWUxZkIXMG0cDMcgZjvsh6Ks3vKcNWFXr7sa3b
   yHRJPByCtD0xo6vwp2g3UnlzwekgqiQX0t3CCuhgzN8FIUT/DHCy5vk2V
   9t+mMFNjHhBjyzMf8kWF5FbYdmxQlSCud7PYhnY+7LJcLd73foPLTnamJ
   L49Ms7FBNcyyIunbi3mmBid/jic9APRd7kwAtbjO1lT85U9eyBinXcosr
   zh9MJVfLotVghuzQ1S25IzJr3HvtgK9pH/l4LbL7myWfyFrpcM2wPeIxG
   fo5nW9fE5Q6qEPmu3w1RkYSCGfx/YGgWuB2E6BEbQXRAwDMqh00Ra82Hu
   w==;
X-CSE-ConnectionGUID: dr0xeJbJQdO+FJofY5klBg==
X-CSE-MsgGUID: CAK8OvvPTzOWPf9YKlS34g==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="59808647"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="59808647"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 03:32:15 -0700
X-CSE-ConnectionGUID: eI3AQv9KRMevZgfTBjMV8w==
X-CSE-MsgGUID: ltEV/2/KTsCZXYhDXdqRuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162979081"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.74])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 03:32:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tomas Winkler <tomasw@gmail.com>, Alexander Usyskin
 <alexander.usyskin@intel.com>, Raag Jadav <raag.jadav@intel.com>
Cc: linux-mtd@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
In-Reply-To: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>
Date: Wed, 30 Jul 2025 13:32:07 +0300
Message-ID: <d947168fd02d6f820159b456099e6aa8f465b633@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 30 Jul 2025, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Intel Discrete Graphics non-volatile memory is onlt present on intel
> discrete graphics devices, and its auxiliary device is instantiated by
> the Intel i915 and Xe2 DRM drivers.  Hence add dependencies on DRM_I915
> and DRM_XE, to prevent asking the user about this driver when
> configuring a kernel without Intel graphics support.
>
> Fixes: ceb5ab3cb6463795 ("mtd: add driver for intel graphics non-volatile memory device")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/mtd/devices/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index 46cebde79f34b0b7..f0ab74d695347117 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -185,8 +185,8 @@ config MTD_POWERNV_FLASH
>  
>  config MTD_INTEL_DG
>  	tristate "Intel Discrete Graphics non-volatile memory driver"
> -	depends on AUXILIARY_BUS
> -	depends on MTD
> +	depends on AUXILIARY_BUS && MTD
> +	depends on DRM_I915 || DRM_XE || COMPILE_TEST

I understand the intent, but IIUC auxiliary bus usage should not require
a "depends on" relationship. Couldn't you have MTD_INTEL_DG=y and
DRM_I915=m just fine?

BR,
Jani.


>  	help
>  	  This provides an MTD device to access Intel Discrete Graphics
>  	  non-volatile memory.

-- 
Jani Nikula, Intel

