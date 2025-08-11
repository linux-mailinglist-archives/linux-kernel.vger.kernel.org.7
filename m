Return-Path: <linux-kernel+bounces-763295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D6FB212DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A14D1908542
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3629BDB3;
	Mon, 11 Aug 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="DzbBAUOl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162A1D2F42
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932087; cv=pass; b=Nd8wO8ZQIO9GTS/4Bk8EBXpc0MCQc4GRUMVNy4bWugQoILez8Tb1hWQ50LIQDJGZZ1Y2HgqfdSUgMAxKIvxFtOgXOlA5r1CqgU3RIAXjuOk6e6XAwDC+MYgUIpM6E15BdFSWs4vtg/0p/wjda1gWciSawl3/JkDmI/PAT1uwHBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932087; c=relaxed/simple;
	bh=gY2TOuTLiUfxqdmops5T0LIKX3z2xgdZCCgMigyMx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo8DNZ3SeR8c4rapwB6wybo5lvr87qtm8ag37rQWHkqTNQNLtMMKAA0eSMqulogUWPtQaPIbzJIClrc7dhPEDNlpdSPBEDZ6HENWJ1L3ilWLpsKbz8Mr7vpsYbhP3A2VmRZjlGlRcxH7raQi+g0g1Q+ZpEt7mnt1y6gD5HMlBmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=DzbBAUOl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754932072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I4KK+cWuMn6BHXPdwWwwTsK1hd1hElCVWFIqF9ooZ6zyCCgNe9UK0VHTQi16lyMNBarfoxRQHYETCFf/NIht3LoD/pLTz0BdHWlbem3ai649Ij+o8RS1AkC8X31uWWTigRO9Ym8WoKE2ZBmduuZUCLUV3gmUk1Ofox8XzbqzrCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754932072; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WoblCwKGuAFNZssfRkarQIbAuL4HisYE9SXaQ6Ai45c=; 
	b=Pm6uBiEJT+ainMlNNW7PlunCBiyxBflUo1bV8qz0gD1qNS6VWfrFVLfMnLOFwASUly4VHyoyRPM4c58tRgxcQZoOCWwhNYAzycam/pRJ8ctzOaWtCUhgZNejdHmh3gtYE/RLAPX7oTi4teOW21TbfiZcpKBmCpIge/qWbJTmkLY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754932072;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=WoblCwKGuAFNZssfRkarQIbAuL4HisYE9SXaQ6Ai45c=;
	b=DzbBAUOl2DFAybzE/keZMPZtc+lESdbcwdreWcBP+iWshM2mTl1QdUjtOFFbTCwG
	ve7XZTGuvO31kSP2SEJwzZkVfxa2/+rD1GfwWc4Nm4sqWfS8iiPHkTYHuANV9Bbwuac
	ZQ5C6Vqkmp57LTCSmcOvUYjbFST4twvTkQVzUe8A=
Received: by mx.zohomail.com with SMTPS id 1754932070977714.9867128062718;
	Mon, 11 Aug 2025 10:07:50 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:07:46 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] drm/panthor: Add suspend, resume and reset
 handling
Message-ID: <nfftvqqdqqe7kmogvrf3ptmfj7bsnafeef57favlb3ck2pqany@rj64ut3glgor>
References: <cover.1753449448.git.lukas.zapolskas@arm.com>
 <a339507d6a8eb18b2e5ea0b74543ff9e8f991f4d.1753449448.git.lukas.zapolskas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a339507d6a8eb18b2e5ea0b74543ff9e8f991f4d.1753449448.git.lukas.zapolskas@arm.com>

On 25.07.2025 15:57, Lukas Zapolskas wrote:
> The sampler must disable and re-enable counter sampling around
> suspends, and must re-program the FW interface after a reset to
> avoid losing data.
>
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  7 +-
>  drivers/gpu/drm/panthor/panthor_perf.c   | 89 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_perf.h   |  6 ++
>  3 files changed, 101 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index ab3e65cc17bd..4bcf257e1403 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -139,6 +139,7 @@ static void panthor_device_reset_work(struct work_struct *work)
>  	if (!drm_dev_enter(&ptdev->base, &cookie))
>  		return;
>
> +	panthor_perf_pre_reset(ptdev);
>  	panthor_sched_pre_reset(ptdev);
>  	panthor_fw_pre_reset(ptdev, true);
>  	panthor_mmu_pre_reset(ptdev);
> @@ -148,6 +149,7 @@ static void panthor_device_reset_work(struct work_struct *work)
>  	ret = panthor_fw_post_reset(ptdev);
>  	atomic_set(&ptdev->reset.pending, 0);
>  	panthor_sched_post_reset(ptdev, ret != 0);
> +	panthor_perf_post_reset(ptdev);
>  	drm_dev_exit(cookie);
>
>  	if (ret) {
> @@ -503,8 +505,10 @@ int panthor_device_resume(struct device *dev)
>  			ret = panthor_device_resume_hw_components(ptdev);
>  		}
>
> -		if (!ret)
> +		if (!ret) {
>  			panthor_sched_resume(ptdev);
> +			panthor_perf_resume(ptdev);
> +		}
>
>  		drm_dev_exit(cookie);
>
> @@ -568,6 +572,7 @@ int panthor_device_suspend(struct device *dev)
>  		/* We prepare everything as if we were resetting the GPU.
>  		 * The end of the reset will happen in the resume path though.
>  		 */
> +		panthor_perf_suspend(ptdev);
>  		panthor_sched_suspend(ptdev);
>  		panthor_fw_suspend(ptdev);
>  		panthor_mmu_suspend(ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index fd16039d9244..512bbdb0aac1 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -1845,6 +1845,63 @@ void panthor_perf_session_destroy(struct panthor_file *pfile, struct panthor_per
>  	}
>  }
>
> +/**
> + * panthor_perf_suspend - Prepare the performance counter subsystem for system suspend.
> + * @ptdev: Panthor device.
> + *
> + * Indicate to the performance counters that the system is suspending.
> + *
> + * This function must not be used to handle MCU power state transitions: just before MCU goes
> + * from on to any inactive state, an automatic sample will be performed by the firmware, and
> + * the performance counter firmware state will be restored on warm boot.
> + *
> + */
> +void panthor_perf_suspend(struct panthor_device *ptdev)
> +{
> +	int ret;
> +	struct panthor_perf *perf = ptdev->perf;
> +	struct panthor_perf_sampler *sampler;
> +
> +	if (!perf)
> +		return;
> +
> +	sampler = &perf->sampler;
> +
> +	if (!atomic_read(&sampler->enabled_clients))
> +		return;
> +
> +	ret = panthor_perf_fw_stop_sampling(sampler->ptdev);
> +	if (ret)
> +		drm_warn(&ptdev->base, "Could not stop sampling before suspend, err = %d", ret);
> +}
> +
> +/**
> + * panthor_perf_resume - Resume the performance counter subsystem after system resumption.
> + * @ptdev: Panthor device.
> + *
> + * Indicate to the performance counters that the system has resumed. This must not be used
> + * to handle MCU state transitions, for the same reasons as detailed in the kerneldoc for
> + * @panthor_perf_suspend.
> + */
> +void panthor_perf_resume(struct panthor_device *ptdev)
> +{
> +	int ret;
> +	struct panthor_perf *perf = ptdev->perf;
> +	struct panthor_perf_sampler *sampler;
> +
> +	if (!perf)
> +		return;
> +
> +	sampler = &perf->sampler;
> +
> +	if (!atomic_read(&sampler->enabled_clients))
> +		return;
> +
> +	ret = panthor_perf_fw_start_sampling(sampler->ptdev);
> +	if (ret)
> +		drm_warn(&ptdev->base, "Could not resume sampling, err = %d", ret);
> +}
> +
>  /**
>   * panthor_perf_unplug - Terminate the performance counter subsystem.
>   * @ptdev: Panthor device.
> @@ -1878,3 +1935,35 @@ void panthor_perf_unplug(struct panthor_device *ptdev)
>
>  	ptdev->perf = NULL;
>  }
> +
> +void panthor_perf_pre_reset(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf_sampler *sampler;
> +
> +	if (drm_WARN_ON_ONCE(&ptdev->base, !ptdev->perf))
> +		return;
> +
> +	sampler = &ptdev->perf->sampler;
> +
> +	if (!atomic_read(&sampler->enabled_clients))
> +		return;
> +
> +	panthor_perf_fw_stop_sampling(sampler->ptdev);
> +}
> +
> +void panthor_perf_post_reset(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf_sampler *sampler;
> +
> +	if (drm_WARN_ON_ONCE(&ptdev->base, !ptdev->perf))
> +		return;
> +
> +	sampler = &ptdev->perf->sampler;
> +
> +	if (!atomic_read(&sampler->enabled_clients))
> +		return;
> +
> +	panthor_perf_fw_write_sampler_config(sampler);
> +
> +	panthor_perf_fw_start_sampling(sampler->ptdev);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
> index 5a14854368eb..1044b0a1cfaa 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.h
> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
> @@ -14,6 +14,8 @@ struct panthor_file;
>  struct panthor_perf;
>
>  int panthor_perf_init(struct panthor_device *ptdev);
> +void panthor_perf_suspend(struct panthor_device *ptdev);
> +void panthor_perf_resume(struct panthor_device *ptdev);
>  void panthor_perf_unplug(struct panthor_device *ptdev);
>
>  int panthor_perf_session_setup(struct drm_file *file, struct panthor_perf *perf,
> @@ -30,5 +32,9 @@ void panthor_perf_session_destroy(struct panthor_file *pfile, struct panthor_per
>
>  void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status);
>
> +void panthor_perf_pre_reset(struct panthor_device *ptdev);
> +
> +void panthor_perf_post_reset(struct panthor_device *ptdev);
> +
>  #endif /* __PANTHOR_PERF_H__ */
>
> --
> 2.33.0.dirty

Adrian Larumbe

