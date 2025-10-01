Return-Path: <linux-kernel+bounces-839072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D9BB0C11
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768111885B53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF64258EFB;
	Wed,  1 Oct 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjXD6g5j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C62580EC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329605; cv=none; b=WZ0KXu0FpcOUKDcrlhNOMugsTyC9BcVsuFgd7y20o58EXOLzB5uF9WorU2UvdXcgKoW+2Rv3NfrXqFa7No0nZCZQuqKAotSW5hox0bw8B0lML0KDDK4/aS2O3WKggkT+wLqwABH1byXlZKzbphXax+EPsUgI5vR26+LM1tDZ8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329605; c=relaxed/simple;
	bh=CWHXIGbmRmhNKsguP0qRvA06HCixs8YZqxSA+QIoHm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuhRFiczzwFQYhPMLRSyuYx9liyBLNIvZM5yKaoxgKZXwI/OpRp7Kag71BhM89iQXHO9SVI+L5ihMRs9IAMNY0aMj2pLZCWw7rDKWaG2Jdst85i1XNBKXk6kuzlR1wON/YTSERh4yZdElbzBvCrjpunlECaFIp1Q7cN/xcSPIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjXD6g5j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759329602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=owbaiW1xpzS8vT38zdTBLv0coUdQJNTI68ZZIQGXnXc=;
	b=LjXD6g5jCdjBrGDJvvCGr99Mt9END08KeA92+Un7I0ycR94jfhdSiCYf3jCjzpmTRLEVIi
	odoCn/W+rcfYISpe+tTIK5xFdsPCoswaEUp3kL8j5UGqhSw3BNoQIYAq+DFC2MpRDNeo+F
	DGKdCtZRmvBz67nf8uT6/xNaYQRGGAE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-wwhMSXFmM2e6-B9btI90nA-1; Wed, 01 Oct 2025 10:40:00 -0400
X-MC-Unique: wwhMSXFmM2e6-B9btI90nA-1
X-Mimecast-MFC-AGG-ID: wwhMSXFmM2e6-B9btI90nA_1759329600
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee888281c3so7758211f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329600; x=1759934400;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owbaiW1xpzS8vT38zdTBLv0coUdQJNTI68ZZIQGXnXc=;
        b=PDS4T4Flw3UkiMBTls7Bxa1ouu0VZ21rqSM8nVrP+N6zJp5vSCgwlWUDBWYui2XAtj
         spEXPZsixjK+VGeBiCWNW6//IYcvNJ5nLp4hJu/sW+BfjRSXX8SHA4y1wByZyp+XotWj
         CqwdIF+id5OCiDeTNwCjs5srB3xGBpJ+sWiYKCJ3BHXu1FAmIHwnpBtfX2eT29xL/dGi
         qkBKfjzzWVkD8wvJ5JdNPpRLBVINbUlJ85xHfQC/6IeET1tVTnaFKVP2mwvIWr2N/wX/
         FHTrCvi3O+x2Y6jCQZ4ax3p6DkIwQ6CYhj6fXoxeROxTL2akDww6Fh/7pIOiFqwmPIYh
         lnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs9AsYuZkwa3DfKJIPfXq6qsizaUYAQnsCsSVzJecL3ujQswVdzLbvfF4W4/hyEa2pP4TsBAK/w7ewvGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFmvemgXTOMgjunhTIVrwgmEN+CmoLBcIsflnGb0/brMqML0j
	MU7LbWarucqBvX3Cnv8wwVFjkOBSyLktu4rcg9dXnof3cdsZB+eyFtr+cP4DiBXiy/zCxfbb5nj
	zlkF8jqvLT2g2w4jgnMlEJErNubkZDb6g7hWR7SaouVD/VPkgfxaFgyHOQFivFYuxJA==
X-Gm-Gg: ASbGncsRDl8pcgg3HV8r9Z1ChjWA/8rCFg2NvNvLYFrN1t7XLQuB5+khjCDUUqwc0ki
	ram5YuUiqedr+wIVwg31GjhEYo3xbCN7eKKu2c5w74CbxXzBtsjq81wA+CDDIbqtKsIPE895hhO
	PIfhD2llqO8VeyUUDHGU8mG3StdKSuphfDQD4LBH98RYMBbCMY8g9zkKxgibI8RHFjSrDaWIRcQ
	cfxYEk14WlOOVF6uMcF+gb7E6vMpkJRgnUANXpVbKy630LZMH3Ww85k8mIdXrQwit+iA9OtWxKU
	VsadEtZ3i2tl+0P4MReNkPOU/1QDIlVw1Ro8ju49DAhk6NlPE9sSjB/EuSNuurDDRz8aomdVvKS
	dj6176Iap
X-Received: by 2002:a05:6000:2dc3:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-4255780b74fmr3016797f8f.39.1759329599741;
        Wed, 01 Oct 2025 07:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKzYO9Sp6gBteVbRgZVz3DKARgkzRERx8bAp4TFc5XZ33edLooF2xD5yzFEFwFicRJr26EPw==
X-Received: by 2002:a05:6000:2dc3:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-4255780b74fmr3016767f8f.39.1759329599278;
        Wed, 01 Oct 2025 07:39:59 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb729sm26620363f8f.6.2025.10.01.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:39:58 -0700 (PDT)
Message-ID: <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
Date: Wed, 1 Oct 2025 16:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Axel Rasmussen <axelrasmussen@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 James Houghton <jthoughton@google.com>, Nikita Kalyazin
 <kalyazin@amazon.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com> <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com> <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com> <aN08NxRLz7Wx0Qh4@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aN08NxRLz7Wx0Qh4@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.10.25 16:35, Peter Xu wrote:
> On Wed, Oct 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
>>>>>> I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
>>>>>> are rather unsuited for this case here (e.g., different feature flags for
>>>>>> hugetlb support/shmem support etc).
>>>>>>
>>>>>> But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
>>>>>> the supported ioctls?
>>>>>>
>>>>>> _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
>>>>>> _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
>>>>>> _UFFDIO_CONTINUE -> VM_UFFD_MINOR
>>>>>
>>>>> Yes we can deduce that, but it'll be unclear then when one stares at a
>>>>> bunch of ioctls and cannot easily digest the modes the memory type
>>>>> supports.  Here, the modes should be the most straightforward way to
>>>>> describe the capability of a memory type.
>>>>
>>>> I rather dislike the current split approach between vm-flags and ioctls.
>>>>
>>>> I briefly thought about abstracting it for internal purposes further and
>>>> just have some internal backend ("memory type") flags.
>>>>
>>>> UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
>>>> UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
>>>> UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
>>>> UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
>>>> UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
>>>
>>> This layer of mapping can be helpful to some, but maybe confusing to
>>> others.. who is familiar with existing userfaultfd definitions.
>>>
>>
>> Just wondering, is this confusing to you, and if so, which part?
>>
>> To me it makes perfect sense and cleans up this API and not have to sets of
>> flags that are somehow interlinked.
> 
> It adds the extra layer of mapping that will only be used in vm_uffd_ops
> and the helper that will consume it.

Agreed, while making the API cleaner. I don't easily see what's 
confusing about that, though.

I think it can be done with a handful of LOC and avoid having to use VM_ 
flags in this API.

-- 
Cheers

David / dhildenb


