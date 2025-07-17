Return-Path: <linux-kernel+bounces-735913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DFB0952A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A838160DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE65219A9E;
	Thu, 17 Jul 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h4LCTFDU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540981EA7C4;
	Thu, 17 Jul 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781685; cv=none; b=Uo2A2JgZ8dxow0Jmm4Mlt9EcwhBsJ6NyECPbrveuYTO2xiLzT3rrJYhGQc9XMSoJQNoxHuBYXrXoBZgHymW0Wyzb+eeYqsp7YLlTwmGS4wKGja8qCxYYWpyjFilERlp+v84WOCfZ6hduthr7IYiag7/uHfkLfrcequrU5sIrWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781685; c=relaxed/simple;
	bh=jfcX+nAQ1g9x9UNiL1LvB59jAPOxCrfZsnsiAu+Uup4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLPsDKuZqKg33Vz90mfPQ55LG6x9HBLfhRWJJBbeR3Y9aTPo4LRMQAdccu6jm3xUrUhi4Rxw1B7XJBcAYNf3paL/vnrj7TkfU+nrcJoVpmgmY4WU/S6m2Sq0kWIcNJ6g7vEj+IRcMN4q8JDUphbpdWvcCBc4fJ5Xh1tJiZ6XlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h4LCTFDU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 33DEB403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752781683; bh=1nMsYaewTP75F6cPx64w1E1JC5eBf5XCECpn9t1Blns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h4LCTFDUc74DSqic/Qpu+lnYQNUnUqV+O8FAWX1BKHrGs2ZS8G6Qk0mhoEIuIBkwy
	 ynlfpUSSuxqZ7TpkDCGo/G9UMQQ+wdkE8qI8zTqpR7WQnL4/9Q1lJYoLFIaPP/YqFS
	 Z/lSE9rdtVhoqNjkLE7qqA+0FDEX7m9F07cMEnmeYrtpWaH1NdKDvTGeECdiFc/iiz
	 dzvsGTAjTbY3Oq9+XQyBGkVRpByJrHtR68gS99VvOneIQaGAGGOoxInM7mQO7zFDyl
	 ErXq1aN67m7EH0vIh5cPWduIJgXGvNgmK7J93Gp023mJ/IY0sO2aqU/KleVOGnydUl
	 2TQmlKj9bqrVg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 33DEB403E1;
	Thu, 17 Jul 2025 19:48:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH] docs: kernel: Clarify printk_ratelimit_burst reset
 behavior
In-Reply-To: <20250714-docs_ratelimit-v1-1-51a6d9071f1a@debian.org>
References: <20250714-docs_ratelimit-v1-1-51a6d9071f1a@debian.org>
Date: Thu, 17 Jul 2025 13:48:02 -0600
Message-ID: <87wm86a9al.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Add clarification that the printk_ratelimit_burst window resets after
> printk_ratelimit seconds have elapsed, allowing another burst of
> messages to be sent. This helps users understand that the rate limiting
> is not permanent but operates in periodic windows.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index a43b78b4b6464..6f8d3935147da 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1099,7 +1099,8 @@ printk_ratelimit_burst
>  While long term we enforce one message per `printk_ratelimit`_
>  seconds, we do allow a burst of messages to pass through.
>  ``printk_ratelimit_burst`` specifies the number of messages we can
> -send before ratelimiting kicks in.
> +send before ratelimiting kicks in.  After `printk_ratelimit`_ seconds
> +have elapsed, another burst of messages may be sent.
>  

Applied, thanks.

jon

