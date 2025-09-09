Return-Path: <linux-kernel+bounces-809158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA6B50960
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4976C3B21DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2E28C86C;
	Tue,  9 Sep 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmeT1YAp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B452571A5;
	Tue,  9 Sep 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461834; cv=none; b=NO4dICyA7JbrxChkQpEU+sVelVe3RjCjDYSFNG7EPyLn48x6Y1npM6WzVsm59DA/wCcAQYf9oXlJWkXHyHL47a/Lsq5i+dtwdI//IA1JHY+j5h1mE4bmEzrtR0x4uNjoyWIW007+WnlEM3pT+Rus4/zVkvHouc+SJEs9Id+GaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461834; c=relaxed/simple;
	bh=bUTJ5x2xDYIixZye6ueFGmxrvO+C0ztkIj5lx2EwDz0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eelGQGw/WNnz8EhUpe31mNqXOhGF9FEGnyYsli2H3jlkC/cDoPingI9W5bX8am2mxvWx5V0fLyIEYwlSHIDvZIP/3ltTpYCwc4gOjBFzVFVx6W1v6Mi6wV/JmEYWONCU5x/t//bQ1xxot4v6WmW+VBBP4NNo5X1c+bfu4836N54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lmeT1YAp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=nrF+fb69zxkGTm0JhxO02WKVVhTproWLQlemtGncFZg=; b=lmeT1YAp2Y3Rnfp9ufijl+FVAC
	tcMzazNXlal0fR398TJvqQ3V+yl9sS/n+qHxWIoKqidl0nfo5LlOO+HWY2uh/oyMPjtC1BD3wg1mx
	ErJTp1BXjgaRZPxoYW7b+VXdrCRAnn0od9sgMBe+niEJRy2Q6kPpzLGhf6Lor+xUQSeYtZI7/ZrUc
	omR6v217Bn/LauhRp7Gvf4R4BRbxtA0ayPbPfYFRsh1tCaA9o5tthAvy0Avu5u6QFJh4Pmz2flrP0
	RnF1JzWQE/tHfFmTg2AY9RVvKt7U8mf9Q9Vrtnp+nGmf2Cnvo7BOAMoViZFAWmseodY4IN6UPXmxn
	P3Af4m8w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw86a-0000000AzoE-2kRE;
	Tue, 09 Sep 2025 23:50:32 +0000
Message-ID: <656591ff-fa7d-4763-8759-0a0af3a4039a@infradead.org>
Date: Tue, 9 Sep 2025 16:50:32 -0700
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
Content-Language: en-US
In-Reply-To: <0d190bf0-b9d4-4d5c-a1cc-6d5d79be3886@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 4:49 PM, Randy Dunlap wrote:
> 
> 
> On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:
>> Em Tue, 9 Sep 2025 14:06:43 -0700
>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>
>>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:
>>>> Em Tue, 9 Sep 2025 00:27:20 -0700
>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>
>>>>> +.. kernel-doc:: init/kdoc-globals-test.c
>>>>> +   :identifiers:
>>>>>
>>>>> The html output says
>>>>> "Kernel Globals"
>>>>> but nothing else.  
>>>>
>>>> I usually don't add :identifiers: on kernel-doc entries. If you use
>>>> identifiers, you need to explicitly tell what symbols you want.  
>>>
>>> Well, it worked/works without using having any identifiers listed, and
>>> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
>>> optional:
>>>
>>> identifiers: *[ function/type ...]*
>>>   Include documentation for each *function* and *type* in *source*.
>>>   If no *function* is specified, the documentation for all functions
>>>   and types in the *source* will be included.
>>>   *type* can be a struct, union, enum, or typedef identifier.
>>
>> Hmm.. looking the entire logic:
>>
>>         elif 'identifiers' in self.options:
>>             identifiers = self.options.get('identifiers').split()
>>             if identifiers:
>>                 for i in identifiers:
>>                     i = i.rstrip("\\").strip()
>>                     if not i:
>>                         continue
>>
>>                     cmd += ['-function', i]
>>                     self.msg_args["symbol"].append(i)
>>             else:
>>                 cmd += ['-no-doc-sections']
>>                 self.msg_args["no_doc_sections"] = True
>>
>> I suspect that an empty identifier could be raising an exception.
>>
>> The right logic should be, instead:
>>
>> -        elif 'identifiers' in self.options:
>> -            identifiers = self.options.get('identifiers').split()
>> -            if identifiers:
>> -                for i in identifiers:
>> +        elif 'identifiers' in self.options:
>> +            identifiers = self.options.get('identifiers')
>> +            if identifiers:
>> +                for i in identifiers.split():
>>
>> (tests needed)
> 
> Sheesh, I can't find that code so that I can patch it.
> (in today's linux-next 20250909)

oops, I was looking in scripts/ and not in Documentation/.
got it.

> Anyway, does this take away something that currently works?
> 
> thanks.

-- 
~Randy


