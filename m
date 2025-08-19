Return-Path: <linux-kernel+bounces-776125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBEBB2C8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111455E80A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD628C011;
	Tue, 19 Aug 2025 15:57:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0282C181;
	Tue, 19 Aug 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619076; cv=none; b=OnNcyHkG94ho9TM5FN++9HvQo8m/okWq5S7fV58daDhbIawp3C+CJqmPK7XFiQPNNj1+KXmWXXU3++KMXffbUizTYOm1NoBpbd5+hcrmLuDDTmxbwuNfgPjo6XBG4O1Jk05fF5RbMx0R1JallSnR053bjOBQFuoeeavO6yj9N9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619076; c=relaxed/simple;
	bh=nYYLDWQBmLQmz4JALrztFGvJiqadcsJbTxGWE8ZkhfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7x7htZ8F+a4hzuW5nRW5IzQOwYJ7iuYRlIerZwfMhibSFZf9rfcnb6h51q1oT7qxMLkKy7ldLC3y9+wuj/xTF3rKcwRZs+zvDA0BH0VkjkNjs8SlCgKlBUWd9uDRPc+07X35j5LZnt3qeZARVISmSn3y/8DPBjzcmzTjuDGknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6B55152B;
	Tue, 19 Aug 2025 08:57:44 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14D53F63F;
	Tue, 19 Aug 2025 08:57:51 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:57:49 +0100
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
Subject: Re: [PATCH v2 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <aKSe_dpuQ35eZaVs@pluto>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
 <20250710-sm-misc-api-v1-v2-2-c3e953e34be6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-sm-misc-api-v1-v2-2-c3e953e34be6@nxp.com>

On Thu, Jul 10, 2025 at 04:33:27PM +0800, Peng Fan wrote:
> MISC protocol supports discovering the System Manager(SM) build
> information including build commit, build time and etc. Retrieve the
> information from SM.

Hi,

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index a8915d3b4df518719d56bfff38922625ad9b70f6..b301f09ab6cc65d286edb8819031d7f4c02e8272 100644
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
> @@ -272,6 +282,34 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
>  	return ret;
>  }
>  
> +static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_buildinfo_out *out;
> +	char date[MISC_MAX_BUILDDATE] = {'\0'};
> +	char time[MISC_MAX_BUILDTIME] = {'\0'};

...dont think that these 2 array needs to be NULL terminated given that
they are used as the dest buffer for strscpy() which always terminates
the dest buffer returning always a valid string.


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

...other than this...LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

