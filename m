Return-Path: <linux-kernel+bounces-859999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26DBEF1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6158418964D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B529B233;
	Mon, 20 Oct 2025 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkeTO4tK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042E946A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928288; cv=none; b=tH/mCgQU+ubTy7CoHZxUALCu/RpUbyKUSL4lkA46UOGTpY1CKHqyMmUYXqIpIhFiIUrUqBZ9coCv1TRjxlQexylS3rTD+Y/I2dq8pXV48csgTrVrMDCWrU7aKTrZz8s55YyAYV5B5xdoMWXi+fDkowIJRoRMeGcjUmQoQQbNIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928288; c=relaxed/simple;
	bh=5bQKbY2DylLFEXOHKBtfcRedLyoCVXF6XoiqTmmPX0E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ATr2Mw4F8GheVzncKNUL2KSTK+ghLrTJTIy9ohUyYkoUJVSb7M3rAWWdrjBv1liWQVzyNkfLgSjlhTnOyW+SxcjbHdUf7Kld0yJW//QtWD7WG2E8Q/noL82hE25pJxVxDpPU+6ly5LJB0mF1uVyYscIh2lbixqYFokLSol2PP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkeTO4tK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760928285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKlkcVagNs0Ydw0UKqIhnLpn3p9SPMohEVtDmAXbYgE=;
	b=IkeTO4tKjRtiEdKwZ8DpYs/okPhxD6ADmCHRi0Xl18CrswtgzikCKn0NluVwRdNf53Z1mX
	f7wyNIlg6nhEi1BooQMRomKNFOGMrqWWh8pCEcPw2YTelLl7k86wAEihdPe0ur73LQOU6L
	CsgLsGo9t36rjrezwCOj92XARUmkdFo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-fNYsaYeHOKqY4XOc3Sxk1w-1; Sun, 19 Oct 2025 22:44:44 -0400
X-MC-Unique: fNYsaYeHOKqY4XOc3Sxk1w-1
X-Mimecast-MFC-AGG-ID: fNYsaYeHOKqY4XOc3Sxk1w_1760928284
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8906059f6b2so2412993985a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928284; x=1761533084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKlkcVagNs0Ydw0UKqIhnLpn3p9SPMohEVtDmAXbYgE=;
        b=YD9ngHLnJ9R+BjpUrXXQrSy7QoynUoYKAoVk0hDnlbYisRhL4PYAI5/01A6GLKTQPY
         hzLT3LvLPJrEL2Y1kvuP1VHzFfyWbxd8T8qaWwFoA64Udv7ifRw++3G5WalhCNtO5WDx
         U9OYkqfVKu7mgatBVnlhtE6WF705Q+DtKv860QYC1Q4awdBAX3bCs9IdvGpFeVxN+W8B
         8W9o8X9jHrNiknkNqU32FOmLEuTKRDZD5Mrdhpnv4FSa1gTEcOLkGSL6wjLWkcJGzpP0
         ncSttJlrD2LH8/I6pU0AbhGU7SVxZGDySOQrk7JNwR9ZhiZcZGKSk/E3huPiNIB30BxE
         7YuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+RWh25DTCjHnxkFzEdMGGFT9D2mVNrCugGLlN4aJo2OjyuDXSDnAA4WkrQ9yd7wP4x+lDioOVxph3CpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSYGCMYvHk1mfPNL3qjXwE56yY+ubRoynMe3ZvDn1T9eWw/VI
	G2Tfd/kJhR8Wq8NKlArVJU8vCd4mSKR5vRZrw7Zs/UrzNIfFS1mAVpKwosoctOcuWzdBitfbp6l
	8F+kNNPnTgt71HZLGR5FnlqbZAqLIZrIwpFUn92cfbWd8PzME0g7A/0sHmVCl6RJZlg==
X-Gm-Gg: ASbGncujC5v9v+pf8RF3hQCQXCJ58He5HhgKue6/KsnXn2PTFlXE+GnziKAicmIw42C
	mXPbHw2MUlG25+Ho/VY/ycqJnczxUX7cIM8XCy+LhVSdOFMnkmY0oTQjhsn+I/oGJ7MyCm15q06
	GPJ+q58Xp+lpIztYL9HvrZe1ZzxTV8dxjH+s/t0pdOsdKZYGNPC3mXSUHQAt87fMuaAsC2XeraX
	jbB/yHxlpLUDZ1vwcHgp6YQZ4LnmaxF/Epi5qeaHObkx1Taxf9uK+gEopv2Rxs3MoqfqhkRaPdo
	yHXRQNMRidahpIlwlEp1iqXJRPY2iDJS4yPTU98RL9FOOacInqS8wS7bWsFTagn/qN9oYsB62gr
	nW0UIgOQwVQHt43MOa7QabxRv4tyAFvTt+yXt79uDNjbiTA==
X-Received: by 2002:a05:620a:1984:b0:84f:f3bb:e464 with SMTP id af79cd13be357-8906fd1953cmr1596427385a.50.1760928283885;
        Sun, 19 Oct 2025 19:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVTUNR70q2Q+iuc8GL/oArje+Kg/LrBETtdWS9ljvnBQCOftYPlzMqYclVKvy5AADdaCK9Ng==
X-Received: by 2002:a05:620a:1984:b0:84f:f3bb:e464 with SMTP id af79cd13be357-8906fd1953cmr1596425285a.50.1760928283426;
        Sun, 19 Oct 2025 19:44:43 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfb57f1dsm467941385a.62.2025.10.19.19.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:44:42 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <85e776e6-110e-4c04-88b7-93059db8f74c@redhat.com>
Date: Sun, 19 Oct 2025 22:44:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 06/16] cpuset: introduce
 local_partition_enable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The partition_enable() function introduced in the previous patch can be
> reused to enable local partitions.
>
> First, partition_enable() was enhanced to support local partition enabling
> by properly handling parent's nr_subparts counter and adding notification
> operations.
>
> Then, the local_partition_enable() function is introduced, which factors
> out the local partition enablement logic from
> update_parent_effective_cpumask(). After passing local partition validation
> checks, it delegates to partition_enable() to complete the partition setup.
>
> This refactoring creates a clear separation between local and remote
> partition operations while maintaining code reuse through the shared
> partition_enable() infrastructure.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 111 +++++++++++++++++++++++++++--------------
>   1 file changed, 74 insertions(+), 37 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0e2f95daf459..154992cdfe9a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1539,6 +1539,7 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
>   				 int new_prs, struct cpumask *new_excpus)
>   {
>   	bool isolcpus_updated;
> +	int old_prs;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	WARN_ON_ONCE(new_prs <= 0);
> @@ -1547,15 +1548,21 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
>   	if (cs->partition_root_state == new_prs)
>   		return;
>   
> +	old_prs = cs->partition_root_state;
>   	spin_lock_irq(&callback_lock);
>   	/* enable partition should only add exclusive cpus */
>   	isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
> -	list_add(&cs->remote_sibling, &remote_children);
> +	/* enable remote partition */
> +	if (!parent)
> +		list_add(&cs->remote_sibling, &remote_children);
> +	else if (!is_partition_valid(cs))
> +		parent->nr_subparts += 1;
>   	cpumask_copy(cs->effective_xcpus, new_excpus);
>   	partition_state_update(cs, new_prs, PERR_NONE);
>   	spin_unlock_irq(&callback_lock);
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   	cpuset_force_rebuild();
> +	notify_partition_change(cs, old_prs);
>   }

As commented in an earlier patch, the partition_enable() chnage should 
be moved there.

Cheers,
Longman


