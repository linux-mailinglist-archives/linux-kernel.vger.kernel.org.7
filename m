Return-Path: <linux-kernel+bounces-809458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA1B50DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657DD4412E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101D2D7DFF;
	Wed, 10 Sep 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qgvGcVJo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6432D24A7;
	Wed, 10 Sep 2025 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484806; cv=none; b=dpC8FNwUOhbF8nsSYOHjjYTxMT9oewdFrVfZBXAmPBfk8dpbY+ljwfZYeuNT/0437cQgaBBEBZL+DRr4FaxwDdzdZm16piqgdWkTS0drKLkFTlgwXK5QWGc4IfsCcR4e4JSmsrvId4hbu7VTz7ykp7lX/IwslarUjYyFpG2WY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484806; c=relaxed/simple;
	bh=TfRMU+9Gdx1HC4JtInnhupQ4idDhmQVckLzwHxwUqzY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eo2MHED3+EgaiULtjhPhvjSu797GbZuGX1FChTl3afg5ZVz6kwA6u7MpQ9eBZDdLM5j1FICjqVTiOpyV8mVlDRPG7d7nf4D8v3o+V4muUXNksrJ9W8y94VmPmMkDb1JeFnzS2+tH7NZbe9dc2qGP8aeIxcZaPImgJ0MQ9bDrNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qgvGcVJo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=67Gw54VTjVoR7AIVRUVgTTN6sTGR1jOjlc8cyyIBWo0=; b=qgvGcVJoFyUqHE7JepjL2lDInc
	ME+w7KYYabpVHhce4yFXxS1h7tInMh8jP4rrMcaPTxQy/XSv+G92cpU1SgmW4d49YvYujMjAI5/m6
	y7A8l/N/aiWq2XScZQpNPHJmiQmaL7gHAX+f+OaLO9OptEqFmYjnBq+YtcwPiFCjYUoKDpcS2j+Wt
	pf+H6ZFzPyBJ0sxaMYXnaDhv8u08OvNsvD+PPq5qn2+wCoCVMN4dfuB5z6sLk/oZ1i1bu0WIyodHD
	BnDtmnUSuY6LVniHrBsnQbFFCCzOtC9vcG4Cq+yOO1ov3tWyPm4AgMwArY7b72ga7cb0pPy+RjHmT
	K+zQL5kQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwE56-0000000CG6N-29BK;
	Wed, 10 Sep 2025 06:13:24 +0000
Message-ID: <c5262290-38e3-4c48-af00-b91f03a065a8@infradead.org>
Date: Tue, 9 Sep 2025 23:13:24 -0700
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
 <c195c68f-e815-4428-9134-8746198a4611@infradead.org>
 <20250910062323.059bb078@foz.lan>
 <14133b75-a984-4244-a18d-f02f0b81d1b7@infradead.org>
Content-Language: en-US
In-Reply-To: <14133b75-a984-4244-a18d-f02f0b81d1b7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/9/25 10:59 PM, Randy Dunlap wrote:
> Hi Mauro,
> 
> On 9/9/25 9:23 PM, Mauro Carvalho Chehab wrote:
>> Em Tue, 9 Sep 2025 17:02:00 -0700
>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>
>>> On 9/9/25 4:50 PM, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 9/9/25 4:49 PM, Randy Dunlap wrote:  
>>>>>
>>>>>
>>>>> On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:  
>>>>>> Em Tue, 9 Sep 2025 14:06:43 -0700
>>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>>>>>  
>>>>>>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:  
>>>>>>>> Em Tue, 9 Sep 2025 00:27:20 -0700
>>>>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:  
>>>>>>  
>>>>>>>>> +.. kernel-doc:: init/kdoc-globals-test.c
>>>>>>>>> +   :identifiers:
>>>>>>>>>
>>>>>>>>> The html output says
>>>>>>>>> "Kernel Globals"
>>>>>>>>> but nothing else.    
>>>>>>>>
>>>>>>>> I usually don't add :identifiers: on kernel-doc entries. If you use
>>>>>>>> identifiers, you need to explicitly tell what symbols you want.    
>>>>>>>
>>>>>>> Well, it worked/works without using having any identifiers listed, and
>>>>>>> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
>>>>>>> optional:
>>>>>>>
>>>>>>> identifiers: *[ function/type ...]*
>>>>>>>   Include documentation for each *function* and *type* in *source*.
>>>>>>>   If no *function* is specified, the documentation for all functions
>>>>>>>   and types in the *source* will be included.
>>>>>>>   *type* can be a struct, union, enum, or typedef identifier.  
>>>>>>



>>>>> Anyway, does this take away something that currently works?  
>>>
>>> The output looks the same with this patch AFAICT.
>>
>> run it in verbose mode to see what command line was passed to
>> the file:
>>
>> 	$ make SPHINXDIRS=your_test_dir V=1 htmldocs
>>
>> This should be printing how the kernel-doc.py command line would be(*):
>>
>> 	scripts/kernel-doc.py -rst -enable-lineno ./include/linux/peci.h
>> 	./include/linux/peci.h:20 Scanning doc for struct peci_controller_ops
>> 	./include/linux/peci.h:32 Scanning doc for struct peci_controller
>> 	./include/linux/peci.h:58 Scanning doc for struct peci_device
>> 	./include/linux/peci.h:88 Scanning doc for struct peci_request
>>
>> (*) the kerneldoc.py extension doesn't call kernel-doc.py, but instead
>>     run directly the Python classes from the library. Yet, to help one
>>     to debug it, the command line is displayed.
> 
> I see. Thanks.
> 
> I get this if I list all of them (on 2 separate identifiers lines):
> 
> ../scripts/kernel-doc.py -rst -enable-lineno -function ROOT_DEV -function system_state -function saved_command_line -function diskseq ../init/kdoc-globals-test.c
> ../init/kdoc-globals-test.c:5 Scanning doc for global ROOT_DEV
> ../init/kdoc-globals-test.c:15 Scanning doc for global system_state
> ../init/kdoc-globals-test.c:27 Scanning doc for global saved_command_line
> ../init/kdoc-globals-test.c:33 Scanning doc for global loops_per_jiffy
> ../init/kdoc-globals-test.c:40 Scanning doc for global preset_lpj
> ../init/kdoc-globals-test.c:49 Scanning doc for global linux_proc_banner
> ../init/kdoc-globals-test.c:63 Scanning doc for global linux_banner
> ../init/kdoc-globals-test.c:72 Scanning doc for global diskseq
> ../init/kdoc-globals-test.c:80 Scanning doc for global rtnl_mutex
> ../scripts/kernel-doc.py -rst -enable-lineno -function loops_per_jiffy -function preset_lpj -function linux_proc_banner -function linux_banner ../init/kdoc-globals-test.c
> 
> or this is I don't use the identifiers line at all:
> 
> ../scripts/kernel-doc.py -rst -enable-lineno ../init/kdoc-globals-test.c
> ../init/kdoc-globals-test.c:5 Scanning doc for global ROOT_DEV
> ../init/kdoc-globals-test.c:15 Scanning doc for global system_state
> ../init/kdoc-globals-test.c:27 Scanning doc for global saved_command_line
> ../init/kdoc-globals-test.c:33 Scanning doc for global loops_per_jiffy
> ../init/kdoc-globals-test.c:40 Scanning doc for global preset_lpj
> ../init/kdoc-globals-test.c:49 Scanning doc for global linux_proc_banner
> ../init/kdoc-globals-test.c:63 Scanning doc for global linux_banner
> ../init/kdoc-globals-test.c:72 Scanning doc for global diskseq
> ../init/kdoc-globals-test.c:80 Scanning doc for global rtnl_mutex
> 
> 
> And then both of them report these warnings (already discussed):
> 
> Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:10: WARNING: Invalid C declaration: Expected end of definition. [error at 32]
>   enum system_states system_state __read_mostly;
>   --------------------------------^
> Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:20: WARNING: Invalid C declaration: Expected end of definition. [error at 25]
>   char *saved_command_line __ro_after_init;
>   -------------------------^
> 
> and the 3 globals with initialization values are skipped/omitted.
> 
> So to get "all identifiers," I should just omit the :identifiers:
> line completely. kernel-doc.rst could use some clarification on that
> point.


Oh darn, the html output is different:

when I omit the :identifiers: line, I see:

Kernel Globals
dev_t ROOT_DEV;
system root device

enum system_states system_state __read_mostly;
system state used during boot or suspend/hibernate/resume

char *saved_command_line __ro_after_init;
kernel’s command line, saved from use at any later time in the kernel.

unsigned long preset_lpj;
lpj (loops per jiffy) value set from kernel command line using “lpj=VALUE”

static atomic64_t diskseq;
unique sequence number for block device instances

and when I list all 8 identifiers (on 2 separate lines), I see:

Kernel Globals
dev_t ROOT_DEV;
system root device

static atomic64_t diskseq;
unique sequence number for block device instances

unsigned long preset_lpj;
lpj (loops per jiffy) value set from kernel command line using “lpj=VALUE”

so for some reason, system_state, saved_command_line, and diskseq are
skipped/omitted when I list all 8 identifiers.


-- 
~Randy


