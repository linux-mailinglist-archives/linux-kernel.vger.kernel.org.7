Return-Path: <linux-kernel+bounces-797084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E3B40B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D611B27D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEEB341667;
	Tue,  2 Sep 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7emYfrv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C592BE048
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832773; cv=none; b=QkeIVch4eUkMMYepIxg5p+t0idW4Taa6yjTnSlqM4tqhTciFKffKymISuynOk4RHgiscwl9CnQF2DZ344pVoJ7H4sV0n1N6ns38ECNvxnHoEgSCwEZ1d2audYchENBQi8jRtxKttyFY7rhM206gronYKg5MpYsdCRDzS/OeBDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832773; c=relaxed/simple;
	bh=wlZH8lhbscxC9THCQ4kinck0ZuzPLO1Tm5yhuN/XkRU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KOKelNGM7bcqFLwt5PoQ0jpejLqrCyWwHabTDlmtZRpi3LdvlxReLIuXeL6rBu3ZasKl/UZUcOsV4dEo1m48JtGNSwQ965MfDruU5wWQvMrox3TulSx0AiJ2Tqc/cxr8uXydbvjG9kpCag0lEYG/jMPwGTXSBj8drhF6op8xgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7emYfrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756832769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHu4aCUA0D1nulKzC9Dqv0LHGBHTxw2XXtYWx9Xi0Pk=;
	b=Y7emYfrvd+Z6Ak1ZzcZkvEJ+PFt2WOB8/5zTkOPfMBod7v3Kzpfj97pc+ywcabJrGnaY8Z
	LgiMHY/Mh9fuXk9/VTMmoI2O9UBPwvMIYshHlgncNpHHGVhtQ6eezDd+46oamt2uNmcwJ2
	UGTdbGEONOW1TOvlx1Ztk6QELmA3gwY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-78spwFpBP0-b15tTHTiScw-1; Tue, 02 Sep 2025 13:06:07 -0400
X-MC-Unique: 78spwFpBP0-b15tTHTiScw-1
X-Mimecast-MFC-AGG-ID: 78spwFpBP0-b15tTHTiScw_1756832767
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70deaa19e05so144468156d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832767; x=1757437567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHu4aCUA0D1nulKzC9Dqv0LHGBHTxw2XXtYWx9Xi0Pk=;
        b=GYJSxXj9oUtbVHxfk1S31roPKHNHnHOkv6Tt/saePfeStZkeeQJQimTJKPfbfOyO/N
         n++x7hCgd+xLurbpCqS1xfPX5oZ0s2ZPH/KPpA/MQtIkUOjugw5AhEbIUqG8ynA0zvZ4
         yqPPgXLVWthok9cwQ85TZzhsqsVgMtZrz+DAcmMFbU/vrBACLcSbEgKJLCwDl+ZSS9n3
         QIJLYGBv/awjLdpkAvxTHTUakPTvzHPmmWsmlN0jeeoJe/KRlq5BiMmOJ9/Zyj0rcBMD
         0cJyy0ioCO78fYG458HTqiO5B/gH84yUrZQ4IuKctZ6yptHdoKONN6IPwafS0dVJRWgZ
         B2sg==
X-Forwarded-Encrypted: i=1; AJvYcCXSLXx5NtNKNMR1eWm6uLV7G8nkerYnhUWuZMW3Y8bU5ap/GqhMRkYevNTVVytwntCu4DCrs37VL3uoJD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkLkTY9BLTYfIfmnE2B16fnJgH63SXSQ2zvhHzBHU3GhNQ86c
	uozxTGqJWi8V6O1zt/mTHMTu0YAPM3HQ+dA11HECKvmeBhWPzsvk0i+YFe3FktG+0A8N2yjzJM2
	hGcP+GWqe9kAkrlQG4DqVBDQd0RUvVQHY+FykYnIyQ6zVPH0WE0tGcPXZnonaxNhBsA==
X-Gm-Gg: ASbGncu8fGop7OADqiJs2PWnlz431USSNuRkqSNZ0DmfQySEJy54gJysEbtc77vhYVq
	mV0P6t9Snb8L69lXGN3cEIp1TLWa4UXSbhI46zQtS2KECbUWH3snY8VFXpAyOa9x0rPH8pel29Y
	/vuDWOgGUMvLMpbQLjmRX0pH6WRMIshgFJTvZ6wKGIKZCj3a0B481grIQMibbDShxLMli+JHRIx
	dzjj41PsLD1JGF4p8u5TXqPvgXid8+Dj5A7awBv+Vb5LC3H/Tkb/FSisSw9wCHHoDLoKEltqvoq
	26gI9w2pIK4f8+OmsJ4VfeKNM+ZyL4uHXe25MmlvkEPtEHz7sQI4IExYXyw3+jSoVJO+YLN6sNj
	exzvxRDKCEw==
X-Received: by 2002:a05:6214:21e8:b0:722:2301:324 with SMTP id 6a1803df08f44-722230112a1mr12129316d6.23.1756832766928;
        Tue, 02 Sep 2025 10:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pydDCKXIedyuxkEgwpPTsJFeOHTh1mDJMxMHZOWHQTWsHU1k0rC0R+/XBlYtwjeZ8QWeuw==
X-Received: by 2002:a05:6214:21e8:b0:722:2301:324 with SMTP id 6a1803df08f44-722230112a1mr12128756d6.23.1756832766297;
        Tue, 02 Sep 2025 10:06:06 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de30sm15073986d6.7.2025.09.02.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:06:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ef0e91b7-be44-4d5d-a556-240709c80fcb@redhat.com>
Date: Tue, 2 Sep 2025 13:06:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
> In cpuset hotplug handling, temporary cpumasks are allocated only when
> running under cgroup v2. The current code unconditionally frees these
> masks, which can lead to a crash on cgroup v1 case.
>
> Free the temporary cpumasks only when they were actually allocated.
>
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_tmpmasks(ptmp);
> +	if (on_dfl && ptmp)
> +		free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)

The patch that introduces the bug is actually commit 5806b3d05165 
("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
removes the NULL check. The on_dfl check is not necessary and I would 
suggest adding the NULL check in free_tmpmasks().

Cheers,
Longman



