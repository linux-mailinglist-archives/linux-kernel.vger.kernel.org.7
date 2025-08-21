Return-Path: <linux-kernel+bounces-780616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F4B305EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D18FB00699
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058C3629BA;
	Thu, 21 Aug 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R7ga1qJb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000636299B;
	Thu, 21 Aug 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807492; cv=none; b=gdfrCusXrlqhlKHfxGLY8y8tD9zLerYJoeE5sKRp8xIuMILY/baJSixlEmPTP8uwzc8/9yS983VyhbT49xNOqqbDVeBfCzsascgKD/iZ9tZEzO6Nq1RJ13gEsfJbU5FRP400aaGLhRMLxLNBdr0c67WW8NxmZ1FmYvYPVDWhBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807492; c=relaxed/simple;
	bh=c8DsSrJaMnEWoX23jkNnLC7l/EoU9r/NMUCpOmQwdx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3rb9lVLrW7wWi09HIy7UlCpLTYeF+pIL8GE4oHPgZiHeVv2XaJnndNRl6dDtZCpT/3BFn6CZrbZKGneqHcTD0RX/+VQNh1hovtd1X/2phLDIyhs/gtFmluxZSxrq6MDJ8CsOj6SxYt8FfNz6U9MQp6KOsrdZSFY9JIjQCdxrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R7ga1qJb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3A66D40AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755807489; bh=L1y7dswyjIEQ5uiwA4dVswHTuGstruSKu9IMPlOfEdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R7ga1qJb4qvrSTghd1VS8VQ13x9q94khWTr4AC2roiKr6XmBfxQaqq1reRUxSOAIo
	 mvdP619YphXUm8uDkEQwrCYhnzlNH9HwIV92EI3LfFuTdgiiiICBqbJmnDNpzMQV3o
	 KkxrAKbGzs4HNRdQnTpARqr1jyGbfgQhyt2sNdbS8B+YZzl0oyHp1bKEhGyvzxIPuv
	 YBpvEZfToIIlGjhcJO0IIMBN3RCfGTnAzzMryrQu+KUFrFc6Gv/r8Jty4vGs3fTA4B
	 oIXTE0yAMuq6QmO9Phv0+H5zcs0kuqBaLTmn5eT+qgqHIckF33NgYviWRxlhhqoYY0
	 OmRbTtLmoyuYA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3A66D40AD5;
	Thu, 21 Aug 2025 20:18:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for
 sphinx-build
In-Reply-To: <20250821214308.08835b9f@foz.lan>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
 <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
 <87v7mg5ux3.fsf@trenco.lwn.net> <20250821214308.08835b9f@foz.lan>
Date: Thu, 21 Aug 2025 14:18:08 -0600
Message-ID: <87bjo8qvi7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Thu, 21 Aug 2025 13:36:24 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> 
>> > There are too much magic inside docs Makefile to properly run
>> > sphinx-build. Create an ancillary script that contains all
>> > kernel-related sphinx-build call logic currently at Makefile.  
>> 
>> So I am just now looking at the script and seeking to understand it, but
>> one thing has jumped at me that I wanted to toss out there...
>> 
>> > +# Minimal supported Python version needed by Sphinx and its extensions
>> > +MIN_PYTHON_VERSION = parse_version("3.7")
>> > +
>> > +# Default value for --venv parameter
>> > +VENV_DEFAULT = "sphinx_latest"
>> > +
>> > +# List of make targets and its corresponding builder and output directory
>> > +TARGETS = {  
>> 
>> We don't at this point have a formal coding standard for Python code,
>> but I do think that we should, to the extent possible, stick to the
>> rules that have been established for C code.  One thing I would really
>> like to see is in the comment style; our rules want:
>> 
>>     /*
>>      * ...C comments spread out with the markers on separate lines
>>      * like this...
>>      */
>> 
>> so can we do something similar for Python?
>> 
>>     #
>>     # Markers above and below
>>     #
>> 
>> I will confess that this matches my personal subject preference, but it
>> also brings us closer to what our C code looks like.
>
> Fine for me. Can I do such changes on a patch at the end of the series
> to prevent rebase conflicts?

Yes, of course - and I don't think we have to fix everything right away
either.  We already have plenty of inconsistent stuff, we can deal with
it in the usual manner, cleaning it up when we're in the neighborhood
anyway.

Thanks,

jon

