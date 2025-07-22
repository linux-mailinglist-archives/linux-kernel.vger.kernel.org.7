Return-Path: <linux-kernel+bounces-741461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9754B0E468
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250EE5815C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A5284B3F;
	Tue, 22 Jul 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtObtWU9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F655221297
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213966; cv=none; b=XJPnKrR09YEwJYkI9GqdehOzqgg9s0Jw3R/z8GrvO+WkyVHBQAoAv7hw1AcHu2l1vvrTIi6lo2RPFyoF9+PpQKgfFjYMaerGN6Gf7TVMq7sZXpidnraYh+w3/PKTpBSOgx+NrEjcIzfGEygB7du5nNMM61I22Z2nGzYeGj/GgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213966; c=relaxed/simple;
	bh=9aLW6WzkW8Dlkxa5+sE4bNKMghEMyAvLa3OeabqQX/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHjyK2kcBRb/CB+4t1hkhhbBxThUpV7Dahcm231BYAIa4zCe40QMe/2kUCDwsSsuhIZXsXdolJV9w7TbudJGewUB9WSvdOCZ0FqxEwouZ2bsko8/rgTAZKK3uR0L3hCsyVVF43tDInDQMbjf1NY74zPd0oouEnC9QL+QH77MIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtObtWU9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753213963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=afDMNM/ets1wQdqXC3stxVj6V8QJ54jbNPfFinJzgxA=;
	b=NtObtWU9vGFSNxXgLTfcastkL5zFz1fihvYxgXFWaX2GiypvbagwYux6vvuDDwNNCXkV96
	JldGaxiumG34B365MkXC0GOJMVwx5oPWDqO/FUGY0TBc5fdmZPOgQq1EXMqlhRz3llOVZM
	VDBXWnOzqrIvAGWEuIGnTW78t5zekAg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-dYwWAw98OSSoJf_ZIQT82w-1; Tue, 22 Jul 2025 15:52:41 -0400
X-MC-Unique: dYwWAw98OSSoJf_ZIQT82w-1
X-Mimecast-MFC-AGG-ID: dYwWAw98OSSoJf_ZIQT82w_1753213961
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso4727474f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213960; x=1753818760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=afDMNM/ets1wQdqXC3stxVj6V8QJ54jbNPfFinJzgxA=;
        b=GyxrMczG/UgPx+O/B2FRX8I0CmHce0ErlLdxGvR4DqDuKvCi3kbupr5JAxbnNv+N9f
         s5A6xC6dDKqBgDUPu1765JluwZ9/FX98LvCTaLP3QFXH/QrhqzsOFvYKa22ixaY1/NvB
         Iw8KZ7QVPR4lVbttgSBDqJU5vivfKgfUdyToI4dCUUxvgU7UDcL3g7nfoX+ZR9a0XbuU
         32dAVmeSmiYNa6t0zdh1vnarw+WA4fRukRP6OuCs4NDBuJVllnbmtp8xTut4t3K7vCh/
         CHTmgOdon7iyZqR3H+Sb9QiLOmgLtuAgQA7eiBQuotH5tvMfCcS+igkEgtR/pQFfGqKH
         vmRA==
X-Forwarded-Encrypted: i=1; AJvYcCVoKT5Mg1H2jtHgYFqVx87VFtl/IHT1UNPUYNgKOI2X1cPyRfD1T0DdanUOqL8zPBHV25cqGPX8Du5/lBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjbc50DwvDZbicTTO69NCyTcv+I492C4rj3OhPuKJOhLeUpItI
	/C2JYICvMm3MPNnrlNR3qSky5UMD7hLqnpIvNnYdSV9obUle44/PJX+4k6eiw48uFZKcIGnzUM2
	gy6samndjnX6bxv3SLxoo1SEl4njZK1xQa4gkD8BvjlkBFCAZmmGNh0HJvxj7Wd1ZGQ==
X-Gm-Gg: ASbGnct9LDpFoIba3sflLhddLQ4wzH1pji5gcrRXWr6IzHrdeEcaxCavsJZuCuAJzPG
	yth0l7j0qDY7C7NbMjdfwsTQNp7CPKAqt738UqUoKLrorv1pAccvqB9GUXLft2XhUXj0umTgQcz
	JOVdJWotxKsYUdCuSx/imyHpPYPXUHpPUSyWE0/EwPsl8FHuVPZMj2ds8cOfYSzTJtMwBhWj7g/
	sUq+3813CFmveg/UGg0GAIqOdlU+LwLHm2KBGg1GCzTqP9Dh+DvY7DCfIFb53dfQSt+Q5Up9KBP
	DPcLqzavwxhJngkYpaFzEnfYgfDnXnKjLUzm66OeV2xIP8KIqnzoZzYO3pX6ZtmJq75IUGNgfwB
	3ngEC7e5Q2uL1ZUQKsUePDrVZ4HbAPmvgTAHfQEsyNdQsZK+DGw0+IfdDg3lyA/OxoOs=
X-Received: by 2002:a5d:5d13:0:b0:3b4:990a:e6 with SMTP id ffacd0b85a97d-3b768c80d4emr397453f8f.0.1753213960400;
        Tue, 22 Jul 2025 12:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHst35ufjkfwSNwPNOo1bjqZrrkvMHnLiHFO3xBOhfcFGHyxPurs2yOJhrQR/AngBAvhnG9wQ==
X-Received: by 2002:a5d:5d13:0:b0:3b4:990a:e6 with SMTP id ffacd0b85a97d-3b768c80d4emr397427f8f.0.1753213959873;
        Tue, 22 Jul 2025 12:52:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d7fasm14352053f8f.69.2025.07.22.12.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:52:39 -0700 (PDT)
Message-ID: <d1f70fc0-ef5a-4946-bc4e-8508b5e265a3@redhat.com>
Date: Tue, 22 Jul 2025 21:52:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add missing mm_slot.h file THP section
To: Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
 <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.07.25 19:43, Nico Pache wrote:
> On Tue, Jul 22, 2025 at 11:19 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> This seems to be the most appropriate place for this file.
>>
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 837bc5cd6166..3f83fb317f51 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15966,6 +15966,7 @@ F:      include/linux/khugepaged.h
>>   F:     include/trace/events/huge_memory.h
>>   F:     mm/huge_memory.c
>>   F:     mm/khugepaged.c
>> +F:     mm/mm_slot.h
>>   F:     tools/testing/selftests/mm/khugepaged.c
>>   F:     tools/testing/selftests/mm/split_huge_page_test.c
>>   F:     tools/testing/selftests/mm/transhuge-stress.c
>> --
>> 2.50.1
> It might also be worth adding it to the KSM section since both of them
> utilize it.

Yes, good point

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


