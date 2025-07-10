Return-Path: <linux-kernel+bounces-725757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677EEB00352
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CC15A07AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A022F76F;
	Thu, 10 Jul 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="I1EjXii0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97972248B3;
	Thu, 10 Jul 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154030; cv=none; b=mAD+Aov/jtzWZWPZlJcC1zycr2Ot+kcdFD9hbXNLpSIPROlo42eNJzR5V2iu2YuL5kt+X6YmjBiZOOsjj4WvUyvV7ph3gbUYgQsls7dQmubwA6wknuiigf/MvCY7uLieeRhsGqSPpvk+hJEU9rhciBOPlYr9SNlNetR5YhHYV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154030; c=relaxed/simple;
	bh=481E+fAvca5n52JQMQhxAjHgrWP/mYYXn7RS0xSjnCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z9lOiL1AyBSGGz3/jBYD9bNvw7A3fHMeR0his2Fk9zy1OnLU4qgCax5b/Z2yRF0ljoztAdL3Vuatce5JWdQWbHFQVwvvh9VkSjE6b9Q0Y5DJzYn+3zmrgFxV35iFgtbgsjMeHe7Ab3l4PWP+BU7r1h6YOvI2Jyovl4ApO/bguZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=I1EjXii0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34BEF40AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752154028; bh=6sD6xiaqHahqHCl608a7Pt1aLuumWeswzITGWjxPddA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I1EjXii0iztMkdq+1WWWwScjFF3sUk7Gmefb+0zwYN049ISE41V9mzSoKeU3za41j
	 HQCM7svlQSBJ3Bfafp/vMFoLSxqtfenLrOuY7+ShUK7/XNlpORtP/O609yol4EV7vB
	 EwviCvdOw5xZjwZYNg2UuvLd/y1YDIwj69UnuRtGj5wm4hVotpAF9g6rX0zKEApqkT
	 yxi9+ZzAvXA30+XnItKlDHGoVGVlRT2pEJyBioqFrX9kbWpL7jB211jIVe9m4xngl2
	 blDKE3bReLPsjZPqN9cYmN440Z6GOD3au9FpgPgDEIl9YM8HQD9SeTyowFPig+JCsE
	 wiDt0QxM7UQQA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 34BEF40AAB;
	Thu, 10 Jul 2025 13:27:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 09/12] docs: kdoc: straighten up dump_declaration()
In-Reply-To: <20250710082556.35a909b2@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
 <20250702223524.231794-10-corbet@lwn.net>
 <20250710082556.35a909b2@foz.lan>
Date: Thu, 10 Jul 2025 07:27:07 -0600
Message-ID: <87frf4yy50.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Wed,  2 Jul 2025 16:35:21 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Get rid of the excess "return" statements in dump_declaration(), along with
>> a line of never-executed dead code.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  scripts/lib/kdoc/kdoc_parser.py | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>> 
>> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
>> index 6e35e508608b..7191fa94e17a 100644
>> --- a/scripts/lib/kdoc/kdoc_parser.py
>> +++ b/scripts/lib/kdoc/kdoc_parser.py
>> @@ -878,18 +878,13 @@ class KernelDoc:
>>  
>>          if self.entry.decl_type == "enum":
>>              self.dump_enum(ln, prototype)
>> -            return
>> -
>> -        if self.entry.decl_type == "typedef":
>> +        elif self.entry.decl_type == "typedef":
>>              self.dump_typedef(ln, prototype)
>> -            return
>> -
>> -        if self.entry.decl_type in ["union", "struct"]:
>> +        elif self.entry.decl_type in ["union", "struct"]:
>>              self.dump_struct(ln, prototype)
>> -            return
>> -
>
> The above LGTM.
>
>> -        self.output_declaration(self.entry.decl_type, prototype,
>> -                                entry=self.entry)
>> +        else:
>> +            # This would be a bug
>> +            self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')
>
> Hmm... Are you sure about that? If I'm not mistaken, this was used for
> other types of arguments, like DOC: tags.

DOC tags are handled in a different path entirely.  I did ensure that
the code in question was never executed ... but then left the message in
place just in case.

Thanks,

jon

