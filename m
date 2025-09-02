Return-Path: <linux-kernel+bounces-797181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C019BB40D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF1E1B63B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3EE3469EE;
	Tue,  2 Sep 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/DsrXo4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BA2E06EA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837294; cv=none; b=juTLUqdl14os/6zaMSI6Pjn/144/Ac1Nne+oVxYQyY2HnnSlxWPjdLAUinIlLhFTlV6pgbB0hwwb+jSkGVvQsb+8i0N9+6hGF6LSiL2/qxPjpw89YmOPF9/V9jREwZ2sCCCp6QK9nZBsnsAeZC9WGBM34edOKsusnBFYMTwgWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837294; c=relaxed/simple;
	bh=ujvP5ppYIq+mrTdhQyLILyCVzNShUHT9r5skpRwxy6k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hVbe0Ht9hTNWyEmNDDuA6WFyiNM/9gGiaJo95IqNZAhLky/GPCETh59h04E99QwyNpeDNDmsyzDq3Q3PRCEKRHkjBBtH3xMOGjgE4/AQbl6/UEbW71gi+8sClcWI8MSikP+nRFY8GqYu6HWLHcfNuq++eZL9UDRGP0AObrtxg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/DsrXo4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756837291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7RY1WsUY1lF18R/9EMCOt/PXAzdHUz71EA85shZ7EU=;
	b=F/DsrXo4rzdDekYGSrHrmA3wmJBTgO+gAg+rcriqaHJ0LEm6v2lJUdlDJ49sHf6WfT2EEA
	EJaoxSgBOIhIDB4Wdd4GX/CGhWWmy76LVfxagmVkiB2onMH7JpariH3i49jTPnx7LSxw3b
	rg8ZXPPc+tXXAj6kghMHfFrQQv/kv+I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-hydJvDV-O9SAajYrEKUTlQ-1; Tue, 02 Sep 2025 14:21:27 -0400
X-MC-Unique: hydJvDV-O9SAajYrEKUTlQ-1
X-Mimecast-MFC-AGG-ID: hydJvDV-O9SAajYrEKUTlQ_1756837287
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-807802c9c85so160321785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837287; x=1757442087;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7RY1WsUY1lF18R/9EMCOt/PXAzdHUz71EA85shZ7EU=;
        b=nbRvEPRCORTcRoHBQrv8YtSp9jcwQwhpEvMHMZ+6VwVKpywsaxarGVnmoqgSaX4j4y
         k7ZLr3TBhYkCIYaG8sV5R9R4FcYjqXxxla2CAIqzmv1d1JwUDnkzSM2BcXPJqpsgacOe
         neP78gSnzOOSfZNsTjkVtxR6ROydP2BtdaxV4Efgo7BhC6CTUly4MJiEqqhLOGy24A3s
         zElWroFL0NGdtD8asR+IMICy1nENoa72Z7Xj4XT4iC0xujPyEr06WhA5Ch2bkNlRtJhw
         MmrhVJRXC3vq9bteR/yGE7sYeh8AW4lzTrPwd49/T+kkJDnDPivEpQ3pGgZt0OLXD+iX
         tLFg==
X-Forwarded-Encrypted: i=1; AJvYcCXFAAvi9e+CPW1in0RG0lZnnNid9NPzWah5B6I0Am1MpU4ef7UUA5MHeehPhCKDhdCCzoZJCtht9KwfAww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYVjGbvyK8YUulBVPwtN69bpV/h1KooyGFN+nJKZaL6cZprDn
	VDpTf1NaNieRfnqBDQ6D72XRTk0A8En1OH1PZOtTbCha3Ht+5LmqG17V4F4e4JjOgkvrsja/vw8
	Z3Rm2Zc3c+2zXjGAh2ylAyi5OtIQUoP2mv4J/hcOvRHy2z+yP4cTWbqqSjSFBURdpOg==
X-Gm-Gg: ASbGncsBYAQz4jeTqbGC7csPh2Y6neBWp9t1Rr0Tzd8a1C+/Uqsg87eTq+8/HDjhMXb
	8uo0s00BsdrwAAK68LRxrMrV4HBVfZ1Sj0N2FS2I0SbKogo5xeUu08uMREZMMI1Xp3aeZX/Wbh9
	12ba0uhPwlhjnLzbyppzya26NFIXzXXrvPsUcaR7lPF8sDxfDsJXIVEY6sMmz9g/V3J8vr9/Xbs
	dwBH7925EPqoepvAdrlCUFeT74Cidqe+jl6RX9WXf2HiN2bDual1OUSxgODBTVAAo5a/sPGaG5V
	j1mUpH1YaqweJdjIJ3lst3Aark9ItsnJVPUh+3wMcRckqnzRXJYn5NDbiIEhOPgQ/e8jIhlyQiy
	JWWq2k7AwMw==
X-Received: by 2002:a05:620a:1a83:b0:802:6dc6:4f32 with SMTP id af79cd13be357-8026dc65a5bmr816926085a.78.1756837286777;
        Tue, 02 Sep 2025 11:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtHLm2OtG+zzbOosERCZVrDaqy0yh4F5L/NztF4x8PsJuHDw2CVmuA9sllL/wLi9X6VpZ5Mw==
X-Received: by 2002:a05:620a:1a83:b0:802:6dc6:4f32 with SMTP id af79cd13be357-8026dc65a5bmr816922985a.78.1756837286340;
        Tue, 02 Sep 2025 11:21:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-806975c37e5sm177580185a.10.2025.09.02.11.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:21:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <927f1afc-4fd4-4d42-948b-5da355443a4a@redhat.com>
Date: Tue, 2 Sep 2025 14:21:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
 <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Content-Language: en-US
In-Reply-To: <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/25 1:14 PM, Waiman Long wrote:
>
> On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
>> In cpuset hotplug handling, temporary cpumasks are allocated only when
>> running under cgroup v2. The current code unconditionally frees these
>> masks, which can lead to a crash on cgroup v1 case.
>>
>> Free the temporary cpumasks only when they were actually allocated.
>>
>> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
>> ---
>>   kernel/cgroup/cpuset.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 
>> a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 
>> 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>>       if (force_sd_rebuild)
>>           rebuild_sched_domains_cpuslocked();
>>   -    free_tmpmasks(ptmp);
>> +    if (on_dfl && ptmp)
>> +        free_tmpmasks(ptmp);
>>   }
>>     void cpuset_update_active_cpus(void)
> The patch that introduces the bug is actually commit 5806b3d05165 
> ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
> removes the NULL check. The on_dfl check is not necessary and I would 
> suggest adding the NULL check in free_tmpmasks().

As this email was bounced back from your email account because it is 
full, I decide to send out another patch on your behalf. Note that this 
affects only the linux-next tree as the commit to be fixed isn't merged 
into the mainline yet. There is no need for stable branch backport.

Cheers,
Longman


