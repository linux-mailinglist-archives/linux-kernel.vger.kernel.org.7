Return-Path: <linux-kernel+bounces-817691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B5B5856F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD71B22615
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24070285404;
	Mon, 15 Sep 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9P1LQHn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1D280335
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965155; cv=none; b=uzHshM9TtPtAWhQ9GFHSfZZ82U7DwBAgASmw3t0vK1r2c0yeJQpUAZs+j+6SJBR0N2fOCCjaeJljMupiVx7vAlagamQ5GRDe3kvImgqRBf7Nmo+UuNXITB1ZhLSo+8sPPmZp+CKOzIyI+8zYtnjHxAsTX/vy4oZGRPMc00HvIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965155; c=relaxed/simple;
	bh=87rhYXHDtQiCMzx57VS1w3vd9t5iVIWXWbpAfZ5d7+Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZG0Z0ZHeMgUN+lIQ8w0hCndBYG3x4B93E03uLXBPg6po71W0Yx41oQ0SVaBJ3h0H6+yfekhaRgaKug3kVbrm+/vUdVFTHtqhu/EzBwFZKTMcSQU/+fICpfniFPbVhZ4cDjy8hqM3BoY83vyJ/v8RVogTIhc2ClE2LCB+3mTlhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9P1LQHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757965152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7HkFYGg6A427CkTE8Uu+596fVOO9ot2LNl0j4v3H3A=;
	b=g9P1LQHniy2w4LSIq1eGA+0bX7y7vlO24tN7P8L0qx2ZWOkcB/wRwqol4uS1E0dLsSpaI5
	P1GSKdPxOuGc36Xq5gkqVfxzcIDwNGhkhunx8F8NMRQfDVWqeM8C/hbya9MSnNwKE3fZTz
	jiAX645t6gzRIiAvsjlKfkQhyNeb+K0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-PS0s5_CTPQGZdvGd3hXf0g-1; Mon, 15 Sep 2025 15:39:11 -0400
X-MC-Unique: PS0s5_CTPQGZdvGd3hXf0g-1
X-Mimecast-MFC-AGG-ID: PS0s5_CTPQGZdvGd3hXf0g_1757965151
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b633847b94so117160351cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965151; x=1758569951;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7HkFYGg6A427CkTE8Uu+596fVOO9ot2LNl0j4v3H3A=;
        b=XEdoKETHwfA+RUowbNRltajutbF5erHxNlCTVT/Rt7t+ofVznCjGcJr12b+2AqZNYm
         3/dPGSKJvg8+lmBkEXrgqrjtzPsXVT+yION4UK9pOVrU0kOeKFMDLT1Ltu6PTpbsC1/b
         p7FAbLyOrx9xuBLMr0I+DObVkN0WM9o8ajj11DMvOUX65BqFzB+K2AKSJpuMscpj8UEb
         ZT88RnbsVa4JoBws/JJYPwD23bbgHlwRRcOTW6rHiQjJMXytRBJQsg1/S2YR8ywFpogU
         QmKpNdvqCpz/HDv3LY1oahn7FEZ+Jd1a+smfdtTls3daTkLw7xNhY6AFGonDS0gRLxwV
         Drhg==
X-Forwarded-Encrypted: i=1; AJvYcCVCu8gqjqVJwn6kFOs/sJ8e+GbvmIW6E3sxl5ohnDjIk077fYW9oKvxZyjWeGrd6Y464EAgg7XofGNBruc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfMJpj4mw20wyXpvyvIHYxp03x5Eby14L1sdmlzPt51z1gNLz
	ddiTyGRLs4eLSwKjHQHisetljZzEOSkCn4YDkGFAoMaa7qIBFI9RxX0D1XGE+s00F/dnlftmIPD
	NDsE6od4SP4q/X6yQu130M2c8+gtRP3eEyJxo6NzGATmZnFvEE9FfJG+Hch14MT4Z7Q==
X-Gm-Gg: ASbGncvJmMpjb2PDywBHXHb5AXfSa6wHUrtKuj6ENCAPt1Q2A00MKICS7NhMGnssmEb
	zpsDpwcKQHqxfGyu+Q2EyVBFPz08I+VvLtFvleqAQg5RFqlfuhmurXUjIplD0DxGvAlNf5ooHGi
	BGYB5I1pPFU8W3GcqLTJeByBReCjMEH5ZW/2GHGvPhMLaoSpEdBztj1paMH0OFtr1+KEJxgupWI
	lDxQRtkNW57TGb1QGGtN/lwz96hpHLlsbJd8tTtR/Q0li62j72J0iD7Lz+t+sG2GTIZLcECEQxV
	Szg7OIAtZyjs1qV7XnI/AJXgWnfdD1sKBsnHtHnmFx6b2t5zUDEjZeDHxbG76KvLst80P/TWu/n
	ybMgxmRKN9A==
X-Received: by 2002:a05:622a:4e9a:b0:4b7:9972:1d8c with SMTP id d75a77b69052e-4b799dd639amr103831551cf.54.1757965150563;
        Mon, 15 Sep 2025 12:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7pID2mDTqz46UkO3VdcT/XS3fmKdEaUkct2TWo3/kc/qTZwcCyfeBGxHuQNXAXCw+g5ytnQ==
X-Received: by 2002:a05:622a:4e9a:b0:4b7:9972:1d8c with SMTP id d75a77b69052e-4b799dd639amr103831151cf.54.1757965149996;
        Mon, 15 Sep 2025 12:39:09 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dd12bbsm73788181cf.43.2025.09.15.12.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:39:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cb1e7156-8043-452e-bdd3-076f72c51bee@redhat.com>
Date: Mon, 15 Sep 2025 15:39:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 10/11] cpuset: use parse_cpulist for setting
 cpus.exclusive
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-11-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-11-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Previous patches made parse_cpulist handle empty cpu mask input.
> Now use this helper for exclusive cpus setting. Also, compute_trialcs_xcpus
> can be called with empty cpus and handles it correctly.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index de61520f1e44..785a2740b0ea 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2567,27 +2567,20 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	if (!*buf) {
> -		cpumask_clear(trialcs->exclusive_cpus);
> -		cpumask_clear(trialcs->effective_xcpus);
> -	} else {
> -		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
> -		if (retval < 0)
> -			return retval;
> -	}
> +	retval = parse_cpuset_cpulist(buf, trialcs->exclusive_cpus);
> +	if (retval < 0)
> +		return retval;
>   
>   	/* Nothing to do if the CPUs didn't change */
>   	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
>   		return 0;
>   
> -	if (*buf) {
> -		/*
> -		 * Reject the change if there is exclusive CPUs conflict with
> -		 * the siblings.
> -		 */
> -		if (compute_trialcs_excpus(trialcs, cs))
> -			return -EINVAL;
> -	}
> +	/*
> +	 * Reject the change if there is exclusive CPUs conflict with
> +	 * the siblings.
> +	 */
> +	if (compute_trialcs_excpus(trialcs, cs))
> +		return -EINVAL;
>   
>   	/*
>   	 * Check all the descendants in update_cpumasks_hier() if
Reviewed-by: Waiman Long <longman@redhat.com>


