Return-Path: <linux-kernel+bounces-895853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD4C4F1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1DAC4F19C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39483730E2;
	Tue, 11 Nov 2025 16:48:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E713730E5;
	Tue, 11 Nov 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879725; cv=none; b=nESS7YtotOpI8mNjVxoY0DyynISU6ptEYz6v7lGr+OKmMPxBezYLOOPPFZR/CpjHotEiTFBfwY3BGlsFYqnoTlB/xaOpfYHrGAw6CX7K91iB+PorSNOxQAzzeatZ74Db6mbW18tn9q2XtyEeAq7SGyk+xEOQAi7vuobcFLaFocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879725; c=relaxed/simple;
	bh=49z32g0qxutzJRq752NeRyM/9fJzJX8OP1/nJk86YwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkmyY4dbWoA7hvHXGuyXyfQtp0lf0JSBxhwO7b0ZfWm42erwj7k8j574F7o6NP2ik5uUs2o9REakyyeVgpcX/VZtcjmkIARRxcrWEsqrXNRki7g8mX1A6dLZvC5UFb83PBgA/L4LSFj71dxMTmKaKOOCrya9/6xF3qU4vZCInjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F91C497;
	Tue, 11 Nov 2025 08:48:35 -0800 (PST)
Received: from [10.57.73.196] (unknown [10.57.73.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 358D53F63F;
	Tue, 11 Nov 2025 08:48:41 -0800 (PST)
Message-ID: <43937832-0e03-4f0b-bdce-dfa12fa801c2@arm.com>
Date: Tue, 11 Nov 2025 16:48:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etm-perf: Fix reference count leak in
 etm_setup_aux
Content-Language: en-GB
To: Ma Ke <make24@iscas.ac.cn>, mike.leach@linaro.org,
 james.clark@linaro.org, alexander.shishkin@linux.intel.com,
 mathieu.poirier@linaro.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20251111144203.16498-1-make24@iscas.ac.cn>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251111144203.16498-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/11/2025 14:42, Ma Ke wrote:
> In etm_setup_aux(), when a user sink is obtained via
> coresight_get_sink_by_id(), it increments the reference count of the
> sink device. However, if the sink is used in path building, the path
> holds a reference, but the initial reference from
> coresight_get_sink_by_id() is not released, causing a reference count
> leak. We should release the initial reference after the path is built.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f677c08233ba..6584f6aa87bf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -453,6 +453,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   	if (!event_data->snk_config)
>   		goto err;
>   
> +	if (user_sink) {
> +		put_device(&user_sink->dev);
> +		user_sink = NULL;
> +	}
> +

I would recommend moving this to the out: label below, to make sure
we drop the refcount even in the error path.

Otherwise looks good to me.

Suzuki

>   out:
>   	return event_data;
>   


