Return-Path: <linux-kernel+bounces-791613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9DB3B931
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6329B1B2591F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4030FC11;
	Fri, 29 Aug 2025 10:50:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFA30F813;
	Fri, 29 Aug 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464627; cv=none; b=HHU2sSI/FqkOs3yHge3j+Q4CfOqb/5+TOj4Rob1wXJExs3g4eQMhMqBwx1T98+PojCExoqtUtIGNQG9uaPT7vLML8aq991Tit5+SeyBJaUFFhsA45NTN6oZm0BJh8XPH1vHwhyHCA/L4gyRR9MaK1wMuLC2KW96dopcou7o8F14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464627; c=relaxed/simple;
	bh=DQ8ssogXZkvnCVE3uT5BWAUe/YqLqrQMJHQmW/wRDs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqOpQobBvrcyPEfQ+lIhXLUuM888DoeIdwSVvrGtImz6Y/XEn+glh7CcQYgMnT1CRxkRYkTZe2wN2W1deEz/HsNjbeMpMvWaEze+13mk+yljjykfvO4q4L78+9RXPhQIHAAnJv6mKBpLd4MgQmLribGwfiJN0T0gI9tFHpHQ/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49FC91BCB;
	Fri, 29 Aug 2025 03:50:17 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B42AF3F694;
	Fri, 29 Aug 2025 03:50:23 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:50:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <20250829-woodoo-acoustic-lynx-7ffaba@sudeepholla>
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

And fix the alignment above, just noticed after hitting enter.

-- 
Regards,
Sudeep

