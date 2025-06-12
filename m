Return-Path: <linux-kernel+bounces-684283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE5AD7896
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AB13B4079
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D229CB4C;
	Thu, 12 Jun 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsoyNP1m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917229ACF0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747609; cv=none; b=d15UNZq2Pnrzibe6JAX2KXG6eiN+wtH+dmISATEUlyEDeOhuCzmGkoJF8c1GbeFFBgUfM3qghv2K4UGghMdqHj9U+ARffSq1da8YAeMCFKk4I4la9uOlx1Mqc8TqNykeXMd+LYkH0ZXq8FUGCc+0ywOvT9BWuGtCTJxoN9WhqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747609; c=relaxed/simple;
	bh=HfDhruzEG5ndTTZsf1a3EBHuRp8XX5lOocqD4sf1i7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLlp3X2ycBFi6PtKOcGbh1GFVVW3X72IGbKYwazdGanvNwXrGru+FOyUOiSZJZhnwbcnmEivwNRpck5R3HfAWnJ531JlCnwOrFVad5VIM7k+U47GZhCbsCG9QxipG1SYLb75KLzTDZ0MjmTHZfNwcXiD80jXw6+J8r7paWU7JtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsoyNP1m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749747606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bE67YPqM8h5nTd6o6AkCh2yLeaxlPhQSOyCDAtjQSEY=;
	b=OsoyNP1mnAp6TTGp6DVLJlX9QJG46R2c88LucIjXJIuvGbhUwUyzDiANQoC7Jxdq6nUVUq
	VbXA4ScUx0SavrHusH4Z+Gx7n+I8JR/MunyGRZGG1aETKxZIzcqWU0P6X8+ATOy8HJSVBl
	Zp94/Vv6kRoP8gDl68dK1em84ylBLWw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-KW-wSpotOP2nGbb8SFHP0w-1; Thu, 12 Jun 2025 13:00:04 -0400
X-MC-Unique: KW-wSpotOP2nGbb8SFHP0w-1
X-Mimecast-MFC-AGG-ID: KW-wSpotOP2nGbb8SFHP0w_1749747603
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d9f96f61so10230925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747603; x=1750352403;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bE67YPqM8h5nTd6o6AkCh2yLeaxlPhQSOyCDAtjQSEY=;
        b=rVUj437k7YLKUqubIs6ZSl4hj5loolDdQ+h9uLZ3AOphpDpm0K9rqUBeCOQQxGrk4h
         f64PR6iY3Yt/QN8g6UnFPHG89nZP9jMg+QzCtH6CKt9TgWMDsHFeQ6d8tYiJWkfoibIL
         7jIp48KGCAuI5zJDnYmtW/62++YlGsh0qKO+rrSlQP2h6C8tiKZ5feKRsgSRs/wswtZ+
         cweYDwTmU/hzXLBuQCfzcEk1sZ61iSvfJDwGCv9L6A0yowwP+SwCcsJPqnlD4RJ+Hy9f
         jE4+YG0fSbmyycmdMO2ATQYRQfIZu+wicCjRFA6OfJeNf+AjikPw3J5uz5w1uONe8hYD
         Ourw==
X-Gm-Message-State: AOJu0Yxh7zeR9kjbsKzANu5v45e8dGUelCILZOnlPkAWrFQa1RdLeDVA
	T3RtFAVSo0r8lGWz4IlFwkiL7IEqVuskiXOaK6Gi2fSS/+hdKf0lFaAUdL4xS/DJrN+mk2/lnSr
	joTXgBKLw86i6oJS9qL38GbWr6g0xZaJB/zdYGBXLGqLSzhLnOmj44/vGBbwz0fGG9Q==
X-Gm-Gg: ASbGnctcAwwfIL4Rvn5n/EbJOWuVXFp8jCEJkndBuJ3Z8RMaGxNSxdFCWQ/VKWUSG+y
	RLx/NUMnUsmR8nGG61aUxOj10iH22DnvV9aoQ9hN0KLyHOOwfKsCwMp/OqBcQddWWvkqA/kuD7h
	EKWPzFNIMMNeccxHN0euxV7hEkkqBtBxQP9lpKHna+BbWr6lF8q0DN2pV3RQwq+DLvGP1nlhOAN
	AB1Vy0+6Pq4x5AhVDJjH96CbXkq+nYzOfwAfO8lo9xA+GPis6AoOfU0rwO/qLrIhvEf4yYZXlRT
	y4WRt6N47MLBM4Yav2gH/B/0PS781Sj86nMIvc1Ijvb3qqwKPHPZg4S0RBGg9Red1hdHZuCp7xX
	0v+fnCbg24R6lHwwvJeyqDMAA25IiaK5y5dNjSovxxhjLaAPdfg==
X-Received: by 2002:a05:600c:4f42:b0:451:833f:483c with SMTP id 5b1f17b1804b1-4532486c6bamr73197745e9.7.1749747603150;
        Thu, 12 Jun 2025 10:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTIa0Dl921K1lO5JZx/PA/Nioq8Af8exEqIs0sIWSYqdOJ/hXH8JgoXnVT7MAlXDsJZzZs+Q==
X-Received: by 2002:a05:600c:4f42:b0:451:833f:483c with SMTP id 5b1f17b1804b1-4532486c6bamr73197495e9.7.1749747602738;
        Thu, 12 Jun 2025 10:00:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5619ab781sm2473119f8f.43.2025.06.12.10.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:00:02 -0700 (PDT)
Message-ID: <11d1ff4d-3f75-42a5-968e-8f4bad84ab78@redhat.com>
Date: Thu, 12 Jun 2025 19:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/huge_memory: don't mark refcounted folios
 special in vmf_insert_folio_pud()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-4-david@redhat.com>
 <177cb5d1-4fde-4fa0-adbc-8e295fba403b@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <177cb5d1-4fde-4fa0-adbc-8e295fba403b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 18:49, Lorenzo Stoakes wrote:
> On Wed, Jun 11, 2025 at 02:06:54PM +0200, David Hildenbrand wrote:
>> Marking PUDs that map a "normal" refcounted folios as special is
>> against our rules documented for vm_normal_page().
> 
> Might be worth referring to specifically which rule. I'm guessing it's the
> general one of special == don't touch (from vm_normal_page() comment):
> 
> /*
>   * vm_normal_page -- This function gets the "struct page" associated with a pte.
>   *
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
>   * case, NULL is returned here. "Normal" mappings do have a struct page.
>   *
>   * ...
>   *
>   */

Well, yes, the one vm_normal_page() is all about ... ? :)

> 
> But don't we already violate this E.g.:
> 
> 		if (vma->vm_ops && vma->vm_ops->find_special_page)
> 			return vma->vm_ops->find_special_page(vma, addr);
 > > I mean this in itself perhaps means we should update this comment 
to say 'except
> when file-backed and there is a find_special_page() hook'.

I rather hope we severely break this case such that we can remove that hack.

Read as in: I couldn't care less about this XEN hack, in particular, not 
documenting it.

I was already wondering about hiding it behind a XEN config so not each 
and every sane user of this function has to perform this crappy-hack check.

[...]

>>   	}
>>
>> -	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
>> -	if (pfn_t_devmap(pfn))
>> -		entry = pud_mkdevmap(entry);
>> -	else
>> -		entry = pud_mkspecial(entry);
>> +	if (fop.is_folio) {
>> +		entry = folio_mk_pud(fop.folio, vma->vm_page_prot);
>> +
>> +		folio_get(fop.folio);
>> +		folio_add_file_rmap_pud(fop.folio, &fop.folio->page, vma);
>> +		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
> 
> Nit, but might be nice to abstract for PMD/PUD.

Which part exactly? Likely a follow-up if it should be abstracted.

> 
>> +	} else {
>> +		entry = pud_mkhuge(pfn_t_pud(fop.pfn, prot));
> 
> Same incredibly pedantic whitespace comment from previous patch :)

;)


-- 
Cheers,

David / dhildenb


