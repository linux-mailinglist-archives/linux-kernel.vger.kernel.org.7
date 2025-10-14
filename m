Return-Path: <linux-kernel+bounces-853225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFDBDAF66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F553352CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7372BD5B9;
	Tue, 14 Oct 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrIdm/nd"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669D2BD033;
	Tue, 14 Oct 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467171; cv=none; b=d/4IJBLMaR+WAmG+03AJsKSnk6rkuu6W1EX706AQjxem4VVinT0BWy5SDYld2CJVMiBEbhEcWZ6MC2PInQn59//cDVMaswaiKIPfolzdP1dLBQX6ancC397oBah9X0XlZCoMO4SAiHlSgQ7gdOp4s6YUNHw9IET0yj235m5OGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467171; c=relaxed/simple;
	bh=Xh2eBKYYOAudGr9RMkzmILNtpywqr0tJTsvy9GaBpt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1UYd3CDTzXjZqb7MXq3Ze8ydPfFyD0aUqlgN1KXsR9QslnKVZWb/EVQmO0mdeY6jILckNfPt8sHRtWrDzj25uYOXunk/KgbZAS2jYMUBolMDymhtV3rZRTwAMaSGjmlo7wsAdVnUfNftkY28m950pH95fsolfoZdizItHP24nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qrIdm/nd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=B/m/yNeA/Z2UE3cQi8e6b5O7/HPsSJCGOd9Cvkn1tDo=; b=qrIdm/ndYl+dfsGuG/f0c5ECjM
	9+o0yosj/2lGow+ujb4omCSXDvQeTdzgx4ogHUBvCPZK+cCT7EcpGiKEOcPqq+3/RJ7BSY0uc8AmH
	9oPHwjKaDW05cGxCYVO6TgXn2Qp9pZ3T0QxMsr7gEwbzWC7c3W+9QGl7LLXqtGqP4DJko1OoRpqfY
	wRvMDxvm9MPl71IopkE0FzqSyyWn+i8CCHnGVmO3mrKHS+5lr14bDyIhSsL1qjycaXiWVQx5WnKL4
	hf0d0hWzI4kFBs+NfSWhFr1oKLI9vqIQs8P6IkPGQRNkNL3v3ERGE2MFq7JVvVoniC8EuufhMiQEn
	N1d5Ye0g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8jvi-0000000HCEC-1CVf;
	Tue, 14 Oct 2025 18:39:26 +0000
Message-ID: <b55bf24c-4b45-4a6b-ae5b-7ded5bfcb25f@infradead.org>
Date: Tue, 14 Oct 2025 11:39:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: admin-guide: Correct spelling of
 "userspace"
To: Jonathan Corbet <corbet@lwn.net>, Akiyoshi Kurita <weibu@redadmin.org>,
 linux-doc@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shannon Nelson <sln@onemain.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org
References: <20250926190019.41788-1-weibu@redadmin.org>
 <87seflbken.fsf@trenco.lwn.net>
 <431ee7b1-3296-4230-a9d8-47445e664e36@infradead.org>
 <87v7kh9wdu.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87v7kh9wdu.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 11:22 AM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 10/14/25 7:57 AM, Jonathan Corbet wrote:
>>> Akiyoshi Kurita <weibu@redadmin.org> writes:
>>>
>>>> The term "userspace" should be a single word. Fix the typo
>>>> "userpace" accordingly.
>>>>
>>>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>>>> ---
>>>>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>>>> index a0cc017e4424..ed1f8f1e86c5 100644
>>>> --- a/Documentation/admin-guide/tainted-kernels.rst
>>>> +++ b/Documentation/admin-guide/tainted-kernels.rst
>>>> @@ -186,6 +186,6 @@ More detailed explanation for tainting
>>>>  
>>>>   18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
>>>>  
>>>> - 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>>>> + 19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>>>>       to use the devices debugging features. Device debugging features could
>>>>       cause the device to malfunction in undefined ways.
>>>
>>> Applied, thanks.
>>
>> Comparing to the "MSDOS" spelling patch:
>>
>> did you check/count "userspace" vs. "user space" vs. "user-space"
>> in the kernel source tree?
> 
> No, but this patch was fixing "userpace", which is overtly wrong.  It
> turns out that there's a surprising number of those, too, but still far
> fewer.

oops, my bad.

-- 
~Randy


