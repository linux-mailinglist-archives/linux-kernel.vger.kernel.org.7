Return-Path: <linux-kernel+bounces-863236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0385BBF74FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32BA3A3B94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604F340A76;
	Tue, 21 Oct 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWvUGmYp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902F2F2910
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060333; cv=none; b=MBtaaGt5xv0TvqoUymNrS2UhUeDKBJfXyFhe2BXVy0aJPZoC7X8omp/KFhK519Nci+ANP/noE4ZVr3UOkgqAfxe4gqB8NqAtWqHID4UwADUwafFAcmP8rYpnzyzXg+ZmXZorLIPkfB8ujjF0UoookoolCHmFU++PS71C8GULFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060333; c=relaxed/simple;
	bh=BwxfchvsS8i8RSG6LfSi/G+dS+9MhkTb8GS+6FdInh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNMRTRi7ZA3OXP9dxohvov7TcfgQAF+RZb/xH5fPC5JVz6TSTz01PYxoVM80PIrmh57ilBmxt56ZQ8hKq6QaJElS1NkgMCW8HSuVcvm15ZrBNxo0j4r1i+djl7z5AoEzg4RJZqrcGOMsxzI1RJk+YSBXje4HgQNBEB/qMbU1RHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWvUGmYp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761060330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ryq8ZFFn05SNtiRqO+IXV06muSLymOv5LlgDxE1tkJM=;
	b=ZWvUGmYpUAvoYI6MUhAlui504DVq/prrSgRpVaB2fMN498hoS4/+KSF0OspJgQXZJsbapJ
	x8mCE4b45VatLRE8dFfktxa5fe8antPzBCAn3tLSZdTNdeLUxnJ3k17hw+jbKe8PAunaxx
	5CoE7u2ai8axn5JLhoDYn2O/cX7DxiA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-D8J2z4CONLO--lVfK48h3w-1; Tue, 21 Oct 2025 11:25:29 -0400
X-MC-Unique: D8J2z4CONLO--lVfK48h3w-1
X-Mimecast-MFC-AGG-ID: D8J2z4CONLO--lVfK48h3w_1761060327
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-427060bc12dso5856489f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060327; x=1761665127;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryq8ZFFn05SNtiRqO+IXV06muSLymOv5LlgDxE1tkJM=;
        b=KKtZtCGTg+8wbRwCG+aX74C3zwe6wIsNegtVnvItdX/IoMBb+M0m9TqtMnKjvNHc3F
         uRTkbodrKeRmu13VHEvLSAOgkq5eePrzDB73AIKHxIyGUfGdtaqXZU9cynY//r5tOVzt
         bKKDcwpg9lxbp0GFO3/C3QgA3tnzsTmIOkS+NT3Ies0xQYI6EcEbnst+7F4GpMb3PX15
         F3PdwSx1MXiCertlw6wYmPlb4+Gqj0hpkGi7b8CN5FFq1MKQqoMV1lTwuXOlLj58Psuw
         ZXM28qVzwle/ynaRVivEa0TrKh+faXBFgPuJLVND6f62owSFHWn33PNclUlUNthB6KPg
         gV2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZchDJ0Hz4Ccm6B7pf3zmrvLJhYWfdTUDIApdWbQzz1vlec1gXiLX1PZrdNoKagrbAP0GJikDXzBKQ53U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjHiPVl07CpcSuM5NvNltdktcjFrzXUMoWP0uiucAiyK3GQk3W
	u9z12oBu1YvuBd0ACoDeTvVlnDmPn38PQVUtRR7IT7cYo8w+bmFl/RNVxcJ2AoCUNvhLoN9UPIe
	q4hnFO4MbOIC2dw1qvfrrqVymckEjTtqT9FSYyAjIk9XP7ndl4tVCXu5D+B7pJoWqPQ==
X-Gm-Gg: ASbGncur9mXoCTXrUxkAbwiFqleEAxtG7XhwZ0Sq1AFosoKd+Eo+SAulbuIJnXvoPl8
	RVUVWxp1UW/OyDlqaoNhl5OwIqNEzRRAiBVxEjvlBYddoGFKQqxYRHmty2iPW5MKA7WkBOnq9Yr
	PvTW72MHSHezUVLbhI8wyikB9zYabL0ny5y1ITDfBAXtKyYJNYJN/F4NIJyVVB/uZB9uctcdwTq
	rhy+DsAUragSdYEpg7thN3gxWQ4fGn9h+AVuh0CiFaVW+cohQ2J63UiAXQr1Ut3GbKzBmlNHnPj
	/eSK8vVCdNd993ZVfQsPzYeWVUwchiSFZsKejhYq5WjLU4/UGkmnJytx4QpARaY1YvqCg0AvQQ4
	vfOwsawRg7oHzIevOBREV7lvhO6pCJdWGCDXt2axHfzump5CcTuNMHzDebIMX1gvJyyqnBZoteB
	Zpj6Y2f9mXi5QmRK+k/747htcdAfw=
X-Received: by 2002:a05:6000:705:b0:427:603:715 with SMTP id ffacd0b85a97d-42706030721mr8869520f8f.18.1761060326893;
        Tue, 21 Oct 2025 08:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiKHKT5n4lxAIXcZezjjomGqsscckAjK3PPu93OYAWQLb8JpaHvdOvGofIdZ4ec/p/eA4hhg==
X-Received: by 2002:a05:6000:705:b0:427:603:715 with SMTP id ffacd0b85a97d-42706030721mr8869502f8f.18.1761060326480;
        Tue, 21 Oct 2025 08:25:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0ec2sm20701088f8f.3.2025.10.21.08.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:25:25 -0700 (PDT)
Message-ID: <8f71e65c-a860-40ec-8570-5cf8f0f947d1@redhat.com>
Date: Tue, 21 Oct 2025 17:25:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, craftfever <craftfever@airmail.cc>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
 <844af749-374e-49b3-91f0-a72e951981c8@redhat.com>
 <2d0cbd23-83e9-460b-a82a-d006a14fa9fb@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2d0cbd23-83e9-460b-a82a-d006a14fa9fb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 05:00, Pedro Demarchi Gomes wrote:
> 
> On 10/17/25 19:23, David Hildenbrand wrote:
> 
>> This patch does to much in a single patch which makes it
>> rather hard to review.
>>
>> As a first step, we should focus on leaving most of
>> scan_get_next_rmap_item() alone and only focus on replacing
>> folio_walk by walk_page_range_vma().
>>
>> Follow-up cleanups could try cleaning up scan_get_next_rmap_item()
>> -- and boy oh boy, does that function scream for quite some cleanups.
>>
>> This is something minimal based on your v3. I applied plenty of more
>> cleanups and I wish we could further shrink the pmd_entry function,
>> but I have to give up for today (well, it's already tomorrow :) ).
> 
> Should I send a v4 to be applied on top of your minimal patch? This
> v4 would eliminate the need of the for_each_vma using the test_walk
> callback like the previous versions.

It would be good if you could test the rework I sent and see if you want 
to do any tweaks to it. It was a rather quick rework on my side.


Then resend that as v4, which is then minimal and we can reasonable add 
Fixes: + Cc: stable.

Right from that start we used follow_page() on each individual address.

So likely best to add

	Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")

Once that fix is in you can send further cleanups that are independent 
of the fix itself, like removing the for_each_vma() etc.

-- 
Cheers

David / dhildenb


