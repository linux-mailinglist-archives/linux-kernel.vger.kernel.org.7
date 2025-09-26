Return-Path: <linux-kernel+bounces-834454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A8BA4BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E823BE9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38B3081A9;
	Fri, 26 Sep 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QTd9Kv9"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3B1C32FF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905842; cv=none; b=TLrE+rVEKj2g/x/CZFDzyP98k77TluxkD3/h1A27tIjUnNnFloH7iXP2qv/2e3v1aLH4wTF+GjxHo7WvpT4+zavfaHReBLL5zKXhwqxnpXipdNNznpMBBEgfyGFiJg7XvHhI9UAS1o/Kb6WIcwP0ZTJPyD0OKdxyEHFyr5oldlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905842; c=relaxed/simple;
	bh=ozFAnMSj2kgHC6gcHPW5nvG7r9I5NW1sV3pIP5G0wVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNc53ZZOnnlfTgo021OJIk6wrxM/83/hMjyBmn1aPd4MB8eRUm6SjqU7FTPT+8jMZPQROzuF07S1pO0qWIcZAcBBpQHYIL4+HQJaFPWPYR5FOgGDXkUcdQWGqoGMjKh8HU96rI/qeAgjdRTHHWs7jOZ6ghJROax7XmyTUuYJsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QTd9Kv9; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-afcb78d5c35so256605866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758905837; x=1759510637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ju6gxyxgWTxjvMZdx3ZtN+Zpu8mTYwaY+/0NZYuLlA=;
        b=2QTd9Kv90bGp+NSV0fkm0euYaoAvRiuVeS/7EkM6lcl6gwujTGw3uhddVHAZycl/ap
         0+sINkMkftM5aWLw7WDuILPRZl7WRwAku0+R4yHy4+g1v9pYtqhG7Cfq2Z7aLy5kTYt6
         kCRbJZ6Xk752m8nyDHV/I+9gUHwOVBsH3zMyHmA83UEy13V5j4xBC8sCngaOmICYAAGz
         MhCeMHXeChnW+EZEQfL5mmbiO90t7cWJ/6xspYVOAzw/BmYs8tWQ1JnVou4+gbSVU9xw
         zBVMFVMRR5Ag3ZnlW8vJilOkisavV3uORBUejFgvjIdIWBuMgoH9Z1p6QIBp25iRU+mB
         JPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905837; x=1759510637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ju6gxyxgWTxjvMZdx3ZtN+Zpu8mTYwaY+/0NZYuLlA=;
        b=EJfS1QYJ0BcncCSRz2bfZw28toDap9P0Ui/yoHd1MZXWvCY8j6N8bCGJgtd+XC/KPo
         IWnfnGSkSfLPispql7oiDPPCtIDsSF7mYf8hrMFGMIXyoCWqihP3utYH0zV6dMOsHpWz
         21MlyxQljG+dblfXokKEyFhZRARjsXQsk33ImtDGna5jUSLkyUeYws1wEvT858P38u9k
         x52G8MmS0RGXUIlAIobTvUDRqWwUeEY0sXx/ASE6EJj6MC9xrYipIYXCBQ+Di4ze6rzg
         n4QLfaP8gPLWjVu88vEwVkY6Hdd0/hgr/7GnmtyZ2Z1jnKm9U7NwiU2lJhsIkHYha4Hh
         eIew==
X-Forwarded-Encrypted: i=1; AJvYcCVOBbKg6Cu0rbibcbXeX+2XXRPGs1mlu275PsLnbBa8WxQF2mx/a5QtzkLCLdPBgcTGMaM81qwQLtrUI5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9MLN8DO45KJtkdNNm7BiXHQ4VufkgKTpDxAPssxDzs4T+4nR
	XzvagX2wAm76RfDgbupKuK40aMrO+ND8wlrmu84K+xbMFMAusEulKAu4b+HAelQHPEOixPVYceQ
	ry9P3emCiLxpaRg==
X-Google-Smtp-Source: AGHT+IHEEKUcEgkinB8RkGOvRf0Mn+ZhFXgTH/LXZ/sF89QqfcyjXF3T4sban7Iur9CoxJ2skTB0kgdlTLmCjg==
X-Received: from edqk11.prod.google.com ([2002:aa7:c38b:0:b0:629:211a:d085])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b9e:b0:b0c:b51b:81f6 with SMTP id a640c23a62f3a-b34bb50f1dcmr907955266b.43.1758905837402;
 Fri, 26 Sep 2025 09:57:17 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:57:16 +0000
In-Reply-To: <20250926154834.2327823-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DD2SCJF0CLN5.1824PA58HFFZF@google.com> <20250926154834.2327823-1-joshua.hahnjy@gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DD2W2YFEPC3L.250WBJ4E5EM4K@google.com>
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
From: Brendan Jackman <jackmanb@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chris Mason <clm@fb.com>, Kiryl Shutsemau <kirill@shutemov.name>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri Sep 26, 2025 at 3:48 PM UTC, Joshua Hahn wrote:
> On Fri, 26 Sep 2025 14:01:43 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>> Hey Joshua, do you know why pcp->batch is a factor here at all? Until
>> now I never really noticed it. I thought that this field was a kinda
>> dynamic auto-tuning where we try to make the pcplists a more aggressive
>> cache when they're being used a lot and then shrink them down when the
>> allocator is under less load. But I don't have a good intuition for why
>> that's relevant to drain_pages_zone(). Something to do with the amount
>> of lock contention we expect?
>
> From my understanding, pcp->batch is a value that can be used to batch
> both allocation and freeing operations. For instance, drain_zone_pages
> uses pcp->batch to ensure that we don't free too many pages at once,
> which would lead to things like lock contention (I will address the
> similarity between drain_zone_pages and drain_pages_zone at the end).
>
> As for the purpose of batch and how its value is determined, I got my
> understanding from this comment in zone_batchsize:
>
> 	 * ... The batch
> 	 * size is striking a balance between allocation latency
> 	 * and zone lock contention.
>
> And based on this comment, I think a symmetric argument can be made for
> freeing by just s/allocation latency/freeing latency above. My understanding
> was that if we are allocating at a higher factor, we should also be freeing
> at a higher factor to clean up those allocations faster as well, and it seems
> like this is reflected in decay_pcp_high, where a higher batch means we
> lower pcp->high to try and free up more pages.

Hmm thanks, now I'm reading it again I think I was not clear in my head
on how ->batch is used. It's more like a kinda static "batchiness"
parameter that informs the dynamic scaling stuff rather than being an
output of it, in that context it's less surprising that the drain code
cares about it.

> Please let me know if my understanding of this area is incorrect here!
>  
>> Unless I'm just being stupid here, maybe a chance to add commentary.
>
> I can definitely add some more context in the next version for this patch.
> Actually, you are right -- reading back in my patch description, I've
> motivated why we want batching, but not why pcp->batch is a good candidate
> for this value. I'll definitely go back and clean it up!
>
>> >
>> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> > ---
>> >  mm/page_alloc.c | 3 +--
>> >  1 file changed, 1 insertion(+), 2 deletions(-)
>> >
>> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> > index 77e7d9a5f149..b861b647f184 100644
>> > --- a/mm/page_alloc.c
>> > +++ b/mm/page_alloc.c
>> > @@ -2623,8 +2623,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>> >  		spin_lock(&pcp->lock);
>> >  		count = pcp->count;
>> >  		if (count) {
>> > -			int to_drain = min(count,
>> > -				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
>> > +			int to_drain = min(count, pcp->batch);
>> 
>> We actually don't need the min() here as free_pcppages_bulk() does that
>> anyway. Not really related to the commit but maybe worth tidying that
>> up.
>
> Please correct me if I am missing something, but I think we still need the
> min() here, since it takes the min of count and pcp->batch, while the
> min in free_pcppages_bulk takes the min of the above result and pcp->count.

Hold on, what's the difference between count and pcp->count here?

> From what I can understand, the goal of the min() in free_pcppages_bulk
> is to ensure that we don't try to free more pages than exist in the pcp
> (hence the min with count), while the goal of my min() is to not free
> too many pages at once.

Yeah, I think we're in agreement about the intent, it's just that one of
us is misreading the code (and I think it might be me, I will probably
be more certain on Monday!).

