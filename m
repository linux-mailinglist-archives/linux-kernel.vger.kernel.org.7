Return-Path: <linux-kernel+bounces-750666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9501B15F77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FD18C74E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5F28641E;
	Wed, 30 Jul 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVObvwn7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8C277038
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875022; cv=none; b=Qye1KAilINSIvuG94DPder8BUoQ2bRCNqEvfk6oYGYpWFtN1NM/VxUwmcsvskgLovQ96FNU2amFpykh8QaLCb+egB1i5au7I8f8FjpAHHKf/2o4PCJB/MX2wPIMcA6taZsMe0U9ckzUBvusy9avXOyqmeKmO3dA304Az1TKMNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875022; c=relaxed/simple;
	bh=Gh6rEP1ugP+sbCWSX5VvNClj+jAExG9nLeS9zaWTW1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXisJF0e2W7ZaFtmd6v/0BYLFyJ5kLZ2pGVIW9XNZAIOeyNIZGi9XA1w3cIZCJtGxutciV0IZrbxBQLh5L3AZ7PhbSaMR7+yeG83Do2r/q8N0ckDuHQCJBQ+ZL5I9YMd9Q6zOTgfoyR4dVYWBpl9PHc8H3//nbWkRNL8q0dvQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVObvwn7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753875018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3GzBWqyifWHwH5iceOXiQp1MaER96Ffw9rxd4twZL8s=;
	b=FVObvwn7ZSzVwmrDaPKFDzKP0zZnmwtcAdSZ6K0EeFDtgqv4SDc1teIcbPAB4g/uyWTvmo
	sg+b5Ys4aYpdC+ebaJgJ0yZSEqg7kU0iI27ft6Cbrv09bEqtf+lRT2rFtvWbyyv0GZL+UU
	jyWMfKnGVgdxkDWhgoWeZBW/5FMo5N4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-C13vudOmMSmFYtnjoGsZyA-1; Wed, 30 Jul 2025 07:30:16 -0400
X-MC-Unique: C13vudOmMSmFYtnjoGsZyA-1
X-Mimecast-MFC-AGG-ID: C13vudOmMSmFYtnjoGsZyA_1753875015
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so50880825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753875015; x=1754479815;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3GzBWqyifWHwH5iceOXiQp1MaER96Ffw9rxd4twZL8s=;
        b=QuS6HzgTvttI0bZfpP/3OFoOLZLVZbTeKTz/UXT20mhe4PtPv8fM9gS5fXwoOIvtGb
         5+cweiFFZ25uxRD6qWLS4UD6O0orYm03YW3OGYkjjHtlUIAdX86AYbuvn/YMym6sQ2Nt
         lhO+dDjTeXkChLqkKaY6e7T/8t2qaozbVsj0F8TG+GyXcSnTMUOvUY2ZMaFHv1Ol6fB0
         1FTfmdHhFtQlUTXtHN5zGoSBy6Yfb6W7SKVzFr1IVxBRKQcr2Dk6CYJCaAbGxXXcM1Mo
         pzashVl8M9bicXby005yenNHHaYJkpVxBS6/S2DJVSl9JfHcZuImDMrliATS2ofPcyo2
         3Hnw==
X-Gm-Message-State: AOJu0YyMtDLetww5vbLCYJUP1J+d3N+yCFutng3XWtNYLz7D3V3C60w5
	dlRFV34VLakK6v/ZK9NcX9mg+vkFNa/0+qRF6F/Mp6AJwyd8S/nugGThR7CtlP1YvWeDZd78PfK
	iI9J81Tby4vvzhc7nwP5au+Gep2DHeGSU+Tz/Z1qwXMfLIDMtxIQtaojbRLNb8Zw18w==
X-Gm-Gg: ASbGnctUruNZI2kMPtE3IuSzv+oAzucZd8h3GC+4FpdgDE7FPm5Xr3jHL1uEURCVu3o
	KxmwqscYQWuEL8IhwLaojeXd+1LlBihUVIWJNttfex7ZXDorWQglHfeNNPLlOsXKITDVFnScUQs
	YFphgvGd4bb2ewYIhOXxvwsgAa03F+euuH443nIihgZrAJSg06ffw4l3LWqd6PrTwttsKLdvuKi
	NLnCNIcF862M0XS1rh+xap4jbMWg2bBgS3mdv5oeWpCR4yDgfsPHfk6htiyJrk+m9DK1jJKVd7X
	tnnh8v6s8Ld54XBRbtDrlkG7AbWvx3vaNAOZQZoUR3P7EFyog8/DaY+xarWRtg==
X-Received: by 2002:a05:600c:1e01:b0:456:1efa:8fe9 with SMTP id 5b1f17b1804b1-45892ce4323mr29265015e9.2.1753875015485;
        Wed, 30 Jul 2025 04:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnL3iXbokbIqC0Pm+v5Ra/rDptiTrRsG1Ols//d8nDmztKA2bkpZWNHk6oLfyjXU92baoGVg==
X-Received: by 2002:a05:600c:1e01:b0:456:1efa:8fe9 with SMTP id 5b1f17b1804b1-45892ce4323mr29264655e9.2.1753875015032;
        Wed, 30 Jul 2025 04:30:15 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589952a60fsm19204465e9.23.2025.07.30.04.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:30:14 -0700 (PDT)
Message-ID: <e0153fb2-af59-4bcf-a07c-d650fa56d55e@redhat.com>
Date: Wed, 30 Jul 2025 13:30:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 00/11] THP support for zone device page migration
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.25 11:21, Balbir Singh wrote:

BTW, I keep getting confused by the topic.

Isn't this essentially

"mm: support device-private THP"

and the support for migration is just a necessary requirement to 
*enable* device private?

-- 
Cheers,

David / dhildenb


