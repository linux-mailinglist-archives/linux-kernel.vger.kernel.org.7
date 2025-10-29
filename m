Return-Path: <linux-kernel+bounces-877035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D84C1D084
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356564078E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75171C5D46;
	Wed, 29 Oct 2025 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npKUKx/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA02F12C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766733; cv=none; b=R8JJkPnZokSBRZPy3C26AMK/DoQXpT3VF4i2zwz6dDoBaZGX/clXnV9IgQSW7/QkYcoVVULVSBbEgoU4JHtpifGwtlzsprWLfnhb1FziYEuOVAtgLtk8doASvaNx1rvnWshnBTZW4Jb7xSeZnZaOgac7OEsBpA+q5/qCZwbJvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766733; c=relaxed/simple;
	bh=R89zVkSXHPeEUzwsnlWJmQ0tSs3mFYIilk13mLGeMZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcCeGpOkV5BdC5RVgS2voic4hhej5qVqBpGFepXSR5Eyzizmw9SCLaLioTxieUMB6KX8GwP8aX7h7iDeCw/w3Hw/Dx3vDwn7xkJaCamD1RwKEV2xiXQSm6TRDX5KsStKgAsYGEyYOjEaGwv1lZf9h/5TCCuae3OD18UOKCXC4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npKUKx/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11495C4CEF7;
	Wed, 29 Oct 2025 19:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761766732;
	bh=R89zVkSXHPeEUzwsnlWJmQ0tSs3mFYIilk13mLGeMZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=npKUKx/40kHFfIyiGGiN9esDR0joALFg6IPbwTKB+YgR8go0U/syXNZtR95dqdIhK
	 Sy0GX5OTR5wIeNXtYLiSBbUd2fdM37drGoVvDZ7sWNmGGPCjG0mUbjSeiMbRxuJk1B
	 2/YfHJKk8m5DT3WfRfVxVITQIuWotsvQOajWFg7dN8HbrMdUsi/0PImFboWeG57dr5
	 Wt4O76Yx+WXL+8LbtjorsjvWSlzLxK+WsNpJuuqOG+YyoUvU3qIlgSlHzgVb2dKHsH
	 XSX0p6OTLZGno3QrChv3R2jOt1vIDrwDx3twlI4G8PSTYWwH+0VOQUCPyEykNuNQrB
	 wOEpADb4Tmrlg==
Message-ID: <8324911f-ff49-457c-9021-a860d2d4c0c7@kernel.org>
Date: Wed, 29 Oct 2025 14:38:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Fix incorrect command state for timed
 out job
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20251029193423.2430463-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251029193423.2430463-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 2:34 PM, Lizhi Hou wrote:
> When a command times out, mark it as ERT_CMD_STATE_TIMEOUT. Any other
> commands that are canceled due to this timeout should be marked as
> ERT_CMD_STATE_ABORT.
> 
> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/accel/amdxdna/aie2_ctx.c    | 15 +++++++++++++--
>   drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index c6c473c78352..289a2aaf4cae 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -204,10 +204,13 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
>   
>   	cmd_abo = job->cmd_bo;
>   
> -	if (unlikely(!data))
> +	if (unlikely(job->job_timeout)) {
> +		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
> +		ret = -EINVAL;
>   		goto out;
> +	}
>   
> -	if (unlikely(size != sizeof(u32))) {
> +	if (unlikely(!data) || unlikely(size != sizeof(u32))) {
>   		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
>   		ret = -EINVAL;
>   		goto out;
> @@ -258,6 +261,13 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
>   	int ret = 0;
>   
>   	cmd_abo = job->cmd_bo;
> +
> +	if (unlikely(job->job_timeout)) {
> +		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>   	if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
>   		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
>   		ret = -EINVAL;
> @@ -370,6 +380,7 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
>   
>   	xdna = hwctx->client->xdna;
>   	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
> +	job->job_timeout = true;
>   	mutex_lock(&xdna->dev_lock);
>   	aie2_hwctx_stop(xdna, hwctx, sched_job);
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index cbe60efbe60b..919c654dfea6 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -116,6 +116,7 @@ struct amdxdna_sched_job {
>   	/* user can wait on this fence */
>   	struct dma_fence	*out_fence;
>   	bool			job_done;
> +	bool			job_timeout;
>   	u64			seq;
>   	struct amdxdna_drv_cmd	*drv_cmd;
>   	struct amdxdna_gem_obj	*cmd_bo;


