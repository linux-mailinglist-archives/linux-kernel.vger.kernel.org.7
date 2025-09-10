Return-Path: <linux-kernel+bounces-810019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC01B514B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5102C7ABE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7726F443;
	Wed, 10 Sep 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EvJBQClh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHZFRomI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA71D88D0;
	Wed, 10 Sep 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502042; cv=none; b=gfjS0XezdhM/CWGW4utz7gkWVGjtQOrA23mn656nYvouN30LjwoOKGMb8AeGYRpFCP6CUVCr0SLs+xRP1aoViEMo0HUpFN6KicvZotVOWWbxj/Us1tYuhWbYZVfaYqjt456Ien2D1SD8aXyOVpagYhfqAu6m6cvAG+krh/BF/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502042; c=relaxed/simple;
	bh=3q09RmMkWSHgrLY6p8anzbp6nCFALU1LtrNvIDZ55sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBCABuYJNa4qHojLKV/bv3NOGopXqPXEw/iBewk2+6AB84DoXK70QljSK6n5BdxJOreGckOkLOJciqxOzv9iN2EPHwndFaPIEF8qrUYc2P4B6J7RTKkerXSvAd9H4p7MyLzlBZhdWaiNQe/5u7RAOOwq4rSmD0+hmY5a0Kw5RK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EvJBQClh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHZFRomI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Sep 2025 13:00:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757502038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfzc87QdWgWMMWC+tnsO32jnctjxPw3Hh/HTjNOLmus=;
	b=EvJBQClh8of271fAFeiBu/IqmIcfIzE3oWxHKBUD1CuTVoKoDrW2B1QSUV6kem5LmRhjpZ
	Ij24VtscTIeLVjiyQpJQUuMkXwDEmNXKzIZ1sx9dk00G8h/Fv1c3jGKOiDDAG6Umxizrar
	cDFFdJV3xF9aVDKQSC1L3fAA2Dsf0NABf3oUj7eXP4W3KoC6txs44ixCi+kWfo8awSz6oL
	2/0GDeqDm1G+/sKRLR6OBDd3SCYRdFqsqAidSM2015CBi1+W34sxFOsv2Uu9kejaAm30XP
	9UXi3BnugKX7ElAhQralKvYk3uc+tdJJcp2irhekVprLGhEFlKPCjKaTGwjUPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757502038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfzc87QdWgWMMWC+tnsO32jnctjxPw3Hh/HTjNOLmus=;
	b=CHZFRomIn7JliWyt+7fTM31EUzmgbLZaVtgtJufg5ZiWQegB81CxSvChfsUGRNHyOAmEkb
	qjzkpOY1r/qn51Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] Documentation: update config name in real-time
 architecture support
Message-ID: <20250910110037.-QJ4Esqh@linutronix.de>
References: <20250910085859.47818-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910085859.47818-1-lukas.bulwahn@redhat.com>

On 2025-09-10 10:58:59 [+0200], Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 14ec35ff5786 ("entry: Rename "kvm" entry code assets to "virt" to
> genericize APIs") renames the config KVM_XFER_TO_GUEST_WORK to

This is 4843a45ef9fe8 ("entry: Rename "kvm" entry code assets to "virt" to genericize APIs")
in -next as of today.

> VIRT_XFER_TO_GUEST_WORK. In a concurrent development work with commit
> f51fe3b7e48c ("Documentation: Add real-time to core-api"), the
> documentation on making an architecture support PREEMPT_RT has been
> included referring to this config with its previous name.
> 
> Adjust the documentation to the current situation, and specifically
> refer to the new name of the config.
> 
> Fixes: f51fe3b7e48c ("Documentation: Add real-time to core-api")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  Documentation/core-api/real-time/architecture-porting.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Documentation/core-api/real-time/architecture-porting.rst
> index d822fac29922..3062cff0e5a3 100644
> --- a/Documentation/core-api/real-time/architecture-porting.rst
> +++ b/Documentation/core-api/real-time/architecture-porting.rst
> @@ -35,9 +35,10 @@ POSIX CPU timers and KVM
>    POSIX CPU timers must expire from thread context rather than directly within
>    the timer interrupt. This behavior is enabled by setting the configuration
>    option CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.
> -  When KVM is enabled, CONFIG_KVM_XFER_TO_GUEST_WORK must also be set to ensure
> -  that any pending work, such as POSIX timer expiration, is handled before
> -  transitioning into guest mode.
> +  When virtualization support, such as KVM, is enabled,
> +  CONFIG_VIRT_XFER_TO_GUEST_WORK must also be set to ensure that any pending
> +  work, such as POSIX timer expiration, is handled before transitioning into
> +  guest mode.

I don't know how this is handled here but if you would start a new line
after "ensure" then you would end up with smaller diff.

>  Hard-IRQ and Soft-IRQ stacks
>    Soft interrupts are handled in the thread context in which they are raised. If

Sebastian

