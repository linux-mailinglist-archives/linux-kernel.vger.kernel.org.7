Return-Path: <linux-kernel+bounces-775074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDAB2BAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF312161C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387025A631;
	Tue, 19 Aug 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtQlsVsl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E8264A9C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589450; cv=none; b=nIzx5mxINYKxhfdO7wYXagp78J9zoXCiN6aa062IcfOiXMjk/IviWyA+9fqBdI+nsyzM/N2Dl2uo5Wf8f0kKpSW4PJSTMoWwl2vE4kRSW8yR/vDlbTg2rCTuemfaa9IafYPSMa2TqTrytK9XDkasmOEwY/Ts6wV7xlnp76Bt2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589450; c=relaxed/simple;
	bh=hbXiwwmv/TAyN+dMm4mGAmUTFqxcIwE6CLeyaSscGWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEmj1acdjHL6Sx3oJ29CahTeJHDUXFwR1RKmDY+KE/TxeAY/0LXzuAG23sgYrUu6X39WP2B3ji3w35oHNY64LjpoEjp8oPp/jV8wrEjLQ0zHjGU7QNnBv87Xvylah+OGHnDhSCGCOL6JZpomqR/aseWmP/AIa8K5CXscxR4Ukv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtQlsVsl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755589446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fIj/g36bZghupXV216+l9nKZNoBOCc3syczxCiD8BLI=;
	b=GtQlsVslDxNIJx6BcVO1ac/kfsnvBgGRCQsGlhnSFi4FuhqJrd+ptA4ggz/AZwvbe0Zm9p
	EjdbO9AGK/wHVeM/PgGrQ2wpZEpE++ZpGcCzur1lJQvMuQyzl6J5Zcvu9U+ytH/5ghI0eg
	45chY6BXVs4QW4MrmMEHvlq6ERJ4FKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-oV7KlUgfM36NGyNRmWnIOg-1; Tue, 19 Aug 2025 03:44:04 -0400
X-MC-Unique: oV7KlUgfM36NGyNRmWnIOg-1
X-Mimecast-MFC-AGG-ID: oV7KlUgfM36NGyNRmWnIOg_1755589443
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41cec2cso4094491f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589443; x=1756194243;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIj/g36bZghupXV216+l9nKZNoBOCc3syczxCiD8BLI=;
        b=HIxRmOi7sBiyFFfcshBmkAW7RO0DaZnhoFkShg9OH0GZi9kgGzKnJbcY7QabJ2EBuI
         gKsol89p8FPpmdAdLYrPmePRJGj8PZQ7N1Ecp8MIYNMjLo4QEpAWx65DNsszzyg7mst0
         aiRmMywMkcRQ8cSXL7cN6bP0zqFCJpfEWvPVBr2fgC5rhTsgJpZxY5BIrilGzV6SE1Id
         yDqZC7rjjfTpFfGU5oKNxDYvl+u6pynjjeA3AQzeMiqpxBWeWI0/C9BNA3+iYKJCwr9I
         N1z3cUV7pMTOa4+vAJcssj6IrBJulNjCiIpnFEtJyFthoEfYnLfgjlUmHn+IjGa2gFzB
         XXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLQ+HezrIVjzr9WhN1soKKjCzQjW1ZRwXAzece+Qg1KtrzdW0iGqcwUs5Mhb62wPqthpFUS0Y15DBif+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeuus7HrbnfM4E058NewyV1IuZ79LX9NwMqINzIi26ccJCYnQ0
	TzZDXG+p9CPSB9gCK/hnl1CETXoDQN3fCGeHBMVgJWqN97zLMu2stXkbBY/HewvBSbnZTlaR6NA
	HjvlEDIeaDoEH/yg5m39CkBo6qBd5V+2Y0UoB5XPhaBSsRdRpHWy47lUnHjNXCjX16A==
X-Gm-Gg: ASbGncu8m/gt8GFEafjCX1W1VyRB2FjRjbxt/6z9B2Lo9ogPSp33Q7QVnlg2uvnmm0E
	LRndc8TvqfYlae7SzwSIaMDUe9q5BbGFBE9D0kpn4kjK65xY05uofxFAfUNcrI4E61rpm2EiG0i
	yoF0oVNZtGhsHxNWPL2mURnojRbMdGb+cmFjE4qWIo4z5fOSx0vNzTQkusrNB/2vqbiOzZXZUM4
	NRtHBsjzUQSyvUjUXDmnK53Cw7JOoKv3G/gp+EK/apebv2opiquac7yeb4TMBPncxcdN3U+09z/
	VZzsZOlRdB2XWwsHsgE/2zCg728VFaReJdDG2eQaM21qqBdywR7KzKVVfrcG16oAPUlVUHidrR3
	VHoMpJwgjUAS7DQUSynx48M8/Cl4sCBq2n2r4anLVTz/vkqh7De4PM08WVDGEZmUmueE=
X-Received: by 2002:a05:6000:4011:b0:3b7:9c79:3293 with SMTP id ffacd0b85a97d-3c0ecc318e6mr949019f8f.58.1755589443063;
        Tue, 19 Aug 2025 00:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX3aCtmn8Z/3+2rglxcbECtcQWpRCN5o9VXE9VpdiFc9WoRBf+18fJ1/CrjpVetKu7qCsWUA==
X-Received: by 2002:a05:6000:4011:b0:3b7:9c79:3293 with SMTP id ffacd0b85a97d-3c0ecc318e6mr949000f8f.58.1755589442605;
        Tue, 19 Aug 2025 00:44:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43c77sm2612291f8f.23.2025.08.19.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:44:02 -0700 (PDT)
Message-ID: <557f34ed-114b-48ff-8c01-ca9c939da08f@redhat.com>
Date: Tue, 19 Aug 2025 09:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/mm_init: use deferred_init_memmap_chunk() in
 deferred_grow_zone()
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Bill Wendling <morbo@google.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>, Justin Stitt <justinstitt@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-2-rppt@kernel.org>
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
In-Reply-To: <20250818064615.505641-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 08:46, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> deferred_grow_zone() initializes one or more sections in the memory map
> if buddy runs out of initialized struct pages when
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> It loops through memblock regions and initializes and frees pages in
> MAX_ORDER_NR_PAGES chunks.
> 
> Essentially the same loop is implemented in deferred_init_memmap_chunk(),
> the only actual difference is that deferred_init_memmap_chunk() does not
> count initialized pages.
> 
> Make deferred_init_memmap_chunk() count the initialized pages and return
> their number, wrap it with deferred_init_memmap_job() for multithreaded
> initialization with padata_do_multithreaded() and replace open-coded
> initialization of struct pages in deferred_grow_zone() with a call to
> deferred_init_memmap_chunk().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


