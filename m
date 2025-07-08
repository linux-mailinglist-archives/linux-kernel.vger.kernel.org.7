Return-Path: <linux-kernel+bounces-721715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53EAFCCFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F9F1BC355A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200C2DECDF;
	Tue,  8 Jul 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Pi6dSmZH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD426CE02;
	Tue,  8 Jul 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983833; cv=none; b=pXaICeUtlZtnAHyJnYs3NAGSEF0Vs7/swTnz+j4xqjjo+LIyiFO4NFim5FDUKcbmk18BXkLZe871R4z+HDipSFc0yaijzV2EzPBsaFaXXi9w2YmYIn8RTOUknDME6JgI6PmXxCMbKK004B6jbusb0u8C5m31OPcm0EJa6h0k9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983833; c=relaxed/simple;
	bh=x0g1b8qscEmMDvgCicLrsggSaHE11bJ3vQNSPjC8Fjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5ItaGBszcVlPglbBjhYyes+92Ibs66E0rFAxKEtzfrfRX72TVjnqKWXeftPI1fNMpdcZrzLFHQw7gpwRKwg1fKmu3YFIotsuN/+uzEAIjeVg7sjDhqT0GZe9erzuGTOuFUjPNkxTyEkjFM6kJjAaM3/t3uPFa8dWaLWT9rpTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Pi6dSmZH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3526406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751983831; bh=WnWNqI6r83IhcQtwKOvhrTukhJuq9eLTsWZfvRQ+lHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Pi6dSmZHEwqutatGA2z2dd28eiYt5g4XZY0SIWkkC2xnzvp1n/pnwOVN1FaoDrPRd
	 emgylqNwjt+kC2TNq+Gqrt3t+7Dkd3YkSj9C+W8cGsx/W/ZHUDYWgM23nYSiTBrhfT
	 K7WNTsHhPYrVJEJi/ZRRq+GB424VVFAZCijpGBZre1TD0LwtSAY1rqHTP9HcxGbOvU
	 QuDshKwn15X3olykUX3Q5YVMQnbMrLfh8SZ2Su5kWFt1J7Ox7isFJ3DJ9BcQoPMCHr
	 z828vbwhVJf/FwNQszEwqos/1YBQZlPyTZmPLQSLWwvuyHUYQzpXOBeug59kOWVn8k
	 pYAASGvPaCqhw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D3526406FC;
	Tue,  8 Jul 2025 14:10:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Mauro
 Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH -next] docs: kdoc: various fixes for grammar, spelling,
 punctuation
In-Reply-To: <20250707050135.2660457-1-rdunlap@infradead.org>
References: <20250707050135.2660457-1-rdunlap@infradead.org>
Date: Tue, 08 Jul 2025 08:10:30 -0600
Message-ID: <87qzyq6aeh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Correct grammar, spelling, and punctuation in comments, strings,
> print messages, logs.
>
> Change two instances of two spaces between words to just one space.
>
> codespell was used to find misspelled words.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  scripts/lib/kdoc/kdoc_files.py  |    4 ++--
>  scripts/lib/kdoc/kdoc_output.py |    8 ++++----
>  scripts/lib/kdoc/kdoc_parser.py |   20 ++++++++++----------
>  scripts/lib/kdoc/kdoc_re.py     |   24 ++++++++++++------------
>  4 files changed, 28 insertions(+), 28 deletions(-)

kdoc is kind of a moving target at the moment, so this patch doesn't
really even come close to applying.  Hold off for a bit, then regenerate
against docs-next?

Thanks,

jon

