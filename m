Return-Path: <linux-kernel+bounces-775700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A31B2C393
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5057ABE61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C413043A3;
	Tue, 19 Aug 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHC67HYi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40629255F5E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606672; cv=none; b=jYVNI9InntQ1redVF3Ta557jOo2WtwOK4hG2Tz/NrnPMa6JULDb5bI+ISF9utHUXdN8UGFd1pEHuXGlJt+3QG1OF/RnI7zq67BOPcYqo6Q65wF5WiWsSrN0N7Ts6qJiYJv1YzqbDAMYJAZ8Oua0KWNwyo+oUidzrwIOcaVPKr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606672; c=relaxed/simple;
	bh=ImCD3eM/PFPyQ9m5dRCYm/LtF5jZcYNy4oNw4R37xEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAkJpL4obEByx/H52Ck6QAzuH1qhn7w0cyjezScELoidWToqsvuQohCUICJkNAAtc9Z+pKv2LFeuZATBbgEkEIXTG5S0IbMCuxVoCk8EEE4Pl1CXPPzjxdfCoidTRzjKOPXPrcxS6HLeSGXgPMSCVZYAl9ct5AMGNFspRS1/7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHC67HYi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755606670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yb5sv1zr5rxUlheY9XAjFIdy+xQxd/kDQBOVar/9xqE=;
	b=fHC67HYiIg5eL0VWMt63wUpXnkejqTclimyI93BRAhfuWjPqLoO/mHBB+uo8ZDBjAqbf7V
	mqIN/T9NyvEf8caqfqyPsr+tRx0DQURcDmYTL+uq17lyd/cqoH1m4JU6ERG2XDGasigy4H
	NruiDs0o9bzB0Go/aP/7gQvSMx6ny0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-Z5bxRfXWN1uZ6neDdxuA4Q-1; Tue, 19 Aug 2025 08:31:08 -0400
X-MC-Unique: Z5bxRfXWN1uZ6neDdxuA4Q-1
X-Mimecast-MFC-AGG-ID: Z5bxRfXWN1uZ6neDdxuA4Q_1755606668
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b00149cso17967625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606667; x=1756211467;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yb5sv1zr5rxUlheY9XAjFIdy+xQxd/kDQBOVar/9xqE=;
        b=VbrP1WXGydivZ0uxdScGYFVysbZGgpAaToL7UYj6SmridFyv1Yp5MdbFS4+bTHOLXD
         0HlWjIz9HkvKz0GSE1lbnqvSX7PmpBjEg8jJUlV6FpMqacrWD2BnHfHmyBz6Sq8bmhnW
         WMAiql4zBL6CH9/HMwQQ/Pypc0kul7+n4LlK63aGtJMLx07h88aagqWCKTsBZ8xGXtXl
         NTg59GEhaCYFSr629omN+B2o2u+6aBtK8Jx7LHhdjxUQZuCkP1dqtO6D6chZ9MTmFYlZ
         N97dJqjTkqSp4+4largULXV02DBu5FCa+JsOkiE4Vt2kRI5zs6DUmTAm1k8ZgR3KVAsP
         YeZw==
X-Forwarded-Encrypted: i=1; AJvYcCWqXUyd1j1k6BenGiJD5BxpI/2fzBk6THZXyHdVtUIoJDi+Os5HdnO2snb5yIC1TUcxUMRMzNXvcpvNjwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXldhEjt5IMp9VX02ktbMzN/ZJlZlCHovcmpWYkUyIvZvhV2am
	c7skUB6tGDwOyFovtGBEDslTiJUDSp1qM4thL812D1i/rHHbf//lW+SER3Q9KtZacHHBDTXxjtR
	CeZsw9vQifOb+AWILj0VekLkTHLmV9IBeiZSGf7H/CqbPbvqaC6EcQ7V8uKc170SIxw==
X-Gm-Gg: ASbGnctvI8Hn0q+8fcmOYEejLmvjC5EQN/wGqKOBBMsFA+esXY/X0jNFcSeNQEjvXfL
	BZB7rlTF+u5X9dVB4KbicTCSASDRLRcYenPGYdAS1FF/NvH7+tBQ5Lf+YwP0+FiY45gu0cUlMKL
	WBznrCVXnJhmzTIWtS5z/2OsVqYof/dGxdSX1Uxq2AfmXEJrSB92RRfqTJgBoKah+qYvll4CzXq
	R2+IBM2vBDmwT2hyy5aTwjA5EOBrZEZeuz2m7grfq7KLObn+sRu4Rf9ydzEi84zMQLhf2SD3e2d
	gLpnsL1M/Bjiddu3pbUXhd1eSaAAow+TxAKaGZ+YfKNNXzKCzBVzttayms/zc1jeAmwoRrY5rtI
	NddrhShy5oTNPQVyjHEqTH6vLEpOHBU0kGx77r4dyKKCn7U7ubOjJkMcOJsusik3p738=
X-Received: by 2002:a05:600c:630c:b0:459:db80:c2d0 with SMTP id 5b1f17b1804b1-45b44d6f6d7mr13425505e9.7.1755606667555;
        Tue, 19 Aug 2025 05:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF9DqbnW7eCUmfGTMJap/d439sOOVnQK43Z23DtcxrFTUNNRVcaiz2wCYQyuGLZpijDyqywA==
X-Received: by 2002:a05:600c:630c:b0:459:db80:c2d0 with SMTP id 5b1f17b1804b1-45b44d6f6d7mr13425125e9.7.1755606667146;
        Tue, 19 Aug 2025 05:31:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a8f972sm42502585e9.20.2025.08.19.05.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 05:31:06 -0700 (PDT)
Message-ID: <1df9b8da-6462-41ec-9dc5-df99dbd8ae8b@redhat.com>
Date: Tue, 19 Aug 2025 14:31:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/mm_init: drop deferred_init_maxorder()
To: Mike Rapoport <rppt@kernel.org>, Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Bill Wendling <morbo@google.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>, Justin Stitt <justinstitt@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-4-rppt@kernel.org>
 <408d7eaa-5aea-4490-9fd0-978c4eb94d32@redhat.com>
 <20250819092254.cddlg6npwl75fvbn@master> <aKRUUzq48xW5qPOp@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aKRUUzq48xW5qPOp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 12:39, Mike Rapoport wrote:
> On Tue, Aug 19, 2025 at 09:22:54AM +0000, Wei Yang wrote:
>> On Tue, Aug 19, 2025 at 09:54:22AM +0200, David Hildenbrand wrote:
>>>> -static unsigned long __init
>>>> -deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>>>> -			   struct zone *zone)
>>>> -{
>>>> -	unsigned long nr_pages = 0;
>>>> -	unsigned long spfn, epfn;
>>>> -	u64 i = 0;
>>>> +		while (spfn < epfn) {
>>>> +			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
>>>> +			unsigned long chunk_end = min(mo_pfn, epfn);
>>>> -	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
>>>> +			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
>>>> +			deferred_free_pages(spfn, chunk_end - spfn);
>>>
>>>
>>> I assume the expectation is that all PFNs in the start_pfn -> end_pfn range
>>> will go to this zone, correct?
>>
>> I think so.
>>
>> defer_init only apply to the highest zone in one node.
> 
> Right, we defer initialization of last zone in every node and there is a
> thread per node that does the initialization.

Thanks, my memory comes back :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


