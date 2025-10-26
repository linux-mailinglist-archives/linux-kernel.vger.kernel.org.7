Return-Path: <linux-kernel+bounces-870237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77630C0A3FF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639384E0FFE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B3226CF6;
	Sun, 26 Oct 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heqdnYiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140D1C860E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761462914; cv=none; b=AV2NJ0Zypm8Vs0gGblMV7a0xAwb7kiyWv3G5mdX29ahggMueZqwUaWa9gWfcvUK9FK1DeJAZ1OjaCOIwRUeVMqRgjtIKNkiOztIEQOFwsw7Q1gbxQ+GcDNIeW/BZ2Asnhw6IwrygY64ZJMGhEFRwnxPZAC3zN4Y2kyz5XqFva6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761462914; c=relaxed/simple;
	bh=AJNZzgEp6c81VP1oCoQp32WwSmhJUoOxEYUL+7abeH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI1/OoWcV8TwAtuWwQ80qD5NOBhaX2ZkqW/iZzAT5DpGaOBEnI1aJuNdoqO2djQRdBnXnjSchEG/mQujBuQP9xIyekKlVcw1gwfqlJv9xCCGoXzSYdCsf9zBmwfrcN0/WbNgobWWumVvFOqGQPjN6Ly3anGbxjO4Nl2FZRI0mCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heqdnYiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24B7C4CEE7;
	Sun, 26 Oct 2025 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761462913;
	bh=AJNZzgEp6c81VP1oCoQp32WwSmhJUoOxEYUL+7abeH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heqdnYiDiO11Lf1pxpHlWAdWi3WrodoKVtkmRRqUBHAa/73sL6JSBAVnisQawDsFx
	 JT2AWCMT12xk3ihSY+n+sOsQTAsUhrRWMgXQtgqSQdAl4zbgWN2/y/0EeMO5Cd2Z9a
	 Y/uOeFJTfykIIXo6H2cKz+J0fXHKKq3R7iKRYA26oPM0X5jOu0hPyLxZUk3p+tsiw2
	 GKwcf5r9mgoe1iGwJsInLSK/yTeGO1b/C/FGGsmJwkU28avvogBeGzAS5IvkF9B0FM
	 SjaCoSZDW6Iltz2UMYPtBGVImMjVN/RA5DaGoYCtw0coa84LyCIVAbH2c4FnYK6hVE
	 0X42FTy4cwLZA==
Date: Sun, 26 Oct 2025 09:15:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Aya Levin <ayal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drory <shayd@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>, Amir Tzin <amirtz@nvidia.com>
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
Message-ID: <20251026071508.GA12554@unreal>
References: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>

On Thu, Oct 23, 2025 at 09:19:27AM +0300, Tariq Toukan wrote:
> From: Amir Tzin <amirtz@nvidia.com>
> 
> In case an auxiliary device with IRQs directory is unbinded, the
> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
> This leads to a failure recreating the directory on bind [1].
> 
> Using the attributes group visibility interface, expose the IRQs
> attributes group if"f the xarray storing IRQs entries is not empty. Now

if"f -> if

> irq_dir_exists field is redundant and can be removed.
> 
> [1]
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
>    Failed to create sysfs entry for irq 56, ret = -2
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
>    Failed to create async EQs
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
>    Failed to create EQs
> 
> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/base/auxiliary.c       |  13 +++-
>  drivers/base/auxiliary_sysfs.c | 117 +++++++++++++++++++++++++--------
>  include/linux/auxiliary_bus.h  |  26 ++++++--
>  3 files changed, 118 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 04bdbff4dbe5..b0fb31279257 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -225,7 +225,16 @@ static int auxiliary_bus_probe(struct device *dev)
>  		return ret;
>  	}
>  
> -	return auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
> +	ret = auxiliary_bus_irq_dir_res_probe(auxdev);
> +	if  (ret)
> +		return ret;
> +
> +	ret = auxdrv->probe(auxdev,
> +			    auxiliary_match_id(auxdrv->id_table, auxdev));
> +	if (ret)
> +		auxiliary_bus_irq_dir_res_remove(auxdev);
> +
> +	return ret;

return 0;

>  }
>  
>  static void auxiliary_bus_remove(struct device *dev)
> @@ -235,6 +244,7 @@ static void auxiliary_bus_remove(struct device *dev)
>  
>  	if (auxdrv->remove)
>  		auxdrv->remove(auxdev);
> +	auxiliary_bus_irq_dir_res_remove(auxdev);
>  }
>  
>  static void auxiliary_bus_shutdown(struct device *dev)
> @@ -294,7 +304,6 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
>  
>  	dev->bus = &auxiliary_bus_type;
>  	device_initialize(&auxdev->dev);
> -	mutex_init(&auxdev->sysfs.lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(auxiliary_device_init);
> diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
> index 754f21730afd..8ae3ec62b3db 100644
> --- a/drivers/base/auxiliary_sysfs.c
> +++ b/drivers/base/auxiliary_sysfs.c
> @@ -13,30 +13,71 @@ struct auxiliary_irq_info {
>  	char name[AUXILIARY_MAX_IRQ_NAME];
>  };
>  
> +static struct attribute auxiliary_irq_attr = {
> +	.mode = 0,

"static" variable is always initialized to 0, there is no need in .mode = 0 line.

> +	.name = "DUMMY",
> +};
> +
>  static struct attribute *auxiliary_irq_attrs[] = {
> -	NULL
> +	[0] = &auxiliary_irq_attr,
> +	[1] = NULL,

Let's use more common pattern - without [x]

>  };
>  
> +static bool auxiliary_irq_dir_group_visible(struct kobject *kobj)
> +{
> +	struct auxiliary_device *auxdev;
> +	struct device *dev;
> +
> +	dev = container_of(kobj, struct device, kobj);
> +	auxdev = container_of(dev, struct auxiliary_device, dev);
> +
> +	return !xa_empty(&auxdev->sysfs.irqs);
> +}
> +
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(auxiliary_irq_dir);
> +
>  static const struct attribute_group auxiliary_irqs_group = {
>  	.name = "irqs",
>  	.attrs = auxiliary_irq_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(auxiliary_irq_dir),
>  };
>  
> -static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
> +void auxiliary_bus_irq_dir_res_remove(struct auxiliary_device *auxdev)
>  {
> -	int ret = 0;
> +	struct device *dev = &auxdev->dev;
>  
> -	guard(mutex)(&auxdev->sysfs.lock);
> -	if (auxdev->sysfs.irq_dir_exists)
> -		return 0;
> +	sysfs_remove_group(&dev->kobj, &auxiliary_irqs_group);
> +	xa_destroy(&auxdev->sysfs.irqs);
> +	mutex_destroy(&auxdev->sysfs.lock);

Actually you don't need extra sysfs.lock mutex and everything can be
protected through xarray lock. So instead of two locks, you will have
one with proper lifetime.

> +}

<...>

> @@ -146,7 +145,6 @@ struct auxiliary_device {
>  	struct {
>  		struct xarray irqs;
>  		struct mutex lock; /* Synchronize irq sysfs creation */
> -		bool irq_dir_exists;

"struct mutex lock" can be replaced with xa_lock(&auxdev->sysfs.irqs).

Thanks

