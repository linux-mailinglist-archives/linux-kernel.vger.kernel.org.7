Return-Path: <linux-kernel+bounces-753870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D0B18945
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B82A5A0265
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F7A23817F;
	Fri,  1 Aug 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KWyz5I1t"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC022E402;
	Fri,  1 Aug 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089208; cv=none; b=gYtuUCiZpqpTxDeLrwgwB0Y1Oatm0MJgIzYpJZaJlmAfm6AQj0oOmRKRC4o5EsbLRvDAHFPucNkxjapioJrJCXHMzbAzYP+yAXB26jnQ+U5k1ewAQPpNx2wmPbahe3rAP11m7hkUy96dLcGiERmqcrf0J1S5ISp3yYOg1bWjkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089208; c=relaxed/simple;
	bh=hSfvBNAxlF9UTGBFGhPRyD90uhNRrXmPIzizgHn4dc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKlK5VJMYXRBFYv0u8t8u1GhFyvuSWnOCc4P4NjYBT24uzZxKNgt1hmejGwX9dpscNfpIf7AwiWxBpmXFpfQYOh3Bu8lpRsPIfoU+3hZPNyZe2YrmsVHzJOIQ++/9TOoRvapSrBKYlUXr90wWBPL4SCAQn6XDRe/FCNSdUhzxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KWyz5I1t; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1AB9A40AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754088754; bh=RI5tGzMTL4KoCeeo0GS/YvN4MLpI/zAokVqzREmztm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KWyz5I1tbhUhAxt351/G0kXlF26vMCbuyK6JYUkjqoXOpNalAzFhkVtVZsF8FPWr1
	 HGumeGtPDoz//fjNKjYMXOiOJSyn2pYpsM8DBlgCQzg8uAiwmAzSpBosAk/AaCv74a
	 98SE08LYXPgAVpjsFVjdX3RpAldgEgfd5pX2f9Mn74EpofjDRztqIBbF1qz+VCIB3l
	 0Qam0crJnksRXxbGAXJezy5CUvZ+KUTzWzuJ4pYkW72Tp9xTiZ8PUwT6giu9R+0b4W
	 EW0z4Rf83Oz8CmLl5N1QSbGgVcdP5RbheFoCD4bmbjW4Ep0RSqvA3iAsWI2E0QH0EI
	 veGkljaM+yC1Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1AB9A40AA9;
	Fri,  1 Aug 2025 22:52:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members() cleanup
In-Reply-To: <20250801080744.14f83626@foz.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
 <20250801001326.924276-11-corbet@lwn.net>
 <20250801080744.14f83626@foz.lan>
Date: Fri, 01 Aug 2025 16:52:33 -0600
Message-ID: <87v7n6pscu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 31 Jul 2025 18:13:24 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Get rid of some single-use variables and redundant checks, and generally
>> tighten up the code; no logical change.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  scripts/lib/kdoc/kdoc_parser.py | 89 ++++++++++++++++-----------------
>>  1 file changed, 42 insertions(+), 47 deletions(-)
>> 
>> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
>> index 20e0a2abe13b..2b7d7e646367 100644
>> --- a/scripts/lib/kdoc/kdoc_parser.py
>> +++ b/scripts/lib/kdoc/kdoc_parser.py
>> @@ -673,73 +673,68 @@ class KernelDoc:
>>          while tuples:
>>              for t in tuples:
>>                  newmember = ""
>> -                maintype = t[0]
>> -                s_ids = t[5]
>> -                content = t[3]
>
> The reason I opted for this particular approach...
>> -
>> -                oldmember = "".join(t)
>> -
>> -                for s_id in s_ids.split(','):
>> +                oldmember = "".join(t) # Reconstruct the original formatting
>> +                #
>> +                # Pass through each field name, normalizing the form and formatting.
>> +                #
>> +                for s_id in t[5].split(','):
>
> ... is that it is easier to understand and to maintain:
>
> 	for s_id in s_ids.split(','):
>
> than when magic numbers like this are used:
>
> 	for s_id in t[5].split(','):

Coming into this code, I had a different experience, and found the
variables to just be a layer of indirection I had to pass through to get
to the capture groups and see what was really going on.  That was part
of why I put the group numbers in the comments next to that gnarly
regex, to make that mapping more direct and easier to understand.

I will not insist on this change either - at least not indefinitely :)
I do feel, though, that adding a step between the regex and its use just
serves to obscure things.

(And yes, I don't really think that named groups make things better.
I've found those useful in situations where multiple regexes are in use
and the ordering of the groups may vary, but otherwise have generally
avoided them).

Thanks,

jon

