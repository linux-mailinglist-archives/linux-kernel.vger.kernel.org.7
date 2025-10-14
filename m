Return-Path: <linux-kernel+bounces-853186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 754A7BDAE06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F7954EFDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177963074BD;
	Tue, 14 Oct 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8ZryYYQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3270273804;
	Tue, 14 Oct 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464797; cv=none; b=VMqQsAA6VyFK5uNmf89NUdDZ92h/t+mVQAiu1Ws8+GWFjwHMto2RuudtWnbHC8Dvmq3oWFEAl4fynqJZBC4bxvJYI5XJD+GH5V0weao5JOtuDeYcwjax4Ry3xwt8jGkn+Pxzb5hDTRc9Ne2q/WFOPkONMI3qqNesrnT7Asu99dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464797; c=relaxed/simple;
	bh=7ZxFIrTz+Z6hfPvArLPPMKcbzUQoz04LKWrVrZPmolU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA8adK8Gr8akyda/8HJtm+ynispLqUIMV/Pf+aIpqidT7sezILlmNTihSUa9BiAB9RuYUnW+VgGeta9PAJnKJ5qs5s50zgFun060JEskVf3BViI7hu8ou7LwuK6clMExE/R57ROS8m6EAWc9bJ00lMrXvHJkHxeLSLaB3iXI1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8ZryYYQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/rcB6BDIY3QkbB1OwWvapEATZoB6lJdXX3krwk4TwBU=; b=d8ZryYYQkEk9ihZBGp1/Xt08S8
	6Fx6DNY90cOOABImjEG9hvspf72JIE7qq+0p4KiAl5M+BryW4/92sl2G8VIzey5fu3yNT2Xfd3HSw
	a/zDgG53ejKZofKnUbzB2dTiv2f17Uu8/UGj+I5JSnYxMsZwkJz/ac+wssn0brImABe2E15AcWaP3
	ODjZaFABnrRhmBBYDK/9BDsgRNRB+giHx6cDSwNFgq3GysRMxsie4onMkSrOc4l5oP8UMavx+xgoz
	DChFAmvmS/ER8ZwyMZO521K6NY2hQEgpDfLqEK33WnGmoRfBhxKZhqA5lomc+RwOYgfgp4qDI7WHN
	aWjYclAQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8jJS-0000000H89G-3PQS;
	Tue, 14 Oct 2025 17:59:54 +0000
Message-ID: <431ee7b1-3296-4230-a9d8-47445e664e36@infradead.org>
Date: Tue, 14 Oct 2025 10:59:54 -0700
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87seflbken.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 7:57 AM, Jonathan Corbet wrote:
> Akiyoshi Kurita <weibu@redadmin.org> writes:
> 
>> The term "userspace" should be a single word. Fix the typo
>> "userpace" accordingly.
>>
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>> index a0cc017e4424..ed1f8f1e86c5 100644
>> --- a/Documentation/admin-guide/tainted-kernels.rst
>> +++ b/Documentation/admin-guide/tainted-kernels.rst
>> @@ -186,6 +186,6 @@ More detailed explanation for tainting
>>  
>>   18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
>>  
>> - 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>> + 19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>>       to use the devices debugging features. Device debugging features could
>>       cause the device to malfunction in undefined ways.
> 
> Applied, thanks.

Comparing to the "MSDOS" spelling patch:

did you check/count "userspace" vs. "user space" vs. "user-space"
in the kernel source tree?

-- 
~Randy


