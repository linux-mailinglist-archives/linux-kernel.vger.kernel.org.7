Return-Path: <linux-kernel+bounces-727578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC88B01C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3506F1C86EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183AE2C3256;
	Fri, 11 Jul 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WpFVBch9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF121B9C1;
	Fri, 11 Jul 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238169; cv=none; b=J3e82eaUppUDVoHu+dvhSmSz5UW3qcOgEwvkUYNW0HrJQHVaWpo0D0AYB0khz6GkD1VwN+XD6iwwFyCl0UNNMLhsGRoRdaNvk08S2s07WYXZrFQLIz+sKz6aesER/ceE8lgKQNjOtu2Q9Yhs1qCyfzaTu76dydY7k5EUgakgmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238169; c=relaxed/simple;
	bh=YTziMBo6Zz4b6KET/0mCEX/tuoaZSFsQV0TdV7/BMn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNaj1uiFsK6S0B79Z782x+rly5NYT2AhawsykCdGjBrXQ/f2IMtP9L1XEnByT6CZrwO9oPbdDPyP+l75kf62iPi3PhSoTybNMumbItp3eywZ1Qs1v2fwJ3e+4B0vEwQEn5oMuxBXXlrcisUFmmY7/pEGRWunYmLmPmjob5Dlsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WpFVBch9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2C96A40AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752238167; bh=Kc55KqYwq18TI19pEbR8Sxtaap5xT2NSPAaOxBvuKpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WpFVBch90ADTjisyJfVcZUfGcD/xni7eirEoHxAXqdyzC+eYt34gQ/1t8EmRKyPFp
	 2QdGXAJxbmI00hIeFdpTJELyzcAlt/TJeD89D7IsEtqvIBRGRLJ3GAgDaflzLS/UWp
	 IL1oTLbpAt6qjsuPqSuIyGlemoxuUwpl56tAknroJlJTf5Wi0qL5r8uOzxT/o2Jhhy
	 +O09+5WaUWEVEkHo+/wbQw7b7OY9JNKn4zDWSeC1iMLXQgMvRwF+/5GiFgOG5x6J92
	 WktznNuWw853Zl2QIUXl3ibmDrularsCV7+X4oQnDtGLKlZJ8xEyNLIlmfS7NnY+aX
	 s3vpANxXLhqRg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2C96A40AAB;
	Fri, 11 Jul 2025 12:49:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
In-Reply-To: <20250711081400.78731086@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
 <20250702223524.231794-13-corbet@lwn.net>
 <20250710084119.3e5c1ced@foz.lan> <20250710091352.4ae01211@foz.lan>
 <20250710101931.202953d1@foz.lan> <87bjpry67n.fsf@trenco.lwn.net>
 <20250711081400.78731086@foz.lan>
Date: Fri, 11 Jul 2025 06:49:26 -0600
Message-ID: <87y0sux57t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 10 Jul 2025 17:30:20 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> 
>> > With that, I would just drop this patch, as the performance is
>> > almost identical, and using "emit()" instead of "+=" IMO makes
>> > the code less clear.  
>> 
>> I've dropped the patch - for now - but I really disagree with the latter
>> part of that sentence.  It is far better, IMO, to encapsulate the
>> construction of our output rather than spreading vast numbers of direct
>> string concatenations throughout the code.  So this one will likely be
>> back in a different form :)
>
> The main concern was related to performance penalty - as based on
> the latest test results, Pyhon currently handles very poorly list
> concat (30% to 200% slower at the latest test results).

Yes, I understood that part

> Yet, at least for me with my C-trained brain parsing, I find "=+" a
> lot easier to understand than some_function().
>
> Btw, IMHO Python is not particularly great with names for concat/accumulate
> commands. For list, it is append(), for set it is add(). Yet, "+=" is almost
> universal (from standard types, only sets don't accept it, using, 
> instead, "|=", which kind of makes sense).
>
> Adding a function naming emit() - at least for me - requires an extra brain 
> processing time to remember that emit is actually a function that doesn't
> produce any emission: it just stores data for a future output - that may 
> even not happen if one calls the script with "--none".

OK, I'll ponder on a different name :)

Perhaps the new not_emit() could even be aware of --none and just drop
the data on the floor.

Thanks,

jon

