Return-Path: <linux-kernel+bounces-887200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37638C37870
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C203B75B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B6340A64;
	Wed,  5 Nov 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flSJsdDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACD321F42
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371789; cv=none; b=NLt31ExPc1JvA2xqe4/xkWRaW96hP4RuPyrzfGI3hLA/6hUc+DPfuf1xD3ObNtR8WH0cC8abighAAuTy11fjVOKqXkLY8XFSedYiqKbHJjXNZdxhPI3UDoSOjOom4FwGWpA0sNacwjdG0nMgP/BavFDoh+CQo9zd7JOeE4LWka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371789; c=relaxed/simple;
	bh=AUFy5GuBYkH+VL7Srm0AtXx8Hzt2VmGSak6WgKWlRTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN8lF9+lq8FFkxUuwO+yu/XxT978on7UxG6yz4gNQYGMDNWvG6YD7bFckHrf5jmNRheFk3M2MskiUjXwW4CpLPUtP4hR3NBixzsqKVa2hGb5JOJ8w3pfR8tY3sgXIpk6VPyKDSl6ySu5lwAegAJMvgoMczCZtpi2bJ5d6KuW77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flSJsdDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359BDC4CEF5;
	Wed,  5 Nov 2025 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762371788;
	bh=AUFy5GuBYkH+VL7Srm0AtXx8Hzt2VmGSak6WgKWlRTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=flSJsdDruhfK1i2/GpmuFwidjvY62sKLi8e/NB/c1Hi9EBFPDz8oQBaA9wp0H5p+B
	 EHYI5hov+mOh1h44X4xLnv4cZfFOhslVyN1wj+9HL8G76RfoXjSxTOYvhbb2+w3aob
	 34gHGcWGpvFEKIweAIEMEYHcmgFTB+qF4+ZnWsvku9pKQibQdBqyGVk8qv0OO3aKU+
	 vnIbmWkkJWQUXEGtSwiR08EukOHqtZn13bcrc59ymQhyxOONhDqi+CRlbukQxwe0Iq
	 F5m8oW99n7LkY9MLAjzB4LvOLo2i6uAodPKafgmS3cul26ddYwFh4XX/4EJ00UMweQ
	 XEqnAe9UIQTrQ==
Message-ID: <5e341c1b-4cb1-46b3-a8b2-2c6758017988@kernel.org>
Date: Wed, 5 Nov 2025 13:43:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Fix dma_fence leak when job is canceled
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251105194140.1004314-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251105194140.1004314-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2025 1:41 PM, Lizhi Hou wrote:
> Currently, dma_fence_put(job->fence) is called in job notification
> callback. However, if a job is canceled, the notification callback is never
> invoked, leading to a memory leak. Move dma_fence_put(job->fence)
> to the job cleanup function to ensure the fence is always released.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/accel/amdxdna/aie2_ctx.c    | 1 -
>   drivers/accel/amdxdna/amdxdna_ctx.c | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 2b51c5211c2d..e9dd9e03ef07 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -189,7 +189,6 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>   
>   	up(&job->hwctx->priv->job_sem);
>   	job->job_done = true;
> -	dma_fence_put(fence);
>   	mmput_async(job->mm);
>   	aie2_job_put(job);
>   }
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 878cc955f56d..d17aef89a0ad 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -422,6 +422,7 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
>   	trace_amdxdna_debug_point(job->hwctx->name, job->seq, "job release");
>   	amdxdna_arg_bos_put(job);
>   	amdxdna_gem_put_obj(job->cmd_bo);
> +	dma_fence_put(job->fence);
>   }
>   
>   int amdxdna_cmd_submit(struct amdxdna_client *client,


