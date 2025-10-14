Return-Path: <linux-kernel+bounces-853213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE808BDAEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BF618A0CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D1277CAE;
	Tue, 14 Oct 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QdPUfnCY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6A213E9C;
	Tue, 14 Oct 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466129; cv=none; b=IF2o/zR8gWftT81boeiMCkS1RvIEF7ZAvaqUnIXNwME9+LjG9a2tI+G17gb6HbpZKGUwUKPLOuaaSDYrsVt3OLCqfgLIe/IUXJAW7BlE3hWwRZyk1zDNKKoKxPkcqABK0BTXs62lHuP+T2ESyxhi4FMOJhUwMgKsVp2ulDdOZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466129; c=relaxed/simple;
	bh=cCUURDd07Yw9p/jOHDANOrc/VydF7BvuWq/CmhJ9tA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFWyERtTY52qtwe3rJbu2G/ELMib/M31TfYUaErBHys/XVvk4NxMa9H1t3fnvtCPyIuPAkyHV9QXbsHhd4GgWJBNkcC5SqS1pRWxv4AyDXKxbqqcmaCDdIyzeG2uUNp5tL4pJo9usn0dCvwvG0qXsTSM4oO4PFFJwburi+qzGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QdPUfnCY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 781B740B18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760466126; bh=CBzFDqgIBt7OUHVz+Kf+Lf4hpJX8ECAmro/oMxEjUzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QdPUfnCYGG2KdH28Gwm2VX02LtL/rO3sRF5MS5NHcRHAtwwf0yDudfztzQQ7qkK4m
	 X4HpxoaTcx/VDlxbFG5migLzyR4TNs6n+s/QPybHP+j5sWryQOzWBfUqeTQPFObhXw
	 l3rU7w8TUvKI3GPZSAO1tBCOzvlxwOxBgu42NrY6258wp8uIjTWoF+LkRMEifrLS1D
	 3OHOXWPwuTzMrkHGobdtX5TytpFt9/udZ2YfQ86sgX+J12fL9W5qQARtHMwK/k2iaY
	 OKG0HAvpWRaSFavGs2rrosTRjqHmLETM3Odfbvv7gFc6u8TEdWPxahYa+D9sdy1SAD
	 HVZFX+oUt5X7Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 781B740B18;
	Tue, 14 Oct 2025 18:22:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Akiyoshi Kurita
 <weibu@redadmin.org>, linux-doc@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shannon Nelson <sln@onemain.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin-guide: Correct spelling of
 "userspace"
In-Reply-To: <431ee7b1-3296-4230-a9d8-47445e664e36@infradead.org>
References: <20250926190019.41788-1-weibu@redadmin.org>
 <87seflbken.fsf@trenco.lwn.net>
 <431ee7b1-3296-4230-a9d8-47445e664e36@infradead.org>
Date: Tue, 14 Oct 2025 12:22:05 -0600
Message-ID: <87v7kh9wdu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 10/14/25 7:57 AM, Jonathan Corbet wrote:
>> Akiyoshi Kurita <weibu@redadmin.org> writes:
>> 
>>> The term "userspace" should be a single word. Fix the typo
>>> "userpace" accordingly.
>>>
>>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>>> ---
>>>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>>> index a0cc017e4424..ed1f8f1e86c5 100644
>>> --- a/Documentation/admin-guide/tainted-kernels.rst
>>> +++ b/Documentation/admin-guide/tainted-kernels.rst
>>> @@ -186,6 +186,6 @@ More detailed explanation for tainting
>>>  
>>>   18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
>>>  
>>> - 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>>> + 19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>>>       to use the devices debugging features. Device debugging features could
>>>       cause the device to malfunction in undefined ways.
>> 
>> Applied, thanks.
>
> Comparing to the "MSDOS" spelling patch:
>
> did you check/count "userspace" vs. "user space" vs. "user-space"
> in the kernel source tree?

No, but this patch was fixing "userpace", which is overtly wrong.  It
turns out that there's a surprising number of those, too, but still far
fewer.

jon

