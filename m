Return-Path: <linux-kernel+bounces-858665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2BBEB5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745BA19A4208
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C382F90C5;
	Fri, 17 Oct 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hlDGUH4b"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636C33F8B5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728473; cv=none; b=SERSJGjh5PWd2zM+S2zQj3bdX74/EKeWHtRJytwklIBnNc7VkQC7s/kw7GRHcK+Bxz57xBwlBmMxHsY4i4SVD/OXGfxlRH0YO6tCQxkF435ZOpJISDoIQb9y6QXfqGTGwwxUgZMpHxNHAaUyUQjjyPxDeyDoWSve6lAi5Z9AAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728473; c=relaxed/simple;
	bh=JK5OLU93mrjxeSOJc1IWuZBrU7i+RjK/PcSw/WDmNMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imnAST0klIg0AjH+u/BHLqw81Ri0O3f4Qk+q0u8PaC8eEoVTcOWcQMaWs2p6nTch/b5inNV/5I6nclYYRiUPtH7BypQ9erkGFri5Or29sWqgDAlch0cff07k+A0FFbdv7fp1bg6odXuvgXkhdTOJSpMfzTxVJQK52w2UlnKHIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hlDGUH4b; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 12C34C035A0;
	Fri, 17 Oct 2025 19:14:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A631606DB;
	Fri, 17 Oct 2025 19:14:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2F01102F236E;
	Fri, 17 Oct 2025 21:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760728465; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LlzN5dSavXopAP47hFEu5I5NgwE9saEWYUag5LC5xgQ=;
	b=hlDGUH4bVrizgVbUbOwMYpQe3OEleII36wWQlYIuEaVZRNrDCHol4+kjmoDBDVBuU1Ke1o
	j24bHClhtALgs3m7tK111B/rLmAGLrOAlwm+n3keEkXwhb67xmq64zWI8OVqZW8pzeaMvM
	In+C5FEDSJtRIsKkpIen7/UegjxohX/B4JtV/3LqG+TtBVzyVt7BBSFfDucxTR5KzVAvyd
	ydiLLWcTn8whin3YAGDZGWlyLQWroZL08m+o+nG7aXof7QvQh6ZhXthm0SYH6HDyBVXMYJ
	4/bliCEyi6SCVybzafT08j42AgK7y9kfRzuT2PMrGs9+ql69d+Q+S5Ioy8xe9g==
Date: Fri, 17 Oct 2025 21:14:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: officially expand maintainership team
Message-ID: <20251017191418c128591b@mail.local>
References: <20251017143302.1776953-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017143302.1776953-1-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 17/10/2025 16:32:26+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since Olof moved on from the soc tree maintenance, Arnd has mainly taken
> care of the day-to-day activities around the SoC tree by himself, which
> is generally not a good setup.
> 
> Krzysztof, Linus and Alexandre have volunteered to become co-maintainers
> of the SoC tree, with the plan of taking turns to do merges and reviews
> to spread the workload. In addition, Drew joins as another reviewer.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Drew Fustini <fustini@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> 
> Co-maintainers, please Ack, or let me know if you want any changes before
> I send this to Linus in the next fixes pull request.
> 
> Sorry for taking my time again after we had decided on this at ELC-E.
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9b16f619373..74a3002bb44c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1997,6 +1997,10 @@ F:	include/uapi/linux/if_arcnet.h
>  
>  ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)
>  M:	Arnd Bergmann <arnd@arndb.de>
> +M:	Krzysztof Kozlowski <krzk@kernel.org>
> +M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +R:	Drew Fustini <fustini@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	soc@lists.linux.dev
>  S:	Maintained
> -- 
> 2.39.5
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

