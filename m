Return-Path: <linux-kernel+bounces-744733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25406B1105E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5878D1CE7705
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AE2ECD00;
	Thu, 24 Jul 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wv1vfFm2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAA2EB5D1;
	Thu, 24 Jul 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378202; cv=none; b=Qkiw1HODwkZYx/Oo3Wg6TlcrBz2y5Y10/f7AvdeHi8npX00WHFiV23HwQk8/hvmtNZ6GAgjgcKJOmIvrBSHfij0LcbA3BC73GD27SN3+qSNmbuQVuC5uu3hZcMwmaUz2vm4NQ27gVdt1TRfno7NGlBQlc/Vrt4Oj2KeZWpI0qN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378202; c=relaxed/simple;
	bh=rQfYK/pFckju0/m5ZMT8YpMb/ONrLOdCFi/xBbvE/uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiXTMbLMpjpuEzqE4k5pm0f1DgzpNzV3Vd4WBQoisgczN90EiMztGGV4jOYB7YlXaKHzKjc4QLcxt8fYho6c8NH9DRRMr1UJGsTW5mxTLyXLWpUC/sp9vk4B19/mUMvH8r4ETemPggQL4T2+8PRngH/pvtnt36qaT6bYmtaDdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wv1vfFm2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Po5cQ5B/7KTWzepFKNX6CQz+apgwh63MuU5rCZ6VX0c=; b=Wv1vfFm2JPt52XUREKd070yyYY
	dhdxbyMhkHeGmeswXVjXfJ8nru4JdQUlggRKS6XIpXdDk6VJ39UpEZHkigZ2R6GZe4GFRJUAFnuJA
	2V8QaLXb3sPybGmrQORiid1/Qo3LZtjLLbqYJ5SGsDtWe8dcu9ivnUhSUTWzgRYUARJ2P98HUQU7g
	p1+l4NC9gDJ9iiujLfD/HE6duEGwUObgilSFLKp9tQlgVXJB8UOwIxUf7feiMdlf0iSGu/VvJf/iD
	AOwphfU29eHKmsqXFO0k7NnmnEuv0JOKB64RqW0kx4FVBZd3L3vyKvaE/NXOS0VVOfgQpUQYW5SL/
	IDwGvdEQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uezlW-000000088OB-2C3D;
	Thu, 24 Jul 2025 17:29:58 +0000
Message-ID: <dfb7415f-130f-4581-88b9-ee18c9ef8518@infradead.org>
Date: Thu, 24 Jul 2025 10:29:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: mention MIT license as a compatible license with
 GPLv2
To: Aditya Garg <gargaditya08@live.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <PN3PR01MB95977C87764A556FFD49FB72B85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025072459-tweezers-dingbat-b748@gregkh>
 <PN3PR01MB95978770C2DC8D5CDB28426FB85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <PN3PR01MB95978770C2DC8D5CDB28426FB85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 3:41 AM, Aditya Garg wrote:
> 
> 
> On 24/07/25 4:08 pm, Greg KH wrote:
>> On Thu, Jul 24, 2025 at 10:03:41AM +0000, Aditya Garg wrote:
>>> MIT is a widely used permissive free software license that is compatible
>>> with the GPLv2 license. This change adds it to the list of compatible
>>> licenses with GPLv2 in the kernel documentation.
>>
>> No, please don't.  This isn't a proper place for talking about the
>> different license interactions.
> 
> Ohk
> 
>>
>>>
>>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>>> ---
>>>  Documentation/process/1.Intro.rst | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/process/1.Intro.rst b/Documentation/process/1.Intro.rst
>>> index 25ca49f7a..c3465e3aa 100644
>>> --- a/Documentation/process/1.Intro.rst
>>> +++ b/Documentation/process/1.Intro.rst
>>> @@ -235,9 +235,9 @@ code must be compatible with version 2 of the GNU General Public License
>>>  (GPLv2), which is the license covering the kernel distribution as a whole.
>>>  In practice, that means that all code contributions are covered either by
>>>  GPLv2 (with, optionally, language allowing distribution under later
>>> -versions of the GPL) or the three-clause BSD license.  Any contributions
>>> -which are not covered by a compatible license will not be accepted into the
>>> -kernel.
>>> +versions of the GPL), the three-clause BSD license or the MIT license.
>>
>> You forgot a ',' anyway :(
> 
> While it is no longer relevant, I wonder where you wanted the comma. Maybe you meant "the three-clause BSD license, or the MIT license"?

In general we accept the use of the series/serial/Oxford comma (", or") or not using it,
but I suppose that $maintainers can determine otherwise.

from Documentation/doc-guide/contributing.rst:

 - The question of whether a period should be followed by one or two spaces
   is not to be debated in the context of kernel documentation.  Other
   areas of rational disagreement, such as the "Oxford comma", are also
   off-topic here.

-- 
~Randy


