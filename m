Return-Path: <linux-kernel+bounces-725753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC69B00347
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9E41C45EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A57226CFF;
	Thu, 10 Jul 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rWMn+TNC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31A225414;
	Thu, 10 Jul 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153935; cv=none; b=DaAiXjCgMPe0VOBQ76U1CXjkB9gr6hM5gIWazpDEXZeAoE0+b4le08dfbkrhjUP1esRMNWDstExcwfd9RBZab73Sx0Y2MjzhOnODAec/vGYSU4B9Rt1nSs1kH5fg1uhjYuhaNvruob8uYFQHBRXpbyssBQx2nHtj3zhC8icvN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153935; c=relaxed/simple;
	bh=o7+Hf7Wo9CHNgJY0ewaHgmaV9SNL3jmQGklltBC0ENw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rk9Z3a5lRa6CoB6jWjE5FWRragTZvNGNuyEgHEeJKVwnEVDamLqLo5JpqiuQz2vnKilZFYYiSFdnqtk+E4RQv7vxiaTxGlVfG2798189Od5hiLpXsHQyKIpciMmPam0H3qkyBTkE1jd4gLJ9bVXV1nixeW+5x7AJNiNEYga14Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rWMn+TNC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CD25340AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752153933; bh=i5oikA4BG/bkIUnJrmDXMXzVdjz/nmtaDoQrWctrj60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rWMn+TNCths4zbJRFNYFdRu5HCPnc9U+M2Z/FO6fIBKA/58/JWPeETUgOHnRx3VJL
	 NcuI1Xh+9zuF1yHGSoRYHsvtLuix7OqfkKC1ylgBeQpLrKpyhcbEZGyuGpWtJeNQ6n
	 qUmfVNxfnm8lI8x/5rAKF/YmO1+imc0YzexgclvZ2mKUDyUSEsZrQ3wKE3LCze8CdN
	 ZmS3kOXQk2TWNtf46siOyb83ckG1SjMM0VUGPvoX0gYttmjGZ3FIdF8KsvsqjGjyEX
	 ByDXbcORtKydFKidQ9ZzJXp+15RSfq7ksAdYBIdInFCv5cDiMf3Gzlfq4I+VTxkdXI
	 Ys6/k0HEDbtNw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CD25340AAB;
	Thu, 10 Jul 2025 13:25:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 04/12] docs: kdoc: Centralize handling of the item
 section list
In-Reply-To: <20250710074543.31b909d8@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
 <20250702223524.231794-5-corbet@lwn.net> <20250710074543.31b909d8@foz.lan>
Date: Thu, 10 Jul 2025 07:25:31 -0600
Message-ID: <87jz4gyy7o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Wed,  2 Jul 2025 16:35:16 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> The section list always comes directly from the under-construction entry
>> and is used uniformly.  Formalize section handling in the KdocItem class,
>> and have output_declaration() load the sections directly from the entry,
>> eliminating a lot of duplicated, verbose parameters.
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  scripts/lib/kdoc/kdoc_item.py   |  8 ++++++++
>>  scripts/lib/kdoc/kdoc_output.py | 36 ++++++++++++---------------------
>>  scripts/lib/kdoc/kdoc_parser.py | 20 +++---------------
>>  3 files changed, 24 insertions(+), 40 deletions(-)
>> 
>> diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
>> index add2cc772fec..c8329019a219 100644
>> --- a/scripts/lib/kdoc/kdoc_item.py
>> +++ b/scripts/lib/kdoc/kdoc_item.py
>> @@ -9,6 +9,7 @@ class KdocItem:
>>          self.name = name
>>          self.type = type
>>          self.declaration_start_line = start_line
>> +        self.sections = self.sections_start_lines = { }
>
> Nitpicks:
> - to make coding-style uniform, please use "{}" without spaces;
> - Please place one statement per line, just like we (usually) do in Kernel. 

Sure, fine.

>   In this specific case, I strongly suspect that what you coded is not
>   implementing the semantics you want. See:
>
> 	1. are you creating a single dict and placing the same dict on two
> 	   variables?
>   or:
> 	2. are you initializing two different vars with their own empty
> 	   dict?
>
> The subsequent code assumes (2), but a quick check with python3 command
> line:

As you note, the subsequent code does *not* actually assume that; I know
the way Python semantics work :)  But I can separate the lines and make
things explicit.

Thanks,

jon

