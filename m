Return-Path: <linux-kernel+bounces-674204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA82ACEB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF973A7D05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98F1EB1AA;
	Thu,  5 Jun 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyjbzO8a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346BB1DC07D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109631; cv=none; b=gvkiaBux0+rPeahIp7bGzGJ3WZZVrw6U4swk+/mRrsF1XT9Jot3lhZHCKnmz5dMn2fdDKCbdMxofmVak0f0XOfi9oyL+8su7DqInNWKzG/ZI8ddv7oQMSrgYTuqaAkjlvfM1VCGdEiJtQ0dp+YvWdbf/HwYBd9obvzqhdZDmvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109631; c=relaxed/simple;
	bh=FhkTk/WKfG5f0srZ1oGA+K0Wub7dk6fYTtDpmrQyqSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzE3X37+NkFxJryQXQLT+VKUmdRvSKvLf1hxVd1k1Lu49W4TutpY5d5OIjgZRd5D42C5OmYyBxw5yi3Fr3pGQefj/a5fCOWuZy887zzjPjI2b4ggLSJDHoRdIW82ZJALPRCesIa/4f581vQ/cq8FSIuycyXHHL0QkatUPKxv0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyjbzO8a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749109628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BNCAVSpJXh/o+ewQaU32BKixyPokxZNp2s0CedjuqZA=;
	b=GyjbzO8aV8F7TA+eiLLBMe4bnYIQXcoCoA385jg0q16aiVGeFodIN77ccwo8qphkevXoJs
	rMIpmBXQ7m4pwFgVZpSKccxFPP7F2AloD1cyDUrasolTnxchXlbR5dZwN0RafAXRk9zAtu
	cdg9j7gRBDKH6ETLzqpXYEftnTopDM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-ilUIKEUTP2-wNUO46c36Cg-1; Thu, 05 Jun 2025 03:47:05 -0400
X-MC-Unique: ilUIKEUTP2-wNUO46c36Cg-1
X-Mimecast-MFC-AGG-ID: ilUIKEUTP2-wNUO46c36Cg_1749109624
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so286953f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 00:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749109624; x=1749714424;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BNCAVSpJXh/o+ewQaU32BKixyPokxZNp2s0CedjuqZA=;
        b=U5hT4wzX2vPNXK8lFW/bhHgnu8HmpywhzH5nDF/QSiYVJxRoCO08f0T9UhcEag6Ki+
         ZVrZ84vLtV0cSpY7e9W3Jzh/mvvLbTmF2WW9NsUk1YHoVFyyDPnkDJESLCVqR5qeRGfF
         hh7zpjaJ3RDl/CUG3F9kM9XY2nnVBvaNoxy1hUNe1RT/OlHFykMyet9hkPvmmsFMJo+F
         9A2aELCy1ld86Ta9kvrGjqzZMAcG/jo8bmF2b4gh7VOywMjnDxONFJnVQpY4YFhJ4YPM
         39gFozQyg7XQFxUike2KY6iKLCMeVIJnGggNlRqOLaAMK/l1U7sEnDxTy3qCxBE5BLbb
         Uhcg==
X-Forwarded-Encrypted: i=1; AJvYcCXK6tvYDH5GK6X6DIGMJDcB5nCaFTlRYfAsFHT2BN/fi+QvzU7y+tBK4oq1YL2j6LujGuRUOVFkwSc7zo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgsoUUpBDO0GkZ7PvP1pIKfyANLOZcvSemqpiXUsV+Z3rjDMqB
	M+XGVI62Yr0j9GdzMOg3pmDA6KSwQwLgEi0p6PFh8Q+d/Y7QdASsXV/DlBgj4qw5OKkjcI7Xtbn
	4LKjk3O6H8DNXusVZ+Z8t6aLiK0TV75IMa8OsMGz9gf/m+2c4x4HPAj4LOeiDSrkqVw==
X-Gm-Gg: ASbGncuMbezrk3aeDGh0wPrZ4n7Gx/TdfiyUj+GvPE6HVQWo3er8yRvGRy2/5HpkeKP
	HFY7wNZyRPnIdO3ZpJH42ad3CVs080jqowWIG4owSbXs5uGyxBlk3hbYaiX5b1fuvoxg1RIycGv
	Icg/FIzvqZ7zQy0oeWovSxpFhTGHSz9qwIsF8d96JcwHlFUlFLl9Tl24O/NoaduKadr+IoGVe3y
	jSXOIztPAiJjxayw5fzLInYka+e8vy0OXB70GSdXhzfFX2x33BLAQmG70dMBNf7+YYv2wOw2kPC
	Q+9vl7lKyde6Fzy1h4bh1jp6rFf62joETNxMw6hnC56KkD6/EOpeOxeX+6lIC7vsIReplvMA2rX
	ZDoiu7jB21L57YNcDtK9A0CoHwW7eqhbBAy8X
X-Received: by 2002:a05:6000:1e52:b0:3a3:7753:20ff with SMTP id ffacd0b85a97d-3a51dbf715fmr4102341f8f.35.1749109624119;
        Thu, 05 Jun 2025 00:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKW5Vy6rvHU4tuAc9hNiYrFzw0cH5ZBqlwWRS7YJXQsUQupDovOp0p7SPbZ/AnZh5B2Orkug==
X-Received: by 2002:a05:6000:1e52:b0:3a3:7753:20ff with SMTP id ffacd0b85a97d-3a51dbf715fmr4102321f8f.35.1749109623707;
        Thu, 05 Jun 2025 00:47:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2? (p200300d82f27ec004f4d0d38ba979aa2.dip0.t-ipconnect.de. [2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009752esm23716613f8f.74.2025.06.05.00.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 00:47:03 -0700 (PDT)
Message-ID: <1bee21f5-6c59-49c4-ad3b-74e6a0ad6ac8@redhat.com>
Date: Thu, 5 Jun 2025 09:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gup: optimize longterm pin_user_pages() for large
 folio
To: lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, dev.jain@arm.com, jgg@ziepe.ca,
 jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 muchun.song@linux.dev, peterx@redhat.com
References: <20250605033430.83142-1-lizhe.67@bytedance.com>
 <20250605073950.1834-1-lizhe.67@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250605073950.1834-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.25 09:39, lizhe.67@bytedance.com wrote:
> On Thu,  5 Jun 2025 11:34:30 +0800, lizhe.67@bytedance.com wrote:
> 
>> @@ -2324,16 +2349,12 @@ static void collect_longterm_unpinnable_folios(
>>   		struct list_head *movable_folio_list,
>>   		struct pages_or_folios *pofs)
>>   {
>> -	struct folio *prev_folio = NULL;
>>   	bool drain_allow = true;
>> -	unsigned long i;
>> -
>> -	for (i = 0; i < pofs->nr_entries; i++) {
>> -		struct folio *folio = pofs_get_folio(pofs, i);
>> +	struct folio *folio;
>> +	long i = 0;
>>   
>> -		if (folio == prev_folio)
>> -			continue;
>> -		prev_folio = folio;
>> +	for (folio = pofs_get_folio(pofs, i); folio;
>> +			folio = pofs_next_folio(folio, pofs, &i)) {
> 
> Hi David, I used three tabs for indentation here, but it doesn't seem to be
> the effect you wanted. Did you mean that the indentation could be achieved
> through tags and spaces, so that the folio on this line would be positioned
> directly below the folio on the previous line

Yes, that's what we do for these cases.

-- 
Cheers,

David / dhildenb


