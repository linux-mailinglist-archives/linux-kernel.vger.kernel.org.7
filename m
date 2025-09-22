Return-Path: <linux-kernel+bounces-827905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C169B93649
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDCB19083AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606E285061;
	Mon, 22 Sep 2025 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyH7oKOV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2811261B78
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577065; cv=none; b=XyECoWBRO671jiwFnno5pEwvhjIqGm9utIQ3c1P4StUshMolUt5fSHJFjYjlNSPoU5pgiyZoEmabvyJLSj8lpcrcdSyddqHcTDIJwGjIdTgF/CQsvjUxPEDd/RlDEz8B4ymK91zP6eZSUHEXxSkbFBwQhRmd5FxL+O5e8U17POA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577065; c=relaxed/simple;
	bh=2xRByGZWaFYp+yJDf9/2jDxhNXjmPcIroUgG7n6lLAU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OH1zfrrTIWhTMeiA4lHNqWFsHe+06DdJwVZkExYz+LQOegkSZmN5qEsOF05TWdkOMyPh9B0f8b7Noyt8Ho8uhxX9NtDv5P7eCAwl/JYjDwIt3ZrM18qWjPAb4ujsrI/LjY64XYVfmA/rcJXf5eD9FRcgUQXIkLt2H/JnF0oOGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyH7oKOV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHx9GFljDLp4HKMuRTlHK8PpeM3Uys9a7nlqWQ8x1JI=;
	b=MyH7oKOVCPSJNG8Sy1K74jfrkPghamf5XOW3nF+bWwSEVJ9x1e0swYBo0w1UGH7mLFxGIu
	s4J0uKuU9lkfzr5UTAQz3JKRMlwplgvnjch66dOkGpAsVOEzwkIKlE5BlJtjtkv4PjOFNQ
	WkZ0OH1aB4S4oDl9siXWZy1zkGzUSw4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425--RlGA3LzPcWAgCkOZPcmdw-1; Mon, 22 Sep 2025 17:37:41 -0400
X-MC-Unique: -RlGA3LzPcWAgCkOZPcmdw-1
X-Mimecast-MFC-AGG-ID: -RlGA3LzPcWAgCkOZPcmdw_1758577061
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f31ef7dfso108057811cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577059; x=1759181859;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHx9GFljDLp4HKMuRTlHK8PpeM3Uys9a7nlqWQ8x1JI=;
        b=P4EP8pdQhCMrNnz5ALDdu7tHpuNrfW/goKRpdOvsdWMA1nTrpji7v/mJ6WirHsGZbz
         JOn0t9hVGGTcejtmzkJAy2BPqhwBnhu7nfX4TZYUN1Cdjgms22FHzIYB6pt7xud2cbaQ
         iomwpMEqj/LvGNMKFe4JC+sFjMXwT07pYIDA0ZetQ1naQKEwcnqNIElcixnrpJUtxZiS
         U+lxJSU3vsiIA8qZXegE+L7p0isn78deTFE5qZ3xWkFwrPmE81W3fssW2OEwmw8twxYg
         QjLcYJ7pK/7SLT1hKUsVf6uL1n0O491yWr1vnC7zTY7xRIq6CYWtqViZua7drWYDWRN2
         A70Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGJhQkr80i5PSsDQTrbDL9AhESTX9hVzNqteuo5Jcu9hjXen430fkMIJlYkbsseNLWMPpLdfrehMguPcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTULhHMjJu3ime4LVMtD07GH+TUeU3SMw/QFCTKVuwfPfqxtEy
	OTKWhgBNbv8EMS7gp9h1fjwaVSb8vGI93cqtWyJGghQQrmqJvsdJWAJpNKZGZMPhSv2Kt8PsFYY
	P6xDlkEZC+Ayi6kaMqZms8vt3MXSHAR1hl3pLZQ/cOH1W9YgRhqdIxHNYxzFsUErOtCOQKFO/bQ
	==
X-Gm-Gg: ASbGncuHeqZDNmrh5wUjmNkLEC13hZq/Eedis/YAFOnihnI5zl//YH35adQFOJ7eAL4
	aax4Q7h2zd7gbUEVXRUtvNX743W5KtsaCnHXvD6RnSEjY7ADfgWif6Q15dt5JgGMAIcDmJ9GZms
	UaOKRz0e8ALUh8G/Yd17HgizKDnJ0YKYGUXTF0UBGJSllWD49QUE9tW4SDcvSdgXeg4p9LET9g7
	c0rAGpcuP9fIoXml8t+GjIVRU5p9G8HYtyrktwiAYg4VPl11ipvl7KS4SDm5/jlNI2/RnnUkITU
	i0NT9D62oc7xZcf+h34ouDldS31jn8NksAR/wPES4ew49Rxo4DEM/0Q3sBinbMWNUUgepj3Ww0x
	A8219iC0Ddic=
X-Received: by 2002:a05:622a:1a90:b0:4c7:e39a:388a with SMTP id d75a77b69052e-4d3830ea28amr3416071cf.0.1758577059508;
        Mon, 22 Sep 2025 14:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF65sFLcUY2meuKw1Ms7ZsIIJeyCSdxc8t3NjAE5Ax7Mh9ZfaXbvNEG1GYuZczXHHGoaefyDQ==
X-Received: by 2002:a05:622a:1a90:b0:4c7:e39a:388a with SMTP id d75a77b69052e-4d3830ea28amr3415811cf.0.1758577059075;
        Mon, 22 Sep 2025 14:37:39 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-848b1f5b5f6sm283872485a.31.2025.09.22.14.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:37:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f5288f26-0d4a-4b89-8119-7c3b966df1fc@redhat.com>
Date: Mon, 22 Sep 2025 17:37:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] cpuset: remove is_prs_invalid helper
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
 <20250922130233.3237521-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250922130233.3237521-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/25 9:02 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The is_prs_invalid helper function is redundant as it serves a similar
> purpose to is_partition_invalid. It can be fully replaced by the existing
> is_partition_invalid function, so this patch removes the is_prs_invalid
> helper.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 196645b38b24..52468d2c178a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -132,11 +132,6 @@ static bool force_sd_rebuild;
>   #define PRS_INVALID_ROOT	-1
>   #define PRS_INVALID_ISOLATED	-2
>   
> -static inline bool is_prs_invalid(int prs_state)
> -{
> -	return prs_state < 0;
> -}
> -
>   /*
>    * Temporary cpumasks for working with partitions that are passed among
>    * functions to avoid memory allocation in inner functions.
> @@ -1767,7 +1762,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   	old_prs = new_prs = cs->partition_root_state;
>   
>   	if (cmd == partcmd_invalidate) {
> -		if (is_prs_invalid(old_prs))
> +		if (is_partition_invalid(cs))
>   			return 0;
>   
>   		/*
> @@ -1874,7 +1869,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		 * For invalid partition:
>   		 *   delmask = newmask & parent->effective_xcpus
>   		 */
> -		if (is_prs_invalid(old_prs)) {
> +		if (is_partition_invalid(cs)) {
>   			adding = false;
>   			deleting = cpumask_and(tmp->delmask,
>   					newmask, parent->effective_xcpus);
> @@ -2964,7 +2959,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	/*
>   	 * Treat a previously invalid partition root as if it is a "member".
>   	 */
> -	if (new_prs && is_prs_invalid(old_prs))
> +	if (new_prs && is_partition_invalid(cs))
>   		old_prs = PRS_MEMBER;
>   
>   	if (alloc_tmpmasks(&tmpmask))
Acked-by: Waiman Long <longman@redhat.com>


