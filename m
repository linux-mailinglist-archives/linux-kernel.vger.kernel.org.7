Return-Path: <linux-kernel+bounces-742184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE6B0EE65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583977B61BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD8287506;
	Wed, 23 Jul 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lha/DSOm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A136280A5E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262755; cv=none; b=XsSvHjLtalFR1K3e9I8mO8SMiigEVDMF/95L4iOsWRgSz85qYkQcDxGBomRhdclch1nzBzo82zSCDyGhY01bA1H3HAOZe4p9fDoPKj9Wf4ibh1kC2ZZ+wjuQbRTk+jGtWuJQ3HIxfg2xYEU4w8vB5JlCVuSvIWGH7MNCTZWOjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262755; c=relaxed/simple;
	bh=5Qh7qWW7rQNwjT6O5C5+CeJqwieCA1ygol2/3xBTsOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBqM+Q3ZL/n7nIlgQ7X1Fh395MGmk723WX6jHr12rmvEJHuaE+VqJ0NbBlfITGZI/7kqxerCcyW0nibImvy7OAgjDxe0Hu4ZtbLs5m99otX2KCegAxsaD8vZ8iS2na6+rXmh4fVeNaFLDGI5xiOW4dFTvQt6r9pWlhbJT/E5aFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lha/DSOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753262752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sCf8Aj8CqcKCT8W+sN9Cfe8UnmLiHoTES6bbWgE/pKg=;
	b=Lha/DSOm+SvJlxNzY5T2IO2IUqLKXg0YAeV3WuGav1wAjk3bA0cxjZuqhYPJers5ieT8fx
	/lyZunfGSsy2xslbQjBVli7o2eWae6zKIutq6nxa4ALjF94jXVGiKMEPzvBKpFYIIryphX
	6XojvBRclbXIXsKVRGCwtSguxe+hbT8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-FdAA7YI0PSarNsaRRS9RXg-1; Wed, 23 Jul 2025 05:25:50 -0400
X-MC-Unique: FdAA7YI0PSarNsaRRS9RXg-1
X-Mimecast-MFC-AGG-ID: FdAA7YI0PSarNsaRRS9RXg_1753262750
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso5151530f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262749; x=1753867549;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCf8Aj8CqcKCT8W+sN9Cfe8UnmLiHoTES6bbWgE/pKg=;
        b=mzePdESBNiyLiGCkDPCE+vPKH9VXkYareeTJ7pHPcMLuveAzVr9vKGQSx4lciDuCDg
         /YCGXz5huDtZgl1CAE6/GleZdQ71mlmmpxZMpOH/4joctr8kTF9bpwaVkXLYmBOlDltP
         rdvx2piqXug64iLPHYW4LYvsghUQ2RCWsCg7T4rejHdgFafNdOtBkdG+SO3XA5bwmJZT
         e9ZjqZuj57QVGEOyGsqtpT+TFiLcDlMyPZG72XFk1ArFdMiLGesTU1GgDJ1zEH7oMkhS
         BM39XGYZZf7xYo84LSf+l2txmFLwCOHzHkZ0KjknfzkbdzvqIqCR9DRZ250/LcD+Y1EH
         NkWA==
X-Forwarded-Encrypted: i=1; AJvYcCX3u+3Vi8QwXXjifP0z0X2lxzcXAVzVIJaWR7/V1e2E+4tFSbBkD91pyIiKs4o35fQ4soOmMI4wI01zLcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gChh5aHvuDgroxOpwD1N9uAtDRix0NIr2+2ZIo/zoEvn+OMl
	5JrBTXpDHp/5yy6ovca1aqe2RswQ5OZ+AyddJk84MscUy/jfSroiXGwY5n+1sFo4uH7cmgcCLgI
	7BSmWYxYE3f0iXVl71+GPbnKUJnAKlprxi85Ih6x2MQq5Ugf0pLMWgGLeLRwImUeyeQ==
X-Gm-Gg: ASbGncs90e+JVYBwFAFXBHkCoS0wGkw4/H3kdcEoS4VGdrGrrXsNgcy7+BhBzTXsFUF
	+YH5s0MfWPcOHHiibwXG89TXOkFP1S9T7zSFv0oMmhGAXPs7/QbTBx6Y4fAaw5BaxLW15MkecHX
	wjmn6U34zm2MG998ciFA1uSbgwtclXlO3pQEpc4SzTFzK52itfvb5WD2n4EY6UwzeZwc15AfW9p
	E/ISLlJYLsQNiGMhv3oHGLmLqCAN4q/RHMxfnWGwd4j8nzNGaX7BOxrX2VFMWQKwzo9sOWHEofS
	fFZhXCqQrwX64E0WfzqyY9vWZuhxQ40T498noW8TinmaeOBfiX8qk9wApbNtQSb21tQyvBkCU9F
	c6m9DQYHO6b4eSLU4rEXIHuDArUrmJ23376T2jiIGQkTY2kYR/zWcqKgz9KZCSjgL2Lg=
X-Received: by 2002:a5d:5f93:0:b0:3a4:e480:b5df with SMTP id ffacd0b85a97d-3b768f2686bmr1999864f8f.44.1753262749495;
        Wed, 23 Jul 2025 02:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtUubqoA0hMp5my3F0ywmrRe1kGuOJ3bA2qH51pMUGeJqeMcqjO+aQrd067eLUelen0I38dw==
X-Received: by 2002:a5d:5f93:0:b0:3a4:e480:b5df with SMTP id ffacd0b85a97d-3b768f2686bmr1999843f8f.44.1753262748961;
        Wed, 23 Jul 2025 02:25:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45863cd63f9sm27634505e9.3.2025.07.23.02.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:25:48 -0700 (PDT)
Message-ID: <11ec00da-56c6-45b9-b04a-7e79467c4300@redhat.com>
Date: Wed, 23 Jul 2025 11:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
To: Vlastimil Babka <vbabka@suse.cz>, Xuanye Liu <liuqiye2025@163.com>,
 Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
 <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
 <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
 <8dd1e8f6-f96d-4d36-ac2a-c258ac842f75@redhat.com>
 <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
 <fb5426c1-c94b-4e79-b09a-fb6b8b1ce03b@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <fb5426c1-c94b-4e79-b09a-fb6b8b1ce03b@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.07.25 11:17, Vlastimil Babka wrote:
> On 7/23/25 11:10, Xuanye Liu wrote:
>>
>> 在 2025/7/23 16:42, David Hildenbrand 写道:
>>> On 23.07.25 10:05, David Hildenbrand wrote:
>>>> On 23.07.25 09:45, Xuanye Liu wrote:
>>>>>
>>>>> 在 2025/7/23 15:31, Kees Cook 写道:
>>>>>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>>>>>>> The check_mm() function verifies the correctness of rss counters in
>>>>>>> struct mm_struct. Currently, it only prints an alert when a bad
>>>>>>> rss-counter state is detected, but lacks sufficient context for
>>>>>>> debugging.
>>>>>>>
>>>>>>> This patch adds a dump_stack() call to provide a stack trace when
>>>>>>> the rss-counter state is invalid. This helps developers identify
>>>>>>> where the corrupted mm_struct is being checked and trace the
>>>>>>> underlying cause of the inconsistency.
>>>>>> Why not just convert the pr_alert to a WARN?
>>>>> Good idea! I'll gather more feedback from others and then update to v2.
>>>>
>>>> Makes sense to me.
>>>
>>> After discussion this with Lorenzo off-list, isn't the stack completely misleading/useless in that case?
>>>
>>> Whatever caused the RSS counter mismatch (e.g., unmapped the wrong pages, missed to unmap pages) quite possibly happened in different context, way way earlier.
>>>
>>> Why would you think the stack trace would be of any value when destroying an MM (__mmdrop)?
>>>
>>> Having that said, I really hate these "pr_*("BUG: ...") with passion. Probably we'd want to invoke the panic_on_warn machinery, because something unexpected happened.
>>>
>> The stack trace dumped here may indeed not reflect the root cause ——
>> the actual error could have occurred much earlier, for example during a
>> failed or missing page map/unmap operation.
>> The current stack (e.g., in __mmdrop() or exit_mmap()) is merely part
>> of the cleanup phase.
>>
>> Given that, how should we go about identifying the root cause when such an issue occurs?
>>
>> Is there any existing way to trace it more effectively, or could we introduce a new mechanism
>> to monitor and detect these inconsistencies earlier?
>>
>> Let’s brainstorm possible solutions together.
> 
> Excellent idea! How about we introduce a function that walks the whole page
> tables and checks the numbers of individual pte types against the rss
> counters. And if we invoke it before and after every single pte update, we
> can pinpoint much sooner the moment it went wrong and the stack that lead to it?
> 

:)

On a more serious note, I ran into that usually after hitting a bunch of 
print_bad_pte() statements: vm_normal_page() would return NULL where it 
shouldn't, making us not adjust the RSS.

In which context would you run into this issue?

Usually it really indicates some fundamental page table handling flaw. 
E.g., page table corruption leading to print_bad_pte() earlier.

-- 
Cheers,

David / dhildenb


