Return-Path: <linux-kernel+bounces-862838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501DDBF65EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23492460A85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE033DEF8;
	Tue, 21 Oct 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8VZH8UA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64533373B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047700; cv=none; b=hascv8Ohc7p/TVimx19roDIi+fzIqzZ7tZLh6OqIAsdR83hi9/cONOG5+YKjwA29RbxB10wlFbuRvTBL+HnI/OUcn8Up5lSUeIQt29V021PfBWIQMl8yiTsl2zSDOvrIt4XLwJXyV289eTZUFv93S9qkETz6NwOARekGix82vr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047700; c=relaxed/simple;
	bh=i0j8FgwGPeON0SRekmlOd+y+TUDvqNz3NMsXik0Po60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0GpA2/+gIJ40OU0TV7kOUU53FYv4peWYLQ0O/q2DuIMAcPkL61eR0tKiVLbxQeUMf7EzVC0MD5KXIuN2A8wAg8RJS8I7RtkKEncLl9xxukOZbfmOvCAmBQK3G7nkwhwumtgT2EiWqiCeiqS9E1jS+heX2FRoLBN0ObhgAybgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8VZH8UA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761047697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UjhTzDfDRfRTb0ujoYWqdsfQUJ32BJBRRtMqD14uvto=;
	b=W8VZH8UAFBURHvFcxNXnotPYb0m93dm6Lp3/k58wB0H5PF/im8Dde4E2TfXe/FEENCWdB9
	Cj8y0oLHraPMYCku3ORzXikDs7gmC7aB7DowuCFGqqXq6KBxGr68LI2Z/VULD1sahau6xu
	vwD6wrvD0BIOyoqwHbMbb73S0wzjH08=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-E6qqHtujPF6yc2mHmQqZHw-1; Tue, 21 Oct 2025 07:54:55 -0400
X-MC-Unique: E6qqHtujPF6yc2mHmQqZHw-1
X-Mimecast-MFC-AGG-ID: E6qqHtujPF6yc2mHmQqZHw_1761047694
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427091cd689so1978735f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047694; x=1761652494;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjhTzDfDRfRTb0ujoYWqdsfQUJ32BJBRRtMqD14uvto=;
        b=wYRdijQOoHaVWXUJzfYxWVRO17rb/atM9etxoVQSzcEwBXX3haftGjLW285Qag6Z+r
         BS2KKA7eeASGHtCwvhaXOkV+11ncE2kxxJRcFGDADnAESwhW12HFl9kY2bgr4epT7g5f
         GFTfwqMHAEgzJW5MPdfClrNdO/8pRD5JwRbzBWT5VeMyy/rvukB5gJtm9TOT62eKZzCI
         55NeCCrbNDNoyqPc+363jJn64q57gaZOgv/eltp5Z7WdKiJkEepbE9gKqnRxCRdHW/OU
         SZ7LnbrMii6QGoEGtlkc3EsKHXLC7qcHH28YysY0OF5DCRczPihfLeJ8CFkV4EVb22ZC
         qaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS7BJ37SpLDGXCtCzACFLlew2FbMT0Huc1X6V5zEFw2ayDP4a+9O5u65v1l25zjqj6oqMCm83JGi9TPIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YLw0ktCtj+aWQvZ4O+9E+WQW6GdkZfkxPtQKpRfNcjioDhhm
	JqinPZRJd3/88fznxYAkt4/47ezSYJaI3bseHRjxWVZz5UGDyIbFopLKbyUt9kvxXetaa4lUPtp
	mtKMapBgT2HJMMOLIvOwoPEHDxic+V14nS4w0fcnhR6YjfRujd+OMINNrpSidFUaodQ==
X-Gm-Gg: ASbGncs6OOA1RunQelOd0HBanMWVuktn2yjGFmj2df+cW5HE2sFXgr+sCswKR1DktGq
	Wfj86tRnHurfIY2BKo5GZG505R50t/X7BvGxaPDXRO62d/tddKXM3a51cF5kJTvYAWw3X8GsNhC
	jpMeUbSA9oqEhC1qn5VwecufqvcVy3E0MEq6xI0LJjAXCv3UnDeX94juZG+ai8lZ5iI/2fY/w5y
	pxj2N3XlSNT+lkSiM9O32w7kl2uAuXS+bDb38RLJzDgGrTTWrm5VEWQXGba9Kz58Keg2VpUlSr1
	zX4E4QWttKCmG6HD39W7rd/LoRoHiyMYpXiQP+Ab4kVblstQym4rq1T7GZnKayHvakbGhEge7UL
	XdXByPtHlrPow6ai6ABJgZcmBg7r+25/q/qC/8B6lFH3/DvQ3dzba7PFXt5d624ooJePcCr+iKV
	MQ3IiiybXzMNG/Orx2RCvVHWxJ4DI=
X-Received: by 2002:a05:6000:3105:b0:427:64c:daaa with SMTP id ffacd0b85a97d-427064cdaecmr11329361f8f.44.1761047694107;
        Tue, 21 Oct 2025 04:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4hoS405o7SL+OX0J5tYiis8Ib15FCEt5fy5LSf9ht7t7QJikfAXYAkg1xAnP6qrMgvDH/9g==
X-Received: by 2002:a05:6000:3105:b0:427:64c:daaa with SMTP id ffacd0b85a97d-427064cdaecmr11329329f8f.44.1761047693656;
        Tue, 21 Oct 2025 04:54:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f88sm19307889f8f.7.2025.10.21.04.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 04:54:53 -0700 (PDT)
Message-ID: <e4349d5a-33e8-4b8d-b1ad-6192ba00ff66@redhat.com>
Date: Tue, 21 Oct 2025 13:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
 <a013f044-1dc6-4c2c-9d9a-99f223157c69@redhat.com>
 <37ceab54-c4b2-449e-aa46-ffaefe525737@redhat.com>
 <eokncpih37zm7ypt6gn5xyetx6jlemhvvfdzpmdlxleqlsqcr4@45h5w5ahwugs>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <eokncpih37zm7ypt6gn5xyetx6jlemhvvfdzpmdlxleqlsqcr4@45h5w5ahwugs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 13:31, Kiryl Shutsemau wrote:
> On Tue, Oct 21, 2025 at 11:47:11AM +0200, David Hildenbrand wrote:
>> On 21.10.25 11:44, David Hildenbrand wrote:
>>> On 21.10.25 08:35, Kiryl Shutsemau wrote:
>>>> From: Kiryl Shutsemau <kas@kernel.org>
>>>>
>>>> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
>>>> supposed to generate SIGBUS.
>>>>
>>>> This behavior might not be respected on truncation.
>>>>
>>>> During truncation, the kernel splits a large folio in order to reclaim
>>>> memory. As a side effect, it unmaps the folio and destroys PMD mappings
>>>> of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
>>>> are preserved.
>>>>
>>>> However, if the split fails, PMD mappings are preserved and the user
>>>> will not receive SIGBUS on any accesses within the PMD.
>>>>
>>>> Unmap the folio on split failure. It will lead to refault as PTEs and
>>>> preserve SIGBUS semantics.
>>>
>>> Was the discussion on the old patch set already done? I can spot that
>>> you send this series 20min after asking Dave
> 
> Based on feedback from Dave and Christoph on this patchset as well as
> comments form Matthew and Darrick ont the report thread I see that my
> idea to relax SIGBUS semantics for large folios will not fly :/

Then I was probably misreading the last email from you, likely the 
question you raised was independent of the progress of this series and 
more of general nature I assume.

> 
> But if you want to weigh in...

No, I think this makes sense. It's a regression that should be fixed.

> 
>> Also, please send a proper patch series including cover letter that
>> describes the changes since the last RFC.
> 
> There is no change besides Signed-off-bys.

Then point that out, please. It's common practice in MM to send cover 
letters for each new revision.

For example, Andrew will usually incorporate the cover letter into patch 
#1 when merging.

-- 
Cheers

David / dhildenb


