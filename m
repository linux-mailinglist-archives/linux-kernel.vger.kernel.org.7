Return-Path: <linux-kernel+bounces-861607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654FBF32C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEDEC4FA69A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A526738B;
	Mon, 20 Oct 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFORNnsj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762A2D23A3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987924; cv=none; b=pGDiVRVjis9oKkAh7YBqdwYRMJCNC/4jAItwEKk2lOE7GOXuOMevlVpNP/7TZpnw+hNoH+HQ2JXwSHQvvjK6hmeoHPw2DG9kvQUf/ihrQYPkHXuHAjxYi4HEbQkQwdZv74KoTp+e6Oc50MBAZPTQWZ6kW0NuBfZ2mshoQcKU3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987924; c=relaxed/simple;
	bh=JBZMif3R56CuL8Lv49JjAMdyR4vbDHyjZyqQqKJEu80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc+dd2skdUXygGKpiX0J8wpL15xRjspJTRdTxOBZUcR/clsN+e7ptKugazXIdAfOTDsR9TFB8+Ij/jKP0OYmCL5DB7b92MfA8n+YqRaxnTne5rlZ6uuh233Uq0VsDXm3cCaAj6XZ2LeHeI2sQDL/qjqEmQOrttEZs6bblm6fVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFORNnsj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760987921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U3DQcRoLyYvhq2b3CfiotZ6Bx3GJ7cUvWYSw6ndhrIE=;
	b=MFORNnsjbDJP0Gedij+/iQvb1sDlYwewYlDmY4IksWMPJ93TKi+bCJllRLttW6tTAbNPSg
	krqre09OQ3vdYPdtI1ZKPXzdwe/NUBYHnnp51VOX1KEhLk/UBJnx8p+TY2Agv7oXjRjItk
	r3MfekOmVcEr8NR/vcSYsiJ5/EfRJCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Lg7emNCxPCCVnaf_vm3Yxg-1; Mon, 20 Oct 2025 15:18:40 -0400
X-MC-Unique: Lg7emNCxPCCVnaf_vm3Yxg-1
X-Mimecast-MFC-AGG-ID: Lg7emNCxPCCVnaf_vm3Yxg_1760987919
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so2830673f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987919; x=1761592719;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3DQcRoLyYvhq2b3CfiotZ6Bx3GJ7cUvWYSw6ndhrIE=;
        b=ZwkrFxxKc6Hp95i3zxovGGfDX+y/E1YNWMj44ftKO+NWCZuET361zfXlq5lKM1vrv/
         wE6CJHOSg4S2AyanH5QCfYUufbrE1II7+krPf9n8u0nHIebbUZltvrfARNHZOoCyf/F9
         iNb+52jXq+CAnKu20mq9cZzkwFoO9F9T7L3ZaFnhW0TDDl0cIUecy7nzZNB4u5KhhWL9
         VkZX3h6+zFt7O7X8kCqJKlBow3BpJEhSaNLTBvzBnK7HpQ3R4o4kCw/MSstGfpdA3Tko
         zSsXknh6ZuwGGg4u3q19MlMUyWdS/OcMvEsv1jZhT8mi/fUfMnk3YZXV0DkC0x2BV8zw
         fL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWODNCE0DhPUi4Z+j/nTSpi4fWAgR+Vp6L0yVOHzQOHtmuVHB05WxkNHyhoJmyJTRxjdDAA2wsfaNF3pSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hj4GWi/7U70QqvP8n6GF76Qr7vRbYqfd9JTIBuGmgKCJKwS+
	UEqOq4V+PlxgBwPP/2SZatfJT+kOUSIChieB5plHxdrQISytfWEt8iruYt7hlcFzkSM8quh2VI3
	V6Qn8UMk1Rg4ATgj8rKrt+aUqwGJojKgzF01dilRJSuCGY3cZpy5diqMYlAAirEyOuQ==
X-Gm-Gg: ASbGncvohZBHw9UCPF2HGZxO0MCqeyiNAFZ5Vw9nMtmPTrbC4UEc06rKbRrAM/qwr5O
	rIjeNTzqy2+z1gTsSdm7bL99mtaUPTkEuXkugtDRXSm8Rqqgehjdnt18JDNhgCgqmwj13Vxaqmp
	Ebn3To7qRGCPatiSmHjFlKUr2zUNNEuQVGKQi/rsw5plrWUUTXbUoZw5fe5s9C5ewynah8UaeZ7
	6teA+sYWx5NVyZOe/dKJWPvoexlK2HR0etTjBOBQFsAwBn1LOHKp6jR7pWnI89Rf4BVn/+7LzhR
	QU2gsLlEHkbFZ8HJtPpHv4Xh+vTf0IR3Rs1Tjwn3lDhH97um83yVwYKQj9AKUe7iNO7A0D0OaeY
	DsEGoBSREO+3Id6k1UJLlw3YK5wCePImZZtBIuiaXN/wSzr7cWEji4f9BF/U0+0F9u/JnusPR3s
	EzO96M04rM9R7JrNON+IRDzsTLWLc=
X-Received: by 2002:a05:6000:2410:b0:426:fd2b:25b8 with SMTP id ffacd0b85a97d-42704bc0d90mr11819400f8f.17.1760987918985;
        Mon, 20 Oct 2025 12:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYbOFgfXtsl4V+IXlQsTJKLseum2E9JtQa3IP+ennwBOv0bsTQGGaaKspULvmUG93wUYtq4Q==
X-Received: by 2002:a05:6000:2410:b0:426:fd2b:25b8 with SMTP id ffacd0b85a97d-42704bc0d90mr11819380f8f.17.1760987918547;
        Mon, 20 Oct 2025 12:18:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce06bsm16367483f8f.45.2025.10.20.12.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:18:38 -0700 (PDT)
Message-ID: <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
Date: Mon, 20 Oct 2025 21:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 21:15, Zi Yan wrote:
> On 20 Oct 2025, at 13:41, Gregory Price wrote:
> 
>> On Mon, Oct 20, 2025 at 07:24:04PM +0200, David Hildenbrand wrote:
>>> On 20.10.25 19:06, Gregory Price wrote:
>>>
>>> Do we really need the folio_hugetlb_migratable() check?
>>> This code is completely racy.
>>
>> My thought was it's better to check if any *one* folio in the bunch is
>> non-migratable, it's better to never even call compaction in the first
>> place.  But you're right, this is racy.
>>
>> In one race, the compaction code will just fail if this bit gets set
>> between now and the isolate call in folio_isolate_hugetlb() - resulting
>> in searching the next block anyway.  So that seemed ok?
>>
>> In the other race, the bit becomes un-set and we skip a block that might
>> otherwise be valid.
>>
>> I can drop this check, it's just an optimistic optimization anyway.
>>
>> I should also probably check CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION here
>> regardless, since we should skip compaction if migration isn't possible.
>>
>>>> folio_nr_pages() should be fine AFAIKT (no
>>> VM_WARN_ON() etc), not sure about folio_test_hugetlb_migratable().
>>
>> will change, and will check/change based on above thoughts.
> 
> If it is racy, could folio_order() or folio_nr_pages() return a bogusly
> large and cause a wrong result?
> 
> In isolate_migratepages_block(), compound_order(page) is used and checked
> against MAX_PAGE_ORDER to avoid a bogus page order. I wonder if we should
> use the same pattern here.
> 
> Basically, what is the right way of checking a folio order without lock?
> Should we have a standardized helper function for that?

As raised, snapshot_page() tries to stabilize the folio best it can.

-- 
Cheers

David / dhildenb


