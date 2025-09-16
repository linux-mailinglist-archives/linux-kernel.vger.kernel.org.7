Return-Path: <linux-kernel+bounces-818757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84FCB59615
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F8518839C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D230C616;
	Tue, 16 Sep 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPAqw8wV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FsgF4lV6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD630C365;
	Tue, 16 Sep 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025414; cv=none; b=kW+yl6BXnTeiuGwgpp+LurGNJMr+Pr7doksS6SIdcwqLxEbtREaL1/8CUui4VKV+P0pHJMSLDuK79WCz6oX1TV6GGW4ZmHCVkw3Ibtbrv1ZU4AbAzc91vMX25lfzqPJuiDtPy4IUORsIE4pHqFwnWush/QkYER4NklDWQWaUP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025414; c=relaxed/simple;
	bh=RLCgcEz9U2n5S1W5t2iRA2VOSeKLjuQTZkTLxEXOzDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6oF4KPbi+Lzr07RBreart5a2p5dvxO+dijc0jcfojd7ek0h7DHeVwRlfvoJY/qMVnVA6CRrslmQJNz6FwNW+B0fnm2eCCJbb5nvN4WwVBfVhRgc+LYFQWALrWlfCoUqPPtyZMUHqTVallyyKHVYBHfFFrMnNnj7pP2XKiLZoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPAqw8wV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FsgF4lV6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 14:23:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758025410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++K6FgctVgLpdC/U11hAdp7fRDnE69jEmJOIzyqcLgE=;
	b=dPAqw8wVqTPs+OLamKZNR5YmRcPuYzoQrVCX/ix7vQ+PtQ0YonPdcsaRm45aYmJC7pz12H
	IuZ8LPcgxomtLzNqMfL1JN7Xgix7mCAH7VlgFuiY85LTO1PfjazKw4aVU3QEIC+R7ToBHW
	y0JskukJlo2jb7FTBxPTYCilbgRKeaYgd6utSXoGM5uTh0ANOVlElU8JYeSlOdvkL4IfKR
	yaLkfuKeHi0vUWXYIoECLNT4B71R7SyzKXALBs9DAsBZoonatldAmfSVMuFRNbRDRkq5yw
	bt8Y3HMtqFQ2VK+sNfmqNxcb0ZIays8hy4NcsNDLOGjrQCeHkKwOWuV5iUhQpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758025410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++K6FgctVgLpdC/U11hAdp7fRDnE69jEmJOIzyqcLgE=;
	b=FsgF4lV6siGCUK1ZD6Ja88G9K3BTciKf2XHZbhfnvm6eSNYrSshiP002Y9B33aB6GbtrTB
	W/P9dmh9ed/cbeBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, mingo@redhat.com, perex@perex.cz,
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, x86@kernel.org
Subject: Re: [PATCH] ALSA: pcm: Disable bottom softirqs as part of
 spin_lock_irq() on PREEMPT_RT
Message-ID: <20250916122328.IAZ6wvY5@linutronix.de>
References: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
 <68b2406a.a00a0220.1337b0.001e.GAE@google.com>
 <20250904102056.YCByXJXj@linutronix.de>
 <878qiutsdu.wl-tiwai@suse.de>
 <20250915152851.-ATGMKhp@linutronix.de>
 <87v7li20me.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7li20me.wl-tiwai@suse.de>

On 2025-09-16 11:43:53 [+0200], Takashi Iwai wrote:
> I applied now to for-next branch for 6.18.
> It's already at a late stage for 6.17 release, and the issue doesn't
> seem like an urgent regression to be fixed.

Sure. Thank you.

> Thanks!
> 
> Takashi

Sebastian

