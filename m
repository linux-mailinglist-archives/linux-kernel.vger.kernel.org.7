Return-Path: <linux-kernel+bounces-755613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D8B1A936
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F204A1890D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FE285078;
	Mon,  4 Aug 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s+HuYPD1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE82248A3;
	Mon,  4 Aug 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332206; cv=none; b=r5mEgfWZsxp7Pp6uV5vsL7IAvw7pgPE23GFHVztJPwUqycc11KGJPUbyD4VW1blQeIztlv4DZnB0vgbhbaWKO1s8jM/HXqbfrEOvp5KmygDTxbCZGXpWTyuLYV03WUNSTJymYPF2X4fLC4Wnpvl7lXQoiDbLKmtDDu1MmeUGVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332206; c=relaxed/simple;
	bh=uJ/oOV5Bf1tX4cFJNMtJsUew/SY8AbI/2NnYXzLpDgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0qtgOk+gXLHrlxc6HyDjL2ZqI0u3cXv35JvHzbBgzfvTvv3YHA/XicVZUVgGxOZepE5FHCMA38kIYemNgrISsn1fOe/292j5m21zNlYm8BateIu+WF5ySAK8milsf2OdhdyQ/BbH8FbW9wZ2NlgR3NZqYvYA+a2cz9XZvjCwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s+HuYPD1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3F56C40AD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754332194; bh=HSp20fpXz0BSrhqJCgCQtB3PUB1/kgFx4skx2uINIgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s+HuYPD12YdNeaEApq21R4UvoWmAKZst50BTI+b0wym/Ve7yy4sxHMkU9xBu+vXQs
	 Uwy6QQFMZQ87Ys/LukWN0APBeLi3R4cnjUp0JGeSkkUSnZANHGsnTayqRyGl7mAx2j
	 erHiUPvWm/2QR0lC0PvrZ04unvR54cTBTwa+HWxtJ8pKIikgGzL4MB6fp8V9BCbuON
	 hns8HHcGb1EQsk2lJ4mPjtNQJh5WfpuCv+czoguKAy/dMmuoJ9crDmQbM3elMfiZu0
	 767w4QLaYceIcLc4A326yLmy+gCsVGARBguw6SPxBDH8Ntrmtqw1RWq+vKGnaFY+a0
	 87D7swpDZwJgw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3F56C40AD7;
	Mon,  4 Aug 2025 18:29:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 03/12] docs: kdoc: backslashectomy in kdoc_parser
In-Reply-To: <20250804180029.11b8c310@sal.lan>
References: <20250801001326.924276-1-corbet@lwn.net>
 <20250801001326.924276-4-corbet@lwn.net> <20250801062710.552dac5a@foz.lan>
 <87h5yrruki.fsf@trenco.lwn.net> <20250804145818.3cc73ca2@foz.lan>
 <20250804180029.11b8c310@sal.lan>
Date: Mon, 04 Aug 2025 12:29:53 -0600
Message-ID: <8734a7ndni.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> In time: I mean *possible* POSIX violations. 
>
> I very much prefer more backslashs than needed or use re.escape()
> than to read thoughtfully POSIX and Python-specific specific rules.
>
> Python, in particular, is not very reliable between versions - each
> new version comes with a set of incompatible changes.

People like to complain about that ... but the LWN site code has been in
Python since 2002, and with the notable exception of the Python 3
transition, it has been really painless.

FWIW, the 3.13 re module will warn if it sees a construction like "[[]"
- evidently there is a possible future change that might make "[[" mean
something special and new.  So I avoided that combination.

> In summary, if you agree with always escape brackets, curly brackets and
> parenthesis inside brackets on kernel-doc, we should be free of not
> opened/not closed "symbols" with is an annoyance at least for me, and
> we should be freed of possible POSIX issues and undefined behavior(*).

It shall be a mighty struggle, but I think I can find a way to live with
that... :)

Thanks,

jon

