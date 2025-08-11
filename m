Return-Path: <linux-kernel+bounces-763160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DBB21126
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7D686271
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330312E3B0E;
	Mon, 11 Aug 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BisNoc+1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A02E093C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927478; cv=none; b=rkppZVqDtishPob7O9Mey+ck+qs1UmnEu6bdcnafOdhC60E+XcnXJNsbzQP0b3ezOGLSLS09/XIlT9g603UGRfbgwlDwYTiSUjwyI0FE7BDtNwCMOH7LOOHZQ5/m23Lv99k+sa/3kq+c0VK6BB6b0vKcj3iSO+m6zv1tnD6lkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927478; c=relaxed/simple;
	bh=S5ab0iLu4pSMGl3CVEGsLuV8rQQlSt5AYFpSPlX/HXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0pHg1Qijz37wqEjiFDTPyxkY19Mha7yJdaL23KTrHPgp5xq/tnDu2H+nElXz2Trcu1AyL8HAPNaDsHnwZZPpkWLfQM9z2jaVd87zJzO4QenA4KR22WN8F2LhoUMP4eVt9pLOSEu4B/+/QxNDMxz4y7Fsu8hxCC6lPOg3FkIKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BisNoc+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754927476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LWmO/tqWZA8f11WmPuI3V0neC5qWaeQE6R0YCXV55sI=;
	b=BisNoc+1gPuLkK5hvfivVFyGm4PKdRHRf6h8VS5Rv8RujvtW6Vxis2PU6GYCG1YVHTwkem
	lCPYgRHF804xYuDb2HJuJ1hi373kH9xv2bWcs06xKzTr+z1QLG1w6fI97FzgGEmbAsV5C3
	dtxkFtHPh+BxubEPc5h8Fg1zafNDbFQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-P5DOeznGODmtiny5eJ4J0g-1; Mon, 11 Aug 2025 11:51:14 -0400
X-MC-Unique: P5DOeznGODmtiny5eJ4J0g-1
X-Mimecast-MFC-AGG-ID: P5DOeznGODmtiny5eJ4J0g_1754927473
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b20f50da27so2277140f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754927473; x=1755532273;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LWmO/tqWZA8f11WmPuI3V0neC5qWaeQE6R0YCXV55sI=;
        b=Yb+SljncGDLl6Oa5lHswhHi/t47oTkLneMqIFd0NG8PX051Nx/Hippe5bH6Z5pI6x7
         XdWVdR+kR6rXhgcegHNjaLxHtK+qqJBGZ2/BrjCc6oiDqGYch6ZxSTrR9B6l7Cx1pfoL
         g0V48FnhTIMpNcZmtnafI96gmsjwbmv2qZqMMs9MPMH49qGg9VEzr9L5Dkhmimcp/aA4
         yNOvJnaruW8Te9PxFbTM4NOJiAs6B/Prs/F9mx1pjyUAUXfBBlK8XTAaJOd4p/9cwM8B
         Nh9FIgl4uCBRHK1l/Hp//o9fvzPLVfik/B6u7tCPjXH8jZsaNjs4spK+x+zCHMRW56xX
         vCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk7rOUUV9vFsPThNs/g7bhHvdCywzr5Lt26XlvRUESdHvnvwaMsRT9o/o7uBH2JPBpCYjh2ChhliGlYH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKRe6gNOWjkl1CKRXFjFBU/lp154UwBfbhNl2blS9HomQzgDh2
	1UdBCgR/n/WlTqIyi5LJyZ4yViVw6SA5wCK6F6OjQ0BDil6GZ3MQpCEGFvD5PNAGenKfhL+cbTd
	SRF+GXTxx8DC4pCBHnmo9mYWBV4+4pa2qK59H4zknqDyTfuGzs8l7JZMt0sgsOEZD1g==
X-Gm-Gg: ASbGncveQI7yy7u/0WTm4XgGC0AMaOuNcfHYeX9Lr5o62XHBPLVotolxtMbbCe9lNOK
	WGHcYQsBZLhAPPSaWN7YaAobEGenijET7GukoPgmAJM4mw9G1v+BnHsT+wx6nSrIqaI4pYDOYxU
	+SNLo/uckqyjZNtuxZhbrEdqy2HQWXp9mKBW116KEcZkcmYa5/ASELs2a2wfo7wLNrvxz09TnC3
	MhG5nhEtiqfnomwIUHbQnyWVc0/gBB9DG2mTpDHhKqmW0aVeCE+bv3/5kxGlx+Gqs0zEX1zoVuX
	kYpTClO9c5Rl9zXOFPDbvQL2Jefuw/K5uzmBBq2bMb3Ybegx4F1bU1BAl4huonApYofW/33PiE7
	pVifn5tNQkHL537KgpuZvXRjCG4Hpd3BDP4X1V6HQ1/YpBIbNrLGs3Tk7u57PGUTUcYw=
X-Received: by 2002:a05:6000:26c9:b0:3b7:828a:47df with SMTP id ffacd0b85a97d-3b91114884amr68900f8f.4.1754927473347;
        Mon, 11 Aug 2025 08:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWhkXQWO2b9wlb7gq7SkBLTpoqfeCqixrWyQfS8jXSb4i59XsYjiDlM2VUN25fLUn+ORlUvw==
X-Received: by 2002:a05:6000:26c9:b0:3b7:828a:47df with SMTP id ffacd0b85a97d-3b91114884amr68873f8f.4.1754927472936;
        Mon, 11 Aug 2025 08:51:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm41359250f8f.67.2025.08.11.08.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:51:12 -0700 (PDT)
Message-ID: <c63b9a78-6a39-42e1-8a72-b4ce4a7025b1@redhat.com>
Date: Mon, 11 Aug 2025 17:51:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
 <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
 <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
 <9178bf98-2ea7-4ad8-ad43-cdcc02ab863d@redhat.com>
 <904f85d0-acd6-4f47-ab45-fbf18b80f1c6@lucifer.local>
 <7e7bfd05-434c-40b7-98ec-8ce352a8147d@redhat.com>
 <fd35dd5d-95cc-4c37-bf72-52a27fe822ac@lucifer.local>
 <efe3aogdw5wxsn46xyy2rrqui7oghyi7elam7aiv3c6o6hsfbx@ee6dayztcy2x>
 <2e8df53b-d953-43fb-9c69-7d7d60e95c9a@redhat.com>
 <e7781de2-dd05-495a-9a40-7718f04adf0e@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <e7781de2-dd05-495a-9a40-7718f04adf0e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 17:48, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 05:39:32PM +0200, David Hildenbrand wrote:
>>
>>>
>>> I could make a function that frees all new vmas and destroys the tree
>>> specifically for this failure state?
>>
>> I think the problem is that some page tables were already copied, so we
>> would have to zap them as well.
> 
> This shouldn't be too much more egregious?
> 
> The issues arise when it might be an OOM issue, but if it's a fatal signal we
> can take the time to clean up.
> 
>>
>> Maybe just factoring stuff from the exit_mmap() function could be one way to
>> do it.
> 
> Is exit_mmap() a problem here? Or maybe I don't understand what you're getting
> at.

We are dropping the write lock in between, allowing for these races.

-- 
Cheers,

David / dhildenb


