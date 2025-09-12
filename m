Return-Path: <linux-kernel+bounces-814160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73DB55016
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888593AB374
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072530DECF;
	Fri, 12 Sep 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JS9cZqa1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FA30505A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685249; cv=none; b=mcSf/IuXTjtybucDeuuh0AkRYc1lzUrK29KqsOsqxesVasGCPSMiCc9sFiMM9fSMmPJgMnVDZcDF2kS58hKXUGdORcF2584zHmjHPbq9r+pgB7TAa7VdBGZliSxnD3Lw09si+440ubBmSym7HFnYBWd4pGycQ2DXYRyTmXGH/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685249; c=relaxed/simple;
	bh=fYDxj4TQJQ7Wj2bc2QbChTPSUPWyqEK1EhkFoltlaI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEq2EfpN4Y4Q6q/q+ADFlX0QUUKOz17OEHyUKfvK3R4qsCGOgjMw9FuuLcnyVABzR/V7ZZSpiHKcFoyH9lS7lNI97jtz01dd+Egd1bVTxFWbjT8mehd03YswqfUn+AAwI/VUohgB3btKwYftw76bXkM6Brwk7NAtHdOqpzcZXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JS9cZqa1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so1693633a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757685246; x=1758290046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyJ2QrNSPpofXSwz4SHyhJQvRMiElOl6uxmOWE9Z9cc=;
        b=JS9cZqa1Ulqn2Ik57c4vcw5ZFjaUF0yxkfULdRafWjsQ9jhCsHkFAsD8HxjCEAy47p
         NrQigVfe+u1h9sC9R2sncPm+W5NThPvAHi/10En8UVjDBBIVGEnrh3cVkadyY/mHzL7Y
         iu+NJS3iwzRyyC40pMB32yPUX27wd34+UqRmCHyspxzkzT/S5LR/HrdA/AWq7Fl7zHO6
         chaeGHGyVH9K79eKyPxuuYKn9AgStEQHRJbmL0r+AHEfFhJ6bblTHQUKyk8Bwv82Z92T
         ea0fuNnfG4XFW326jHBhjpTfev8kIUpSY8onEFEmHxWOLshWBbmDCJObLh+3jvx/QD56
         EthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685246; x=1758290046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyJ2QrNSPpofXSwz4SHyhJQvRMiElOl6uxmOWE9Z9cc=;
        b=XHSRPdfeSWoyZtfo/6JSMTyCVqQ8VZ5gF9ythnu9S5HDfyKaKMAo6XFQPaluwodabA
         /Mxf1yOLk5kpz9efqcfFlyCaN7mDo4x6hkMFvIB39OtZPBuWB40OKGXcuO+lNynZlS4V
         UsIHiNvbUwsIPTluFMttK9cyIsH+tz+MDxsk64aj+bBwSYFeSvJq6pIrd5CFkeqlnBj4
         4eG675j1eOBNNGWfJCMIgWU0ZhvEfl9IDVTz5vf/VOO02er+WU+MFbC5WujiESATTFtw
         et6zIDKxdwM7WNCJ7W8nQeiIyl9Y/yev7qwUA6oJN7cT72fTxB0tC7IDZAc8pyww7imi
         UPUg==
X-Forwarded-Encrypted: i=1; AJvYcCUepA/IjMVYWgprB6XSu5GVmB7Q1zFtl670Pt/Rt8Lgm3e1+tUT7274NNGbR4El5clg42PY8IWU6R9B4XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/YJNcKOLQoawpDETAxOpqQZeFF+8nHMHqgjo5HDVFrF3t6zq
	6yKRLETffMwesfTT6CA6gzyWma77oqsDb2tkO6QFmBBBC/mV0u/2xz1l46Jgo08DF6A=
X-Gm-Gg: ASbGncsNKCvnDcoPFn+z9jbDf4PmAtHHlXFnucvf3U6zWV4wy1aAGejNCC7i7ZBwlCa
	ipDIkyZAZD8i5rzhEcuaSs4D/iCCfgSpkAUj0ihyUoVTR+RuqUg13HHRUN6/P/5X9H+LYNDOyHL
	u4nuye6VQ9Ig7vCBCtzcqMg4asvJw+b6wXlSgv44nqh9qz/DwAbcmqGzpdgascinOnuRF2y6xIA
	yVSGZYFvg6tgt05549j2Ax3MZScFSfb46JoBP+X0zd6l+2CeJMOFS3/2qFkYY0GBxpXqKAEiS+7
	jnxJDaXcBJTYvD9BjEfjw8rzp2TFMbDgp5eapFY7UpBKa8y8TU8t+QyApUmITVkO6BHAhu2kDol
	fef2rSIEVsA7aNIz9jHxWKO2tohKIc4Mymlzmdg63bm8Yf4MazDMYH79gvHFa5Iw=
X-Google-Smtp-Source: AGHT+IGLna4QvgAwH+y9fiaoSNhZuY4/GpQUf8k/O/HrPL3FzcefwfbnWIwjuerIkhrw91ozq40o4Q==
X-Received: by 2002:a17:90b:1b50:b0:327:9735:542b with SMTP id 98e67ed59e1d1-32de4fad2bamr3187655a91.35.1757685245925;
        Fri, 12 Sep 2025 06:54:05 -0700 (PDT)
Received: from [10.254.128.3] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dfc974426sm68216a91.20.2025.09.12.06.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:54:05 -0700 (PDT)
Message-ID: <f18f6248-4774-47bf-91c6-159005593153@bytedance.com>
Date: Fri, 12 Sep 2025 21:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is
 -1, get dma_dev is NULL
To: Pavel Begunkov <asml.silence@gmail.com>, axboe@kernel.dk,
 almasrymina@google.com, kuba@kernel.org, dtatulea@nvidia.com
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20250912083930.16704-1-zhoufeng.zf@bytedance.com>
 <58ca289c-749f-4540-be15-7376d926d507@gmail.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <58ca289c-749f-4540-be15-7376d926d507@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/9/12 20:40, Pavel Begunkov 写道:
> On 9/12/25 09:39, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> ifq->if_rxq has not been assigned, is -1, the correct value is
>> in reg.if_rxq.
> 
> Good catch. Note that the blamed patch was merged via the net tree
> this time around to avoid conflicts, and the io_uring tree doesn't
> have it yet. You can repost it adding netdev@vger.kernel.org and
> the net maintainers to be merged via the net tree. Otherwise it'll
> have to wait until 6.18-rc1 is out

Thanks for reminding, will do.

> 
>> Fixes: 59b8b32ac8d469958936fcea781c7f58e3d64742 ("io_uring/zcrx: add 
>> support for custom DMA devices")
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   io_uring/zcrx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 319eddfd30e0..3639283c87ca 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -600,7 +600,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>>           goto err;
>>       }
>> -    ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, ifq->if_rxq);
>> +    ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
>>       if (!ifq->dev) {
>>           ret = -EOPNOTSUPP;
>>           goto err;
> 


