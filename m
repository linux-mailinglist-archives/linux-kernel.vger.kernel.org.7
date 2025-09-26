Return-Path: <linux-kernel+bounces-833667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF5BA2989
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA7614E1809
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822027FB2F;
	Fri, 26 Sep 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UDIG2jBL"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AEA27EFE3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869876; cv=none; b=fnH2yNRJ7RP1KctDoodUUVNi037x9HXwLqg07bW69zfnK398VT6ZQ8rGqUJZO4Xpj2vMi+mX0odX/MUBoUQPx4SKdIPkhbh4nBbWzd+Xb2r67mkx18NJXK8bW+UaHTdYVBFDGAs+5e1x0XKkf5ZhJD7ix8UPIe9gl1XIk5D8jJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869876; c=relaxed/simple;
	bh=YgymePRKA7a+5Gycw6dzc3Ehm1gp8bc3lnVl3WW1LzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObddP1bP2bOazWg4fvEIfN1o8U+/aNBtNpwwIfOMYQzil0MdpBlPnmI7SXNjx92+uO5BKgv8BidWXTlyqEZuMbln+9WAROvvmIm7I+jR14cmDIPT1fd0EzGKgMOkcYCgjpujmtop4vzBOI+V+HnP8K8dpqK73oYO1KZvc9UhAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UDIG2jBL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54a74f9150so1647168a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758869873; x=1759474673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vx1itF2fTgxMCrrImdJeroS3R9ZKO1BJn3DX+Hel84=;
        b=UDIG2jBLNC5IWX7ZlFEoTTyFqrtkm0iblohSdKFYLR2xXCigN3VFO4YG5WP+Yvz0Ld
         ArnxrpjPICdOtVf569UJpIrdC/n6Y7jX51iedDOYZ5tueypZRxeZtXWFT5go8poZX63U
         vciUNg38FvKOKVpVqc2IIDcKD+REJnMJkJZHCIDcIXBeyU3LZW2XlVkukwdilPfJly6+
         S238xtVRDoKjhGtEFKUJngwhwoUW2dKZ4rfyErigQ9qwEWRigT4kXic/PA/psHa/Tgc3
         OOj4bwKIao4xbFENoaIXpvqC97GqLPH9MX8+unZNLC2qwnvX+hZntM+8pEww6JxKfN+E
         6USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869873; x=1759474673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vx1itF2fTgxMCrrImdJeroS3R9ZKO1BJn3DX+Hel84=;
        b=nAI/seC57TosGAEM9lIWyIJMMYvZE/zOvNFpTHshaqxL41HxMNWK81JgzEfokRvKs8
         s9oVICJLT+yBamg9JeNwtwchCCtXUzBqTxPo/sdcfMXawwyhRp3eFrr2fZMYzfXaIkEM
         kffZzX8vItJ0f2IJspVfmqNfGo3IuYSzzH7VhHcHrfbL4HwSXANwYj2kUoaHtdwOR9nO
         T9+0wTiopgMBgbHqlLWdo5quVbdNT3RxS62y/tAbJyxq6KAqk3SzzgprzmxaeYwO31Eh
         /Uabrxwtk5f14tsn9ygyPc1zJ4lkR9AVbUg2jF6S0x8mZEy5lXWGzWs/Leh5UUmk3nTn
         9BFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjexJgepoZ1GSxIvTT0ch9uRUsCU/EOzUajfTzbBJ9LmCUHXMYM20hKHX2FPVq6G7tu3Yzymdqjd87hzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGwL6oUIVcsISWSWZp8WbBV0dOZuFGDH3Xf9VQ9NaHtD/vWBc
	HC5jjYjU4mzsKTqWGyaERo2ZYwdtTlIj6ihsazKMxWme51xPzFw5WktMTsgeaRzAyaY=
X-Gm-Gg: ASbGnctRQxPrO8C58OXBtQAqXcBdbJOfuhHTIF3FxkvUQUOfB1xnfC+GH9nl5gskGgR
	Vjw57BDEK0xA7K38vf8LLiPN34vgHgFQ+w9pU3k+cGa0uAnylEcS1EJcGOGzO3BOHnU82ZH9Sn1
	EzSbZmB0o31pMI96Uqv8TXN2J6sQIjWqayml2alL9/e1ckPDZAbVNFf+LEz3odHMqcRVr6w3Jly
	MOezzfkAmdpu4YD2T+2JxUsiXbHQDgfISk8DnXekGZSIQdxGPTW6CS4lwSHb7qNV2XWEWDWzF/R
	WVmlsoMAOIus8/nGS2Bpe9DjJX8k8ziN8VbwRKpkCR0s9JuGMzJPcNN4b82DsuROGsvC0cGv41M
	fCRzF78jIS9q/FfyyxlI0hP0pOgP9Qs33KhlMO+OA9BOQl9Duxb6vsYXQmfnPvREA6qz0
X-Google-Smtp-Source: AGHT+IF5bDf0FkWtdSNimjWM369R4KoAz2kYx41Je3d4j3cldNB8OPUueqbjTUh0a0uZVlv2hvbHNQ==
X-Received: by 2002:a17:902:db02:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-27ed4a91a32mr59676945ad.32.1758869872599;
        Thu, 25 Sep 2025 23:57:52 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27f1c1af2d5sm7102075ad.58.2025.09.25.23.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 23:57:52 -0700 (PDT)
Message-ID: <fc91a0ab-e343-4f7c-8fc3-508ab0644e42@bytedance.com>
Date: Fri, 26 Sep 2025 14:57:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@redhat.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
 <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
 <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
 <tyl5nag4exta7mmxejhzd5xduulfy5pjzde4mpklscqoygkaso@zdyadmle3wjj>
 <wlbplybaecktirfzygddbvrerzrozzfudlqavkbmhnmoyt6xmf@64ikayr3fdlo>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <wlbplybaecktirfzygddbvrerzrozzfudlqavkbmhnmoyt6xmf@64ikayr3fdlo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/26/25 6:35 AM, Shakeel Butt wrote:
> On Thu, Sep 25, 2025 at 03:15:26PM -0700, Shakeel Butt wrote:
>> On Thu, Sep 25, 2025 at 03:49:52PM -0400, Zi Yan wrote:
>>> On 25 Sep 2025, at 15:35, David Hildenbrand wrote:
>>>
>>>> On 25.09.25 08:11, Qi Zheng wrote:
>>>>> Hi David,
>>>>
>>>> Hi :)
>>>>
>>>> [...]
>>>>
>>>>>>> +++ b/include/linux/mmzone.h
>>>>>>> @@ -1346,6 +1346,7 @@ struct deferred_split {
>>>>>>>         spinlock_t split_queue_lock;
>>>>>>>         struct list_head split_queue;
>>>>>>>         unsigned long split_queue_len;
>>>>>>> +    bool is_dying;
>>>>>>
>>>>>> It's a bit weird to query whether the "struct deferred_split" is dying.
>>>>>> Shouldn't this be a memcg property? (and in particular, not exist for
>>>>>
>>>>> There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
>>>>> the protection of the split_queue_lock, otherwise the folio may be added
>>>>> back to the deferred_split of child memcg.
>>>>
>>>> Is there no way to reuse the existing mechanisms, and find a way to have the shrinker / queue locking sync against that?
>>>>
>>>> There is also the offline_css() function where we clear CSS_ONLINE. But it happens after calling ss->css_offline(css);
>>>
>>> I see CSS_DYING will be set by kill_css() before offline_css() is called.
>>> Probably the code can check CSS_DYING instead.
>>>
>>>>
>>>> Being able to query "is the memcg going offline" and having a way to sync against that would be probably cleanest.
>>>
>>> So basically, something like:
>>> 1. at folio_split_queue_lock*() time, get folio’s memcg or
>>>     its parent memcg until there is no CSS_DYING set or CSS_ONLINE is set.
>>> 2. return the associated deferred_split_queue.
>>>
>>
>> Yes, css_is_dying() can be used but please note that there is a rcu
>> grace period between setting CSS_DYING and clearing CSS_ONLINE (i.e.
>> reparenting deferred split queue) and during that period the deferred
>> split THPs of the dying memcg will be hidden from shrinkers (which
>> might be fine).

My mistake, now I think using css_is_dying() is safe.

> 
> BTW if this period is not acceptable and we don't want to add is_dying
> to struct deferred_split, we can use something similar to what list_lru
> does in the similar situation i.e. set a special value (LONG_MIN) in its
> nr_items variable. That is make split_queue_len a long and set it to
> LONG_MIN during memcg offlining/reparenting.

I've considered this option, but I am concerned about the risk of
overflow.

So I will try to use css_is_dying() in the next version.

Thanks,
Qi




