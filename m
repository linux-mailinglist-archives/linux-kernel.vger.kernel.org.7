Return-Path: <linux-kernel+bounces-757778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 725FDB1C684
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A337A5860
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FC28A41E;
	Wed,  6 Aug 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kIQRATFv"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE75FB95;
	Wed,  6 Aug 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485226; cv=none; b=Z2NVpVvgp9qs8Mg4nYldq1wFr+1Ak1bYT9wwz5pyriH1ZkAeGGQbcYtR6aIPCUQTZN2+Q11BuNVCCRTKynBMsLmi3IJdQbPA+/M7eq5tLEr6gDo+5gOsWjEbJU02/znAqIgKZsAVhk1CkvMRmgDgoX/ZpUzE1hSQfLynGwBCfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485226; c=relaxed/simple;
	bh=5dBsSFUhzpantvZNynZVlQp2rA4vTP7pUqhKRuQ2aqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IlB0eYXclZOyHLCEqEcYM+iJ0tgQXV7DxqXWRGb8JHHJ4yNUGmdblPrDBznaurVftO2YvZR207hqxDg2ZiVgRRGExdEj42Q3nXSsbZjjyWl/qWkYhKefxA+n/iwfqFRZXd35BGkTDdXgO4Eb1NHYNRhB97dwcsBCj2vif1UGWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kIQRATFv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4DD4F40AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754485220; bh=im7LLmwAt+qnrrIdtEWbBORzYEkTYFR5z3r9vPt2t1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kIQRATFvKHkvdsD3LzWuIoQwzOdnIFlx7S99tlZwt0LhqkTfEJlQVi0AOZ00ySugw
	 wo3840PtNlJsoEBCGBS8yVc2nDkQRu82swEfp6dG1D7J1H+5mFLwXzArHETUqh9AnU
	 UQylKM3kap6DPVneV9JbDk2T4NZJ+dx2baDmfNO5ig2GpV4LbbO0T93Fsp91T8hkRa
	 cNZsISTo3l1DtsNRycXw9KQ+aZk1ERGjALNluiCkrH9NHMFZ07YkbMAMrQ5RQk4Xdu
	 Bj6qm52zkJUtrZAZF0/3p/Hp+e1gUHNpnFQMEl2ZycMZNWXeL0AzXOjATTvlqwRbY5
	 otrhnNbQ4Ga2A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4DD4F40AD2;
	Wed,  6 Aug 2025 13:00:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members() cleanup
In-Reply-To: <20250806110538.35bcc127@foz.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
 <20250801001326.924276-11-corbet@lwn.net>
 <20250801080744.14f83626@foz.lan> <87v7n6pscu.fsf@trenco.lwn.net>
 <20250804151511.73ffb949@foz.lan> <87ms8djsjx.fsf@trenco.lwn.net>
 <20250806110538.35bcc127@foz.lan>
Date: Wed, 06 Aug 2025 07:00:19 -0600
Message-ID: <87ikj0k3ks.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> > Btw, on this specific case, better to use non-capture group matches
>> > to avoid those "empty" spaces, e.g. (if I got it right):  
>> 
>> The problem is this line here:
>> 
>>                 oldmember = "".join(t) # Reconstruct the original formatting
>> 
>> The regex *has* to capture the entire match string so that it can be
>> reconstructed back to its original form, which we need to edit the full
>> list of members later on.
>> 
>> This code could use a deep rethink, but it works for now :)
>
> well, we can still do:
>
> 	for t in tuples:
> 	    maintype, -, -, content, -, s_ids = t
> 	    oldmember = "".join(t)
>
> this way, we'll be naming the relevant parameters and reconstructing
> the the original form.

I've already made a change much like that (the "-" syntax doesn't work,
of course); I hope to post the updates series today, but it's going to
be busy.

> Btw, while re.findall() has an API that doesn't return match
> objects which is incoherent with the normal re API, while looking
> at the specs today(*), there is an alternative: re.finditer(). 
> We could add it to KernRE cass and use it on a way that it will use
> a Match instance. Something like:
>
> 	# Original regex expression
> 	res = Re.finditer(...)
> [...]

A definite possible improvement for later... :)

Thanks,

jon

