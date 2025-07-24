Return-Path: <linux-kernel+bounces-743991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA59B10690
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A09516C03C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F56244668;
	Thu, 24 Jul 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXrtx9Z1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEE23E342
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349572; cv=none; b=J+CRS0/IhB7zy6k+sHEuxsl6nGXdVrS/KrfB9UTTCqJdDHR3pTiP7SY9qvYpz9QSVnzi5nClCFQx2tzmSCcKsK17RXpCrq48Nbq1tLJHs0X56UVu1FcLsXHQOIeIhJYbQdCf3fiyjh2bZ5suPF8Ck0syJMG2a/i06/cGuvI+C2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349572; c=relaxed/simple;
	bh=YiigMUL7P6xLHOUGfdGiE4E3g6pABIlRhuWDEo1ppfs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e7huVHl0Jp/6wTz1DxcZ4cFB3hFF0fBPbSudhnkLpNQpL5+6DKHYlH+owkr8W9HAjP+8MhPs+fAA6H2MHgiQDoEtuLlVg+XIWlghkQDry4d0BH/ouKI24oZe7m/WLw96K0vslQ7cKYOqihgPZvS4r73QDFsWZkrNMyiSWZnDfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXrtx9Z1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753349569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q7uCQhwKP9dLIvdktJaD9mbq81ibyvlDaVR50SYdU1Q=;
	b=ZXrtx9Z1k8EwL4e7I3UYA2FchJLtYSECyPldZEpLWk6e91plztAtQvqtTJCyoMN00HiGSD
	7Dk91mz7ca1+fLPibeZ2LqkFm4vpP+xOTO/ZUs5jaMZy3F9Hd33thcvNqPhnvMxCKskPgw
	RCNXA1QJNgD6fb1iCgKHtiaDCnLi5lw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-XLlaSRx4Nl2EtFz4CDvSQw-1; Thu, 24 Jul 2025 05:32:48 -0400
X-MC-Unique: XLlaSRx4Nl2EtFz4CDvSQw-1
X-Mimecast-MFC-AGG-ID: XLlaSRx4Nl2EtFz4CDvSQw_1753349567
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so6155065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349567; x=1753954367;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7uCQhwKP9dLIvdktJaD9mbq81ibyvlDaVR50SYdU1Q=;
        b=XPpamYvoPD38sfsH5I93PFCIzxWWknSaZgOxfuLwb3fpZ6xCM9iLhwqv8E2hxz1x+Y
         zcHJ5yNeZO/7HDYLQT8J7c3Y+hSBDJENdCWPNKg2nB0NLQKvcb12FNi8Llal0khp4VGT
         TCX9Hg5jUcqjgMsmpDv9tTn2djvgKyXwjpLkSYFmmDdyLCw8PuZp3ohS7Gy+AMpgrzn1
         Vmd5NN9LU0uMthbnLY1ZYY0P7hf5ARe7CmtAixJCORyu+CywxK2v35MXVEQqLP/CnaIf
         3IAbcbd40QMLXaHEjoaEyD7ERh4TgwQ35k/AveqYEaTob2Q7oeMTbCGzsvsdoJiw3nYV
         uq2A==
X-Forwarded-Encrypted: i=1; AJvYcCUxpJMvREQ7Ul65LjhuDT+V/fEh1raZHVjHghM5J6iQQTXXOqnd2n9ZYWPB3JFOhvYj6Rz/VfulmL8cz6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzB3l42zzTkFoxUn62e7gL+itw9WZt1UNh9X3rZ8cfJoimy+vK
	x7X94bLh5evme4Sc+xz5gv0wFAvNtnFSMMoSP155TquaVM8KHxPHamNY9zBBUP9ju58eJUH2Gtb
	o7sFgwSs8pjzlOqmBbi6eVvbFddOWQdlb6HE4wuMlqGzJlhJWwWlRmXVw1kTSTn8YuQ==
X-Gm-Gg: ASbGncv8nT9biQ7jwwxutjcZKmScl2rJO0o0kEkjEdV9M6VTE5okfzwWsIChtDYeS7r
	inLAbBf/vfa+XV5D9wrzEOi7bC/66P/wDeGtEK67qgDSYIZZpEFAh76Lv0MUlJz3/0axH+doHyO
	HwWGvSbh0vruLdTit6E+bDox6tp4hGG1fpYbpGNOHv00GNhw9b+AaPNZn++iwn2bGJvpnDEZQ0f
	5neeH2jOQEPmCcysBX+xAh8ocnJr2YwvqgcYosZc4qRp9dyOIPOhh5eFqIbxt75TMQurPllvOJ7
	AD1qJf2jfasAgJW11jTiv6Q85txVHkHDQ4HHPVjDJTiO8K7hT6qr0n1136PTPlQUZZTeOsmGE1q
	vUq8vclIoxOViskDGqpC311rQP4XuHq3NZZ3FdiqPGbfzUN+VBRPjHOFMp9yfiSxF
X-Received: by 2002:a05:600c:6295:b0:456:1bae:5478 with SMTP id 5b1f17b1804b1-45868c75008mr61284505e9.2.1753349566866;
        Thu, 24 Jul 2025 02:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGgRm3hljQJ07PojBQ5FpXpLe9MmgVV9TG5vqehFxZVZNSzXPtZOOEFRcpY1A/+rO7OoBZZw==
X-Received: by 2002:a05:600c:6295:b0:456:1bae:5478 with SMTP id 5b1f17b1804b1-45868c75008mr61284025e9.2.1753349566358;
        Thu, 24 Jul 2025 02:32:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm16573555e9.0.2025.07.24.02.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:32:45 -0700 (PDT)
Message-ID: <23b986e2-80d6-432f-8188-7a11d6915c9f@redhat.com>
Date: Thu, 24 Jul 2025 11:32:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
From: David Hildenbrand <david@redhat.com>
To: Huan Yang <link@vivo.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724084441.380404-1-link@vivo.com>
 <86516155-f2d9-4e8d-9d27-bdcb59e2d129@redhat.com>
 <cc560d48-884d-4c8f-9fb0-565d74ad769a@vivo.com>
 <e9bb93a6-1e95-40e5-ad10-a60d80735432@redhat.com>
 <6d14e212-418e-4734-b256-b75c6fade25c@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <6d14e212-418e-4734-b256-b75c6fade25c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.07.25 11:20, David Hildenbrand wrote:
> On 24.07.25 11:12, David Hildenbrand wrote:
>> On 24.07.25 11:09, Huan Yang wrote:
>>>
>>> 在 2025/7/24 16:59, David Hildenbrand 写道:
>>>> On 24.07.25 10:44, Huan Yang wrote:
>>>>> Summary
>>>>> ==
>>>>> This patchset reuses page_type to store migrate entry count during the
>>>>> period from migrate entry setup to removal, enabling accelerated VMA
>>>>> traversal when removing migrate entries, following a similar
>>>>> principle to
>>>>> early termination when folio is unmapped in try_to_migrate.
>>>>
>>>> I absolutely detest (ab)using page types for that, so no from my side
>>>> unless I am missing something important.
>>>>
>>>>>
>>>>> In my self-constructed test scenario, the migration time can be reduced
>>>>
>>>> How relevant is that in practice?
>>>
>>> IMO, any folio mapped < nr vma in mapping(anon_vma, addresss_space),
>>> will benefit from this.
>>>
>>> So, all pages that have been COW-ed by child processes can be skipped.
>>
>> For small anon folios, you could use the anon-exclusive marker to derive
>> "there can only be a single mapping".
>>
>> It's stored alongside the migration entry.
>>
>> So once you restored that single migration entry, you can just stop the
>> walk.
> 
> Essentially, something (untested) like this:
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 425401b2d4e14..aa5bf96b1daee 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -421,6 +421,15 @@ static bool remove_migration_pte(struct folio *folio,
>    
>                   /* No need to invalidate - it was non-present before */
>                   update_mmu_cache(vma, pvmw.address, pvmw.pte);
> +
> +               /*
> +                * If the small anon folio is exclusive, here can be exactly one
> +                * page mapping -- the one we just restored.
> +                */
> +               if (!folio_test_large(folio) && (rmap_flags & RMAP_EXCLUSIVE)) {
> +                       page_vma_mapped_walk_done(&pvmw);
> +                       break;
> +               }
>           }
>    
>           return true;

Probably that won't really help I assume, because __folio_set_anon() 
will move the new anon folio under vma->anon_vma, not vma->anon_vma->root.

So I assume you mean that we had a COW-shared folio now mapped only into 
some VMAs (some mappings in other processes removed due to CoW or similar).

In that case aborting early can help.

Not in all cases though, just imagine that the very last VMA we're 
iterating maps the page. You have to iterate through all of them either 
way ... no way around that, really.

-- 
Cheers,

David / dhildenb


