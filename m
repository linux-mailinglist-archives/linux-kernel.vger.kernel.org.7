Return-Path: <linux-kernel+bounces-763116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82784B21068
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EEB18A1A28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9A2E54AA;
	Mon, 11 Aug 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjfjJaaV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3602E540A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926128; cv=none; b=SCb7scUHt2gBg0tGbB3+/5blgdoALs4iKJQ/iN0OOygzrQswKJq5yrvJ6p3ju67PPqgjJ1KeTTFzoF8MFhY1S26A7MtYO+APNBlzt8/h6pl2AqfZYTLFbualh17EYewvPXo1Urhrcx2EHAsqFjatvHtZNeocjT0PJ0zUA7H+8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926128; c=relaxed/simple;
	bh=v56uFo/zmEfwlvgP587eD8BCei4dxB+Jq5fyld4IwAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Olca9306E9IQ9RNUHXgYm1fRR0IroX37qQsJCFfNgGH9OK/2XlzSaLHq1pxtjOCmeED/jJHvBuFxjXYErucsXJvbwM3RXBDXTwNt94E5eP96M5G+LGPORaqEauSTPpqdm2UcRU1i03QG7SVDtSJ1bpX4nrQIpazIUtSOhZOuXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjfjJaaV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754926127; x=1786462127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v56uFo/zmEfwlvgP587eD8BCei4dxB+Jq5fyld4IwAc=;
  b=jjfjJaaVifl0i/Xok5/upRc9SdZEfADGQTFYPr8Jk82wHfxaR5R3bBqe
   NJkK6+rqOu8J3yB4SmKCXqW9BxJpt+VNmi6BzitmqcVL3kcQ+npNEL7xP
   0Mum568cGdPiF87Y6C3EET/n9lvl4jP+ig5MGjF6VMsJCzbgM7jyJef7D
   1UOSmC7zDv9X7RJyBCvfb19Y849a2LAlTj6JgI0GO4Q9zqwJ683YtjewR
   UJVD6hUVjXF/2Ec34p6BQyumECAcLHotZPua94xybzblUe2AplF1fVUY3
   JCtdd2c4qeUJOZKumNIa/hmCth5TA+ohUILnfOEorlT2tFwkFm7TnVoo0
   w==;
X-CSE-ConnectionGUID: dz/2UvcjSCC57HAUarZqQw==
X-CSE-MsgGUID: W/reysVCQb+TZU9XY7RhJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57086475"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57086475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:28:46 -0700
X-CSE-ConnectionGUID: lSCeqRbBRo2/RcAUEmf67g==
X-CSE-MsgGUID: USPqmt9CT9S0DfZMbpxR7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165190765"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.140]) ([10.247.119.140])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:28:41 -0700
Message-ID: <bbfd790f-99be-4ee3-a2b8-998f9eee9679@intel.com>
Date: Mon, 11 Aug 2025 08:28:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, saeedm@nvidia.com,
 itayavr@nvidia.com, jgg@ziepe.ca, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
 skhan@linuxfoundation.org
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/25 11:17 AM, Akhilesh Patil wrote:
> Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> Avoid potential memory management issue by matching alloc/free routines.
> 
> Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/fwctl/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> index f93aa0cecdb9..4b379f695eb7 100644
> --- a/drivers/fwctl/mlx5/main.c
> +++ b/drivers/fwctl/mlx5/main.c
> @@ -345,7 +345,7 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  	 */
>  	if (ret && ret != -EREMOTEIO) {
>  		if (rpc_out != rpc_in)
> -			kfree(rpc_out);
> +			kvfree(rpc_out);
>  		return ERR_PTR(ret);
>  	}
>  	return rpc_out;


