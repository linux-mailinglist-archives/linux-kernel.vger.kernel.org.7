Return-Path: <linux-kernel+bounces-674235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0AACEB84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8796A175137
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884ED201004;
	Thu,  5 Jun 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTaXK+XL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF181FE44A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111127; cv=none; b=nOCV6u8s64gi1wl+AC0Rz71IsO6Loz7DHziPtVWn3QHpFXSqpVIi+nLrJNJ+9d2HCG1Ok6ppp9K2kblhqo3iZHgo2P1MtYIgtfweQM2OwhPRUI8LiPQxGLB3HUePQB+yxwMp4lS0zUtLMy8aFfBycUUFYPqs/BX81MOnnTRJIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111127; c=relaxed/simple;
	bh=7APDMZaxuVVUzPH0hzXVXeKKwrGCSAQgU0rVY3XSHRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1J7PPNUkgDT4iwDyCYMH14PWnaMwwXRu9wYuFhEzliCLBCTqS8jar+yGiYEQqjSpbUTZRPpx0EajiSUbI2F2FvH3R+7ubU0iR5vRzYxAHexEBvK1tRaqSDXBMCRUy+kz8PZtX7GYd7rcInY77i36WeNfZIXb8u9mF1qoj87YNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTaXK+XL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749111125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aGysovsvSFhFmocooEY0x0kn//BwNRfG7TQs4Li9A7s=;
	b=bTaXK+XLUcGyQngJIFi1G6oYqPLEVyOviN80YKfxzP2Xo1oJkZhRVt3JKy5kfc76pCAXEZ
	2PYHes/213fKysp8nK84G5hb6udwVzNBBWDJbGCpZvC2uhC+HbNLgjanEYvOt5+gDtX6pm
	RTlZuHfSITUnWO6AITTFmlhqlu+11rE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-zTkkcovgNFKLzUr-c3lMjQ-1; Thu, 05 Jun 2025 04:12:03 -0400
X-MC-Unique: zTkkcovgNFKLzUr-c3lMjQ-1
X-Mimecast-MFC-AGG-ID: zTkkcovgNFKLzUr-c3lMjQ_1749111123
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e6d426b1so900392f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 01:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111122; x=1749715922;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGysovsvSFhFmocooEY0x0kn//BwNRfG7TQs4Li9A7s=;
        b=RQ1BROxgoJAwJHEIQ/aoPNulW+dhLntHK8/CvCnr48u72xNFn3hwsG8SPH5vEugtcm
         z2MRngL2iMGsn/weAhaaiqcsT9jPHU8BZIxpZO9o7ZM3r/J8DRKFCnJr+UleukDBGnul
         RdPTDN5z3Mskzhhp4pCBWKK8uq1cLAEWJXetGjl67uCL9avIbdNTZNc1prDj4oZmuvhJ
         /cSY5YnpuLEv8EqYIfa5teussJ2qBAe+M37CeIidnY9SjR+6/k7lBPHBKfPUoeMPZGbu
         vn2JLEBlR8I0fHLhL5vq0oogpW9OYnzN0C73qaNtIbEu2AhIS3Lg6AhIhV9uS4UXDVlR
         f0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhif29Y8TbomrAC/kIbh0HD8TWAgZbW7v9NKZ4nevs22y+45tJeErAvH044C7oHaeQEdbaRVYMmOz2pFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAL8FdRymLntq4pbv8EXhvRfdJw/i0OjnXndNhWKWskFGeeTT
	RwYuCIwCbKO9bBKlBfcbHsMJG+Uq7V5kEw1qHICDL+THX77/eTBOACr/ysMaWgH8t2AW32okG9Q
	z1ViaTodNUuSogD6he4PAe1uMVt8oq4JjLdKUaSBlpxoVRQP0RJvxWb3roLv/wRq6OA==
X-Gm-Gg: ASbGncuHvsfWxHnEszJBMhmZHfubwRy0DbazI+98kjl34+U67rfQmI0Xwwqfp8SYYzs
	3R4pfQwMyHrzwLSGZOiDPKvwLCpe3IKb5/LmjacxtWcPEnVz613Pwehc28j1FdOGTtME6PQB+Bt
	fe15H6YyXJFVMq/YAW7Zzpu+Q4I+VnWJdW6nA9+7yPYE/CiQVczv998HoCk+hwzHMXt6nEQFZty
	xAfZEwGdddGx8ouTEGtNxRUcNhUtl0t9YmlW9ExDDFTlF6+imUIiEohyC/yudH9YXYVNFkAUPai
	x7zq9NH/uwqQs+ygT1fnpt/vBN5sXm+KPSoka6FAtVD+NWoIahvywbNFe6MY04BdY/Auje/iX01
	q9JhRkGppOYMMHvHFTVtX9nOTCVl9zcmQAEuYc6QL/v8xVPw=
X-Received: by 2002:a5d:5f51:0:b0:3a4:e61e:dc93 with SMTP id ffacd0b85a97d-3a526dc53e9mr2106824f8f.1.1749111122618;
        Thu, 05 Jun 2025 01:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcU5CzNqzvXoSvX3HTznxyYrcaaBp12FMjtapttNNs0veytGDkx7moKmOt950sPzUrUeBIfA==
X-Received: by 2002:a5d:5f51:0:b0:3a4:e61e:dc93 with SMTP id ffacd0b85a97d-3a526dc53e9mr2106796f8f.1.1749111122277;
        Thu, 05 Jun 2025 01:12:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2? (p200300d82f27ec004f4d0d38ba979aa2.dip0.t-ipconnect.de. [2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cf14sm16149545e9.25.2025.06.05.01.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 01:12:01 -0700 (PDT)
Message-ID: <057fc1c1-7285-4656-aaa3-9a18d2e8f34b@redhat.com>
Date: Thu, 5 Jun 2025 10:12:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm,memory_hotplug: Implement numa node notifier
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Harry Yoo <harry.yoo@oracle.com>, Rakie Kim <rakie.kim@sk.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250603110850.192912-1-osalvador@suse.de>
 <20250603110850.192912-3-osalvador@suse.de>
 <ddcdd8b9-566c-4f6c-b1f7-861e93a80fbb@redhat.com>
 <aEA-K3hTvhtdUxuA@localhost.localdomain>
 <9a845c21-5cfb-4535-97bd-0b02f5852457@redhat.com>
 <aEEos-bG7cq0C8gI@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aEEos-bG7cq0C8gI@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.25 07:18, Oscar Salvador wrote:
> On Wed, Jun 04, 2025 at 02:47:28PM +0200, David Hildenbrand wrote:
>> Just to clarify, these were the 3 notifiers each that belong together. I was
>> not sure about NODE_CANCEL_ADDING_FIRST_MEMORY vs.
>> NODE_NOT_ADDED_FIRST_MEMORY.
> 
> I started working on the new respin and the moment came to make a
> decision about this.
> I think I'd go with NODE_CANCEL_ADDING_FIRST_MEMORY, for two reasons.
> One is that memory notifier also uses that therminology, so I'd use that
> one for the node notifier to keep it consistent.
> Someone could argue whether we are perpetuating a bad decision naming
> though :-).

Works for me :)

And yes, out of both options I provided, that is the better one.


-- 
Cheers,

David / dhildenb


