Return-Path: <linux-kernel+bounces-888427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B602BC3ACDD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1F71A452E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C25B322A24;
	Thu,  6 Nov 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzmvCtRE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3953254BA;
	Thu,  6 Nov 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430872; cv=none; b=ADZNKDOTJb9SeGLxE4H9nCMxgv64f+z5u/8jNPffl+vQW1XCAm/ElpPrUakhwi2A0/XryPuu5MPuLi8GN2od2gzN1yBR2x1w59Q2ck3jpN6q57MH9N3Y4FM41pS69qME+kmGKH92rCY5Dv6mnG4cli2DWXLtVduTX4GVAIE3b+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430872; c=relaxed/simple;
	bh=HQnwmTY2Dss65rcWJxxHBnyzveJ0YCY7uZJ1ZSggDdo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qwhVE+YDj1XY8cNleRVddmb/awWAAALXh9vpTQiUPBycJaIi2pIEMEHsNt6wF+8cSVDMhdFNX0gW5o7DF1YaGwVSUjiWnNA7NdqWRJeEJo0JPsdEcR/z9iP08nWg61gqWLWD6uJF1qxXk+JQphIrRU1un11PtJjYMtzgiFLUNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzmvCtRE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762430870; x=1793966870;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HQnwmTY2Dss65rcWJxxHBnyzveJ0YCY7uZJ1ZSggDdo=;
  b=GzmvCtREoI3htLN3H3+HaqE1sPg2uTuxBmedOiGk/6N2PGGex0zE3Dsd
   7DdbuP4U/vvUTYqbmlUo3vG1AUyZNTv9TAfQkhOOljblK+QDVyplqF6LF
   N/iikIw9J3tI+U526SVT+RGB9W8mpNPSAixrHxgji6J/Gkw7ILKlqQ0tx
   wRtMUMKUOqDxe9wH3CFs/XKTuFU+6kkcOMqLyHx2Y+8PKvThaZPaOTgS8
   S+nW3iEZcPnae0fbifKmZ1/bTjqGOrcx3F8XnICB0Mfohb6veePVHN9i/
   ezEZdDG1XBfqnCh5QgDyPrJWXj6HzOOqcYagF66LEPWc9HoFWwkk0mRXa
   Q==;
X-CSE-ConnectionGUID: WFK7Z+EpTV6MuCl4uz/2tA==
X-CSE-MsgGUID: N42lsTsZQQmLAMyHG+Hlww==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67176580"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="67176580"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:07:49 -0800
X-CSE-ConnectionGUID: WzyiCRXqSrOCN0LYSzDGnA==
X-CSE-MsgGUID: IVHaVMzJTEmhEwIy7odAyA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:07:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Nov 2025 14:07:43 +0200 (EET)
To: Sebastian Reichel <sre@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] platform: arm64: thinkpad-t14s-ec: add system PM
 hooks
In-Reply-To: <20251106-thinkpad-t14s-ec-improvements-v1-3-109548ae75c0@collabora.com>
Message-ID: <06de8e30-c5e1-46b5-d7f6-f5ab441e5b29@linux.intel.com>
References: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com> <20251106-thinkpad-t14s-ec-improvements-v1-3-109548ae75c0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Nov 2025, Sebastian Reichel wrote:

> Improve support for system suspend. The register information has been
> extracted from the ACPI DSDT code handling Windows Modern Standby. In
> addition to writing to the 0xE0 register, the ACPI function also does
> some changes to the thermal configuration. This part is not implemented.

This doesn't cover why you do that repeated writing, please include 
explanation for it.

> After this patch the laptop's power and LID LEDs will switch into the
> typical breathing animation when the system is suspended and enabled
> normally again after resuming.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/platform/arm64/lenovo-thinkpad-t14s.c | 53 +++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> index cf6a1d3b2617..066074a1314b 100644
> --- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> +++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> @@ -25,14 +25,17 @@
>  #define T14S_EC_CMD_ECWR	0x03
>  #define T14S_EC_CMD_EVT		0xf0
>  
> -#define T14S_EC_REG_LED		0x0c
> -#define T14S_EC_REG_KBD_BL1	0x0d
> -#define T14S_EC_REG_KBD_BL2	0xe1
> -#define T14S_EC_KBD_BL1_MASK	GENMASK_U8(7, 6)
> -#define T14S_EC_KBD_BL2_MASK	GENMASK_U8(3, 2)
> -#define T14S_EC_REG_AUD		0x30
> -#define T14S_EC_MIC_MUTE_LED	BIT(5)
> -#define T14S_EC_SPK_MUTE_LED	BIT(6)
> +#define T14S_EC_REG_LED				0x0c
> +#define T14S_EC_REG_KBD_BL1			0x0d
> +#define T14S_EC_REG_MODERN_STANDBY		0xe0
> +#define T14S_EC_MODERN_STANDBY_ENTRY		BIT(1)
> +#define T14S_EC_MODERN_STANDBY_EXIT		BIT(0)
> +#define T14S_EC_REG_KBD_BL2			0xe1
> +#define T14S_EC_KBD_BL1_MASK			GENMASK_U8(7, 6)
> +#define T14S_EC_KBD_BL2_MASK			GENMASK_U8(3, 2)
> +#define T14S_EC_REG_AUD				0x30
> +#define T14S_EC_MIC_MUTE_LED			BIT(5)
> +#define T14S_EC_SPK_MUTE_LED			BIT(6)
>  
>  #define T14S_EC_EVT_NONE			0x00
>  #define T14S_EC_EVT_KEY_FN_4			0x13
> @@ -202,6 +205,14 @@ static int t14s_ec_read_evt(struct t14s_ec *ec, u8 *val)
>  	return ret;
>  }
>  
> +static void t14s_ec_write_sequence(struct t14s_ec *ec, u8 reg, u8 val, u8 cnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < cnt; i++)
> +		regmap_write(ec->regmap, reg, val);
> +}
> +
>  static int t14s_led_set_status(struct t14s_ec *ec,
>  			       struct t14s_ec_led_classdev *led,
>  			       const enum t14s_ec_led_status_t ledstatus)
> @@ -554,6 +565,7 @@ static int t14s_ec_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	ec->dev = dev;
> +	i2c_set_clientdata(client, ec);
>  
>  	ec->regmap = devm_regmap_init(dev, &t14s_ec_regmap_bus,
>  				      ec, &t14s_ec_regmap_config);
> @@ -593,6 +605,26 @@ static int t14s_ec_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int t14s_ec_suspend(struct device *dev)
> +{
> +	struct t14s_ec *ec = dev_get_drvdata(dev);
> +
> +	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
> +			       T14S_EC_MODERN_STANDBY_ENTRY, 3);
> +
> +	return 0;
> +}
> +
> +static int t14s_ec_resume(struct device *dev)
> +{
> +	struct t14s_ec *ec = dev_get_drvdata(dev);
> +
> +	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
> +			       T14S_EC_MODERN_STANDBY_EXIT, 3);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id t14s_ec_of_match[] = {
>  	{ .compatible = "lenovo,thinkpad-t14s-ec" },
>  	{}
> @@ -605,10 +637,15 @@ static const struct i2c_device_id t14s_ec_i2c_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, t14s_ec_i2c_id_table);
>  
> +static const struct dev_pm_ops t14s_ec_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(t14s_ec_suspend, t14s_ec_resume)

Add #include for the struct and macro.

-- 
 i.


> +};
> +
>  static struct i2c_driver t14s_ec_i2c_driver = {
>  	.driver = {
>  		.name = "thinkpad-t14s-ec",
>  		.of_match_table = t14s_ec_of_match,
> +		.pm = &t14s_ec_pm_ops,
>  	},
>  	.probe = t14s_ec_probe,
>  	.id_table = t14s_ec_i2c_id_table,
> 
> 

