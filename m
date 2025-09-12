Return-Path: <linux-kernel+bounces-813981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F598B54DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE8C3BF49D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209D2F617C;
	Fri, 12 Sep 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COR5gYVO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39A305976
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679940; cv=none; b=Da5WU2KKhDr/nckB9G6WIyq7j8CbMybcQWHSx8GMUjWnppkKPzF4/eYtwFxMWo5fy6W0fA4T3b52UkovhJCKyWPazE/kvFgmM0IQQqwwfKj3RiNqewZKYsZpPaT/ysp1kGm59aE1H3rrGRQ1jMK3UNusZVajlzd+LWD5QBKBizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679940; c=relaxed/simple;
	bh=w+2iPZY7IKx+3xapcM7nvoQHjog+qVzom88CFVQfI2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c576JYRSwbzcpGA3W3fWlC+OnvthR8Cm6n1jMEmfvdcmaYe5xp/SdJZ6Cnc6/Yxi+Q/hhIi/di8QnBYk2q1lrjvoKmVPphXeXOm8PfF1lLWnLiA3ICo7V3YkUJEUfP2ehc9a/A5dhRMxGinHi4z6OHREZOd+f/nIaJOhC5JMRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COR5gYVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757679937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wTo+izX1w//0z26IKQTIbvBaXy5RN7cB2ha614yOXr0=;
	b=COR5gYVO8IQHtx64ybw10Nxjz5bcEZLpGRMaqt898a/5Iv5TA7DBlMjWPeFrXGaMjuQf0C
	/2mKOxeid6bFk9M+J+YXrjOOValz60Ok00D91kzTtWz+e/hQXE737L2JFGCJzMQ5Mm84Sa
	R7Rg+vzqwhgLD9kkKqk9JoTCZk3qrxU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-jYlMMkwbMmaQe3rh8Eiqzw-1; Fri, 12 Sep 2025 08:25:36 -0400
X-MC-Unique: jYlMMkwbMmaQe3rh8Eiqzw-1
X-Mimecast-MFC-AGG-ID: jYlMMkwbMmaQe3rh8Eiqzw_1757679935
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e26b5e3f41so913503f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679935; x=1758284735;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTo+izX1w//0z26IKQTIbvBaXy5RN7cB2ha614yOXr0=;
        b=VuBYX32+iJa53P5sqMZD7evT+4b0qnDdHrFv1z6QeFDMkUR+7BcfI8oAo1aOiw9Qih
         NucpNX8qMOx7J5KLQj9zvEVR155AHq9Rl+e5bpI0xk9VoQUcicC0tQGRu5dVbPXta5qp
         ao9wpxoO2PqCu7YAVlVulVt90OVsdHS/KoXD5bPHtvKpms0AryT+4bjWycNdpOF0+Gc/
         8IzZyWJx7cWpnCah0f6LI9tfoErU3ymyoci4fDqgVdPQiGCyhQYIRnvEsl6j0Kq/c7eM
         LkTMneO1T7YU7VCX6KLp0054Te4jK9+sOeSm6+Ka6XVNKy2OADB8XtFwvugQ9BtcLsg3
         379w==
X-Forwarded-Encrypted: i=1; AJvYcCWUtqljYemKFBqvg9V10h5OUHjEhpW0k8mHQhM2M4ULuaJ/oRmckyIWSXe3MElV/jCpHlwT8dmxvwb9s6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHVloEqcTMsc3irStysR81KaZlpMqvW4G7npX7gPXyR7kgt8K
	J7JCscOWMldkIauNLMAzSx9v+raSHL3OXLlI2gubY4GPPm3Dg9/cYJc2DNJVBQg7drYI715XN8b
	qSdBYs0ZVdaeRPaJZyQHJ4hmorbTCkIGh8OnaBbG3QGiDr6W346WsP91AsEPbYA4xLg==
X-Gm-Gg: ASbGnctQc4FIkypIzbqKkv7O1pC+B+ggZcj2Fa+YDv1Tm1bJp7rEjD62VNN70lgZCXf
	jd9Apt25rcJqQP29uYbs6n2xIlxj09rmrB3HVEhgJhgyk1bPS2vpnADW14lkmHDNVR+9ZdqcOLQ
	E8mdYnZEamNIs0HTq/XJaBLxJqSIGKFhTV8Uax8frbP4LLiHe4+hfuWZCUWQCoCUR5kcD0Bmqvy
	cqVyAQce3xSlQtB7ouqwXReJfJOs8S7vh1j7gkLNlbpwCjDLa+okEY3/7+S/9s0QMpZUo4BiD1c
	E6O8GSUdCahVRFWBPF/hT6dsfiDm/ZNuybFZJubvJ3Dj4c2CKsD5CHouKv1MVrtMNTr5UhzCvqI
	FbqKF8pIi9x3OWpHE0VaC79+EhjfMvY/nTZAjlMgrir7Fj1bIZnDNtqbejqVAkXdr6v8=
X-Received: by 2002:a05:6000:178e:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-3e7659f5dd6mr2519954f8f.58.1757679935063;
        Fri, 12 Sep 2025 05:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6PZSoaqYfs4WDxtD7xqA4jAMhuyLomw1mK3Dy9a1s3qWzRB2kaFiIuJKmlg+DYd89YE4p1Q==
X-Received: by 2002:a05:6000:178e:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-3e7659f5dd6mr2519910f8f.58.1757679934531;
        Fri, 12 Sep 2025 05:25:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d822fsm6485239f8f.53.2025.09.12.05.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:25:34 -0700 (PDT)
Message-ID: <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
Date: Fri, 12 Sep 2025 14:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 14:19, Kiryl Shutsemau wrote:
> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
>> The following series provides khugepaged with the capability to collapse
>> anonymous memory regions to mTHPs.
>>
>> To achieve this we generalize the khugepaged functions to no longer depend
>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>> pages that are occupied (!none/zero). After the PMD scan is done, we do
>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
>> range. The restriction on max_ptes_none is removed during the scan, to make
>> sure we account for the whole PMD range. When no mTHP size is enabled, the
>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
>> by the attempted collapse order to determine how full a mTHP must be to be
>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
>> contains swapped out, or shared pages, we don't perform the collapse. It is
>> now also possible to collapse to mTHPs without requiring the PMD THP size
>> to be enabled.
>>
>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
>> mTHP collapses to prevent collapse "creep" behavior. This prevents
>> constantly promoting mTHPs to the next available size, which would occur
>> because a collapse introduces more non-zero pages that would satisfy the
>> promotion condition on subsequent scans.
> 
> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> 

I am all for not adding any more ugliness on top of all the ugliness we 
added in the past.

I will soon propose deprecating that parameter in favor of something 
that makes a bit more sense.

In essence, we'll likely have an "eagerness" parameter that ranges from 
0 to 10. 10 is essentially "always collapse" and 0 "never collapse if 
not all is populated".

In between we will have more flexibility on how to set these values.

Likely 9 will be around 50% to not even motivate the user to set 
something that does not make sense (creep).

Of course, the old parameter will have to stick around in compat mode.

-- 
Cheers

David / dhildenb


