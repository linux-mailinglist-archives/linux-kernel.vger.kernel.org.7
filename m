Return-Path: <linux-kernel+bounces-809156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BEB5095A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0DC1C20C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0E28C840;
	Tue,  9 Sep 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lfrfgqyl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B9263C69;
	Tue,  9 Sep 2025 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461746; cv=none; b=MkUwbcniQZ2k1rf9u9m92lDvkXcOD6KOCPJimF792HmWrkCbPGn+ph0iL2caBiutcl5IUgBTLIg+l45mnV2MOZKtYd9nTghxd9qgctz9bifMLDv3luzTy3yt3xuvlIziyWRGgfBk1rUMWVxO/U+saCG+rlHPMoNb2CeFQhe1wNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461746; c=relaxed/simple;
	bh=ifaveuRP1lkmToJv/vqVwP6f+GXkiOZzi5N8jnOqPlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv7gI31gU1Eg3mJ3NphhRyOW+YOajrhuR8uK5C4Ro44SGRCAxnwFeEhRdoy4onb2ZtMSj+McyIVxVrjvVHrbHueuTvnmUqKsfz2JN5rUC/NudbWPSpA1/0jam+dO4WPKhX+vi/BiWS2O8YXhqMoFO3Xdl690EBPJPIWxr2ODj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lfrfgqyl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=uJfWuo0MZXOLxI791mD3r/hoECoRqmtqO0CG+FThFRk=; b=LfrfgqylJutd1Lc1BPWk9C/G5g
	eTzT2hbtDr9AHvtt0Du3pGGVF8ZeMfZ4sjBPIdtqBurt3RqIsb3dO7P0LDFfzH2vHe//Tksqn9zxH
	8EKg6B6+1RLFRhDwSM0QjbDRq0s+INHLmgBumqpJPFax3gggR1Z2arHcLyIKI2W0hR5sdORILnCdc
	CQO4QGwqu/deP+8+c9KquHQn4gXMRxuG/JgiOXrLnfMRMVB1XLtYq6tUEOJTnCnmS+SPSKIwzcy0X
	kmvyKlfpb9xx9Jhuz+REzzWZazkN6THcEryPg3JAC8yDlVAzgSg6LNg/0dHhRMmvFv79AiOwkIf69
	J+1J7U5g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw859-0000000AzEV-2qWl;
	Tue, 09 Sep 2025 23:49:03 +0000
Message-ID: <0d190bf0-b9d4-4d5c-a1cc-6d5d79be3886@infradead.org>
Date: Tue, 9 Sep 2025 16:49:03 -0700
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250910010903.5388bffc@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:
> Em Tue, 9 Sep 2025 14:06:43 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:
>>> Em Tue, 9 Sep 2025 00:27:20 -0700
>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>>>> +.. kernel-doc:: init/kdoc-globals-test.c
>>>> +   :identifiers:
>>>>
>>>> The html output says
>>>> "Kernel Globals"
>>>> but nothing else.  
>>>
>>> I usually don't add :identifiers: on kernel-doc entries. If you use
>>> identifiers, you need to explicitly tell what symbols you want.  
>>
>> Well, it worked/works without using having any identifiers listed, and
>> the docs in Documentation/doc-guide/kernel-doc.rst says that they are
>> optional:
>>
>> identifiers: *[ function/type ...]*
>>   Include documentation for each *function* and *type* in *source*.
>>   If no *function* is specified, the documentation for all functions
>>   and types in the *source* will be included.
>>   *type* can be a struct, union, enum, or typedef identifier.
> 
> Hmm.. looking the entire logic:
> 
>         elif 'identifiers' in self.options:
>             identifiers = self.options.get('identifiers').split()
>             if identifiers:
>                 for i in identifiers:
>                     i = i.rstrip("\\").strip()
>                     if not i:
>                         continue
> 
>                     cmd += ['-function', i]
>                     self.msg_args["symbol"].append(i)
>             else:
>                 cmd += ['-no-doc-sections']
>                 self.msg_args["no_doc_sections"] = True
> 
> I suspect that an empty identifier could be raising an exception.
> 
> The right logic should be, instead:
> 
> -        elif 'identifiers' in self.options:
> -            identifiers = self.options.get('identifiers').split()
> -            if identifiers:
> -                for i in identifiers:
> +        elif 'identifiers' in self.options:
> +            identifiers = self.options.get('identifiers')
> +            if identifiers:
> +                for i in identifiers.split():
> 
> (tests needed)

Sheesh, I can't find that code so that I can patch it.
(in today's linux-next 20250909)

Anyway, does this take away something that currently works?

thanks.
-- 
~Randy


