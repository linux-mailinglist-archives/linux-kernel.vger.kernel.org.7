Return-Path: <linux-kernel+bounces-896842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50155C51588
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B936334B36C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74862C0262;
	Wed, 12 Nov 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="d7ZEEf2E"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C52F3600
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939607; cv=none; b=UmvCpDk3lOQFvqd1YqmMbt5v+/Xvxfzx8E31s+Pf9bFfXuJdT0O7/2lVXo0vBlOFTqcEflradSvgdFfYiMORXt2ZIPNMhtL3svtRWYh2at8/OkERPnUntPboFs1IDP4otx9apZ1HOwaYanc1OyKexxEBz9yKg/e7hjPA9ly/Maw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939607; c=relaxed/simple;
	bh=Bv1vk741p4JJsa9EJzAU8Q1WivVpE6uUjg664knKdrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3SCVeUyBFhuuw2HYEA2E8DAWu8JqtTWmB7bx4Oky2QZ11EJrGs5LXqNSo/j7AosrkH1rX1w/hjYetPZtNjsFKUjpQD2WPrF0teAJd6L7yxrvDonJBXw9/5B+WHtcKjZ2K1863qCXzVmLBT3FSKDBM4JgqkIKwCYQ5qY8jdhs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=d7ZEEf2E; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso477701f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762939604; x=1763544404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6o4ShRZkHRUWNEA1Gxq8wchbZOAVId9k8T/+YEnweQ=;
        b=d7ZEEf2EH/zDKu3+zrMiagnra+nXBIkHmcP98xMHtAi9iDqSiJvsRA+wBWlAQSbdVb
         iXgpntjHw03/ZdykDrBX0Txom7wZoSnjNF5UeI+igJSSg36ZlyxFc4WKmrvWgpdFYafp
         CD0szmxAZEnp512soI+Y/aPKUneETXFjElTrakl4Dqcl3LbTLWI45ZVRntTrH5STDfzE
         8lBVAp+W3JK+kyaIsbvneXUJBVU7HJlnTq0xGsfySjLqovCCE6Y3AAUouCXMg5gt76Qo
         /XN7emR9THCw0sZcuhwsHif0mEgQyhrb2XcX4w0q731bpDV23S+CCcWxki6rHdJIC+cD
         7DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939604; x=1763544404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6o4ShRZkHRUWNEA1Gxq8wchbZOAVId9k8T/+YEnweQ=;
        b=LOnQOat8sxnM6SQp46mvX0BYuM3MgUQptm1InK0bdwhZStIFIwmbDA0G40pcYcPnHh
         i1lQh3KYEZixMmT0aSrofVbL33Pve39aqLpxRIWRY4p2VF7FuVUU8H1LM7nU33m01gvb
         hEpT3+POzNr+eT2xBC+I3x7A+blH5KTx7x8p/DTykuOOpXkY22fChRrTSqDSNm26uFA1
         9CzkTnVLyWLMMMyBAbgeoXmR1XYjL+gqMTXDcYIFbpHrFl2YaOylnaK0HOIG+vZTUTAb
         lwmC32l53GwyAglS7YORFpitR1bfdXzyjsWrTCDt8f9QJqzeJQm192M2BUPJRfYPDFTv
         kDEw==
X-Forwarded-Encrypted: i=1; AJvYcCWRE23UTO37Pp0datNEffQe9r6Rlfg3buX/qC/a/MWqYDh733/Gg1++aHoQPQZhvx/DyomaRQWdn+nVmCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5C8P50kUhO8NAH3K4R2TGKN/7GDHRcSc9/isp3lXOVKoEX5/
	nNgjN7U2XJfYXwYULeotimDNl9aTXMMQUPmBP5oFx80Gd++Sul/F7We5ldYEnHinKEU=
X-Gm-Gg: ASbGncsYlQ05hJjclWS6Z26jZnWT5eWXkQN/7klZ9F7BIJzM3a1KhfCdKOLXIRZeWVK
	uSkHLoeclclGWcojUlrq3OtrVPIviuW0XrYWWx0ablOWH0gztMgDr6KyOxDAq+0Fo5lqPBSkAqK
	nYjDO1cS2ggx2wnVCr4Ebr/e6sxukgeRS2x4wZ2aP7+qllS2l6pPz1CFO+7IrE8t0msnz/EB+m5
	JG45tpcV5ElqqH1D4zV62rMQwLPEhR2BZCmg1682ggn23ySixjBWxrE2Jbr2pnsQ80gChwEr42e
	YqqUfpkg8/e1GK4mLVqtYu4eleNQx2LOmHfTHnwifKbFc0Rv2KxIBCMHh8FpH54Ysw+kJlTsSwv
	ge1BXNG3q0toy+VYLGH8AT0EaDWJnIO71hJYKuLafAGP7zE7X0eHKIWn9NXqrec0ERjrSI85Gyv
	7k3bkEzYQnTGyFTG+OVNaryg==
X-Google-Smtp-Source: AGHT+IFY7UcjIa0YdZIgSPVahVRS/IE+hi9DKKHSOUoFypj2RLkC1gFWvUzqpprhzIE1XretNfh8CA==
X-Received: by 2002:a5d:5f87:0:b0:42b:41dc:1b58 with SMTP id ffacd0b85a97d-42b4bdb8247mr1934029f8f.45.1762939603510;
        Wed, 12 Nov 2025 01:26:43 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63df69sm32884187f8f.13.2025.11.12.01.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:26:43 -0800 (PST)
Message-ID: <04291a87-24c9-433b-9bb6-7e70ea19459f@ursulin.net>
Date: Wed, 12 Nov 2025 09:26:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Fix outdated sched_job docu
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251111161502.86180-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251111161502.86180-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/11/2025 16:15, Philipp Stanner wrote:
> There is no such thing as a "done_list" anymore. Remove mention of it.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   include/drm/gpu_scheduler.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index fb88301b3c45..18d6210ce2d0 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -320,7 +320,7 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>    * struct drm_sched_job - A job to be run by an entity.
>    *
>    * @queue_node: used to append this struct to the queue of jobs in an entity.
> - * @list: a job participates in a "pending" and "done" lists.
> + * @list: for enqueueing the job into the list of pending jobs.
>    * @sched: the scheduler instance on which this job is scheduled.
>    * @s_fence: contains the fences for the scheduling of job.
>    * @finish_cb: the callback for the finished fence.

Interesting that I cannot see there was a done list at the time when 
that comment was added. Anyway, I did not dig much further back since 
for the current state the correction is obviously correct.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


