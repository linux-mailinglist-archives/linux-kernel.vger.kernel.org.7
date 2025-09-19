Return-Path: <linux-kernel+bounces-824909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8361B8A734
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED917A88CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385331D75B;
	Fri, 19 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLFK8rH6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72331CA72
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297408; cv=none; b=TZ4BT0BF1p8Cd2I76nHErQiry9qNilpZ8jETXV68m4sbLcEKL9hZqxu95Hkltb0T63FHc2kvCunhrVhM/8JoG8CcVZ1NeyoSmwjS90ZyCmC9yNlNuukBz9/eU2Ft8AvN1PFBSa2IIVcc/MXDs8FZ3siteTJc0bNSxKpX7GOylqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297408; c=relaxed/simple;
	bh=D0R5kVCxPQIDn/il8Ta4k7mCVYofZw2cjllgDPoACfM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F4d80RJ5CfTwLS67KdCbYZ2+JQTKpBpBnusSpdwzmgKkSBlR8qWbaY1jlHfjFrBH7L5AZAdOZHpiiyzwJMIXQcxHOaDPtjhz9MkPtAkSqjiDivwFxqJQanxFm9lhlToDVsWTh19YZV551ejECeS9XVbbmqCFUgBoKiaW4NByY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLFK8rH6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sHkXx4w+OoPaSwn+jcuJrB3W8WiBrbLAHFAMNdkKp8=;
	b=gLFK8rH6UXOCB9FMFOnayEYHJnf4HjF63kE+cJktPGXeq0/rEHWG3pcgWS1jk/XYarGx3l
	TUWVKj3DDZp5h+tz6MUAsNiA9hOVRhIXqQw1pDOIbZSfr4dtrJlQcbvIFjtC9tLueOt4qY
	Rx3xFHxHCT/rJEKcyEPJb5Fa+cFUA0Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-yM3BTRLcMW6xyFNeGbGCiA-1; Fri, 19 Sep 2025 11:56:42 -0400
X-MC-Unique: yM3BTRLcMW6xyFNeGbGCiA-1
X-Mimecast-MFC-AGG-ID: yM3BTRLcMW6xyFNeGbGCiA_1758297402
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so39120041cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297402; x=1758902202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sHkXx4w+OoPaSwn+jcuJrB3W8WiBrbLAHFAMNdkKp8=;
        b=jys8FaPZdYkGdEqMoitQHwecyvu8iUtnFwPWQEyq2XNumB8VXnn4UclxAGOg9UNYDB
         PMevzAYaChoUqpcRXeL3T4CBtHKct/CueLd6QjTmstnpAcwkB/kuJS7uW3954l1XXGrV
         HA5yMZ/URCbN6SVZKa2EjPVVcKkYftH+Ifi+CrA+aYUgw6U2DIRDsX/SlJ6RLvmBU9PY
         nqkaoVMmvrCYpJqxzgFOK713X0DvziuiNq2OBDV2z9clWEV/ljhxXeHgUIUnR7lB2ZV8
         OsKUOfypvQVn/RE2jw7+8nghLdCelZ5A0z1NbnRLktSwEPgaCk4qvmLg0dvs4Qgqjelw
         ABlg==
X-Forwarded-Encrypted: i=1; AJvYcCWWRQrqOmq44sSulYskb7HxcqJ+smQUi+wf83nkaye8s56WcGVCJ+/9EGlAw2GqLt+gzQsddW470lXdpWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovrLZrWM/or1D9rMfCtNAxhivykGcUo5gW+8H/rrR3o6oTAjP
	BAoPyJ+K/UYHNutzFPJi0b3d1D25RXZf5rcLj58uV4/n2b+JO2hITnEq8rzLFBf304y4vvOReRL
	Tg4gRFGshwK/End1w78PMKDdkIB5qHlWvrO4bl+SHSpQptQ/ay5JHsAKjEz5sEE8TxA==
X-Gm-Gg: ASbGncvIHo6j2TEc1mVH1vGy2G5Q9SYoMf3gu0v9nTPVg7PlYLBOmRLIy8Eoz5qC8FJ
	KnDXjaRDgbZGxzC5MYEQm40PkkqhcMwqtib8m+dI4iVHHDMVNMxL9OvnIR6ywlVs+fkMnuazIAM
	uxHeQsalkP+OCERVv2WVUwmo3XTILCePWBDVFENKMNuPFjl1llIUaPQYcZJdOysmnadbT+7v17U
	mnwcKDRm0hxfxeFrGdBgRZ0/AA0/06lDMRmoz7H6MIIwdq4laGVDX6lhTrInFnUQMhbayGKlCKX
	wBGc43aFk+3fV6dQC6jsdSjDeqPKxxXxBeV8kqXx
X-Received: by 2002:a05:622a:1f85:b0:4b7:a80c:8862 with SMTP id d75a77b69052e-4c074b098a0mr46911221cf.69.1758297402209;
        Fri, 19 Sep 2025 08:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh71Li8WLeUmgSV4Dl+4mfO+VS0fxYClCgrplm39AM+j63r2SJnEhs5cDod2uOJst3FG4CPg==
X-Received: by 2002:a05:622a:1f85:b0:4b7:a80c:8862 with SMTP id d75a77b69052e-4c074b098a0mr46910821cf.69.1758297401714;
        Fri, 19 Sep 2025 08:56:41 -0700 (PDT)
Received: from [10.192.63.20] ([204.8.158.106])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda9bf16f1sm30439431cf.44.2025.09.19.08.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:56:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0d6a0288-33a9-4dec-8dae-1e9dc3f75185@redhat.com>
Date: Fri, 19 Sep 2025 11:56:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next v2 1/2] cpuset: fix failure to enable
 isolated partition when containing isolcpus
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250919011227.2991696-1-chenridong@huaweicloud.com>
 <20250919011227.2991696-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250919011227.2991696-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:12 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The 'isolcpus' parameter specified at boot time can be assigned to an
> isolated partition. While it is valid put the 'isolcpus' in an isolated
> partition, attempting to change a member cpuset to an isolated partition
> will fail if the cpuset contains any 'isolcpus'.
>
> For example, the system boots with 'isolcpus=9', and the following
> configuration works correctly:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 1 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated
>    # echo 9 > test/cpuset.cpus
>    # cat test/cpuset.cpus.partition
>    isolated
>    # cat test/cpuset.cpus
>    9
>
> However, the following steps to convert a member cpuset to an isolated
> partition will fail:
>
>    # cd /sys/fs/cgroup/
>    # mkdir test
>    # echo 9 > test/cpuset.cpus
>    # echo isolated > test/cpuset.cpus.partition
>    # cat test/cpuset.cpus.partition
>    isolated invalid (partition config conflicts with housekeeping setup)
>
> The issue occurs because the new partition state (new_prs) is used for
> validation against housekeeping constraints before it has been properly
> updated. To resolve this, move the assignment of new_prs before the
> housekeeping validation check when enabling a root partition.
>
> Fixes: 4a74e418881f ("cgroup/cpuset: Check partition conflict with housekeeping setup")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 44231cb1d83f..2b7e2f17577e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1806,6 +1806,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		xcpus = tmp->delmask;
>   		if (compute_excpus(cs, xcpus))
>   			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
> +		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>   
>   		/*
>   		 * Enabling partition root is not allowed if its
> @@ -1838,7 +1839,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   		deleting = true;
>   		subparts_delta++;
> -		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>   	} else if (cmd == partcmd_disable) {
>   		/*
>   		 * May need to add cpus back to parent's effective_cpus
Reviewed-by: Waiman Long <longman@redhat.com>


