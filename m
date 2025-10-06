Return-Path: <linux-kernel+bounces-843012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFFBBE32B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B06A4EC3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67C2D0C99;
	Mon,  6 Oct 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClR0DRyI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B0283137
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757893; cv=none; b=G2r5T5wg+QGdPMVB0wops59t/NOHhj+myXCg1bu/2Rf2Mb0O6MHf+j8sAHSpnLw9yOFhFxq+HM2Hw0PxUiRYX+gJz5w9Sw4v/h9yJms9fBHDfEiBT4uQ0q+3+zx+Vk+iSYTmrmyM0H3Vj1QLvje1c3/133yPWlR3RwOW46fel2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757893; c=relaxed/simple;
	bh=WrGRiVcZjXzubJ0VV44EaPG8I6oTrnoxkHlt/1VaJ5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paNDAlojF0bHxs0uPmo+F1CmCwaIzl+drERBxdumAE0MhsgYC5FjNyqLmO3w57PM9jLkq5wImfLurWNtmatdEq7sxP/tqIg/IzcxpUpq4c38orikR8JHPvRVpFDEnSRaza9uTh1tr5rZQkQo8bD8ORwnzcfJxzwNhiHm60PLH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClR0DRyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759757891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J9Vslcj5WOkRvo7kWCjBKDT3O8gP/5DZEooiRG+rxc0=;
	b=ClR0DRyIoczYM9x5ZZa28fy+t9vCev0imiOwt1EGLlaLc0APlHu5pwitzhl9nwifHavGJC
	jRUUiSPJAPl8dQ6vIdt5HlD4RLCMLwLxxpCO90Yr1sYaJLUs8ioAE/Y1aSt0FS4D7DDYuE
	/FML/O0JAFcis/k/db+r+rhrEfwCrmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-JRcdW05gMh-BEC1pKhHtRg-1; Mon, 06 Oct 2025 09:38:09 -0400
X-MC-Unique: JRcdW05gMh-BEC1pKhHtRg-1
X-Mimecast-MFC-AGG-ID: JRcdW05gMh-BEC1pKhHtRg_1759757888
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e407c600eso26266675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757888; x=1760362688;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9Vslcj5WOkRvo7kWCjBKDT3O8gP/5DZEooiRG+rxc0=;
        b=ZLz1Q+KawDZlOySzwdUkM0WpH6zYvr8L+at+viiZC1E8TGMclCMaEcDt6PJKZsImsL
         Bgw4VPFlEJAoZAwLN/bqa4wi2nRpAWIIX5T7m4pDjko/x/qk2Mg/7qIZXqmBD0nxYCcy
         Gefzwla616MDwcAvxdrSj9F0KeZqJAMTihlsQ/kzpZviGV83m2BD7RCN5uwsjzlSIVRp
         q7uGmusdo4itNyjkCnIwJ6uQq2hIo0jzaTZ6wPdTYESByvkBBGAQDUUg08+0swAGIEVs
         bk70llTVU1+lNUlSIVvq3QBhPOi419VX3ROfDGgN6ukja70rOZttkrEC2wImU5dAAhYW
         c7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWilciIc32ZFbL5FYgXR5ZvX7o/ZqdluwkiVovi9yYBGFY6HbapXnM+10s/VzEApIGpDX3pTBBuYP1SzvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOJg9m8HtgR8LG0TA9EL4snqyiTb3iuSRkzXK8mcCA7lMa084
	b1E7ErkTbj5dhvUlf5lLtk2xLI9IR2buQ1JoSdt92ZO68INvqZTr8ZJHmu9t37wjfHpmboNzUPF
	2TC6zF5a7Z1mkqNticoffDrxED6MJsHjYhF3Jbkp8xX3zYjZqxBBIyDJCmouD69RcDg==
X-Gm-Gg: ASbGncvJY4AkUtM+Q5ABfP/s2bFOVQ/OIdVeRBqzytA7fJj3PPbNlMAuQRSqWwbpClZ
	dx80fth6NsMgu3YYK7f3mnhm0Vxh/YUIGfDk/nu3BIRe3vB7WP3xqOXaxgP2tGnuwLo+8KDJjtJ
	6leSHWUw0aXNLXfB8HSIpqJuje20NxGhwwiZZmD9mqWhf5JVhz5PiK1exB4LGvBXXURpTcwqycY
	ooy89Oe1I5euikac72lyiIuiFMT6NteBVKCmK1YgLubNOtiFhyqjL/R5pH6WwCPfunANZRRvje2
	azZ7qkCMcTn3I/EWBqHuHKW1YEpkdjNzoRPe75gsYIk+apuiXfY8zYTqKuQ6Q+6oQLIvWcRjwbF
	Ts0Iqv1ny
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-46e7114310amr100732125e9.17.1759757888244;
        Mon, 06 Oct 2025 06:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE076+Qj5FIN1G3sNZQZ/xD8YOyGPuPaWGZHYbFqbRLs6YYMiCNULxQdvp715NneEIF4EDA4A==
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-46e7114310amr100731955e9.17.1759757887791;
        Mon, 06 Oct 2025 06:38:07 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f02a8sm21300590f8f.39.2025.10.06.06.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:38:07 -0700 (PDT)
Message-ID: <ce32090b-32b3-4d7d-b1c0-dfc7e1c70202@redhat.com>
Date: Mon, 6 Oct 2025 15:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Axel Rasmussen <axelrasmussen@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 James Houghton <jthoughton@google.com>, Nikita Kalyazin
 <kalyazin@amazon.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com> <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com> <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com> <aN08NxRLz7Wx0Qh4@x1.local>
 <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com> <aN_XZbQjuYx-OnFr@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aN_XZbQjuYx-OnFr@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

>>
>> Agreed, while making the API cleaner. I don't easily see what's confusing
>> about that, though.
> 
> It will introduce another set of userfaultfd features, making it hard to
> say what is the difference between the new set and UFFD_FEATURE_*.

That's why I suggested we use something like "BACKEND" as part of the name.

If we can come up with something better, like talking about capabilities 
than features to better distinguish it, even better (UFFD_BACKEND_CAP_* 
etc).

> 
>>
>> I think it can be done with a handful of LOC and avoid having to use VM_
>> flags in this API.
> 
> I waited for a few days, unfortunately we didn't get a second opinion.
> 

We are currently in the merge window and many people are either out or 
were attending kernel recipes and are on their way back.

I'd suggest waiting a couple of days for more feedback -- right now 
there is no need to rush either way, we have the complete development 
cycle starting in one week.

-- 
Cheers

David / dhildenb


