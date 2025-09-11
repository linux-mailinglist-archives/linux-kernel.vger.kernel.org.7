Return-Path: <linux-kernel+bounces-811725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D20B52D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05160188FD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86F2EA164;
	Thu, 11 Sep 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYIyv6sW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F12E8DE1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582473; cv=none; b=rBvxBMihH2E/LJbYMMRZncCoMJq9p5dmPZlFstrLuzkPhn2/DnksKx1Sk2PvgimysOE0sDBvzBVykC77UqBxPhPxJwzCFZuk4F27OIqdMEHfjbLngoPp6buyUxC/w/AI6c76G6eTkObBvZPbQIimMRTDO+0oKX6t9JXVaQwa+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582473; c=relaxed/simple;
	bh=8YkIvKUOYlRbneRzvGr0TIgkm2nND7ZQ6FrOaBHqD50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oD8Ck85J8bwuNX5VE7FrOUVdulFNIHOlTH5prHZ1E9GvXUp16l8tOX6sxm1+arq132JnYG4CqBhb+KB0ML9rgNnXICe7AbeJ+rP+sPaPJ3tTMaQYrGwrJEKfno/JzTrrLaMBh1zc+kMYj7XSJey8e+XP5aKeDX1qNsDfcC6mnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYIyv6sW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757582469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wx2VuKFN5l2ZKUiBY7O9oVouFRhc9i2w8paZkQJvRtM=;
	b=EYIyv6sW60cP9zjjJ/xdw9Ic2sBdDK25T1QxL+u6cotKtAbEs5rjPHZnQdNGVcsptbuBP9
	LKRLposkfiUIgTnxJ3uftIpTJMfa1uAwZg+5sn5vTN/Sgn75tONgoq5lWzXmRgJkzkQcot
	xk8q17CX5D8tyDoFcufofIm+tvKJ2SI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-DX_Oo-FyPsqwsjr4KPx9rA-1; Thu, 11 Sep 2025 05:21:07 -0400
X-MC-Unique: DX_Oo-FyPsqwsjr4KPx9rA-1
X-Mimecast-MFC-AGG-ID: DX_Oo-FyPsqwsjr4KPx9rA_1757582466
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e38ae5394aso396659f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582466; x=1758187266;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx2VuKFN5l2ZKUiBY7O9oVouFRhc9i2w8paZkQJvRtM=;
        b=K5G4BMSyRbmjmd7xYwv4LGgE8/vQcYoC+YiRw0zfb4SGd9HGNkrqJCXTvrg60uux2Y
         kWhghpxmbdiCGBLn/OvRiLRfC3x8R29Nd+pp71qDpVxWtxaC7nOCTd9ERm3LyeQb0ecB
         /2rHsgsTDOCyBcQ2ReDrx105pIEsVq5hIkeagl+AgerwR2ygvhh7XRC+cDKKrrnhxvzF
         e+ayi7LMovZPZ+4c8/h7ts/NHAMN/aomJtJXINclLtCBOhMEeiJ2m1scaRxTW4wXSPPU
         nu3yQIJtQIUh3UdQnbZoOOONzZvQV80Ay9xvy55AhNdxRPYYViJPj+WKO4XqbjIWyeaI
         mfrw==
X-Forwarded-Encrypted: i=1; AJvYcCUFqTU0IiMA7kq5zgWBERNT+zQ+wieAHfAZumkogNhl3JZCF0hZF6VtGI9B0KjeEb+mqerx4TQR0uieykE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+huf+pa+P3LVlELvD+2J5+rR+UtLbZg5KAtIpDgNnRjwnixmJ
	ddmfVmMiOaZp/wujMjZ6zYesFECQlvu6fyqyvRzeY/9jiZ5U+LzAuUYmMLeSKb/qUoQqy6HJRkc
	MvTp8g+k7N6TkxplZ7JZOueQTQRVx6DwOIRBCNaoBtY1gyjYMqNtW+31y+1uNIRLJYw==
X-Gm-Gg: ASbGnct+OQWv60YGQV21jMbBZDl4Q2ngXSY9NpAoy+KHJUIwE6EVX7pnVtKy1simiU/
	WfCR5/MnRCWIb5jFGb336PMHlvP8W2udDCQoOTCKlpm8lNknR6npltWC9z5CRY6UawkKxznX+bn
	TLXC9sqmdeXctgtq06pST+tqyOkgAlGTV2Uo5wPyy/wjDWeJGryvRIxISmK6EwDjpH7Y+fid9za
	mG1xzbR9ERrN5iZYADagRkLZ68xMcPp47uCe1pWU51eQjvcBjhxuzELIn6kwg80pp5GvSzs1oZt
	tqIiL7bLNNq9iGAZ6LQ34XMfJLSXA+6ciHk9wi9pwNggjHiZXz0LItB1pZ2yUqdM1jdavseprvs
	y0kK9+mm1k/FudY9qke/zUmdqGZ4z1h5St/K6TFzosVoXksmW1WycgUqt0yUNXzRhguY=
X-Received: by 2002:a05:6000:178e:b0:3e5:4da4:d883 with SMTP id ffacd0b85a97d-3e64392d44fmr12834679f8f.32.1757582465814;
        Thu, 11 Sep 2025 02:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHyUavJICeyqztmPEQghHdLocWjpJqN/HeJo81P2eWSfishVTQf6+EKdsobdy2aaseNe4rzw==
X-Received: by 2002:a05:6000:178e:b0:3e5:4da4:d883 with SMTP id ffacd0b85a97d-3e64392d44fmr12834646f8f.32.1757582465337;
        Thu, 11 Sep 2025 02:21:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760776badsm1739785f8f.5.2025.09.11.02.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:21:04 -0700 (PDT)
Message-ID: <e58b16ea-3018-434e-9eff-eb6cdeef4429@redhat.com>
Date: Thu, 11 Sep 2025 11:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] mm/mmap: Abstract vma clean up from exit_mmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-3-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909190945.1030905-3-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 21:09, Liam R. Howlett wrote:
> Create the new function tear_down_vmas() to remove a range of vmas.
> exit_mmap() will be removing all the vmas.
> 
> This is necessary for future patches.
> 
> No functional changes intended.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/mmap.c | 37 ++++++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b07b3ec5e28f5..a290448a53bb2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
>   }
>   EXPORT_SYMBOL(vm_brk_flags);
>   
> +static inline
> +unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
> +		struct vm_area_struct *vma, unsigned long max)
> +{
> +	unsigned long nr_accounted = 0;
> +	int count = 0;
> +
> +	mmap_assert_write_locked(mm);
> +	vma_iter_set(vmi, vma->vm_end);
> +	do {
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			nr_accounted += vma_pages(vma);
> +		vma_mark_detached(vma);
> +		remove_vma(vma);
> +		count++;
> +		cond_resched();
> +		vma = vma_next(vmi);
> +	} while (vma && vma->vm_end <= max);
> +
> +	WARN_ON_ONCE(count != mm->map_count);

I would just do a VM_WARN_ON_ONCE() here.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


