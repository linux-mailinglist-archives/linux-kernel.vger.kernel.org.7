Return-Path: <linux-kernel+bounces-860016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF942BEF23C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E41898042
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05321CC4D;
	Mon, 20 Oct 2025 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WngY3mW0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C491DE2B4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929332; cv=none; b=fWkm6LDcmE2HgdtpiFi6uHWTth0C9o73cd3LYBVEvS27xjoTfKqtlLAbXub16/tmzEvrqT5AyFLq6C0++MPANnrau3xDU+75gE9/3MKs4NKSfRpuKF0QmJfx0SKvPkUlkM++Xx3ds/A0+3EiCBgUXeX7yjTF57Rd61n4MYOVZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929332; c=relaxed/simple;
	bh=rAoQi/OVGRD40wxyBtagKf5s2lVoONJmqXW1VzaEnys=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uvLWQ7PP9X6slaOnLyi7fuvjErUhtZ77PKGNyiYyg5R5DecHmO8MtE6551JriSyGpD4BslwImzdiqQGyisv5uyR2VZEUjxlfb/oKNcLCw0cH5yNrxd0IxoS7sgyenjCFi/Tn4lj/jD5FLP0LtITpOnKQN82SllpkAT2pPEYqc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WngY3mW0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760929329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfb2SEcPIGgCEG5yuBvT/WnsW8xLWJgx9/NcXzeHRCg=;
	b=WngY3mW0jmzXGylfpvbM+wyf3XMghCwc/TC10+WV94lEtzOaQxE/eEoU+9JEP7B6NxCyYC
	ADz3+HTkYPDpYmhwpJP8KnbJB+d4VtmcCz7TaJQROFnaBOgGfqX83AaDwgeBb/pYCD/ZC3
	JDbRaENbWDsIfmzqL6SS69u3u7nXwDw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-_g_-MpbyO-yhD_fBy9e3wQ-1; Sun, 19 Oct 2025 23:02:08 -0400
X-MC-Unique: _g_-MpbyO-yhD_fBy9e3wQ-1
X-Mimecast-MFC-AGG-ID: _g_-MpbyO-yhD_fBy9e3wQ_1760929328
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-892637a3736so792537485a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929327; x=1761534127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfb2SEcPIGgCEG5yuBvT/WnsW8xLWJgx9/NcXzeHRCg=;
        b=LjKOwpFyPS4DPeMBUkAO5NRq+jnxmXKRemzKTcI/Nalwtjaoy3rQ9IPdH5fBXMbwkY
         2yGwV95v7lk5TOHTQ3Ku0d3wKYSmR8CIdzW0wdPqXUaXRN2sXnix29SA0mm1T+L9sYAM
         8NDIMPNfkmi3IePqwl6K/t4pdf0myvzpN9PyNjVj1LRJBImO6PIHOoa0iX4WFXB55noC
         yc7QGcSgvBKvnXDWngB5BukaktVXXnWq01Q6IpuSo10WWqJLfmaDeLeRwmayvtuD+hTL
         y5hV1ddqmek6Z498cUEfwRoR7GnevhhuPpgYFZL+fZ1+hP4GYk0r8+H22rcHsuWlMN7l
         MXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQYqsw/pagoCGxuOBYnX3jrmTl1B6VgUI6BKZbGA9S6QhB1ZWDVLOAv1mptz20vbAjZty39SFNL+1NZQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9WMssIstNRGLBxkMhfpaTxasMrJF2uHRIRHM0wGk821vygIw
	kedD7CYu0CEfxFNMBcnmCHFrVzHiwBDjL+F3nv0sCEHmH9pn1DbFgXlv6bvfCiJxUcRdUIFd/0b
	MjRpESVHBgHOXBdZ98soPqgaguhiHmN7s44lQ5PTXZmg3hRRAIHYiTK/DhLGUzZWd+/MPpwjkdg
	==
X-Gm-Gg: ASbGncvlPsJ13TGcI4dhgnu4IIVeTncdJmEtQqMvPnTtTdmr8vuzxWY+jZKlQclpWdP
	fiR5FnzgeHK9pxjvRtH68rfTeMATCB4E/Kybw7Sdp4cwB0efJiGhKvLpnOSyt2Z+cKLi6jHZk+N
	PR0s4SSE+ZCfmSZDrd2f83Xh7z3ze/Mkb25PQOaAAkE0Zy5Mju9HogQNV3OzMsXoVwsux9Ex0TG
	cpvLuBLSELYxVwdbOD+v5zzek1kaplRLSV37vfz/aOUYRHZfYSm5aml8cwqjH97yk86AHYXlr0I
	TiR/v/Eg+VZ6uCa3C0tBYv3HJ+HNXQ9le1VSAErcpJTqxx8kEZML4CWhyURg8CLd1jOregMmPfz
	mtK56lky3ypaQAEJj6p3u4j1HEnTPMx3pgsViGqSijbzevg==
X-Received: by 2002:a05:620a:46a8:b0:890:379d:9807 with SMTP id af79cd13be357-8906fd18325mr1353121885a.41.1760929327197;
        Sun, 19 Oct 2025 20:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGSG6T3ISqKJSkJcpmPGMJEfII85UaXeot8tSn96YFrb3xzePkyRwEClWOgaSQJ+VqRt7IbA==
X-Received: by 2002:a05:620a:46a8:b0:890:379d:9807 with SMTP id af79cd13be357-8906fd18325mr1353119385a.41.1760929326843;
        Sun, 19 Oct 2025 20:02:06 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aadc2032sm46417621cf.0.2025.10.19.20.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 20:02:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <21d14cb8-3c8f-45cd-abdd-961271d537da@redhat.com>
Date: Sun, 19 Oct 2025 23:02:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 13/16] cpuset: use partition_disable for
 compute_partition_effective_cpumask
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-14-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-14-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/28/25 3:13 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Replace the partition invalidation logic in the
> compute_partition_effective_cpumask() with a call to partition_disable().
>
> This centralizes partition state management and ensures consistent
> handling of partition disable operations throughout the cpuset subsystem.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6625b803ba02..20288dbd6ccf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -170,15 +170,6 @@ static inline bool cs_is_member(const struct cpuset *cs)
>   	return cs->partition_root_state == PRS_MEMBER;
>   }
>   
> -/*
> - * Callers should hold callback_lock to modify partition_root_state.
> - */
> -static inline void make_partition_invalid(struct cpuset *cs)
> -{
> -	if (cs->partition_root_state > 0)
> -		cs->partition_root_state = -cs->partition_root_state;
> -}
> -
>   /*
>    * Send notification event of whenever partition_root_state changes.
>    */
> @@ -2073,6 +2064,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *child;
>   	bool populated = partition_is_populated(cs, NULL);
> +	enum prs_errcode prs_err;
>   
>   	/*
>   	 * Check child partition roots to see if they should be
> @@ -2095,26 +2087,20 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
>   		 * partition root.
>   		 */
>   		WARN_ON_ONCE(is_remote_partition(child));
> -		child->prs_err = 0;
> +		prs_err = 0;
>   		if (!cpumask_subset(child->effective_xcpus,
>   				    cs->effective_xcpus))
> -			child->prs_err = PERR_INVCPUS;
> +			prs_err = PERR_INVCPUS;
>   		else if (populated &&
>   			 cpumask_subset(new_ecpus, child->effective_xcpus))
> -			child->prs_err = PERR_NOCPUS;
> -
> -		if (child->prs_err) {
> -			int old_prs = child->partition_root_state;
> +			prs_err = PERR_NOCPUS;
>   
> +		if (prs_err) {
>   			/*
>   			 * Invalidate child partition
>   			 */
> -			spin_lock_irq(&callback_lock);
> -			make_partition_invalid(child);
> -			cs->nr_subparts--;
> -			child->nr_subparts = 0;
> -			spin_unlock_irq(&callback_lock);
> -			notify_partition_change(child, old_prs);
> +			partition_disable(child, parent_cs(child),

The parent of child should just be cs. You don't need to use parent_cs() 
to get it.

Cheers,
Longman


> +					  -child->partition_root_state, prs_err);
>   			continue;
>   		}
>   		cpumask_andnot(new_ecpus, new_ecpus,


