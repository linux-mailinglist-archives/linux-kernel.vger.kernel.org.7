Return-Path: <linux-kernel+bounces-766959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC646B24D28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5601E174958
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AF1F4634;
	Wed, 13 Aug 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FSTAqWnF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655441EDA3A;
	Wed, 13 Aug 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098219; cv=none; b=op7fxURKyJb2zl5YzfKxP4vMaSyBMwMHsOFxyApvGLqc9KYaXSj5prVdC1HmoV8y4vRPnjNVn5ZhBCsMG/ZgKVVmX6B32JhdcdqGdhYpUfOrHdibtvn96GTBo/A425Lw7AZ9pr0AaL7TqWxFLyunHfZ2LZXF64mqG8tio5tm0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098219; c=relaxed/simple;
	bh=wuyxRAdOc9VQAvUMY9mwNJe6qRrAvIC7Dop5b+bfkuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PG52eySjSKPsXK6B53OcoUsqwENURKl65G+dPN/SoH0+yYbWLFPlLm2B1KbAbb0+xKkYzjrNIfUb8y/agy17AynknwrA+XQPiQ1IaXpC9ByalpZrirPKJ99eF5y3vorB3PudlODJwsxau1518T3fOzXQeHOSsKnx/+wxbnGH+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FSTAqWnF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B1A940AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755098217; bh=5RUQcbRdHlb0azK7oxd9N9h6sfjuy1kAQ4WOx5rNbI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FSTAqWnF8NnDLZ/xFwv+NxW0BgqckHqTHD7n+cyEpo4+LgzYJYiFTX0tMOW2MfaD3
	 fouO8zpGBnd8GAXCQoDuc1k9l8hrWH9zAXR6kUpCLiUmdi2igRUL1BtS+UvcqvJ7wQ
	 e9lsPYOORzg2lA29/rCBlu0HOnReanaRJFy4zzYiygaPVtz86o6cPF8h21Uo5c3p+R
	 wodEIYrPKGeTamcGD6iOWhSBkkvExTzf+3rBSE5prXQlF5vaFLS3XHa8UtxQLQ1rI8
	 vdYmnvk5eObUL1XVBMLGW3N5Rekgn/IagMcyZrZ7JCNfWY5M5ciljmPp+J6cN4Y9s2
	 PLs/ozFLB/pGw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2B1A940AD5;
	Wed, 13 Aug 2025 15:16:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 5/7] docs: kdoc: tighten up the array-of-pointers case
In-Reply-To: <20250813005334.31db20b0@foz.lan>
References: <20250812195748.124402-1-corbet@lwn.net>
 <20250812195748.124402-6-corbet@lwn.net> <20250813005334.31db20b0@foz.lan>
Date: Wed, 13 Aug 2025 09:16:56 -0600
Message-ID: <87sehvb6af.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> On Tue, 12 Aug 2025 13:57:46 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>>              elif KernRe(r'\(.+\)\s*\[').search(arg):
>> -                # Array-of-pointers
>> -
>> -                arg = arg.replace('#', ',')
>
> Hmm... if I'm not mistaken, there is(was?) a previous code that replaced
> commas by "#". Such statement is needed to catch some corner case.
>
> This like here is(was?) needed to restore the original arg string.

That (hackish :) replacement is still there ... but there will be no
commas in anything matched by the regex here, so the restoration is not
needed.  I can add that to the changelog for curious readers in the
future. 

>> -                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
>> +                r = KernRe(r'[^\(]+\(\s*\*\s*' r'([\w.]*?)' r'\s*(\[\s*\w+\s*\]\s*)*\)')
>
> As mentioned on patch 6/7, IMHO doing concats like that at the same line
> IMO makes it harder to understand. This works best:
>
>                 r = KernRe(r'[^\(]+\(\s*\*\s*'
> 			   r'([\w.]*?)'
> 			   r'\s*(\[\s*\w+\s*\]\s*)*\)')

I'll do that.

Thanks,

jon

