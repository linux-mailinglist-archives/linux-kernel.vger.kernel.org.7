Return-Path: <linux-kernel+bounces-809429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC05B50D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA365E1C42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206732E0419;
	Wed, 10 Sep 2025 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GUiKNtmi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CC3B186;
	Wed, 10 Sep 2025 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483985; cv=none; b=k5p0LlicxwYbV8FbRU4GDJ0cPGrPw11jWaWvJfhT6G1Njeq8ImLMUPCLxItunxD9gCMZGtlaGfOOMvxQBbYy6duBmXqbzcGNvsKZ6obCKTmIHGNusgSmysTiyrxAyZqOaegqXxUYLgvGefJDC9/xfW50NhHBnwf+5fEvDhzK/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483985; c=relaxed/simple;
	bh=5IxG8Z9PgwiMMwrOHhG7jefOPrAnnnDK9LcuzzTL9Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMoApKom/8dvSNmj9zJ+UkXV8lb54dFFWY2T5f8dCtr6ynr1NsKqTlm5B5w7iVpbjsBJ0MiYBfcVjZ8ltUrhHj9AqOPi3NEkDMA++IVPOR0FrFrZtNl19wIs6GvwOych2X9XMywBhFEEtFdqFBAJ2X5Hd4tRCjAllXUz/I9hDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GUiKNtmi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Mnw4Ea8vEVwGfnN17/VxvzfcceILPNEC7ILi6SjVv80=; b=GUiKNtmigoEsHj6WJ/U4Lo4PHh
	aEqD0U1Dqn1GFAFoGiSHOt4SD2akXQEPG0QP9q4+fv+qmoDW2uMWnzJXruJWUNr3PDCbAoRokwyR0
	oHr69BREEsUhf4MMX0bLe6+fFsD4DjUCiWzl4BkIc5tB1c19jB2SvW5oXF5+5uhAEVX+Duk53ijTH
	x3BenGs8/jzwXUpzKzw19NW2zFx3iIO4az1AQwDovyu1sdsTKUSsk0KXUHaC1/a4zJs1t22MEAEe/
	GSa9HDAa01NBV90lOposu/RJrtO5ahp6QHUdzdj/VPSL1Z16GUIbz1vsMVW93HLKOGaGTTggD7bNP
	NPlWLlEA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwDrq-0000000CETl-14dY;
	Wed, 10 Sep 2025 05:59:42 +0000
Message-ID: <14133b75-a984-4244-a18d-f02f0b81d1b7@infradead.org>
Date: Tue, 9 Sep 2025 22:59:41 -0700
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
 <5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
 <20250910010903.5388bffc@foz.lan>
 <0d190bf0-b9d4-4d5c-a1cc-6d5d79be3886@infradead.org>
 <656591ff-fa7d-4763-8759-0a0af3a4039a@infradead.org>
 <c195c68f-e815-4428-9134-8746198a4611@infradead.org>
 <20250910062323.059bb078@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250910062323.059bb078@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 9/9/25 9:23 PM, Mauro Carvalho Chehab wrote:
> Em Tue, 9 Sep 2025 17:02:00 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> On 9/9/25 4:50 PM, Randy Dunlap wrote:
>>>
>>>
>>> On 9/9/25 4:49 PM, Randy Dunlap wrote:  
>>>>
>>>>
>>>> On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:  
>>>>> Em Tue, 9 Sep 2025 14:06:43 -0700
>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>>>>  
>>>>>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:  
>>>>>>> Em Tue, 9 Sep 2025 00:27:20 -0700
>>>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:  
>>>>>  
>>>>>>>> +.. kernel-doc:: init/kdoc-globals-test.c
>>>>>>>> +   :identifiers:
>>>>>>>>
>>>>>>>> The html output says
>>>>>>>> "Kernel Globals"
>>>>>>>> but nothing else.    
>>>>>>>
>>>>>>> I usually don't add :identifiers: on kernel-doc entries. If you use
>>>>>>> identifiers, you need to explicitly tell what symbols you want.    
>>>>>>
>>>>>> Well, it worked/works without using having any identifiers listed, and
>>>>>> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
>>>>>> optional:
>>>>>>
>>>>>> identifiers: *[ function/type ...]*
>>>>>>   Include documentation for each *function* and *type* in *source*.
>>>>>>   If no *function* is specified, the documentation for all functions
>>>>>>   and types in the *source* will be included.
>>>>>>   *type* can be a struct, union, enum, or typedef identifier.  
>>>>>


>>>>> I suspect that an empty identifier could be raising an exception.  
>>
>> and it's being caught and ignored (not printed)?
> 
> there is a try/except block to capture exceptions. It is supposed to
> print something, though:
> 
>         try:
>             if kfiles:
>                 return self.run_kdoc(cmd, kfiles)
>             else:
>                 return self.run_cmd(cmd)
> 
>         except Exception as e:  # pylint: disable=W0703
>             logger.warning("kernel-doc '%s' processing failed with: %s" %
>                            (cmd_str(cmd), pformat(e)))
>             return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
> 


>>>> Anyway, does this take away something that currently works?  
>>
>> The output looks the same with this patch AFAICT.
> 
> run it in verbose mode to see what command line was passed to
> the file:
> 
> 	$ make SPHINXDIRS=your_test_dir V=1 htmldocs
> 
> This should be printing how the kernel-doc.py command line would be(*):
> 
> 	scripts/kernel-doc.py -rst -enable-lineno ./include/linux/peci.h
> 	./include/linux/peci.h:20 Scanning doc for struct peci_controller_ops
> 	./include/linux/peci.h:32 Scanning doc for struct peci_controller
> 	./include/linux/peci.h:58 Scanning doc for struct peci_device
> 	./include/linux/peci.h:88 Scanning doc for struct peci_request
> 
> (*) the kerneldoc.py extension doesn't call kernel-doc.py, but instead
>     run directly the Python classes from the library. Yet, to help one
>     to debug it, the command line is displayed.

I see. Thanks.

I get this if I list all of them (on 2 separate identifiers lines):

../scripts/kernel-doc.py -rst -enable-lineno -function ROOT_DEV -function system_state -function saved_command_line -function diskseq ../init/kdoc-globals-test.c
../init/kdoc-globals-test.c:5 Scanning doc for global ROOT_DEV
../init/kdoc-globals-test.c:15 Scanning doc for global system_state
../init/kdoc-globals-test.c:27 Scanning doc for global saved_command_line
../init/kdoc-globals-test.c:33 Scanning doc for global loops_per_jiffy
../init/kdoc-globals-test.c:40 Scanning doc for global preset_lpj
../init/kdoc-globals-test.c:49 Scanning doc for global linux_proc_banner
../init/kdoc-globals-test.c:63 Scanning doc for global linux_banner
../init/kdoc-globals-test.c:72 Scanning doc for global diskseq
../init/kdoc-globals-test.c:80 Scanning doc for global rtnl_mutex
../scripts/kernel-doc.py -rst -enable-lineno -function loops_per_jiffy -function preset_lpj -function linux_proc_banner -function linux_banner ../init/kdoc-globals-test.c

or this is I don't use the identifiers line at all:

../scripts/kernel-doc.py -rst -enable-lineno ../init/kdoc-globals-test.c
../init/kdoc-globals-test.c:5 Scanning doc for global ROOT_DEV
../init/kdoc-globals-test.c:15 Scanning doc for global system_state
../init/kdoc-globals-test.c:27 Scanning doc for global saved_command_line
../init/kdoc-globals-test.c:33 Scanning doc for global loops_per_jiffy
../init/kdoc-globals-test.c:40 Scanning doc for global preset_lpj
../init/kdoc-globals-test.c:49 Scanning doc for global linux_proc_banner
../init/kdoc-globals-test.c:63 Scanning doc for global linux_banner
../init/kdoc-globals-test.c:72 Scanning doc for global diskseq
../init/kdoc-globals-test.c:80 Scanning doc for global rtnl_mutex


And then both of them report these warnings (already discussed):

Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:10: WARNING: Invalid C declaration: Expected end of definition. [error at 32]
  enum system_states system_state __read_mostly;
  --------------------------------^
Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:20: WARNING: Invalid C declaration: Expected end of definition. [error at 25]
  char *saved_command_line __ro_after_init;
  -------------------------^

and the 3 globals with initialization values are skipped/omitted.

So to get "all identifiers," I should just omit the :identifiers:
line completely. kernel-doc.rst could use some clarification on that
point.

Thanks.
-- 
~Randy


