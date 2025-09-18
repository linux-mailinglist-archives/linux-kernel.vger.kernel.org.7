Return-Path: <linux-kernel+bounces-823424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A5B86637
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74CC547647
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D112D2395;
	Thu, 18 Sep 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqwk0vNX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C37288500
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219042; cv=none; b=EkjryP2BarOMk2LVBScJfqgCfpx0caLehETgsN0KbWKlpg4/2f6hgv5iJ+q30gNo+3SSFOHwaS31BkCiu1LY2lxJ0sSfOr8SfTLkDtjKM3FiPe81CForzA9um1Ywv9lhb7wpl3X2R/q/MRh6ky3kmH8cJIUvgpMfxalb69S818Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219042; c=relaxed/simple;
	bh=G11DW+dxDZsRwBrASQuWanHM5C6C3pq8YdaEHXpqd2k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IbjNIzUVW9JVATAjljVye2803Rcp2LJrWvZ1rN2JEq7iWeCjppV9w7J/ijeJKhlIBFrIDAjZ/ZT0inKtBEwCS1I1E9EBhza+cMo4A3MtMhNgXKGabslyk4KjUnpw5g0TgZq/2tXCLnO3fHVpblefM5jWW1c4E7qey3jEJfXftcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uqwk0vNX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758219040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vr089DtKU6BHFhoOnacLG5H/uMQfTGq5wqyv/jSw24M=;
	b=Uqwk0vNXhn3qY6e9biV3s+bI26XaP0G8/PnrLIAGVOSL0/iRl8Poi4m59k3IUdibjHPGMN
	Uq5D5JheRyyYukcEM/ebqXgu9Y4/VDSetz+rsonrSsqqsj9jIuHkk7/Z54EHzJt7it4T6W
	018RpnxmelZYT/DMsZp097WjdU6a9qA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-djXjXoCUM8u3QnnEckJt5g-1; Thu, 18 Sep 2025 14:10:38 -0400
X-MC-Unique: djXjXoCUM8u3QnnEckJt5g-1
X-Mimecast-MFC-AGG-ID: djXjXoCUM8u3QnnEckJt5g_1758219038
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-770c2440225so28598616d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219038; x=1758823838;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr089DtKU6BHFhoOnacLG5H/uMQfTGq5wqyv/jSw24M=;
        b=cn0K+ndzgaLKHa3XkZDuqcJBzor11Pyw1x5cU/mSLdJDDY4gR5FlimIEmV68XRKaLn
         r8wvYeLFnDlTXj3ueBi8P2BDoD91ihaM+TFkUBG2K6aQCatYO9JlZEsIsr8w4fVDfu6A
         NkAWHf5UWFd3LSAV2l//vWftiSeAZFo2kKrqU2mmt5Zoxee01IYZr+zoO8p7DXzDZMdw
         en6IHee9vE/7djvpBc5eZKqSQeTFCam+/f4IViYX+J+7oKJw2MqJLPkTJWzJqmOhZTiC
         4qHlY1L7yFvAICdc4z0QYkMAqx8J3iFAILB87ogo+1jyufIIQl5P8krOrKfBRL+x50MV
         /NVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpDlXM0byOObmptjjawgxgDxwphWoc9PMAc0mWcxl8gbc2ZE3evGRjmhcv86nNM2aaGV6+mce410czmcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRHiqyL4Xp3yTIhTFEJb5B8RiUc7TVC1JYFwmymN7dX3QTLyW
	y/1NuYM8qtQ8ZtqKNwwUgyl1g8KP03hsiz+tuml29/0so7kNDJNBqiobQoZXyej5Whkxi6WW0kX
	WmQrGWSKsmSNprVYg24fNNV7+1EC4vN8z+8fQnctrXzs1NJl8V+1tIYL523MEEszARQ==
X-Gm-Gg: ASbGncsXw0ddRPRg7wPKRdWLD361o0RAoUyKUaSXnkwXLkjxvBcz0o9KTd0fXzdp5L8
	NdZTR/UzZfr2YPlNkEpH+cJE1HBn9kT6M6QowrrOlZBdnJy5R43VuziIpWZ9IUQ92SPdkoPXyIN
	pAHjm+/JN7jwKdRHZFz9jGrkSz8Wgf8TCXxHf5zTgAHDqDsgu9JfcPyxzNyeyj8gNg+JAaraGO5
	6XMoXLCG64hT2jQYqtZ4dc1HsG6f9Q1Fk87Oa1pqz7LYxGkW1le6xGIobVpjISnjBylEYeLeGyc
	3yOb5q6ovx16gsxN8T6ZJ1YE50fsPNYSBEaGHCbamFEeraKhMR9+CNHZhIdLenDfjS/RXPIRfDq
	FRxqYETkQQw==
X-Received: by 2002:a05:6214:1945:b0:77d:6920:f855 with SMTP id 6a1803df08f44-7991d54f01fmr3749946d6.57.1758219038098;
        Thu, 18 Sep 2025 11:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkKmLDocDew++syyxMKDilcYw/Xs5yWPD3DVBHZ2sTHpZvWqF9ALgzSZJhNk93MzijvYLAQ==
X-Received: by 2002:a05:6214:1945:b0:77d:6920:f855 with SMTP id 6a1803df08f44-7991d54f01fmr3749546d6.57.1758219037715;
        Thu, 18 Sep 2025 11:10:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79337bc5835sm17034806d6.0.2025.09.18.11.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:10:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ea6c57fa-4e44-45ad-9219-09bc60acea26@redhat.com>
Date: Thu, 18 Sep 2025 14:10:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 2/2] cpuset: Use new excpus for nocpu
 error check when enabling root partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250918122532.2981503-1-chenridong@huaweicloud.com>
 <20250918122532.2981503-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250918122532.2981503-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/18/25 8:25 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A previous patch fixed a bug where new_prs should be assigned before
> checking housekeeping conflicts. This patch addresses another potential
> issue: the nocpu error check currently uses the xcpus which is not updated.
> Although no issue has been observed so far, the check should be performed
> using the new effective exclusive cpus.
>
> The comment has been removed because the function returns an error if
> nocpu checking fails, which is unrelated to the parent.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 2b7e2f17577e..44d65890326a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1818,11 +1818,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		if (prstate_housekeeping_conflict(new_prs, xcpus))
>   			return PERR_HKEEPING;
>   
> -		/*
> -		 * A parent can be left with no CPU as long as there is no
> -		 * task directly associated with the parent partition.
> -		 */
> -		if (nocpu)
> +		if (tasks_nocpu_error(parent, cs, xcpus))
>   			return PERR_NOCPUS;
>   
>   		/*
Reviewed-by:  Waiman Long <longman@redhat.com>


