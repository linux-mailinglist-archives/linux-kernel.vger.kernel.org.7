Return-Path: <linux-kernel+bounces-872463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25893C11443
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98146563807
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BB302CB9;
	Mon, 27 Oct 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF9BPKc/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B007302158
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594072; cv=none; b=sEM5SJfd6W/4uXn+43ZKKO/tyCMV/IxdqpgI0hy5H5QfMteJKd1I/zj6FtEjnAMuhCNIkiwqAU1xTOvDVxA/Du9Yp0Vi2mhjc6ToAGBrELdIzbRDzsu+7DNq6tFU4lYrZ1iXiVAdQDTRCNTMCKsE011uuN1QdcIHi8hSP15iKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594072; c=relaxed/simple;
	bh=/xkVXx7Cs9/8F3UhthuFOfV14IyD5VXNGwTKofvch7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8zT7G1RlAwWY4wAhOTce2PkX77YquhUS/zDi+A9wJT59ugD5882gDTEzmGLe/iEKsFBtoohEOeH+8/ZJw97ymnhMBKT+GakRPNjSNktTnwEZX+T7UyOr40utdvo2VYU/51CVM7nrCfdA9mcGjoFWlJLKd8n+wEt1SQCy+srJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF9BPKc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761594069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sQQG1U8D9NRn8/WCZbwr1i1w57XgvAobXv1AZVxyG1w=;
	b=MF9BPKc/b73yzQqpUwNTHh1uKH2gx5sbZOex0Zo92fr5jywbwaxxOdyrlYeh29CDay8ikJ
	o2Qi4y33YuwvyYECObTNgVGSjcUWm5PfmAnILnLOLJdtLOoz6H5et3CBfNBrcP9GrPn2ie
	L0HOMnBvrWQqnp8I9Ksn7xrOs+8R1s0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-0buzLZfWN_iyO2P7h13bdg-1; Mon, 27 Oct 2025 15:41:07 -0400
X-MC-Unique: 0buzLZfWN_iyO2P7h13bdg-1
X-Mimecast-MFC-AGG-ID: 0buzLZfWN_iyO2P7h13bdg_1761594066
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4298b58bd3bso2545624f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594066; x=1762198866;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQQG1U8D9NRn8/WCZbwr1i1w57XgvAobXv1AZVxyG1w=;
        b=tfYGwLAJV/IhxXHMoJPqZILnr0TuyP3YKLLmDBAdR912s6Yuu+aMiaxw+5eaKxvzmI
         hZL7+JjOh5ijfzQsY50yJenpMi8odlRGzs4Opfq3JWBfQCaktaafo6A5KVJqnuD26Z5H
         GnIl6fIGQ0GKG/O7ZqZ2wkZfOXEoGVvKzjDBWjP+8S4Q+/NwLYO8/a9KmjmyVEUxKOxu
         uCQoCpvXL8dsbsRtIG7DWnZkk1TcT6d4HUa8s2BjCR2RV4THoqstBUfdJzi9pQmeKV4h
         Iq7CWhbtXF4gpGk21i+zs9n4nJXisQwNnxkTbcWiP2s2HPS0WouXZQtmzjkJFHkeEkqe
         H55g==
X-Forwarded-Encrypted: i=1; AJvYcCUrWMtNve2HHFN+sIALy+3XaE5bU0mz1q3wos9Rgp6RZ4mX60FhRcbhS5zKT3Ebm9H5NpX+sQ3TyJN6Ewo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRm+j9fu90z4PGOw9ldXuYIof6dkqeMrmdSiKquqahcRHUknLV
	EtFaiEreIPDrb6B9k6vTJPloY0H988rUiJUa/dWlg+TQg38T456WdtLLEZZLrIQpb+e7WQpSD8X
	/UlWnyduRefar16lo6XyoXsP3KTq7o6Ors34MdLoi6oqSzS6g1cIC9090P8d5sprHtw==
X-Gm-Gg: ASbGnctpEVuWmBoVeDuSZ3bGQnhAS6IwKoWNmxtgvbH7qxH74Ica/2qtoQ/woj0d5Je
	bCQFnFioeSp5qvVzdxD7Lfkz5D+nC/IsgNW0Iq2W4dUbdtWSVM0NihDg+VGmazcNlJVGj5Rxyjy
	vuOt6aw8EB0iiOvSXTWLqSvK4o846ux7ywfIeOdg2Y2PGn6INkJqmnLZJbrsZ2g+peOUpMnsPAT
	RJ/lBPDJPgZCgjQSFPQT9vixaKWDx2AdGUWNVpM3GtwFs1rEIhkzwFuWYziac2ZYPpvHtfXFHu5
	3D3vlMzHN0ybakLJaL2b89LIRr4mErmdEZNKwwghzZx6ZT/yN3XbVM8LzE3WKrgIUHI98fRFdGU
	NpRWxr2w8lycxroy0lAMSRIzo671vYhmHtqrTWvvOV5QRqWOLwKgtXLn4TPkcGEWwFi14F6HUyf
	xO55MEaaUkhJL7chO9J7j2CLh3MKo=
X-Received: by 2002:a05:6000:1789:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-429a7e82d3emr835399f8f.47.1761594066249;
        Mon, 27 Oct 2025 12:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVV7ZikNBr8078iLXAz6FTXXQLRURl8SrPF+kjxb0I+lt95sxQQlqW53H9ifqttFJc1n2uNg==
X-Received: by 2002:a05:6000:1789:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-429a7e82d3emr835372f8f.47.1761594065760;
        Mon, 27 Oct 2025 12:41:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9d1sm15723309f8f.35.2025.10.27.12.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 12:41:05 -0700 (PDT)
Message-ID: <13945f06-f862-4f80-904a-f2a4ccff3e4b@redhat.com>
Date: Mon, 27 Oct 2025 20:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] mm/mremap: Use can_pte_batch_count() instead of
 folio_pte_batch() for pte batch
To: Zhang Qilong <zhangqilong3@huawei.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, jannh@google.com,
 pfalcato@suse.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
 <20251027140315.907864-4-zhangqilong3@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251027140315.907864-4-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 15:03, Zhang Qilong wrote:
> In current mremap_folio_pte_batch(), 1) pte_batch_hint() always
> return one pte in non-ARM64 machine, it is not efficient. 2) Next,
> it need to acquire a folio to call the folio_pte_batch().
> 
> Due to new added can_pte_batch_count(), we just call it instead of
> folio_pte_batch(). And then rename mremap_folio_pte_batch() to
> mremap_pte_batch().
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   mm/mremap.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index bd7314898ec5..d11f93f1622f 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -169,27 +169,17 @@ static pte_t move_soft_dirty_pte(pte_t pte)
>   		pte = pte_swp_mksoft_dirty(pte);
>   #endif
>   	return pte;
>   }
>   
> -static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr,
> +static int mremap_pte_batch(struct vm_area_struct *vma, unsigned long addr,
>   		pte_t *ptep, pte_t pte, int max_nr)
>   {
> -	struct folio *folio;
> -
>   	if (max_nr == 1)
>   		return 1;
>   
> -	/* Avoid expensive folio lookup if we stand no chance of benefit. */
> -	if (pte_batch_hint(ptep, pte) == 1)
> -		return 1;
> -
> -	folio = vm_normal_folio(vma, addr, pte);
> -	if (!folio || !folio_test_large(folio))
> -		return 1;
> -
> -	return folio_pte_batch(folio, ptep, pte, max_nr);
> +	return can_pte_batch_count(vma, ptep, &pte, max_nr, 0);
>   }
>   
>   static int move_ptes(struct pagetable_move_control *pmc,
>   		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
>   {
> @@ -278,11 +268,11 @@ static int move_ptes(struct pagetable_move_control *pmc,
>   		 * make sure the physical page stays valid until
>   		 * the TLB entry for the old mapping has been
>   		 * flushed.
>   		 */
>   		if (pte_present(old_pte)) {
> -			nr_ptes = mremap_folio_pte_batch(vma, old_addr, old_ptep,
> +			nr_ptes = mremap_pte_batch(vma, old_addr, old_ptep,
>   							 old_pte, max_nr_ptes);
>   			force_flush = true;
>   		}
>   		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);

get_and_clear_ptes() documents: "Clear present PTEs that map consecutive 
pages of the same folio, collecting dirty/accessed bits."

And as can_pte_batch_count() will merge access/dirty bits, you would 
silently set ptes dirty/accessed that belong to other folios, which 
sounds very wrong.

Staring at the code, I wonder if there is also a problem with the write 
bit, have to dig into that.

-- 
Cheers

David / dhildenb


