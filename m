Return-Path: <linux-kernel+bounces-756862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C635BB1BA80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAF07A213A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA229A333;
	Tue,  5 Aug 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWgBJMnu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B791E51EF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420078; cv=none; b=nH3CAms6yIllkwSt1W7M4K3urBvQgyYhgoOMYk8HApsJ62OJODLXyTdYWqoZa88sRJyeo4liz4OFnYbYnoA6Yga28fMA9ZH8AVvSCrjszQ/v1HdQa77zb7tm/Zi00h89KRt0v0+aFC0YpT9XOglqhkWWD22VlDJxJflVo6qZu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420078; c=relaxed/simple;
	bh=Eq+8/9N21uUABn7cM82efdGCZdsKLrvvKvKVERGXrMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgD8l9OAe4NsHtV6iaOXGuy3LD/FUFAua404zoWATE7/BosmiMv0oyat1roNORAkD0UJpMqfJNH8PGkf2tpy7Gn6j+Ru0igYU3ytqSNUVcqgKJH/j1kGAAKilqaxGMYgyk+B4TttoEV8q463KxDowLfk/j0cCIWrUMA1Jbl68T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWgBJMnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB60CC4CEF0;
	Tue,  5 Aug 2025 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754420077;
	bh=Eq+8/9N21uUABn7cM82efdGCZdsKLrvvKvKVERGXrMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UWgBJMnuWlhzUbBl/xwXY2/S6KDAAsIWAtTL8B3Jv7gnlle2dH7XjjHL5gN8Z2150
	 z98aLTu4LzhlYe4iNYCuIxhtGqw6dfJ74sxClUSOCHA8H7t77EIFkwpb13zQbkUIo/
	 BHF/iMb0I6CETWDifApRzCZBDM8r5ZVUxXF3RWWCoKsUXLFT2DEAr8ATyrVRTTKA2n
	 zD7u64bLNAoG9Eiaivgbgm78glRpu7x33oSjF+xH7xmZ1N6vERvDb9t5fi+eX+BpE3
	 EXkjSooG1oT5Eo2sEbfLxOVn/ouyiLn5c0doGpd4vYNv+eSqMoy60Q+TuhRsn7pGTw
	 rT992c/wJsH4A==
Message-ID: <4419fe5f-a500-4092-a1ea-32b714059c58@kernel.org>
Date: Tue, 5 Aug 2025 13:54:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Unify pm and rpm suspend and resume
 callbacks
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20250803191450.1568851-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250803191450.1568851-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/25 2:14 PM, Lizhi Hou wrote:
> The suspend and resume callbacks for pm and runtime pm should be same.
> During suspending, it needs to stop all hardware contexts first. And
> the hardware contexts will be restarted after the device is resumed.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org)

> ---
>   drivers/accel/amdxdna/aie2_ctx.c        | 59 ++++++++++----------
>   drivers/accel/amdxdna/aie2_pci.c        | 37 +++++++++++--
>   drivers/accel/amdxdna/aie2_pci.h        |  5 +-
>   drivers/accel/amdxdna/amdxdna_ctx.c     | 26 ---------
>   drivers/accel/amdxdna/amdxdna_ctx.h     |  2 -
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 74 +++----------------------
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  4 +-
>   7 files changed, 73 insertions(+), 134 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 2cff5419bd2f..910ffb7051f4 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -46,6 +46,17 @@ static void aie2_job_put(struct amdxdna_sched_job *job)
>   	kref_put(&job->refcnt, aie2_job_release);
>   }
>   
> +static void aie2_hwctx_status_shift_stop(struct amdxdna_hwctx *hwctx)
> +{
> +	 hwctx->old_status = hwctx->status;
> +	 hwctx->status = HWCTX_STAT_STOP;
> +}
> +
> +static void aie2_hwctx_status_restore(struct amdxdna_hwctx *hwctx)
> +{
> +	hwctx->status = hwctx->old_status;
> +}
> +
>   /* The bad_job is used in aie2_sched_job_timedout, otherwise, set it to NULL */
>   static void aie2_hwctx_stop(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hwctx,
>   			    struct drm_sched_job *bad_job)
> @@ -89,25 +100,6 @@ static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hw
>   	return ret;
>   }
>   
> -void aie2_restart_ctx(struct amdxdna_client *client)
> -{
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_hwctx *hwctx;
> -	unsigned long hwctx_id;
> -
> -	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	mutex_lock(&client->hwctx_lock);
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> -		if (hwctx->status != HWCTX_STAT_STOP)
> -			continue;
> -
> -		hwctx->status = hwctx->old_status;
> -		XDNA_DBG(xdna, "Resetting %s", hwctx->name);
> -		aie2_hwctx_restart(xdna, hwctx);
> -	}
> -	mutex_unlock(&client->hwctx_lock);
> -}
> -
>   static struct dma_fence *aie2_cmd_get_out_fence(struct amdxdna_hwctx *hwctx, u64 seq)
>   {
>   	struct dma_fence *fence, *out_fence = NULL;
> @@ -141,9 +133,11 @@ static void aie2_hwctx_wait_for_idle(struct amdxdna_hwctx *hwctx)
>   	dma_fence_put(fence);
>   }
>   
> -void aie2_hwctx_suspend(struct amdxdna_hwctx *hwctx)
> +void aie2_hwctx_suspend(struct amdxdna_client *client)
>   {
> -	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
>   
>   	/*
>   	 * Command timeout is unlikely. But if it happens, it doesn't
> @@ -151,15 +145,19 @@ void aie2_hwctx_suspend(struct amdxdna_hwctx *hwctx)
>   	 * and abort all commands.
>   	 */
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	aie2_hwctx_wait_for_idle(hwctx);
> -	aie2_hwctx_stop(xdna, hwctx, NULL);
> -	hwctx->old_status = hwctx->status;
> -	hwctx->status = HWCTX_STAT_STOP;
> +	guard(mutex)(&client->hwctx_lock);
> +	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +		aie2_hwctx_wait_for_idle(hwctx);
> +		aie2_hwctx_stop(xdna, hwctx, NULL);
> +		aie2_hwctx_status_shift_stop(hwctx);
> +	}
>   }
>   
> -void aie2_hwctx_resume(struct amdxdna_hwctx *hwctx)
> +void aie2_hwctx_resume(struct amdxdna_client *client)
>   {
> -	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
>   
>   	/*
>   	 * The resume path cannot guarantee that mailbox channel can be
> @@ -167,8 +165,11 @@ void aie2_hwctx_resume(struct amdxdna_hwctx *hwctx)
>   	 * mailbox channel, error will return.
>   	 */
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	hwctx->status = hwctx->old_status;
> -	aie2_hwctx_restart(xdna, hwctx);
> +	guard(mutex)(&client->hwctx_lock);
> +	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +		aie2_hwctx_status_restore(hwctx);
> +		aie2_hwctx_restart(xdna, hwctx);
> +	}
>   }
>   
>   static void
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 3474a8d4e560..6fc3191c3097 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -440,6 +440,37 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   	return ret;
>   }
>   
> +static int aie2_hw_suspend(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_client *client;
> +
> +	guard(mutex)(&xdna->dev_lock);
> +	list_for_each_entry(client, &xdna->client_list, node)
> +		aie2_hwctx_suspend(client);
> +
> +	aie2_hw_stop(xdna);
> +
> +	return 0;
> +}
> +
> +static int aie2_hw_resume(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_client *client;
> +	int ret;
> +
> +	guard(mutex)(&xdna->dev_lock);
> +	ret = aie2_hw_start(xdna);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Start hardware failed, %d", ret);
> +		return ret;
> +	}
> +
> +	list_for_each_entry(client, &xdna->client_list, node)
> +		aie2_hwctx_resume(client);
> +
> +	return ret;
> +}
> +
>   static int aie2_init(struct amdxdna_dev *xdna)
>   {
>   	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> @@ -901,8 +932,8 @@ static int aie2_set_state(struct amdxdna_client *client,
>   const struct amdxdna_dev_ops aie2_ops = {
>   	.init           = aie2_init,
>   	.fini           = aie2_fini,
> -	.resume         = aie2_hw_start,
> -	.suspend        = aie2_hw_stop,
> +	.resume         = aie2_hw_resume,
> +	.suspend        = aie2_hw_suspend,
>   	.get_aie_info   = aie2_get_info,
>   	.set_aie_state	= aie2_set_state,
>   	.hwctx_init     = aie2_hwctx_init,
> @@ -910,6 +941,4 @@ const struct amdxdna_dev_ops aie2_ops = {
>   	.hwctx_config   = aie2_hwctx_config,
>   	.cmd_submit     = aie2_cmd_submit,
>   	.hmm_invalidate = aie2_hmm_invalidate,
> -	.hwctx_suspend  = aie2_hwctx_suspend,
> -	.hwctx_resume   = aie2_hwctx_resume,
>   };
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 385914840eaa..488d8ee568eb 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -288,10 +288,9 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx);
>   int aie2_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
> -void aie2_hwctx_suspend(struct amdxdna_hwctx *hwctx);
> -void aie2_hwctx_resume(struct amdxdna_hwctx *hwctx);
> +void aie2_hwctx_suspend(struct amdxdna_client *client);
> +void aie2_hwctx_resume(struct amdxdna_client *client);
>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
> -void aie2_restart_ctx(struct amdxdna_client *client);
>   
>   #endif /* _AIE2_PCI_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index be073224bd69..b47a7f8e9017 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -60,32 +60,6 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>   	return &fence->base;
>   }
>   
> -void amdxdna_hwctx_suspend(struct amdxdna_client *client)
> -{
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_hwctx *hwctx;
> -	unsigned long hwctx_id;
> -
> -	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	mutex_lock(&client->hwctx_lock);
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
> -		xdna->dev_info->ops->hwctx_suspend(hwctx);
> -	mutex_unlock(&client->hwctx_lock);
> -}
> -
> -void amdxdna_hwctx_resume(struct amdxdna_client *client)
> -{
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_hwctx *hwctx;
> -	unsigned long hwctx_id;
> -
> -	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> -	mutex_lock(&client->hwctx_lock);
> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
> -		xdna->dev_info->ops->hwctx_resume(hwctx);
> -	mutex_unlock(&client->hwctx_lock);
> -}
> -
>   static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
>   				      struct srcu_struct *ss)
>   {
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index f0a4a8586d85..c652229547a3 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -147,8 +147,6 @@ static inline u32 amdxdna_hwctx_col_map(struct amdxdna_hwctx *hwctx)
>   
>   void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
>   void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
> -void amdxdna_hwctx_suspend(struct amdxdna_client *client);
> -void amdxdna_hwctx_resume(struct amdxdna_client *client);
>   
>   int amdxdna_cmd_submit(struct amdxdna_client *client,
>   		       u32 cmd_bo_hdls, u32 *arg_bo_hdls, u32 arg_bo_cnt,
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index f2bf1d374cc7..fbca94183f96 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -343,89 +343,29 @@ static void amdxdna_remove(struct pci_dev *pdev)
>   	mutex_unlock(&xdna->dev_lock);
>   }
>   
> -static int amdxdna_dev_suspend_nolock(struct amdxdna_dev *xdna)
> -{
> -	if (xdna->dev_info->ops->suspend)
> -		xdna->dev_info->ops->suspend(xdna);
> -
> -	return 0;
> -}
> -
> -static int amdxdna_dev_resume_nolock(struct amdxdna_dev *xdna)
> -{
> -	if (xdna->dev_info->ops->resume)
> -		return xdna->dev_info->ops->resume(xdna);
> -
> -	return 0;
> -}
> -
>   static int amdxdna_pmops_suspend(struct device *dev)
>   {
>   	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	struct amdxdna_client *client;
> -
> -	mutex_lock(&xdna->dev_lock);
> -	list_for_each_entry(client, &xdna->client_list, node)
> -		amdxdna_hwctx_suspend(client);
>   
> -	amdxdna_dev_suspend_nolock(xdna);
> -	mutex_unlock(&xdna->dev_lock);
> +	if (!xdna->dev_info->ops->suspend)
> +		return -EOPNOTSUPP;
>   
> -	return 0;
> +	return xdna->dev_info->ops->suspend(xdna);
>   }
>   
>   static int amdxdna_pmops_resume(struct device *dev)
>   {
>   	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	struct amdxdna_client *client;
> -	int ret;
> -
> -	XDNA_INFO(xdna, "firmware resuming...");
> -	mutex_lock(&xdna->dev_lock);
> -	ret = amdxdna_dev_resume_nolock(xdna);
> -	if (ret) {
> -		XDNA_ERR(xdna, "resume NPU firmware failed");
> -		mutex_unlock(&xdna->dev_lock);
> -		return ret;
> -	}
>   
> -	XDNA_INFO(xdna, "hardware context resuming...");
> -	list_for_each_entry(client, &xdna->client_list, node)
> -		amdxdna_hwctx_resume(client);
> -	mutex_unlock(&xdna->dev_lock);
> -
> -	return 0;
> -}
> -
> -static int amdxdna_rpmops_suspend(struct device *dev)
> -{
> -	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	int ret;
> -
> -	mutex_lock(&xdna->dev_lock);
> -	ret = amdxdna_dev_suspend_nolock(xdna);
> -	mutex_unlock(&xdna->dev_lock);
> -
> -	XDNA_DBG(xdna, "Runtime suspend done ret: %d", ret);
> -	return ret;
> -}
> -
> -static int amdxdna_rpmops_resume(struct device *dev)
> -{
> -	struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
> -	int ret;
> -
> -	mutex_lock(&xdna->dev_lock);
> -	ret = amdxdna_dev_resume_nolock(xdna);
> -	mutex_unlock(&xdna->dev_lock);
> +	if (!xdna->dev_info->ops->resume)
> +		return -EOPNOTSUPP;
>   
> -	XDNA_DBG(xdna, "Runtime resume done ret: %d", ret);
> -	return ret;
> +	return xdna->dev_info->ops->resume(xdna);
>   }
>   
>   static const struct dev_pm_ops amdxdna_pm_ops = {
>   	SYSTEM_SLEEP_PM_OPS(amdxdna_pmops_suspend, amdxdna_pmops_resume)
> -	RUNTIME_PM_OPS(amdxdna_rpmops_suspend, amdxdna_rpmops_resume, NULL)
> +	RUNTIME_PM_OPS(amdxdna_pmops_suspend, amdxdna_pmops_resume, NULL)
>   };
>   
>   static struct pci_driver amdxdna_pci_driver = {
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index ab79600911aa..40bbb3c06320 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -50,13 +50,11 @@ struct amdxdna_dev_ops {
>   	int (*init)(struct amdxdna_dev *xdna);
>   	void (*fini)(struct amdxdna_dev *xdna);
>   	int (*resume)(struct amdxdna_dev *xdna);
> -	void (*suspend)(struct amdxdna_dev *xdna);
> +	int (*suspend)(struct amdxdna_dev *xdna);
>   	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
>   	void (*hwctx_fini)(struct amdxdna_hwctx *hwctx);
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>   	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
> -	void (*hwctx_suspend)(struct amdxdna_hwctx *hwctx);
> -	void (*hwctx_resume)(struct amdxdna_hwctx *hwctx);
>   	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>   	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
>   	int (*set_aie_state)(struct amdxdna_client *client, struct amdxdna_drm_set_state *args);


