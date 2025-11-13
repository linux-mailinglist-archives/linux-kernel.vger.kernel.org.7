Return-Path: <linux-kernel+bounces-899864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E713C58F74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B83B364689
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF2286417;
	Thu, 13 Nov 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA3RziZf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7218EFD1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052335; cv=none; b=GRpfrZALrqMR+NR2oBaL7zAkJBXv0e9vuV53sfouCXILAndphVNddA76mvCEUQD4oCKpvBnSkFIGOYXW9LE7gtpO/NVjDvuIjpUrId/dSM5MrYrc0BjDPYCgLBynIoNZKBUjN+fEIXHzD5r2D1WVxpuLEWTd9Hk/bUvPxhbqKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052335; c=relaxed/simple;
	bh=DZ65OqEYwdNFF6KiH64cjQNsny+9tsnZlOAkumCdths=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBFmkuC6GuZFkS5b383Nn9XQlp0x2ghqO0q/5+DcaBI1c/TS+fWSJg1j4bKVYwcCKeBXFDOcfHpPjzNwNHYYeFo91bf8Ey5cjH8s8vBmupq7uBCiP41cf4ZLJBwZBmFuigeov/dVgFmofaPgcGwtAHjOjlWrGaY5B/ae7f0bRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CA3RziZf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763052333; x=1794588333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DZ65OqEYwdNFF6KiH64cjQNsny+9tsnZlOAkumCdths=;
  b=CA3RziZfzAzYuPWkD+rEvobfkRNRWOiPqStuc7VKZPcFLygUSVm6mzeo
   Wv8HNO0AfyC9Or+mWOyk27uGv0uyNzYELPk6csjvtqUwDxcOxJcBnqxzC
   qWR7+Wr+8Uh4V3LLj/L7gRXYH2B9IsUx3LW55DdWWyFHQYuJfJzGwbnP/
   G8DihGjI1SjySCsCZdELuLr0R1LcY+A31m0DdI3jGG8+mVjEMc1SKYAjP
   QS+gsM4tmmb/zJMSUJ6twzWcDIi5wzh7J2fQxFA8tQIFo65oaIyfFEW7V
   OfO5cYlw8G+BMlt231Jrjngp61wMupZTcuNpPe3xwZnP+tARHwvyHrRmZ
   g==;
X-CSE-ConnectionGUID: ORyrdWA8SMi5onTISJudUQ==
X-CSE-MsgGUID: mfQ4iYvFTM6RLDZhpClLlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69004358"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="69004358"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:45:32 -0800
X-CSE-ConnectionGUID: v1gPspn3R96lLRORcTSDUQ==
X-CSE-MsgGUID: vVL/sWyXTr+KKTDL8OguTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="212944298"
Received: from mfalkows-mobl.ger.corp.intel.com (HELO [10.246.18.39]) ([10.246.18.39])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:45:30 -0800
Message-ID: <9ae59f7e-9d99-4e73-a805-99586d8f49bb@linux.intel.com>
Date: Thu, 13 Nov 2025 17:45:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Fix deadlock between context destroy and
 job timeout
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 mario.limonciello@amd.com
References: <20251107181050.1293125-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>
In-Reply-To: <20251107181050.1293125-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>

You could add some lockdep assertions for dev_lock to better track its 
state.

Best regards,
Maciej

On 11/7/2025 7:10 PM, Lizhi Hou wrote:
> Hardware context destroy function holds dev_lock while waiting for all jobs
> to complete. The timeout job also needs to acquire dev_lock, this leads to
> a deadlock.
>
> Fix the issue by temporarily releasing dev_lock before waiting for all
> jobs to finish, and reacquiring it afterward.
>
> Fixes: 4fd6ca90fc7f ("accel/amdxdna: Refactor hardware context destroy routine")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index bdc90fe8a47e..42d876a427c5 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -690,17 +690,19 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
>   	xdna = hwctx->client->xdna;
>   
>   	XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, hwctx->priv->seq);
> -	drm_sched_entity_destroy(&hwctx->priv->entity);
> -
>   	aie2_hwctx_wait_for_idle(hwctx);
>   
>   	/* Request fw to destroy hwctx and cancel the rest pending requests */
>   	aie2_release_resource(hwctx);
>   
> +	mutex_unlock(&xdna->dev_lock);
> +	drm_sched_entity_destroy(&hwctx->priv->entity);
> +
>   	/* Wait for all submitted jobs to be completed or canceled */
>   	wait_event(hwctx->priv->job_free_wq,
>   		   atomic64_read(&hwctx->job_submit_cnt) ==
>   		   atomic64_read(&hwctx->job_free_cnt));
> +	mutex_lock(&xdna->dev_lock);
>   
>   	drm_sched_fini(&hwctx->priv->sched);
>   	aie2_ctx_syncobj_destroy(hwctx);

