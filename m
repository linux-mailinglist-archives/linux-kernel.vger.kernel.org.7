Return-Path: <linux-kernel+bounces-756290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB232B1B25A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7302D3BEC05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28B23F421;
	Tue,  5 Aug 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESBZ8kcm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F93AC22
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391485; cv=none; b=k2sz0JDBwRc7lmIg8TN8hH3iV8Jtp/bhGJ3/oDiAPzj8Kmb4u7Hko5MW808aIhm/oKyUniAbQN7SkjW6kiWAqFvxtrsiQnoDZDp4SaFCscgeVWIaxQ6bSw80xoSLLieFdl2sr0z0kBu2L7gOchs2ISCSKTCMQy1ys86TrkzmbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391485; c=relaxed/simple;
	bh=Ox3hj0iu+4FyPnva+8eJCz9F/sGPzU69uxhRVwpkSeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIXIL3gQBwANsMIq4HYSsf53XVIbNV/AWMQ8uZ+8jCs5ZHBIVhPpod9ctpv1pOaP/WoeSwjMpT5We5F+rwQ9WBWDObrt8ltYXkGahtxWIq4jWUumo6Fq6AbQ25bVXMA34wZfI0837aRxcO44ZR11ORAO7YtIvKZB1bT/OvM4FJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESBZ8kcm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754391482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n5BMU5lGJ8RNX9gIIEKL9KgpFrlX8cIqx5sp7WULqO4=;
	b=ESBZ8kcmuvMv9V0TyCbtmTtsojJKVtJdv/VIS+wnsXbLc2njaFSlxcp5rXZzLg7aKDTLam
	v3XNylM0tauqiJOiaZfcxOJF8J0U+7bCQBGPkC4syTNTASohdO1ixcWI6NBJgukHZ6V2Cu
	H093Q55E3QQ1IJ0LTZS2J1bGKPgqhAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-2nwttHU_OG-hkTibpYEhUA-1; Tue, 05 Aug 2025 06:58:01 -0400
X-MC-Unique: 2nwttHU_OG-hkTibpYEhUA-1
X-Mimecast-MFC-AGG-ID: 2nwttHU_OG-hkTibpYEhUA_1754391480
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459e30e4477so3295065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391480; x=1754996280;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n5BMU5lGJ8RNX9gIIEKL9KgpFrlX8cIqx5sp7WULqO4=;
        b=sdnhAOvN5WK2Hmrj+lfKbXPfnOiyX0WLMhljSGJ8s9K44wovyzLeG8IvSmP+0cpbBe
         c4Qayu7YEuFkbBdTqjW75+OcUqZDL/LNsrYDhOZYwOJ6++q+PGwnUyFZDysMcB+BbGeX
         s7mg3mOfc2/qE8vVY+VYj1f1zUkZVX/K+DyV3wNFJsorFhagKd5hLuG3fH6hr5ihTmTS
         NZjv4BZ6vknTVbJScFBQuCW2O77D9LW0Z3qUicEQvJeXop0LRt8oLfPMiHnJjccPfuml
         yo2MKq0/QPY2gBE9KoAbCAZya8Dcu4lZtTx2ozZAiGr3xVMoFRNPQKc4Cshys51EUNuT
         7wcg==
X-Gm-Message-State: AOJu0Yz3vf4HNrz5V2RTokvXo1tjgTwlPJmZgKymxzHur/mCQZIRh8rw
	bQqIrR10dj14SG8ltexqb38LkTAAIeWGEeh0oSTp2NlsEqy63TpnaVnTqeMTmP1W5hhqXEsxfZW
	T+BUm5GZWxOe3UqfzkhwKRrfOSCsROUXpevzcHR/O5S37ULTLHKjY3DeELQIQ15VwYw==
X-Gm-Gg: ASbGnctS1KEWvsvwgoMh1MxP6lK+sJQIP0GUtjLx912nqUgp+7L2xnZO+vwIF9uDpAo
	5hD1csLdPmGaToCd8o7B+/2Gho1Oadt9UhLXyDGAalMt+LHHeYby0OGiCekscK+AgMGOqQwqfK4
	4ei36bvqMcp4GudNoJnJ6YLIfVw4tPtuuZ6OjB2n8XN5gynmrDOLbrD1/rUaSnGTWchC0nwd038
	kSuIMuf0UT2q/nK+FOjrR86az7psafo3szpkfrqPrMCOH/A5xJoc532ZY80h/tHlGB4dmBVK1DI
	V1lyYi2WGqLS83oFAmVdli8cuOdaJ5I/4Z5jzlYUZn/JfGeEX6EE5995oNs2pYmSCM7f+JxdVHY
	tHejDJVJc4k4fRtHN4nyuAtI+c0hGnOv6fpnpl68xnneXNgEhyvE5jzB+lsJZ60ByFVQ=
X-Received: by 2002:a05:600c:181d:b0:458:bbed:a827 with SMTP id 5b1f17b1804b1-458bbedaab7mr62785195e9.1.1754391479876;
        Tue, 05 Aug 2025 03:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZS0DPqvyL4hZcBu/zSvjFODPXrIdMTkSTToGBYD4/CSW2xPIeZ33vTtYp0ch0Ef/n0Jv5CQ==
X-Received: by 2002:a05:600c:181d:b0:458:bbed:a827 with SMTP id 5b1f17b1804b1-458bbedaab7mr62785045e9.1.1754391479451;
        Tue, 05 Aug 2025 03:57:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm18505270f8f.52.2025.08.05.03.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:57:58 -0700 (PDT)
Message-ID: <98a30c7f-8be1-4b08-955c-724667971288@redhat.com>
Date: Tue, 5 Aug 2025 12:57:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
 <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
 <1e307223-897c-4db0-9564-95d76bc3d260@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <1e307223-897c-4db0-9564-95d76bc3d260@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 06:22, Balbir Singh wrote:
> On 7/30/25 19:50, David Hildenbrand wrote:
> 
>> I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
>>
>> My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
>>
> 
> I realized I did not answer this
> 
> deferred_split() is the default action when partial unmaps take place. Anything that does
> folio_rmap_remove_ptes can cause the folio to be deferred split if it gets partially
> unmapped.

Right, but it's easy to exclude zone-device folios here. So the real 
question is: do you want to deal with deferred splits or not?

If not, then just disable it right from the start.

-- 
Cheers,

David / dhildenb


