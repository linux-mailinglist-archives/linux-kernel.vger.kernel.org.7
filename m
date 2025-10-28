Return-Path: <linux-kernel+bounces-874643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4EDC16C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E57F355CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E43C2C326B;
	Tue, 28 Oct 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTPc81t0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DD29B216;
	Tue, 28 Oct 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683193; cv=none; b=XWnzAgizLDZtMLOgLtSenWrlkpuMfYrrC8bncM9HJ6WmEL1IfrDchHPHqvEGtQPErN6D0vB7PazY0T+7vpoJYtbiNTHtpXKtj/4k5WjQVg2R+R0SF7iOO02ew84WMEKADx08IlLjeZmiWv9/fvj7PhfCK70Bz15b/3DsGlQUOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683193; c=relaxed/simple;
	bh=p5AXlxsSmKmNiS3CKnSiud9MaomkPEulNkF1KVmM+HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXnQjkXjhdnJg0o9YXJ0XbsmrdWT60JK9GxeI1hWJWuyFC17gaDgi8OsdQqW4M5ZnuTtA3YzOl9WMxjQpmaFjjpabpAThGjOpthNWVZROE6MVlnnB1RD63EqDmZbk4oa/rMxsj1En7f8CSYL87rymxEAFOxB0D3LkUX1LAOZ8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTPc81t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DC3C4CEE7;
	Tue, 28 Oct 2025 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761683193;
	bh=p5AXlxsSmKmNiS3CKnSiud9MaomkPEulNkF1KVmM+HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tTPc81t0T9qce9F9j0wgNvcs5p7qcEtaDecs9MbA8prPmyE34nXV+f7Vn827nP0Km
	 1e5BG6DlWOFTnRNawidplOYhIB119FX31U8Pj/wmIEJfSoi1T3ZhcM74lkGzMjDNL2
	 4Th5I3B6d66xwe74m79uNOQW0kIWak1WLyUymohhE+4CHzKaDkI4cVrSNxAAcfnUAc
	 iURkcAo7WGP88KVYxm/Cv3Uqi/yD+uOYvs8UdDyyEDBX5ZNwMpfMK9UHUZVbn8V6y+
	 0jCC4tzmrO7DMjp6vYDEUTUUie7HDbz/bIUctacIk2nyVJ3XEMpfZ332ieph/cK/Qa
	 qBBzoGxpHsPhQ==
Message-ID: <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
Date: Tue, 28 Oct 2025 15:26:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251015084414.1391595-7-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 3:44 AM, Antheas Kapenekakis wrote:
> The Ayaneo EC resets after hibernation, losing the charge control state.
> Add a small PM hook to restore this state on hibernation resume.
> 
> The fan speed is also lost during hibernation, but since hibernation
> failures are common with this class of devices, setting a low fan speed
> when the userspace program controlling the fan will potentially not
> take over could cause the device to overheat, so it is not restored.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> index 73e9dd39c703..8529f6f8dc69 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -37,6 +37,8 @@
>   #define AYANEO_MODULE_LEFT	BIT(0)
>   #define AYANEO_MODULE_RIGHT	BIT(1)
>   
> +#define AYANEO_CACHE_LEN	1
> +
>   struct ayaneo_ec_quirk {
>   	bool has_fan_control;
>   	bool has_charge_control;
> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
>   	struct platform_device *pdev;
>   	struct ayaneo_ec_quirk *quirks;
>   	struct acpi_battery_hook battery_hook;
> +
> +	u8 cache[AYANEO_CACHE_LEN];
>   };
>   
>   static const struct ayaneo_ec_quirk quirk_fan = {
> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int ayaneo_freeze(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> +	int ret, i = 0;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> +		if (ret)
> +			return ret;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ayaneo_thaw(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> +	int ret, i = 0;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> +		if (ret)
> +			return ret;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ayaneo_pm_ops = {
> +	.freeze = ayaneo_freeze,
> +	.thaw = ayaneo_thaw,
> +};

I think you're misinterpreting the PM callbacks purpose.

If you look at include/linux/pm.h you can see that thaw() is only used 
on the way down (IE when creating the image or the case of errors).

If you want to restore the registers to what they were before a 
hibernation you want to use the restore() or restore_early() callbacks.

> +
>   static struct platform_driver ayaneo_platform_driver = {
>   	.driver = {
>   		.name = "ayaneo-ec",
>   		.dev_groups = ayaneo_ec_groups,
> +		.pm = &ayaneo_pm_ops,
>   	},
>   	.probe = ayaneo_ec_probe,
>   };


