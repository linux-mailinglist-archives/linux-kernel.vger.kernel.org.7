Return-Path: <linux-kernel+bounces-791612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AD4B3B928
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BC4567E29
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269630F7FE;
	Fri, 29 Aug 2025 10:49:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5626B77B;
	Fri, 29 Aug 2025 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464546; cv=none; b=iGZaBX5/OiJ00BHJz1e06shPERTGNB8HMfXPydMoQyuO3AmdANpNJBNzqOo4OBL0nBkcJT7ZmokM20pLDnxvBu+/FSFC8MWxTo4AMuHqbjigC1YEh6Wpr6t1qwsjcWiVNl6/fg1WHv7P3Qc7xxBxEK55iRzkrggnvpPtNzIiSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464546; c=relaxed/simple;
	bh=pf60yOCYu6UeHBzU3k2qIPPUe5wYD1ZLuf41B/NPuEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYAPQ5paaqAjNIfG1hgpRPiXBIYblMhRziEW8stSpeXA93UXrxso5p+sBM2zRrFhaUJY4gbGSAZH/tO75sbNcxSMAW0eDIzIkvCzHfVuhPI7tcXeKQ0QwkfiGuSFYnx9OzNmk7kGzqHUA2Ua+gHujjG6RGfAClJ73wp6JxDzs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E44C419F0;
	Fri, 29 Aug 2025 03:48:52 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 588D73F694;
	Fri, 29 Aug 2025 03:48:59 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:48:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <20250829-satisfied-carp-from-camelot-bddbfa@sudeepholla>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-2-82c982c1815a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-sm-misc-api-v1-v3-2-82c982c1815a@nxp.com>

On Wed, Aug 27, 2025 at 12:59:14PM +0800, Peng Fan wrote:
> MISC protocol supports discovering the System Manager(SM) build
> information including build commit, build time and etc. Retrieve the
> information from SM.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index a8915d3b4df518719d56bfff38922625ad9b70f6..464afeae8267d8c1eca4c4d5e008eca6d741c6ff 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -25,6 +25,7 @@
>  enum scmi_imx_misc_protocol_cmd {
>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
> +	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>  };
>  
> @@ -65,6 +66,15 @@ struct scmi_imx_misc_ctrl_get_out {
>  	__le32 val[];
>  };
>  
> +struct scmi_imx_misc_buildinfo_out {
> +	__le32 buildnum;
> +	__le32 buildcommit;
> +#define MISC_MAX_BUILDDATE	16
> +	u8 builddate[MISC_MAX_BUILDDATE];
> +#define MISC_MAX_BUILDTIME	16
> +	u8 buildtime[MISC_MAX_BUILDTIME];
> +};
> +
>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>  					struct scmi_imx_misc_info *mi)
>  {
> @@ -272,6 +282,33 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
>  	return ret;
>  }
>  
> +static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *ph)
> +{
> +	char date[MISC_MAX_BUILDDATE], time[MISC_MAX_BUILDTIME];
> +	struct scmi_imx_misc_buildinfo_out *out;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_DISCOVER_BUILDINFO, 0,
> +				      sizeof(*out), &t);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		strscpy(date, out->builddate, MISC_MAX_BUILDDATE);
> +		strscpy(time, out->buildtime, MISC_MAX_BUILDTIME);
> +		dev_info(ph->dev, "SM Version\t= Build %u, Commit %08x %s %s\n",
> +			le32_to_cpu(out->buildnum), le32_to_cpu(out->buildcommit),
> +			date, time);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
>  static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
>  	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
>  	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
> @@ -299,6 +336,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
>  	if (ret)
>  		return ret;
>  
> +	ret = scmi_imx_misc_discover_build_info(ph);

To align with other naming,

s/scmi_imx_misc_discover_build_info/scmi_imx_misc_build_info_discover/

> +		return ret;

The document in 1/6 didn't state this as mandatory. IMO, it is not
fair to return error if the return is NOT_SUPPORTED.

-- 
Regards,
Sudeep

