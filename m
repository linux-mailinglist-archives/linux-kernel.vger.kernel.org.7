Return-Path: <linux-kernel+bounces-861327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A98BBF26F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B007018A6929
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341A267AF2;
	Mon, 20 Oct 2025 16:30:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948D1C28E;
	Mon, 20 Oct 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977842; cv=none; b=L3pWw1t4D7aP2gK0dylPyPH/EGK0MhDD9mghhu3dkaTEwT+kUtm/cD3KLPr7zwXcB9pwPsO9bYsgGt1iZE7BBH2T79DZ58yd5OiWmHNru+if0Z01kZ93oL01w3zZt4YSuVH1pyudB0S5b0rNvNAtPpZSDMKcDjDFxJB0oDnNmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977842; c=relaxed/simple;
	bh=CNXzha2xG/lnbXIdZ1b/HGoxw0vpJia7eENqBa9pQfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvkntTal2A9EoJPqgEKwK2PN0UjmtohZVBguxmB//W8dcdWq7DewdA/KBHos3S8LCp/MW2KRWStCUJy30+W/DgIG62eINVYxxthN9tgNYH41N6b/xLbSxkQl3Nb/Od7i3VJB4uYm2vCbFfiYlf7m7SR9YvTXrqwyEPDH8SLJpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cr16n6Yjrz6L5Xx;
	Tue, 21 Oct 2025 00:27:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EA82140275;
	Tue, 21 Oct 2025 00:30:37 +0800 (CST)
Received: from localhost (10.48.157.75) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 17:30:36 +0100
Date: Mon, 20 Oct 2025 17:30:34 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 07/10] firmware: arm_scmi: Add System Telemetry ioctls
 support
Message-ID: <20251020173034.00005c15@huawei.com>
In-Reply-To: <20250925203554.482371-8-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-8-cristian.marussi@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 21:35:51 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Extend the filesystem based interface with special 'control' file that can
> be used to configure and retrieve SCMI Telemetry data in binary form using
> the alternative ioctls-based ABI described in uapi/linux/scmi.h.
Why you say alternative.  Why do you need both?

That's in the cover letter but I'd put something here as well.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../firmware/arm_scmi/scmi_system_telemetry.c | 402 ++++++++++++++++++
>  1 file changed, 402 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> index 2fec465b0f33..f591aad10302 100644
> --- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
> +++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c

> +static long scmi_tlm_des_read_ioctl(const struct scmi_tlm_inode *tlmi,
> +				    unsigned long arg, bool single,
> +				    bool is_group)
> +{
> +	const struct scmi_tlm_setup *tsp = tlmi->tsp;
> +	void * __user uptr = (void * __user)arg;
> +	struct scmi_tlm_data_read bulk, *bulk_ptr;
> +	int ret, grp_id = SCMI_TLM_GRP_INVALID;
> +
> +	if (copy_from_user(&bulk, uptr, sizeof(bulk)))
> +		return -EFAULT;
> +
> +	bulk_ptr = kzalloc(struct_size(bulk_ptr, samples, bulk.num_samples),

__free() would help here.

> +			   GFP_KERNEL);
> +	if (!bulk_ptr)
> +		return -ENOMEM;
> +
> +	if (is_group) {
> +		const struct scmi_telemetry_group *grp = tlmi->priv;
> +
> +		grp_id = grp->info->id;
> +	}
> +
> +	bulk_ptr->num_samples = bulk.num_samples;
> +	if (!single)
> +		ret = tsp->ops->des_bulk_read(tsp->ph, grp_id,
> +					      &bulk_ptr->num_samples,
> +			  (struct scmi_telemetry_de_sample *)bulk_ptr->samples);
> +	else
> +		ret = tsp->ops->des_sample_get(tsp->ph, grp_id,
> +					       &bulk_ptr->num_samples,
> +			  (struct scmi_telemetry_de_sample *)bulk_ptr->samples);

That is very unusual code alignment.  Drag 2 lines above left to match one line above.

> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(uptr, bulk_ptr, sizeof(*bulk_ptr) +
> +			 bulk_ptr->num_samples * sizeof(bulk_ptr->samples[0])))
> +		ret = -EFAULT;
> +
> +out:
> +	kfree(bulk_ptr);
> +
> +	return ret;
> +}


