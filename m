Return-Path: <linux-kernel+bounces-578464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E7A73259
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 13:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945F67A6A79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11411213243;
	Thu, 27 Mar 2025 12:36:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B420E310
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743078997; cv=none; b=QXyvIjqhdWd+fnp3SJzZXwsOwDi0p4UnwFqsZuEoGw7lo95X2md6Y+h/NVR7k5UqxXXMnyF4uqczkLRJt9dsXt/UsYeJgEkjo7ntD884fQBU8Oc6j7NEi76VdBBy5VjGqVIZ7qo8Os7d5U+iMoExCYAn+VHc/B1/VYIYRhlsaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743078997; c=relaxed/simple;
	bh=zLWdYtqImRVpdcyhFlRIq2t/1nIjBVUrdpwk/EoErTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDJOWkHdFgsO5tGVTIQ8s+xURscNibHe3YK8ztn9Dc89mTyy2k9VNKXtx2g0ylkay03jF/YGE3sNXUiSthJOhqV4LYr7tGjTUHQud5hl/WdwLE5hpZOV0L5a5ay72eT79VNK4nU1T9BqXVrdOzPxlzAzP6dcJZQ7dVz5kYvAj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60AE1063;
	Thu, 27 Mar 2025 05:36:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA8E3F58B;
	Thu, 27 Mar 2025 05:36:31 -0700 (PDT)
Date: Thu, 27 Mar 2025 12:36:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring
 <robh@kernel.org>, Steven Price <steven.price@arm.com>
Cc: Philippe Simons <simons.philippe@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Jernej =?UTF-8?B?xaBrcmFiZWM=?=
 <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 1/2] drm/panfrost: Add PM runtime flags
Message-ID: <20250327123628.3d33c68e@donnerap.manchester.arm.com>
In-Reply-To: <20250312232319.25712-2-simons.philippe@gmail.com>
References: <20250312232319.25712-1-simons.philippe@gmail.com>
	<20250312232319.25712-2-simons.philippe@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 00:23:18 +0100
Philippe Simons <simons.philippe@gmail.com> wrote:

Hi Rob, Boris, Steven,

> When the GPU is the only device attached to a single power domain,
> core genpd disable and enable it when gpu enter and leave runtime suspend.
> 
> Some power-domain requires a sequence before disabled,
> and the reverse when enabled.
> 
> Add PM flags for CLK and RST, and implement in
> panfrost_device_runtime_suspend/resume.

So some Mali configuration and integration manual I am looking at says
that this sequence should be always observed, as the powerdown sequence
would include disabling the clocks first, then asserting the reset, then
turning the power switches off (and the inverse sequence on powerup).

So should we make this unconditional, not depending on implementation
specific flags?

And also I am wondering if panfrost_device_init() gets this wrong as well?
As I see it enabling clock first, then reset, then pm_domain, where it
should be exactly the opposite?

Cheers,
Andre

> 
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 +++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index a45e4addcc19..189ad2ad2b32 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -406,11 +406,38 @@ void panfrost_device_reset(struct panfrost_device *pfdev)
>  static int panfrost_device_runtime_resume(struct device *dev)
>  {
>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT)) {
> +		ret = reset_control_deassert(pfdev->rstc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS)) {
> +		ret = clk_enable(pfdev->clock);
> +		if (ret)
> +			goto err_clk;
> +
> +		if (pfdev->bus_clock) {
> +			ret = clk_enable(pfdev->bus_clock);
> +			if (ret)
> +				goto err_bus_clk;
> +		}
> +	}
>  
>  	panfrost_device_reset(pfdev);
>  	panfrost_devfreq_resume(pfdev);
>  
>  	return 0;
> +
> +err_bus_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS))
> +		clk_disable(pfdev->clock);
> +err_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT))
> +		reset_control_assert(pfdev->rstc);
> +	return ret;
>  }
>  
>  static int panfrost_device_runtime_suspend(struct device *dev)
> @@ -426,6 +453,16 @@ static int panfrost_device_runtime_suspend(struct device *dev)
>  	panfrost_gpu_suspend_irq(pfdev);
>  	panfrost_gpu_power_off(pfdev);
>  
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS)) {
> +		if (pfdev->bus_clock)
> +			clk_disable(pfdev->bus_clock);
> +
> +		clk_disable(pfdev->clock);
> +	}
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT))
> +		reset_control_assert(pfdev->rstc);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index cffcb0ac7c11..f372d4819262 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -36,10 +36,14 @@ enum panfrost_drv_comp_bits {
>   * enum panfrost_gpu_pm - Supported kernel power management features
>   * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
>   * @GPU_PM_VREG_OFF: Allow turning off regulators during system suspend
> + * @GPU_PM_RT_CLK_DIS: Allow disabling clocks during system runtime suspend
> + * @GPU_PM_RST_ASRT: Allow asserting the reset control during runtime suspend
>   */
>  enum panfrost_gpu_pm {
>  	GPU_PM_CLK_DIS,
>  	GPU_PM_VREG_OFF,
> +	GPU_PM_RT_CLK_DIS,
> +	GPU_PM_RT_RST_ASRT
>  };
>  
>  struct panfrost_features {


