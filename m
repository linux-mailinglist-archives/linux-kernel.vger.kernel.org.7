Return-Path: <linux-kernel+bounces-776450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA17B2CD76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059175625D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A6266565;
	Tue, 19 Aug 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU5CuMoJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576E230BFF;
	Tue, 19 Aug 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633794; cv=none; b=OUSYD2iaD3pMTrCxtlSL0WATSTTZloT2ZYvLQLPbtNo9E+Yn81BIavFV/hVZUIHWiE//XdWoC4CoO1S99Fo3d/8CvuZctGOp1hOe2lvmnZiQUkc3Y/uFdBfhrx+jqMlnldx0zMpKyA6TEmZk5mqkx4SQalSnDG7EHBbV9TbbV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633794; c=relaxed/simple;
	bh=8a3LDRek7pclDiu8iThGNBYfwJ8V6jmoHiPtnYxBEWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saMX+KVPvbodUZiv/mihjpQhVoZ2cVkdFDspiK7sJvJuk1WnkvrMjzdi5CcwG8NDgI3ojqkoUey2ObWQ9iJuF43HJRcgf8GhB04/3ie+PVVwtru4PsTg2xJOBV4P/nEpa98HrYTdU0sxu3MEX/n4FyrOAqCxXA1zsjbJAQ9zUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU5CuMoJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755633793; x=1787169793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8a3LDRek7pclDiu8iThGNBYfwJ8V6jmoHiPtnYxBEWU=;
  b=nU5CuMoJvmF0gzIMTtMwPM9KLr/Of2iDiRHA44WC0/rC7IZMjcxwFnE+
   Nexn1RaTqqkes7q6Bzy/Uo0OMorpt1THJQKRFTF4aJls0HDH3wX5pMnTk
   l3M7K6mZj9MeZ7ZefLMsCzadnWhv/z1Qb4GV17MboNg57UnF1TjKhtq3R
   bZoNVptE1DG2iLr6lso6wpAnCkGJP64IEzNA9RLU76bm5dErmoT0KjhJA
   HYp30VRsSHSj2fJKvWuEbyCO/PDSlqCl0ywkWu/UoRNKGIF1+Viv9c33J
   Q1NlA5RhawjXrFyKqUIn5aIufgIFiEcMWw/iSF7GlYY0WUv8Oe5mrG3t0
   w==;
X-CSE-ConnectionGUID: qZ/AtG1MSAiWyxfS2qgctQ==
X-CSE-MsgGUID: RF8LerhVRZu4kqCEwDUY2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57097337"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57097337"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:02:54 -0700
X-CSE-ConnectionGUID: SWnQ9BAtSFOGqsBdONpLcA==
X-CSE-MsgGUID: WzaNQ9nMSOyVGvgXjv4qPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168729201"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO localhost) ([10.124.220.219])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:02:53 -0700
Date: Tue, 19 Aug 2025 13:02:52 -0700
From: David Box <david.e.box@linux.intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
	David E Box <david.e.box@intel.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/pmc: use kcalloc() instead of
 kzalloc()
Message-ID: <g5qqewwjflr7uzuhwcjbbykjj2lf2civ5vcltehgddjpc5abv5@2abp2b4r6kyg>
References: <20250819135155.338380-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819135155.338380-1-rongqianfeng@vivo.com>

On Tue, Aug 19, 2025 at 09:51:55PM +0800, Qianfeng Rong wrote:
> Replace devm_kzalloc() with devm_kcalloc() in pmc_core_get_tgl_lpm_reqs().
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer
> overflow.
> 
> Using devm_kcalloc() provides built-in overflow protection, making the
> memory allocation safer when calculating the allocation size compared
> to explicit multiplication.
> 
> [1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: David E. Box <david.e.box@intel.com>

Thanks

> ---
>  drivers/platform/x86/intel/pmc/tgl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index 02e731ed3391..fc5b4cacc1c6 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -273,8 +273,8 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
>  
>  	addr = (u32 *)out_obj->buffer.pointer;
>  
> -	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
> -				     GFP_KERNEL);
> +	lpm_req_regs = devm_kcalloc(&pdev->dev, lpm_size, sizeof(u32),
> +				    GFP_KERNEL);
>  	if (!lpm_req_regs)
>  		goto free_acpi_obj;
>  
> -- 
> 2.34.1
> 
> 

