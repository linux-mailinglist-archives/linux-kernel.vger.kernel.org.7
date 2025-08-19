Return-Path: <linux-kernel+bounces-776131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB72B2C8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1AA5672EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55192BD031;
	Tue, 19 Aug 2025 15:59:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03742C181;
	Tue, 19 Aug 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619154; cv=none; b=IL7Z4uc3/j5XlxpxrjIsoGJzKhV0HeZh32R5nd535tOra9LRty/f91Q0M1/760tG6F0F2Y3BVUQtiOGGH/dE8KFCMjjfkwUf57hzJoCPzOFyvQZzEP7G4Ed5wrhk+4bYTCI7A2wZ9t1L4KpOkc6ZBgA31Zna3l5isQ7wONtCDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619154; c=relaxed/simple;
	bh=cUvOmmSVi8EgHXGDEz4RjYvK/h6LmNIHxazVjG6Hs7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfeiAv4mvs+VLwi2HD+7B3hSh8QAwCjdNYaLm86p26aDzWybvYYAIVn13F9J/iT0iXTvxv9Twbc+5mJJT+JB6EDvSbZ/tkJFF/Lecdu8DTlwroAow0Y7k9g9Ju9B00jojpqS9urTUKeNKmLHWnUowUoIKL0xJP4FFx26Id7mZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D1B152B;
	Tue, 19 Aug 2025 08:59:04 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E95F3F63F;
	Tue, 19 Aug 2025 08:59:10 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:59:08 +0100
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
Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: imx: Support getting cfg info
 of MISC protocol
Message-ID: <aKSfTL4fCaDsoHQX@pluto>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
 <20250710-sm-misc-api-v1-v2-3-c3e953e34be6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-sm-misc-api-v1-v2-3-c3e953e34be6@nxp.com>

On Thu, Jul 10, 2025 at 04:33:28PM +0800, Peng Fan wrote:
> MISC protocol supports getting the System Manager(SM) mode selection
> and configuration name. Retrieve the information from SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index b301f09ab6cc65d286edb8819031d7f4c02e8272..dc6ea67255b8b1ac95dfb552fa88b65044de8d3f 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -26,6 +26,7 @@ enum scmi_imx_misc_protocol_cmd {
>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
> +	SCMI_IMX_MISC_CFG_INFO = 0xC,
>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>  };
>  
> @@ -75,6 +76,12 @@ struct scmi_imx_misc_buildinfo_out {
>  	u8 buildtime[MISC_MAX_BUILDTIME];
>  };
>  
> +struct scmi_imx_misc_cfg_info_out {
> +	__le32 msel;
> +#define MISC_MAX_CFGNAME	16
> +	u8 cfgname[MISC_MAX_CFGNAME];
> +};
> +
>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>  					struct scmi_imx_misc_info *mi)
>  {
> @@ -310,6 +317,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
>  	return ret;
>  }
>  
> +static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_cfg_info_out *out;
> +	char name[MISC_MAX_CFGNAME] = {'\0'};

Same considerations here...

> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CFG_INFO, 0, sizeof(*out), &t);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		strscpy(name, out->cfgname, MISC_MAX_CFGNAME);
> +		dev_info(ph->dev, "SM Config\t= %s, mSel = %u\n",
> +			 name, le32_to_cpu(out->msel));

...other than this...LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

