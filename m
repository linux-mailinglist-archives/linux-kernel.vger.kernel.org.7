Return-Path: <linux-kernel+bounces-786974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B789B36F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B8207BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AB21CC60;
	Tue, 26 Aug 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR/KC4U3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241631A550
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224420; cv=none; b=Aso9V0YQWBsrrS4AYwDeH68FXtRyWb7nDNCraJk3ZlJ4JV0Usoj0Aw0SCfsHxDPPVVR5m+dfKFzhWLyMrzVqsPHGglkq5g0+7cp0gCShIPIOLr+sOp6fv+dq6lPfz5xHFSCTfc3infFwKXwG00aesAgWV8++zv/CNOLvAi0JhnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224420; c=relaxed/simple;
	bh=NXzXQw4Zt6Em+yckX6q/jojHBegK12Bp1ww6CHFGn3w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cy7Es0ifg/7MBx2iGx9E8qfX2DIHnDGoWJONkqVoP3SK1ykuqzRSKS5g3iNZaCrKtiEnlWFrHw6JIeGAafwLUC4d+7BqK1ffk1pgg1wX7hfXpqNX2Ju8PZTSnKZlcCw7Z8TWR+n6p20FjasPVos2XigiDUDbUYdhfcc+0j8h38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR/KC4U3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756224417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRIEwoyk6U3gj8I8qpF/P/UU9F7Za9uOXepaDGpaelc=;
	b=NR/KC4U3fwP3FpDxtXFuRKCWNnac2u6k+bHVZFp3jmcEC83UUvaJ4yxPhnZHMDE6+2iVmS
	rhB+4J/rzaAY74jw2oV5gAXEPr48rqLDLxs3HJAc65AE/UVGF4/UIV6A07B9ZYcL/eBZA5
	SeFFfxb/knNgXq47rGH6oK+ueawiDHQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-XF5iBYPCP7W7vzEbPytRlw-1; Tue, 26 Aug 2025 12:06:56 -0400
X-MC-Unique: XF5iBYPCP7W7vzEbPytRlw-1
X-Mimecast-MFC-AGG-ID: XF5iBYPCP7W7vzEbPytRlw_1756224416
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-72112230256so13139427b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224415; x=1756829215;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRIEwoyk6U3gj8I8qpF/P/UU9F7Za9uOXepaDGpaelc=;
        b=F4PIylSxiLjUWkKm20LhQ+yQDQiV2KW6pfWIFtIiTajWdLo3Qv56MaoIbDwi41Qcwq
         KL2xuWmKaf7tk9IeopIXBo10aJiciQKhnoVbnVcE0zvCqpDIiGDEwvnPHn1gsA8c0i06
         5VAULAWZPHD96W6R7NgCUiGoLX/YDyExx/7vDE5R9uGq7zs6gDH/BUvxgb2d5ldJQVcz
         CfxkARddg80vD0y/UxzuUUrQfYwblbz9/FbcE+NiAne+kG2/58jS+Uw4S0fSXtPZgrVL
         sW+Jj5ufE+sVn+GkqMyXcxTVXqmPDo61lhnef5du9ssHuGOPgJhbEADFiAk5anfdttm5
         hBqA==
X-Forwarded-Encrypted: i=1; AJvYcCXNrJVRylhGJ3zUycarJAhLe3xdk+e3pqtgSUV2lvrOBFrlaivkfnthXHrb1ae8biaCA10zHugbvcIHw88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHl/VTw8cE1eAvHj5NY418xGe7YjIdiaObFODlHxV6k8TyiaXC
	WmXaJVOBCa+eUibE1rhWTquGs0K1MvBMoPiqONQBbPYkCqthRzuBQJFpZNXtuMuSIe1h0CIqE30
	Z1rJoLEoZD0xbjA0NNlvTrnyKsW/a8sfWcekmdy3Te/zm1CM5cMjVRleyD2kCub5s0WSMR8PSvA
	==
X-Gm-Gg: ASbGncsD9vIC8VspfTVUagLqjgFsHKehv7VTFt0WSbaVFPSUNW6rcFVxM6mSScEjGq2
	PsyudcvfD19EaH36lYHdjUyvE7WGAMs5OMIGRtvCF819Ir9bG4XkoVcIeKuzE4/h9qF8VpoBMqv
	tofKYInXXaw3Q/pi7hftbs5Xb5TH6m5c5V3asH8enfZEaGV/M7CEgjXUmA//PMc8kDuSP5H4rJs
	3++PSY985HawLyOQN081jyKj4uCyA6mci3wSGzDQVx3Q5AX38QMaQ5zMEZSHOv14aOdqGsChn31
	VItMOA15DC7UOFWX0A2VNE0NVltZkhUedHmB0Vyf2myXDrsxM/Y9xQ0HNTBiSak+8XH0hxnt6gA
	I76mmznPs1g==
X-Received: by 2002:a05:690c:9408:b0:71f:ede3:fc40 with SMTP id 00721157ae682-71fede401f9mr124796637b3.40.1756224414527;
        Tue, 26 Aug 2025 09:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFnKwjMtJb1I/GUzeDWlV9jGDybHVkg/0iCUr2vSxDmHSySyqwLLofo6fDGwKkUM8vVe/X6g==
X-Received: by 2002:a05:690c:9408:b0:71f:ede3:fc40 with SMTP id 00721157ae682-71fede401f9mr124793067b3.40.1756224408326;
        Tue, 26 Aug 2025 09:06:48 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7212cb28226sm5154357b3.15.2025.08.26.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:06:47 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8907b39b-6d30-4b56-b358-d63f9f625993@redhat.com>
Date: Tue, 26 Aug 2025 12:06:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250718164143.31338-1-longman@redhat.com>
 <20250718164857.31963-1-longman@redhat.com>
 <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
 <9bd275be-45df-47f3-9be3-f7e1458815a4@redhat.com>
 <nqes55hiydw37qpt5mrqwzyhan5nxlzvuoccei4hmjloccr5xr@aqkuqerfwomc>
Content-Language: en-US
In-Reply-To: <nqes55hiydw37qpt5mrqwzyhan5nxlzvuoccei4hmjloccr5xr@aqkuqerfwomc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/25 10:25 AM, Michal Koutný wrote:
> Hi.
>
> I had a look after a while (thanks for reminders Ridong).
>
> On Mon, Jul 21, 2025 at 11:28:15AM -0400, Waiman Long <llong@redhat.com> wrote:
>> This corner case as specified in Chen Ridong's patch only happens with a
>> cpuset v1 environment, but it is still the case that the default cpu
>> affinity of the root cgroup (with or without CONFIG_CGROUPS) will include
>> offline CPUs, if present.
> IIUC, the generic sched_setaffinity(2) is ready for that, simply
> returning an EINVAL.

The modified code will not be executed when called from 
sched_setaffiity() as the SCA_USER flag will be set.

In the described scenario, sched_setaffinity() was called without 
failure as the request was valid at the time.

>
>> So it still make senses to skip the sched_setaffinity() setting if
>> there is no online CPU left, though it will be much harder to have
>> such a condition without using cpuset v1.
> That sounds like there'd be no issue without cpuset v1 and the source of
> the warning has quite a telling comment:
>
> 	 * fail.  TODO: have a better way to handle failure here
> 	 */
> 	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>
> The trouble is that this is from cpuset_attach() (cgroup_subsys.attach)
> where no errors are expected. So I'd say the place for the check should
> be earlier in cpuset_can_attach() [1]. I'm not sure if that's universally
> immune against cpu offlining but it'd be sufficient for the reported
> sequential offlining.

Cpuset1 has no concept of effective cpumask  that excludes offline CPUs 
unless "cpuset_v2_mode" mount option is used. So when the cpuset has no 
CPU left, it will force migrate the tasks to its parent and the 
__set_cpus_allowed_ptr() function will be invoked. The parent will 
likely have those offline CPUs in their cpus_allowed list and 
__set_cpus_allowed_ptr_locked() will be called with only the offline 
CPUs causing the warning. Migrating to the top_cpuset is probably not 
needed to illustrate the problem.

Cheers,
Longman

> HTH,
> Michal
>
> [1] Although the error propagates, it ends up without recovery in
> remove_tasks_in_empty_cpuset() "only" as an error message. But that's
> likely all what can be done in this workfn context -- it's better than
> silently skipping the migration as consequence of this patch.


