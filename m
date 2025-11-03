Return-Path: <linux-kernel+bounces-882228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D723C29ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6096347C68
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132B28750A;
	Mon,  3 Nov 2025 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTHY9x+z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PujspCJK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C119D065
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139563; cv=none; b=mLhTz7/7q85GCiEv0s4HnjXOfMk1evAXWqXEI9Zpgvt4PKOJsct+nOjsqStcOl+pbo0j0W0lRvcV9l2v4BrT9toj1Kx+QdrpbS8PLzQIdFYHWhX1E6fgoYY0T4MBKgHdYU1dy3rtws0zy1JGZTXPy3qhGjuCuWVilfo2OawgF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139563; c=relaxed/simple;
	bh=S5lhzElP8mKmku7HndUOsllDqxcCj00rLtLHo93bS6U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E5A954SjozMqDdb6ObMKd5AKOoCWzHt7NMRIdrbbqANRV9J0f+sd2PH1c0fKWlSCpNUaBroOaleNGBoMhNL968tOY42bfQR4QeJE/saPwHIQdKUEE34g16PmPAmvuyMiNm4bwYh+Go4U3U2MKjbGJ5NYRqvDdppnI0qYoyGSC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTHY9x+z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PujspCJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762139559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfdEr1jxJKtYpq9KoY5qe0Z0hYY/0s/1RnPyyPEXS34=;
	b=OTHY9x+z2o8xACLodO7hrqmacgADuXqF4y5xb+ClQvOad+OAq9LpmS4cL/AC/+FGIQfZ6l
	ebdIIfhsUrUWSx0Eve2bvAZEjmqq2eoGiryFtTRTLck7xs5cnp+XZh5nCUUq97xSXrPJKU
	0wm25Syz8HdVlgG77Bz3X3HS+Soj6lY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-CRas426IPmW27uTuYgq3vQ-1; Sun, 02 Nov 2025 22:12:37 -0500
X-MC-Unique: CRas426IPmW27uTuYgq3vQ-1
X-Mimecast-MFC-AGG-ID: CRas426IPmW27uTuYgq3vQ_1762139556
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8805713e84fso15466466d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762139556; x=1762744356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfdEr1jxJKtYpq9KoY5qe0Z0hYY/0s/1RnPyyPEXS34=;
        b=PujspCJKr5I5ja9cvUq/6AWaku4kgiIl6jbYNFJb32J7efL/FKhOnojvOVdfcejuih
         1tjdBv5I1NWhZx/QLIpC/9yuCq6SjVx1hMg28jGMACrjxGxtQx8nqitanQ2GC+jnXFSM
         KrNI82xRtgpAupxqWE0IV7nXw+Ly+q5rfJZeT1KCX0BjE/5emRqZv+EIzMxowZLy8LcZ
         gq5Q9Xf8uLxBdakFeKceb0HWlDKzhiBBeF7rpRreInjTkhNY1ZJEdh4/RwOiHy2AHDhr
         Hx0FxsVxXVVOIb+ZtcujEUrthDb05JhW4Qiv+eVcvGLujJ7exZOF9lpoUa12zbliPz+m
         XRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139556; x=1762744356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfdEr1jxJKtYpq9KoY5qe0Z0hYY/0s/1RnPyyPEXS34=;
        b=P/Q1NFf0UGboNgXQPvGgy8rdjLyNDTArylbYrfW3v33ob2gCsb7Aoqky518xlP6jLE
         IVc34Gv8JivAN+5bRWY9xGfSuFZvMqC/iprPzxKOwFJ1UExjfijXAmr3XuuhjqcnonhO
         7Gi5Q598NXdUNuoS3hA1J9Ocx6iCSBWj6xrCtfl6SOivuxqA+zDOLWlGV9PEQzcgutA2
         pntcgM/EafQyPTJPfTMrFAhwJPlx+PkV4LmFjJOspLOaOnU0oXVPg5w7GuAVLw6dYgdy
         4Diq6NBZHzvtuXDy/x5HfoPmBiVqJzb9NSjTYzeluI8iyFDaKLgVfhiiWxSCjiJJENS4
         HPIw==
X-Forwarded-Encrypted: i=1; AJvYcCVlS7Guv+226zqOi0YqDjVmsFDiQdWSttItNlaR5GV9cyx9qEhVZkvhP2yk92+Kbv/fUaEtUf0PfuRwmGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNNeF18/3qXrHVrrnHCFoQJSLbMokTDY7dRF6+x/XcpP7Hdvu
	/HpCCecQPvA7Vl+rSlTRExpzG/sy9MKpEbKi1Zi1ZxiSW4MAz8coey1kxEET44lkMrE2+G2Jdrl
	ehsF5CAPY6JG70SZV+/DQ71c+2OBWFRQ6ZNwmGAGyObLLLLnNrs4VWpxk7A/p6HErQA==
X-Gm-Gg: ASbGncv/0tGhQaaQmzLwdFuj9bVun6KAA+oKDARAryGsUfpX6ilwaPZAjy/pe6ALtEo
	UyyNtN+NsGxB/HVNDJGlp0riZtiu0S7uf4XUHkvUbQmJKIB02IRHSyDkqAFxCRxMYZoVx54TGDc
	SdxoMTqYrEOkctsMWHCLfAgTt3mjUYePgLIZFypVq1PaS9MDRBrZWRBu0nyTrnz0Zw5vJJABcbb
	e48SLegvwab6/eXj4hP3oir+mjL7xTDLRm6a8YwcSHtphk8xQKFARINz28cSpFG8ZDUMvZ7/5Wi
	7f/Kwl0Hds4W6Yxqy6vY2HyS4RhAFLLKBOXCTHp0IpqalHArpW/FwwFo7AOFSL1Vx4uCDDqGaT6
	qDwzu1VmOCA1zPZ6SjhqVsKWBmeBPEyqF1IHO5s4X6zjzFw==
X-Received: by 2002:a05:6214:d64:b0:880:4f33:4666 with SMTP id 6a1803df08f44-8804f334d94mr58782996d6.20.1762139556262;
        Sun, 02 Nov 2025 19:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcfeKBmG70eDimSeDmwKwC562nYZpblijcMB08FrdeomYXqHJAlEgptfXX8UOLwzXJtatUYw==
X-Received: by 2002:a05:6214:d64:b0:880:4f33:4666 with SMTP id 6a1803df08f44-8804f334d94mr58782786d6.20.1762139555843;
        Sun, 02 Nov 2025 19:12:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8804ba4b832sm31857146d6.36.2025.11.02.19.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 19:12:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b34dc762-5a90-428b-815f-0c2b351078bf@redhat.com>
Date: Sun, 2 Nov 2025 22:12:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
 <8da89966-b891-4088-9699-e82863e52415@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <8da89966-b891-4088-9699-e82863e52415@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/25 9:55 PM, Chen Ridong wrote:
>
> On 2025/11/3 9:34, Waiman Long wrote:
>> From: Gabriele Monaco <gmonaco@redhat.com>
>>
>> Currently the user can set up isolated cpus via cpuset and nohz_full in
>> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
>> domain isolated nor nohz full). This can be a problem for other
>> subsystems (e.g. the timer wheel imgration).
>>
>> Prevent this configuration by blocking any assignation that would cause
>> the union of domain isolated cpus and nohz_full to covers all CPUs.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 67 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index da770dac955e..d6d459c95d82 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1329,6 +1329,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>>   }
>>   
>> +/*
>> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>> + * @prs: new or old partition_root_state
>> + * @parent: parent cpuset
>> + * Return: true if isolated_cpus needs modification, false otherwise
>> + */
>> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>> +{
>> +	if (!parent)
>> +		parent = &top_cpuset;
>> +	return prs != parent->partition_root_state;
>> +}
>> +
> Hi Longman,
>
> I am confused about this function.
>
> Why do we need to compare the partition_root_state (prs) with the parent's partition_root_state?
>
> For example, when a local partition is assigned to a member, I don't think the isolated cpumasks
> should be updated in this case.
>
> In my understanding, the isolated CPUs should only be updated when an isolated partition is being
> disabled or enabled. I was thinking of something like this:
>
> bool isolated_cpus_should_update(int new_prs, int old_prs)
> {
>      if (new_prs == old_prs)
>          return false;
>      if (old_prs == 2 || new_prs == 2)
>          return true;
>      return false;
> }
>
> I would really appreciate it if you could provide some further explanation on this.

This function should only be called when both the current and the parent 
(top_cpuset for remote) are valid partition roots. For both local and 
remote partition, the child cpuset takes CPUs from the parent. The list 
of isolated CPUs will only change if parent and child cpusets have 
different partition root types. If parent is an isolated partition, 
taking CPUs from parent to form another isolated partition will not 
change isolated_cpus. The same is true if both parent and child are root.

You are right that this check may not be obvious for a casual observer. 
I can add some more comments to clarify that.

Cheers,
Longman

>


