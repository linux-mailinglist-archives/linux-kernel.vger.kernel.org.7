Return-Path: <linux-kernel+bounces-791648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C4AB3B9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110D436011F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F361309DB5;
	Fri, 29 Aug 2025 11:07:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52F28369A;
	Fri, 29 Aug 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465651; cv=none; b=pUkM6ETw34y3raitOHQYMS8gc8KOTcKNnlRyFAdC8KDapwU6FzuCuTG1yqt8DmxOn1MAzHDPYOYquFEaAXnbFbdBuoWpGJdbV52rdkZ/KPYEe6g457MoaQnFsGiNHZFdvTEXYY64/Aopch580n7/kKmY6cGR/h6uArBzqRiqr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465651; c=relaxed/simple;
	bh=OuMntZNkfyDAAkBIafKM+mTQbYxmCjKGlhwBA/uVqFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpl9iIf4Elk+QJD/VWT2uRCfBBWwSVmr4ZKBqIFqAmYw7NSQoDP+26ns2N4W+6VRtJgqZSW7wZQkTzYlPXqkLVBVInXb2ibl5xXU2kWvaH7VqTN8PhKfmDPrNYq/kJTAFQPEmqPLwXebI8nvD9MrUYTl82M9WSdYByJZbbDBqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3721596;
	Fri, 29 Aug 2025 04:07:19 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 942D43F738;
	Fri, 29 Aug 2025 04:07:25 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:07:22 +0100
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
Subject: Re: [PATCH v3 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250829-realistic-dolphin-of-blizzard-2bb398@sudeepholla>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-5-82c982c1815a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827-sm-misc-api-v1-v3-5-82c982c1815a@nxp.com>

On Wed, Aug 27, 2025 at 12:59:17PM +0800, Peng Fan wrote:
> MISC protocol supports getting system log regarding system sleep latency
> ,wakeup interrupt and etc. Add the API for user to retrieve the
> information from SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 82 ++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h                  | 19 +++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index f934b4fbc6ec9f1e6b24d1c6c8cd07b45ce548e3..2d3423d83aed857329a9a367d0ec0681a1d77d0b 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>  	SCMI_IMX_MISC_CFG_INFO = 0xC,
> +	SCMI_IMX_MISC_SYSLOG = 0xD,

1. Not ordered
2. Inconsistent command name with the document.

>  	SCMI_IMX_MISC_BOARD_INFO = 0xE,
>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>  };
> @@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
>  	u8 cfgname[MISC_MAX_CFGNAME];
>  };
>  
> +struct scmi_imx_misc_syslog_in {
> +	__le32 flags;
> +	__le32 index;
> +};
> +
> +#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
> +#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
> +
> +struct scmi_imx_misc_syslog_out {
> +	__le32 numlogflags;
> +	__le32 syslog[];
> +};
> +
>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>  					struct scmi_imx_misc_info *mi)
>  {
> @@ -371,10 +385,78 @@ static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
>  	return ret;
>  }
>  
> +struct scmi_imx_misc_syslog_ipriv {
> +	u32 *array;
> +	u16 *size;
> +};
> +
> +static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
> +					     const void *priv)
> +{
> +	struct scmi_imx_misc_syslog_in *msg = message;
> +
> +	msg->flags = cpu_to_le32(0);
> +	msg->index = cpu_to_le32(desc_index);
> +}
> +
> +static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
> +					 const void *response, void *priv)
> +{
> +	const struct scmi_imx_misc_syslog_out *r = response;
> +	struct scmi_imx_misc_syslog_ipriv *p = priv;
> +
> +	st->num_returned = RETURNED(r->numlogflags);
> +	st->num_remaining = REMAINING(r->numlogflags);
> +	*(p->size) = st->num_returned + st->num_remaining;

I think you can drop () above.

> +
> +	return 0;
> +}
> +
> +static int
> +iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
> +				  const void *response,
> +				  struct scmi_iterator_state *st, void *priv)
> +{
> +	const struct scmi_imx_misc_syslog_out *r = response;
> +	struct scmi_imx_misc_syslog_ipriv *p = priv;
> +
> +	p->array[st->desc_index + st->loop_idx] =
> +		le32_to_cpu(r->syslog[st->loop_idx]);
> +
> +	return 0;
> +}
> +
> +static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph, u16 *size,
> +				void *array)
> +{
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_misc_syslog_prepare_message,
> +		.update_state = iter_misc_syslog_update_state,
> +		.process_response = iter_misc_syslog_process_response,
> +	};
> +	struct scmi_imx_misc_syslog_ipriv ipriv = {
> +		.array = array,
> +		.size = size,
> +	};
> +	void *iter;
> +
> +	if (!array || !size || !*size)
> +		return -EINVAL;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG,
> +					    sizeof(struct scmi_imx_misc_syslog_in),
> +					    &ipriv);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +

Handle NOT_SUPPORTED if not mandatory, may need update to the document to
add NOT_SUPPORTED as return value. Currently it's only success in which
case you don't need any error handling at all 😉.

> +	return ph->hops->iter_response_run(iter);
> +}
> +
>  static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
>  	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
>  	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
>  	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
> +	.misc_syslog = scmi_imx_misc_syslog,
>  };
>  
>  static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..6e18920aac56de67d388e985e3305745d3798c3e 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -52,6 +52,23 @@ struct scmi_imx_misc_ctrl_notify_report {
>  	unsigned int		flags;
>  };
>  
> +struct scmi_imx_misc_sys_sleep_rec {
> +	u32 sleepentryusec;
> +	u32 sleepexitusec;
> +	u32 sleepcnt;
> +	u32 wakesource;
> +	u32 mixpwrstat;
> +	u32 mempwrstat;
> +	u32 pllpwrstat;
> +	u32 syssleepmode;
> +	u32 syssleepflags;
> +};
> +
> +struct scmi_imx_misc_syslog {
> +	struct scmi_imx_misc_sys_sleep_rec syssleeprecord;
> +	uint32_t deverrlog;

s/uint32_t/u32/ for consistency ? Just look above 3-4 line e.g.

-- 
Regards,
Sudeep

