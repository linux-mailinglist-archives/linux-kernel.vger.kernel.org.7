Return-Path: <linux-kernel+bounces-799988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32DB43213
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F9D165E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F3246BBA;
	Thu,  4 Sep 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3mF1Nr5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTa4MJJO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570551A23A9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966371; cv=none; b=XjUvnNdOkDw3NTBNMaqxUciCbFSLYKFnKsmQ9U7t4jDeL+uBxCeqM8FXUbkBFjm/zn7COZ5K5/EmecR796DZKGWBZ7/pp06lZe4G1PwmVrmnSuAY5PUNmmOuJeV3LgDkFoa1ErIJCevOgmlmtf/MoFGL6dTQm89I7SeqoXAgrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966371; c=relaxed/simple;
	bh=T2M5y5iMBdFOk0EziNCklAQ5vJkE7v8Re9oP1RjijIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL0ouPpCw84eh/xe4ThljjYtI887Hxu6vy9pZfDipQYfYwI23GBZ52Jl7vnlowkdEfmFHm3HH2J2i0/pFzSrtNHG0vfWBSKX0OQAvMquWhz6ouqnVGhF9skx0fpYq1h+9YtYz1SbVNQsrer6XbIDPEREHqp6tkfy8KM5/68M3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3mF1Nr5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hTa4MJJO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 08:12:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756966367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WeOH+JVqba84dXKrauDtj8cgh1+G+Z0Etd6YWsUVtLI=;
	b=L3mF1Nr5efzsm2ttbOUUDu0Ptqnk9D6e2Hqj26ORwJnRos2Yj7dzvxgSbQ/+NrWeckd4Gl
	RNZ9buNAb/Nl/8yy5BOE/Mfw3sGjGAtrsZJ8g/yhdr1si5jU3RqCumzbwBACk/i2xR7Zhi
	FjoSCAV8qCQP3mfsSGte0sOA2j9a5oNNHKLbWnhEQWizC+0ArVh2aK3GPds76pVxR43X4b
	6bQpud1nzq4zLV0nZ94DvdBJL2e759Dn/ZubJJxndWSaGta9i/Nkoi+heZxYgBIkqNBGew
	x7ceOjPSVLzrmgDmPofLbCNIt2QbddJMAVac+uWCASD34ohV26moJQMMGFbIjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756966367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WeOH+JVqba84dXKrauDtj8cgh1+G+Z0Etd6YWsUVtLI=;
	b=hTa4MJJOP945AHUb8R7x3iU5Wh8FMAG2OQ0ha2ZnOAEkXEruMGRy/oPpeA+sEvT7zCi8o9
	2Y12+yNGJZiACTDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
Message-ID: <20250904061245.pqGf3VwT@linutronix.de>
References: <68b269e9.a00a0220.1337b0.001f.GAE@google.com>
 <20250830065638.6116-1-hdanton@sina.com>
 <20250904010529.6410-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904010529.6410-1-hdanton@sina.com>

On 2025-09-04 09:05:28 [+0800], Hillf Danton wrote:
> On Wed, 3 Sep 2025 16:59:05 +0200 Sebastian Andrzej Siewior wrote:
> > On 2025-08-30 14:56:37 [+0800], Hillf Danton wrote:
> > > > syz.0.46/6843 is trying to acquire lock:
> > > > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
> > > > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
> > > > 
> > > Given softirq_ctrl is percpu, this report is false positive.
> > 
> > No. This can happen on a single CPU.
> > 
> But the single CPU theory fails to explain the deadlock reported.
> 
> > > >  Possible unsafe locking scenario:
> > > > 
> > > >        CPU0                    CPU1
> > > >        ----                    ----
               Thead0                  Thread1
	       ------                  -------c
> > > >   lock(&group->lock#2);
           preempt to ->
> > > >                                lock((softirq_ctrl.lock));
> > > >                                lock(&group->lock#2);
                                       <- preempt to
> > > >   lock((softirq_ctrl.lock));
> > > > 
> > > >  *** DEADLOCK ***
               now nobody makes progress

Sebastian

