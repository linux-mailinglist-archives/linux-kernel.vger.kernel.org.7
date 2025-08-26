Return-Path: <linux-kernel+bounces-786088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CDB354D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC3D1B621B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08BD2F60B5;
	Tue, 26 Aug 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQiZBbWD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5C1B4223;
	Tue, 26 Aug 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191267; cv=none; b=Y/239iJuhGeJF8dbtWfVvyBcGWRo+XdUBO1azblTBNKpsRzzDNnuQbnDI1zCJVXiCUbqCUjHOeeg3YSlnIYQMsxtNiH3BEKCv8y9865khv7jh3tFPunPtBM7xdhk/feeWV/e611kqPDNQo+qtKcJhoRKMZf9XF+7KGoXFhe0CeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191267; c=relaxed/simple;
	bh=GCXK9lBQxnpvP4CS3fac4UgL43PEtRvfp2/tBi5BrUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz7ByahBguz9hQ5kBF81X1fLkGABQmfJDIPJqxcLEKtLvyZUL1waqHbg0iBI+lYEy8DsVworGeCEVPFWM5t7N+16dmD2wneCigeRoN0YK+bi0dfO4tm4Fg2bZM4/Ee86NFnIbmTqNpjNlM1jjo+B8Rf32wQubA7JbZVyhMgDbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQiZBbWD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0yW+8sLG9IXtlq0I3N5zxQoGTczv6TkhG3cqXiKZ17w=; b=nQiZBbWDkRktGbLzVRD7OhGhIQ
	l3kBlUnbfStBlWa9HI8J87e/hUGTNPGpoTRv3+f02oaSvtzFVlX4AtJXihBWadiBg1s/o7i5O8Z/N
	Yljl9vrgGex8Dd1PDwUR4bp30VVsAssMEHK5o48ihUA2UO40dXYOolRe5dXCbGhd96W6R3k1S7gEs
	RwBBWzk7sIRh8KTqRX3SAdEblAmjQCwe4ii/wfmhVeuXf49xZDvebLvxwX8U1uGnY7pExklAe8kX6
	BWwE0rPoHmARrie+DdlcpZTZRpJYve1kw+3C/AD29sYDj5AMJKsnAZzS6sDw1kU57KxneO7CEJ28N
	EZASG/rw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqnZX-0000000AlSF-2P3K;
	Tue, 26 Aug 2025 06:54:23 +0000
Message-ID: <67d355fc-7ee9-4203-9578-095004c4a7e6@infradead.org>
Date: Mon, 25 Aug 2025 23:54:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Fox Foster <fox@tardis.ed.ac.uk>,
 Federico Vaga <federico.vaga@vaga.pv.it>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250826003437.7695-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/25 5:34 PM, Bagas Sanjaya wrote:
> Management style docs writes on people under a manager, where they know
> the details better than the manager himself, in past perfect tense. Yet,
> "know" is in infinitive form instead.
> 
> Correct the verb form.
> 

Hi Bagas,

I don't know about the patch description/argument/justification,
but the wording makes no sense to me...

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/management-style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
> index dfbc69bf49d435..1381b253b19ef4 100644
> --- a/Documentation/process/management-style.rst
> +++ b/Documentation/process/management-style.rst
> @@ -42,7 +42,7 @@ actually true.
>  The name of the game is to **avoid** having to make a decision.  In
>  particular, if somebody tells you "choose (a) or (b), we really need you
>  to decide on this", you're in trouble as a manager.  The people you
> -manage had better know the details better than you, so if they come to
> +manage had better known the details than you, so if they come to
>  you for a technical decision, you're screwed.  You're clearly not
>  competent to make that decision for them.
>  
> @@ -115,7 +115,7 @@ sure as hell shouldn't encourage them by promising them that what they
>  work on will be included.  Make them at least think twice before they
>  embark on a big endeavor.
>  
> -Remember: they'd better know more about the details than you do, and
> +Remember: they'd better known more about the details than you do, and
>  they usually already think they have the answer to everything.  The best
>  thing you can do as a manager is not to instill confidence, but rather a
>  healthy dose of critical thinking on what they do.
> 
> base-commit: ee9a6691935490dc39605882b41b9452844d5e4e

-- 
~Randy


