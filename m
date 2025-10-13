Return-Path: <linux-kernel+bounces-850417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8ABD2BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B083AAB19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F4258EE8;
	Mon, 13 Oct 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LO4QSF//"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0794C85
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353948; cv=none; b=dNc06Sz1cliZQrIqVIMmwDpq1dQ2Qa5nhxzH+OH0Y7CgxB+z7XmSBFL1HlKw3aSgj7qVIdjhqMRf3AWwll8YUfjeMJPGaqzALuyWuvUs0aMZC1mxQztqtbznJgwxW4oJM7MuE0xjWiWYlhkId+WU/5zP8NsEym03WH0pOcfqtbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353948; c=relaxed/simple;
	bh=UednC2ZKR2Mh5G+irI2q3xfx4FRPA4w2E/7ZpfhJkdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWXqEqXpj5MXCvq5uXHuGyxPe3bgBIS4DGMtv1uVkWx0kpwqmZzgy7Zu6UvqfnkTHpXbvpF8ZqsPFKFoKv2Ffs5rokGNEFwU4ygj2xoO/UuhrD3kKzsEEXVH2i5HQEwqnFqnTZagerXscrWy6q/05LsDOAz+haHF7DbOfDfOpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LO4QSF//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760353945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XULdT3agFke/P/nH7DRRciMv9t5MyWZ3cE6tzq0NQJQ=;
	b=LO4QSF//Rsqv5mYrUt1FilGeh5RPo9Jp5eY5lqO+gpHXuvxY4LddrAIuKTOmCHkDtwhHYR
	moLfVHBuq2/4u/rWm0NRnpsR+td2NSaQjUv5QSy3XfEckt1yxD2isLc5h+0eipZgSGPvGP
	RZm7JYpLjRNgn4Gw+7w6vCiNnzYxfc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ksIs58HKNkK7DgNzLiBcNA-1; Mon, 13 Oct 2025 07:12:24 -0400
X-MC-Unique: ksIs58HKNkK7DgNzLiBcNA-1
X-Mimecast-MFC-AGG-ID: ksIs58HKNkK7DgNzLiBcNA_1760353943
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso28712335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353943; x=1760958743;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XULdT3agFke/P/nH7DRRciMv9t5MyWZ3cE6tzq0NQJQ=;
        b=h2h5blOq0AWa14GdN461NTTUwM2V600YCXMvl31PkhgmESxRR9opGKhVW1hR4S9Ugi
         95tuXP59YUVNmPD9/sqSKbpqtsUaoTvuzcyrrKa57mvFVry8AJ5P7OV3Mrhse0V3A/3J
         yYNMmNq4oOCGZxL03jFQvBapWGbFg0q2cd01aLIz4Oibb19WiPls75pU47XChjRAaWOC
         UVzg237YVE2T9EBk2eoSbQ2VOtvDnces5XEs4NFSVtZsUetQdRm/OpH/B98jb3DXzCh5
         bymMloLVvjRcMvK5Up29X21RTzh9l/ht5Qd0eOxA14N1ppjvLUWyvQhMqlR8el0x5XA7
         JG9w==
X-Forwarded-Encrypted: i=1; AJvYcCWUnarbivoFYmuxAMu1dMtW0UO5EHYwv8DsBsKGVG2GRLmK0cf03vco/vfBIngQfi8QeA4pzA9hsH9vsRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0V62QtVut/6M4UZ1KOsIPE+lU6oPbTJi1Y8l6RePZ4DEJTHp
	QjScAZRZ1OEVJMKJ61V2vjkAeJ5XK2OC5VALUE5ZaUpAc8M7G+zGKQf9l2c6rUSNfNc99wA+Ssg
	jgqgyNt2f8/+5oXzMtCj13fiq2DF1bXXEqH5Ub4064cJ2ML0EgQvsNEYNL2h4WK9O9Q==
X-Gm-Gg: ASbGncueYvP+0KNwB6lZ04fWJ8vOmSGugn5YD3jP0pdns6QslPzVtkaze822plLR7yU
	mwR83TapJf1QwtADrXPAKsOILqze2e80FtXpFydu4wfAZ3Py7MlrX2fADbiysyNzCO1Qh2jSlKB
	uaE6E0DJtvGpz6E1+rh1e12ADXjN/0bZbDJ2DejiWfVg4xNX193Z0SOqZ8i4og+l+9RTfV7+/+N
	Zk0qB0mab3ejb8uzhwslVilLCkZSqWl7ZNluKjOvVoEXlpBzS16Y/i6SEI9dIWJ+KUCVxhwpNL7
	XW0dztu9ud+hYvgurg4MHQPf5IdSUsIBWuHe2opAT8ebq3zDX51alOuOuISGp1UCJBUYUC12L4h
	lhSs=
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-46fb32e50fcmr126504125e9.32.1760353942864;
        Mon, 13 Oct 2025 04:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhGqB33GtEsb9WhKM6fim1eU7Q+q1kqoOzaaByZHeQ7HI4L9DqqO/lwFIxHHImbaHfSHEAA==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-46fb32e50fcmr126503845e9.32.1760353942439;
        Mon, 13 Oct 2025 04:12:22 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb55ac08dsm174127325e9.13.2025.10.13.04.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 04:12:22 -0700 (PDT)
Message-ID: <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
Date: Mon, 13 Oct 2025 13:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 13:04, Lorenzo Stoakes wrote:
> On Sat, Oct 11, 2025 at 05:30:52PM +0800, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Hello MM maintainers and drgn community,
>>
>> This RFC proposes to convert VM_* flags from #define macros to enum
>> vm_flags. The motivation comes from recent drgn development where we
>> encountered difficulties in implementing VM flag parsing due to the
>> current macro-based approach.
> 
> This isn't going to work sorry, it's not valid to have flag values as an enum

I don't follow, can you elaborate? IIRC, the compiler will use an 
integer type to back the enum that will fit all values.

> (they're distinct) and also - importantly - I'm going to be making significant
> changes to VMA flags soon (to allow us to have arbitrary number of VMA flags on
> _all_ architectures as recently done with my series doing something similar with
> mm flags).

I guess this patch should not really make a big difference regarding 
your upcoming plans?

I do hate the enum stuff to make these tools happy, though :)

-- 
Cheers

David / dhildenb


