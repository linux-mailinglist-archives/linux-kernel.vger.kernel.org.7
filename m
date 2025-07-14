Return-Path: <linux-kernel+bounces-730393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B891B043F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BB87B914A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1425DB12;
	Mon, 14 Jul 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edWjV44M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264625DAFF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506767; cv=none; b=mA1olpm+QNKgMvGm/TmUQ/Zc86jXtKzH1fUVRomXzKZ5ewTUH8Xd878JQ+bh3p+UcL3ewLQMpBc98QneWiOesYGjamP+a9x8ps4Kk40rChdW2mXYqcfYKIafJcGLBOyhBfLO1nqWrWNNhbhYw768N2E/QnGMMN2C/wUsIlVn784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506767; c=relaxed/simple;
	bh=B2nNnofCbdWQMLA1IZqPAeR1yiz8M/mYhPdaoGDi0a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhxp0xhQCvC4+M5jcquDW0TupE4k+WJ6Rse7yrTKCjk2Dl68jBtZ0KT9JaQOWN/UeZ1iSj8lVLtDC1ISzpZNALuNlNfoI3oR9t1sC03y/fbxaaTLH1kHi7nClGr5+R7SZEIn2ElI60iw8oqvsjPfVjfDNprtvoSNeCSv3EV8WyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edWjV44M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752506764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VHGCViQy1nmkV3DUJUcJGBuXbl9yxC8NPr6QML7nGo=;
	b=edWjV44MxqVuyXtN4DBBYg5UOIt7D28loHnvRfNRb5h9s4ZLySGdqAxRAGM9mBRSmNU3Wt
	/w8PA9aEZLWsUztd5cKGrc5DE4Ng1DEOcSlYeEa2v3coJQCk0JOCSdf0uxExYpwvURGO/l
	XU41sCsNuko7NMy5teatVr6NoGE+tXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-WxyJcq6WMrWUU7R2mHG3hw-1; Mon, 14 Jul 2025 11:26:02 -0400
X-MC-Unique: WxyJcq6WMrWUU7R2mHG3hw-1
X-Mimecast-MFC-AGG-ID: WxyJcq6WMrWUU7R2mHG3hw_1752506761
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d30992bcso34582955e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506761; x=1753111561;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VHGCViQy1nmkV3DUJUcJGBuXbl9yxC8NPr6QML7nGo=;
        b=Z45436yRIzOExrLXOz3At9GuKx7IJLa9yTv3Gz+RnWkyXwbpM385uUwWnB7rYVM4NL
         quzl1GrA+r1f5TnmMd9i3kUW2zsvzJsWLJhBaogohcnv2OpezPTO2SPqNklk+/1hb6B+
         eOoryOhdA7mDd3D4utoURoOOW1dnsy0HIPXwEJvGtNAYtqvNMw+4s5Yx0cqqrbXMfsDg
         clAocaqsPmeFV7QzZXTvspXL4BPeeXEOFIGPMBc2ncyYx+JRc4DlEAkD4+aDWfJitMzG
         wGfmL5FHjO5c6bylYP8EgKmDyEKqxkSs9ogZ8xshB1rV60X7xpSTfh3p4rhymWEHVDYT
         Hokw==
X-Forwarded-Encrypted: i=1; AJvYcCXQDdtmVZZinSOHbmTKGO6xFKSw2F5k4G7jKr5fLRkDtczQ/53z04bG5dbiDFwoUrrSTh8Nzwbm01ehhmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54h/chsRFJIZkRHHzWXYZxrqGvim2mZiUlnxb9epRCEzQ+fpz
	mVT7BggsmuI/huWjBpO9cxQhr14LJi5NC+UcrRXQ68oyaxwCf4BPYHcCBs7wXAF7RfpezBmdyRX
	j4xyjd5raBOcugf0VoKPYPcDYGImb/iNHLyEK8lMhrxhYmVBM/nVr8hI8PtOQJTcRpw==
X-Gm-Gg: ASbGnctEW+S+woEE1J6c5OnRjdG7si5hUmccF5Q2AG1fiyYo+5pgV0JhaB2l7P0qDTX
	6EYMNHBIyr3E8FTGHSyrILlrxuIL9PUPuCpZnmQo5KTlJYnyi95ayyC0DxxEvTbVc7SONcnV7tC
	LeA3qe+6n5Y5KMdZu4KJCzjqwe1AS1QsJ35REB058YQgKXt+sJ/tW6dxLiUtDgLYzdvfZEOt0kW
	OJJ5JzY+FcgihfR5LKoAXalEZ5CBpGy3u+/3jw8+YHFJKEtzMIArIAn0LJ+zmk2LotHqeVuwuSA
	EhDojsCJL4aFBfWIzDrKSGYPP/k7VWa4r18grkeAPMv2CAQ9SLgJw0dguMPSt2hgEpGQh6NpW4l
	Ka4DTxRztNz1e4icFKfnZoVtvUvYPaVWA9V9Vh5SYPuzoqO2WYn/sKb9q/7iMysp6
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-455bd87a4a2mr110812185e9.4.1752506761044;
        Mon, 14 Jul 2025 08:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuOWgnY869Vy5HqhGIQqeATnGreqOqbm0tJKMjayVDKE7oxj+d5bWRSPH3Beio9jC9kUAbgQ==
X-Received: by 2002:a05:600c:8483:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-455bd87a4a2mr110811915e9.4.1752506760617;
        Mon, 14 Jul 2025 08:26:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561d19a21dsm26792415e9.24.2025.07.14.08.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:26:00 -0700 (PDT)
Message-ID: <d0b345c8-29be-4ca4-8243-de16583c93e2@redhat.com>
Date: Mon, 14 Jul 2025 17:25:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <ky2jvl6uyi75qwfmpwzmwu6qfnlwxshk2zunywe3pve2pshdxj@p2ihhzov3imx>
 <cd3516af-8481-4418-9f72-a7738a9fd024@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <cd3516af-8481-4418-9f72-a7738a9fd024@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 17:23, Lorenzo Stoakes wrote:
> On Mon, Jul 14, 2025 at 04:17:23PM +0100, Pedro Falcato wrote:
>> On Mon, Jul 14, 2025 at 02:00:39PM +0100, Lorenzo Stoakes wrote:
>>> The check_mm_seal() function is doing something general - checking whether
>>> a range contains only VMAs (or rather that it does NOT contain any unmapped
>>> regions).
>>>
>>> Generalise this and put the logic in mm/vma.c - introducing
>>> range_contains_unmapped(). Additionally we can simplify the logic, we are
>>> simply checking whether the last vma->vm_end has either a VMA starting
>>> after it or ends before the end parameter.
>>>
>>
>> I don't like this. Unless you have any other user for this in mind,
>> we'll proliferate this awful behavior (and add this into core vma code).
> 
> I'm not sure how putting it in an internal-only mm file perpetuates
> anything.
> 
> I'm naming the function by what it does, and putting it where it belongs in
> the VMA logic, and additionally making the function less horrible.
> 
> Let's not please get stuck on the isues with mseal implementation which
> will catch-22 us into not being able to refactor.
> 
> We can do the refactoring first and it's fine to just yank this if it's not
> used.
> 
> I'm not having a function like this sat in mm/mseal.c when it has
> absolutely nothing to do with mseal specifically though.
> 
>>
>> I have some patches locally to fully remove this upfront check, and AFAIK
>> we're somewhat in agreement that we can simply nuke this check (for
>> various reasons, including that we *still* don't have a man page for the
>> syscall). I can send them for proper discussion after your series lands.
> 
> Yes I agree this check is odd, I don't really see why on earth we're
> concerned with whether there are gaps or not, you'd surely want to just
> seal whatever VMAs exist in the range?

Probably because GAPs cannot be sealed. So user space could assume that 
in fact, nothing in that area can change after a successful mseal, while 
it can ...

Not sure, though ...

-- 
Cheers,

David / dhildenb


