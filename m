Return-Path: <linux-kernel+bounces-589223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60284A7C355
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 20:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85B81B604B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9621C184;
	Fri,  4 Apr 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgOtWSKm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4619CCF5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792942; cv=none; b=kDfSiPQKhkXmA+TzOdnRFWRXaIXx+kntubP7QNWoqSJqy6VstBDW7WJ63HWiZ1HPcwQfd07dO+TQ+GV6+ZCA2Bv7e931METMJt3Py5rwTJY2e1dFuft60NKKlj8nVbLYBCZpXh92n6bftVb30R30oLvpkcdOnofA36qm/KCyYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792942; c=relaxed/simple;
	bh=XnDhVT1x83AsNY8OZJgr6vEU6u45rQkuQM30F7imBpU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UtR089yTzVLgCvp9gLlCDk6nWDhKNwQ5aBrcSYNGHiv8gSxl+ik8zmOTL7QHG+dsPbRc1BV9mz8APxCJkc1E8yfznxT3uV7ugV3dEscnOVZW/5TRjzuk7z9UhSpwF9s8nWpe5xb/P5B3+qJuDVXgWfk9KoZ50xHAOnBFhgaqHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgOtWSKm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743792939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJ+WDACAsHxbVWot9DqTlvwAc/91z/vLEjznERJRGEA=;
	b=hgOtWSKm3RoQwBo5KMLmnYYzz4kx5MiI2MqSlCOSBix4MJ6/DZmxDz0qtGCQT4FKInV90O
	KJEOD1kO9TRYc4BX0wWJue29FM66dqwrAG4edqToEjtXNa9jmFHMKxT0ADyykZB6ShJePm
	3IeWi6hqkqV3mQ3RmgcFll7btFZ2iJ4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ycE4IAYuMU-Gp0OCTxMyvQ-1; Fri, 04 Apr 2025 14:55:37 -0400
X-MC-Unique: ycE4IAYuMU-Gp0OCTxMyvQ-1
X-Mimecast-MFC-AGG-ID: ycE4IAYuMU-Gp0OCTxMyvQ_1743792937
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54e7922a1so483762585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 11:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743792937; x=1744397737;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ+WDACAsHxbVWot9DqTlvwAc/91z/vLEjznERJRGEA=;
        b=YbEjAtP3bxhEUyoh/nJp4xY3QD1mpMCe41CieA+FjiO2OVb/cNfJEKATQ0WjkTMbvY
         j68FsmVu9iGvGAg/f6jXG88v4OghlkVSPhXiZD4jGufEx5SvvCNfqHaYA30F5t3lz0jY
         8r2e9Ur0R4wH4BidTlalqanW0oHLkEZBcxNpuuNsi9VOjN5pMga2/keUSIjuZg1r46Aj
         r6FHs7CHyXqLFNY2vG57aSgn6h2CSaJGxrdwOyM/L4e2gUdC7O1EzH9UDImCTJ2q6vMx
         Id5k8pIB7tJHEMM8X2pUasP/GIqbvvqe7PIVBje+NJ3qNOBrzIvJDkztNnG/f1deNtgC
         byTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDy4wKiyLwYbWvkTCify2giM2nLLkur5oJWZEj1Uz7DAZcQBCVwMTPJS0tAu/jfOh+LA57zQlMpcbS2WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyizMySSDjoBycJU6mqpbeEbbBQKfHuD4n+Mi47YBgRTobmr6uT
	usrkiGdTB/cQmG+VGkNRg4pLQHIyxxAiMtx9oNiFGXbbpCP+lqtiQKysMtuk0R3UU8rswEv5tK+
	iScSknoMQXcvY7OCmVyKs0XuFE22M6XYVNo5E3kMSz3cKTM30g4BCb//7QjBrLQ==
X-Gm-Gg: ASbGncsbaYm2kyORriJ893laBv9csiObicqEz4K4R15zi2xX0jX+8mq3XD5TBQ6hPB+
	xbRnpEeWuN8FTyExSntvXGjTPOES68dIjEPXIfIvUacOXT2Z0UR4UGaU6erk3+avCHB+i7OL8eC
	NB8EKNJH2Q9Gx3XkzhxHpQmXuUTPig0iRcAfIeZlus3YRUzWGXz2hSsqG8/QixzjiZ9LJypvvFg
	+T6NqfF3Fu4ykHlpucSdz7WPBL8S1o91zpzRqSiVEPqNgVO92/jG/NmioBV2HpZiFFzlCSZFWte
	5RwcNPNMA5IB+/9qodtYtSkI8ffPFf+Y6G34j+JLEz1PmOCmRXSonxI4dRGeyQ==
X-Received: by 2002:a05:620a:d93:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c774d6fcd5mr576731285a.26.1743792937393;
        Fri, 04 Apr 2025 11:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1GWz7ZoZU1D4Cwc3QUuGir5Wj6Kdn7kWMfIbYb7f8OvFkQTHaKFBY0OhVoifakryu8wvgkg==
X-Received: by 2002:a05:620a:d93:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c774d6fcd5mr576727485a.26.1743792936962;
        Fri, 04 Apr 2025 11:55:36 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f1393fdsm24772476d6.89.2025.04.04.11.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 11:55:36 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4294852-cc94-401e-8335-02741005e5d7@redhat.com>
Date: Fri, 4 Apr 2025 14:55:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
 <20250404181308.GA300138@cmpxchg.org>
Content-Language: en-US
In-Reply-To: <20250404181308.GA300138@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/25 2:13 PM, Johannes Weiner wrote:
> On Fri, Apr 04, 2025 at 01:25:33PM -0400, Waiman Long wrote:
>> On 4/4/25 1:12 PM, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long wrote:
>>> ...
>>>> The simple and naive fix of changing the operator to ">", however,
>>>> changes the memory reclaim behavior which can lead to other failures
>>>> as low events are needed to facilitate memory reclaim.  So we can't do
>>>> that without some relatively riskier changes in memory reclaim.
>>> I'm doubtful using ">" would change reclaim behavior in a meaningful way and
>>> that'd be more straightforward. What do mm people think?
> The knob documentation uses "within low" and "above low" to
> distinguish whether you are protected or not, so at least from a code
> clarity pov, >= makes more sense to me: if your protection is N and
> you use exactly N, you're considered protected.
>
> That also means that by definition an empty cgroup is protected. It's
> not in excess of its protection. The test result isn't wrong.
>
> The real weirdness is issuing a "low reclaim" event when no reclaim is
> going to happen*.
>
> The patch effectively special cases "empty means in excess" to avoid
> the event and fall through to reclaim, which then does nothing as a
> result of its own scan target calculations. That seems convoluted.
>
> Why not skip empty cgroups before running inapplicable checks?
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b620d74b0f66..260ab238ec22 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5963,6 +5963,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>   
>   		mem_cgroup_calculate_protection(target_memcg, memcg);
>   
> +		if (!mem_cgroup_usage(memcg, false))
> +			continue;
> +
>   		if (mem_cgroup_below_min(target_memcg, memcg)) {
>   			/*
>   			 * Hard protection.
Yes, that should take care of the memcg with no task case.
>
>> I haven't looked deeply into why that is the case, but
>> test_memcg_low/min tests had other failures when I made this change.
> It surprises me as well that it makes any practical difference.

I looked at it again and failure is the same expected memory.current 
check in test_memcontrol. If I remove the equal sign, I got errors like:

values_close: child 0 = 8339456, 29MB = 30408704
failed with err = 21
not ok 1 test_memcg_min

So the test is expecting memory.current to have around 29MB, but it got 
a lot less (~8MB) in this case. Before removing the equality sign, I 
usually got about 25 MB and above for child 0. That is a pretty big 
change in behavior, so I didn't make it.

>
> * Waiman points out that the weirdness is seeing low events without
>    having a low configured. Eh, this isn't really true with recursive
>    propagation; you may or may not have an elow depending on parental
>    configuration and sibling behavior.
>
Do you mind if we just don't update the low event count if low isn't 
set, but leave the rest the same like

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 91721c8862c3..48a8bfa7d337 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -659,21 +659,25 @@ static inline bool mem_cgroup_unprotected(struct 
mem_cgro>
  static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
                                         struct mem_cgroup *memcg)
  {
+       unsigned long elow;
+
         if (mem_cgroup_unprotected(target, memcg))
                 return false;

-       return READ_ONCE(memcg->memory.elow) >=
-               page_counter_read(&memcg->memory);
+       elow = READ_ONCE(memcg->memory.elow);
+       return elow && (page_counter_read(&memcg->memory) <= elow);
  }

  static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
                                         struct mem_cgroup *memcg)
  {
+       unsigned long emin;
+
         if (mem_cgroup_unprotected(target, memcg))
                 return false;

-       return READ_ONCE(memcg->memory.emin) >=
-               page_counter_read(&memcg->memory);
+       emin = READ_ONCE(memcg->memory.emin);
+       return emin && (page_counter_read(&memcg->memory) <= emin);
  }

  void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup 
*memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 77d015d5db0c..e8c1838c7962 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4827,7 +4827,8 @@ static int shrink_one(struct lruvec *lruvec, 
struct scan_>
                 if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
                         return MEMCG_LRU_TAIL;

-               memcg_memory_event(memcg, MEMCG_LOW);
+               if (memcg->memory.low)
+                       memcg_memory_event(memcg, MEMCG_LOW);
         }

         success = try_to_shrink_lruvec(lruvec, sc);
@@ -5902,6 +5903,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, 
struct s>

                 mem_cgroup_calculate_protection(target_memcg, memcg);

+               if (!mem_cgroup_usage(memcg, false))
+                       continue;
+
                 if (mem_cgroup_below_min(target_memcg, memcg)) {
                         /*
                          * Hard protection.
@@ -5919,7 +5923,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, 
struct s>
                                 sc->memcg_low_skipped = 1;
                                 continue;
                         }
-                       memcg_memory_event(memcg, MEMCG_LOW);
+                       if (memcg->memory.low)
+                               memcg_memory_event(memcg, MEMCG_LOW);
                 }

                 reclaimed = sc->nr_reclaimed;

Cheers,
Longman


