Return-Path: <linux-kernel+bounces-796677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A405B405D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2754E3BD7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44868313E1D;
	Tue,  2 Sep 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQbDyaDu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36A31352C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821058; cv=none; b=Y0kZ68vKgQZAIdz/pBxTUDOH9j+hfYaeq2VehO1p3/tyqIiCJ+ekyety0cJkwS26WYpSdHuYkLVURAPnfm2+nE/kfaoNPuJwoSqc9855EMWz+blu+KZ6TkJlClznT7srM5/vKvqc9BShKrdrRefwtsgs8LkS/yyBQbkQhzMyzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821058; c=relaxed/simple;
	bh=caUygkLX29UctzzHFfy3myEeOqF1S6aaPwgrFfajd2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0wLap34TPUw1H9/KlLA4/uC45l1qQtAzjwebhCQF4SyWY/JQF5X2qn/Il+5kmu+bp9EplYSm4/clghXc7JR7EnGvg+xscGRas6N0FozL8kwdUF6dsySw3/SwEZop73j+Wvwgdme7ChOfvvf1uCNGMr5+vthEYUBG7QkWpa3pN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQbDyaDu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756821055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gjIO8VOEjJ/H4tg0OoEy8m/wse6tQSWY2ahEW3Ut7lc=;
	b=DQbDyaDunOcJsKacoQ5dU5YtQdbB3wm/lB92bwD4Tch7Qar6MFXj1A9NE+QTuHXnw6FZtm
	IZBEPtfewq6PthZqAPmvWq8etvF7d0jBuT/bAJjJipNLTp2tUIEZ49iSnPsOkCqLu9/Qg0
	fyw2hThotDgPQZOXbdGoQeOrK80GFHU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-mg3XfJyVOMOiwTnjRrJysQ-1; Tue, 02 Sep 2025 09:50:53 -0400
X-MC-Unique: mg3XfJyVOMOiwTnjRrJysQ-1
X-Mimecast-MFC-AGG-ID: mg3XfJyVOMOiwTnjRrJysQ_1756821052
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b8af0b8deso13081375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821052; x=1757425852;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjIO8VOEjJ/H4tg0OoEy8m/wse6tQSWY2ahEW3Ut7lc=;
        b=jZRVw1zOSBu3pU7YKCSdWGUzjxfxmghABLfqYeDk7+HJfwIvtahI1jyWYRAfVMGkQd
         NQb2OLRvmDxnzAJXxt/8tPa2P+fByAbN9KWU2eRF1Vs0BJZGNOz6ito6BOTHl9/5RGv5
         3p04EFbSCYh2fkhnqkWZRam/NTvvZqgGa3y7qb9vVgF5a64tTxL7V+sAlomIUGXClGXq
         SrvS6pEGcTnjgcJ+utM/D8xzfqNf93S+8IHEYTc867hAqTfIgULxTNUWUbJqLFqNRVYH
         F8ruKQ351NVazAlfil1oi+R07F3aQfVAuUIe34RtrKKMANwdR0yz7PgEGXbCGCy4zrct
         ltUw==
X-Forwarded-Encrypted: i=1; AJvYcCVk2bnycgiihBSiqsAQMW0hcS7oLbrlg84580D8sj+kc5XUXIhbx/8w8LNdtyqyfY3fGjUrzffjfMQ7vnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1pBHhW1h0sCpSujBYrmMPKPAC8tqUcf3JjVyDL+PRHBJHAbv
	1p52eaQR9flEprJOpR2La+QWhGPdoqxQbolVEBJFdZeEqrcFepUorEkR/MIv8Jx+plnunJAdv9G
	G7l0O0KMsb76a+GhCSjXQ59tizpSNQpVAEBQqe7CxMQzXAMQG5NlubBXNdKKZiMKdug==
X-Gm-Gg: ASbGncs1T9ntDCNyAA7zFVMdH60Fw7hZSSNjTAjOymcJBgVjLIgRUsK+dx3V0iSnsFf
	wk8K1wrC2hbWwRAU/kFYE/x/n2UdMsroV29t0PwDyrLZb/chSd8ZQ3okpG2IVaHaC2818+PjD53
	RjyZAqVHJMoVYMbRWBvOsoD3CR0l5Cp3M93yT39ZazBLfMpLIIBiMnjpEoGubpZ5B/IQPnR+6xF
	tvLDIuPIhWA1UwBsz7P+t37Ik3grzLZHuimH6Z3BdwwD4jT0sbso7wiUCyJ3X33RfiFt/U6brC2
	MRllY5vhf66Bh4NMh4WzII1K5S2f2rVLVqmcT+vI2R5oOKg9XIjk3i1ghNmsiJY9tMrB3u2+RrS
	O7m1hXAoXN6Q67wQc7M2YDhk4GPxDUJAEuLXrojrk6IVFIy7yIsw4gRvDLbU11XpYuPE=
X-Received: by 2002:a05:600c:1f1a:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45b8554eb75mr86986555e9.13.1756821052430;
        Tue, 02 Sep 2025 06:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE5rw3XcMK3gm1igeQlOk7pSVENRSC5jy18vid34H5lOCgcV+oH6uu2ahStX5eCwpxOESuPQ==
X-Received: by 2002:a05:600c:1f1a:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45b8554eb75mr86986345e9.13.1756821051980;
        Tue, 02 Sep 2025 06:50:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98e77231sm27328225e9.12.2025.09.02.06.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:50:51 -0700 (PDT)
Message-ID: <516d445f-eac0-4ad0-a337-6c669f1ec191@redhat.com>
Date: Tue, 2 Sep 2025 15:50:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions when
 THP is disabled
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, mcgrof@kernel.org,
 gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
 <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>
 <6l6f5idkqebpai6qn6n3phbnydz55typdwmvp3eexwnhk4qr54@otcgssegyqke>
 <519df8fd-b02d-4b4b-bf47-79070e3d2c9e@pankajraghav.com>
 <h7pqst5vvkahposrvf2iy5qz53t4crrujold2ky4ssrpawaefv@yaqaj3so2hxi>
 <ic5kobuxfm4zi6agfvosjxs325mdgrfpjz52mi3zn27epbuvef@z5dmowge6uyb>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <ic5kobuxfm4zi6agfvosjxs325mdgrfpjz52mi3zn27epbuvef@z5dmowge6uyb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 15:40, Pankaj Raghav (Samsung) wrote:
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 48c4f91c5b13..4ddf9e87db91 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -588,21 +588,29 @@ static inline int
>>>   split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>                  unsigned int new_order)
>>>   {
>>> +       struct folio *folio = page_folio(page);
>>> +
>>> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
>>
>> No. Make it unconditional. The point is we don't expect to see any
>> splitable folios, so no reason to get here at all.
>>
> 
> Got it.
> 
> Just one question though, in a future world where we remove the
> dependency between large folios and THP, then we can revert back
> this change to do a conditional WARN_ON?
I think we would never expect to get called to split something that is 
small. Calling code should be fixed.

-- 
Cheers

David / dhildenb


