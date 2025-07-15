Return-Path: <linux-kernel+bounces-732216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F0B0638A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E19E1AA550D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96692AD2D;
	Tue, 15 Jul 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqMGj57E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735D248F7E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594845; cv=none; b=c4aG+ujPjg9r+ards0TzcPvenRgtfF392wtCgYu0ZW/bOMmwFs319Qc0j2b/XIxt4Cgs1PXu/j57FgSoUuIsW85nEPcnh3eJ9bbEUB3th6sSfp9MLWipfTye5zpTtfLOv6t38y/yqKIJ0QYhDilXtC+8UhCXrtokuEXWdkdg8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594845; c=relaxed/simple;
	bh=7p3MlzNMPnV+yP1R/oFLSAlsSu8M2X9v99aIDTC+pKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM+N7+cImg4sVoQz5X09+g8JphdOiI5ZIeyK7EDua5vLfnBz81jooNVq1Q1x8srvFF85jby9iHM4f9eswnI8SR4mFUrh3Fxf8OnQ/f/E2ldLnaQBah+baYrCn9NdSHAc+1ZXFG4MeMJb3bGsJCqKHe2/YYRCxKYZEzwOxc5zqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqMGj57E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmv50NS1VuZTN4/dyOMhlcYCw9wZ76zAdhcUU4LU8Ts=;
	b=hqMGj57EHtjb3ElFeqKEce/udGmEsApvlNbewwuC/Zv19y4n8NjLW2Vgau6196F8WT1iBz
	z4jrPTLNgcWFX41vj2qWgepdf3+1AOS4SJllDfzDbQaL8+MXjLbqV39V+O1d/VNmCKb0B+
	+HC1ocfcMeSBheXIQfo22Ddsm0mX4fE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-6VMqa6HfOgejbjh1Pg-XLw-1; Tue, 15 Jul 2025 11:54:01 -0400
X-MC-Unique: 6VMqa6HfOgejbjh1Pg-XLw-1
X-Mimecast-MFC-AGG-ID: 6VMqa6HfOgejbjh1Pg-XLw_1752594840
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561c67daebso43285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594840; x=1753199640;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmv50NS1VuZTN4/dyOMhlcYCw9wZ76zAdhcUU4LU8Ts=;
        b=wLng8vuw2y9ZEBCHoSVILlEBg8GjqaN7SgcIdniHWj+A/M6OMAm5sBC8uHbJ6/awwX
         joSrZXjE7ssk1bY5GcsMCyN4ZYhASgRPVvvrj4IONxqnwrItBMCB43NHNaIclT9pULAL
         UimeWJTPUKK2gagwoIz72ZrspQ8hX+ulpClRDlxOId4XXkf0WxIbDAVK/1VDXSS++ApH
         sqeN5tiUjRDQuJodtDSb7Z589OEIuKu+10+iBRPYxXvf1LzW9MidGTjCmMRtmaBSl2Yj
         pcTd4+Ba5ByKK3ioDegZJTNFvq1pJmYTFjWkxZk2cyl+GblhTClQfNldBacMfZIOQWGj
         YTxw==
X-Forwarded-Encrypted: i=1; AJvYcCU7qXohk5M+6fjSr2FH41jtZ3+40/BMyiRK5yFlCSy8Rl49kYihwMDzzZ3NFBaKpU8FB970A7YMGKCm84I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXBG75qX5EYq9gIIV9QiPi0WZDbWNnQbzl/jcm5DmSmVRSPP9
	0yCB/eGkOFeq6EJ9UW74NS/oxPioDwHNS9AvtRAdkSLFD0qQ9sZxZ+N/JGfIpczeMsiTjMVUztJ
	opPwZLltWHE08UBnpa72x+GZGiuTWIh39jaKFhYuyZauSnnlVSnXTMtYjF6gKfwTlOg==
X-Gm-Gg: ASbGncu1puQqYjs86rjZRFNcUv4I6Y2sO8FYqfPDSMWnYvgLTKrAo9lruDjuDvwBXDr
	+brsA81MHw7KiMEYiAcIc3+PPVYA5tUrQ5h1h+4Q9tGu6Z3heYHV5S0Q784CFHZf3Xt2Th3WTkM
	zLSMk8qeuo3NJdhffqS33kXLoc+vl/ascfJz9Juoe6r1SbwDUnnVDYQgogCpu8jzJhWby00Cwcz
	cKEQ0PtF/XzbVThNlniC505TNnQn60pdUswOrykk0+sMwVTA1Ggr3XWACyTbvmMrJ5MYGqRVTPq
	DMPvJGlfLnHTlEzzKdMEj9KzDcNNKCUVM/t+QKV0s64CLaaTG5IHixGHa7S+IQmSJrplMWEETr8
	LgW3yIivP0CA2kWSpsmXnE6SloEmgz/yGI4qxQkfCBaYO6J90fA+cP81mngsFWAQm5Kk=
X-Received: by 2002:a05:600c:5296:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45625e60a5dmr42794125e9.9.1752594839841;
        Tue, 15 Jul 2025 08:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjvMQLgGZNyoZsqz8MCuvOcue7LYnZbngEgbjMQqc91Vf50+c2mJ+v6bzN/+cLK2wOg4k8uQ==
X-Received: by 2002:a05:600c:5296:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45625e60a5dmr42793555e9.9.1752594839295;
        Tue, 15 Jul 2025 08:53:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d77asm15798899f8f.58.2025.07.15.08.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:53:58 -0700 (PDT)
Message-ID: <d8474462-a90d-4b35-bfd2-dc1a641cc837@redhat.com>
Date: Tue, 15 Jul 2025 17:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/14] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-3-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250714003207.113275-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create collapse_single_pmd to increase code reuse and create an entry
> point to these two users.
> 
> Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> collapse_single_pmd function. This introduces a minor behavioral change
> that is most likely an undiscovered bug. The current implementation of
> khugepaged tests collapse_test_exit_or_disable before calling
> collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> case. By unifying these two callers madvise_collapse now also performs
> this check.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index eb0babb51868..47a80638af97 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2362,6 +2362,50 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   	return result;
>   }
>   
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int collapse_single_pmd(unsigned long addr,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)

Nit: we tend to use two-tabs indent here.

Nice cleanup!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


