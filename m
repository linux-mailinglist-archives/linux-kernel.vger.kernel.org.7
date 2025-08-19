Return-Path: <linux-kernel+bounces-776190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC4B2C9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05794720AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485DA258ECE;
	Tue, 19 Aug 2025 16:28:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D6255F31;
	Tue, 19 Aug 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620910; cv=none; b=lU8SFT8G8QQHYuNyBOyLJtMXR2GZrv28xMnQgFyrICvLoAiiaP94M6dr4B0pVloDA2uQspFAlr0huGb6KUMJu7d9UBMl56YSv79e4ifmlugzXqDh427ZlatRbLsTmJ4zYuwBL0vKg6hWE5HUsa0JKTPmR6u2rZi8+AHoFgwhd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620910; c=relaxed/simple;
	bh=59eMJBbsypb0bqhMladJTLt9RfpDyJ0/o/Jv5WMJiR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhVjGEoSygsjfpziu45qJK+EFxmrNDSNY3BIzXjewHjeI8G7q8C0zm/eDYrYfmFM3v6CYH+u3kgUQtV9V5mRb+vL45Gr+fal8QWnVO0xAoX7LV4bodkMKpTomXRFhaHlP2PPgcb8rglptK4VwgZyL0/AuBZMjmY1WuQfrfQ7aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F321F152B;
	Tue, 19 Aug 2025 09:28:19 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B6F3F63F;
	Tue, 19 Aug 2025 09:28:26 -0700 (PDT)
Date: Tue, 19 Aug 2025 17:28:24 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: imx: Support getting board
 info of MISC protocol
Message-ID: <aKSmKJSJNc9a6s5E@pluto>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
 <20250710-sm-misc-api-v1-v2-4-c3e953e34be6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-sm-misc-api-v1-v2-4-c3e953e34be6@nxp.com>

On Thu, Jul 10, 2025 at 04:33:29PM +0800, Peng Fan wrote:
> MISC protocol supports getting board information. Retrieve the information
> from SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index dc6ea67255b8b1ac95dfb552fa88b65044de8d3f..6b86c35c192d02e13f0d2a7d713bc447886b84bf 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>  	SCMI_IMX_MISC_CFG_INFO = 0xC,
> +	SCMI_IMX_MISC_BOARD_INFO = 0xE,
>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>  };
>  
> @@ -76,6 +77,12 @@ struct scmi_imx_misc_buildinfo_out {
>  	u8 buildtime[MISC_MAX_BUILDTIME];
>  };
>  
> +struct scmi_imx_misc_board_info_out {
> +	__le32 attributes;
> +#define MISC_MAX_BRDNAME	16
> +	u8 brdname[MISC_MAX_BRDNAME];
> +};
> +
>  struct scmi_imx_misc_cfg_info_out {
>  	__le32 msel;
>  #define MISC_MAX_CFGNAME	16
> @@ -317,6 +324,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
>  	return ret;
>  }
>  
> +static int scmi_imx_misc_board_info(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_board_info_out *out;
> +	char name[MISC_MAX_BRDNAME] = {'\0'};

same...

> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_BOARD_INFO, 0, sizeof(*out), &t);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		strscpy(name, out->brdname, MISC_MAX_BRDNAME);
> +		dev_info(ph->dev, "Board\t\t= %s, attr=0x%08x\n",
> +			 name, le32_to_cpu(out->attributes));
> +	}
> +

...other than this...LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

