Return-Path: <linux-kernel+bounces-874293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3582C15FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76783A82FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF38220F49;
	Tue, 28 Oct 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR2Bzabm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22472853E0;
	Tue, 28 Oct 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670302; cv=none; b=W6TX8/YGnqEFyYZ0sSc6DHAeg1EUHOHpEhsjIVupBW7fTvX84sEu5fczOWTo6BSOSDRA+vcx9bPliXscikVIGqxVXYPwBmzJWrHGgtUTqR14h4ancPEkCqydX16dy63JXF3Odb0hYygN+jbA5B/FA1xQzwy9EZnjjzqyMVQWY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670302; c=relaxed/simple;
	bh=yoaFau88fu7GEnNGlir2HFlv0ume3b9rIw67jXjurk4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pBcqSlHYk9X+YMQ2lu0keJA9+hKHZSOYBLzT5P462lahyf8eIALLWr546RPU7GI1+DqrioMGyzSBr+Z2Y10Og49/KfYDrTz0ngTj3ZQtaDSER94rnflP1znK6PQsDX6kflXMTNCHPZ0Dh54mO0Qt4CpCw9J1TW5aNiBZ9NXOHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YR2Bzabm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761670301; x=1793206301;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yoaFau88fu7GEnNGlir2HFlv0ume3b9rIw67jXjurk4=;
  b=YR2BzabmLd9xBZwbgt5I96w/ctQJsmsUOI6HgxC1YBv/GoPSoJ9JZCuJ
   Qkt4qLIz1gaxhEVBkbnPgHdiXtVv4M/xh/b0tCwg6eU+93GwB7S2rp9Un
   Zs/zBweZbJ4lqed/vx4KjluDyrFsJCxrCIwaOAAFySyEh2id4KJSfROMR
   TxNRYsg8jDwmJITA6sXkuMtrkeM+O89bT008+ug+RtclGbDHC4vMOo+NB
   4ALGlUNvhcHGfbHf6enyI/EhxUkWE3VSmyzTCLSHShBhCeFUb37l+DzxK
   2oFvcORhKcpxLcoarMQVZKlI9W6NZxq8uTV24hsivY406yy6jxws9k5fE
   g==;
X-CSE-ConnectionGUID: rTSIRKnjQReO4DqGBt8TjA==
X-CSE-MsgGUID: 45UUK/iIQDGABh1X+qFlLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67616639"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67616639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:51:40 -0700
X-CSE-ConnectionGUID: dp86btRNTFOOHhcMBxtn+w==
X-CSE-MsgGUID: 1bU5Q4avTXS9EZJaPHIXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189718688"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:51:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Oct 2025 18:51:34 +0200 (EET)
To: Lazar Aleksic <kripticni.dev@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform: x86: Kconfig: fix minor typo in help for
 WIRELESS_HOTKEY
In-Reply-To: <20251017183521.16268-1-kripticni.dev@gmail.com>
Message-ID: <453fa860-feb7-fe7f-34eb-4b023262cb41@linux.intel.com>
References: <20251017183521.16268-1-kripticni.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Oct 2025, Lazar Aleksic wrote:

> From: kripticni <kripticni.dev@gmail.com>
> 
> Fixed a misspelling of Xiaomi
> 
> Signed-off-by: kripticni <kripticni.dev@gmail.com>

Hi,

Thanks for the patch. In order to apply it, we need to have your name in 
the Signed-off so please send v2 with that corrected.

-- 
 i.


> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 46e62feeda3c..c122016d82f1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -432,7 +432,7 @@ config WIRELESS_HOTKEY
>  	depends on INPUT
>  	help
>  	 This driver provides supports for the wireless buttons found on some AMD,
> -	 HP, & Xioami laptops.
> +	 HP, & Xiaomi laptops.
>  	 On such systems the driver should load automatically (via ACPI alias).
>  
>  	 To compile this driver as a module, choose M here: the module will
> 


