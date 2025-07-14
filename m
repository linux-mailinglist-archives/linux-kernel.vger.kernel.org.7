Return-Path: <linux-kernel+bounces-729586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AFB038B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACCF67AD179
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BF023D293;
	Mon, 14 Jul 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiXuW8Cv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34622F74E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480293; cv=none; b=OBQWYu1bxaKAJk3xj07R7hp3Pm2ZWCBgdScStzh0wyrfD88920NYnulGVhRn8J+DRALqqLYB4ib0LlU5ZMW3GZaak2Kw/fj1f/WLuMTUqoVn71B8MzmKz7PIeFpV+92DB5SYQch07nOU0jY+LlkMdZamunIrO3/nEOdzpTvjrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480293; c=relaxed/simple;
	bh=KbRJ3Ig/iVuHA590hmtAJD7HA8CEfOE32nxGjcXKm/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eC1iMFq5ETVxLwVi20sVdf7FCvBk9S9pv98WCQZBGgZjJxCLES3acK4JxmuGuTLtkf2QmWxiuqfCY6BKAmq5+1e09lB3Y05/iPMFcuv4PWDF2WbNQogDZc8HxUXs6mmjHO7y9iqa1E5TLtwpaQGSRtaHFimRjr5ns891FXQE4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiXuW8Cv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752480290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ixOAhqEqvoxP1PivoSUfdqLVUuvoI4jKQJJfXotpDys=;
	b=MiXuW8CvSk3G3a+R4B5rn6QUJNKCosNfbkPs+vmxY6CvAXsd+aum5NBwek7QNvb55yMyIN
	P4USbWDqxEG8djBc8diJ11E+XauFI2CIdd0kWMm+1K/dN+ReAlSuRGHadh5jAOTV0Ubj+J
	Cfu/9i0AZrh6LiOIw+Lat549r2PflSA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-LGafFiUjMCW8N8dwi8lBjg-1; Mon, 14 Jul 2025 04:04:47 -0400
X-MC-Unique: LGafFiUjMCW8N8dwi8lBjg-1
X-Mimecast-MFC-AGG-ID: LGafFiUjMCW8N8dwi8lBjg_1752480287
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so4115155e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480286; x=1753085086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixOAhqEqvoxP1PivoSUfdqLVUuvoI4jKQJJfXotpDys=;
        b=En8F/Ja2I5vIitAHk3Jl67/Wc+0LvWG+Kx3ssxBEizopniDdeArERv3+e/9dADFFX5
         0qsZ9VNBsBBLfa1oRx3F1xsNSCu/kUGG4A84TpHly+XCdzu0P5s0nWJOwLR9NYjr0tlZ
         OO8j2O9H3ORx9Oen7+Pgx7oNd0WkE51haolt/OPrDd6TuHrPIy3EfVtkrB4fcCNwndau
         6gDLxSrFk6FYyXaT1OKbHeFB+nYlZC/m0hLv9W4bAjyuNXaYUP5rM9LnCwDXhSxG9Eae
         EdYbfyZ5rDLwJNnRZiLjNHltzkTJajCa6c4evP6y54UH7TPo1baR+C035Wp8NUh/abHo
         fQjw==
X-Forwarded-Encrypted: i=1; AJvYcCWIsTTCZUVFtx/bOra7PBIz/VdXUjkCSWoBvtS4sEdCo/LYOR3Nlv6oBNJp30CpLpKNTc+3GczGufljJQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPDYs9kL59gXoIEjG+EWivHVB85MpNW5HacziTm9MN3BEJuoOt
	rBcMlbTdKpB/YekwsNyfpZmYfkOF+CXmO/Y3Eih5iTxyrY4+nvqZ6cHUrdX/irvmXypAKYAljyY
	gC7sunodmohQKScz2yut4k/8HrHvpQyBhDww0IXPuoyxtRGQyGDwHowhQHvugTSObMA==
X-Gm-Gg: ASbGnctYKyxxQrnDC7DmfmFE8IPB4HQENKB18P2gf6omGpnxI22wcwjEl9eYbjuMMKJ
	mjqYmXF0dvWU5iBDt9ep5cQT6fzZnXxc5ktUlQows3p0za3a3J+H99J1x4nYe0HhqR//+LjJp4C
	/eUiHszD8zs0knzDipMC+f6vz554A/VTxzFKrHuU45tp7eUNh5EgHQtkkiPcWADYUGdT+HHhiwg
	6toqtxA5QMsvc0ObeEvP2brCr7rU3R5slu20+K4GqsfTyQySRJeoxhCEjD7YvdtyyPk2vwPiaBc
	1w9/BgjEB/z625RveJx6dhMvoaddJ/HgV5A1Z/BuyZn8xHB5exDLLzh6eS4Xzc6tjcHFPdMirAn
	rmIcU2y4ehXpcbwuiiKJ2d6etzm8c1/YGSIhEENUXJ363TBFj0d8UATPIWB3cIuk+
X-Received: by 2002:a05:600c:4e8c:b0:453:606b:daea with SMTP id 5b1f17b1804b1-45565ed6221mr88009585e9.20.1752480286490;
        Mon, 14 Jul 2025 01:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoByEu1/Uf5RBo5csxuZUO9+jOoSxjseMQn3FmuvY4lczw6M1Y83tcmfv4c33XRFZ1XLrKJA==
X-Received: by 2002:a05:600c:4e8c:b0:453:606b:daea with SMTP id 5b1f17b1804b1-45565ed6221mr88009265e9.20.1752480286086;
        Mon, 14 Jul 2025 01:04:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1997sm11917851f8f.10.2025.07.14.01.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:04:44 -0700 (PDT)
Message-ID: <ca5b359e-45af-445f-89b7-7ec2c3d0a161@redhat.com>
Date: Mon, 14 Jul 2025 10:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] readahead: Use folio_nr_pages() instead of shift
 operation
To: Andrew Morton <akpm@linux-foundation.org>,
 Chi Zhiling <chizhiling@163.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250710060451.3535957-1-chizhiling@163.com>
 <479b493c-92c4-424a-a5c0-1c29a4325d15@redhat.com>
 <661ccfa4-a5ad-4370-a7f5-e17968d8a46e@163.com>
 <20250712152544.07f236ec277290c70a2a862f@linux-foundation.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250712152544.07f236ec277290c70a2a862f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.07.25 00:25, Andrew Morton wrote:
> On Sat, 12 Jul 2025 10:23:32 +0800 Chi Zhiling <chizhiling@163.com> wrote:
> 
>> On 2025/7/12 00:15, David Hildenbrand wrote:
>>> On 10.07.25 08:04, Chi Zhiling wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> folio_nr_pages() is faster helper function to get the number of pages
>>>> when NR_PAGES_IN_LARGE_FOLIO is enabled.
>>>>
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>> ---
>>>>    mm/readahead.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/readahead.c b/mm/readahead.c
>>>> index 95a24f12d1e7..406756d34309 100644
>>>> --- a/mm/readahead.c
>>>> +++ b/mm/readahead.c
>>>> @@ -649,7 +649,7 @@ void page_cache_async_ra(struct readahead_control
>>>> *ractl,
>>>>         * Ramp up sizes, and push forward the readahead window.
>>>>         */
>>>>        expected = round_down(ra->start + ra->size - ra->async_size,
>>>> -            1UL << folio_order(folio));
>>>> +            folio_nr_pages(folio));
>>>>        if (index == expected) {
>>>>            ra->start += ra->size;
>>>>            /*
>>>
>>> This should probably get squashed in Ryans commit?
>>
>> I have no objection, it's up to Ryan.
> 
> "Ryans commit" is now c4602f9fa77f ("mm/readahead: store folio order in
> struct file_ra_state") in mm-stable.  I'd prefer not to rebase for this!

Yeah, in that case, obviously no rebase :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


