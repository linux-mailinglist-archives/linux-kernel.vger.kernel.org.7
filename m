Return-Path: <linux-kernel+bounces-827353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4571B91867
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E969518925D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2E30E0F7;
	Mon, 22 Sep 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIhPqGNd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8524221F0C;
	Mon, 22 Sep 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549177; cv=none; b=NNw+1VkVyjQyiMYG3+Y8qeb74lchwsK71nkC5LOvmdp6++jDoE+yNGo8j7jWg6kPT/6qNrpCZUsvkLegNqRD+cAfzF9bn/yz0JKUlbwKVmd/Vd6ImxL7do1IQP/KklmL8ZkVeXasTrjTkxfC1FjXMSijM+iXQbeIdCGzSSoD01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549177; c=relaxed/simple;
	bh=zCJ6uUOofn2XoIRVY+EzCUyKwOANO/PBG8qjf/GVMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btJ5IaUnzw+1oMnCjGMC4aIgGp39xEHgGxJQ4ZKfTjJdNpKfAN/8v73q65p5IbOUz7xZQfylu0Rl+KC9mnHHarLH71lbXQJBnYTBEtxeLYvnKxB3/03pL9P5idEj9flEPzegPCqGs/Ug3k/4t0T1HWsP7KiqWEVI/uxdtrc4Dl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIhPqGNd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758549176; x=1790085176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCJ6uUOofn2XoIRVY+EzCUyKwOANO/PBG8qjf/GVMRE=;
  b=GIhPqGNdl23XzdgfvqAhvspIJw1cNQnGQQ/LICNwGDi+H/C+NAmrdNLC
   Rbh5RwqOmND6clWT7MHVA+V0x+1+plxwMjy8xaM3R/rl+T5jIy0AyehN4
   Ub1OEvXRWLWEQSh+AApoiVbb1u80q+AdCp0I0XB6aL/HA3lrV/Pv25WpO
   K4JwuDNOCeuP+m2lAJHU5kPczKPwY8YcfNbrvSy1Pz7EBalA1CoeKCeEH
   BivBYI6UF4AEMwt8r6qeghHm7ZdJGiF4VEYb4VLAopIgzaMoeJScCIoRU
   NRk21K0MzRsKb9ELmgSJg3aWQuny6TsFcgnSbFCaEWxrwiwYctXR1pAMV
   w==;
X-CSE-ConnectionGUID: 5ilk1I4HTG6grM/NU8DtJA==
X-CSE-MsgGUID: Vdpo1X0LS+yYHrm78NiuEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60724426"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60724426"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 06:52:56 -0700
X-CSE-ConnectionGUID: EdcLVe1cQduVLZeapGGGOQ==
X-CSE-MsgGUID: gCnnAeqGQ9muL/FmLeNVrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="176305912"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 22 Sep 2025 06:52:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Sep 2025 16:52:51 +0300
Date: Mon, 22 Sep 2025 16:52:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] usb: typec: tipd: Fix error handling in
 cd321x_read_data_status
Message-ID: <aNFUs9CqtLq7ozOV@kuha.fi.intel.com>
References: <20250920-tipd-fix-v1-1-49886d4f081d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920-tipd-fix-v1-1-49886d4f081d@kernel.org>

On Sat, Sep 20, 2025 at 12:28:03PM +0000, Sven Peter wrote:
> Right now cd321x_read_data_status always returns true even if it
> encounters any errors: tps6598x_read_data_status returns a boolean but
> we treated it as an errno and then we have a bunch of dev_errs in case
> tps6598x_block_read fails but just continue along and return true.
> Fix that to correctly report errors to the callee.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-usb/aMvWJo3IkClmFoAA@stanley.mountain/
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 2b1049c9a6f3c4300f4a25a97fe502c47e82a134..d0c86347251c5cc19a9b377550c00c27966f8329 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -577,30 +577,36 @@ static bool cd321x_read_data_status(struct tps6598x *tps)
>  	int ret;
>  
>  	ret = tps6598x_read_data_status(tps);
> -	if (ret < 0)
> +	if (!ret)
>  		return false;
>  
>  	if (tps->data_status & TPS_DATA_STATUS_DP_CONNECTION) {
>  		ret = tps6598x_block_read(tps, TPS_REG_DP_SID_STATUS,
>  				&cd321x->dp_sid_status, sizeof(cd321x->dp_sid_status));
> -		if (ret)
> +		if (ret) {
>  			dev_err(tps->dev, "Failed to read DP SID Status: %d\n",
>  				ret);
> +			return false;
> +		}
>  	}
>  
>  	if (tps->data_status & TPS_DATA_STATUS_TBT_CONNECTION) {
>  		ret = tps6598x_block_read(tps, TPS_REG_INTEL_VID_STATUS,
>  				&cd321x->intel_vid_status, sizeof(cd321x->intel_vid_status));
> -		if (ret)
> +		if (ret) {
>  			dev_err(tps->dev, "Failed to read Intel VID Status: %d\n", ret);
> +			return false;
> +		}
>  	}
>  
>  	if (tps->data_status & CD321X_DATA_STATUS_USB4_CONNECTION) {
>  		ret = tps6598x_block_read(tps, TPS_REG_USB4_STATUS,
>  				&cd321x->usb4_status, sizeof(cd321x->usb4_status));
> -		if (ret)
> +		if (ret) {
>  			dev_err(tps->dev,
>  				"Failed to read USB4 Status: %d\n", ret);
> +			return false;
> +		}
>  	}
>  
>  	return true;
> 
> ---
> base-commit: a4e143636d5def935dd461539b67b61287a8dfef
> change-id: 20250920-tipd-fix-0c50f9f99a5a
> 
> Best regards,
> -- 
> Sven Peter <sven@kernel.org>
> 

-- 
heikki

