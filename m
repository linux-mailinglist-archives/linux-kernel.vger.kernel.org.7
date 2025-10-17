Return-Path: <linux-kernel+bounces-858276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DABE9924
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABA5188EDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A333031B;
	Fri, 17 Oct 2025 15:10:22 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4E2F6932;
	Fri, 17 Oct 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713822; cv=none; b=L/SqW18t2jMeuFt97S9BHrFqQc7u3cnlyLOWRsqtJ6ZmW99QpWd6avvXQHGRk2cUNU3p9n705bvbcLovO+8BXtT+SkE5CAeVs0ytLM7m1N0VC8eamB4tFotaNAtW961RtUb7mOJawULxJhsMU3nswuuC9pH4CmV1rqe9NfzCU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713822; c=relaxed/simple;
	bh=cBZB+o7awJSM5IFkiX30sjtoDlWX3dVOuSreHm4+oVQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FishEH4oJCPgMCObb6//tsGTac/S3hoAum8krQuiiC8XBktRqyPjmfs5yFbYKCKEmOh0vZch1nsxynG23QDTdvXjQSyXixyIo+vqXdv/DZY8nVeHd6zdIL+q6WA4faa2XI+QzyNInAFUqGxocnXm83+eT2X0gWF1yN/BCLg1uI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp7T06X0Yz6M4KG;
	Fri, 17 Oct 2025 23:06:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F42D1402FF;
	Fri, 17 Oct 2025 23:10:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 16:10:16 +0100
Date: Fri, 17 Oct 2025 16:10:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 03/10] firmware: arm_scmi: Allow protocols to register
 for notifications
Message-ID: <20251017161014.0000347c@huawei.com>
In-Reply-To: <20250925203554.482371-4-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-4-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 21:35:47 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Allow protocols themselves to register for their own notifications and
> providing their own notifier callbacks. While at that, allow for a protocol
> to register events with compilation-time unknown report/event sizes: such
> events will use the maximum transport size.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Hi Cristian,

A few drive by comments...

> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 78e9e27dc9ec..3e623c14745d 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -593,7 +593,12 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
>  	if (!r_evt)
>  		return -EINVAL;
>  
> -	if (len > r_evt->evt->max_payld_sz) {
> +	/* Events with a zero max_payld_sz are sized to be of the maximum
Local multiline comment syntax seems to be
	/*
	 * Events...

> +	 * size allowed by the transport: no need to be size-checked here
> +	 * since the transport layer would have already dropped such
> +	 * over-sized messages.
> +	 */
> +	if (r_evt->evt->max_payld_sz && len > r_evt->evt->max_payld_sz) {

> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index d62c4469d1fd..2e40a7bb5b01 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -161,8 +161,13 @@ struct scmi_proto_helpers_ops;
>   * @dev: A reference to the associated SCMI instance device (handle->dev).
>   * @xops: A reference to a struct holding refs to the core xfer operations that
>   *	  can be used by the protocol implementation to generate SCMI messages.
> + * @hops: A reference to a struct holding refs to the common helper operations
> + *	  that can be used by the protocol implementation.

@hops isn't added in this patch so either it should be handled in where it was
added, or if that was missed a precursor patch to this one.

>   * @set_priv: A method to set protocol private data for this instance.
>   * @get_priv: A method to get protocol private data previously set.
> + * @notifier_register: A method to register interest for notifications from
> + *		       within a protocol implementation unit: notifiers can
> + *		       be registered only for the same protocol.
>   *
>   * This structure represents a protocol initialized against specific SCMI
>   * instance and it will be used as follows:
> @@ -182,6 +187,9 @@ struct scmi_protocol_handle {
>  	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv,
>  			u32 version);
>  	void *(*get_priv)(const struct scmi_protocol_handle *ph);
> +	int (*notifier_register)(const struct scmi_protocol_handle *ph,
> +				 u8 evt_id, const u32 *src_id,
> +				 struct notifier_block *nb);
>  };
>  
>  /**


