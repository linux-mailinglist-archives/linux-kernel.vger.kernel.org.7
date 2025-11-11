Return-Path: <linux-kernel+bounces-894632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D742BC4B752
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68A344F138D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893983043C7;
	Tue, 11 Nov 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRmwdrC9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kReif2sW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEA28C00D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835192; cv=none; b=FYo5YsFmqwuxrVp5m5TcdyS/jQu4d18/r4CMQvo7q0NlzODGlUJKSKaJmUcOCKGz0cWgrPYMrVsTGsl0PU86OkyfK6J311HD20xFJBeRMhaWnhnuhK2Nmlkvz3HYcijvn9oME9nha5s3JG9todY9CkyyWU+NZmtGvRzVivkOR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835192; c=relaxed/simple;
	bh=8RMdtaBeUgxOa66xEv3AWKaQqgqZOKBlVnze2K1GYgE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TkXYLfngvcfYTPOOLL7lJdJLfuB1I68Sv/P+SS6oYPsbLWOTXiw/c982rLB9wfr9dbZ18NvWzwnwQI79sO8NA9zKjXLT4YJ+JOQe6ZeFE9B5G6b0+WwilZijeVzi+JQt+u7JsPYgc8JUdKGe1+FAqRrKyIdwj4zf1wc83ObVMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRmwdrC9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kReif2sW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762835189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPEh5FOm5ROsAwzfPYlmN0EmwzoMy2vKzelCep4kRwQ=;
	b=YRmwdrC91Msb4t26CFiBl1GDCpeDnMEa6LLe7Gi7HZ3mOyoyRgSP92mHaOy7ZoCutvIOPB
	4ti9UnceI4Q+4cvXxcZbllFOqTllstlcSM66VJv5bAj11jI73T+sPh2IebOUCdnrOQIxRO
	tpcxJ1YH/Vw2Pob36paDZ174p+2/XCI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-z645FVe4PKuzPZcZdzIQHQ-1; Mon, 10 Nov 2025 23:26:28 -0500
X-MC-Unique: z645FVe4PKuzPZcZdzIQHQ-1
X-Mimecast-MFC-AGG-ID: z645FVe4PKuzPZcZdzIQHQ_1762835188
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88236bcdfc4so82820016d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762835188; x=1763439988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kPEh5FOm5ROsAwzfPYlmN0EmwzoMy2vKzelCep4kRwQ=;
        b=kReif2sWfnwQhdfgxGalSgRyAw+PKYL+qehJflK0HIsUiqMAitmWZAj1Qo5iZHGHE8
         WolLRiMrNmWNj+gbYsBItWSFWIO1PzXHtvSfBfFyHbWWqTbTZ8k1hujWlR214X4MNW3+
         x/B5dXmkzx90f6bZp187bcidPOpA81r6wL1mb/HaJKvE8526IE5wIHCFK2k8XHBhAxNz
         R8B0DuJPjc7/yCPDoguMBIa2OPFAfwKx094x/Rt7E1QZICqXA41liU3JwwRdzUfF+goB
         FEXwJunEI4hTnuzPQItebD4qaTvVbtbxaCBLcjHuzCV8F1+VExaiglJWCagR5KPslL39
         sCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762835188; x=1763439988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPEh5FOm5ROsAwzfPYlmN0EmwzoMy2vKzelCep4kRwQ=;
        b=rbcH6ZM7mOaPfpgHgFOOB3NBevUFl39ABnh/qJcCUZIN4NvT+6wTaFD/1wb8XwAJbJ
         sPpIPxxJOj+yxNEtBZpsJHDXh1DQolThqCvsLYwxxH2tnW3G7Y3whFZ+rvxtSGkH/S2l
         BZiT/4JjlUaiQvZQiFZOuT3b1Tg3IEjRRSKfmJCkdVA/rSXy8ug7+9vHYES56ZwVf1f0
         Bit1XSMiZKciss2jf++3g8jhmpTWtd5TFQYth21v7vUetQEQYuB+BEauBf3Uq6mln3ii
         zzft0j6Tu6SZFUco2NiepHzhpEl+dbq/BrSdlOSfr/wDB53lZT/iB/+gD1BpvHsv7s28
         GKNw==
X-Forwarded-Encrypted: i=1; AJvYcCXEKjdNkzyy25CdlSmm9+wz6NLFGbOVWu2lIHZhgzGvSLmjNfsL2iUed7hHP0xsrOAClHQkX1zSQU/PtTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVXKW1913VhE73PfjnG0/X4vXjVcdTKS8MDbE0Fz1Fe04OLqc
	rqgHJ9VfFEWF0vyuM18Wk6JO5PvLEEuOtmFqHh50zLpTuhnYZ/XO+T2FTu6AtB2SDCqk2I8knDb
	locbyIzZHABiCHicn98rTLjJx00i49I8gQmbyVthzCvOR+sqLxc7FfuSku7Q9Rkuxag==
X-Gm-Gg: ASbGncs8dv0sBBzDPXkBfpoOiXE4Nz7PztUcLxQAmfZ+kc1zOzrHpRlv8FRyh7HsDMv
	XBk0Ez8uaXWlegQ/TnhhYsaH4YREZQ7KcKIj95OjUE07OWgfW/p0VeNSLYq5azvxtwpF+VFNLkW
	icZJAt7jUKt/EQ+q7OKEMC64S3F1s8Fe6Ltt96X8o0cBQsRoyTymVGzTg4xejAz+MIOe34SIQwe
	PXEwplu6HMCBo9mimqlgTfefOz1wPo3rLt4jDaFK4bbQEzxpPsObjxtkbobO55R8vW71yygpK7a
	46VSHA/zgBCozh8TgueN9B/z2jwt4Gtsp5sXqrPj7yiDpKtRjiMgjD9wfCZmaZpGAetX6GUa9Zx
	WuLKFOrcBvYY/7MnIo0wXE4CUz1h3CR8pDd9mqPHsjIOcLA==
X-Received: by 2002:ad4:5deb:0:b0:880:6647:1031 with SMTP id 6a1803df08f44-882385bf25amr151425156d6.1.1762835187811;
        Mon, 10 Nov 2025 20:26:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE827JjhCjMCbcengTfa5HNZ5i9tHdgANx+cncvp5Ytw3zHicS5X1S/lVww1a27gfgSadaHRQ==
X-Received: by 2002:ad4:5deb:0:b0:880:6647:1031 with SMTP id 6a1803df08f44-882385bf25amr151424996d6.1.1762835187427;
        Mon, 10 Nov 2025 20:26:27 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882389939eesm64874876d6.23.2025.11.10.20.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 20:26:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cd1fbcd1-37e6-4aa8-8654-3305cbe085c3@redhat.com>
Date: Mon, 10 Nov 2025 23:26:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251110015228.897736-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 8:52 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> There is no need to jump to the 'done' label upon failure, as no cleanup
> is required. Return the error code directly instead.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 8238fd8c0c29..c90476d52f09 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2897,21 +2897,19 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   	 */
>   	retval = nodelist_parse(buf, trialcs->mems_allowed);
>   	if (retval < 0)
> -		goto done;
> +		return retval;
>   
>   	if (!nodes_subset(trialcs->mems_allowed,
> -			  top_cpuset.mems_allowed)) {
> -		retval = -EINVAL;
> -		goto done;
> -	}
> +			  top_cpuset.mems_allowed))
> +		return -EINVAL;
> +
> +	/* No change? nothing to do */
> +	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed))
> +		return 0;
>   
> -	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed)) {
> -		retval = 0;		/* Too easy - nothing to do */
> -		goto done;
> -	}
>   	retval = validate_change(cs, trialcs);
>   	if (retval < 0)
> -		goto done;
> +		return retval;
>   
>   	check_insane_mems_config(&trialcs->mems_allowed);
>   
> @@ -2921,8 +2919,7 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   
>   	/* use trialcs->mems_allowed as a temp variable */
>   	update_nodemasks_hier(cs, &trialcs->mems_allowed);
> -done:
> -	return retval;
> +	return 0;
>   }
>   
>   bool current_cpuset_is_being_rebound(void)
Reviewed-by: Waiman Long <longman@redhat.com>


