Return-Path: <linux-kernel+bounces-756433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD568B1B3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1257A85B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E9271A9A;
	Tue,  5 Aug 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/v7iCa+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4527145B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398730; cv=none; b=DSwenzqS+ImTZqOb8oH2oLZcAkb4tHYsZc/8lvX8pEwS3FKVRNi/EMcXg2kSmRwwlyPoOdpFx1psqkagR3xY0p+N5AI2nhh9IlDR4RP1XOxLHfEKUi+4d6bjoFI0FG71JPHt6/WHBkYZgfTHP54xokzGxRyXCDyxtUXIJMmVMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398730; c=relaxed/simple;
	bh=i2l4UZAqNXF0AaeoJL0TEjDpkuzDgXCxnDpXIDxnwio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0OR7n2W0tZ6zTj/pirwoF61TIkeYOMVUyyPiDzhnEivhqOyFbnceaVrBB9p32UNmsVRnQ8iJWUln/20HwfQCks6of9U3q2H9SR5DCkZDH2Ks8hKuqHyRfKpmXkRDBl4I9XnEmPJxyNfGP1A8FNC5zJBRI0gdWu6K/MxC6nx3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/v7iCa+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754398727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lTZfMQLhSPfCJQmmLYuzfiipP2GKwI927nDiRlIvHCA=;
	b=S/v7iCa+oW7p4BZOnp1yMOaZgVMkhTR0droITjj/mjy/e7DI5DMCFsmEWk1wgJbuHf53zT
	NdjSIyEnXVAlvEYLWQiU1bygBKyY9f1Zdddb47f2VHumks+hlk5YLKvRHAHGWbYLrcU+ft
	QUNR+TUK/4nG8uS0mYTZ88iLluj+6M0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-jbONr3aPOh-cHfpI0hKm0g-1; Tue, 05 Aug 2025 08:58:46 -0400
X-MC-Unique: jbONr3aPOh-cHfpI0hKm0g-1
X-Mimecast-MFC-AGG-ID: jbONr3aPOh-cHfpI0hKm0g_1754398725
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7825a2ca5so3239798f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398725; x=1755003525;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lTZfMQLhSPfCJQmmLYuzfiipP2GKwI927nDiRlIvHCA=;
        b=hug0spHvC/yPfspr4cBUvaapFcx5ysBhZiWdWB81fNq2xwMcxX2GY/q2GiQ+BkNZQV
         lI43sbyOyIdgHrxzpLZbU/XUKaVxoOxazqsCv38D4cenYwSelbQEdAhl1/FDG7YuuxSA
         NLrdd13O4zS1veQTt+GOqIQaKPQ1pxl4qzTX5EkDAmkNVOLvqXeYqsbk6EPsKbNXe3Nn
         SeNfpdK01ABU1R0+NXRnQxTjdQZiOLxqxhD9dvyLQJNDD3IsMt01pejkW4zZcyDIlB//
         J52xkGnVIT4XGy42AlFV0XznkeZ3WqPxXmuKJrKtZEr97I2FoP6Pwwi9EGJr4sbShvUO
         mi+w==
X-Gm-Message-State: AOJu0YzjLcF7r0U70YlCsRBYVqMZnVvYWFr36e0HJaKyZ64j8hF4UOtx
	ceO/t1F4MK4pi7div85rUfj8Oi5Qr/z/E70z9sOzIvz0K7thjFuH4gABN0AOd9HTaMuH8JeUw1I
	NYqbQ+9RDoHsj+lhhcomwTAOHdDAxxn4ZLbR7dySnmhJsU/ODeBIaboZLd4tTF15qbEIq9KJEok
	18
X-Gm-Gg: ASbGnctEuAFWjZfpOEHkzpTuT7dLPdBc7tLgbCIqEzojWLyVchAg6XjJo0pdOR+D/oC
	sZyzuWC8XMnsBsfA5qjA7oWGltRSrlG7uNsmr579mQVpXVo5SA0/NZUSTZLWtakKU7AdCosgr0D
	8grBF7Mep0c2bLU+NKi+qANBXAW/IgNAEIcbe3Mnr2c4SHxAWbmSpbxLwHyaOvM0f9e5mG3w/Qd
	2PAoINE2RvwCC8tDZkk9M8c8v333Xa7g3Di+zGTjr9fhl3YLAf42dqKG86cvRfghJ5H6eoyJF0N
	otCg/rBRppZbIrVN9ykdvb/UlnMSZT2Tc/M17k//n29fjrlJ5PBkIE/21E0spzB57GdkXns=
X-Received: by 2002:a5d:5f4a:0:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b8ebed2fdbmr2863427f8f.29.1754398725173;
        Tue, 05 Aug 2025 05:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1e51JlGAL/9wdzpcbyPC9c3UCgkCY7wkeuF90OqGQFtbP0YkZLeOQM7IrojmjymtuR99b9g==
X-Received: by 2002:a5d:5f4a:0:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b8ebed2fdbmr2863402f8f.29.1754398724748;
        Tue, 05 Aug 2025 05:58:44 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a26f.dip0.t-ipconnect.de. [87.161.162.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469319sm18864766f8f.54.2025.08.05.05.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:58:44 -0700 (PDT)
Message-ID: <da283a44-e668-4e88-985c-3e2805b556bc@redhat.com>
Date: Tue, 5 Aug 2025 14:58:42 +0200
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
 <98a30c7f-8be1-4b08-955c-724667971288@redhat.com>
 <9c0ad782-e1c3-4c7d-bb20-730d2f915dd5@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9c0ad782-e1c3-4c7d-bb20-730d2f915dd5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 13:01, Balbir Singh wrote:
> On 8/5/25 20:57, David Hildenbrand wrote:
>> On 05.08.25 06:22, Balbir Singh wrote:
>>> On 7/30/25 19:50, David Hildenbrand wrote:
>>>
>>>> I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
>>>>
>>>> My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
>>>>
>>>
>>> I realized I did not answer this
>>>
>>> deferred_split() is the default action when partial unmaps take place. Anything that does
>>> folio_rmap_remove_ptes can cause the folio to be deferred split if it gets partially
>>> unmapped.
>>
>> Right, but it's easy to exclude zone-device folios here. So the real question is: do you want to deal with deferred splits or not?
>>
>> If not, then just disable it right from the start.
>>
> 
> I agree, I was trying to avoid special casing device private folios unless needed to the extent possible

By introducing a completely separate split logic :P

Jokes aside, we have plenty of zone_device special-casing already, no 
harm in adding one more folio_is_zone_device() there.

Deferred splitting is all weird already that you can call yourself 
fortunate if you don't have to mess with that for zone-device folios.

Again, unless there is a benefit in having it.

-- 
Cheers,

David / dhildenb


