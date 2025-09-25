Return-Path: <linux-kernel+bounces-832125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A0B9E67C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D321BC47D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366582EACF2;
	Thu, 25 Sep 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArBjsOVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88872E9ECF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792827; cv=none; b=HU2EQBxDVJElxonwZiCTx9PoQINmZZ6RYnxCsvDjPDWKunxXkZSmkCJM3nDMAtTZ7DU4fN1wLcs/ST5Bp5scaD/tkFcbSIRfS3Vb57tXG0TXYaDYZheMHlOez7UwMKDTPVOdBxmLSONv6K2ACXcVWOOzPXyWiYxEdxWraHmsMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792827; c=relaxed/simple;
	bh=wgFW2Qy2mAdqpU7Ouy5ArqSzkyXxatRw2BRfBdgtwhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3rlpHNzxg9DWzZtQEUz4OL8HorgR512OB+9APh0cmXKGMxJPRaf9bvaeTZfvNduVm9XYYLLNCefrDpmeTe6TWwscjGHWw/AGdl4a/VwwLKSPSvGRIFCJNuTm22rn9LFgbzy8ghPky8KvBopXhZcNVYok003yQAMGyFTn4It4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArBjsOVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758792824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UQxV2N8dYSlRevMplPP+7X68Vqzpbc0LIY+aAribQjo=;
	b=ArBjsOVEfL7M7O0+ETjNVFKtOvB9GGcI35VFEvnJGzd07vOL50kQ8+yD2agEdGbK5aN92p
	OXRP824Tz7IumlHT/DkTyydQ0RNkzX+RY49VwDoi0z4kxmriDbLqzon4GU5U/HI3NphtO4
	uIqCyXuLXTSSPrCv8zzR2Fas+ZtSmM4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-hyYyIXVsNAqqiN7UuTOckw-1; Thu, 25 Sep 2025 05:33:42 -0400
X-MC-Unique: hyYyIXVsNAqqiN7UuTOckw-1
X-Mimecast-MFC-AGG-ID: hyYyIXVsNAqqiN7UuTOckw_1758792822
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e23a66122so5270025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792821; x=1759397621;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQxV2N8dYSlRevMplPP+7X68Vqzpbc0LIY+aAribQjo=;
        b=RYrq9Zuz+X1bcfay2LYKosuw6zJnl/O0+v5pUKIh57cPOSoLkje8GMrY2dUa5in59Y
         iRvbxxyOhHJ1ZbTKCfHl6kNXYgnEESB3lY1j6xJavpehIZrqA6PgG5eQOD1at5X+YNwv
         WpWWc484YmtDruIIzexoOBxIIzHfwLeT+yYQxhgdbr+/vLqZ2ZkDj+kLCc/5aRB18q7M
         UzS0RKPbTnog0WNoEcj5noD8FUaApVxJNFj6IKxCnQod64vUhHkhSktjYHuY48tgqea3
         wIwJL+B0lMoxHtmHnBPEalRFxs2maT+Typ/oAG+HE7ULTWfkNSJjJzBW90JtK3tByjkw
         Abyg==
X-Forwarded-Encrypted: i=1; AJvYcCXYziYMEpYEslpNTqelnKM9wzKTtAMxdq8+1WtiNkfpGA/RdkyLv8aOvuUJtprAvE71T/9ohs/eGF1v3o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09qYAjC5qoXbD6ICu9FqRCGUpVndeWK89rU1wSG50w0VqD4ax
	CuzzHYaq+oMUvyX4hdI6Kw1lgrIGuMv8L1/SVgR3Ui9A5If9fSQUqWqF0pIN78oszkFyd78MaCE
	1Uxqts6TQ9k6r2/uUfuCVMCR5Goai763EeDahG4ZZFp6x84awK4tHecE0qqgmWV3nKQ==
X-Gm-Gg: ASbGncsy3gBiI7CgOYdmLjQfRhj9q8Z9F+iGUILqu2Zesbl9/kXtqJEixdsvBIki8Z5
	feOqNfMP68QZwWTkwbvRGOJpGbGnpUtDWkeuWkHeiP+WjBkX/9kS1yNurQUrCapvg/TbOJ09HAf
	aD8rAo06yVi3Y69vmqfLRMRALgzNgVnTcdpdph1jQsRva3jO+P73y9HLseTtk/bdRvV8VlS9PlH
	xoQxH6kcdjl0uVXaDA2G7fEIipZfrNZ39VnM4pbXiPlf8I2+Rh2cwKgYfjsBL+xYRNGCqZJHmUS
	/IH3bMFSAVVa0MXWHgoKCBBaK+8BhP3bksSurJ9sRuTGzGBYSPswOutb+SFEZbm3bol02oXgFPL
	2lOdI15Ks/yAI0EUa1NfTffeNe2FWy1k6F70UQFkEYuwVKIePLsBVgmpkUD029Wk3ENfk
X-Received: by 2002:adf:a3c9:0:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-4103a4f171dmr1075310f8f.20.1758792821516;
        Thu, 25 Sep 2025 02:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZcXl4pYQPZQ0U4/pa9bQrhuaKgjWJziO9jJ5iUdtLGhTCrjOfRbjX4KoPsMAZSVZkv1fopg==
X-Received: by 2002:adf:a3c9:0:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-4103a4f171dmr1075287f8f.20.1758792821120;
        Thu, 25 Sep 2025 02:33:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm2265662f8f.24.2025.09.25.02.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:33:40 -0700 (PDT)
Message-ID: <c24d7fdf-4c4b-4379-a538-ae5847bf57e9@redhat.com>
Date: Thu, 25 Sep 2025 11:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
To: Kiryl Shutsemau <kirill@shutemov.name>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250925085429.41607-1-dev.jain@arm.com>
 <427kxhljdcrn7thput727j6vpqvxtalistn6yoq6ykdpbe5435@sn7a4rh7zcdo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <427kxhljdcrn7thput727j6vpqvxtalistn6yoq6ykdpbe5435@sn7a4rh7zcdo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 11:31, Kiryl Shutsemau wrote:
> On Thu, Sep 25, 2025 at 02:24:29PM +0530, Dev Jain wrote:
>> At wp-fault time, when we find that a folio is exclusively mapped, we move
>> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
>> reduces. This is currently done for small folios (base pages) and
>> PMD-mapped THPs. Do this for mTHP too.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm-selftests pass.
>>
>>   mm/memory.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7e32eb79ba99..ec04d2cec6b1 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4014,6 +4014,11 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>>   	 * an additional folio reference and never ended up here.
>>   	 */
>>   	exclusive = true;
>> +
>> +	if (folio_trylock(folio)) {
>> +		folio_move_anon_rmap(folio, vma);
>> +		folio_unlock(folio);
>> +	}
> 
> Maybe take the folio lock earlier in wp_can_reuse_anon_folio() to cover
> large folio handling too and avoid trylock here.
> 
> Something like this (untest):
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 812a7d9f6531..d95cf670b6a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3843,6 +3843,7 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>   	 * an additional folio reference and never ended up here.
>   	 */
>   	exclusive = true;
> +	folio_move_anon_rmap(folio, vma);
>   unlock:
>   	folio_unlock_large_mapcount(folio);
>   	return exclusive;
> @@ -3858,8 +3859,15 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>   static bool wp_can_reuse_anon_folio(struct folio *folio,
>   				    struct vm_area_struct *vma)
>   {
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio))
> -		return __wp_can_reuse_large_anon_folio(folio, vma);
> +	bool exclusive = false;
> +
> +	if (!folio_trylock(folio))
> +		return false;

No, there is no need for that.

-- 
Cheers

David / dhildenb


