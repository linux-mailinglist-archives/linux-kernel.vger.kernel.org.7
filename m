Return-Path: <linux-kernel+bounces-797098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17620B40BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A79F7AA93F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC253431F8;
	Tue,  2 Sep 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOMDWc+H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185F33EB01
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833280; cv=none; b=lLWQXYmnssly8n06J6MHxM4lIpqGAVFqGRqjnzTE5v4//epMzaJhv5CZGUduDh0kjTBZDp8b3/44o4kiPTg3wYBxyvfAxUvo39KfTL6pQT+bltg14fY5yaOwIOxk1cj71ZOQgHc86ZBH0U+Rhy08HTHAGBDiLQOXLDB9e1cijAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833280; c=relaxed/simple;
	bh=KP+TLtwyL8ipGtoqM7ghjMPqXCRkOL7mmitCpt9EMnE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tgIx4ldkQWJRB+mUPsjAyOgleyS92Sk1vO2q+NYr6jck9W7U+u0ZHtzMQHbGMKqNA2UAYT8HT4DcQK6Cw4Q+y2g/j7xVPWRodGkpVx/RVqQUFRf/SVq8b6K6HFNv8oKHf4KisxCGzPzH0q24DHg0UP4G6PFbVgdO83/xrAnT/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOMDWc+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756833276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJTbTLLAJp5d1X+RLfkvvY6hV6oBzi1je5oF3smiZug=;
	b=dOMDWc+H9lwRpfUWjXKW4Ny9lFd1W2cdnMwTcebuiO/n/cm48AXmD69nJxIRtab/qxFkM/
	VQK2WRUz26ELXliS7g6LyOqCVbpREmDEOyFzrIqogIuPd++xsqYym/zOUQgREi+xUfAo2o
	vgSAB6LY99QgHTp0l0S3ST2yDHOX6Gk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-tCjAhT8lOwqvF6zE2D6scw-1; Tue, 02 Sep 2025 13:14:35 -0400
X-MC-Unique: tCjAhT8lOwqvF6zE2D6scw-1
X-Mimecast-MFC-AGG-ID: tCjAhT8lOwqvF6zE2D6scw_1756833274
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b30cb3c705so36448171cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833274; x=1757438074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJTbTLLAJp5d1X+RLfkvvY6hV6oBzi1je5oF3smiZug=;
        b=L+WfABuouP3V8mSwQGzY+Ii+6X4+kbszUDBXDUeX3nnkSvHzzNLuSiFSbgxx2Q7+d2
         lVWLpVXc+FWUqIOjpiOgcdp3MSLpgHdaQkPXUSjdsIelK0I8PQB7Gey9RW2KnFyNTF2n
         yMYdYXE0BHoTvBUcZYxN+gLM+HVFgugqkeK9vW0AhcpbtgxG3q5yVdYpcvAdIxR9ZNFq
         ngjNyk0Y8OWNRs7IRz+wMSi83pZoDSZMP8+Ipsunw3SK0/rwTYzhM8C+ialJvbiyVVjW
         427RaWmzGqKVs+sBqUGfclifMZJqG8P3NKeckUP4PFJrgMoZgd81ddReWiu1HnJOWkvC
         GN7g==
X-Forwarded-Encrypted: i=1; AJvYcCWfOJiQxNIQB+ziZOOXpvYD5ybkuCqE7slUFkzJ9nhmmG6Ih0R4443HRHCOrGrmJ79brRHA1Kw01wRzFNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13baj6ss0ujNQfdoPTgbGZ9MhS6jSor6SqR4ShQAcCUjKnsAw
	/ZjUXvXu93pCNzov0TMjPOzrWFhn5RdCwEwEiOqDyCZtc162lyo2SV+DC/UOmtIJQqnpUjwPLtw
	CBR5YzPJkMMR54f+Vq5NjPyLgHoctch98PGCFWO1KcrgP+ohMNg8c/9MiABq+6ggqyx3mTwYthg
	==
X-Gm-Gg: ASbGncv2ozHBPxZmpcoDYa69Jd1Jp/3hjV4DvmuRA5iw/rBWyRZMiJQBg6dw8GUCUa4
	UGngROmba/ikNu/bXVdrv82nVwAy7LbVlqgqkkUgUQtuYAucPtBph5MdqNK6QFr/0xdVZBJigm1
	y7eBavw+VAJQJRxhJuB9NwqY8tdq9cnQ9IvACJXS1JUHegKbJhDij1/zvT7mr/dO8DUMmGSw+0X
	lPyvme/5CqePpSCzLxoV5TrTN1Em/Cb3pf4OcZ/UvRWiYUJ7lCHCoRgS2Z/Fwcw3wWtzKx+2Vqp
	Z6hzHaoD06ophfloupXczp5wHeFJ9aCqlpP1/el8TiBHNxfJIPTPuibedx7Nc9HOchu6wE5eHUO
	X7gS7XV4beQ==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr30038441cf.81.1756833273761;
        Tue, 02 Sep 2025 10:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd9q75h/QyzT7q7qh5UVGeZkAkp/BGinsKuVNoDttOlVyk/VfACSIA8Q3J9whLbhq6hXufmg==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr30037991cf.81.1756833273364;
        Tue, 02 Sep 2025 10:14:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462ede0bsm15181361cf.36.2025.09.02.10.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:14:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Date: Tue, 2 Sep 2025 13:14:31 -0400
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


