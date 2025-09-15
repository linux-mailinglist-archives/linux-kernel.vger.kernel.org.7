Return-Path: <linux-kernel+bounces-817649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8CB584E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11BC7AFC10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497CB2BEFE8;
	Mon, 15 Sep 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOwkLNNb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC44283682
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961890; cv=none; b=j61asj299VaG+JFSpTxBbhXnipagFqr3LPStHQVaWHQSk3IyFF352Fw4ev1cH29FXLDidOTIh7pbuWxY80OzyCBYjj1G7/fGg8PeagKnMhnAyHRtDiEQyQV+hzjEcP1uZwLV2Sgpn/a/qaklsIlIqUBkRr+s3NOnW2OnyBHHr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961890; c=relaxed/simple;
	bh=siF+cUJ0MXDi9fG9kS1S5oPOWHY/N4+AU9C3uXhgSS8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L0vYaw6KsRx5KBeYUdIr2xatZuXOAw8yHM3p1MUNr6aYFtcDe9yGwB76pzHlh112xl/PfkAjmNO0+cY2VFpwXbLYomNMr1VNdbW4iOk+dFYh0sE3vvWNgmTEA2BVoi6U3YTWfmAwlZFKFEHMrgvxCU8br4GmBuajPwvXLweH/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOwkLNNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757961888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYas1KhB09Rxb7ocj6C9fOFj/tEHQDmFrrWYj7yINyE=;
	b=MOwkLNNbaJ2pKT1YzbMlKjIHdhbKRIwjAA2ZrD5XoA5JXHQu0zVPelHDRcJaZSGvn4hgGr
	NdS7l1SiRd4twXBxMdEG8ZFscTRXt5oaH0IFFUgvfZP6EREm4sFiV6UHvVLok5f2sKH+EQ
	gLChwEZ/XoQqIVs171efVR1XwG3I1Yg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-DKydg0h8Pl-JmCFErAw1Lw-1; Mon, 15 Sep 2025 14:44:46 -0400
X-MC-Unique: DKydg0h8Pl-JmCFErAw1Lw-1
X-Mimecast-MFC-AGG-ID: DKydg0h8Pl-JmCFErAw1Lw_1757961886
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-773e990bda0so50790916d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961886; x=1758566686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYas1KhB09Rxb7ocj6C9fOFj/tEHQDmFrrWYj7yINyE=;
        b=O1xq86ZkF3tsmwhl+Mf5qIFvRh8T/d4pvoaiQBgJnil2n0HSNlAXuCEX0LaE7EwK0r
         PZd+Ty9mX+vMp77zMt8xEjJpp4VsqxpR2iQE4rLard7erG94y6LPf1pBtX7XNbInwu/a
         Fh3l77PpHNyJfAmLxsCszhCFRFuhoreSJq8Hl8EUIeQRldZILMQCDZMfzJbGFa/wRAMs
         4HkIq0KZTRI23jsMVy7nltjE+G/+M9GZR0HyKqIpxuywhi3lVkT8M6iwUfI2IFRoN4/s
         rtlJsCnJO4nM9REToNnf+7BzqpOYQ+o6Z0JIuW7RJ1bjsxTYAOuR53gA65Vf0caGCR7L
         eqIg==
X-Forwarded-Encrypted: i=1; AJvYcCXX04tHu1a4T6Tu5+uD5K8pWFc3QLcP4fJNRsbmQ0qOxABTNrPoJfoYM76r2U1UfhSzFRXeOhuXjP1yPdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFObVxdQuBVnrQeIdYXQIptHDWuFoqVpUv8yATab+wKKeULiXY
	7P4t6pppJABzZgZx4mcvlkJ7ylKaK6IhH0I0zUOY18x4JL1lR1CzGm1+JkYs7hI66ZsY2e+O7qn
	Bd17jkUIgUEsxVY2OH0nFQt1EMWFQPikCZiFkWRgk+PlfaCtIJJ5dFc68Lly78hltjg==
X-Gm-Gg: ASbGncvOXvTH/tI3rcwPNOc87S/OMFe/XfB0qjZu8PnDXqjkMXB6qMG6GWX18sU3gp0
	6u99YBDyp+JDfeIXZfn8+ISOmLX7gSOFJM2AfJGa/NiRK/SMjjAlJrk8EiKlhHQno6nMzQCHEKd
	7Y1S39Y7Y8eA+FPmOdxxvC0NKxoRztUDGI5vPJMqs9A+ETLrlz+uudPuMgAqEpEVXJEf/+bn3aP
	8STZSI2FClOXKFbKabEVQJwIznmxU8xifiwoZ8eFPmWstxUDjEMBrKP4JzgQyTQXfaDptqQz52b
	2nnkZCKUwSxYGGk8+97nSsqNtggL71aaTOZ+3+e1JS/MMwqwGtmo1lFQAVlgLRJOCZ1fTcb8/Ep
	+8DumZFr7/g==
X-Received: by 2002:a05:6214:1d24:b0:766:3902:b9ca with SMTP id 6a1803df08f44-767bc5e5138mr192434146d6.25.1757961885853;
        Mon, 15 Sep 2025 11:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt6VhgCUr0JQtHHuL07FrOdDlBOUWjL2CkXjgKYoyEtglTMKJ54UdEUm2p0M7XKMORlJ6TXw==
X-Received: by 2002:a05:6214:1d24:b0:766:3902:b9ca with SMTP id 6a1803df08f44-767bc5e5138mr192433796d6.25.1757961885459;
        Mon, 15 Sep 2025 11:44:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-778d99113d1sm40448006d6.68.2025.09.15.11.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:44:44 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <94219ba5-d0f7-4c2c-8d82-daffb1d7d151@redhat.com>
Date: Mon, 15 Sep 2025 14:44:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 03/11] cpuset: change return type of
 is_partition_[in]valid to bool
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The functions is_partition_valid() and is_partition_invalid() logically
> return boolean values, but were previously declared with return type
> 'int'. This patch changes their return type to 'bool' to better reflect
> their semantic meaning and improve type safety.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d21c448a35e1..a31b05f58e0e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -159,12 +159,12 @@ void dec_dl_tasks_cs(struct task_struct *p)
>   	cs->nr_deadline_tasks--;
>   }
>   
> -static inline int is_partition_valid(const struct cpuset *cs)
> +static inline bool is_partition_valid(const struct cpuset *cs)
>   {
>   	return cs->partition_root_state > 0;
>   }
>   
> -static inline int is_partition_invalid(const struct cpuset *cs)
> +static inline bool is_partition_invalid(const struct cpuset *cs)
>   {
>   	return cs->partition_root_state < 0;
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


