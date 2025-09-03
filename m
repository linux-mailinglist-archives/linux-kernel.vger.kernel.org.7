Return-Path: <linux-kernel+bounces-798881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE0B42433
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162315E085F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABD930AAB8;
	Wed,  3 Sep 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvdESYoT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZ0pLElK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06483074A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911550; cv=none; b=u0itozC2dVUmf3tecZH8gTJD/XFZt591HYgIDLnNBjH57W73Nd+Whkvqnf8D6VV5vQiGXpnXeg0w7RayuCb0KvUJmUCf/MLTmTT5yP663SC/R7oh0IAUuUJclmPLHmOU4oQbjj2SNtfq+AY/qQfR7NfFfxgrM75kZKdAqDr4rms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911550; c=relaxed/simple;
	bh=PW6jHR9+zX+ViK7Tgdt+U7jJMoIyJN4sK1F2Xz5gU24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8ikU3dcVsESvWyrw4d09jZOBwvzx8cFgCWMAbQ6S/dy4j4tCAA+DdqSXCWy0eukoaxAAqkNk2iNC0rnQuGwcjW/6QYfS6jl32LQn4O0qLWZDqnJEiwOx/b2gpEWEa+mA+H1Zb7GGYByycQqHDC+1/8ZnuwG/COhuRIWizyd4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvdESYoT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZ0pLElK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Sep 2025 16:59:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756911546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CVut3AfTWRze481ZKUx7S7RslYpJDeo5SsE7cVwThM=;
	b=YvdESYoTT5Mm4wZor3Nr4g8iEb52Rrus+e9kGSkubEBvg4fsF5GB7BhO6G8TA0aifMxfdq
	+96vultzFsMh34kvQJ8sPmqi3LXf9P7sHyfprn6ZzoV2i0j1kf3uee2RltgIJrZPmxzO5t
	NYt5kbQJ6cw213JvmzsMNKXOhD+VKt3goacWJXhvhvKWYzTUIdmB1lDc2a5LDA8Wls2ErK
	3HC+22zP96omAj1cQTzrP5v7sYXBrDu1Lb0l818oGa9+3SrgPhwdwhlOWwcu9PhKiXWE5y
	FK2ADKOIRk5a+2sZT3q28tEd/Jv9tukuv6/IEhLozsIfDNcB7s9e+7OAlegoqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756911546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CVut3AfTWRze481ZKUx7S7RslYpJDeo5SsE7cVwThM=;
	b=zZ0pLElKAksFr0Gof+otXBlIQsZS+nSMK8jUr2J/DDyNVNKGUL88A7z70fmr1kjwJJndIt
	E9PnQH/NLpVj2hDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
Message-ID: <20250903145905.r7Ak4Wya@linutronix.de>
References: <68b269e9.a00a0220.1337b0.001f.GAE@google.com>
 <20250830065638.6116-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830065638.6116-1-hdanton@sina.com>

On 2025-08-30 14:56:37 [+0800], Hillf Danton wrote:
> > syz.0.46/6843 is trying to acquire lock:
> > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
> > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
> > 
> Given softirq_ctrl is percpu, this report is false positive.

No. This can happen on a single CPU.

Sebastian

