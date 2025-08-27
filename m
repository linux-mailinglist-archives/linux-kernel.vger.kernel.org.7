Return-Path: <linux-kernel+bounces-787699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE5B379F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761565E4E41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE130FF28;
	Wed, 27 Aug 2025 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="psL96GdM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544022B9A8;
	Wed, 27 Aug 2025 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756273314; cv=none; b=VGI21fu0p7S7oOAPwfPuP7Dfhxqjj8rveUry6s9+Y02IGzeAwH1XOCJ9E8bNm4gfly07MCB3LGMzgYd6fweY8vdBVFtNpn4O6HPxVo6oTI9HvMA8Vol/jjRkBLklIkcYKEs3azRf3CB/ntqJEaeEMkzFapFknqCpDaL1adV//SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756273314; c=relaxed/simple;
	bh=b6q9cCDu3HC3NYVsFNsvw0/99qTo9vtqisSmqkijYtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1rEXYZv3JTsDpA/ZzH9wq4ifMIzU/yjbf+Q8b/H0nIjrNudx3/DR9mr3ag03eeprL1/03tRFaswLqGS3oq9gawU9WZa9QFFIEhq2MNpTLgWc1R/0sygKleVmyMJCroNw0f0aMDhdrHvZ639ljiSZETgnd+z/YTeqRbAkfcHqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=psL96GdM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C619140ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756273309; bh=Y6z+kBjl0XBbufpDiwRSMUVdA8goEEeheytHFy4pCxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=psL96GdMwjIqfsiBoi+W6scJ7PL83t9o9e3c59ICPz2Qjo9gp5hhFZugDlrF5mcZp
	 6oUJifyexCOI6xek4gh7hZvhoTS6bO7ID90SyJAjBxcHWq/pgpY++j0r2uuuq9+G7l
	 OhOv6TRqq+KR5bEnz+QrOomwEG15AJrGFOB7Hg2VluQ+GLxSUJgCUKws2rjDQsObzC
	 +p9W/q40nr1O25uYupZKgcjU9A8T/e05ZaiwjdjmP2lg+uIqtD36MfKDg1CU9iu2od
	 bjJMz7b8rkpkG09Q9oS8QMkMQc+ki2peYyPc4srhqeVCdn5zMiLN8JBeDi4TuE1D1f
	 1r1D5vTYOqMmw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C619140ADA;
	Wed, 27 Aug 2025 05:41:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Jonathan =?utf-8?Q?Neusch=C3=A4f?=
 =?utf-8?Q?er?=
 <j.neuschaefer@gmx.net>, Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
In-Reply-To: <20250827044848.17374-1-bagasdotme@gmail.com>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
Date: Tue, 26 Aug 2025 23:41:46 -0600
Message-ID: <87wm6p9v8l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Management style docs writes on people under a manager, where they know
> the details better than the manager himself. Reword it so that it would be
> less confusing to non-native English speakers.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v1 [1]:
>
>    - Reword the confusing phrase (Konstantin)
>
>  [1]: https://lore.kernel.org/linux-doc/20250826003437.7695-2-bagasdotme@gmail.com/
>
>  Documentation/process/management-style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
> index dfbc69bf49d435..bb7a69e34ef180 100644
> --- a/Documentation/process/management-style.rst
> +++ b/Documentation/process/management-style.rst
> @@ -42,7 +42,7 @@ actually true.
>  The name of the game is to **avoid** having to make a decision.  In
>  particular, if somebody tells you "choose (a) or (b), we really need you
>  to decide on this", you're in trouble as a manager.  The people you
> -manage had better know the details better than you, so if they come to
> +manage most likely know the details better than you, so if they come to
>  you for a technical decision, you're screwed.  You're clearly not

I really do not understand what it is that you are trying to fix here.
The original may not be the best English ever, but it is entirely
correct; do we really have to churn the document for this>

>  competent to make that decision for them.
>  
> @@ -115,7 +115,7 @@ sure as hell shouldn't encourage them by promising them that what they
>  work on will be included.  Make them at least think twice before they
>  embark on a big endeavor.
>  
> -Remember: they'd better know more about the details than you do, and
> +Remember: they know the details better than you do, and
>  they usually already think they have the answer to everything.  The best

Here too.

jon

