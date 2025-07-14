Return-Path: <linux-kernel+bounces-730776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3912B049A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F761AA0100
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379A263F4A;
	Mon, 14 Jul 2025 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPpRZB/k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56872253A7;
	Mon, 14 Jul 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529285; cv=none; b=AkzLXMVor49+nF2OOp3RAgXdOrrYzxUhMJ73EDnzEjWq/9/QbFWZLQMA5IBz/ZHTA7KuImSW4q+8Uzmo8dlq2kMhBDai/xm6/O/JGCF6zMj75GTNDRL8zvXM8TTRVPQZeGskf4LKurLa3VyeGM1MqTZ/K76BDYHbiPTayQ5W3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529285; c=relaxed/simple;
	bh=B9AlzhJyxEyJt8bmyvWUtEjGTV8ckWRt5CPFA2L78LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt54NGaRSOwuwtT97DqQNC3Y/aXiXrSX/fDhPjjRClcbrzDp1OvxzqOUksuVA5/i3MfWPqjJ8aqfibdzar5PclfUxoWoIVJvE9k0O/TlZRDW3P+w3z6Ii3d+oQgrt/hN7r217UFDsQVuZOMCWT8UHSz48B+z4JAGArygu5qCVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPpRZB/k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752529283; x=1784065283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B9AlzhJyxEyJt8bmyvWUtEjGTV8ckWRt5CPFA2L78LA=;
  b=TPpRZB/k0wNLbJoyClAx5pQeQx2asO443ew/1GXTX65OV1iRLMwIKXr9
   ZHGKVRbOw2mRxs80aFjtn+chKgHP/GVaOCgWHzyperlz7auwLLUGPTlLT
   b6kQPJ40fz7QXGRa0AEuBTjYDWe8jiIMArb2vpBYJV7826mFK3RHc+TS6
   uLEvnnvo0xBze8c1Rx46kESNsLNTbwfYyDePKtgiD8h4x7wfppIvR/T2e
   Sgu763CyJjhYaj8qm6aGOfBvK0gznGGlESPkTAyLArcphCH4wJ5eCi4Ek
   8Tc/XiP83jMreLzlsv5/1pL+gupZjDwHVBYcKgoHAHb9v8u2xn+4mrMZ/
   w==;
X-CSE-ConnectionGUID: Iwv6od1mStu+dak/lFKBMg==
X-CSE-MsgGUID: KX4exX27Q2CQdUPhzHmh4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58541058"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="58541058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:41:22 -0700
X-CSE-ConnectionGUID: H03IYVhLRi+Xu0K8KMkZbQ==
X-CSE-MsgGUID: zciLo+LwR4edXAuKnj2+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157547312"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:41:21 -0700
Date: Mon, 14 Jul 2025 14:41:19 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	ashok.raj.linux@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Update entries for IFS and SBL drivers
Message-ID: <aHV5f-DlLMZk2Lhv@agluck-desk3>
References: <20250714164643.3879784-1-jithu.joseph@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714164643.3879784-1-jithu.joseph@intel.com>

On Mon, Jul 14, 2025 at 09:46:43AM -0700, Jithu Joseph wrote:
> Update the MAINTAINERS file to reflect the following changes for two Intel
> platform drivers:
> 
> - Tony has agreed to take over maintainership of the Intel In-Field Scan
>   (IFS) driver, and is now listed as the new maintainer.
> - Remove myself as the maintainer for the Slim BootLoader (SBL) firmware
>   update driver and mark it as Orphan. To the best of my knowledge, there
>   is no one familiar with SBL who can take over this role.
> 
> These changes are being made as I will soon be leaving Intel.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fad6cb025a19..9b90f434101b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12185,9 +12185,8 @@ F:	drivers/dma/idxd/*
>  F:	include/uapi/linux/idxd.h
>  
>  INTEL IN FIELD SCAN (IFS) DEVICE
> -M:	Jithu Joseph <jithu.joseph@intel.com>
> +M:	Tony Luck <tony.luck@intel.com>

Acked-by: Tony Luck <tony.luck@intel.com>

>  R:	Ashok Raj <ashok.raj.linux@gmail.com>
> -R:	Tony Luck <tony.luck@intel.com>
>  S:	Maintained
>  F:	drivers/platform/x86/intel/ifs
>  F:	include/trace/events/intel_ifs.h
> @@ -12527,8 +12526,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi.git
>  F:	drivers/net/wireless/intel/iwlwifi/
>  
>  INTEL WMI SLIM BOOTLOADER (SBL) FIRMWARE UPDATE DRIVER
> -M:	Jithu Joseph <jithu.joseph@intel.com>
> -S:	Maintained
> +S:	Orphan
>  W:	https://slimbootloader.github.io/security/firmware-update.html
>  F:	drivers/platform/x86/intel/wmi/sbl-fw-update.c
>  
> 
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> -- 
> 2.34.1
> 

