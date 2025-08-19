Return-Path: <linux-kernel+bounces-776226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7432B2CA44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1941D1C21280
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01912D24BC;
	Tue, 19 Aug 2025 17:10:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724862C235F;
	Tue, 19 Aug 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623400; cv=none; b=WQ4uWYxX/cTOWUNhjHD8qIm6v3bNbhM362djhuTRhWC4dutzR7pFAFMONx1W9abUK7KMZmhi3FkiuG9SkQuqsvW8PSIIjXGHO4UlzyHfAjKqWt2gprL0Dd1OLGEtLzoc75Md1wGo/0lShRbQG0II9zGiGlopbT5lF6H5Ccu+5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623400; c=relaxed/simple;
	bh=YAOcmIkDFLTTzAcikF+2H/zSLiLBkJQ+34RhnGCffeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMYW2mvrkRRyzRs8Bo398raAVTwNnIbiIO329WicNiVycrxdCx4eViyfk3U6x73AzuPsI0hMIp5j3gu3Wv1//v81jU+WKp+KwfQA91k1p4ivZeCJi/w49KV5f76Z8vJbTaG/lBYx1wPtJOjLx9rgz6vNU7/J8Ep97yBEiaVYt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52824152B;
	Tue, 19 Aug 2025 10:09:49 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A26B3F738;
	Tue, 19 Aug 2025 10:09:55 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:09:52 +0100
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
Subject: Re: [PATCH v2 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <aKSv4NrDfC33Niqs@pluto>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
 <20250710-sm-misc-api-v1-v2-5-c3e953e34be6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-sm-misc-api-v1-v2-5-c3e953e34be6@nxp.com>

On Thu, Jul 10, 2025 at 04:33:30PM +0800, Peng Fan wrote:
> MISC protocol supports getting system log regarding system sleep latency
> ,wakeup interrupt and etc. Add the API for user to retrieve the
> information from SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 78 ++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h                  | 19 ++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index 6b86c35c192d02e13f0d2a7d713bc447886b84bf..193a862cf9b807232f04a6dbbd6a8efd1b40ff73 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>  	SCMI_IMX_MISC_CFG_INFO = 0xC,
> +	SCMI_IMX_MISC_SYSLOG = 0xD,
>  	SCMI_IMX_MISC_BOARD_INFO = 0xE,
>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>  };
> @@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
>  	u8 cfgname[MISC_MAX_CFGNAME];
>  };

Hi,

one consideration down below...

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
> @@ -372,10 +386,74 @@ static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
>  	return ret;
>  }
>  
> +struct scmi_imx_misc_syslog_ipriv {
> +	u32 *array;
> +};
> +

So, AFAIU, you basically use this generic u32 array to retrieve data words from
your FW in a generic way....

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
> +
> +	st->num_returned = RETURNED(r->numlogflags);
> +	st->num_remaining = REMAINING(r->numlogflags);
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
> +static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph, u16 size,
> +				void *array)

...and you provide a output array param and its size to use in the
iterators to retrieve your data...

...so you can use size to properly let iterators check bounds...

...so far so good BUT...

...is it not a possibility, especially with different FW versions in the
future, that the platform will return LESS than size data, because maybe
different platform can return different log data...I deduce this from
the fact that you are using a generic u32 array...

...so in this scenario wouldn't be useful to have the above size param as
being both an input and an output parameter using a pointer ? 

So that you can...

	static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph,
					u16 *size, void *array)

...use *size as the max_resources for iterators as of now BUT also pass
it down to the iterators in ipriv->size so that you can easily once for
all in prepare_message

	*(ipriv->size) = st->num_returned + st->num_remaining;

...so that you can KNOW if the specific FW has returned less items than
the maximum *size slots provided in *array ?

I maybe overthinking...and also this scenario will assume that the FW
can return less items, BUT still contiguos items...i.e. no holes in the
array....

...thoughts ?

Thanks,
Cristian

