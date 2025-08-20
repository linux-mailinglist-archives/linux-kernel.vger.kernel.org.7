Return-Path: <linux-kernel+bounces-778042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6B9B2E0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A7B643BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E4334367;
	Wed, 20 Aug 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQweiP4g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA60334365
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702215; cv=none; b=CP9yxY6xrqVWFxYqUTTlYLhQxbvfY/J08UAXloOt+oQpOcDUEICaEa4uZKVL6il629ZSY1OyWXARRrB7Fj9nifqL2I3+ybu8s0Ah//Orc1QyemoMFmcyIX+SNX7k3gdml00CZZjnk80S5jC84Adg3N5Gx4ZwabkT0OApQ57wpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702215; c=relaxed/simple;
	bh=PcW1KNcPW+hWokoucPIYlF4L2HxPdllxak/MzbEoTcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XDHFhKnTprfg96jNapkaz3LElfYgEtIrpXTwhmZPPUoLUAOzsx4bDvop+Gm56JvuDonJke06ifsBnM7jqml6W9GhDlq7SR/EriZLkrvzg6rZ6q5Pw411JaQwF4FDINQCjBO0a5Dix/MOU88s7XK8QKdE6bbTjeS1WOKNxCiSK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQweiP4g; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755702213; x=1787238213;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PcW1KNcPW+hWokoucPIYlF4L2HxPdllxak/MzbEoTcQ=;
  b=DQweiP4gtWp9GdexHtFIHqsYU1MWwzbKXVA14CXOVOeq+CvJyYTHNEOZ
   4kZG0kylb/7yqhjI3kEGL9Ua/UDUTlzUKRx1/MTyHxKuDOXV5FznHxuhi
   UcbgTHFLNVPx9Zk9aXvS9aCIA70mFhVBNi+xClEK/fEZ/QZu14oVkFx+h
   GOGf0JIotqoRp4HbD72Tr1nc44MdAFsqfrJAWoUFeVSYg2glDFIfAvPdq
   qtv4iNFsfl4VJ6s59wFBjHnTGS9p6T/QjqU0gJ0TU6hU6RzUBkGsUkyKm
   UfI/aLtS9vGMFfjme7X2cTj3oH7LNDQF0nLLGbJxoJLRhaXgesvBvrtvs
   w==;
X-CSE-ConnectionGUID: e8doe3swRmOZvGq6A5Rc3Q==
X-CSE-MsgGUID: H/lI8r+OTd6Q/yIEvks8vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75552567"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="75552567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:03:33 -0700
X-CSE-ConnectionGUID: hN9tjZPjSiSM+9ehxugYIA==
X-CSE-MsgGUID: pfV8cZ4oSjiRcxPNXcxzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173405726"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.205]) ([10.247.119.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:03:30 -0700
Message-ID: <7350db53-d5e6-4b3e-8686-3749353725a0@intel.com>
Date: Wed, 20 Aug 2025 08:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_fwctl: Remove the use of dev_err_probe()
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 Brett Creeley <brett.creeley@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "open list:FWCTL PDS DRIVER" <linux-kernel@vger.kernel.org>
References: <20250820124011.474224-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250820124011.474224-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 5:40 AM, Liao Yuanhong wrote:
> Logging messages that show some type of "out of memory" error are generally
> unnecessary as there is a generic message and a stack dump done by the
> memory subsystem. These messages generally increase kernel size without
> much added value[1].
> 
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value
> instead.
> 
> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/fwctl/pds/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 9b9d1f6b5556..8dd659aee256 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -481,7 +481,7 @@ static int pdsfc_probe(struct auxiliary_device *adev,
>  	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>  				   struct pdsfc_dev, fwctl);
>  	if (!pdsfc)
> -		return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
> +		return -ENOMEM;
>  	pdsfc->padev = padev;
>  
>  	err = pdsfc_identify(pdsfc);


