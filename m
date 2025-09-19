Return-Path: <linux-kernel+bounces-823982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E712B87DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B07B2C09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16926AA91;
	Fri, 19 Sep 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YWJX1e45"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85723741
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758255674; cv=none; b=pPl04YXLpyDSxOveZfgMzd+QKBPqlVnFbhhsI5Oe/tMMSZHODGXw6GMH/VsRMtXVXDWpIzLJwx+Ysu3S8e7mMsn0B8IBerPbU2+RwLgrjeviY/jSMYRXz/fB///dwsC6NQPq3x13woICLI7s1C35fIk+XYKg1mWnyJ1O2dyopJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758255674; c=relaxed/simple;
	bh=VwEKxfxIhVMNyB5nDVAQn1hDFOeZF0akVouNyCBqHxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Py2hNgY89x072unyxI2Qc5WCPbBIaqlhQMbfb7Bv8kZRSC/iTISEzPhpO4IsKUkHe1uYmftassomAmnsfpreQcxgV/Sx+jUl+T1MuRyAVKTfXtTPYVqKsz3Kvh73x0EFVWZQtQS/aFgKzqKJLDs2b6M6Jt7QlUGLZr3PlxUZeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YWJX1e45; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FB08AkPogpZ1CN2MlqSj5xJDBZIBAXihl92UEHxatuk=; b=YWJX1e45aZk9c0QoynCO28tYH5
	76Yz7I0s8OL3PfQN8LzEOWKTWI/PTt/zNzfzd2LNvXT7j815SVBCEsp/Tcf2a1K8Ymg6wECq/x+Cg
	Af7HcuRGfNw1V1RtM3JNfOglPDuadUxMCPr73NadCEnEhTYZ4oOmMXJ3yIk7FhOPqnoMEJ3RSuurC
	CiLnNN09YwN8jRoMeRtfupRw9DVzI2mWX15sP5x1WQWtHdPkXj38A+KNTxFly8tSq0ZoROBdMrrzT
	kLg/zDRcRKAomJlF7egMKhMILytUZ8dxI4UKj1wTeJSOWssa7MDNrm0daF3U3HS37wwCGlz8bRut3
	mUyZh/cA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzScK-00000001nWD-1vvj;
	Fri, 19 Sep 2025 04:21:04 +0000
Message-ID: <4e76b94d-9c32-4ec1-b2ec-fc989f1a23ad@infradead.org>
Date: Thu, 18 Sep 2025 21:20:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fixup: alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, kent.overstreet@linux.dev,
 vbabka@suse.cz, hannes@cmpxchg.org, rientjes@google.com,
 roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev,
 00107082@163.com, pyyjason@gmail.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250916160110.266190-1-surenb@google.com>
 <4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
 <20250916175639.2368772636d5e543faa5b13b@linux-foundation.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250916175639.2368772636d5e543faa5b13b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Andrew,

On 9/16/25 5:56 PM, Andrew Morton wrote:
> On Tue, 16 Sep 2025 21:50:51 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>>
>>
>> On 16/09/2025 17:01, Suren Baghdasaryan wrote:
>>> Document new "accurate:no" marker.
>>>
>>> Fixes: 39d117e04d15 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
>>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>> Based on mm-new
>>>
>>>  Documentation/filesystems/proc.rst | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>>> index 1776a06571c2..17668f82ff1c 100644
>>> --- a/Documentation/filesystems/proc.rst
>>> +++ b/Documentation/filesystems/proc.rst
>>> @@ -1014,6 +1014,14 @@ If file version is 2.0 or higher then each line may contain additional
>>>  For example if the counters are not accurate, the line will be appended with
>>>  "accurate:no" pair.
>>>  
>>> +Supported markers in v2:
>>> +accurate:no
>>> +              Absolute values of the counters in this line are not
>>
>> s/values/value/ maybe? :)
> 
> That's OK as-is.
> 
>> +              accurate because of the failure to allocate storage required
>>
>> s/storage required/memory/
> 
> Sure.
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: alloc_tag-mark-inaccurate-allocation-counters-in-proc-allocinfo-output-fix-fix
> Date: Tue Sep 16 05:53:33 PM PDT 2025
> 
> simplification per Usama, reflow text
> 
> Cc: David Rientjes <rientjes@google.com>
> Cc: David Wang <00107082@163.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Sourav Panda <souravpanda@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  Documentation/filesystems/proc.rst |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/Documentation/filesystems/proc.rst~alloc_tag-mark-inaccurate-allocation-counters-in-proc-allocinfo-output-fix-fix
> +++ a/Documentation/filesystems/proc.rst
> @@ -1016,11 +1016,11 @@ For example if the counters are not accu
>  
>  Supported markers in v2:
>  accurate:no

Please insert a blank line here to prevent a docs warning:

linux-next-20250918/Documentation/filesystems/proc.rst:998: ERROR: Unexpected indentation. [docutils]

Thanks.

> -              Absolute values of the counters in this line are not
> -              accurate because of the failure to allocate storage required
> -              to track some of the allocations made at this location.
> -              Deltas in these counters are accurate, therefore counters
> -              can be used to track allocation size and count changes.
> +              Absolute values of the counters in this line are not accurate
> +              because of the failure to allocate memory to track some of the
> +              allocations made at this location.  Deltas in these counters are
> +              accurate, therefore counters can be used to track allocation size
> +              and count changes.
>  
>  Example output.
>  
> _

-- 
~Randy


