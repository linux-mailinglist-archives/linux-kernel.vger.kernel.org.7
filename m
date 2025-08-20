Return-Path: <linux-kernel+bounces-777839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA1B2DE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0006C5E3444
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F261CBEB9;
	Wed, 20 Aug 2025 13:50:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE41C84BB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697844; cv=none; b=puj4Nv8SIWbpaS+VTZseGAOkrztXRuXeSUMF9PWQDZVDOA2dP2lHn468QIdJqMN6NSAzBn5NDDRLXx5d6d1KV6LTpbB2pDpuidRssFu21aX1op5LS9eUm7Ry69mlon8sW7SB7xyVGRqBLH3WYKwe43nlgtlGGome2BqgVt3MS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697844; c=relaxed/simple;
	bh=PlAWtq9hXEASVA9AC3Q6Gsd2Mw3o6eeAzFIF3c9LDvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2HXO8jolJ50Fm2BUFzx07NX5+DuBClnl85XrsPA/dk69JDLAQ0pvrijqFxNBaAPwiYOea6cUtGqcGI2Bazw4jss3dHpkSbv6MrUahtI1jaJLvxEu5CNyhaTO/z5HlyvMmjepCcJgRrqhl2pDy+PeFT7m+14U6JgbckCCZKptp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE5521D31;
	Wed, 20 Aug 2025 06:50:33 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC4683F738;
	Wed, 20 Aug 2025 06:50:39 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:50:37 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] firmware: imx: Add stub functions for SCMI MISC API
Message-ID: <aKXSrZEudO_bOoPr@pluto>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>

On Thu, Aug 07, 2025 at 09:47:42AM +0800, Peng Fan wrote:
> To ensure successful builds when CONFIG_IMX_SCMI_MISC_DRV is not enabled,
> this patch adds static inline stub implementations for the following
> functions:
> 
>   - scmi_imx_misc_ctrl_get()
>   - scmi_imx_misc_ctrl_set()
> 
> These stubs return -EOPNOTSUPP to indicate that the functionality is not
> supported in the current configuration. This avoids potential build or
> link errors in code that conditionally calls these functions based on
> feature availability.
> 
> Fixes: 540c830212ed ("firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()")
> Fixes: 0b4f8a68b292 ("firmware: imx: Add i.MX95 MISC driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/linux/firmware/imx/sm.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
> index d4212bc42b2c17fb8f94d58856a75beb5611ce4b..99c15bbb46aa8329b5aa8e03017e152074cdf492 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -26,8 +26,20 @@
>  #define SCMI_IMX94_CTRL_SAI3_MCLK	5U	/*!< WAKE SAI3 MCLK */
>  #define SCMI_IMX94_CTRL_SAI4_MCLK	6U	/*!< WAKE SAI4 MCLK */
>  
> +#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV)
>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
>  int scmi_imx_misc_ctrl_set(u32 id, u32 val);
> +#else
> +static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

