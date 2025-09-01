Return-Path: <linux-kernel+bounces-794720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110FB3E642
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4B204F35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3F338F4D;
	Mon,  1 Sep 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtN4/73d"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0C17BB35
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734970; cv=none; b=osmeE5k7MP/3wrM2wcq+nG2JeEvJ8QUIGmzyhLZp0QhPzaKRnT+TvDllnwS2FTiXejUnbU/KiBFixalD4ydXGMbhlZ06ngDKlEwyeZGJu7e9CElFtlvoNkfpbe6wbygt3rgudYsQ6NkrERee3Xe31Q6ozDaOfYYLW2c11xuRDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734970; c=relaxed/simple;
	bh=OEfNXwx7ba29QLkvQYW+GfCpbR+wRaDI6Gm1k4gEsUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaExmHazXxuNg0gcASTH5xZ/Mc5upR27XIfnXk//y5O8XNSyFwK21hiGoSgfIz4OBpbYp63j4Auw0ujkyxF5WNdNq8FESWypfLBR+0whe+9ImR8uhQLgW5aAz9DlsexkAt68vGGSqU1h0D7Phx0IkUQg34FMvTfHKVdsVWngYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtN4/73d; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bd4d359-2367-4002-a082-151a42e710d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756734953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/n9U23ZBdIPJ8zX9weCyIsKOP+HNAxWeX8Q/95N9LIY=;
	b=GtN4/73dSp2SoWnOaBpxVwybABsVY4jAZ7R7HvWKWaCIkvOoQ1vbyrT1jR2rG0t8K/oBhr
	IDmzipas/9j0ufof2ZemBHt2DhfBtnVnnv/zLxkBF5WGUuaTbmn4pq0kgWGXrYFrDlVi8k
	+sAOsPcHAXz0XQASwLLZMhFqXqSopsY=
Date: Mon, 1 Sep 2025 15:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ASoC: SDCA: Add quirk for incorrect function types for 3
 systems
To: Maciej Strozek <mstrozek@opensource.cirrus.com>,
 Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
References: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/1/25 09:57, Maciej Strozek wrote:
> Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
> but uses the function types from the 1.0 spec. Add a quirk as a workaround.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>

yay firmware quirks... Probably the start of a *long* list, eh?

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

> ---
>  include/sound/sdca.h            |  1 +
>  sound/soc/sdca/sdca_device.c    | 20 ++++++++++++++++++++
>  sound/soc/sdca/sdca_functions.c | 13 ++++++++-----
>  3 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/sdca.h b/include/sound/sdca.h
> index 5a5d6de78d728..9c6a351c9d474 100644
> --- a/include/sound/sdca.h
> +++ b/include/sound/sdca.h
> @@ -46,6 +46,7 @@ struct sdca_device_data {
> 
>  enum sdca_quirk {
>  	SDCA_QUIRKS_RT712_VB,
> +	SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING,
>  };
> 
>  #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SND_SOC_SDCA)
> diff --git a/sound/soc/sdca/sdca_device.c b/sound/soc/sdca/sdca_device.c
> index 0244cdcdd109a..4798ce2c8f0b4 100644
> --- a/sound/soc/sdca/sdca_device.c
> +++ b/sound/soc/sdca/sdca_device.c
> @@ -7,6 +7,7 @@
>   */
> 
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/soundwire/sdw.h>
> @@ -55,11 +56,30 @@ static bool sdca_device_quirk_rt712_vb(struct sdw_slave *slave)
>  	return false;
>  }
> 
> +static bool sdca_device_quirk_skip_func_type_patching(struct sdw_slave *slave)
> +{
> +	const char *vendor, *sku;
> +
> +	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
> +	sku = dmi_get_system_info(DMI_PRODUCT_SKU);
> +
> +	if (vendor && sku &&
> +	    !strcmp(vendor, "Dell Inc.") &&
> +	    (!strcmp(sku, "0C62") || !strcmp(sku, "0C63") || !strcmp(sku, "0C6B")) &&
> +	    slave->sdca_data.interface_revision == 0x061c &&
> +	    slave->id.mfg_id == 0x01fa && slave->id.part_id == 0x4243)
> +		return true;
> +
> +	return false;
> +}
> +
>  bool sdca_device_quirk_match(struct sdw_slave *slave, enum sdca_quirk quirk)
>  {
>  	switch (quirk) {
>  	case SDCA_QUIRKS_RT712_VB:
>  		return sdca_device_quirk_rt712_vb(slave);
> +	case SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING:
> +		return sdca_device_quirk_skip_func_type_patching(slave);
>  	default:
>  		break;
>  	}
> diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
> index f26f597dca9e9..13f68f7b6dd6a 100644
> --- a/sound/soc/sdca/sdca_functions.c
> +++ b/sound/soc/sdca/sdca_functions.c
> @@ -90,6 +90,7 @@ static int find_sdca_function(struct acpi_device *adev, void *data)
>  {
>  	struct fwnode_handle *function_node = acpi_fwnode_handle(adev);
>  	struct sdca_device_data *sdca_data = data;
> +	struct sdw_slave *slave = container_of(sdca_data, struct sdw_slave, sdca_data);
>  	struct device *dev = &adev->dev;
>  	struct fwnode_handle *control5; /* used to identify function type */
>  	const char *function_name;
> @@ -137,11 +138,13 @@ static int find_sdca_function(struct acpi_device *adev, void *data)
>  		return ret;
>  	}
> 
> -	ret = patch_sdca_function_type(sdca_data->interface_revision, &function_type);
> -	if (ret < 0) {
> -		dev_err(dev, "SDCA version %#x invalid function type %d\n",
> -			sdca_data->interface_revision, function_type);
> -		return ret;
> +	if (!sdca_device_quirk_match(slave, SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING)) {
> +		ret = patch_sdca_function_type(sdca_data->interface_revision, &function_type);
> +		if (ret < 0) {
> +			dev_err(dev, "SDCA version %#x invalid function type %d\n",
> +				sdca_data->interface_revision, function_type);
> +			return ret;
> +		}
>  	}
> 
>  	function_name = get_sdca_function_name(function_type);
> --
> 2.47.2
> 


