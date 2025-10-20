Return-Path: <linux-kernel+bounces-860017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC4CBEF23F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B54E14E607A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2F248176;
	Mon, 20 Oct 2025 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiGnlJZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E45833987
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929580; cv=none; b=aI3yhPZVImUlcYpJ3qMLGjv8LrXaU80G5/HfDnIIchDXR9vyZBIdDBi6n9XtRg8gE2FedllK3Wg4gefx8tTcKSmn0ysH/0Cjil2V3SktqbW1X2S+dZGP3V9jBdmGZrFSsgyCwvQJoxKidQEu11mZQrJQyIAg6fgy1j+IGAU/9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929580; c=relaxed/simple;
	bh=7N2T2H6xqeb+s2RqOis9of2IMSQJUG36GeIPiHqGvew=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X/3SXOT2aQMoGRFBQPUXf1Ew1QuFA6zLYr6SJcVPkT0ZnJPP/b14U71xlhL6y+0ZJvjQI39NVPPSlzwyUHwCzzweOhCOe9i8CfgBzOwsZcy3YFMxottZC52FMPc65yCsVV9GjyDWrvkj6VGGSQbcOt5yOtF+nmMgPMTjhdU8VWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiGnlJZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760929577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QxLHu88/J8uGioBBOh2aPODsSSOv5fZdzgxa8HnOPc=;
	b=EiGnlJZAIE3TJYm/q+zO9LsyasLvHykpiVnysE7ihibucYJMd3foKaEcTjhAsKk3QWVq5i
	2OrIP3f96Snak1o1vuKSNG/x/pd01dttdx8xSnmOfsW811ytRP+whNkhdqvmnlm4JszClF
	c8uOuayYpfZUd3liuVWbzXQZf+R2Jcw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-FovxwLcrM4m_hHc3ryNGUQ-1; Sun, 19 Oct 2025 23:06:16 -0400
X-MC-Unique: FovxwLcrM4m_hHc3ryNGUQ-1
X-Mimecast-MFC-AGG-ID: FovxwLcrM4m_hHc3ryNGUQ_1760929575
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78efb3e2738so130005806d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929575; x=1761534375;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QxLHu88/J8uGioBBOh2aPODsSSOv5fZdzgxa8HnOPc=;
        b=hLzUMN5AzntF7is0Sy0hWlxH7T3RoD2lgL4vieXzth10loovZ8csamRcsT5SoALy+5
         tVO0pai9wU/xncie6mUnpAKZuICvHOt4ECTU2OaEuIGce7HUD82RJ1YXsV2gNd3tiu80
         /IHH8KFXKr5lRJDsiV45SrjF3hK8ywNPPkOchhVZ8hUfFePha1JtDC2jTHzmNV4shkjS
         i6GFnePxMT6aX3g0V0lSJSoHqZE8OAGCxRUZy8FY5oa60ICI4l+rnBBHLEAcNa0epXdP
         pHftOdWEkpFSIbo5ditPPL7m5yyy8Tuc5aT0Rxm77XH3Ujlnsk1oFTfJ47N1x4MA+Zgz
         IUEg==
X-Forwarded-Encrypted: i=1; AJvYcCWCgIXLAEL7bBS4Cz5r//iZiU6vMhD7Pn4Ww2pD7qWZYipDGtE5SjXhZFSCHp3/SV7K4Zv0UT0/IWtNT30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3wNqMjxwHx/n733l14JRMZxDzXF1KXG2UlHNBhZ1H07n7twi
	vy0HCY7SELe8E0iv6qMw6tjc1GPaEuonR1OtHt+NXI0dIf6W72wPEH+mh7df38oxAEVAAzfmDQw
	9WS/Wzz6y2SOgLye1mc379hjVh7b+XHkjyZsEHpW3n6g+SS/U58tB26BE17Xdz3m7/Q==
X-Gm-Gg: ASbGncskbmxa+dzN3TIs2fRt3/7zSdFyDBNDnFGBNEVJGGGMgriY/bo3cmSJIcneAhI
	Ucg18d48oFB/8OE8HTdDiIKBKtk3FEhjwXbUO1bVrD+fVdImoQyfD8Q2BMMGnDsQzdbshIJ8QUW
	5YpvHrEsv8N8JXEaso7v7niGzfHZjuZ/uswJHuhHoS0fItn6Z6B/ybe3I3F9C6ucQGnm5cujvOg
	tRLvrVX32vqkpO4C8+1w8cJ6Fzc2Dw+uRh0YfUry5GqHUVDq8iPSjhpNh3swSgzDbKJftqfl3ad
	/mCqcdPvfKIMxcFLuhzsVVKWL2masF9SLy3x58cxcgpttMHAdEWDSIBMANHBH7AI+fM5EsgK80N
	j0iLejF41IZAWAtUgaDBqXc77PDENdmhaMM+t7cynsPbIdg==
X-Received: by 2002:a05:6214:27e7:b0:87b:b3a2:6727 with SMTP id 6a1803df08f44-87c20637859mr181719416d6.45.1760929575386;
        Sun, 19 Oct 2025 20:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJOK8Qtp1ennlsqg1ib14bZ3gwOiagIloP9TClPxRBCw1Fao7aw6/ncOek+1KWV+ZqrzNUVg==
X-Received: by 2002:a05:6214:27e7:b0:87b:b3a2:6727 with SMTP id 6a1803df08f44-87c20637859mr181719176d6.45.1760929574766;
        Sun, 19 Oct 2025 20:06:14 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521c120sm42971456d6.20.2025.10.19.20.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 20:06:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a07b794c-d133-4d23-b0b0-cb9e0dc42d2b@redhat.com>
Date: Sun, 19 Oct 2025 23:06:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 14/16] cpuset: fix isolcpus stay in root when
 isolated partition changes to root
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-15-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-15-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/25 3:13 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A bug was detected with the following steps:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 9 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated
>    # cat test/cpuset.cpus
>    9
>    # echo root > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus
>    9
>    # cat test/cpuset.cpus.partition
>    root
>
> CPU 9 was initially placed in an isolated partition. When the partition
> type is changed from isolated to root, CPU 9 remains in what becomes a
> valid root partition. This violates the rule that isolcpus can only be
> assigned to isolated partitions.

I am a bit confused at the beginning about this as it does not clearly 
state that CPU 9 was listed in the "isolcpus" boot command line 
parameter, but I believe this is what you mean here. Yes, there is a 
restriction that a boot time isolcpus CPU cannot be put into a 
non-isolated partition, though that will likely to be relaxed in the 
near future.

Anyway, it is a real corner case. I also don't believe commit 
f28e22441f35 is the one that introduced this issue as the restriction 
was added later on via commit 4a74e418881f ("cgroup/cpuset: Check 
partition conflict with housekeeping setup").

As you have added a Fixes tag, it should be moved to the front of the 
series as it is likely to be backported to stable. Putting it near the 
end of a series with a lot of changes in between will make it harder to 
backport to the stable kernels.

> Fix the issue by re-enabling partition validation, which performs
> comprehensive partition error checking. In the scenario described above,
> this change causes the operation to fail with housekeeping conflicts,
> preventing the invalid configuration.
 From the code diff below, I don't know how you re-enable partition 
validation.

>
> Additionally, when enable a local partition, the warning for tmp->addmask
> not being a subset of parent's effective CPUs was removed. This warning was
> triggered during local partition re-enablement because the CPUs were
> already added to exclusive_cpus during the previous enable operation. The
> subset check is not applicable in this re-enablement scenario.

That should be in the new code that you introduce in this series. So it 
either be integrated into one of your earlier patches or be separated 
out as a separate patch without the Fixes tag as it is not applicable 
for the stable releases.

Cheers,
Longman

>
> Fixes: f28e22441f35 ("cgroup/cpuset: Add a new isolated cpus.partition type")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 35 +++++++++--------------------------
>   1 file changed, 9 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 20288dbd6ccf..2aaa688c596f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1873,6 +1873,7 @@ static int local_partition_enable(struct cpuset *cs,
>   {
>   	struct cpuset *parent = parent_cs(cs);
>   	enum prs_errcode part_error;
> +	bool cpumask_updated = false;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
> @@ -1899,22 +1900,14 @@ static int local_partition_enable(struct cpuset *cs,
>   	if (part_error)
>   		return part_error;
>   
> -	/*
> -	 * This function will only be called when all the preliminary
> -	 * checks have passed. At this point, the following condition
> -	 * should hold.
> -	 *
> -	 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
> -	 *
> -	 * Warn if it is not the case.
> -	 * addmask is used as temporary variable.
> -	 */
> -	cpumask_and(tmp->addmask, tmp->new_cpus, cpu_active_mask);
> -	WARN_ON_ONCE(!cpumask_subset(tmp->addmask, parent->effective_cpus));
> +	cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
> +					 parent->effective_cpus);
>   	partition_enable(cs, parent, new_prs, tmp->new_cpus);
>   
> -	cpuset_update_tasks_cpumask(parent, tmp->addmask);
> -	update_sibling_cpumasks(parent, cs, tmp);
> +	if (cpumask_updated) {
> +		cpuset_update_tasks_cpumask(parent, tmp->addmask);
> +		update_sibling_cpumasks(parent, cs, tmp);
> +	}
>   	return 0;
>   }
>   
> @@ -2902,7 +2895,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	int err = PERR_NONE, old_prs = cs->partition_root_state;
>   	struct cpuset *parent = parent_cs(cs);
>   	struct tmpmasks tmpmask;
> -	bool isolcpus_updated = false;
>   
>   	if (old_prs == new_prs)
>   		return 0;
> @@ -2920,7 +2912,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	if (err)
>   		goto out;
>   
> -	if (!old_prs) {
> +	if (new_prs > 0) {
>   		/*
>   		 * cpus_allowed and exclusive_cpus cannot be both empty.
>   		 */
> @@ -2950,12 +2942,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   			err = local_partition_enable(cs, new_prs, &tmpmask);
>   		else
>   			err = remote_partition_enable(cs, new_prs, &tmpmask);
> -	} else if (old_prs && new_prs) {
> -		/*
> -		 * A change in load balance state only, no change in cpumasks.
> -		 * Need to update isolated_cpus.
> -		 */
> -		isolcpus_updated = true;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it
> @@ -2985,16 +2971,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	WRITE_ONCE(cs->prs_err, err);
>   	if (!is_partition_valid(cs))
>   		reset_partition_data(cs);
> -	else if (isolcpus_updated)
> -		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>   	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
>   
>   	/* Force update if switching back to member & update effective_xcpus */
>   	update_cpumasks_hier(cs, &tmpmask, !new_prs);
>   
>   	/* A newly created partition must have effective_xcpus set */
> -	WARN_ON_ONCE(!old_prs && (new_prs > 0)
> +	WARN_ON_ONCE(!old_prs && (cs->partition_root_state > 0)
>   			      && cpumask_empty(cs->effective_xcpus));
>   
>   	/* Update sched domains and load balance flag */


