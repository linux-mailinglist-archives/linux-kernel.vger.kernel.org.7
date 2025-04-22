Return-Path: <linux-kernel+bounces-613264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E739BA95A39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 02:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F52C16C9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 00:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649313B293;
	Tue, 22 Apr 2025 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVDCnjCy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982529CE8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745282123; cv=none; b=XAkO6CwkbfqywiCyVEUMjNJzziRNAHZwzPwduGuDP/hMGwCMoxH4w3J2jsLzv5PqFV+S+qIft03nbSxdgh68mhigJP5LN6tCT1L93LdUR89EqD3CceOXtXUYUKzOhWISTziOER4F8slq8jqaWmLqskIsTsPyU3eQeSpKaJUf2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745282123; c=relaxed/simple;
	bh=cKgR3+9PJB/50YfugU4/FB3a+w9fbcKAbpWtC5z89o8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e92mcpNZTsaQOWbbGHKzz6t1fZCWu0pd5HtARlYeEkHLW9vKbppkMNb2xv6OQktJujICP+9YPXeC//9vYw+Gw4EHxzBSeAdwKjvciLJfvOtgCgAGdzzuQhf4yI10ixk5JT+KFWZQJvTJ7gYYv9x+I+FOpG89mhCpw5FMKz2DToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVDCnjCy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745282120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zQBqgp3LCbgCzAboI9XQBdES5DPR7oeFpEx4guOZXE=;
	b=NVDCnjCyxL98r3D5cH7R0Rup0+CP6kk8iyfC33SPqhFK59nFCJau9hq49FMrHAZC5TGaXk
	WTKxXfTn8xhx0gYdD0XHmjL0DezOqnHdvc1T2Z5dniLGG2yb0/7ngLd01u5FyM23ZoR6A4
	w1FBcQXISfd8C4k9XxX0Q0uzjeWrilA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-SlLM0ttjPjGc44cMEnEGBg-1; Mon, 21 Apr 2025 20:35:18 -0400
X-MC-Unique: SlLM0ttjPjGc44cMEnEGBg-1
X-Mimecast-MFC-AGG-ID: SlLM0ttjPjGc44cMEnEGBg_1745282118
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-477647bd4d4so49818671cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 17:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745282118; x=1745886918;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zQBqgp3LCbgCzAboI9XQBdES5DPR7oeFpEx4guOZXE=;
        b=Tpw0rt+4hGmKolzFO4SIg7rvCc2TEOIaBMNS9ENEOoL9BIuTCCps3qP/trAovaePBR
         Lob9BJq4iaikfgUbc+0ZP33xhF3O1zI4pGr4Rh5Ym+UvAziIgQsLjQZXqXkrQTHtyzJI
         zLLgrALaX5AC0JPygZvKG1zdQpY8M05NzETqAfVrKD9wSXbZsTwUsACH2M51HLTbibrE
         SIpBMCz/Ozt9RKqWcYgfSgtxSov7RSsfxsEfmwqlF/bQFI65A+3NgcCFQaeYXmeWz/gN
         qUeFuhWBUlruOhIkM/ZsFKSekdn0mrBqxbPpMmEeMsdM9HczMY6zzL9PBCj1O4KrPuMT
         rJYA==
X-Forwarded-Encrypted: i=1; AJvYcCV4STeKwo0zg5dEwDo/r/sYDPLe4FazLKfykAI6Twjwx4qS5uj0YOMmGh08gevIaUNTJ7aQED2WQbKBzaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5narYUmyVAlfnFNXyqzDyx1tPHBTZej1Zgww4GrS/HRl++EZ
	5l03m13cF9dytw8f/1F9IcmtC9YQ6aI5075t3Cg3qfgKbMPDFXd/my3saz55iaDy179Hs2VtMQF
	ylexui/uMW0VDmNEI4qB1xT/u8KuM+CSUi2fahdWRCbbSo9lmfabTYglu3J58aA==
X-Gm-Gg: ASbGnctwX5/0+Jqvsd9AV+/Ec18w7AKRDrGu/8T33PN7LQGeGLbOH1ldAFQD0mgLsWq
	e5cT7TYXGpz0YM+zDzt+9JNMmzuhYQRf2TU7QpyS838FAqLEWZLGlIiUh2Hp9+2+SRbNH3OxrNC
	xattxE/vpoN0/vgiiWm/28g7wxF91rT+DsJgOGtNXGbgQeK/FKMd7xvVWDlx/Oa6iMRqJfPDtTU
	pXv7nSgT8B1tckdhxZGOCfOl3kkWJKeYSE+DmrLqL8QosPFHe2A1xxI8oRrEeKAFaqEIt/akyf2
	igw7IQYPVUArYfjDNMaRC3xrif/w+nI5Fsj6zFAsnOhnu2aRxcvD2iDhYw==
X-Received: by 2002:ac8:5fca:0:b0:476:75d0:a1e1 with SMTP id d75a77b69052e-47aec393d49mr207680271cf.9.1745282118186;
        Mon, 21 Apr 2025 17:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3REdENZgnJTaxkrRF1AqZKfhF9AAt5zCkgw2tWo6ZEkKm30J1Vx/N9effiYs8J2qc3GWbLQ==
X-Received: by 2002:ac8:5fca:0:b0:476:75d0:a1e1 with SMTP id d75a77b69052e-47aec393d49mr207679981cf.9.1745282117841;
        Mon, 21 Apr 2025 17:35:17 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf7357sm48788181cf.66.2025.04.21.17.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 17:35:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6e7806a7-9ffd-4c7c-b247-934b206088c7@redhat.com>
Date: Mon, 21 Apr 2025 20:35:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Waiman Long <llong@redhat.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
 akpm@linux-foundation.org
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
 <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
 <aAbbtNhnuleBZdPK@gourry-fedora-PF4VCD3F>
Content-Language: en-US
In-Reply-To: <aAbbtNhnuleBZdPK@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 7:58 PM, Gregory Price wrote:
> On Mon, Apr 21, 2025 at 04:15:49PM -0700, Shakeel Butt wrote:
>> On Mon, Apr 21, 2025 at 06:59:20PM -0400, Gregory Price wrote:
>>> On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
>>>> On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
>>>>> On 4/19/25 2:48 PM, Shakeel Butt wrote:
>>>>>> On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
>>>>>>> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>>>>>>> +{
>>>>>>> +	struct cgroup_subsys_state *css;
>>>>>>> +	unsigned long flags;
>>>>>>> +	struct cpuset *cs;
>>>>>>> +	bool allowed;
>>>>>>> +
>>>>>>> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
>>>>>>> +	if (!css)
>>>>>>> +		return true;
>>>>>>> +
>>>>>>> +	cs = container_of(css, struct cpuset, css);
>>>>>>> +	spin_lock_irqsave(&callback_lock, flags);
>>>>>> Do we really need callback_lock here? We are not modifying and I am
>>>>>> wondering if simple rcu read lock is enough here (similar to
>>>>>> update_nodemasks_hier() where parent's effective_mems is accessed within
>>>>>> rcu read lock).
>>>>> The callback_lock is required to ensure the stability of the effective_mems
>>>>> which may be in the process of being changed if not taken.
>>>> Stability in what sense? effective_mems will not get freed under us
>>>> here or is there a chance for corrupted read here? node_isset() and
>>>> nodes_empty() seems atomic. What's the worst that can happen without
>>>> callback_lock?
>>> Fairly sure nodes_empty is not atomic, it's a bitmap search.
>> For bitmaps smaller than 64 bits, it seems atomic and MAX_NUMNODES seems
>> smaller than 64 in all the archs.
> Unfortunately, it's config-defined on (NODES_SHIFT) and the max is 1024.
Actually, it is nr_node_ids that control how many reads are needed to 
scan the complete node mask, not CONFIG_NODE_SHIFT.
>
> Is there an argument here for ignoring v1 and just doing the bit-check
> without the lock?  Is there an easy ifdef way for us to just return true
> if it's v1?

Your current patch is ignoring v1 as css will be NULL. It only works for 
v2 with a unified hierarchy unless some users explicitly force cpuset 
and memcg v1 to be in the same hierarchy. You can certainly ignore v1 by 
using cpuset_v2() check.

Cheers,
Longman

~Gregory


