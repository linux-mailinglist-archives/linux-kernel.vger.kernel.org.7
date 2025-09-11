Return-Path: <linux-kernel+bounces-811791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C44B52DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BA55672B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162130DEBB;
	Thu, 11 Sep 2025 10:03:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40826AD9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584992; cv=none; b=HRcSL4eaktFsR7ShsZuC1LX89AgsILihQMpU4v8UBVN9W7dtI5qdjGpFy5VUmH34xQ/e4F77aKqBDLElBcTJIdLpDXJ/8Dm2tiPvxO2bQAvEIaB47pvHo5QX7IeWOWRtYej2kx5aq0uUvwkXXCz3LnfKya650QZTZSqof9U99zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584992; c=relaxed/simple;
	bh=AiaTSXsMc3D2dBcx/iT2cNLaKTUrWt5unOdEKO3LKZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KzSaOnr/FGH3GeJ7gaS8i/DASIqTusg16/FE6FiJcObeaAl6nVZtF4wL1SMd/QJz3yQD9RzW0ew/KSAK7ne2bIF/Ik4Yo1XAyd9RexIJ5s6wPgtl9D9kAePKGcrihEGj24awCEQwm+wl7AY7oyMn9jP2Lk99aDgfPpPGsGmV6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C64E0153B;
	Thu, 11 Sep 2025 03:03:00 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D41833F66E;
	Thu, 11 Sep 2025 03:03:07 -0700 (PDT)
Message-ID: <9c86b280-60de-4819-855a-87c91f057dcd@arm.com>
Date: Thu, 11 Sep 2025 11:03:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] coresight: Separate failure and success flows
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mao Jinlong <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250512154108.23920-1-leo.yan@arm.com>
 <20250512154108.23920-5-leo.yan@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250512154108.23920-5-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2025 16:41, Leo Yan wrote:
> For a success registration, it releases mutex, then binds associated CTI
> device, and returns a device pointer.
> 
> As a result, it separates flows between the success case and the failure
> flow, any code after the tag 'out_unlock' is only used for failure
> handling.
> 

This description is a bit ambiguous. Please could we simply say:

Subject: coresight: Cleanup coresight_register error handling

Separate the failure handling path from the successful case.
Use the out_unlock label only for the failure handling.

Rest looks fine to me.

Suzuki

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 4f51ce152ac7..4fc82206b326 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1377,17 +1377,21 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	registered = true;
>   
>   	ret = coresight_create_conns_sysfs_group(csdev);
> -	if (!ret)
> -		ret = coresight_fixup_orphan_conns(csdev);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = coresight_fixup_orphan_conns(csdev);
> +	if (ret)
> +		goto out_unlock;
> +
> +	mutex_unlock(&coresight_mutex);
> +
> +	if (cti_assoc_ops && cti_assoc_ops->add)
> +		cti_assoc_ops->add(csdev);
> +	return csdev;
>   
>   out_unlock:
>   	mutex_unlock(&coresight_mutex);
> -	/* Success */
> -	if (!ret) {
> -		if (cti_assoc_ops && cti_assoc_ops->add)
> -			cti_assoc_ops->add(csdev);
> -		return csdev;
> -	}
>   
>   	/* Unregister the device if needed */
>   	if (registered) {


