Return-Path: <linux-kernel+bounces-819211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA88B59CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CD81B283C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730F37C10D;
	Tue, 16 Sep 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Tvbv5CIW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FA283686;
	Tue, 16 Sep 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038541; cv=none; b=WiVWZMG9/e/dFf3PUE/IdZNxXW20dQCCu9Z25y0iewBB/MaIej5LxaBm0ss9wL2KcIlA07IKGAuPbQ/6oQKLPtW5N9JkHl2hqPF5cwEpCnwzNQn+nPl7uM2ieMD+uqIxR7x4MbePKdLb9lo+MF5pIvfdADFka1pWBZHBQrH7hBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038541; c=relaxed/simple;
	bh=44GCQrg+RZIZttr3oabaJPgQXYKuuYWPt3yzuuUE7xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvQlC2j47hGgJcycQlTlymiHJ/7bsuBZqEyOd+mfqwh99CorZ6y1OW4VoQoJFlhw6XVt4pKvT0M8dnQhjYbf0pCRDLaitNz8ciHViSihyLYiWcAWXGskf4X9O2S8TKVk01dE+pDCdimAMQY7Z1/R17q5/WXOeQq8XhPIjG8KxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Tvbv5CIW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B453240ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758038538; bh=xH0MlYA0WK4YHbfdeNWzmmkyiGfpVhiVhqm/ok4PNaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Tvbv5CIWCBrLO9iaNpm0zDt7rqFPCZYjTcxmX7RGuuj3K4MZvv0I2TMxw+K4dMSSA
	 oZkALUfhvVuXPBUqIQjFMdSduxPYwNuUmCMHv/Uf13TWFakzApbWVgx/hgxN1D5G7o
	 sOTtONi7LatiLS78Yi5swHs26iDyJ5RxsqzBUUZpTetfeFmFpmuP23tHb4QoY52FDf
	 rxMDN/c6mpBOb2YobKtdaqVoou5JAGFfpX7dV856Z9CAtmgZKWr/caAjFwI4YRhKUV
	 rIfsa9uODTNF9QSxDgqyHNbK61tpl03Zpi0GldN5g0oBUE9mqfcm57OExvUd6o3VTH
	 myxhF+3bFLOpQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B453240ADA;
	Tue, 16 Sep 2025 16:02:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Akiyoshi Kurita
 <weibu@redadmin.org>, platform-driver-x86@vger.kernel.org,
 mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com, W_Armin@gmx.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: w1: ds2482: fix typo in buses
In-Reply-To: <208fa944-6aef-4acb-ba39-d351d364c53e@infradead.org>
References: <20250913173413.951378-1-weibu@redadmin.org>
 <208fa944-6aef-4acb-ba39-d351d364c53e@infradead.org>
Date: Tue, 16 Sep 2025 10:02:17 -0600
Message-ID: <87348mfks6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 9/13/25 10:34 AM, Akiyoshi Kurita wrote:
>> Correct a spelling mistake in ds2482.rst
>> ("busses" -> "buses").
>> 
>> No functional change.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  Documentation/w1/masters/ds2482.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/w1/masters/ds2482.rst b/Documentation/w1/masters/ds2482.rst
>> index 17ebe8f660cd..5862024e4b15 100644
>> --- a/Documentation/w1/masters/ds2482.rst
>> +++ b/Documentation/w1/masters/ds2482.rst
>> @@ -22,7 +22,7 @@ Description
>>  -----------
>>  
>>  The Maxim/Dallas Semiconductor DS2482 is a I2C device that provides
>> -one (DS2482-100) or eight (DS2482-800) 1-wire busses.
>> +one (DS2482-100) or eight (DS2482-800) 1-wire buses.
>>  
>>  
>
> Well, I'll leave that one up to Jon. The $internet says that
> "buses" is preferred but also says:
> "In both British English and American English, busses is a less
> common but still acceptable variant."

I went ahead and applied this, but ... this sort of change brings churn
for not a lot of value.  In general I think we can live with "busses",
so I would rather not see an ongoing effort to change them all.

Thanks,

jon

