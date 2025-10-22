Return-Path: <linux-kernel+bounces-865843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC208BFE26B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D5123551BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90822F9D83;
	Wed, 22 Oct 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQiZIhZg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9C33F3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164656; cv=none; b=fiRN248hqpxiwTrLSuXHDNgK3mdxL2cVTRPb3IMuhOxlmdTKb8i0HNu6Sf2xXsJg13OTHmViUnXQxbG+I/Pz7h5Le5tCA3bnhMTtXW7cV7E9I9BWgmC5S+bWdHRAnJ7pOdqN/9mmTM+oTVThJbfZCqMMi0TTttg6nGnzP6Z1lkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164656; c=relaxed/simple;
	bh=zQb8V2kxtPB9vtLKrejrFXSDgBDB0ZMJCK92N4HBh3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+nBAmwfifbw9yrc6hnRwp/XwS125L9yfGmz2AMYkLrZcs2CNNnACed6vusfUbL8G/9PwP0kGTRBmBxpKFB1yQeqcgaf5WaaoZ5Akb39R2FYOSIoAeRBq/+ncmAfYsu40/loPTWMNs9qWOArJHSRub7lsGDh/XZV92uMh9RrXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQiZIhZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761164653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e8sawOIoUzZEu0j8xgE4SlyrEgF5lTOfUde0v0D4Y48=;
	b=PQiZIhZgpVjFz6TSKV2lZOoQUlYBCrvIfF0TwteNPKn6btwHpU5mwCDP0DUvUsMcahBCUv
	UsklA4+Ajazi+Qp7INGF3hjUREXjspHUfPNEOP9DjjkIRUUFyYiZoVgld7BnV+aagYBRSP
	5aJnggyKCM8PpiOCsivh8tAxwIXUEQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-2Jbw2RHbNy25Jelw6cGJnQ-1; Wed, 22 Oct 2025 16:24:09 -0400
X-MC-Unique: 2Jbw2RHbNy25Jelw6cGJnQ-1
X-Mimecast-MFC-AGG-ID: 2Jbw2RHbNy25Jelw6cGJnQ_1761164649
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47114d373d5so178345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164648; x=1761769448;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8sawOIoUzZEu0j8xgE4SlyrEgF5lTOfUde0v0D4Y48=;
        b=OR6urAH7o6lD5jjZcFd2KztAnTn/Sij63St2OxX3HrinBfXcJnGRjyj3jl9/+vu9jK
         Atw/xHiqG8mDBqfPoIqKFcHvWTUwY/ltvQjPZIICSsZAWugqflQUAM/XzS2YcgmnSQMZ
         FCLr8QKv+PB+UcwbzY7yklDF5bTW9+1LcdMvF7NhtjyNi55m8DH5XFe6QPDZf2i/wN7u
         pnz67gc8hcRN/UPzxtVNg3beK0jPZy/cjY0rgfZ8JFvb7cP48Nd0TgHqeAfqmoJLa/Y5
         1ty+fVdAhna/iHzZSIyyhUK3Im2uQMO4JUwPlybW8HEOQCkzPrqwFQyZLlilXq8rqYCJ
         T++Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUK5jpSAgwy7K7pDAzOQ1ob+sLycEAmRnuIU+T/fQdBjdxUmiGVD/wpDCIg9ljgGKPADMMJjFzCEJyTwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHYpGNmf001IMxibhsLbUv1j4NBz3QzqyUo4T8nzqiG0IsAvV
	wWZwp/AfMArBBILJ8HbZ4h3dqKTB7qKP8ZYWhvnq4v50GIkeRRj4ACSch0ZXC1knaMiTk88t9sA
	E9OHwd69BtrhU5nK2liwEPhJbWSt5eK9qCj1UDvy72ssov+KaoDBvn7J9NNONqPTOnA==
X-Gm-Gg: ASbGncv4fx8dGNCHhbTkRd6gmAsoiw4EREgZENqaQe+Z6b9zuz3KuHn2V/1XBXm/Ioa
	tKLExangF97gvjRJ82EegikX2N9VjqWaMIFp692lz2AoGuyqct+TXk//2Lja6WTxX9peuLTitK6
	Pqs0qIyJzlhDg0+LfYWoV0wB88M4d1Po9O+32aGJ028y2GiPxTIJ+trR1AZiB9SYuF9zpNiA4A2
	PxMVz1IMgCjkWHmOBP3JOW/KpTAMEKbLDYIqXDMRIW8EdBkDOU3EGVJFWb/KfiY3iiOAF+PUrix
	aFrT/QRwv54KjDuXmCVRZD0Tug8s7MY46f+R26GoOGZHhpHqKEXnO3DmDjAiGDYM0VlnEmt/o6E
	B0Y8QIj+zKJpWMv1SuucF2gv2csD6xZckEyFMGO90dv3vojayAWcVydNRV3HoxX1lTyiy3e5Eei
	iU33UmrQypOauO6NaEpVaU1+Tl00Y=
X-Received: by 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr111828605e9.19.1761164648654;
        Wed, 22 Oct 2025 13:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpQTWNDB51Ac84akYrEZaSTOvtME/UTFQj59Tk6U86I4y+KK2TQ/veXOE6MjAMBRZ39kUedA==
X-Received: by 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr111828545e9.19.1761164648253;
        Wed, 22 Oct 2025 13:24:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494b22536sm43813825e9.5.2025.10.22.13.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:24:07 -0700 (PDT)
Message-ID: <0a121e1b-e238-4a75-b431-7c5a23c70f45@redhat.com>
Date: Wed, 22 Oct 2025 22:24:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
References: <20251022032951.3498553-1-anshuman.khandual@arm.com>
 <87ecqve6gg.fsf@DESKTOP-5N7EMDA>
 <b5a1b52c-75ef-4915-a254-a502b9f78eeb@arm.com>
 <87o6pzbbks.fsf@DESKTOP-5N7EMDA>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87o6pzbbks.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 10:11, Huang, Ying wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> On 22/10/25 1:03 PM, Huang, Ying wrote:
>>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>>>
>>>> Add some [pte|pmd]_mkwrite_novma() relevant tests.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> These tests clear on arm64 platform after the following recent patch.
>>>>
>>>> https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/
>>>>
>>>> Changes in V2:
>>>>
>>>> - Added a new test combination per Huang
>>>>
>>>> Changes in V1:
>>>>
>>>> https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/
>>>>
>>>>   mm/debug_vm_pgtable.c | 12 ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index 830107b6dd08..def344bb4a32 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>>>   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>>>>   	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>>>>   	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>>>> +
>>>> +	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
>>>> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
>>>> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
>>>
>>> Why do you use
>>>
>>> pte_mkwrite_novma(pte)
>>>
>>> instead of
>>>
>>> pte_mkwrite(pte, args->vma)
>> Just wanted to have more coverage for pte_mkwrite_novma() helper which was missing
>> till now in this test. But just wondering is there a specific reason for replacing
>> this with pte_mkwrite() helper instead here ? Also we could probably add tests for
>> both these helper variations if that is preferred.
> 
> IIUC, pte_mkwrite() is a more formal interface.  pte_mkwrite_novma() is
> used to implement pte_mkwrite().  So, IMHO, we should use the more
> formal pte_mkwrite() interface if possible.

pte_mkwrite() does different things based on VMA flags on some archs 
(e.g., x86). So to test the "interesting" stuff one would have to craft 
a special VMA.

Without any special flags pte_mkwrite() really is just pte_mkwrite_novma().

-- 
Cheers

David / dhildenb


