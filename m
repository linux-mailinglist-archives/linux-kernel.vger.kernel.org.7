Return-Path: <linux-kernel+bounces-822370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F21B83A73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC250721518
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2992D94AC;
	Thu, 18 Sep 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PqfpST/b"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50F2D9491
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186070; cv=none; b=fYWCev8/0yiGj7y12oILAr0AP9irJBNdn73Utnf3xRe57H98KyeZdAy8epzuzhuq2k3zoX+nfImdAGTzMB0LTk41SvzESmgxIQRv7b63UIjG5eauzUPWuFxKTJn8IGNXgq+oRqzDNUUfiFosr9cHo3LSZf6WLz/O8SFbh/XNlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186070; c=relaxed/simple;
	bh=AqZM7AdYIKykOwepAJRBMw793BMf0ItIPyZAUrbjvEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKZl/69Q0V4/haLQxb6aokoqm/w6GpS2mK/RUyhF+tDj3oNqSA0Pg9NC6c6R4OOs+oyvHSqmfWzXiQGO8/BFaTf649gu917ncIdjsCs5dkcXXsk88Hzu53uDv5trBV853USXmBoZP+O2KCVyR8RYL3pWoFLFlCemTlZ6zhv3FOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PqfpST/b; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3e03ae3-36fb-455d-9f62-7e915e7bcd46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758186066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/wSaqH34v0KZoe6ggKel2oXiRC6toJfQY2vW/+tF20=;
	b=PqfpST/bvj8Jq1kdP13n/p+IjwVELtyooR80qm0u87t239/kMFNHZafJIH8I1yOSbZOxOa
	+RwNlf9y9pCVPxVrrBlTvGxQLFH90J6YckJ0hVeXCjzyrfwKqIUFiEZkIz4jy1wGpByyCU
	+8iuXunakmoihq9Hpnss7zGvGkd23Oc=
Date: Thu, 18 Sep 2025 17:00:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
To: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918071741.526280-1-ye.liu@linux.dev>
 <aMu01xIkj-3hgW88@tiehlicka> <1a9f44a1-855c-450e-9dc4-415a29b90011@linux.dev>
 <780aa9d6-a85c-4050-820e-c0ca9f5bb658@redhat.com>
 <6d6e2e33-c221-4ab8-a29b-3d14fb1a592c@linux.dev> <aMvHt7Z2PMuZaned@tiehlicka>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aMvHt7Z2PMuZaned@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/9/18 16:49, Michal Hocko 写道:
> On Thu 18-09-25 16:31:22, Ye Liu wrote:
>>
>>
>> 在 2025/9/18 16:16, David Hildenbrand 写道:
>>> On 18.09.25 10:11, Ye Liu wrote:
>>>>
>>>>
>>>> 在 2025/9/18 15:29, Michal Hocko 写道:
>>>>> On Thu 18-09-25 15:17:40, Ye Liu wrote:
>>>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>>>
>>>>>> Add a header line to /proc/buddyinfo that shows the order numbers
>>>>>> for better readability and clarity.
>>>>>>
>>>>>> Before:
>>>>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>>>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>>>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>>>>
>>>>>> After:
>>>>>> Free pages per order       0      1      2      3      4      5      6 ...
>>>>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>>>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>>>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>>>
>>>>> Why is this needed? And have you considered tha this might break
>>>>> existing parsers of the file?
>>>>>
>>>>
>>>> Thanks for the review.
>>>>
>>>> The reason for this change is simply to make /proc/buddyinfo self-describing.
>>>> Right now you have to know which column is which order; with a header it’s
>>>> obvious. This is similar to what /proc/pagetypeinfo already does, e.g.:
>>>>
>>>>    Page block order: 9
>>>>    Pages per block: 512
>>>>
>>>>    Free pages count per migrate type at order   0 1 2 3 ...
>>>>    Node 0, zone DMA, type Unmovable             0 0 0 ...
>>>>
>>>> Regarding existing parsers: the patch does not change any of the existing
>>>> “Node … zone …” lines, it only adds a single header line before them. Most
>>>> parsers match “Node” lines and ignore everything else, so the risk should be
>>>> low. If you know of any existing parser that this would break, please let
>>>> me know so I can address it.
>>>
>>> What if there is a single one out there that has hardcoded to skip the first line only?
>>
>> I understand there may be no way to be fully compatible with all existing
>> parsers. However, /proc/buddyinfo is essentially raw data intended for
>> human and tool consumption, and parsers are expected to be robust against
>> format changes.
> 
> I am pretty sure you can create a trivial wrapper to print that header,
> right?
> 
>> Adding a '#' prefix to the header would allow most parsers to skip it,
>> but it still changes the file output and cannot fully guarantee that no
>> external tool will be affected.                                          
> 
> That still assumes that they expect something like that.
> We are trying really hard to not break existing userspace even if it is
> not written in a robust way. That is simply how Linux kernel handles all
> the existing interfaces. There must be a very serious reason to add a
> change that might _theoretically_ breaker existing userspace. What you
> are proposing here is not such a reason as it is trivial to achieve what
> you want from the userspace.
> 
> NAK to the change.

I’ll drop this change.

-- 
Thanks,
Ye Liu


