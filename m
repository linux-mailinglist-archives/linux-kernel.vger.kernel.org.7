Return-Path: <linux-kernel+bounces-809025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050EBB507A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B9B188AA75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4496246789;
	Tue,  9 Sep 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QErhSw5g"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE62156230;
	Tue,  9 Sep 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452007; cv=none; b=M9HcbM7GWBKoSekBEpGL4L89Vt1zbZXbge3ugdzvXlJ2JaSKVDllko/a/yPTC0dX0HnxjXmSD9i1HTmwoevjrWdtXRMW9dz8gLKdNtQvJBMleZ3RPeOgqqPuJ4dl8rJ1Ec7sOduhvotdnjkfJl8Moe0F22h8SHC3xnt48GB3MXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452007; c=relaxed/simple;
	bh=WleETWC+GsQIv4WF9jFa8jkLFZOSyzCZ01AJm3KkFnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ActQ0HS2YVAj7A6fWPNxPBcd+8gpYIn91psCXjwPyoO8Skb6uSGWl81yy2flDNKqPRZvKLLTcsGjjU5okyUarHZscp4+CVD7Rq9fCHkTbQ/83l7Okchid3p8yZi7cizcnvyaoodUW91R5wAwskgS5MRKRVvwEm2+PGictlvEUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QErhSw5g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JpRhAacMskRE5f/7K9KISuGLtmoNhtQQkhXvzxgsxk0=; b=QErhSw5gIC360LztoXcePOd95b
	KMnGYTYwbYlr0Wy2zaVv1LSSkjIFIs6Mn4iVHSOaDQ+pwMUGY3ONEj/XLtISMNpdC4qiaSk1u+YEd
	GfUBEFjvV33zeQedRXvc1gS8Qw3coMI0rT/1FR59Wqoog9+U6Y+hXIWYx9MtinCOMNLvNq80VUNRA
	osaz+HdPkxSwb8m65iK5X5B3pgWZwkXknfR1VoLZ965oDgwKqhZMVgxACVXDA8SmDMOwbBPqhzLB5
	cddE819BVr00VKtNJeV7OBVPq4FYF4wHdolCZyidwLKFra02Aorc5XakYCJjeMZTyNWyPo02kCqkF
	FYmMCaow==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw5Y4-0000000AGqm-0af7;
	Tue, 09 Sep 2025 21:06:44 +0000
Message-ID: <5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
Date: Tue, 9 Sep 2025 14:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
 <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
 <20250909215824.1968220c@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250909215824.1968220c@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:
> Em Tue, 9 Sep 2025 00:27:20 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> Hi Mauro,
>>


>> So, I grabbed some global data from 6-8 places in the kernel and put them intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/kernel-api.rst
>> like this at the end of that file:
>>
>> +
>> +Kernel Globals
>> +==========================
>> +
>> +.. kernel-doc:: init/kdoc-globals-test.c
>> +   :identifiers:
>>
>> The html output says
>> "Kernel Globals"
>> but nothing else.
> 
> I usually don't add :identifiers: on kernel-doc entries. If you use
> identifiers, you need to explicitly tell what symbols you want.

Well, it worked/works without using having any identifiers listed, and
the docs in Documentation/doc-guide/kernel-doc.rst says that they are
optional:

identifiers: *[ function/type ...]*
  Include documentation for each *function* and *type* in *source*.
  If no *function* is specified, the documentation for all functions
  and types in the *source* will be included.
  *type* can be a struct, union, enum, or typedef identifier.


> As a reference, kerneldoc.py logic for identifiers is:
> 
> 	if 'identifiers' in self.options:                                                                                                                                                                      
>             identifiers = self.options.get('identifiers').split()                                                                                                                                                
>             if identifiers:
>                 for i in identifiers:
>                     i = i.rstrip("\\").strip()
>                     if not i:
>                         continue
> 
>                     cmd += ['-function', i]
>                     self.msg_args["symbol"].append(i)
> 
> without it, it will pick the entire set of symbols. 

Yeah, that's exactly what I want, so I don't see a problem.


>> My test files are attached. I dumbed down (simplified) a few
>> of the globals from fancy types to just unsigned long, but that
>> didn't help the output results any.
> 
> Looking on your attachment, you can either drop :identifiers:
> or list all of them:
> 
> 	.. kernel-doc:: init/kdoc-globals-test.c
> 	   :identifiers: ROOT_DEV loop_per_jiffy
> 	   :identifiers: preset_lpj
> 
> (here, it should only show those 3 symbols)
> 
> see, having this:
> 
> 	.. kernel-doc:: init/kdoc-globals-test.c
> 	   :identifiers: ROOT_DEV 
> 
> will run:
> 
> 	$ ./scripts/kernel-doc init/kdoc-globals-test.c -function ROOT_DEV 
> 
> 
> 	.. c:var:: unsigned long ROOT_DEV;
> 
> 	  system root device


Yes, I understand how to use explicit identifiers.  :)
Thanks.
-- 
~Randy


