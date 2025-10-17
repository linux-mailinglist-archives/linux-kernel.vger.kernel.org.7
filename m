Return-Path: <linux-kernel+bounces-858274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0634BE9829
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AB7188097C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B832E121;
	Fri, 17 Oct 2025 15:07:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AA2F12DB;
	Fri, 17 Oct 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713631; cv=none; b=ekFv/SfP6sEdKtfnDqs6oAeoND1AJFb9ZsEIXZkzMobcOIvVvcdoGh+Uchrp/MgdbjLCkFIX+mXA5qq8ywaOw7yAZaJSQDasZwahr7bX1HqISB2MgN/ddb9s4Sz1ZpVkftsIP42an3CBdigJizxfmZikO2gEItv3E2Plroc5GYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713631; c=relaxed/simple;
	bh=WlSUQ5wXLRSKderV8wdsxnAk5WDay+EYZfiXWfKmQT0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPI6llVQEwC2ZWfb+mkPwVH/rTTipvZDDuXt8cQ8r8yJt7mMp/sJQqxmJcXoAYDk44A28ATOrdqcpKf3PALHeXKb7/nFe76oIumGG/CEp68C3/GYxh0lhS/UrBuH0sxJdoawQFXI1dIvOmAy1bVfLGWwD4psTSLnWQdlKB3HLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp7PK1SNYz6M4rt;
	Fri, 17 Oct 2025 23:03:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 73BA61402FF;
	Fri, 17 Oct 2025 23:07:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 16:07:04 +0100
Date: Fri, 17 Oct 2025 16:07:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 02/10] firmware: arm_scmi: Reduce the scope of protocols
 mutex
Message-ID: <20251017160702.00002af4@huawei.com>
In-Reply-To: <20250925203554.482371-3-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-3-cristian.marussi@arm.com>
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

On Thu, 25 Sep 2025 21:35:46 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Currently the mutex dedicated to the protection of the list of registered
> protocols is held during all the protocol initialization phase.
> 
> Such a wide locking region is not needed and causes problem when trying to
> initialize notifications from within a protocol initialization routine.
> 
> Reduce the scope of the protocol mutex.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Hi Cristian.  A few things inline and this runs into one of the things
that is dangerous to do with guard() or the other cleanup.h magic
(and documented there!)

> ---
>  drivers/firmware/arm_scmi/driver.c | 53 +++++++++++++++---------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index bd56a877fdfc..71ee25b78624 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -17,6 +17,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bitmap.h>
> +#include <linux/cleanup.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> @@ -2179,10 +2180,13 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
>  	if (ret)
>  		goto clean;
>  
> -	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
> -			GFP_KERNEL);
> -	if (ret != proto->id)
> -		goto clean;
> +	/* Finally register the initialized protocol */
> +	scoped_guard(mutex, &info->protocols_mtx) {

See the guidance in cleanup.h on mixing goto and anything defined in that file.

In some compilers, if you hit the goto above and hence jump over this
the cleanup variable will still be instantiated, but not initialized leading to
a potential attempt to unlock random memory.

Either this needs more substantial rework, or just handling the mutex with
out using guards.


> +		ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
> +				GFP_KERNEL);
> +		if (ret != proto->id)
> +			goto clean;
> +	}
>  
>  	/*
>  	 * Warn but ignore events registration errors since we do not want
> @@ -2243,25 +2247,22 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
>  static struct scmi_protocol_instance * __must_check
>  scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
>  {
> -	struct scmi_protocol_instance *pi;
> +	struct scmi_protocol_instance *pi = ERR_PTR(-EPROBE_DEFER);
>  	struct scmi_info *info = handle_to_scmi_info(handle);
> +	const struct scmi_protocol *proto;
>  
> -	mutex_lock(&info->protocols_mtx);
> -	pi = idr_find(&info->protocols, protocol_id);
> -
> -	if (pi) {
> -		refcount_inc(&pi->users);
> -	} else {
> -		const struct scmi_protocol *proto;
> -
> -		/* Fails if protocol not registered on bus */
> -		proto = scmi_protocol_get(protocol_id, &info->version);
> -		if (proto)
> -			pi = scmi_alloc_init_protocol_instance(info, proto);
> -		else
> -			pi = ERR_PTR(-EPROBE_DEFER);
> +	scoped_guard(mutex, &info->protocols_mtx) {
> +		pi = idr_find(&info->protocols, protocol_id);
> +		if (pi) {

if !pi we carry on with it NULL, which is a behavior change from
before where it would be ERR_PTR(-EPROBE_DEFER);

That might not matter, but it's not 'obviously' a safe change.

> +			refcount_inc(&pi->users);
> +			return pi;
> +		}
>  	}
> -	mutex_unlock(&info->protocols_mtx);
> +
> +	/* Fails if protocol not registered on bus */
> +	proto = scmi_protocol_get(protocol_id, &info->version);
> +	if (proto)
Trivial but I'd flip the logic to
	if (!proto)
		return ERR_PTR(-EPROBE_DEFER);
assuming a NULL return as mentioned above isn't the intent.
Then
	return scmi_alloc_init_protocol_instance(info, proto);

> +		pi = scmi_alloc_init_protocol_instance(info, proto);
>  
>  	return pi;
>  }


