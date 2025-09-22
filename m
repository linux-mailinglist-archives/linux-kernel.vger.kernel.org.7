Return-Path: <linux-kernel+bounces-827904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F7CB93646
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F29A2A444C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129382F90DE;
	Mon, 22 Sep 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FocbLlBz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623A2F657C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577044; cv=none; b=cewbPE+4j7EUSwhIaN6nZ/Z2WqcBT49QRF6VivmuBL3OOl126UHMO88xpx0+WVG3piTBSYC9u9FPMMn6+16ZoKM8BSpaE18Iq3b5yg2TUxZlUwHEogBgFusAEqeH2UcAVVPULXRRm0Gvk0VNY6+cZnNypxaPdpkCQzlXsnP72N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577044; c=relaxed/simple;
	bh=uSLiGVlIIoM7NyajIMOQr8NBUWho6EVv8VLHM6IJx6M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qMt/y1NfW4ZJy8VvTn8YKeBMIvSECF5pPoRnjXdXw23mo+j5nCeQ6mg+LP0QuMJ/lZhH4NcWJr3fIucWtkkIwaxcKLyKdy7S5bRg62q6igaMFwhtM5EzVPtfM7yMjuF5uDP1UE53oP1goeYa1DbVrQHwVdN9Ec4gCE9aKrKJYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FocbLlBz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD26UGWYp2I8NuboASBVlnAzd6CeC9jo2ngEN55ArA8=;
	b=FocbLlBzikNPsY5uezI42J8klSdC8PMNnGkS5F/vGO6aIJmDlRcQYBgAiVxVgV0D7vHBHm
	3IlRenhHuZNXWKLqrPQ2Ji43jSzIIFd7J51uVE4KsXkM0TG8nNY/vIXQ/VUNlDn0AyyTkB
	L8T7ZbrHKRQh0X31Xdba5G6QERWFhQg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-FPbeIb3WNBSNIJsddyTqIA-1; Mon, 22 Sep 2025 17:37:20 -0400
X-MC-Unique: FPbeIb3WNBSNIJsddyTqIA-1
X-Mimecast-MFC-AGG-ID: FPbeIb3WNBSNIJsddyTqIA_1758577039
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b31bea5896so49143191cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577039; x=1759181839;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD26UGWYp2I8NuboASBVlnAzd6CeC9jo2ngEN55ArA8=;
        b=e8oW/Ce0jXaDQe4V4gDDha+0dHotYvPnkWasxCSZrRz+hdp6RE34NmPPl8a9CLfC9K
         kEYBVJdCZ1cWP429jLENHveNZoJw8NWEQehwAB6pxjx4LA2CXTirgk6IlL45pRO4hDQf
         VyunQfCANEiKi+e6orXtQqW6Nkr5CmR5LzrPMK+uUhuKULAUld3s2aYQ7kfPJwHTOenh
         mqe22o8zbqZ+gBBnQvn9wio0TOC3QLFATcdes53cQHQkhm+PBqdcljg8wasPRUPlqL1f
         lwne5pZHrt7nXaJUYk5dNN/T+N2RKMQ/fm9gBEgYdLI3cv3/U7yvmDTiwtmOTtdRVqLt
         j+eA==
X-Forwarded-Encrypted: i=1; AJvYcCWfaeMHiKRn3uRJRGn68SzJyo68mbRTKaQLTyUUa55hpXg4xWC2SMRhZ0LUr5QbvS7rKLuI864agN8cyfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+PRdsglK+r/e+5Ff1nHMV2V33uX6PcvX7wY7dFjZZr1YHY14
	fp21UF/ifVUxp2DJUmBULsaiYde/ebMmelb4FjxZ20vxkILyb5xcwoqlcHpSokDQHd/yFo2YDKU
	sA3IFpXgrEObZ4bTlSYn0cklQBD73glxqI+Ti+v6zvegagdkNbtsYPyLBq3WLU3V2lVMsVp838g
	==
X-Gm-Gg: ASbGncvLs8r6pWWMPqbHn95u/yOIxKP9MxU6AYnzI9z5WUXuPLuDdEDncH29C6n5XsD
	J2BmFHuy5tFc1eJ7h70WoV0lv765Bagwky0/SO5buHN427po253dSPQdpfAPabvQ+JNepK4MMqd
	EUQ4ZBUDyYO/n7m3cv3Sy+E959v0RRiLbyPe3/BTneHbMwGJOSBPXa8upt172RBwM8gqsaSI84a
	NLMDT93LE+Kl/z2GgeN/v2mfYuZ4MTjfhm1VhSlg+mztJlOO7B5D7x3XXqlc5vHFnKUjHuDhdOL
	GFHnPkQtG85osWcOWVssWPv/a5xPUkwKEVnc0GlTqwAdVH4VIlAHiZ4dUv9nqs5tzlAnKbofc4h
	R1er2eW+X66I=
X-Received: by 2002:a05:622a:1106:b0:4b5:e6eb:a24b with SMTP id d75a77b69052e-4d368b7661cmr4386291cf.34.1758577038851;
        Mon, 22 Sep 2025 14:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU56HEEnLu53dBShyrwugDcXuwnFtK6t3b/o7o9H27urog2Z0nV0RGNeximfHc2tylrXNVAA==
X-Received: by 2002:a05:622a:1106:b0:4b5:e6eb:a24b with SMTP id d75a77b69052e-4d368b7661cmr4386121cf.34.1758577038542;
        Mon, 22 Sep 2025 14:37:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4d1046b5dd2sm9810341cf.49.2025.09.22.14.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:37:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fddfeb3a-2a1e-42be-b2ad-8b6fa5f24f9b@redhat.com>
Date: Mon, 22 Sep 2025 17:37:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3] cpuset: remove impossible warning in
 update_parent_effective_cpumask
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250922130233.3237521-1-chenridong@huaweicloud.com>
 <20250922130233.3237521-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250922130233.3237521-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/25 9:02 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> If the parent is not a valid partition, an error will be returned before
> any partition update command is processed. This means the
> WARN_ON_ONCE(!is_partition_valid(parent)) can never be triggered, so
> it is safe to remove.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 20dface3c3e0..196645b38b24 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1923,7 +1923,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		 * A partition error happens when parent has tasks and all
>   		 * its effective CPUs will have to be distributed out.
>   		 */
> -		WARN_ON_ONCE(!is_partition_valid(parent));
>   		if (nocpu) {
>   			part_error = PERR_NOCPUS;
>   			if (is_partition_valid(cs))
Acked-by: Waiman Long <longman@redhat.com>


