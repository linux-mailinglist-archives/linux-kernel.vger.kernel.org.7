Return-Path: <linux-kernel+bounces-690587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52EADD65A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA957A56A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0D2ECD39;
	Tue, 17 Jun 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayq2cMh5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B42EA17C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177100; cv=none; b=HFrmHGMreeInibH7HV6m7lvnbuYAhfSOwuh+SeP2EPFuQNeQi8M8IDEg1OAQfVUt9AWrvuzMP1JQwpCc/CI2k+UcBbFNpN4XAvRIHM3thqHzrmONDkSzrIHm0vIZeymFp9sbDO3+XG5TH36JjmrSDm4bknKuVrsfNzoruvSzQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177100; c=relaxed/simple;
	bh=EV4z8OrdAmsdvSsal+Eul/nlTIQTkqoRdK7bUO8Fg3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc4jT05qJzotgM4TIirK5lZYxfi1o03oMZ6RVoDgrma19PUzJAARa5CzZsHTji45rQa/Zxg+966802ssJHQQIKXN81XFp7FhDwej3muLqT7XXzpUAMiTdn/TVQw1W0pNoPdwHMb/Qz13U43s7zKK7FW6uJVFuS/FU9cNH3qtNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayq2cMh5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750177096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ggyx/jOc4d7bYwabgJy5rrVWttDhaySL1H54el9rbuo=;
	b=Ayq2cMh5H8BwRCW3JZ0qOCSLeP2h06t0lx2jGQQ4e8WWs2na6ZPVuP3P7A2jEZSQb0eoiE
	31hzPd61bJVMD8VeAw5OKfXRp+r2KSJDAGBNmzqdolUMpYxY3Fq7110efHv+Sd8HZMcnD1
	jCfN6ZXM2IDgIkjsWoozltVuO6V9Vn4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-8FdtiNSUN9-KB3bAa5a8mA-1; Tue, 17 Jun 2025 12:18:15 -0400
X-MC-Unique: 8FdtiNSUN9-KB3bAa5a8mA-1
X-Mimecast-MFC-AGG-ID: 8FdtiNSUN9-KB3bAa5a8mA_1750177094
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3671311f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750177094; x=1750781894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ggyx/jOc4d7bYwabgJy5rrVWttDhaySL1H54el9rbuo=;
        b=NNw1r6DXG0pS2ttmpcfHPN2yXtS0nZe61xfiZzNV0WBX4edzlFO7gmmryZo1zxUudt
         lczXqbweLl6FulhDneT/1wICoErqZJnb5ISlIUNBmBH7NoHi/NAYTVPXtpazgyVeSbem
         ETEGsWn0h2h8dxtcd/0zplyEId7IvHCCAqqRHLETr4iL2Iv6n/6a+7zkvucM16mWQJIy
         hrCsFU3NnSEeR7DCgfEma3mU20Ab+5DcfypdTTdO0vOad+UHJWZ5aRSCFulqdqVzDMfb
         vxVp0qROTjpbV7yhMus04aotM9EfDzBgyvZ6POOiDstX/5X9zeG2n/sPo/n+mhpuE86m
         wiwQ==
X-Gm-Message-State: AOJu0YxhJhjou83l4S7LAjA8subksnz+NsBL1St2Az93b6rHri+yg+kv
	GtQTrN04j83U5ZpfbJfUm+6YqJ78zcVZ9JIsaiW6RlNnFKLfme/v7Chzrz199ti7/UQGDG8TvUM
	Dx6e5WKwZHro+AxKxfL7QCpI6BgOeH9Ix6pQuzlVDkrH5HzCbYvu3A932MyBpMaRKV1OElQlR9n
	Tw2RJyqhhsxB2SEeOkTWdDpzElK7zhFXuPuEV/JN8kafIQ48pT
X-Gm-Gg: ASbGnctBUukBzksC6vb64EtAhxNpCBNoqkgjLKFaVKi5DoIFTEYhBFDoKEX5xB1Q1sm
	hAr1BmWTi8uXizpyLdz7j71vZrKvsHLb4VS4kaDEpnQ4y+59CwrHABnVd5cVsSsXDWcA3qb5cSA
	vUa1UCeTWmueyL5M9+Db/qbZ+uAEIsE2V+nX8zCfXUyux8SCWmGZ1fQpgx8xuxkRK+8FO1X6DB4
	saV8nDXfU1eysA4KvpQxfOdU/jcPKpG8uplEDFMG39+86ABdQVy5BQpVUNv3vBLCOgd+eG1T1YX
	K94Iz/hE88Rxvnug6oOTZR7qoJ2lBq7D8ZCqCZ0rIVht6xLiGcmWcgOk+jipuvEBvkVoTa/sB0T
	eAPhNS6y8Z495+9BlwnH3+SDlAypT0kl98E8kOHF7C9JOh9Q=
X-Received: by 2002:a05:6000:310d:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a572e69d13mr12381491f8f.58.1750177093260;
        Tue, 17 Jun 2025 09:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy6w26SNF8JRiuV5RMogom+yqNk+oRLR2pX8ZZtPy7a4e3of9FalfrLKf1qQuD1a20chDIUg==
X-Received: by 2002:a05:6000:310d:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a572e69d13mr12381435f8f.58.1750177092692;
        Tue, 17 Jun 2025 09:18:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087f8sm14640954f8f.53.2025.06.17.09.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:18:12 -0700 (PDT)
Message-ID: <e7a6b0de-3f2a-4584-bc77-078569f69f55@redhat.com>
Date: Tue, 17 Jun 2025 18:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] mm: vm_normal_page*() + CoW PFNMAP improvements
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 17:43, David Hildenbrand wrote:
> RFC because it's based on mm-new where some things might still change
> around the devmap removal stuff.
> 
> While removing support for CoW PFNMAPs is a noble goal, I am not even sure
> if we can remove said support for e.g., /dev/mem that easily.
> 
> In the end, Cow PFNMAPs are pretty simple: everything is "special" except
> CoW'ed anon folios, that are "normal".
> 
> The only complication is: how to identify such pages without pte_special().
> Because with pte_special(), it's easy.
> 
> Well, of course, one day all architectures might support pte_special() ...
> either because we added support for pte_special() or removed support for
> ... these architectures from Linux.
> 
> No need to wait for that day. Let's do some cleanups around
> vm_normal_page()/vm_normal_page_pmd() and handling of the huge zero folio,
> and remove the "horrible special case to handle copy-on-write behaviour"
> that does questionable things in remap_pfn_range() with a VMA, simply by
> 
> ... looking for anonymous folios in CoW PFNMAPs to identify anonymous
> folios? I know, sounds crazy ;)

I'll mention one corner case that just occurred to me: assume someone 
maps arbitrary /dev/mem that is actually used by the kernel for user 
space, and then some of that memory gets allocated as anonymous memory, 
it would probably be a problem.

Hmm, I'll have to think about that, and the interaction with 
CONFIG_STRICT_DEVMEM.

-- 
Cheers,

David / dhildenb


