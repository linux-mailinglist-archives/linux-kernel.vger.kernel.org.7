Return-Path: <linux-kernel+bounces-861504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCCBF2E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D64434F8E50
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706CC332EA7;
	Mon, 20 Oct 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrwFA8i2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD4267F58
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984118; cv=none; b=hl/NZu3q5aQ4EoHC0XU1BmZdyckJdH40yGKUpuUKd8q2K+ixCKtJpQjqJTXCZtITL6qzbduzaniTtWZAs8iQ13mIaf3a9l7AlH8cf7HZGxyAth8Y3aPl0sCpwK9m62hHuuksOQlg1Kbv1BthLfmJHVZPyc6zi+ijInhruzKGPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984118; c=relaxed/simple;
	bh=2/ZaP6z/POrQxAirdGrlQwLfCvS8kgizQaGNGL4EIXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J70cFa6aY3AdcXSsbT9gbkRmC2H//F3dgd6ogVhzsQkHwUrlTVwTdtfX5SE/5yxDMWT2YDGlVr47djRF/nEsbUGF7QJ1iVH8BrqnorEMYUQahgoMqR8D89ithE0s8guMbZvl8Yj0omAH0C2z//eDYXeZ4I5pWhNfVDwh02r/LfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrwFA8i2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760984115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yFbIY9KfSl1aaYeBiu8nSJ69xUVXrqjagrwKc2qCZAo=;
	b=ZrwFA8i2U0n0b3/x79tERGRVJXFZoGz0Ss04XRta+JLrstThPuXbKtTYXN40ERwAWmwSS0
	RkhaiDGZd26TPImrZhLonJ+B3jPna51biWFFlTFC/yCNzsq85yE5SxyPjYVnHt4wc4C1U5
	h/NetzBvJ/LohzJJzK9G9jMbB8rVYRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-CDCjVPfdM_20VVBd2rz2rw-1; Mon, 20 Oct 2025 14:15:09 -0400
X-MC-Unique: CDCjVPfdM_20VVBd2rz2rw-1
X-Mimecast-MFC-AGG-ID: CDCjVPfdM_20VVBd2rz2rw_1760984108
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471193dacffso30005135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984108; x=1761588908;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFbIY9KfSl1aaYeBiu8nSJ69xUVXrqjagrwKc2qCZAo=;
        b=qEqNSIFLz+Rhl4O8hyY9BMWvoVugYOw7jovZ5ey2AF48/gAOTaTwWu6A6oXwkzaXfl
         tQ832Zz9JGd2YV144q+HGvQifp6Ad25d2YgAtYFZAB3zsQs6JFTDjH84f9LxQ8FetyHB
         JjsxBsO9F2ylsF97i+CENXFes9BnDnzDmB3dTWGS+vj2/58apjSLWVIWoMGnc0kf2Z7T
         30PmAK8ZcWMcKe6FwyrqySywcYygxmXzUdAGoUCKSs5JcOWmHM7Ko5UplUx3Qg8VBxWj
         qkEdVvGQDZy8GnQ723ctwZVLeEhCu11FglyedCSnSQylWE0ETehMxjeOX37tA094iRRo
         4XLA==
X-Forwarded-Encrypted: i=1; AJvYcCUbCi8wq8D/ehuMKHtBTcVhX/S7+Z5R54XLCtyUDesxg86kjXYdTy1knj9RGhhBrmldwCh6XW/RIqBgFQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjjIw4hTVNmGAIPPXNwDhfw0apHYFAjutUqbNKBJA0ygb8Mjp
	3KExTXcjRJgVN81imKoApPaybVDUBVXmM4Vp6AAVbpB0gNylFrC+xfk1AO6nUZGh5135m9Z0Nsn
	yBrX4W0vUn3TAnsDgh8CJPjRm4yNBLJBSbVh2qdS+sodwHgIE6vZO+1saDnLPztod+w==
X-Gm-Gg: ASbGncsqsyeG2XwYgG6cLgYoOyQ+yT/AK1YHu/SZ9JecSm9gmACZrRSl/Dca912B+Ci
	MnUu3F9BILaq8G3vGS7ATQeElVfX46FFk9KkCqittSjTDcJnN5GN4T6g/2TN+TG/MuPrW9G1RvJ
	MnxKq4F8Q3qgwT77edFbYYR68ARifiPUpayW/ch/CTgPHPYRS6EBwVdFPqItM2j0x9lKm0LXJLd
	g/eCJeXSMzcGf4kKEFozSfpYRXGWCTNMxBFQm929eXI/ysdQIJXpfXxGxKY5TWyGuv+Jzbr3ua0
	Q7iJoO24DYMiNGEKLXzS030tYO2+XeEJxOch2GBlTU53Zaee3NokOYLT9b+Z7D5F05M/OsGFSZp
	rLrgAOwr//ciR+gnSWzhNaxdj0vtkscASWpdP2e8qh3DPWGVOgv2lOl9h+HcJFdDuOM8uG6mtma
	tIPNUC6cNiKMeM61Vz0XXBxnqiMCg=
X-Received: by 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-47117919c1cmr109211585e9.29.1760984107902;
        Mon, 20 Oct 2025 11:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI5NLM98OQsw1KE57HcLloTm5u9UUcInx88xRDDU5JgrtG6ezDCPBSxrNpLVxH6YIVkVgtWg==
X-Received: by 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-47117919c1cmr109211415e9.29.1760984107543;
        Mon, 20 Oct 2025 11:15:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aa079csm1455205e9.3.2025.10.20.11.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:15:07 -0700 (PDT)
Message-ID: <c3175394-7fc3-43fd-9fad-4d3790837e3e@redhat.com>
Date: Mon, 20 Oct 2025 20:15:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hugetlb.h: flatten logic in
 arch_hugetlb_migration_supported
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, osalvador@suse.de,
 linux-kernel@vger.kernel.org
References: <20251008212614.86495-1-gourry@gourry.net>
 <def56e60-42ae-4848-b0a0-91bd1c95d8d7@redhat.com>
 <aPZf1aOyhVHVedok@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPZf1aOyhVHVedok@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 18:14, Gregory Price wrote:
> On Mon, Oct 13, 2025 at 10:10:05AM +0200, David Hildenbrand wrote:
>> On 08.10.25 23:26, Gregory Price wrote:
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 526d27e88b3b..b030850975ef 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -876,12 +876,9 @@ static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
>>>    #ifndef arch_hugetlb_migration_supported
>>>    static inline bool arch_hugetlb_migration_supported(struct hstate *h)
>>>    {
>>> -	if ((huge_page_shift(h) == PMD_SHIFT) ||
>>> +	return ((huge_page_shift(h) == PMD_SHIFT) ||
>>>    		(huge_page_shift(h) == PUD_SHIFT) ||
>>> -			(huge_page_shift(h) == PGDIR_SHIFT))
>>> -		return true;
>>> -	else
>>> -		return false;
>>> +		(huge_page_shift(h) == PGDIR_SHIFT));
>>
>> switch (huge_page_shift(h)) {
>> case PMD_SHIFT:
>> case PUD_SHIFT:
>> case PGDIR_SHIFT:
> 
> PGDIR_SHIFT is not a constant on x86.

Ah, probably because of 4 vs. 5 level page tables. On x86 the check 
doesn't even make any sense as we don't support PGD-sized pages.

If we could rule that out at compile time, it would be nice. But I don't 
think we have a way to test that support at compile time.

But anyhow, nothing against what we have in this patch here

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


