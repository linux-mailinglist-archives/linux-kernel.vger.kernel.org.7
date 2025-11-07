Return-Path: <linux-kernel+bounces-890448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCEC4013C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49F684E333B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC52D7DDA;
	Fri,  7 Nov 2025 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXXAg/fb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287932D3EF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521739; cv=none; b=ImahDn5Vxt/P6S2B+bSG80uaC9HiiUE+Hlla9AiDYGIiL486WNcMxwGRPXlJvENXZm994wzc/5zjML859FKms32rvhYO+VrKr3Ze1rNjGRSt1D0EEWuak6LVSeT0/xKrWBpm1jLi3NdswJxrw0ft5mWlmYk76Mq2KzCO/RyyBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521739; c=relaxed/simple;
	bh=jVylRwWjsZJx3w4jWSgnkfUgxa87TYOD4vgdP4YM9Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgTUPfbdQbGSd6cHJu5q9Na5087quErTN5mu9qjHFftmKh+M6d93/sgXrfvRUotYuZ849sklTXcwCW/Xud/DViFP7Zfg4TEnkdYQQDYyFdgm/Gh+1Yjs35Fv5k9IA8WVC6SizQLkhxSR5musOHdlvI4ja+92eLu4JGinApgj3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXXAg/fb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so140805366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521735; x=1763126535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BW73tny/rNjGjbXRK/CCOTxvH5raxzJjwlFOSIFvCv4=;
        b=KXXAg/fbaA8b+Ku8JnYZrK3mczpKJfAPYS9Spni8Q+NNGrP77RYnBHLD15u2hMMKo4
         CXxPwwVAxgGDNhrp3rOpIBAoEJ0ySE9bN2De7kYI5LWNwh6Vlu/oJ5gKqQjZHN8BaBTq
         RNbM9HrAYxmo1VVps+cgN6/Nvi+Ed2D2lr+X7Dd/vG5UflAkgbzP21V+RcGIlZvB56Ev
         jR0Low5QFRTQj0dEv2fNro0dTiQFXwOecTsvLbIjf7YeSgSvusEE7kAMwNS4XuZMtlLD
         8rTBU0CAvmagm+E7YHsxPdCmPpuxA5xg0xgUz4cwTcEdP5vrMX9hRz66XgYvnTrbYyt2
         WhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521735; x=1763126535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BW73tny/rNjGjbXRK/CCOTxvH5raxzJjwlFOSIFvCv4=;
        b=Wj3t51EieOmwxWDf+P3Y5Ap9hltKDOBgOpJAFrClkCJqOln0bINrs/9M6KwKpRNZ3q
         vZRPbgUEAnQRAJk/+dcAjRh6xTNXqUQWTyomeMBbS9T6yr/i8Z7aEvzW8KSWh4CLsiNG
         PDCger2Vl6wJ9JdaG7tMhHYvk86uEbgfbkCFrC9ZNP545G7/sVxwrYwRg05tCvKdW6Aw
         pe4qpBGKmATfTpH3dLp15K4A+AoWnWHul59CIW6AlaPwOPLkoGK3IBJM7fEnlKMN/GnW
         rjxs8xUkZZZ/4kW6EXw4ryuRkdRU2MKH/HhQWysRXct0mJCt4IG1ALHEv3OsCmGQ9KiW
         wQpw==
X-Forwarded-Encrypted: i=1; AJvYcCX50gX/9GSZbLzSCVnhLe21N81marbDPAj90L8B81DaNePb5c3tis8yfUsoFdpQy3SeKx5+lERtUKkI1Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqeSytmhNlD9jB53vNVHXjRt3untqsqM8lORAOklLDVFaEEvr
	EdkyJOrwASLNvPNPbs2n6IR2ZjKVXlC5ywAya7c7OHzM6+lXfXLB4LbVe3c6LsYd99sgnxfqSOW
	s/8VS
X-Gm-Gg: ASbGncsohEyZZQa2NS/XBXjSFglKiWvzwlu9qVyo7IZy1PH+6KgL18ftgYzhv2YUfjr
	vnxDRdjLAPkOo51hpfb6CnODuxhrq1oNs+zcjdARQB6iB37x6KsKboKvWjV6SgdEX6usnzOcRRh
	5ufcZKXbq12YntvQIi1Kgd4ryzTOyxmidTYKCsiCQVPBbb9gbXYKWovAb18DjTM8ornQxTPuqgL
	Q64to6afE/ZN4QBENe6FBXNSDdjulbjCSMY+h7NWaWAtzmk9JbpccvsP38C5I9pTGx3LCaUyUQY
	/v10zsNigcCDL9ULiNATN8t0o2As4JI3zExaHqCUIauOcd4+yZV/yp4o9bSxEnJqZvwwfXI0Atk
	VqmZigLJMbh11lZVYxfBevcCqlxB34ev7W82DonxT4Epizea6aFPN79tvXqQTPKr7BmR3jY4GA9
	QPW9cQk4S8d6gwcJRoLNhG1TDG
X-Google-Smtp-Source: AGHT+IH+ShbDcZE+qh4SZkqFEhzUdrx2v7L/xU+R5lqvkQSu+xhB2RSlNKbrKOFBDGQaTsFsa5ikmw==
X-Received: by 2002:a17:907:971b:b0:b4a:ed12:ce51 with SMTP id a640c23a62f3a-b72c096d5b2mr296847766b.23.1762521735393;
        Fri, 07 Nov 2025 05:22:15 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312271sm239966466b.19.2025.11.07.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:22:15 -0800 (PST)
Date: Fri, 7 Nov 2025 14:22:14 +0100
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
Message-ID: <aQ3yhmsT2NHeNwLi@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
 <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
 <aPEGDwiA_LhuLZmX@tiehlicka>
 <46df65477e0580d350e6e14fea5e68aee6a2832b@linux.dev>
 <aPE84XfToVH4eAbs@tiehlicka>
 <db4d9e73e6a70033da561ed88aef32c1ebe411dd@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db4d9e73e6a70033da561ed88aef32c1ebe411dd@linux.dev>

Sorry for late reply.

On Mon 20-10-25 10:11:23, Jiayuan Chen wrote:
[...]
> To provide more context about our specific setup:
> 
> 1. The memory.low values set on host pods are actually quite large,
>    some pods are set to 10GB, others to 20GB, etc.
> 2. Since most pods have memory limits configured, each time kswapd
>    is woken up, if a pod's memory usage hasn't exceeded its own
>    memory.low, its memory won't be reclaimed.
> 3. When applications start up, rapidly consume memory, or experience
>    network traffic bursts, the kernel reaches steal_suitable_fallback(),
>    which sets watermark_boost and subsequently wakes kswapd.
> 4. In the core logic of kswapd thread (balance_pgdat()), when reclaim is
>    triggered by watermark_boost, the maximum priority is 10. Higher priority
>    values mean less aggressive LRU scanning, which can result in no pages
>    being reclaimed during a single scan cycle:
> 
> if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
>     raise_priority = false;
> 
> 5. This eventually causes pgdat->kswapd_failures to continuously accumulate,
>    exceeding MAX_RECLAIM_RETRIES, and consequently kswapd stops working.
>    At this point, the system's available memory is still significantly above
>    the high watermark—it's inappropriate for kswapd to stop under these
>    conditions.
> 
> The final observable issue is that a brief period of rapid memory allocation
> causes kswapd to stop running, ultimately triggering direct reclaim and
> making the applications unresponsive.

This to me sounds like something to be addressed in the watermark
boosting code. I do not think we should be breaching low limit for that
(opportunistic) reclaim.

-- 
Michal Hocko
SUSE Labs

