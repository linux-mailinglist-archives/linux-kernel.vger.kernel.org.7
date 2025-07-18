Return-Path: <linux-kernel+bounces-736576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916CB09EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41C01C445E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7009295513;
	Fri, 18 Jul 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMwSPG7t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446D20E71D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829777; cv=none; b=YEOZpFpcdiqFVff3rdK+yrSXPdfk+xY5bG0VBG8sdn+ddRgQATdwMuqPrm11lvFYwiKYuAhZqD3k+lWegyD7jBEKsQOlu306TH+nYdXvTWXKjvDtz3+7DjMva836TKggxyk6WESecZgeRO/ZS1ntZBp0n2hSddtAKisSPWaCvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829777; c=relaxed/simple;
	bh=UtCb0XEENQrhwIrwSyIf3fzwd5mpbrwW2EYLLnWjwOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWMfAlchIIVttrQIhgsbplZyXcMoVFAXguFnFlvfqKGhpKq7xSVYrsSmoRJKHG+oQGqMHiYtHVMZjxi5AJEGh31KF7scSU7hGz5nvdduLNqj9j4Tv3p0mU0C//2axSjBhV4S3aMelW64sWmlQ/cV5GYDSEv0j1Iec/1dFGkorto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMwSPG7t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752829774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLyNWUZYLntH6kzg6fsWrkbR7v6uvcRiHtF10eyX+X4=;
	b=DMwSPG7txv2LAWgrTJHAyq3Cn776uZvyTaT6fD5UBZwJeyZtlkbXFLLK8Hw00RHzTFqOJR
	POWdrpcDQfJIDeRYOWTQpLvvCKs99CJai+pnP5WKPF12KGWshKPLnQ8RsQIfdeGKKQTvvB
	zPrfmKrXbzmMRDgPk4DuaPq3B5Xnkm4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-lpn9YZEBO6KzPZK-AB6L9A-1; Fri, 18 Jul 2025 05:09:32 -0400
X-MC-Unique: lpn9YZEBO6KzPZK-AB6L9A-1
X-Mimecast-MFC-AGG-ID: lpn9YZEBO6KzPZK-AB6L9A_1752829771
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45600d19a2aso17078545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752829771; x=1753434571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLyNWUZYLntH6kzg6fsWrkbR7v6uvcRiHtF10eyX+X4=;
        b=FTH+Zq9sMchTKGTaHomOtwGLE+WJBAXd5/IO/QM8+Kv+oWmgIrYEHDXegt2IBdmdF+
         vevQHmZH5Ijd7of09LjN8BvAAu7gQJ19ej24wn9YJDJ3Qt8YdoLbcmP84Gccd+rgE+Ji
         wzmOBI+N+kWFUQ57332tdDi2ilt+XAJepom+kA5+iOvFOtRGVDHZuWgTy6YTXC/+TbjE
         yOjsIG1O/lwdyn+QxEB0HdfF5hy42bqeDBacGm6zdJohRI4muNZnAbY+dISvOjMyChvs
         l2pvmPUVrGW4u+4yBIa4vGpODn/BMO/rPAnGN/DrPjER1pCHhCFvjeuJcb5oqAd5PorG
         3yjw==
X-Forwarded-Encrypted: i=1; AJvYcCWrrx0Iza668kPw9ZOth1X47Av+/XQmPXLVrrDVLf7n7bPH++VqRbrlBFSgIKyNJu6Lon9UhUDAxrF3RPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQESmolWqrIleuwZ42bxnDue40ckQLZ/D5nsM4GDOtNch7V46e
	Gtv9GEP7eQaqEyDADv4ESH0iK75wGxG0yw3OrEQebG2909MTNnbU82smP1OwYJPexAoo3gu3MFJ
	fZKP89wtywty+cBBpUGlhnM6Lkl6YLHwtFcU4aUGwKz8eo6doAeq/YWsjKXXuSaEedA==
X-Gm-Gg: ASbGncuJGp2e6OmJHj24KpPhEEvItu58n+4XF1m6zz5czqKwsUL6/QNod8T4YKns+lJ
	XNRZt7tplEBILJiW8HE0OnkFH3kKR+WDO0+IPd1QshEy/u6lHsPkA4WbqkbjavhD5NjtbY0XSxn
	0SLlsCamssvV+TZHMbcFuJA5R5CPm4hQQNIiOXTrDRi3AZitwkZ8hYxogY2UcXcfssKyiNQbgSK
	wWETovUTmw6mf5YnfYsyrwenUEzHCttzIlnRcm4Ywq8jyEDmoEmxrOjsi0TYs05yKjgYfaIZXY2
	3UAgPEZkinCSeuJ9e5BcaAO8q78EbpfFPMYGQYr0N7rlYZwoJsf7E6YUcoTyXo270w3kCsdSJ2a
	CdDcPRQ4E2eM=
X-Received: by 2002:a05:600c:4709:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-4562e32e598mr89675335e9.4.1752829770943;
        Fri, 18 Jul 2025 02:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGN/Cv3drNsF8UaKNdX/NfxKGTgGum22Q8FGNtEDQQFlxthmY+ud4BApn5/n0KWmB/pCzOcw==
X-Received: by 2002:a05:600c:4709:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-4562e32e598mr89674875e9.4.1752829770415;
        Fri, 18 Jul 2025 02:09:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e818525sm72859355e9.16.2025.07.18.02.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:09:29 -0700 (PDT)
Message-ID: <0becc009-68a8-452f-9115-a5df3ca998ed@redhat.com>
Date: Fri, 18 Jul 2025 11:09:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and
 getcrosscycles
To: Carolina Jubran <cjubran@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
 <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
 <4b81bea4-ef05-4801-8903-2affa02d2366@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4b81bea4-ef05-4801-8903-2affa02d2366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/25 5:56 PM, Carolina Jubran wrote:
> On 17/07/2025 13:55, Paolo Abeni wrote:
>> On 7/15/25 7:15 AM, Tariq Toukan wrote:
>>> From: Carolina Jubran <cjubran@nvidia.com>
>>>
>>> Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
>>> expose the device’s raw free-running counter.
>>>
>>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>> ---
>>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
>>>   1 file changed, 73 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> index b1e2deeefc0c..2f75726674a9 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> @@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
>>>   	return 0;
>>>   }
>>>   
>>> +static int
>>> +mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
>>> +				struct system_counterval_t *sys_counterval,
>>> +				void *ctx)
>>> +{
>>> +	struct mlx5_core_dev *mdev = ctx;
>>> +	u64 device;
>>> +	int err;
>>> +
>>> +	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
>>> +	if (err)
>>> +		return err;
>>> +	*device_time = ns_to_ktime(device);
>>
>> If the goal is providing a raw cycle counter, why still using a timespec
>> to the user space? A plain u64 would possibly be less ambiguous.
>>
>> /P
>>
> 
> getcycles64 and getcrosscycles already return the cycle counter in a 
> timespec64/ktime format, so I kept the new ioctls consistent with them.

Ah, sorry I missed that context. Looks good to me than.

Thanks,

Paolo




