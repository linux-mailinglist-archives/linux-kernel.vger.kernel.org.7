Return-Path: <linux-kernel+bounces-827902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC7B9363A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983962E1A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E5313525;
	Mon, 22 Sep 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7Ig2ubZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CE23C516
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577025; cv=none; b=AWXiewfeTKnv6xxWCC5Cwce8aAtPnL00e59LcbDXVcOHm/5jsTZAviKSqP3e9pjLWaEmQQ3VagXiIC3kngnkgeflyWGkJS93L0FtG0MXH/4TuK4s/A6G4lg4YJPQjskyckkkWcLTyOdQ97toD6u3qZjWG/8K1KrZ3Dpt5VkPlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577025; c=relaxed/simple;
	bh=hSsaEQb4VAWVoscZOLW+eqrIRXRtuWgYlZ0Q2Mmdsjs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bYbkZHRv21IgjKxChSOhTPQ8qE/WZDDzvGC+uy2x/uTRdYWONZWK53W0xucdvsEGj/OedG79UqY54AV9AnRih9D8F/Q7yEvz+52qolHPhiNIgbu/IOf55yniGaGvu0buUIl3goMo8BWJ8kzK2ajXNreNYPTB+Asu3PKOziERHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7Ig2ubZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQg+VY8gn4Rmq+YGMtXx2+Qb8qCVcANWfi/lFd5PqbE=;
	b=d7Ig2ubZA+d1yMEeGsRBHN8NObQgQZkKK1lARuAmWB4Ur2eguop+M5uHmmka0anUdlIiLQ
	lidiwYo+mdWAKYXgoXLUMLdUoD3cUt4LUOWlQUJnERiIlXMRgDP/NNCpdJuN3kLNXXrK5s
	OkRE/B5OXkc/0KK9b61M5fhtJJcVGoo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Vt1Y_QsRNte6r-hf2cEThw-1; Mon, 22 Sep 2025 17:37:01 -0400
X-MC-Unique: Vt1Y_QsRNte6r-hf2cEThw-1
X-Mimecast-MFC-AGG-ID: Vt1Y_QsRNte6r-hf2cEThw_1758577020
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78eb8a9d229so80753296d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577020; x=1759181820;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQg+VY8gn4Rmq+YGMtXx2+Qb8qCVcANWfi/lFd5PqbE=;
        b=J00ZFzbqy6eqSYxym97TTm49JhwnAtjWpc36i0FNEs2KMETJ+muUgacCzA/+VQySWa
         VJOaU87beMLIztJCB5X4y5xbchMWPKRZKK3NsCunyXtJ+3riflA0xn0h6HwrI3lQoyJu
         x9FfO8ibzx7J/lLP3vYPzcytOtnGnrK+LQ8aLI0kS0P/dOPJv13sZ6/7sw1M4RVxSnhT
         AfJvaH7BO2vJVLM1hg+X6n8IGZ3mXR2PLL5jXFcH9JY0+0U72gmjOniD+y7dt4lazBw8
         +Bn/fgWBF49GCSS86t4RVK9rj2oFbNUUv2D5FuDrejzFAZAHxypZTOEhpWOWPmvMt74f
         +oEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZlbqevCNptrvfc+XIwle08bE04bH2DF7LDk/MMeQmqPaYFH1P4EGIwNeGS9PAwYvLoxONWBLACsaqxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshYaihPG7iyrnlZCmnh9pI06fHL1kQSX7MwtZEgjn8R3DvZun
	cy4tEbDTelC/rNacqcJwfcXpX3b9JDsOuqonHKkwAhKxtIIZiTOrzoR+eq2Y3LaJwKZ3D2Rydoc
	qFSKytxpUZv2dIzTO3bALJw9k+OyGDg+wLzutcIgQKIY4DKx5o4kORPA2eyip4WNHSg==
X-Gm-Gg: ASbGnctccZSMaH70zkMk2sONMxOP6A5c5c9dEjZg795aUpjAHuMLT1iBDPPXO3QQq8U
	V7W14wyfy2idAklpNdBNZnK9D3mTb6PdFcCEWPkP5hbB5TjazmioQ6k2KATcUVK1BRkNJo3rjvi
	NlcvA975kFi0cYfMLigIY/BZsHPjTHLS9xZS+SzvMmspljZZ5Y4gOdR2xjBGo/21WCvxyX85Mql
	ovSDAwaE9J8MXjpbngaDElo0CMkI9F/jbD3T4ekxDKCzwnFwLn7UtaUsgxC0Ap8iml2EgFl2e6e
	IkwijnWHGCxvwP3t+nZDpJCKtG2vwVKuNz/M4g+/sChNzZ4wiSucRxuNK3ynixO0I2RqALz4NJ8
	dPmgfhCS+GeE=
X-Received: by 2002:a05:6214:2241:b0:78f:2a6c:19 with SMTP id 6a1803df08f44-7e703820172mr5615096d6.23.1758577020303;
        Mon, 22 Sep 2025 14:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHomM5uVrLRgfcL17MuNwl5LJ5DpctEKMKOIq90FQWbjUTIIF5r0eVSR150tzN+X5Hj6GV5zA==
X-Received: by 2002:a05:6214:2241:b0:78f:2a6c:19 with SMTP id 6a1803df08f44-7e703820172mr5614106d6.23.1758577018792;
        Mon, 22 Sep 2025 14:36:58 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793474ac8dasm78515486d6.30.2025.09.22.14.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:36:58 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3108a41d-24b2-4a0d-bc71-3e62ff97054b@redhat.com>
Date: Mon, 22 Sep 2025 17:36:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cpuset: remove redundant special case for null
 input in node mask update
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
 <20250922130233.3237521-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250922130233.3237521-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 9:02 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The nodelist_parse function already handles empty nodemask input
> appropriately, making it unnecessary to handle this case separately
> during the node mask update process.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 535174ed7126..20dface3c3e0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2847,22 +2847,16 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   
>   	/*
>   	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
> -	 * Since nodelist_parse() fails on an empty mask, we special case
> -	 * that parsing.  The validate_change() call ensures that cpusets
> -	 * with tasks have memory.
> +	 * The validate_change() call ensures that cpusets with tasks have memory.
>   	 */
> -	if (!*buf) {
> -		nodes_clear(trialcs->mems_allowed);
> -	} else {
> -		retval = nodelist_parse(buf, trialcs->mems_allowed);
> -		if (retval < 0)
> -			goto done;
> +	retval = nodelist_parse(buf, trialcs->mems_allowed);
> +	if (retval < 0)
> +		goto done;
>   
> -		if (!nodes_subset(trialcs->mems_allowed,
> -				  top_cpuset.mems_allowed)) {
> -			retval = -EINVAL;
> -			goto done;
> -		}
> +	if (!nodes_subset(trialcs->mems_allowed,
> +			  top_cpuset.mems_allowed)) {
> +		retval = -EINVAL;
> +		goto done;
>   	}
>   
>   	if (nodes_equal(cs->mems_allowed, trialcs->mems_allowed)) {

Right, the *buf check is no longer need with the current version fof 
nodelist_parse().

Reveiwed-by: Waiman Long <longman@redhat.com>


