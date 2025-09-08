Return-Path: <linux-kernel+bounces-805444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3EB48896
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188631699FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117821D3F3;
	Mon,  8 Sep 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iv0p7UWz"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27F1C84AE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324049; cv=none; b=CW9RjNUW2lK0fcffeXw3UG0CZiuHtRQfM5wCtaNPj20PeafOjTUEJmz9A5QTBqGyeiIaopcbXTi0Poe5/qAHwolPHYB506KoPtS9L4+ic8NXzdt7DrRA7D4kNibS1P7kSaOea3jxWMTS4mZodUNJ7WyOgxMyyP8dCh2U7aeiZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324049; c=relaxed/simple;
	bh=UjmEAY8XI0mSvG1ZpOHbmycwYBFjY2ituNyXgKa7eOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YubbJ34CYneSCGmDlhiYdqj6s8DsVVEsMdxBvS6A3btGZthIb85E6gaNwPfL7gSKge/OVPvDwOgDMk0Hl9mQH0cPSDMw6Eiuj84U9vljxMyKqA/bLPYuYcUr4keBlC42sGqJ/QYen+ReLuUK2SX91D2mvxEtkKyJZMJYYUyOT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iv0p7UWz; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7728a4a-7af9-4d7b-a06d-d61b697eaeef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757324042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEEBVaVKlKHbQ45HKM4XzjEJWmhD75GPFAdeX7JNCvc=;
	b=iv0p7UWzXnmJ44EqNPGvW4uieAmGmQyWh3pgPbGcGOi4uNxXJx28fOc9ld0xj/fRPbOds9
	UG+KamYHwAXIR4QOMYHMq7tcM0v3TC2JXl8bzW7cVVaNIGArVRF3GoAjPI0cbn4jWos9uf
	isupz2ncnCaqkJ6zGD+l350V0PCkdoE=
Date: Mon, 8 Sep 2025 17:33:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: Refactor note_cmpxchg_failure for better
 readability
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250908071922.1062170-1-ye.liu@linux.dev>
 <aL6WTrXczZJYUoGb@hyeyoo> <c089b941-97c7-4392-828f-923e8da3510a@linux.dev>
 <aL6gMEvR8RqW7YrE@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aL6gMEvR8RqW7YrE@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/9/8 17:21, Harry Yoo 写道:
> On Mon, Sep 08, 2025 at 04:56:40PM +0800, Ye Liu wrote:
>>
>>
>> 在 2025/9/8 16:39, Harry Yoo 写道:
>>> On Mon, Sep 08, 2025 at 03:19:21PM +0800, Ye Liu wrote:
>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>
>>>> Use IS_ENABLED() and standard if-else to make the code clearer.
>>>>
>>>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>>>> ---
>>>
>>> Looks good to me,
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>
>>> with a nit,
>>>
>>>>  mm/slub.c | 10 ++++------
>>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 30003763d224..34853c0441a6 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -3064,18 +3064,16 @@ static inline void note_cmpxchg_failure(const char *n,
>>>>  
>>>>  	pr_info("%s %s: cmpxchg redo ", n, s->name);
>>>>  
>>>> -#ifdef CONFIG_PREEMPTION
>>>> -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
>>>> +	if (IS_ENABLED(CONFIG_PREEMPTION) && tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
>>>
>>> nit: insert newline after && as it's more than 80 columns?
>>
>> I noticed this too, but using the script ./scripts/checkpatch.pl , there were no warnings.
>>
>> $ ./scripts/checkpatch.pl 0001-mm-slub-Refactor-note_cmpxchg_failure-for-better-rea.patch 
>> total: 0 errors, 0 warnings, 22 lines checked
>>
>> 0001-mm-slub-Refactor-note_cmpxchg_failure-for-better-rea.patch has no obvious style problems and is ready for submission.
> 
> IIUC the default limit is increased to 100 characters in checkpatch
> but 80 characters is still preferred.
Thank you for your patience.
I will update the V2 version and include your Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Quoting Documentation/process/coding-style.rst:
> 
> 2) Breaking long lines and strings
> ----------------------------------
> 
> Coding style is all about readability and maintainability using commonlu
> available tools.
> 
> The preferred limit on the length of a single line is 80 columns.
> 
> Statements longer than 80 columns should be broken into sensible chunks,
> unless exceeding 80 columns significantly increases readability and does
> not hide information.
> 
> Descendants are always substantially shorter than the parent and                
> are placed substantially to the right.  A very commonly used style              
> is to align descendants to a function open parenthesis.                         
> 
> These same rules are applied to function headers with a long argument list.
> 
> However, never break user-visible strings such as printk messages because
> that breaks the ability to grep for them. 
> 
> And also quoting a commit message:
> 
> commit bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> Author: Joe Perches <joe@perches.com>
> Date:   Fri May 29 16:12:21 2020 -0700
> 
>     checkpatch/coding-style: deprecate 80-column warning
> 
>     Yes, staying withing 80 columns is certainly still _preferred_.  But
>     it's not the hard limit that the checkpatch warnings imply, and other
>     concerns can most certainly dominate.
> 
>     Increase the default limit to 100 characters.  Not because 100
>     characters is some hard limit either, but that's certainly a "what are
>     you doing" kind of value and less likely to be about the occasional
>     slightly longer lines.
> 
>     Miscellanea:
> 
>      - to avoid unnecessary whitespace changes in files, checkpatch will no
>        longer emit a warning about line length when scanning files unless
>        --strict is also used
> 
>      - Add a bit to coding-style about alignment to open parenthesis
> 
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
>>>>  		pr_warn("due to cpu change %d -> %d\n",
>>>>  			tid_to_cpu(tid), tid_to_cpu(actual_tid));
>>>> -	else
>>>> -#endif
>>>> -	if (tid_to_event(tid) != tid_to_event(actual_tid))
>>>> +	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
>>>>  		pr_warn("due to cpu running other code. Event %ld->%ld\n",
>>>>  			tid_to_event(tid), tid_to_event(actual_tid));
>>>> -	else
>>>> +	} else {
>>>>  		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
>>>>  			actual_tid, tid, next_tid(tid));
>>>> +	}
>>>>  #endif
>>>>  	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
>>>>  }
>>>> -- 
>>>> 2.43.0
>>
>> -- 
>> Thanks,
>> Ye Liu
>>
>>
> 

-- 
Thanks,
Ye Liu


