Return-Path: <linux-kernel+bounces-805363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12715B487A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1985A1B20BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0812EC555;
	Mon,  8 Sep 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQfgqq8r"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2514AD2D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321811; cv=none; b=pa6F8TPMJRhQV0B0iS1o1lguFwaTSUAp90A0oC3bLdIawuq7vteFzOaK0Vl6vETfgejz/cW/+dZaF5jDrC0HP+qsYEa5o2zB45tbZJZGvUoIgodMipPRZrdL8FbMmPQa2+df8VtOXNQ1jL+94tDBXZps+NhMJOzz2RCXg9X9aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321811; c=relaxed/simple;
	bh=V/bVGP/KdOF19nDlQUVl6n1WOYhjtPS3aZaW8tI//lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7RVZWF6WMds+iw573ghVb4tTZKTXAkFQDEaRf7siFt2FAzX7x4+sKcrxvH5zaxt4EJD3hYa20VrHF7DKXnF92vkgW+3W1Gnjwap+L9E4VOe/RFdH7fvWDMQC3DNM56OTSVQSfexiv2vqt44YfRBjCrXqIR+OQSZIA/qHVH91OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wQfgqq8r; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c089b941-97c7-4392-828f-923e8da3510a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757321806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKQQNlo0TfpyWma+YA6JB+SzcXFLckK+IlyLWqw7/4Y=;
	b=wQfgqq8rLxodgybIZRFdD/kgN3ta6mz+xdpAzih/j5QppO3iZswBVbKWZyS+GBkxdntlZ8
	5SCZQokCfOfpOpNcCbYXeZ60Z5rCrCK8bFUyKpn8tjWXILFvOgib4DdfWeZ8xTgkBirO9U
	b84OcVFZz4t7xKxfvrzb/uDQEFJ3Izs=
Date: Mon, 8 Sep 2025 16:56:40 +0800
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
 <aL6WTrXczZJYUoGb@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aL6WTrXczZJYUoGb@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/9/8 16:39, Harry Yoo 写道:
> On Mon, Sep 08, 2025 at 03:19:21PM +0800, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Use IS_ENABLED() and standard if-else to make the code clearer.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> with a nit,
> 
>>  mm/slub.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 30003763d224..34853c0441a6 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3064,18 +3064,16 @@ static inline void note_cmpxchg_failure(const char *n,
>>  
>>  	pr_info("%s %s: cmpxchg redo ", n, s->name);
>>  
>> -#ifdef CONFIG_PREEMPTION
>> -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
>> +	if (IS_ENABLED(CONFIG_PREEMPTION) && tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
> 
> nit: insert newline after && as it's more than 80 columns?

I noticed this too, but using the script ./scripts/checkpatch.pl , there were no warnings.

$ ./scripts/checkpatch.pl 0001-mm-slub-Refactor-note_cmpxchg_failure-for-better-rea.patch 
total: 0 errors, 0 warnings, 22 lines checked

0001-mm-slub-Refactor-note_cmpxchg_failure-for-better-rea.patch has no obvious style problems and is ready for submission.


> 
>>  		pr_warn("due to cpu change %d -> %d\n",
>>  			tid_to_cpu(tid), tid_to_cpu(actual_tid));
>> -	else
>> -#endif
>> -	if (tid_to_event(tid) != tid_to_event(actual_tid))
>> +	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
>>  		pr_warn("due to cpu running other code. Event %ld->%ld\n",
>>  			tid_to_event(tid), tid_to_event(actual_tid));
>> -	else
>> +	} else {
>>  		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
>>  			actual_tid, tid, next_tid(tid));
>> +	}
>>  #endif
>>  	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
>>  }
>> -- 
>> 2.43.0

-- 
Thanks,
Ye Liu


