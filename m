Return-Path: <linux-kernel+bounces-745389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A2B11942
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D262E4E57FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14AB25A62E;
	Fri, 25 Jul 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlF4m06/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426921CEADB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429103; cv=none; b=kNPiEjpSWJrol18YPNYpO2Vr6DfpwTe3dy6WFvGz9apb2tpEni0iL2NtfCtpQjUXH4SsK+4QDl83kRTwA4tvkQvglqknyCSwyJVaX88wOsxljxoMm+ekU6v2w/DD9VWJcHISBXLW7GlsJeGw9bJfs99fTreIgiYbcV208rHTb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429103; c=relaxed/simple;
	bh=/0SunHtLq4hQR5o0CytRHIZLvwaO/a4pUZamTp8lIOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz5m6iSvZ+IcJQtN20KgfBQGsgpY3MSxHsdvjZHk+SpYDJloNMNBR2LJUJLOHvw91ugKWBpfxElqdtu8rjGqLo4HGXfbQ441uuRHuI5WI81S/89O0cksHTELXYQXzR7W2IfHP5IsNL2cS5flMIaW9ssKX1zn9s65gJTUtF1F3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlF4m06/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753429099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nqBO9xBmUQSQOv3t22Yu8O/ZK7eM/acEO/FVmlf3cEw=;
	b=DlF4m06/UTIpeWXnJmSXxtveDE1MVPhufs+TdJWheJGIC1d3aH1sqHx27sHFl1bTFQdOYy
	vhYNDTH9y88evPI3qwOsHikzf80zO8XE5loD3MAFFBd+LZ/v1hr7byu9hdl+TIA7TpTdbb
	LEHD1Q80dnJiZgnKs2VKA9o8VXvWHGA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-t38I4gi1OiusJzXJFkfFiQ-1; Fri, 25 Jul 2025 03:38:18 -0400
X-MC-Unique: t38I4gi1OiusJzXJFkfFiQ-1
X-Mimecast-MFC-AGG-ID: t38I4gi1OiusJzXJFkfFiQ_1753429097
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45867ac308dso9646095e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429097; x=1754033897;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqBO9xBmUQSQOv3t22Yu8O/ZK7eM/acEO/FVmlf3cEw=;
        b=YhIbR615h6UWNyn1HiWomUPAHCNMw1aRWNPH9ZJIemNB906T8Esnvo/F4ZJJ7JpVRK
         kl/orTsSOYYnRYSqU4Enw3XFOQh5UVTVgMPKObDSvDmi7w0toFr8TtzNkVvQrBsTLMOr
         Cxh29AXZezb7UPkBmrunN3aNXjpZZqW59NMQJlZpX4A7qp4OiKWcdJNyBnFJiZwMY96h
         nXl9Nc4oX5TKOnHYRgNR8BzmellzdbNQM+H+RiXQp9fpGcNdNJVHMwj4E5X6wM/Ydk3d
         EF+rhOR8vKmnTSTec5OdReKklyj5HYuK8sKFwVnv8Q61ZD4Z+n2iKe5HJWheFGmbRgt9
         5EiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2HYuq6csATfEs3SHDAIRqU7NUa2hHq4p8WPLtMh3+YDSrgG5rkqDoV8gb8Ytf8ndfIRadLU3BmsmsktY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dZB4LAKM+a+fXHN3/1aJ34qFvXhdMAYgXbOcMAzGkAyh6pi7
	8YT9hMV1Q8bfGj5WjPW6fmbRehy6xh0g1e6qrMTR6xeqO2Zs0oUjywHTeM0xF1zIHnq6Gi9eNqP
	UvHPWMk1kJgHDTFUq1b/iM+UpnEA5f4dDylR5DTfT8PfPOvOBXSBG5dblsfiBupjdig==
X-Gm-Gg: ASbGncvjvA1CiMWKvs/33kQnzP++VBtD9dlkWfUGGPAJoTAMr7eXLdFMQKXtViN8o3D
	KYkvYrbrHzVbtzxfe+FMep7KCDr0+z5RxAi4cXjxP4mPd6nIA354A4xptpW1FzLWXO1HcORCXds
	qCSTuZgBSckvcZEx6pfeC53H9zmT7/DeSvRzTSO//6Wma379frlwXn3keEKufMZde/LYG8igR6c
	XEsL+CXyTQC6MQBmWNAoaiCPtMmtEGQON+pNlBPEkLKCKFLR/XrxOBowNpNm/4ARMbI0Ceb3ZIa
	CfeUKFeHVPrN1Bc3XTxb/r7xGNCFXhq/7KkszmpmgREPv53Nc0xhX3cfqa1trFxZR8yVEw==
X-Received: by 2002:a05:600c:468d:b0:456:1752:2b44 with SMTP id 5b1f17b1804b1-4587654e5fcmr5455295e9.23.1753429096635;
        Fri, 25 Jul 2025 00:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvfKwpSm5/wram/IC4tM9dnLJQxwvBCyuFrEnsH9dC086EvjWN2n4VNM00MDSTcQOQlFRPrA==
X-Received: by 2002:a05:600c:468d:b0:456:1752:2b44 with SMTP id 5b1f17b1804b1-4587654e5fcmr5455045e9.23.1753429096130;
        Fri, 25 Jul 2025 00:38:16 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0fd5a.dip0.t-ipconnect.de. [79.224.253.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870532a4csm44564315e9.7.2025.07.25.00.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 00:38:15 -0700 (PDT)
Message-ID: <0ad414a1-9a57-4050-a7b6-fdea08aebbd1@redhat.com>
Date: Fri, 25 Jul 2025 09:38:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <4f66d89a-631a-43eb-b4f9-c9a0b44caaae@redhat.com>
 <692f9624-e440-4cf2-8202-861c679ddb73@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <692f9624-e440-4cf2-8202-861c679ddb73@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>> The justification for this change is to account for the case where:
>>>
>>> 1. A MAP_PRIVATE R/W file-backed mapping is established.
>>> 2. The mapping is written to, which backs it with anonymous memory.
>>> 3. The mapping is mprotect()'d read-only.
>>> 4. The mapping is mseal()'d.
>>
>> Thinking about this a bit (should have realized this implication earlier)
> 
> Well none of us did...
 > >> ... assuming we have:
>>
>> 1. A MAP_PRIVATE R/O file-backed mapping.
>> 2. The mapping is mseal()'d.
>>
>> We only really have anon folios in there with things like (a) uprobe (b)
>> debugger access (c) similarly weird FOLL_FORCE stuff.
>>
>> Now, most executables/libraries are mapped that way. If someone would rely
>> on MADV_DONTNEED to zap pages in there (to free up memory), that would get
>> rejected.
> 
> Right, yes.
> 
> This is odd behaviour to me. But I guess this is what Jeff meant by 'detecting
> this' in android.

It's rather weird usage of MADV_DONTNEED, but maybe, for some R/O 
buffers ...

> 
> The documentation is really not specific enough, we need to fix that. It's
> effectively stating any anon mappings are sealed, which is just not true with
> existing semantics.
> 
> However I see:
> 
> 	Memory sealing can automatically be applied by the runtime loader to
> 	seal .text and .rodata pages and applications can additionally seal
> 	security critical data at runtime.
> 
> So yes, we're going to break MADV_DONTNEED of this mappings.
 > > BUT.
> 
> Would you really want to MADV_DONTNEED away uprobes etc.?? That seems... very
> strange and broken behaviour no?
> 
> Note that, also, mappings of read-only files have VM_SHARED stripped. So they
> become read-only (With ~VM_MAYWRITE).
> 
> To be clear this is where the mode of the file is read-only, not that the
> mapping is read-only alone.
> 
> So with this change, we'd disallow discard of this.
> 
> It'd be pretty odd to mseal() a read-only file-backed mapping and then try to
> discard, but maybe somebody would weirdly rely upon this?
> 
> It's inconsistent, as a person MAP_SHARED mapping a file that is read/write but
> mapped read-only (or r/w of course), can discard fine eve if sealed, but if the
> file happens to be read-only can't.
> 
> But we could add a VM_MAYWRITE check also.
> 
> OK maybe I"m softening on the anon_vma thing see below.
> 
> So we could combine these checks to avoid these issues.
> 
> 
>>
>> Does something like that rely on MADV_DONTNEED working? Good question.
> 
> Kees/Jeff? Can you check if android relies on this?
> 
>>
>> Checking for anon_vma in addition, ad mentioned in the other thread, would
>> be a "cheap" check to rule out that there are currently anon vmas in there.
>>
>> Well, not 100% reliable, because MADV_DONTNEED can race with page faults ...
> 
> But hang on, it's read-only so we shouldn't get racing faults... right?

You mean, ones that populate anon folios.

Well, there is long-term pinning that can break COW and other weird 
stuff like FOLL_FORCE. Most of the latter probably holds the mmap lock 
in write mode. Probably.

> 
> Hmm maybe I'll soften on this anon_vma idea then. Maybe it is a 'cheap fix' to
> rule out the _usual_ cases.

Yeah, something to evaluate.

-- 
Cheers,

David / dhildenb


