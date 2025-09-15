Return-Path: <linux-kernel+bounces-817109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51380B57E11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966EE176518
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9828980A;
	Mon, 15 Sep 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEhWfOIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AA207A22
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944388; cv=none; b=IgstOcT0gIH6ajX40mpASbDLyUm/9gT21kL/Mt+ZwjxItPiRBBbcHVc5/3rcjPne5EQ251sQuwLmVAbOLKWezgMYtQ2UvY6q+ZGjemn2gzmAkrcfHOAyikCQDbKolJNCx7bu7CwiJycSHeaGiivkudFKnzoDHRT2NKgUxVcOt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944388; c=relaxed/simple;
	bh=Rov7RRW34U348A8wlFFF4LWXqJ1I96X2aoU0qQpHQIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFXnrqa6eilVPuMgPfobmVg2Kd8X2yOJhIOI+1n2ZUjrb9/nlRHBadUhwdx6TJPSQYk7Lf9GaSWaUwi2/hPIXGximjmAR3Gu09AiePcGuJIEVtIYJxqaGnUzdVoYCW62Pcr+quf1gAA0WLVqu+coO0H/mKt6/BcruaOInyJ2+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEhWfOIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757944386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WLlYJinc0dfQVpvH1UOH7RnaSWYBlLeAZhMVXB0T/UY=;
	b=fEhWfOIT2dmVkvFNBtqhdK8QM7qVLzWu7dNX4RNZAPpIsCrOimkNyYSwjZVDY8YyKdcjx0
	4LCIItV65fgKyVyyylCnRRANcANisBZKcWUc3FQLtosOMcdPv6S6UiHrdQsCCgRL7Fe3Yb
	VFUqBDbgVCJF3KRHgcHW6wojPMFls40=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-WsJCxUuiMGKzkdbOjquJcw-1; Mon, 15 Sep 2025 09:53:02 -0400
X-MC-Unique: WsJCxUuiMGKzkdbOjquJcw-1
X-Mimecast-MFC-AGG-ID: WsJCxUuiMGKzkdbOjquJcw_1757944381
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so19625905e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944381; x=1758549181;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLlYJinc0dfQVpvH1UOH7RnaSWYBlLeAZhMVXB0T/UY=;
        b=WDOVOL8arUhnVwau/oI80CjhrpX7UnoqkbUY7RvW85xLcvwCsAtPTwrE+ApkFK5QO+
         KzNXMCm/+D6Cin1bg2v7g6rNP+NYlpGevlxZ9R01AWTaIQkibk3svLgMqF+5iekYstrT
         Lc8n47ZhAXyyDZppkLzBjQeHlJrOHrByWwHDJTSiZs8Qoo5sQvYcOmEfhUjkAQJsUmuu
         hmJ2kWSfiKt+dDyCXPCT7ifB2NwlGrnaqoNopngosSbG/vcasTPga+jqOPoHAhjM9j+6
         dRqK/Ium8cM9rGIdaWvHFCgnqCiRCiufB2jMs9Z5Q+BI+mH3nfz7in7Up+5gZmN4Jkgb
         Nr1w==
X-Forwarded-Encrypted: i=1; AJvYcCU0bgAMlcbopR2vbvHzq4z9yYv9+BbQiOt/2mVhjzy3wgPUYs5CaUO9rNOjPMapw74G8ZTlOFYIJQ07FVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Ym+02/rQPc77dj2vDDkfr8Y53q468ZT1h1zLlUutDNq7MPIi
	tGv2HM0u1509d9mZQTzCssXaIS93a6GC/WJdqamSOtteuF9zQVjxYM8QHsyqYy5hspT9/S4w51n
	eJXNo8RJFkJyLRoCkHcV8PalW1txBq0fQXDsRm48A3r8GPEzfYt9x2Qo574lJ6PdZKw==
X-Gm-Gg: ASbGncscsRa9ueeLI5cQnWjEstNYewS7uwYq7If7DncX8RlT6IeRRZCA/DBrYl+GT7D
	V5fIamkJ6cqVnqoYBCtitTZHbfUFuoIGth1upDaEBFnVeEI7hocIwJHjo5dc66iJHJP2d0BXQqk
	MKzfhBxLSPK6kDizyFEmHs8o4iNzmH2JFBqviM+/6mQFqqD5Qk4p/tZyZ2vS/VFHCFayKRi7g45
	KKYbrBNCt9gcYFv/vmDg3VAPJCXmM1CEazJ6yYpDuFP2xWZ4ydWdEshnFQUuE/GMN1o3ma+j3j5
	X3tQ2V5b7eYBazGP7FYdboBAXtY4lYEHMLJ+MPutgWOrZkUGiTCpIJR4Ig2wEWtH9X3ie2f22ah
	xs0qfgL4edhy0Rmx61QyX2SupFQPU5skNopgmn+TUe6p/e6YT4WJFi5Ltwr4SI0iIzqI=
X-Received: by 2002:a05:600c:354f:b0:45f:2c7c:c1ed with SMTP id 5b1f17b1804b1-45f2c7cc3dcmr34398735e9.2.1757944381506;
        Mon, 15 Sep 2025 06:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcLx/v+RcvjN7afogw7EpWBGd7QAXnqzzVsXD0ZOV8pq1yT5xn6CvxOmjMR8tWQ2JOMsAx5g==
X-Received: by 2002:a05:600c:354f:b0:45f:2c7c:c1ed with SMTP id 5b1f17b1804b1-45f2c7cc3dcmr34398405e9.2.1757944381060;
        Mon, 15 Sep 2025 06:53:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm179952405e9.21.2025.09.15.06.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:53:00 -0700 (PDT)
Message-ID: <9c66e21b-c782-4ed5-b89d-0d7412ef3c85@redhat.com>
Date: Mon, 15 Sep 2025 15:52:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 1/5] mm: softdirty: Add pgtable_supports_soft_dirty()
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-2-zhangchunyan@iscas.ac.cn>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250915101343.1449546-2-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:13, Chunyan Zhang wrote:
> Some platforms can customize the PTE PMD entry soft-dirty bit making it
> unavailable even if the architecture provides the resource.
> 
> Add an API which architectures can define their specific implementations
> to detect if soft-dirty bit is available on which device the kernel is
> running.

You should probably mention that we are removing "ifdef 
CONFIG_MEM_SOFT_DIRTY" in favor of pgtable_supports_soft_dirty() checks 
that defaults to IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) if not overriden by 
the arch -> no change in behavior expected.

Then you should mention that we make sure to never set VM_SOFTDIRTY if 
!pgtable_supports_soft_dirty(), so we will never run into VM_SOFTDIRTY 
checks.

> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   fs/proc/task_mmu.c      | 15 ++++++---------
>   include/linux/mm.h      |  3 +++
>   include/linux/pgtable.h | 12 ++++++++++++
>   mm/debug_vm_pgtable.c   | 10 +++++-----
>   mm/huge_memory.c        | 13 +++++++------
>   mm/internal.h           |  2 +-
>   mm/mmap.c               |  6 ++++--
>   mm/mremap.c             | 13 +++++++------
>   mm/userfaultfd.c        | 10 ++++------
>   mm/vma.c                |  6 ++++--
>   mm/vma_exec.c           |  5 ++++-
>   11 files changed, 57 insertions(+), 38 deletions(-)
> 

Good! All relevant CONFIG_MEM_SOFT_DIRTY occurrences seem to be gone 
now, which is nice.

Nothing jumped at me, hoping this makes cross-compilers happy.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


