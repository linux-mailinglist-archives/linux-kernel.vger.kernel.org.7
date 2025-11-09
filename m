Return-Path: <linux-kernel+bounces-892141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAEFC446D8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E255A4E3589
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CF2673AA;
	Sun,  9 Nov 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b7nyoVY1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94620223DFF;
	Sun,  9 Nov 2025 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720501; cv=none; b=nkRer9bQ4bbXhB7TbWHwvcrUZU0N/t2c+ZD3HwXVqMqkOvfVXjL3oZ1OSohv8lkJ4SNRBsyubq2B+C3fuRLC4r0M4L5YM1JWinHFX70ea9jBodx9qQA2se4gn+kIwkltY2gKSnOBP11wmGktAQ0EYQcdMHLRx1svYUik4sH8rFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720501; c=relaxed/simple;
	bh=YhbkijbCIuFlE6JMviZoSxb6GHLt2GDOMb+2CwPXqq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nelLQ4odA1f2OnPqfJy/W/Z+t4JTG0p0sbWDTsTtF0YKdI6t7cwltnbEYIT/JpI+yPfZH4cM2ZzkIg6CimJu6MpP3tjs29jakUbiOUV4DxPwlUhq0pYoQpOvE7FqYVwPou/K1FNXL4wFOEjcFUbXdGzCnQvlLLd4tl4JEu8Km40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b7nyoVY1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ShTQjuBHiYNK8qnH7Zt1aDx2xEWODN4ScD7inlcGEAs=; b=b7nyoVY1ANNKduI/bmDYUgIG61
	RtWfFSO3Pr2YWQ1Jv6l2sIOT0FpqdtvkcZggLlmZGOUC/OSiyp0h7vMCgLxbnxM3sTXN3/gn2Au6j
	nH/Lg8RU/iHrfSLWsj41GbrLhf2dYTWiPZ60yQlVQ2u7kUVYRtoCakD9uqw5ZYqAaCXCjTD6eoAuV
	OFxgIdyWgXn7JMW7oTk/4pWt9u7nBhbQdhEyQmCODRx6TtcVvJ80niMuIBalQMpjMIrEYFWMlXJUW
	P8KZSvHN661ZVcw2p1w2HplkYXvn14Z48aSIQWrOyb6Ag6q5s0NpFNcTrWtiJ7FhDYN3TSPfO+kea
	FXkC0JDg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIC7i-00000004MxA-3VSQ;
	Sun, 09 Nov 2025 20:34:54 +0000
Message-ID: <a61cafaf-7e09-496b-b940-bc287dfb8b08@infradead.org>
Date: Sun, 9 Nov 2025 12:34:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <87sees73i5.fsf@trenco.lwn.net>
 <90db7fc0-5ce5-4ed4-ac33-18910c37d3d7@infradead.org>
 <aRC5NjhOmuGIpdPA@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aRC5NjhOmuGIpdPA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/25 7:54 AM, Andy Shevchenko wrote:
> On Sat, Nov 08, 2025 at 04:03:15PM -0800, Randy Dunlap wrote:
>> On 11/5/25 10:12 AM, Jonathan Corbet wrote:
>>> [Heads up to Stephen: this change will add a bunch of warnings that had
>>> been dropped before.]
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>
>>>> When kernel-doc parses the sections for the documentation some errors
>>>> may occur. In many cases the warning is simply stored to the current
>>>> "entry" object. However, in the most of such cases this object gets
>>>> discarded and there is no way for the output engine to even know about
>>>> that. To avoid that, check if the "entry" is going to be discarded and
>>>> if there warnings have been collected, issue them to the current logger
>>>> as is and then flush the "entry". This fixes the problem that original
>>>> Perl implementation doesn't have.
>>>
>>> I would really like to redo how some of that logging is done, but that
>>> is an exercise for another day.  For now, I have applied this one,
>>> thanks.
>>
>> I think that this patch is causing a (large) problem.
>>
>> With this patch:
>> $ make mandocs &>mandocs.out
>>
>> Without this patch:
>> $ make mandocs &>mandocsnoas.out
>>
>> $ wc mandocs.out mandocsnoas.out
>>   29544  267393 3229456 mandocs.out
>>   10052   95948 1208101 mandocsnoas.out
>>
>> so it appears that this patch causes lots of extra output.
>> Some of that may be what the patch was trying to do, but
>> with this patch, "mandocs.out" above has lots of duplicated
>> Warning: lines.
>>
>> $ sort mandocs.out | uniq > mandocsuq.out
>> $ wc mandocsuq.out
>>   18012  167689 1994145 mandocsuq.out
>>
>> $ grep -c "^Warning:"  mandocs.out mandocsnoas.out  mandocsuq.out 
>> mandocs.out:25273
>> mandocsnoas.out:10022
>> mandocsuq.out:15252
> 
> Yes, that's what Mauro explained, that we may have the dups.

OK, I remember something about that...

>> In mandocs.out above (29544 lines), this line:
>> Warning: ../sound/soc/sprd/sprd-mcdt.h:48 struct member 'dma_chan' not described in 'sprd_mcdt_chan'
>>
>> is found at lines 7 and 29122.
>>
>> So maybe the logging output needs to be repaired sooner
>> than later.
> 
> Right! But I'm not familiar with this, so I can help only with testing,
> and not with real fix development.

Same for me.

Thanks.
-- 
~Randy


