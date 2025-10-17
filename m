Return-Path: <linux-kernel+bounces-858232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60361BE955E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A75143494ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B702F12BC;
	Fri, 17 Oct 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfhKnP+8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE51F3B8A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712668; cv=none; b=Kj0g+fjxoGLZdKvKeVhpnLmMgSiqN1CUGZKVnhE5jeB9ugmir80VwjXYE/g/N73ExI2GQC6FYsdSfERm4ZA/kM2ddxMJsNz0H7wt7kzauv+3c/Jp549F+M8havCWAJfE8OaBHou/rPdbliDv8y85y5wpTeX9rZIlG1LHHpqJRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712668; c=relaxed/simple;
	bh=nGR9BmRbUdrK+/lXDMULtEjeiqF4g5IMGpWBZshjHwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZiCBj4H0e+a2ex8CqmRWewg4DXudbI/efu92sZas0wLB5RCsRvbWOpwoN/rmE7OtsPb8hyK6S49vbUZ1unhBbmNXOWqpVeP9br5yzBnThecdmxd9cT4z7unHptaY1lk1IWlXNQhB75ORKz839T5oxF3pV4lQQcCByAcNVYPA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfhKnP+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B7C9hu553OGC0Get+n5WL3qvSp6zoZqo26CwVK8246I=;
	b=dfhKnP+8INyOoH1rH3PqbZVfH6JgTkpsXf5CTmIzorRYkvnMRf3iUBSDMqjEyi+o2+m0Pa
	gQAFoIWozD3Oz9SmKAAc6EC6/9e05HymbJpRQrJfbwP5YQ6RKzf1nBZt5V+hZYFsqNupKc
	a/YXEMvBS0uuOqu9/wYu/0E8k3T47DA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-IkoZZ8TPMH-7dX1Spgs8_Q-1; Fri, 17 Oct 2025 10:51:04 -0400
X-MC-Unique: IkoZZ8TPMH-7dX1Spgs8_Q-1
X-Mimecast-MFC-AGG-ID: IkoZZ8TPMH-7dX1Spgs8_Q_1760712663
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so2656106f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712663; x=1761317463;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7C9hu553OGC0Get+n5WL3qvSp6zoZqo26CwVK8246I=;
        b=jro3HefGbrvaEEQMCK1a2uljd9p3U1yr7evDU6n+aJ2Dz+ZDIt9L4W3gzMkiOF+t/f
         2lmVY17C4/3NmAMveWTTEJwMqe+qhvpV9ldIPjuvs+z7o7iCiCCu3p+NbkVSceD0A2ij
         07GgEBLFDoR5g8TIRt3l+sUWpS24lhRUtE422yeSEJBjLQ9L4pj9bgEn7driwcUcNjtT
         TBQWNCiyve6TNzxTO85ExA0IkZeJZA79gYurHUzBytEbV8JblbjThHAqMtTSk03d6TdG
         c+rzYK+ZcAP8JNcGflWIOTKwBgGAIbXTUDwLPk6OnJZrzxGlRs76h7Dl4Na1qIqI7Jwd
         jx7g==
X-Forwarded-Encrypted: i=1; AJvYcCV7sKiDayew5Noo08mkp0dL7BDp0cgr3F29khNF8KUgg6Qmf1eSxTTYQX4N3Mht8wHCSOJEZfRVKZ4q0WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOUeU8629d71sXpY/ZHQ4VcBbBwMy0g8Npt2ER2cHaLgGNz1T
	zioRX2w8/0Q8MJZUCkCxlqT3l5SHuZq4FlaqlJOFB+zg/x046cRHWgvgq7jBfnGSBAKixStpUh2
	MTqm0AswMysYhcngAZp9/E2UaIJMp2N8wmRyuIX2nR7bVdCTc0976RB62Vf8b03qlxA==
X-Gm-Gg: ASbGncvAMYqCbT9EVCQrZpHsi/JEOSWfJszgmvwtPGbKjrnjhwsV2q91QDAtYHHYIda
	IFcvzX5nH2yQIY3n/DlyEen5jqNeNF4yeN5ozXmb2WoNT4FWs/VlEIqxUjXdGSqkbU0IP6hCm2+
	l4UzRJnZBbSGAL7E7cyKFfg1pHOOCKzKAIU4q+fs3WTq5c+V0k+2vdT8bnjzK8MdC4qtDxG0F64
	/XZ4bCFHcp272OpL7MLKpEygBiftwaIF2V9wUd1ggFsXk4HeCIr8Pok8bgkcIZ3xqD3/VLUZMug
	qGDGgzJ40DXapG2lH/VBxqVSVjVeATXqWWN0CfP8QiiVTDMMf2of9omqXEtgyisxKwntD31Ezuw
	PvXNi/KUgAHCRqQqZ5RMRJuWG6NHuIht3ZCQUMZwJZe0KxRL+tfCItL8jsBxBtqxWjtCvsRJTtc
	PLrG0Yvp1AeVGg8VrA6a+ita9PTfk=
X-Received: by 2002:a05:6000:4024:b0:3e9:a1cb:ea8f with SMTP id ffacd0b85a97d-42704da3924mr2740540f8f.52.1760712662810;
        Fri, 17 Oct 2025 07:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfNQMBiLauvPSM0faAjKqEzpbvcxmljg9bBT34eftkoiDWS2pQ9K9WkhYw53TR88fYTwa3Fw==
X-Received: by 2002:a05:6000:4024:b0:3e9:a1cb:ea8f with SMTP id ffacd0b85a97d-42704da3924mr2740519f8f.52.1760712662311;
        Fri, 17 Oct 2025 07:51:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42709e48963sm1964395f8f.23.2025.10.17.07.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 07:51:01 -0700 (PDT)
Message-ID: <1937040d-5e70-4d9a-b77a-261bf0f4994e@redhat.com>
Date: Fri, 17 Oct 2025 16:51:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: guard is_zero_pfn() calls
 with pte_present()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
References: <20251017093847.36436-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251017093847.36436-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 11:38, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> A non-present entry, like a swap PTE, contains completely different data
> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
> non-present entry, it will spit out a junk PFN.
> 
> What if that junk PFN happens to match the zeropage's PFN by sheer
> chance? While really unlikely, this would be really bad if it did.
> 
> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
> in khugepaged.c are properly guarded by a pte_present() check.
> 
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> Applies against commit 0f22abd9096e in mm-new.
> 
> v1 -> v2:
>   - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
>   - Reduce a level of indentation (per Dev)
>   - https://lore.kernel.org/linux-mm/20251016033643.10848-1-lance.yang@linux.dev/
> 
>   mm/khugepaged.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d635d821f611..648d9335de00 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>   		pte_t pteval = ptep_get(_pte);
>   		unsigned long pfn;
>   
> -		if (pte_none(pteval))
> +		if (!pte_present(pteval))
>   			continue;


Isn't it rather that if we would ever get a !pte_none() && 
!pte_present() here, something would be deeply flawed?

I'd much rather spell that out and do here

VM_WARN_ON_ONCE(!pte_present(pteval));

keeping the original check.


>   		pfn = pte_pfn(pteval);
>   		if (is_zero_pfn(pfn))
> @@ -690,17 +690,18 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   	     address += nr_ptes * PAGE_SIZE) {
>   		nr_ptes = 1;
>   		pteval = ptep_get(_pte);
> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +		if (pte_none(pteval) ||
> +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {

This now seems to be a common pattern now :)


Should we have a simple helper

static inline void pte_none_or_zero(pte_t pte)
{
	if (pte_none(pte))
		return true;
	return pte_present(pte) && is_zero_pfn(pte_pfn(pte)
}

initially maybe local to this file?


-- 
Cheers

David / dhildenb


