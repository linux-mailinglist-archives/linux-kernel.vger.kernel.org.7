Return-Path: <linux-kernel+bounces-791639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB994B3B98F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B40687ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66753112AB;
	Fri, 29 Aug 2025 11:00:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462972BEFFE;
	Fri, 29 Aug 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465257; cv=none; b=MsYditCC7TQZhqnw39Owdc/9bgEulAO4eojT+Krc0Jd0EFCClHOmE6irE1oC/QdwsCfIybiD6ppZLO2IpEwD0FkudK58TWscT/8WmzX0wUl1fkkkgQmVT/RQE+xK5yldZZeMGyV4MK/kKHNr7CvDwOYDRoQVhIMH7aeBTWEWeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465257; c=relaxed/simple;
	bh=JqkfAbOwMjDSRO2xJdz1XvgyaE1mG9XvJSxk1upfKtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI+0n6EuY0A7rIl7kWl/Q4R/jbR5uQ/nITVK2b2k0J3qdXc+Ghb8uHwyX4rWKebFq92VSlPUvDjAQ2w0J0CW2yy0XrrYOefNe9sGIBU4t+LN9Fmz2yCxya9Modw1KIuWuntp25N3xQiQklqS0Xb5QpjEuK2K9zO0Yl3AMiL89Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5124F19F0;
	Fri, 29 Aug 2025 04:00:47 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD9BC3F738;
	Fri, 29 Aug 2025 04:00:53 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:00:51 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] firmware: arm_scmi: imx: Support getting board
 info of MISC protocol
Message-ID: <20250829-nostalgic-skylark-of-fruition-d50d26@sudeepholla>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-4-82c982c1815a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-sm-misc-api-v1-v3-4-82c982c1815a@nxp.com>

On Wed, Aug 27, 2025 at 12:59:16PM +0800, Peng Fan wrote:
> MISC protocol supports getting board information. Retrieve the information
> from SM.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index 220b9369fb537306f9e1a105930ad4d65e6b10aa..f934b4fbc6ec9f1e6b24d1c6c8cd07b45ce548e3 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>  	SCMI_IMX_MISC_CFG_INFO = 0xC,
> +	SCMI_IMX_MISC_BOARD_INFO = 0xE,

Again keep it ordered by command number ?

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
> @@ -316,6 +323,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
>  	return ret;
>  }
>  
> +static int scmi_imx_misc_board_info(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_board_info_out *out;
> +	char name[MISC_MAX_BRDNAME];
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
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
>  static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
>  {
>  	struct scmi_imx_misc_cfg_info_out *out;
> @@ -371,6 +402,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
>  	if (ret)
>  		return ret;
>  
> +	ret = scmi_imx_misc_board_info(ph);
> +	if (ret)
> +		return ret;
> +

Ditto, not mandatory, graceful return on NOT_SUPPORTED please.

-- 
Regards,
Sudeep

