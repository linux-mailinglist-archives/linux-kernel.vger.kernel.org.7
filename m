Return-Path: <linux-kernel+bounces-868639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C80C05AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E65FF35C3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1151C305E14;
	Fri, 24 Oct 2025 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5m97qC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5ZhHpHM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E431D6AA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303147; cv=none; b=gRXF/8/ac4x0rN+54z8Xs5JDN4RCLIfI/FWaqjtkRzxAJw5KUdWz5dVHFOXCuSk/XcPAZ63ZInFXYJ/ikx/H0jtFZRhrEuxNOTG8XP12k/CLdHnJo8E33+pYSdcnqN42sYkZ87Wgbpy5ekfaogJT84fMUfXWvTbxAbJj1pajZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303147; c=relaxed/simple;
	bh=oR9fr4/cj1v98n5y9lWOkrmcH2Vx7fCTx7V15NnfFsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPCMQWRcIasXLgL7flOQ2eO/LQ0d0cNCAOCk5I77e8PdDCPBt+YiLVK8/sBWV/Hglh+dH93j79twfcBMwkwaSiTrGRmE0jFHCX7bRszCOHO6ck8g/5QT2LJ1OLs/+Woh6+dDXe/zXGMw6gYRw6SbL3RIqnfEx821SIORUs2KYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5m97qC/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u5ZhHpHM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 12:52:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761303143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjAhEWMmIoGnnfhEzLQEZHmdmHxc7Bd3jy4l8L0fvyM=;
	b=T5m97qC/Hb6qYcst+b+1S6xA/goxk48d0iasq5rIFxkG+43q+TsCy1j+lInhGi7pz0PXDb
	Tvi2tE8o9vKhADlfr9/A4EhMgKpVRxE9U4sWxcp5smikFftD20mCZ4tNCKaACBBaq33HgA
	j7k+7NozDVPVQwd/U/TRzKq9d893V9a9MFM2DQdaX8VTEakerBIMvZwsYvb8Z5efwN9fJH
	ARKi2+l0g+6BLskG5aN+PTe7lbgq5+f/Af813/zEaF+LnX88OOVWMxh/Pwbj1ioPWPeIKj
	z4pKUZvC+21cmwngplT6gw9glLogUUcUy0nxRvQbYLZXw2LJX7A8Aqq6xlVIuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761303143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjAhEWMmIoGnnfhEzLQEZHmdmHxc7Bd3jy4l8L0fvyM=;
	b=u5ZhHpHMO2cXf+T4Kt4odPK1y0NvoplRLSsZWX7vajdzSxhkgkiwkn/beo+nsp7edsDAAG
	S6eYTrfn6mEDZFDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251024105222.RZPI5xWT@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <20251024104055.GE771@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024104055.GE771@redhat.com>

On 2025-10-24 12:40:56 [+0200], Oleg Nesterov wrote:
> On 10/23, Sebastian Andrzej Siewior wrote:
> >
> > On 2025-10-23 12:32:34 [+0200], Oleg Nesterov wrote:
> > > printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
> > > CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.
> >
> > Could we please get rid of CONFIG_PROVE_RAW_LOCK_NESTING here? This is
> > lockdep internal implementation and has nothing to do with printk or
> > anything.
> 
> OK, but let me ensure I didn't miss something (again ;).
> 
> I mentioned CONFIG_PROVE_RAW_LOCK_NESTING in the changelog because if
> CONFIG_PROVE_RAW_LOCK_NESTING=n, then LD_WAIT_CONFIG == LD_WAIT_SPIN
> and lockdep will not complain if spinlock_t nests inside raw_spinlock_t.
> 
> IOW, without CONFIG_PROVE_RAW_LOCK_NESTING printk_legacy_map is not
> really needed.

This is correct but CONFIG_PROVE_RAW_LOCK_NESTING is kind of a must and
should not be an option. This just verifies what we have in
	Documentation/locking/locktypes.rst
and this is not an option.
As I explained it earlier in this (or other) thread I removed it and
brought it back because on non-RT architectures spilled warnings and
people did not want to apply a larger pile of patches because "it did
work" and "I don't use RT" and I have so much time available for
arguing.

It is not an option architectures which support RT. It is one on
architectures which do not support RT so they don't have warning and may
debug & fix them if they want to.

> Oleg.

Sebastian

