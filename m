Return-Path: <linux-kernel+bounces-867260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE69C02138
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F323A4B50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19D334370;
	Thu, 23 Oct 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kd/0WRab";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ycdq+jIG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47133344C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232277; cv=none; b=fdS8AAX36m3NdVXM6ufTcfpTi2cTJHgqX4G72GN5eq5lhi1vCtj1AyldsZIF/SdUz/HbAkk7ljFx9UVB4v2p7IOE3nV+EPquG4CUK609yKd8y+UlWJpm1UzKeM2vvSV/qcPklSXYNMQsMVcu4nEppGZQQj383bA/VDBYuiA6+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232277; c=relaxed/simple;
	bh=5dwU6i5sitLr16Z9Isb9fR4BLIpTXcDlO9qOTy+GlQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBUvGjDgAij62uzgmcBhJBhbZYgcFQ86YWhDGpc3N5iIiom+PznDrSEWGnVHzh72fJNu0TK7ryUtp+crJa5ULdHxsElJtGAv4d4G1Nq5W4OdukwOsXV1aW3TMCoqJe3Ik3y7lQH699NEQkgDjPHU7yI+TL8QhGYxZA5RiaHIsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kd/0WRab; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ycdq+jIG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Oct 2025 17:11:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761232273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tevRDzSxVSNJnZIlEmVhPn2v+oCYBqON7T1YAaqgrg=;
	b=kd/0WRabwkk/N3bm3iRYrZc0VAWdWmwukTqUTus+xw3Z+CQtIp42WoIHkz+ChwdqoM8cEX
	kriNqTAnFwoSdR3u9IGNzlD9dThNm36E+bL0lOFPHNWqaiKome2c7Les5u+5nt8vNx8AGD
	0MmOnQ6GLRGD8JOUr00tLdqOc5J9RYe4ze09BCAnOFn3aZeSil/KkZlPusClcHacq581Nc
	fG1dnlRaHVSnbn/xZbo1BmzEACSjT1oZoKH0DYM+uITUedawh6kj243iiT5nccIF66Xwdh
	TWCeZnGtecY930ISBqZal99z3IWZAZFeEf0Hdc4RtD3MBp+bvb9duDMpON/mhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761232273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tevRDzSxVSNJnZIlEmVhPn2v+oCYBqON7T1YAaqgrg=;
	b=Ycdq+jIGFpPAovK7f5TQpHL/RH27Ra5/QWk5meeN+/gacNcFJvqg37JaVi9FUl8j6auM5r
	WJ9+LVranOg69pBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023151112.goqBFQcM@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm4lbqt2.fsf@jogness.linutronix.de>

On 2025-10-23 17:12:49 [+0206], John Ogness wrote:
> On 2025-10-23, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> @@ -3016,7 +3017,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> >>  static inline void printk_legacy_allow_spinlock_enter(void) { }
> >>  static inline void printk_legacy_allow_spinlock_exit(void) { }
> >>  #else
> >> -static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
> >> +static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
> >
> > We could use this lock_map_acquire_try() directly but okay having it in
> > one spot with a comment might have its benefit. But _why_ is here a
> > CONFIG_PREEMPT_RT? This is supposed to work in both cases. Should a
> > legacy driver be invoked on RT then the comment is not accurate, lockdep
> > won't yell but we still have CONFIG_DEBUG_ATOMIC_SLEEP making its own
> > judgement.
> 
> With PREEMPT_RT, legacy console printing is forced into its own
> dedicated kthread. At runtime this is checked via
> force_legacy_kthread(). So with PREEMPT_RT there is no need for special
> lockdep trickery. Once we can get all the consoles switched over to
> nbcon, !PREEMPT_RT will also not need this lockdep trickery.

This does not matter. My point is that there no need for this ifdefery.
You say: This might get the nesting wrong but it is fine because the
outer lock should be this. This does not hurt if it is also applied on
RT. _BUT_ on RT you don't even trigger this path so this ifdef is not
needed.

> John

Sebastian

