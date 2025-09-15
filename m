Return-Path: <linux-kernel+bounces-816746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26422B577E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804FD1892AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BC44207A;
	Mon, 15 Sep 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVAMuHpH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E62FE57C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934988; cv=none; b=FfOgYGckSqKd9FJm7jpCDln8acreuNsuyL4XwDvMJa5Jk3iIxO0QpO6zN6t2YB6ei5RxWNCJKI82y/FiD46m3oLVagWh6zOvvyRqww0jqDgrye3grKWXXF3gQfb37CpuWkqgrS8Ivl+QHhF5VG1DLisptmGS0fsssYB3JKnKscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934988; c=relaxed/simple;
	bh=muY6oKGaQsELxz9GLAl8Q4hE+kepIx72NjjgLJqgf1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs6h4xfR5z39Ldrhw7RZR5XUaAcjl+e2xvQD3TeHjGralih1FA8E4lfu2wRi5fI/65MWOz40eClgdOWn+LoZLeMupR4fVdscfQgvu4lRRD+3D7gpIkFcWssqfXpWwGnn6dW+PCE04zX0rRBwlg94LlKe8ER3hFA4+GlORezAbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVAMuHpH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a9VHMJIScHKfyZnHIwgFZKoZs2/TRCeiVl6qpGPg0Ts=;
	b=GVAMuHpHmeFDtxojxY7+864MEqxtghp1NElP4/VWWGDvMjJNMI31smMNjRzgUunMkG8NsM
	hKElX48i7KBdkEe3WpNHD8QPxmqpNp13RZBxQfYkLM97kmk/aZOmSPFnC3ofklx87RA3Ws
	Sqan7bwQw/8D02+FrBjKIW41pucdTvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-ZiXrGDojPrS1dmkrDHzNDQ-1; Mon, 15 Sep 2025 07:16:25 -0400
X-MC-Unique: ZiXrGDojPrS1dmkrDHzNDQ-1
X-Mimecast-MFC-AGG-ID: ZiXrGDojPrS1dmkrDHzNDQ_1757934984
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso29605675e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934984; x=1758539784;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9VHMJIScHKfyZnHIwgFZKoZs2/TRCeiVl6qpGPg0Ts=;
        b=GpMKknVKw6lANFSmcQ9X032w/07mE2ld4ndLpBqFYn4tge4iCWgPCiIai8/Cu+ant/
         uEiX1OvBRJn/F3xp2gjDgUamu803oyYr9V4e4/Xx5O3IbBbBVgnTiGpTVgHQnPhe1LsM
         diZ8glqEnEDfqP3ZpONWvRpg2vNIJYSbrkOplGqO5kdnHIGsGieLVELxHsfAbw+d67av
         CuNR8X95VbaCsfHNxgMLkO0tR2WzEqdD1Tpa9D4sJIQOHmRAqoN+boM3JqSJSo48T0w0
         577yw07dhRQor1CsnXsqbmynseLCQKl1x3vQY6VBVBK9knhdTFOkU6aHIYB1v70e3HLM
         RelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFBX4Uf+w6d1yAz9iVvm7hsIHDhpoKgiP2hY8AcJpELbMwqZixGZyhXh83yd8yjXlrStXReHhQNIaKZ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHx++QjNkTNofCjQ8GwFiRhSRnN0MwlHie538vG8Tkn1fjqMn4
	o4NyNpjv2yXhus1Q711TuVnDra/ezD5tQmqm7c5uwKaNvZ+IqHZipeWrc9Rp9oD2Yc05TKJzaKi
	t8mUfQ4/cvmQ2LUnABWyu5wmwgCx8XZuNY3gYcolLupwcTvX8pRI2nFSSAFOiQMtlSQ==
X-Gm-Gg: ASbGnctGKUlS5tiVSgzDLzZhHLQw6Ail4nl6jPBI3QIBW7AOe3A3mdKGjGChlNXWKXf
	GXcz3fW6XpB+X8FiB67NSbpC/6uD2hbB10i3fpAgpVZzo3EffGFidPJrkouu8bzqPIMCAJ4n5MW
	N2OCTd45Qk2/Fw5mhGPlnacwwjvyWRSPIIsK7FEnN9U3sOIWmbGr2kaz/YUwHSZd0t0Q712YUGw
	YkFQJ9LKjBv8LXmX02kgdwXi30+DDOcwaHmaoHTGVwzBJ0iSBnIyZX3wwKbo2N7K7YdvYhbADrZ
	MFuSRGRyBjsE4V1UOiCb/blCc3/OEfo1TzTLG1H/JTZOoUKfuOX8Bdec74XFfvuQ1dRxdsfRtH/
	HVNe7Q4f0zcpXfEp/5z/d+kzT+zl6+pXTizbCraRqzhnjRGSZo9QqqU0gkUrZqAjTJ0E=
X-Received: by 2002:a05:600c:4585:b0:45c:8e6d:a45f with SMTP id 5b1f17b1804b1-45f211caa28mr122688535e9.5.1757934983644;
        Mon, 15 Sep 2025 04:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG21FJvY8SBizXlRClZvA3kmKzKK5uslfzuqwPWbv/g2k+5nh8fAMnOP2RGfJj6Isnts61Hg==
X-Received: by 2002:a05:600c:4585:b0:45c:8e6d:a45f with SMTP id 5b1f17b1804b1-45f211caa28mr122688065e9.5.1757934983229;
        Mon, 15 Sep 2025 04:16:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03719235sm173781695e9.1.2025.09.15.04.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:16:22 -0700 (PDT)
Message-ID: <546d111c-0814-433e-b6a8-600a1065e3f7@redhat.com>
Date: Mon, 15 Sep 2025 13:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <2c5328ee-fb6e-45cf-a151-868cc8e7ff97@lucifer.local>
 <4508810d-7645-4f57-a0c5-2ee9f44206fc@lucifer.local>
 <34754ca4-fced-4a3c-8ff8-c00967d487de@redhat.com>
 <92352257-5be4-4aaa-b97f-c4e879ac6959@lucifer.local>
 <de3f5502-ef81-4f44-96a9-995e512301a3@redhat.com>
 <5099d9fe-4a07-4acd-95c8-782ffc74df37@lucifer.local>
 <1312fa3e-88dd-490a-9e07-9749c625933b@redhat.com>
 <c2f129c5-7a59-46b7-8fd6-0bb052e597ba@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c2f129c5-7a59-46b7-8fd6-0bb052e597ba@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I am afraid we cannot change the parameter to ignore other values because of
>> the interaction with the shrinker that easily .... we might be able to
>> detracted at wait a bunch of kernel releases probably.
> 
> :(
> 
> BTW 'Detracted at wait'? :P You mean we might be able to remove after a few
> releases?


"deprecate and wait" :)


-- 
Cheers

David / dhildenb


