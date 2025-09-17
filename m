Return-Path: <linux-kernel+bounces-821123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BEB807DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F7E1BC3CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F43333AB3;
	Wed, 17 Sep 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMzvxYE1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F8333AB5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122542; cv=none; b=vC5Z0elY9ei1rlgKVDoyOgA6ZBA91tTpdec/a7OfzteO3YNyCfEHnq4EG7vnABMRDLZmiB2sXAC9tv3Em5o+gbIXFIu0gp6/uvh8GFeK5bpqgqfJWlLASBvSPWi/D4/5aEl+GFiHOBmivVLadpiDPxCqLt5EPdHGruH3YlzF6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122542; c=relaxed/simple;
	bh=G/bV8fRNuXhxBDfwwFFEsp0hzSbHLbcHv/U1NKTsReY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KofaKr6jOhKsyijKEiEr+q+o9BEwJYfBD9xFxuIYNg5Jk/wcbAW2ha2hAsjvViuuVVi9QixjQvAB3BrRevkFMtYORJFHVvgog+hNUdMlZlTmuoUyT5CSiMbBU4IdRzy3uPhz7CAW0S+Pwrr+qprDX9FDcsyV9/s/xtKOxhEK654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMzvxYE1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758122540; x=1789658540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G/bV8fRNuXhxBDfwwFFEsp0hzSbHLbcHv/U1NKTsReY=;
  b=DMzvxYE1sCRMNxSbs5aRwbQikdpkn+Se4CAaeQ04qWHcl4J9DJoPFYun
   ua8x2WPHGq62PckU5H3PTdLeONQU9htxUXQfTP1PoDZqF08atREqWpcBv
   P2BpdBTYVtec8JzdJ0QZqnHHuP7YErdbWDZH8PQ+3J9gFjsvmtONUY4ur
   3tY4Qcw2ZvZDjYLMh/UCNvETko6cYCKB264skTCy+IHldQx40cEwZpYw5
   zOdMpgRonlormIfaTbuD1aICVJ2zg0GNBdGdrrhR9K1Vognd/0iyxy9F3
   8tZ1JmI79GRwrrhwqgUPW5/7i3JyEIJIcU7OZLkcAfMcI/pwOReYlcSM/
   Q==;
X-CSE-ConnectionGUID: eSI5QQimSXCvqmaZYvat5w==
X-CSE-MsgGUID: TGd3uvGbQEu1zOoBvxnvlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="48007032"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="48007032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 08:22:18 -0700
X-CSE-ConnectionGUID: Y3ZkmuDhSEeH0TMd+gKnWQ==
X-CSE-MsgGUID: xZCP5nuQSGq+oATXotjpyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="212421123"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.223]) ([10.125.111.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 08:22:18 -0700
Message-ID: <4ba6e926-c658-45bd-a1ba-96255a7d3279@intel.com>
Date: Wed, 17 Sep 2025 08:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_fwctl: Replace kzalloc + copy_from_user with
 memdup_user in pdsfc_fw_rpc
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Brett Creeley <brett.creeley@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org
References: <20250917150941.168887-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250917150941.168887-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 8:09 AM, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify pdsfc_fw_rpc().
> 
> Return early if an error occurs and remove the obsolete 'err_out' label.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/fwctl/pds/main.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 9b9d1f6b5556..04d84f892fb8 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/vmalloc.h>
>  #include <linux/bitfield.h>
> +#include <linux/string.h>
>  
>  #include <uapi/fwctl/fwctl.h>
>  #include <uapi/fwctl/pds.h>
> @@ -366,18 +367,10 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  		return ERR_PTR(err);
>  
>  	if (rpc->in.len > 0) {
> -		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
> -		if (!in_payload) {
> -			dev_err(dev, "Failed to allocate in_payload\n");
> -			err = -ENOMEM;
> -			goto err_out;
> -		}
> -
> -		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
> -				   rpc->in.len)) {
> +		in_payload = memdup_user(u64_to_user_ptr(rpc->in.payload), rpc->in.len);
> +		if (IS_ERR(in_payload)) {
>  			dev_dbg(dev, "Failed to copy in_payload from user\n");
> -			err = -EFAULT;
> -			goto err_in_payload;
> +			return in_payload;
>  		}
>  
>  		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
> @@ -453,7 +446,6 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  				 rpc->in.len, DMA_TO_DEVICE);
>  err_in_payload:
>  	kfree(in_payload);
> -err_out:
>  	if (err)
>  		return ERR_PTR(err);
>  


