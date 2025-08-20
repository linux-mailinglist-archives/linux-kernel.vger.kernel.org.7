Return-Path: <linux-kernel+bounces-777844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE8FB2DE74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4432E564B80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84ED1D5CFB;
	Wed, 20 Aug 2025 13:52:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA119DF62
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697937; cv=none; b=QYRvTtPAMOICAFvwgEzAM5Ymd0kPYsQ9ycwmOY5jwIVn/jrtg07nMekqmQEltKYFZgJgzTHD2DlHuoHePIAAjNeNGnGGYNR0LdqCxB0ErEttiu/PNlFvndAKJ9YuP/H6RhDRzM3sixPR/8ErVeFhAv+VpwXboW4D9NiqVfR48Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697937; c=relaxed/simple;
	bh=x9m6lyZr89uhKMYacvX3Uxb5ULz79Sabw7pdWj/rTVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPgLdHydfHDUk4n3qyTPclvefadhbyLDHJVV/zOrQ3Ra/c/qPvdhwqMKKzjh8/Gb92Ew0JWMxwZ3T+ILRyLjIiR2DdWBbB8PyL31afyfK9OSDOBpfy7v2A/KOU9w7wDcZBbCkv5fx8Pz/Os4obpvvDLoZOjAxRaO2WDmtdVN40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650381D31;
	Wed, 20 Aug 2025 06:52:07 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7780D3F63F;
	Wed, 20 Aug 2025 06:52:13 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:52:10 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] firmware: imx: Add stub functions for SCMI LMM API
Message-ID: <aKXTChnYGUgJzCD1@pluto>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-2-3489e41a6fda@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-imx9-sm-v1-2-3489e41a6fda@nxp.com>

On Thu, Aug 07, 2025 at 09:47:43AM +0800, Peng Fan wrote:
> To ensure successful builds when CONFIG_IMX_SCMI_LMM_DRV is not enabled,
> this patch adds static inline stub implementations for the following
> functions:
> 
>   - scmi_imx_lmm_operation()
>   - scmi_imx_lmm_info()
>   - scmi_imx_lmm_reset_vector_set()
> 
> These stubs return -EOPNOTSUPP to indicate that the functionality is not
> supported in the current configuration. This avoids potential build or
> link errors in code that conditionally calls these functions based on
> feature availability.
> 
> Fixes: 7242bbf418f0 ("firmware: imx: Add i.MX95 SCMI LMM driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/linux/firmware/imx/sm.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
> index 99c15bbb46aa8329b5aa8e03017e152074cdf492..f2a72177bb37c1d46145a60710e3809641e0f5a2 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -56,7 +56,24 @@ enum scmi_imx_lmm_op {
>  #define SCMI_IMX_LMM_OP_FORCEFUL	0
>  #define SCMI_IMX_LMM_OP_GRACEFUL	BIT(0)
>  
> +#if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV)
>  int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags);
>  int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
>  int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
> +#else
> +static inline int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>  #endif

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


