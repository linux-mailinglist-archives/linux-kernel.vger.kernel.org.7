Return-Path: <linux-kernel+bounces-756363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F9B1B31C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5118A1645E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0E26CE2C;
	Tue,  5 Aug 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP0AIIQV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784925CC6C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395847; cv=none; b=LNLPl6HtpQbdsg4FGhEovMvphHsBizONG8MrkWGRJ8pKx0KTs5dXdAeSNb0u3wPZAlfE2BlaZCx0T9p/LnKB70aRBbqGEhwSDZgQTotUK5Mok8zRiZr3rZz2qGob67E6XrA9a3mumbaODQHxRF0uyF/S/UhLgnD8mP8Pu5o/vZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395847; c=relaxed/simple;
	bh=dsbomZ2TJrqJxB3vb/LYF0ouD+kHHvZ3VGqy8aWySIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tviapPcj05beG8uhnqMjMpDtSDex0rgVCqDKAM14jCJnyMOF2DWFJa3zG3q/HeYoxxMTOOfV5IgRyeWqSXi1nqPz3HIN2HAor8qzuiSrCEFj8FBb6SkxANlSRMRuoHOqO3Yti8wmQCbFCYJLJ46helGGQLnk5oy7eYRleFlQJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP0AIIQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754395844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mxPZ9mV2VGEDs+TcyLyleA5F2IOZRlRZriZVa56GH68=;
	b=bP0AIIQV1Je0WcEnkmGqaJGd0nAyN5xTZwMLhbKrsxlL9kqpVkk8w0zG5ICW/kIBB1EqWu
	C6W9O5LsFnO3pdzgGRvQPG7GhD+eFKC8URRR1qLHdDRSceLhhm4/fVyCtHc6gj3C3i2992
	4T2/LY9iB6dguH/Rb+0/OxdNHksXr/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-__cN0hJFOpuboUSYgXHXKg-1; Tue, 05 Aug 2025 08:10:43 -0400
X-MC-Unique: __cN0hJFOpuboUSYgXHXKg-1
X-Mimecast-MFC-AGG-ID: __cN0hJFOpuboUSYgXHXKg_1754395842
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458b9ded499so23378535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395842; x=1755000642;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxPZ9mV2VGEDs+TcyLyleA5F2IOZRlRZriZVa56GH68=;
        b=Dp9IiUKUwfQfUIN5XbuWE6y/nvFMLLwh1Jv38vSBfTK23ymlysT3tDZQ2d3VSKkzK2
         UghfR8Au1FVYt9+ooasfO3NZ+Szw0NNIKjke+7wW93MO0DFUMvJUqqVJGFjdehwUNq21
         k8Ubp65fI8uhnqCQVvWQsKM5aExCBwdl8ss0/CRgKX6pj3aMXXqKEN5wqja4CqxirPT1
         sYtS8Y4+5fmKzR1LtZXE9pSGmc6HOrb5BF/vKdF8U5lhFGtxz9qYBFjXkEStxI1mhuos
         TsEaZ0ITdJVuq5Nkv5wyfn4DASkI+jh9coySpZahZUMk1N3QJ9J/Mgyn79BeVd+zc4Mh
         6DBA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJgaDEvv8q2YZnu+BjqcCOJb2h9xCq06oUbpYF8piJpICsXyqQzWSNYnFwWF44P7tCUWnBfioOJYfZ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeaTyR8ZqBMKzhP1cgxxjrYBIyjegsV7bHv14Vbq33Zv8Dgl4
	jW4uU4mD9z2zn0xLBSIrFLH7pJP6zhyNKASjlMz7ZXa7THu/kJPrFwa4/eeoib5iLhUNexdK+FS
	5tKlb/dn71tcjguSf6Jh+HiGYFr3sCXUt3IA3Hige9Lkflx5gJjDY+gYcoMbYgkCHRw==
X-Gm-Gg: ASbGncvnarbSXpq1jLGuW3h22+vIUFUAKNVNnSHziquYO3Zaalh8jmDX7+BjKNdPikF
	/hVStAaCNqHPFzUNCa0A+WC0LYrLOBJxWmpReCNcXfg7C5s8QP/l8If3wxpnO8sPTGgFgh80Yml
	xkvMVH4xpptel/WIhs5pqOIg3NXCnheBbohWSFa7Ypp8HXMG56oM5ypOuh6gzqxMpm+AhxUxrJD
	c8uycqrHS907ngZmWl5BgOUM6n9g9RZ/Tsy3NWA7QfnOO6+JPJ2WCy0E9qjcAsHV/Uez3WZm+vG
	wN5Ja0KHAQFnICmnxQIrnM3SFPvCM0IaD/JWOSsT3jJUNQbnG5pycMSnlJkUi5fNfOc1d72Ay3K
	k03k1Y4JJzxseSMJrH7PaRLGqPEJmyrDeQIefaFZr1iB7SEJsyqeER7EH4JhDLSmre0I=
X-Received: by 2002:a05:600c:1391:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-458b69ca295mr96547385e9.4.1754395841891;
        Tue, 05 Aug 2025 05:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRVCbz9qSTE0QSs8VJxnp/4QbJ3PPlhM2p3GCusUFNug/XIQgjZ+Xc7sBO+ds4FESyakyM7A==
X-Received: by 2002:a05:600c:1391:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-458b69ca295mr96546975e9.4.1754395841451;
        Tue, 05 Aug 2025 05:10:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm98317775e9.22.2025.08.05.05.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:10:40 -0700 (PDT)
Message-ID: <ca35da97-13d1-49f1-95b0-b8b9c8a7f540@redhat.com>
Date: Tue, 5 Aug 2025 14:10:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
 <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 13:40, Pankaj Raghav (Samsung) wrote:
> Thanks a lot Lorenzo and David for the feedback and quick iteration on
> the patchset. I really like the number of lines of code has been
> steadily reducing since the first version :)
> 
> I will fold the changes in the next series.
> 
> <snip>
>>>> @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
>>>>    	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>>>>    	shrinker_register(huge_zero_folio_shrinker);
>>>> -	deferred_split_shrinker->count_objects = deferred_split_count;
>>>> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
>>>> -	shrinker_register(deferred_split_shrinker);
>>>> +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
>>>> +		if (!get_huge_zero_folio())
>>>> +			pr_warn("Allocating static huge zero folio failed\n");
>>>> +	} else {
>>>> +		deferred_split_shrinker->count_objects = deferred_split_count;
>>>> +		deferred_split_shrinker->scan_objects = deferred_split_scan;
>>>> +		shrinker_register(deferred_split_shrinker);
>>>> +	}
>>>>    	return 0;
>>>>    }
>>>> --
>>>> 2.50.1
>>>>
>>>>
>>>> Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
>>>> then have a user-selectable option.
>>>>
>>>> Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?
>>>
> 
> One of the early feedbacks from Lorenzo was that there might be some
> architectures that has PMD size > 2M might enable this by mistake. So
> the ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO was introduced as an extra
> precaution apart from user selectable CONFIG_STATIC_HUGE_ZERO_FOLIO.

People will find creative ways to mis-configure their system no matter 
what you try :)

So I think best we can do is document it carefully.

-- 
Cheers,

David / dhildenb


