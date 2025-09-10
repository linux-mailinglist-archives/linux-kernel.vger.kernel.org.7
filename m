Return-Path: <linux-kernel+bounces-809167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498DB5097C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76CF5E5D31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D493F9C5;
	Wed, 10 Sep 2025 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uursvU5t"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131C1CAA4;
	Wed, 10 Sep 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462523; cv=none; b=BX0tdwa3iSsQywNSn4r2YV7MgWCUzinNety8QrlGfDVQVcmSZC44LHA4GR/9KZRZ1zz4ViFV3mkgad3AhUu6Va97vyCxvYdi7Ynv/DFFcyxBwqrVCOHDp5N6bNhbbA0LC+s5p50xHXIVon1mpLPkzir2mqD/FW+LXKb/HTQx1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462523; c=relaxed/simple;
	bh=6K1ZxFvnj7ilVZ2Lvcxnu+ROFL4h434RG+LR7aqM3VA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cBuskd33XYVghkFl8m9se3Hs59MgN8RO7M+uBVSADTbgMZ9XWCD4m+tZHG23SGS0M3/yGkpQ4v3/CqdFikPnrRUbDomR5dT2IoK4Pyi6hxYTvQb9K0UMq/kH4Fdvx7pAC0Crn7jrEfEyc2FJCG7dyFRbSCNlGfd3Ux4y2Y+bOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uursvU5t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FZWrlVjuxyIdwbbbBVX1Q3DragMFJR1SfLC7gOGLRmA=; b=uursvU5tLhdcbp3fat4Hdg2qIY
	E4RQ8Rw+1wuIqIZ0GShlucgW/wSWlki+MEs0J0RtXw5T+UZAHb8X9dqNdTUKcEO3xeTpuRGFnIlRW
	lScwdj4P4uH2zQ7+/ZX8aE3GQ2IS49bGtxeR2ZKonwLwjfx9R9SHz4GodkFzR5GCMunY3C3R6JS7Z
	2XWLNmYJhkn/JjGz8W79RXvVD80VPlgtxgVpoH61KMGhhaUkN22h3g9SvIXowl3eVyGuA0tTVHzr5
	zn7ojbnGPeWbZSaY1iSfdNbywiXz3Pd3AEkpsz7E3QurOdr7P024lOHiNA0dDqlXxVbn7O9mOH6EN
	f70Z//ZQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw8Hg-0000000B2sZ-1vGJ;
	Wed, 10 Sep 2025 00:02:00 +0000
Message-ID: <c195c68f-e815-4428-9134-8746198a4611@infradead.org>
Date: Tue, 9 Sep 2025 17:02:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
From: Randy Dunlap <rdunlap@infradead.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
 <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
 <20250909215824.1968220c@foz.lan>
 <5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
 <20250910010903.5388bffc@foz.lan>
 <0d190bf0-b9d4-4d5c-a1cc-6d5d79be3886@infradead.org>
 <656591ff-fa7d-4763-8759-0a0af3a4039a@infradead.org>
Content-Language: en-US
In-Reply-To: <656591ff-fa7d-4763-8759-0a0af3a4039a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 4:50 PM, Randy Dunlap wrote:
> 
> 
> On 9/9/25 4:49 PM, Randy Dunlap wrote:
>>
>>
>> On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:
>>> Em Tue, 9 Sep 2025 14:06:43 -0700
>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>>
>>>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:
>>>>> Em Tue, 9 Sep 2025 00:27:20 -0700
>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>>
>>>>>> +.. kernel-doc:: init/kdoc-globals-test.c
>>>>>> +   :identifiers:
>>>>>>
>>>>>> The html output says
>>>>>> "Kernel Globals"
>>>>>> but nothing else.  
>>>>>
>>>>> I usually don't add :identifiers: on kernel-doc entries. If you use
>>>>> identifiers, you need to explicitly tell what symbols you want.  
>>>>
>>>> Well, it worked/works without using having any identifiers listed, and
>>>> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
>>>> optional:
>>>>
>>>> identifiers: *[ function/type ...]*
>>>>   Include documentation for each *function* and *type* in *source*.
>>>>   If no *function* is specified, the documentation for all functions
>>>>   and types in the *source* will be included.
>>>>   *type* can be a struct, union, enum, or typedef identifier.
>>>
>>> Hmm.. looking the entire logic:
>>>
>>>         elif 'identifiers' in self.options:
>>>             identifiers = self.options.get('identifiers').split()
>>>             if identifiers:
>>>                 for i in identifiers:
>>>                     i = i.rstrip("\\").strip()
>>>                     if not i:
>>>                         continue
>>>
>>>                     cmd += ['-function', i]
>>>                     self.msg_args["symbol"].append(i)
>>>             else:
>>>                 cmd += ['-no-doc-sections']
>>>                 self.msg_args["no_doc_sections"] = True
>>>
>>> I suspect that an empty identifier could be raising an exception.

and it's being caught and ignored (not printed)?

>>> The right logic should be, instead:
>>>
>>> -        elif 'identifiers' in self.options:
>>> -            identifiers = self.options.get('identifiers').split()
>>> -            if identifiers:
>>> -                for i in identifiers:
>>> +        elif 'identifiers' in self.options:
>>> +            identifiers = self.options.get('identifiers')
>>> +            if identifiers:
>>> +                for i in identifiers.split():
>>>
>>> (tests needed)
>>
>> Sheesh, I can't find that code so that I can patch it.
>> (in today's linux-next 20250909)
> 
> oops, I was looking in scripts/ and not in Documentation/.
> got it.
> 
>> Anyway, does this take away something that currently works?

The output looks the same with this patch AFAICT.
-- 
~Randy


