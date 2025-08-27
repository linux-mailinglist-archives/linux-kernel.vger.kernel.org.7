Return-Path: <linux-kernel+bounces-787686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21AB379B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7217B0A99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A730F924;
	Wed, 27 Aug 2025 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zcRGjdEV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A223CE;
	Wed, 27 Aug 2025 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756271856; cv=none; b=JBolDQkrmIom8Kj5MPE1Ngn9njqU1BrMt+kz/7nx4DAKnA9Sk8Uvkb4buozd/uxkb/bO8yhM7b0eFO9CGMv7dUWHyw1Su7SXBn4xg1r46vA5lRtuqpGJTHahQZlV3qI3lE0qL2qQs+aR0sg5xXZTQWXq4/PB7nZq9qnGZVS44ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756271856; c=relaxed/simple;
	bh=hvUTIdURmwppgPaBNy9RGLO8fkSDdyrvhcQHCj/04is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgzoDOsnpjc056YRWb7rU9aEoC8Muufg1sbYkVvLxX46CMsX8zEF83C61etf1VT3pnmaKPU3NoPDTn4gKcoTF7xHMk5oBJ3t2tDLg1Qwn7Bi2ffaJOwRz5J754XucZIp73AjOrXIY1i0TOdkjSG1Pop7c94zNOX6KR+6hBhdlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zcRGjdEV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JYEj2SwXE01Y7WOdonk8/xJyOnDqigfYVLRo9H8olA8=; b=zcRGjdEV/5vKz0Il5P9+4ytwkq
	zPMZqZKEYMs0d7gq7xd8T+LnnLmjB7EKuGpCEWcXzbZNYWj8Y3KA89007RGarwrRXQiWR11g4+wtS
	mJEo4EmPFI5jXCEdIULhgDu/HiOzPz8MWWVlIo3312EsyjaaV56Lih9f3E7P8eHHYwUc395jNeeRj
	TBIglsZuFhGZYliX67bd0JwGBo2Vasi9mDNSFPCGE+G3Ry1IPpYnDOcslYroDZ3WNk57aSLlWuS8k
	JeawDNKxDYVUXImbmsjXWaXCck41wTIBFf6VAAmos1v8SgKVKEIhFOy7yHdeDkdggokjliB2pIJXK
	khJ05MAg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur8XM-0000000E65U-2JbQ;
	Wed, 27 Aug 2025 05:17:32 +0000
Message-ID: <e8a42b9a-7c0f-446a-bdc7-ac1a04b12a5b@infradead.org>
Date: Tue, 26 Aug 2025 22:17:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga <federico.vaga@vaga.pv.it>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Matthew Wilcox <willy@infradead.org>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250827044848.17374-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 9:48 PM, Bagas Sanjaya wrote:
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

although I would have said
+manage should know the details better than you, so if they come to

Anyway, thanks for the better wording.

>  you for a technical decision, you're screwed.  You're clearly not
>  competent to make that decision for them.
>  
> @@ -115,7 +115,7 @@ sure as hell shouldn't encourage them by promising them that what they
>  work on will be included.  Make them at least think twice before they
>  embark on a big endeavor.
>  
> -Remember: they'd better know more about the details than you do, and
> +Remember: they know the details better than you do, and
>  they usually already think they have the answer to everything.  The best
>  thing you can do as a manager is not to instill confidence, but rather a
>  healthy dose of critical thinking on what they do.
> 
> base-commit: ee9a6691935490dc39605882b41b9452844d5e4e

-- 
~Randy

