Return-Path: <linux-kernel+bounces-752269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA7B1735A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE523B3AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67381A0712;
	Thu, 31 Jul 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDaTrJSp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DA1991D4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972929; cv=none; b=s5k4fpiNr4Az/wBKC1Rmq/McFxSNo5pxgD5g74jK5o+ukcMS1b8AfY3ljSkYKIbg1F+t33igw08+ynHVD0qC75znsByOrj+gUhklXpfg29gB6zj8lQZqRujY38BZzsjh4WE49oH3PYAg7GrULbvjHxPKSKVeqXaF4GKpN3c4iP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972929; c=relaxed/simple;
	bh=aWx2gjqS6M6ygu3N9po/c0VNXsn303TDvVKp71moG+0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=doNtyFW1WNrUQjlVBmXX/NSNejIcW+wRA1Vb6XhRVnwgqbdErZ0u0bpGcM2MARni8yFPKvmm1meGrqYWKbhPD3xUEimzlTZVlUIrnVA4fRrRf6xAkNlCJeQWlbd3E8sEc0SJYd7BqD4vGmMv4Chk9J10cYC6piWFgAeoLwNCNwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDaTrJSp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753972926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsiOkYl8w6UkdDXvwA/Q7z1jJLdQhRaeynAGg2kIoco=;
	b=XDaTrJSpltSlHzPLWHoatzggLDGTCSbD2C0wZiqzlF1Lwfl5CuC20yCOzmNO+kKoLs2yn0
	9n71rPxxep60xBzUyUFvpYRT7ZLcdjr6K495lmBQY8YKOyYlz76rJWCskJ6OqJq1g6lOny
	9xxmukCiWk0tkuN5YO3H59315fwX+0E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Gy7PwnfUPQ2W5QC52rPa_g-1; Thu, 31 Jul 2025 10:42:05 -0400
X-MC-Unique: Gy7PwnfUPQ2W5QC52rPa_g-1
X-Mimecast-MFC-AGG-ID: Gy7PwnfUPQ2W5QC52rPa_g_1753972924
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab6d31e2dbso10689661cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753972924; x=1754577724;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsiOkYl8w6UkdDXvwA/Q7z1jJLdQhRaeynAGg2kIoco=;
        b=PdkN1HzHR6ggssRqmDB7SmGUBRhdz4bKVDXomyyAYQ+uyO79xC1C939+HJjsTtS/SL
         alrroS1W6gw+rTMQiuJyMvVoye1t/yzZPaU5z4ZjFuSMYjbpg7n5VGBodVhBzfbVPNj4
         qbPRvpLQzMnOu34k5SMMnzSK3TgHD+hAuhSOKS4w5+PKaU4viV6RQy7C+QNC8a5YndBx
         vE2PVG+WzFep8BSuwSINmMZYf9IP+g0CC4Ut9QF6MAJNkXKP/O27g6IcNhuVfcLUnKOu
         u9kf3E4ED0uUBJlBfS+7fPcH9Hw2PVS3bwjZp/QggTIZarsb76GTRIXGGbkJl/KMNCE3
         ZZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUV+UG5nlJv3upPluIpTkoRTxznPiHDrP61UQ6S6wGfIzhf9GHzIh72N4SiL3zaqQ/qMsGm3lOBSM9xnuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxadr0mHMsdsb27xpnK7fFBsCReLIFZwJfRy4B/VNP09/Y1KOzo
	RRSgRFTitSrTTA9FeixtaeuMaJUJ7KM5+1XJ5qNeRjjVtx1NN7aRMdxwTVOgA2Zm7LEMNPupF0H
	K4IS/LKSMz1qRZeYCdPoaTXblYtz+tnIzZw6ZibVOcsOAEZEHs+Ty+WWjjoHSnguTJA==
X-Gm-Gg: ASbGncsWgCbii1qEnRCRCpKHLKbJ4BJycyeGcw31a8eKQlIBv9C5CaaVXJvCZBO4ltx
	phZZYmrqF10jeedzO+5zGCdHtc1bQ+tRL7juSqHxHKe6QHeIDdV9BlHU3cRobRLxAOtVaRNOaoD
	tX/z9SQFiBWH9/Ro6TAcaURQp0o2/vniej0pekfHzoUMk8NzT8GFACatVomVGg5hlimLQ3fnJA+
	pHMW/X36dDKnwKJ7ArfVHUQRhSmFf5Irml3ypLPss6q9G990/8mUdG7lYCnA7Md1lt6tdxWe48/
	Is3RARnTm3flf9tWUovXIXCBtjsBKpTGm49mVDa68XrKeLvLwl0xeUpGun7TYxclQI7XaOkSofL
	TXo74yJj/Vg==
X-Received: by 2002:ac8:5856:0:b0:4ab:535a:8612 with SMTP id d75a77b69052e-4aedbc7a2d5mr106935091cf.45.1753972924413;
        Thu, 31 Jul 2025 07:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoC+TiYhD9lbEfddzo7WoEaaA7lV+KxK6mjK9Hi8FAyhmapjxwPPfjzyisW2yq4w1/CMm2MA==
X-Received: by 2002:ac8:5856:0:b0:4ab:535a:8612 with SMTP id d75a77b69052e-4aedbc7a2d5mr106934661cf.45.1753972923974;
        Thu, 31 Jul 2025 07:42:03 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed670c6sm9167081cf.37.2025.07.31.07.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 07:42:03 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dfff7d97-9fc6-43f3-864e-0ac31213d141@redhat.com>
Date: Thu, 31 Jul 2025 10:42:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/8] cgroup/cpuset: Rename
 update_unbound_workqueue_cpumask() to update_exclusion_cpumasks()
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-6-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250730131158.101668-6-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 9:11 AM, Gabriele Monaco wrote:
> update_unbound_workqueue_cpumask() updates unbound workqueues settings
> when there's a change in isolated CPUs, but it can be used for other
> subsystems requiring updated when isolated CPUs change.
>
> Generalise the name to update_exclusion_cpumasks() to prepare for other
> functions unrelated to workqueues to be called in that spot.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3bc4301466f3..6e3f44ffaa21 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1339,7 +1339,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	return isolcpus_updated;
>   }
>   
> -static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
> +static void update_exclusion_cpumasks(bool isolcpus_updated)
>   {
>   	int ret;
>   
> @@ -1470,7 +1470,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	list_add(&cs->remote_sibling, &remote_children);
>   	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>   	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_exclusion_cpumasks(isolcpus_updated);
>   	cpuset_force_rebuild();
>   	cs->prs_err = 0;
>   
> @@ -1511,7 +1511,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>   	compute_effective_exclusive_cpumask(cs, NULL, NULL);
>   	reset_partition_data(cs);
>   	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_exclusion_cpumasks(isolcpus_updated);
>   	cpuset_force_rebuild();
>   
>   	/*
> @@ -1580,7 +1580,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   	if (xcpus)
>   		cpumask_copy(cs->exclusive_cpus, xcpus);
>   	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_exclusion_cpumasks(isolcpus_updated);
>   	if (adding || deleting)
>   		cpuset_force_rebuild();
>   
> @@ -1943,7 +1943,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		WARN_ON_ONCE(parent->nr_subparts < 0);
>   	}
>   	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_exclusion_cpumasks(isolcpus_updated);
>   
>   	if ((old_prs != new_prs) && (cmd == partcmd_update))
>   		update_partition_exclusive_flag(cs, new_prs);
> @@ -2968,7 +2968,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	else if (isolcpus_updated)
>   		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>   	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_exclusion_cpumasks(isolcpus_updated);
>   
>   	/* Force update if switching back to member & update effective_xcpus */
>   	update_cpumasks_hier(cs, &tmpmask, !new_prs);
Acked-by: Waiman Long <longman@redhat.com>


