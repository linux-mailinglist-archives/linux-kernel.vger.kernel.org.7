Return-Path: <linux-kernel+bounces-794081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FFB3DC96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE39E3B600B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D392FB618;
	Mon,  1 Sep 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA5E2LCD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D92FAC0E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715728; cv=none; b=lxDrBqJGeDkjMXeXBjgjsZIAa5DDSpRQRsTSy9LF1VCPRlYeTp1uUzEdWUC7Nv6SuCS/z/ViCaBulazou6WbiNs97EsfsWNCf1nwBXuIdL1zTp5h0QW9FzKtWxpi4LwY5owKUYYNERYz+Fvc5CvGuuwdXweJeHQOiyPhF90Qd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715728; c=relaxed/simple;
	bh=UmR92pqcKCbqblA5mzeeG4b/xKSr411QQ63Fq1MC+d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhnJbdo4llXdVAHJZMxupLHFtWnaRpH9Pq9afolP9Lkaxmbvjnc5/V00vD4buuWs0/TuAI7ZT/w0uspJ6w2X1QzTek8RS6ZjYxEWk4NN5vdl0IHUGwfUt6gxGhvUmN0GO7en6/w5wg+GnhpbJ+NOUFDlg3x2p7bTsJuFqzWdDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA5E2LCD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756715725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Rp/f+W0ugUReLNu6gdfFdcYbWimciufzeaE9rDyHW8=;
	b=gA5E2LCDu6LC0ZIdrE7KGVsZGouVwZtQO72OaLuow+ebkjWrsWNIXD9gLoKNeZVrskwuRU
	N93Qpmlyj5pA2ZgOlS2PjJOWRi7GS4dD+wlGk+iH9wUvKYQ/qasDkcVTdIqUh2yrmxVEkk
	AI5q9dzR5+E6KgKWiMum+mOvhSXFI0g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-2gpWcuGJOJeT9H0eaoDWPw-1; Mon, 01 Sep 2025 04:35:24 -0400
X-MC-Unique: 2gpWcuGJOJeT9H0eaoDWPw-1
X-Mimecast-MFC-AGG-ID: 2gpWcuGJOJeT9H0eaoDWPw_1756715723
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b8dde54c1so2934215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715723; x=1757320523;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Rp/f+W0ugUReLNu6gdfFdcYbWimciufzeaE9rDyHW8=;
        b=qRajJTh2sv8zbuKFzZPKk0IyCsfeLlAbGodP7xkU1VQYzpkDK5sdVJ5T4BlmmF3UuY
         D4aNrocMdDOFuDRdDS/C+gPQIcRrnj49iELeCNIZ6MDR6LIqOsKul4mRnWYqKFrECnfv
         layrq+i7/t7U9BcmduSFkis75Yqs79LlgFHE6ENuHLVRNSGNmzyVaKP/aT67yGO0h8di
         +NDy60j7PRPPvcGWOnbzlUUMf4UWBFZ8avWbADKcxleb/n3AO2idknZbPAdsUmocpwsb
         sskKxWNTnrdIWCp1QDirgb5dNgAgSd8Ktdakt1GHRQ462l2cmK1WgyRuoezc3iPQjszs
         cZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVkee7GbZSNEmzKULHueF9QOY6MMLte9GP+id3NlP1OZKWtzI7rpf5wwZ+qsDSYVvEP+sXR4Uzw9WNignM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkg7eRWhUmiNLwEfT3WL2j86CLThyXsJVyDnNGpTVDEuH+/KxP
	xHCBJGricKIuoh+7h4OpKCHMLns9GHv8utZZ4kr5V4jMtNmxz9zdW1ab1Lm3A/M1vMFFrMGIAap
	Bzw45REgCQO/V0UPgKNi5lhpZtM/wgOlN6TfE2P1LGTE50xKoy8aOwT8HzuYFOwqSXg==
X-Gm-Gg: ASbGncuWyvCyutQ8L2NlGvRG0j2nItlFlxcSrw3VSz/Ui3XInMv6UHKcBFdZqMs5REw
	1zGV8rTiJPzMJrE3BFQeDRVhpmrMGYulbB0wIYQ+ToG5Xk2XZOnrWi931Yi/pfEHHuKeplbAtO8
	2V9BZGw9wPdl0/S5JWoaNVnQ/Nb4QToLq7JJWOglFUn+AlFHirG1SH+uDlgSEWWka7R6U2tKVuy
	IjQSgb5krtnCaXJBwcucUedN2I7na7ck2Q0IKOVbovm4ezIXvlONBcuIdxozgXfuJSTsqg5a984
	PXHK9lLH+kd9d4mpa87Hx9+7wdUx113SE0+oFUHJR+Oi8J1GumlXaTg3tgVTOAuS4dynEnuB5gF
	ooiO4Ch3OPYGeVZU+y6eipDz3Ne47w7f1eAMTilLEdMOniC55vkSxcRAxfeSq2Oxfd3c=
X-Received: by 2002:a05:600c:35ca:b0:45b:8939:8b19 with SMTP id 5b1f17b1804b1-45b89398d7amr40695475e9.8.1756715723516;
        Mon, 01 Sep 2025 01:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFddP6f93Y6m5iRNV/zYvBCXZhasJOXAiWFqnS7FH0aiguBZ9WEirTfxYpQJ343zE7hjq4YFA==
X-Received: by 2002:a05:600c:35ca:b0:45b:8939:8b19 with SMTP id 5b1f17b1804b1-45b89398d7amr40695215e9.8.1756715723093;
        Mon, 01 Sep 2025 01:35:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6db6sm240749605e9.2.2025.09.01.01.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:35:22 -0700 (PDT)
Message-ID: <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
Date: Mon, 1 Sep 2025 10:35:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
 <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 10:26, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 10:20 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 01.09.25 10:05, Max Kellermann wrote:
>>> On Mon, Sep 1, 2025 at 9:33 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
>>>>
>>>> On Sun, Aug 31, 2025 at 11:39:07AM +0200, Max Kellermann wrote:
>>>>> For improved const-correctness.
>>>>
>>>> It is not a proper commit message.
>>>
>>> I believe it is proper for something as trivial as this. I think
>>> adding more text would just be noise, only wasting the time of people
>>> reading it. But that is a matter of perspective: I expect every
>>> competent C developer to know the concept of const-correctness.
>>>
>>> Do you believe the commit message of 29cfe7556bfd ("mm: constify more
>>> page/folio tests") is "proper"?
>>>
>>
>> "Constify shmem related test functions for improved const-correctness."
> 
> Mentioning "shmem" adds no information because that is already
> mentioned in the subject. "Constify" is just as redundant, it's the
> same as "adding const".
> 
> The only new piece of information here is "test". If you want, I can
> change the subject to "mm/shmem: add `const` to pointer parameters of
> test functions" and leave the body. Would that make the commit message
> "proper", or do you insist on having redundant information in the
> body?

We usually write complete sentences, and there is nothing wrong with 
repeating what the subject says.

All the time it takes you to argue here would be better used improving 
your patch descriptions.

-- 
Cheers

David / dhildenb


