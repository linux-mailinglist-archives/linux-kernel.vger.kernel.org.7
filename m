Return-Path: <linux-kernel+bounces-860014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2568BEF236
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AD01899D54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92E17A318;
	Mon, 20 Oct 2025 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDkJ2piH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB52110E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929224; cv=none; b=TpZH2srmFDrRgilbe/C6JpItDgwh6MgT5dOesrYM0dNWTogurqsQ93w/uZ2TeGSS8bSem9/XNdJqkoLI5p2wkwSzanXgb9sjGAz88XqmDVeEbYXfNfxQnIy8AHu1DF79SIMVz1NqsV7bcghGhQr8DsQgvMMRmB7SQgLBA0SgZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929224; c=relaxed/simple;
	bh=K/aA7P7dfeOY8yhg9izbYW2PD1+xi5gAIsV34LbxObw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kd5/m9AjY4leg1aZGHCP2Sqmp1invdiWWm9B/g82NWMaYBo79uefC7kCCL3P9CN1yGnbLwlEraZCSD2qJxLqLJfjF5ocrEl6UlG9cD7p/v29G3RhYvpf8oqRv3IDrnODl6tgJzPI/kW/3IgeNOQ6V4MZIbXutHMivqekXPczj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDkJ2piH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760929221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yULaBv7/tlcy18c6VGXiS1CDPHHODpwOo6cloD7fa7k=;
	b=RDkJ2piHaFK2BTC1fAItdvx/CySRGjLZmMJXGy0dYCVD60CmLyg5pwxZQs4jTUxVcHOuSY
	MnMTcPB2z2uPmk+ACfDFqCMB6ws7UdKeRKpxF63xc19h6NM7JcaE0WVi06jgyxZ8zVmI3m
	UnmaNyjz2lj30rTkMvWBki8woNpmgaw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-qNAfYIcaOamMOAlGqaeFIA-1; Sun, 19 Oct 2025 23:00:18 -0400
X-MC-Unique: qNAfYIcaOamMOAlGqaeFIA-1
X-Mimecast-MFC-AGG-ID: qNAfYIcaOamMOAlGqaeFIA_1760929218
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78efb3e2738so129885646d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929218; x=1761534018;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yULaBv7/tlcy18c6VGXiS1CDPHHODpwOo6cloD7fa7k=;
        b=B1XVoSeq2aZ9DywnA3119HzEbelQc3Ux1ucOdgQjxo4S5RrgJH60EP9awyJq4TEN8B
         dXW46OybsZm6DEpNxqBsjmQgR3gXuALk2LP33cLaJFfJTw3p4R50d/1gRb+Z5OcjKKgL
         2qPqD0OgiYfyaVhCRvyv/6mH/idoI0FXnQvgPqN6hFEDskFc9PlIP3iaMt8sbr+ZoG8L
         mrXVNHR+wnYdjdhulpoQge/5n5P027bD0dUORr9sxN1T1v+gArb97b0x5fVdlAb7S52e
         rb1HpnLURUxvQ2c5fWxLJ1ojdsic3NrnOfYhHFmhFi0Haf1jHJQWhYkIylkC/eO4y4Jz
         LWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR5bon9FdLpcRkZ/dZIXmaUJx5lJqKpHI8bBDSUfL4B3eL1cNj+1hZ59UTQWFdqm1lIDS2ldsg9JbaH2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKSAjnRRFbIY571AwZUS5CGxi/gkE9mtlrYF44uDKq3euzp3R
	MAptSWGxf5Vm/9Tfkte5bdlF+p1rNwYY7nOHRcHiRz/qjVS+qdZ2neRBy8dthAHOTQ0oLIB9A2k
	4hn7z3uxcniTN0QncdLpnNBkASoupIcjfLQ9/MdG5hCVs1uCnzyHlUoYuEHiaLFZzEA==
X-Gm-Gg: ASbGncu6adGsFlUO+tnx/1hTzUbN5lIOWSZMwBl43F1JkfcH3hmTcwTL7I5cgOQlhDn
	U14DwuMk09lGRvyS7JRU6OehkQOQomjkG0zns4Sc9c1FA17KjFzGmgS2UDrKdO5fzd39/M3PBv/
	4Ub0P6aZPvtkDgEQUnhuThjC2yxOknMKYsZ3y9A5Nj8kdFmHjtme1+GFuCuIrd4eWRmeACVwyhj
	K8nIZkiFdHxBrt6EuoS/oQNpcikbWRyXlUbuV6WXgSgX5AakbrxrB7ao08l3xm3+n7oiaZXjtog
	bFXvPWhCZR2ZLOTjvlJA1ld1c2GAk8TrpAixU2w+qgmOGiv0MZGMY/CV7QuAfKssMNcBQ8eO/k5
	szS0LjvuxMHvb1MULnHoyZh562lZ6qBgT/Mpboj2guQ6fAA==
X-Received: by 2002:a05:6214:4001:b0:87c:2548:bfbb with SMTP id 6a1803df08f44-87c2548c0b4mr139173426d6.16.1760929218010;
        Sun, 19 Oct 2025 20:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDuPuomvhT0pE5PoA9OiYcCwQdFSr4A+zo5QMLZ0jqJ2tpRQ+P7cXEe54AzppWjUy1WSHC9w==
X-Received: by 2002:a05:6214:4001:b0:87c:2548:bfbb with SMTP id 6a1803df08f44-87c2548c0b4mr139173146d6.16.1760929217605;
        Sun, 19 Oct 2025 20:00:17 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521bf8esm42503156d6.22.2025.10.19.20.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 20:00:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b436725e-215f-467f-9123-1853f65c3946@redhat.com>
Date: Sun, 19 Oct 2025 23:00:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 11/16] cpuset: simplify partition update logic
 for hotplug tasks
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-12-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-12-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/28/25 3:13 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Simplify the partition update logic in cpuset_hotplug_update_tasks() by
> calling the unified local_partition_update() interface.
>
> For local partitions, the previous patch introduced local_partition_update
> which handles both validation state transitions:
> - Invalidates local partitions that fail validation checks
> - Transitions invalid partitions to valid state when no errors are detected
>
> This eliminates the need for separate transition logic
> in cpuset_hotplug_update_tasks(), which can now simply call
> local_partition_update() to handle all local partition changes.
>
> This patch simplifies the logic by always proceeding to update_tasks for
> remote partitions, regardless of whether they were disabled or not. Since
> the original code didn't perform any meaningful operations for non-disabled
> remote partitions, this change should not affect functionality.
>
> The partition_cmd mechanism can now be safely removed as it is no longer

It is partition_cmd enum type.

> referenced by any code paths after the partition update logic
> simplification.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 67 ++++++++++++++++--------------------------
>   1 file changed, 26 insertions(+), 41 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 9e98df542715..a1896a199c8b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1211,17 +1211,6 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
>   	cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
>   }
>   
> -/*
> - * Commands for update_parent_effective_cpumask
> - */
> -enum partition_cmd {
> -	partcmd_enable,		/* Enable partition root	  */
> -	partcmd_enablei,	/* Enable isolated partition root */
> -	partcmd_disable,	/* Disable partition root	  */
> -	partcmd_update,		/* Update parent's effective_cpus */
> -	partcmd_invalidate,	/* Make partition invalid	  */
> -};
> -
>   static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>   				    struct tmpmasks *tmp);
>   
> @@ -2062,6 +2051,9 @@ static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
>   		update_partition_sd_lb(cs, old_prs);
>   		return part_error;
>   	}
> +	/* Nothing changes, return PERR_NONE */
> +	if (new_prs == old_prs && cpumask_equal(excpus, cs->effective_xcpus))
> +		return PERR_NONE;
I believe you already have this check added when you introduce 
__local_partition_update() in patch 9. It is a duplicate.

Cheers,
Longman


