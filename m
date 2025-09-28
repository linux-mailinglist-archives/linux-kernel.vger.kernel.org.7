Return-Path: <linux-kernel+bounces-835489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D4BA7474
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19C4179FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09387221F03;
	Sun, 28 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3RJtMz4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D1FC1D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075245; cv=none; b=s8cC+QuNaLNY+iIa1RElRldj5WhFST/IYAvymHK03GAI85GnKyECSIhsV15uav3hEACV1pPydyadW/8N5eb0IsGhMSeijvf45zB1rDV9duYoBk/tyTy+cCZndBlWElPNhtbxnDiAmcfdPxu95iNKWwc61/RPJNuEMeh0EfaxWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075245; c=relaxed/simple;
	bh=9LrQVIBHMJJ9SOBDZ8aAkPl2odbwkgagrOP9lMew+n8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CRE+b5DV52ObR6+Je+Czbxf/NXryj2JJbWuITNQdwikoWaUYq0Efxj5oOvWQ4uxrdXEJxeICDeGv4QNLp0GeDkDA7apYpwdgh7SCJyoqk2S1bHq/SLa7SZ7KyKill0ry82nKYbht/H2bAg/YurxeFe5fmhNur5Wx6HnDJOa+F1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3RJtMz4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759075242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRFlrSNo+OKIG+sGNz6RYa1m/9yNjqMbQ2/tMAQzkUc=;
	b=d3RJtMz4CnTOL1dhCuAJJLjJPgjJSTic5MO2bDw5KZTqV4ES1Klz7Y3umxNLO1cBJ2m9wd
	etxpPtK8RdXE4JtI74g8Uvz0oORjH6D2LgwijfmA0gQvQaRjNz7t4u3qqYGez3tkhvdMpc
	fynF9F1naEw6N0/W1sWOM52UCPq5bro=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-B5cm_2nlNlOOoiAbNrbD4A-1; Sun, 28 Sep 2025 12:00:40 -0400
X-MC-Unique: B5cm_2nlNlOOoiAbNrbD4A-1
X-Mimecast-MFC-AGG-ID: B5cm_2nlNlOOoiAbNrbD4A_1759075240
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b302991816so75250081cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759075240; x=1759680040;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRFlrSNo+OKIG+sGNz6RYa1m/9yNjqMbQ2/tMAQzkUc=;
        b=UxJdYr/RW7FU1XTxPPHTRcuHwh54a6HItAXl+/A5R6H1r9STAs8RfE0XOlm2dn/LZQ
         /521xxSmVSYfFSEY5ttUhJyHpAax12BiwmNQzZAboooyupf4k4pi58TauQiU4yZd5+M6
         RakoKpkTThv6/AlK9L9ROm/uOoTKJdp0DyfoQgID/42quzopOs6arqWEMCBQTDaUuDMu
         DP8SsCmGfzWZDLh5tIdthEy6cx41VLg2Ok0nx5KZq24kVMrtt2/tu2b1jyJsLQi0atJh
         GEcdBraLmpr06g44MUGKAuwqeMEVwQJkfxmBfDA9MKy531bFjDnmAXi7fP7Ecw76YsQ4
         USPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfFF4HzrbFf95QiH9c20BNre1XoXfvEJat1dSA6ScsqvEhhA8rmgGcJhC8YUJDJb0OxJND+RC0BI4ONTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjtnnMi3zP2Fc5OGvbGy8Tp2TMnLS4EmgGtnAXbenOM+/3fWc
	+NJsNWpBpyJnceA3z55Dhi2JfeifyZcf6uKnHYEnO5qTnRs30DfjK0Q8LWkXODfZOczpIY62mSj
	gKTR64IepBi+a30Z2HnTp1fcYGa5JAKp2rrR98xMjFbSBLLzJpbm7t7/TwfgKqR8vig==
X-Gm-Gg: ASbGncs1gzhiQel88WSsAxl/o5vTXSPTm/+KQWJfP3FPLUl8f6DHo0sjXLiSmYOpPsj
	QiMFherCWPQ8b0E9Ih1k/UU6dkOjYGRbFmWrq4Qe5Dei8ZGpeXk9j83LjAthLKPDBhk3ye3XdKp
	lUjGq3tHZ0V1AuabOwa3+zhfX4IeIIMlzBOx2jV14zUsqVeosiFnq8K/PQNgcdaPK6cr5a6rdh0
	K759rhdoR0hlWUcJTo4mih6eBordSXUkRzxHmkeMF803w/lhTqKVfQs1mt44+tbZrcDgiRXTy5O
	cA6eIDO5XXdhKyDg0Xs9W+0Khiwo4pSgA/1g/zTLB87dcCXl/P+OP5KkNNOjYwsYxTqFkhzdzhZ
	IS5bDhnOqZks=
X-Received: by 2002:a05:622a:4a87:b0:4b2:d865:3e5b with SMTP id d75a77b69052e-4da4c9666cfmr178206621cf.68.1759075239746;
        Sun, 28 Sep 2025 09:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1hINZSe24nntpK+BqyGEpQ7rcyf8UCeVwRKAVOUGc5zCrNOVJqPmei1m/A3TJr+fANHcmSw==
X-Received: by 2002:a05:622a:4a87:b0:4b2:d865:3e5b with SMTP id d75a77b69052e-4da4c9666cfmr178206101cf.68.1759075239286;
        Sun, 28 Sep 2025 09:00:39 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c29ae247fsm603456685a.30.2025.09.28.09.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 09:00:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8a6a99e8-f171-4f1a-86db-21ecd3cd2287@redhat.com>
Date: Sun, 28 Sep 2025 12:00:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 00/16] cpuset: rework local partition logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The current local partition implementation consolidates all operations
> (enable, disable, invalidate, and update) within the large
> update_parent_effective_cpumask() function, which exceeds 300 lines.
> This monolithic approach has become increasingly difficult to understand
> and maintain. Additionally, partition-related fields are updated in
> multiple locations, leading to redundant code and potential corner case
> oversights.
>
> This patch series refactors the local partition logic by separating
> operations into dedicated functions: local_partition_enable(),
> local_partition_disable(), and local_partition_update(), creating
> symmetry with the existing remote partition infrastructure.
>
> The series is organized as follows:
>
> 1. Infrastructure Preparation (Patches 1-2):
>     - Code cleanup and preparation for the refactoring work
>
> 2. Core Partition Operations (Patches 3-5):
>     - Factor out partition_enable(), partition_disable(), and
>       partition_update() functions from remote partition operations
>
> 3. Local Partition Implementation (Patches 6-9):
>     - Separate update_parent_effective_cpumask() into dedicated functions:
>       * local_partition_enable()
>       * local_partition_disable()
>       * local_partition_invalidate()
>       * local_partition_update()
>
> 4. Optimization and Cleanup (Patches 10-16):
>     - Remove redundant partition-related operations
>     - Additional optimizations based on the new architecture
>
> Key improvements:
> - Centralized management of partition-related fields (partition_root_state,
>    prs_err, nr_subparts, remote_sibling, effective_xcpus) within the
>    partition_enable/disable/update functions
> - Consistent operation patterns for both local and remote partitions
>    with type-specific validation checks
> - Fixed bug where isolcpus remained in root partition after isolated
>    partition transitioned to root

You are really active in restructuring the cpuset code. However, the 
next merge window for v6.18 is going to open later today or tomorrow. I 
will start reviewing this patch series once the merge window closes 2 
weeks later.

Cheers,
Longman

> Chen Ridong (16):
>    cpuset: use update_partition_sd_lb in update_cpumasks_hier
>    cpuset: generalize validate_partition() interface
>    cpuset: factor out partition_enable() function
>    cpuset: factor out partition_disable() function
>    cpuset: factor out partition_update() function
>    cpuset: introduce local_partition_enable()
>    cpuset: introduce local_partition_disable()
>    cpuset: introduce local_partition_invalidate()
>    cpuset: introduce local_partition_update()
>    cpuset: remove redundant partition field updates
>    cpuset: simplify partition update logic for hotplug tasks
>    cpuset: unify local partition disable and invalidate
>    cpuset: use partition_disable for compute_partition_effective_cpumask
>    cpuset: fix isolcpus stay in root when isolated partition changes to
>      root
>    cpuset: use partition_disable for update_prstate
>    cpuset: remove prs_err clear when notify_partition_change
>
>   kernel/cgroup/cpuset.c | 907 ++++++++++++++++++-----------------------
>   1 file changed, 408 insertions(+), 499 deletions(-)
>


