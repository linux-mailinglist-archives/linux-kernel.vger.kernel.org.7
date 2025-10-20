Return-Path: <linux-kernel+bounces-861231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F8BF21E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBA03BA8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DA223DC0;
	Mon, 20 Oct 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h04n5cTz"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E191ADC7E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974378; cv=none; b=e8rqxodEeXodo3QEO/9g1z+3t3bmaKi/sCE34G2yNpseoeQaXkKqlaQH6W9gGfBAng9bqzVK47ntEYCPiVgSsIioHH1Rj+n6d7oEtNp0rr9C9BIh6b5KgsJA0n7/YU2HIHvAePC5Mec+lLxP2gXkxvMbN2PaRCCSsMmKe16kSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974378; c=relaxed/simple;
	bh=ZPVXW8UxHiUYWn/Ly8epU5bZkQYHaGpTP9XwhVJOzBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvuEWEUa64pNQM6GEl64Ij4t96XDdYtn5QR3kBBmc5QqNvJ475O2Xb5Kc4yppa5W+d2FxAxwlJYKtF9hJ21DHGUK0LrRFtLwGU1DtgTxbaXSAXn6AqK6VVr09ssQDOSemd9OEhQkS1cgG5mL074C4VTjvYM4zoWR6O2QoxV6eHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h04n5cTz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a207072-8623-40ef-bf3c-0edc1c6304ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760974373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBRDLpDd/ovgwGQlK3jYx7rs+f8otlMFk8pGLq4TlNo=;
	b=h04n5cTzSMkmrsYA4+eYbtS7m52Z4LUP0T1WtaJnEk7mDMUT/N2V+M6rp/W3CcqDnmAbDa
	lYX5FI5fSi7ZM2MvDN5Gex4O3StnKa94PXNXoqZIZFcBdZ7eYcAq94rFOyFaGr75HWU9Q/
	wNwB0mqfe0s5O8xIfLaYmsLt0mIFn8o=
Date: Mon, 20 Oct 2025 23:32:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: Factor out common logic in
 [scan,alloc]_sleep_millisecs_store()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251020115350.8175-1-leon.hwang@linux.dev>
 <7d9b4ac6-b0c2-4a0e-bee1-23f7a82eea72@lucifer.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <7d9b4ac6-b0c2-4a0e-bee1-23f7a82eea72@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/20 21:53, Lorenzo Stoakes wrote:
> On Mon, Oct 20, 2025 at 07:53:50PM +0800, Leon Hwang wrote:
>> Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
>> perform the same operations: parse the input value, update their
>> respective sleep interval, reset khugepaged_sleep_expire, and wake up
>> the khugepaged thread.
>>
>> Factor out this duplicated logic into a helper function
>> __sleep_millisecs_store(), and simplify both store functions.
>>
>> No functional change intended.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> Thanks this is a decent cleanup, with the nit(s0 below addressed LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 

Thanks for the review, Lorenzo.

>> ---
>>  mm/khugepaged.c | 29 ++++++++++++++---------------
>>  1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 0341c3d13e9e..0b7915015e9e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -129,9 +129,8 @@ static ssize_t scan_sleep_millisecs_show(struct kobject *kobj,
>>  	return sysfs_emit(buf, "%u\n", khugepaged_scan_sleep_millisecs);
>>  }
>>
>> -static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
>> -					  struct kobj_attribute *attr,
>> -					  const char *buf, size_t count)
>> +static ssize_t __sleep_millisecs_store(const char *buf, size_t count,
>> +				       unsigned int *millisecs)
>>  {
>>  	unsigned int msecs;
>>  	int err;
>> @@ -140,12 +139,21 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
>>  	if (err)
>>  		return -EINVAL;
>>
>> -	khugepaged_scan_sleep_millisecs = msecs;
>> +	*millisecs = msecs;
>>  	khugepaged_sleep_expire = 0;
>>  	wake_up_interruptible(&khugepaged_wait);
>>
>>  	return count;
>>  }
>> +
>> +static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
>> +					  struct kobj_attribute *attr,
>> +					  const char *buf, size_t count)
>> +{
>> +	unsigned int *millisecs = &khugepaged_scan_sleep_millisecs;
>> +
>> +	return __sleep_millisecs_store(buf, count, millisecs);
> 
> I think this'd be much clearer as:
> > return __sleep_millisecs_store(buf, count,
&khugepaged_alloc_scan_millisecs);
> 
>> +}
>>  static struct kobj_attribute scan_sleep_millisecs_attr =
>>  	__ATTR_RW(scan_sleep_millisecs);
>>
>> @@ -160,18 +168,9 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
>>  					   struct kobj_attribute *attr,
>>  					   const char *buf, size_t count)
>>  {
>> -	unsigned int msecs;
>> -	int err;
>> -
>> -	err = kstrtouint(buf, 10, &msecs);
>> -	if (err)
>> -		return -EINVAL;
>> +	unsigned int *millisecs = &khugepaged_alloc_sleep_millisecs;
>>
>> -	khugepaged_alloc_sleep_millisecs = msecs;
>> -	khugepaged_sleep_expire = 0;
>> -	wake_up_interruptible(&khugepaged_wait);
>> -
>> -	return count;
>> +	return __sleep_millisecs_store(buf, count, millisecs);
>>  }
> 
> I think this'd be much clearer as:
> 
> return __sleep_millisecs_store(buf, count, &khugepaged_alloc_sleep_millisecs);
> 

Indeed, your suggestion makes the code clearer.

I'll update both occurrences in the next revision.

Thanks,
Leon

>>  static struct kobj_attribute alloc_sleep_millisecs_attr =
>>  	__ATTR_RW(alloc_sleep_millisecs);
>> --
>> 2.51.0
>>


