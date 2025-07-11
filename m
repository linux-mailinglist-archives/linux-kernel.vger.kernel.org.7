Return-Path: <linux-kernel+bounces-727622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E68B01D36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88822188FBC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05552D29DF;
	Fri, 11 Jul 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RII7gpEn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF4225409;
	Fri, 11 Jul 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239853; cv=none; b=UjXYEShOUt7JWUCHDlestist6dylfeA2858CObx3azQAjL+2c9glgTAcwO5SUAMKvZbfYaINw2WyLzUofbeQtyuSReoDt83LIPbYQ9BGZuIlUtnIRQXuwXjtEJT0e3pnceeEIFDk9ioGjf5G8/JI7yVMH3O9+RVC3fDAHX01TXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239853; c=relaxed/simple;
	bh=rV6tu2akD8A19pYQBOP8ifNXpul0uTEEMoKEuRrsdhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlD4Tm2u56MkKpmplNOT6gx9pEah6iqZwfzOZck8lkzShSM/nBVwHFwidU9cm+BYOXT9BUhKvJLaDVMF+ll6sx7NR8vYyWd5SjGdUymUnr/kV71A66/VdHxfulPFphKcgA7v43lYUfniu/+AbgctJw0SErFcMB6ZoUYCyKvFRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RII7gpEn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D606240AAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752239851; bh=ARpc4fa7w7O5A58ZzO2CUW0NoN9+vkN8quTh6fyMW9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RII7gpEn7X9r/vUOHEnUqNJ2vB4S2OpeypqPnB3OmlQBli2CkBbG9pDdbjPC5UgXk
	 i+A+cIebz8uTPMh1hrCkHCm0CaXVIK4gm/KEKTWbFDDkJyn+l5bhRJd26PjVkSgaT3
	 4D9mIDJT9+Z5ngE385OCUq5SaRPtbmkbVNqamiVzstogrGFFpfQXXi1V/Xprv4jNfx
	 HZYqoyZ9kZpQqLjuwplegE4qDFSlSATUXlJUlR9XaRdsb5FfUFGDZWsdh5bppg8h62
	 u1DzPXsZMw3s9Gb2wYMs1y+aqBvy373/ITJFqndOB+eQxhs2Xd5IwePet+A+LLoGb6
	 T+PN+xdMd6myg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D606240AAD;
	Fri, 11 Jul 2025 13:17:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 00/12] Thrash up the parser/output interface
In-Reply-To: <92ff26c0-6952-4f7e-965e-2f020adb859b@gmail.com>
References: <20250710233142.246524-1-corbet@lwn.net>
 <92ff26c0-6952-4f7e-965e-2f020adb859b@gmail.com>
Date: Fri, 11 Jul 2025 07:17:30 -0600
Message-ID: <87ple6x3x1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> On Thu, 10 Jul 2025 17:31:30 -0600, Jonathan Corbet wrote:
> [...]
>
>> Changes since v1:
>> - Coding-style tweaks requested by Mauro
>> - Drop the reworking of output-text accumulation for now
>> - Add a warning for prehistoric Python versions
>
> Serious review of python code is beyond my background, but I did a test
> on this against opensuse/leap:15.6's python3-Sphinx_4_2_0, which comes with
> python 3.6.15.
>
> Running "./scripts/kernel-doc.py -none include/linux/rcupdate.h" emits this:
>
> ------------------------------------------------------------------------
> Traceback (most recent call last):
>   File "./scripts/kernel-doc.py", line 315, in <module>
>     main()
>   File "./scripts/kernel-doc.py", line 286, in main
>     kfiles.parse(args.files, export_file=args.export_file)
>   File "/linux/scripts/lib/kdoc/kdoc_files.py", line 222, in parse
>     self.parse_file(fname)
>   File "/linux/scripts/lib/kdoc/kdoc_files.py", line 119, in parse_file
>     doc = KernelDoc(self.config, fname)
>   File "/linux/scripts/lib/kdoc/kdoc_parser.py", line 247, in __init__
>     self.emit_message(0,
> AttributeError: 'KernelDoc' object has no attribute 'emit_message'
> ------------------------------------------------------------------------
>
> This error appeared in 12/12.  No errors with python3 >=3.9.

Well, it does make it clear that things won't work properly with older
Python... :)

Seriously, though, that's embarrassing; I was clearly in too much of a
hurry when I tossed that last patch in.  Will fix.

> I'm not sure but asking compatibility with python <3.9 increases
> maintainers/testers' burden.  Obsoleting <3.9 all together would
> make everyone's life easier, wouldn't it?

That is pretty much what we have done, this was just intended to let
people know that they won't get the results they expect.

Thanks,

jon

