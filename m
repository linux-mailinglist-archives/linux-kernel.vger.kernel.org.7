Return-Path: <linux-kernel+bounces-898109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32163C5467C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39BC64EB47A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2353B2868A9;
	Wed, 12 Nov 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsmND9ho";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKuh6Up+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FF27B359
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978164; cv=none; b=hmkhk4xwBX8vaRiAaZtjWw6G9Z9LPfT4R3Fv2dLs/Uw181LORBtUWOy1tywUztNG/Yk0N+L1w0nls+ZL12vCwWuuj2TNcQkcYsQE7KsWZqqWmY6qBzwbYBVV/YkvTn8mw4Le21o7XdS/KcGZeZAqsE76NEtGVZyEFV/ftNgi+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978164; c=relaxed/simple;
	bh=Q7jKv1JlKhmirpqCatrnUEr8E5+mAGjOY7Wywiyo+Sg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BPakHJsXNApvBnshvaadVYiR6u31AMopQC8VHyMcQsvi47lCK00VTh1c4ohInVfMnAgZ5lMK9hLH1NxabFD2vGBHA6BjnNULTSfp5i1R8kSrLYJYTt3WDRLxm9eq0HcmnJULYGQGk0Dr1Xzj37GrmFPdvcU1VbQZ69+8Zmvul2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsmND9ho; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKuh6Up+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762978161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsVZFRRGhKmeupE13R44EbaKUl2pjowYCrWWNsS8SwM=;
	b=SsmND9hojdBgUyPqlVvtGXWh2ygVO2ln1m3ZfAZ47iwNx1oAXWJ8zDoKfMZuT3LbwWTjiw
	XgzLI1kk1/gesh4ODjRi9QPaAC9k1DinUsdJZUpM3hkStmLPlSuoOph2RQJKr8r6ZWKm1t
	HJSaRoPjPJgnkm/whuR8UsAJzwgvd7U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Zso4ezIKNV6JvuIydaTWRQ-1; Wed, 12 Nov 2025 15:09:20 -0500
X-MC-Unique: Zso4ezIKNV6JvuIydaTWRQ-1
X-Mimecast-MFC-AGG-ID: Zso4ezIKNV6JvuIydaTWRQ_1762978160
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed5f5a2948so537521cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762978160; x=1763582960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qsVZFRRGhKmeupE13R44EbaKUl2pjowYCrWWNsS8SwM=;
        b=PKuh6Up+4JUfWIEmgE2vTDO0jw+9xBDnw9DilXXoDtKk9u2b7JP5gR2o+vIoYG8CTB
         4BxjaJFvV5H6FGTuGIIr9yQbdm0IkdV2kWyR39CTDgAVmTn7HKHm9EtE2HfBjYApU2ef
         QSuLgXTK8Un0Kkpom9DGXLn05Gpwf8zDrPrMB/thhlXC0v7dmSOUr7IIg0pjEW7G9B+v
         YOsF2lDltZ0BvYu5lHPa3Ach9UE3GZyyrbNia/iYFpKEs6quM3WAZNoDZo3nE2iScvz5
         by8IakZC3oR73oEvgRB4RTecTLQVgJ35IsNwGofgxNzeovIFx/d3PZe3sXm5lDqBq6zP
         EJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978160; x=1763582960;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsVZFRRGhKmeupE13R44EbaKUl2pjowYCrWWNsS8SwM=;
        b=sO+l/nzdVR9M/+zI1Tx3YDk0v5dxz50xvhUIUmGeQcbNLQ7amI/CcjPVHI0yHtUHyq
         yn1ztegZPrO7RPAfzuaKXZY+PFZ/i5UxYeOdIE+Xf9/vbp8sRlhqJ/+osGOZWKeQ0SRQ
         sZ+yIwH7wrUQsqu2Wls9oh7BendFGEdiFMmgySENKlXss3oR4XryZkVWDL6Sfkj6tKvs
         g2z3jjxhLU8ZCzX1QpDW+FIg3rBalDUqx56608Qpsis9zQ9ry9p1yGKLUCd7vL79IxxD
         93f4JWbijBR8BZlya75u2gAupX+md1EYddnBHPcoP+UhcfW4/DjkGrAR3aGI444DK3Xy
         swPw==
X-Forwarded-Encrypted: i=1; AJvYcCV432HRYiyYTDIUn9kQHyh2AHUPE8bAC6yGXZ+nKIPakDKJxOonJmeQK3SKrBym//Y4R8FsmocIw4iDeyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEc4QoVmQguDbmWY5cuDni+Rm6Kdk+WK+MlRPVeRQoHxN+NO+
	g0XWjgmfQMG6nJE+uaMQjGNhO/ck8sKLliD79YwvtGp23+92jrQ26ecLz2vU0SmZTosGrLEAcjr
	fEZKui/HUZNz40BFhkX2LcaxHN+13c2Zri7F+JtniX3FU5nv3j/rFVbU40FTCzk4k4w==
X-Gm-Gg: ASbGncv4oIdQng2FUGi+KCqhmKqg4uuWJiNvf0NWmYp5VSbUUbRLvkrJ2QsSLL5jeb8
	bypLtP+nAjxbyQIo6ksExiP3f1Od8Efmfko3iPkDgHyPv3bJFZ4j2FUv3DufKMTwuY8vyX+Aqsc
	SYxwB2AgZTEo2IM96LOacE+tzHNUfaRMARFMPUdTAJunRVNGxmNHLgTIBZ+OGLTNDJ9U31K+wZA
	rMcQ/9apMgRk4+8O2g438ukPAAf/494jdb4OVNZcyLYraOBk22UNvlrUAeS5BJfaJZOgLBImsFi
	9R1EvTSxqKP56wHaHtCLjzV+lCCULB5NfZXR5iZqUXvnmL2NSNDaTyNbWB5WARP1ya12F9UQCIt
	5TxUFvgF+3OsdmOKlK/WYKfQeVF3TsNptAzq/hs59O7PgQg==
X-Received: by 2002:ac8:57d0:0:b0:4ed:635c:17dc with SMTP id d75a77b69052e-4eddbccc00amr49732841cf.8.1762978159815;
        Wed, 12 Nov 2025 12:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrHRtoWUnalhKkU81sz2ukv2YLjrxVdyeykwnN+OFwK5SIwxIrrc30MD3x4HLaRYsG8yBL2A==
X-Received: by 2002:ac8:57d0:0:b0:4ed:635c:17dc with SMTP id d75a77b69052e-4eddbccc00amr49732511cf.8.1762978159467;
        Wed, 12 Nov 2025 12:09:19 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba8561sm97073816d6.61.2025.11.12.12.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:09:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <28109443-4bee-4ec8-b7d1-599ce1464da6@redhat.com>
Date: Wed, 12 Nov 2025 15:09:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/22] cpuset: fix isolcpus stay in root when
 isolated partition changes to root
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
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
> CPU 9 was initially listed in the "isolcpus" boot command line parameter.
> When the partition type is changed from isolated to root, CPU 9 remains
> in what becomes a valid root partition. This violates the rule that
> isolcpus can only be assigned to isolated partitions.
>
> Fix this by adding a housekeeping conflict check during transitions
> between root and isolated partitions.
>
> Fixes: 4a74e418881f ("cgroup/cpuset: Check partition conflict with housekeeping setup")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 96104710a649..6af4d80b53c4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2995,6 +2995,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it

This patch has been merged in somewhat different form.

Cheers,
Longman


