Return-Path: <linux-kernel+bounces-753482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AECEB18393
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F671C8300D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C12690D5;
	Fri,  1 Aug 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R88BAQ6a"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74E4A1D;
	Fri,  1 Aug 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058113; cv=none; b=gKI0cGersgxpcP5eNYoZpdHgNOyiWQFyaanLEkhdKHEZ3QzRDy8/Gh2SMlOL0Fd0xsyIlHbWZbmQab0kCu6sNFUqaCYmmTXY30vFAacJ0yVKQmrpch7f+GYuqGeZmlmrj+q9Sy078uh/8vAqIzni4+8+zcvAiO0jDPaTcAhKRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058113; c=relaxed/simple;
	bh=Vk4yhqUs6asX1UYp28stE8DmbpfWp5RqzyNaf8hTOro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3XvXyiYq4ZBml/tbhZXmY9yZ+WNBgEER1Zv7auXWl++w+eKd5AymYDVdNDRWCtwMVxDMyr5OyvkF1RGvtjZfHsETDzcnsJbSmL8PlakliHN/5PBOq29UPgkRQa30eWbE2IXWj75dpVoWEPWJdYuO4YIqkhgp1Wfrq7ZFXYtCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R88BAQ6a; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6B71240AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754058110; bh=FCNzgg8KFGO5P4jyLB/uIOqTkdI+Q2VJEsljptIYopg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R88BAQ6ajCUZij/lg79qWCslrmuf/2ulmHJ8xv9FR8FnSkDSrftmV8ofwZT8vMv+Z
	 ISLHVy3EWi3yvjBByPp3srpHbWhE0gx04G7rVIg442DtZNsqj+pPdJ8MwYtkN8I60y
	 bZmReLlzo2WPXj6FFDSl6HPHhRSXwE5/RlochK7A5IOs6YQEqNS6eZaYV8HgT/HjTu
	 qFXEH2m4GXi7OgOB5lZHdlVTls0GDrikOlaFwPjpfokMJQfX5gIuoBUwsh2xVzOFx7
	 ZIoHLZ7zw77UXS4vGovrKNRAJQacxKswdMahkOAzd5+6E+0mZ6h+BvB65mvft9Q5vw
	 soGSgxCCo5GSw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6B71240AD2;
	Fri,  1 Aug 2025 14:21:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 03/12] docs: kdoc: backslashectomy in kdoc_parser
In-Reply-To: <20250801062710.552dac5a@foz.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
 <20250801001326.924276-4-corbet@lwn.net> <20250801062710.552dac5a@foz.lan>
Date: Fri, 01 Aug 2025 08:21:49 -0600
Message-ID: <87h5yrruki.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 31 Jul 2025 18:13:17 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> A lot of the regular expressions in this file have extraneous backslashes
>
> This one is a bit scary... It could actually cause issues somewhere.

What kind of issues?

> Also, IMHO, some expressions look worse on my eyes ;-)

Here I think we're going to disagree.  The extra backslashes are really
just visual noise as far as I'm concerned.

>> that may have been needed in Perl, but aren't helpful here.  Take them out
>> to reduce slightly the visual noise.
>
> No idea if Perl actually requires, but, at least for me, I do prefer to
> see all special characters properly escaped with a backslash. This way,
> it is a lot clearer that what it is expecting is a string, instead of
> using something that may affect regex processing.

I guess my point is that, in the given cases, the characters in question
*aren't* special.

>> -        param = KernRe(r'[\[\)].*').sub('', param, count=1)
>> +        param = KernRe(r'[)[].*').sub('', param, count=1)
>
> This one, for instance, IMHO looks a lot worse for my eyes to understand
> that there is a "[" that it is not an operator, but instead a string.
> The open close parenthesis also looks weird. My regex-trained eyes think
> that this would be part of a capture group.

...and mine say "that's in [brackets] why are you escaping it?" :)

>>          if dtype == "" and param.endswith("..."):
>>              if KernRe(r'\w\.\.\.$').search(param):
>> @@ -405,7 +405,7 @@ class KernelDoc:
>>  
>>          for arg in args.split(splitter):
>>              # Strip comments
>> -            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
>> +            arg = KernRe(r'/\*.*\*/').sub('', arg)
>
> A pattern like /..../ is a standard way to pass search group with Regex
> on many languages and utils that accept regular expressions like the
> sed command. Dropping the backslash here IMHO makes it confusing ;-)

...but it is definitely not any such in Python and never has been, so
escaping slashes looks weird and makes the reader wonder what they are
missing.

> Seriously, IMHO this patch makes a lot worse to understand what brackets,
> parenthesis and dots are strings, and which ones are part of the regex
> syntax. 

So I guess I won't fight this one to the death, but I really do
disagree.  Writing regexes in a non-canonical style just makes it harder
for anybody else who comes along to figure out what is going on; it
certainly made it harder for me.

Thanks,

jon

