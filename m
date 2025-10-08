Return-Path: <linux-kernel+bounces-845607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6732BC5824
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 441AF34F13B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3FA288513;
	Wed,  8 Oct 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTG5irjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26D1AA1D2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935825; cv=none; b=jktDULe/aKZdiiO3YxSCdz1e0EDwdkbKnm9y6CrC9Lj1saAvexQz4DvZokwxBCk2xWKTX2UuSSOb+Y4kMe8HJXX5ZvlP4WmWtd90Qqm2hi/YnBwJ3I/y3OzdZZAwSsOa/b+IhVqo5lxA0tuQO+lgGl9SXcjRMQ7y7fn3id35B7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935825; c=relaxed/simple;
	bh=bTO4eQ7sdiDVbau4hRFaoBOduo/himBoHKTVgRQAWak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZp+Qvq1kQIrRKKnjQZIbLFi6f69F/mRb0AG12IA555pAZnuNf7r1pWu5C35bYE/tS7OLnQIwuBr9boiiTNHJBQ9kFA9zj4/CcGVjwmfOPXO73uJ5rbD/JARvYgt/Iv+Mz4XwrUAvCHdQ4TXQ2Eo1f00ZSRII7A/ozmcpRSkjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTG5irjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1CEC4CEE7;
	Wed,  8 Oct 2025 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759935825;
	bh=bTO4eQ7sdiDVbau4hRFaoBOduo/himBoHKTVgRQAWak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TTG5irjh+c4NlBzW0xbWfcvnyEKO0TJm56Yz86sy8os96eeiooHK92V+nCVCArA6X
	 Dn2weJ4Eoc0N90LHBkKRcTcAJsm7j8KMhPLa6ecA3ct45Ryjf81KATSX+bzkC8V9tC
	 TeWD+o1Sw4WBJRVDQ3r2eOnp4ofxz3y2zwxJNNqrUEPHe3Z/eIxA4q79peKPkGmKfs
	 RHyWAionzRgxxvjLCWTKkS37xlB0Sgil6Xs4+cNI9SKeXRp/AZ06LrGxputlxp8903
	 auY8MdTBIm5QIjGTZd7nc8ep11Dfn8YdvFdK+Gho6Eyrr+UYYo2VNtmOWlNLsKLztd
	 RCSQ87tbkweMw==
Message-ID: <bb0e5610-2c59-4d74-9585-d9238e7143d6@kernel.org>
Date: Wed, 8 Oct 2025 10:03:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Resume power for creating and destroying
 hardware context
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251008045324.4171807-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251008045324.4171807-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 11:53 PM, Lizhi Hou wrote:
> When the hardware is powered down by auto-suspend, creating or destroying
> a hardware context without resuming power will fail.
> Call amdxdna_pm_resume_get() before requesting the hardware to create or
> destroy a hardware context.
> 
> Fixes: 063db451832b ("accel/amdxdna: Enhance runtime power management")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 691fdb3b008f..ab4d66f1325d 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -610,10 +610,14 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		goto free_entity;
>   	}
>   
> +	ret = amdxdna_pm_resume_get(xdna);
> +	if (ret)
> +		goto free_col_list;
> +
>   	ret = aie2_alloc_resource(hwctx);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Alloc hw resource failed, ret %d", ret);
> -		goto free_col_list;
> +		goto suspend_put;
>   	}
>   
>   	ret = aie2_map_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
> @@ -628,6 +632,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		XDNA_ERR(xdna, "Create syncobj failed, ret %d", ret);
>   		goto release_resource;
>   	}
> +	amdxdna_pm_suspend_put(xdna);
>   
>   	hwctx->status = HWCTX_STAT_INIT;
>   	ndev = xdna->dev_handle;
> @@ -640,6 +645,8 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   
>   release_resource:
>   	aie2_release_resource(hwctx);
> +suspend_put:
> +	amdxdna_pm_suspend_put(xdna);
>   free_col_list:
>   	kfree(hwctx->col_list);
>   free_entity:


