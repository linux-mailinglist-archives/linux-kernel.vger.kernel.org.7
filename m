Return-Path: <linux-kernel+bounces-810004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FCB5147E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8517188CF35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAAD3115A2;
	Wed, 10 Sep 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwUGstgs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gkv3pirN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DD2D5951;
	Wed, 10 Sep 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501498; cv=none; b=XEPUHGEcCS1McH6qhDIkNzjl46pKFn8khcw4lESBI5x+N1QtHAlMT9FyyUWgpQ8OJ/TAW53HmmOXJsmjew/DR2Z/n9gFkaLCBeEdQQG3mO68qIAq+uODDmhZPYynN3ncu0DsbbOzswQ/f+d4p7VXKAK36pHpid8irY6+4Zjte60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501498; c=relaxed/simple;
	bh=4/4TPh99l0DgXjNtIiFjYIeCWcK7mTfi6m3iGmYjCH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgSSJT5BulzV23b7uJ1965nxOwXUyNedeVDj7YF1IjJWXXogAkrpwoiNkBWY1fRGAygI/3UqKrMNqanfZ5vKzLKiGhUi+fZeL51C5wRnwSkV/29cdREmPpaUUwV3O8RgGRdgssey/LLLPA1sQjhzw4aLESF3mj1f9pCdevbqfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwUGstgs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gkv3pirN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Sep 2025 12:51:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757501494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PS1y10JT/ZWQAxSVC2nHn86zAzD2dArWPn28ZTzQ+Ig=;
	b=dwUGstgs5sgq8ddBjiH2Tno4uLV8vRbDhUfkhBQoFAz3/ybotKk5zwa4hT8kft91MjVQ6X
	7L+thLTjABcc/Doq/YY6j7EEw8GLSIB8bZYL64ruKuP1RSqF6LYq4REvJ5kOesoeKEl6FY
	CCDUMiRnqZuksLnMtlMiWdc5/i1OJmnQHfuqb2ZqmFx7L0I4tG4Gckh9aMDhcWl+k4TE/v
	beA/xcZQqfhgnvPy21hf2YIeUZUkQvsL0z+rftPKCtuSP+l4G21R2Em113oeRuGYMdoDCs
	8t6mhDkXFhd9DCMdP15vUo32+UUZ3zHQww71s1vMhFruN1fLL8tGYcXPywri4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757501494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PS1y10JT/ZWQAxSVC2nHn86zAzD2dArWPn28ZTzQ+Ig=;
	b=Gkv3pirN6os9pzyiCXRWvUl4DQsHVHKCfHMhw6KGtLTTsqsn0Gh+0DPxMd9VWMzb2AY967
	7UwWpgwaXYZFSWCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add doc files on real-time support to
 Real-time Linux
Message-ID: <20250910105133.e3XIjGDn@linutronix.de>
References: <20250910085635.47724-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910085635.47724-1-lukas.bulwahn@redhat.com>

On 2025-09-10 10:56:35 [+0200], Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit f51fe3b7e48c ("Documentation: Add real-time to core-api") adds new
> documentation on real-time support, i.e., PREEMPT_RT. So, add a file entry
> for that directory to the corresponding section in MAINTAINERS.

Guess it makes sense. Who is going to apply this given that neither docs
nor the tip people are on Cc?

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7175c38c6d1..e2782810d0e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21403,6 +21403,7 @@ M:	Clark Williams <clrkwllms@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  L:	linux-rt-devel@lists.linux.dev
>  S:	Supported
> +F:	Documentation/core-api/real-time/
>  K:	PREEMPT_RT
>  
>  REALTEK AUDIO CODECS

Sebastian

