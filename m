Return-Path: <linux-kernel+bounces-817665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC26B58521
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2155203D94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7427F163;
	Mon, 15 Sep 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxe8twKU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxZvutuy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFF1E9B1C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963390; cv=none; b=VH72vfl2aR/azRw3jhuxydSJjrg/KQi+i5+UqGQIgPBy5+DPtr5C2mz9rlGUb6olrmYAu5hiTZUYJgcKZVpW97rl844GlAeEmt1WBT5Vs0otO+sQHz4YjRQi47YqMaHYAlYLJ4fF4xmTZhF+4/pAKaxoprPCWnWMoBfgniLOYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963390; c=relaxed/simple;
	bh=rg0sLfTUnaivB4AoCCPKFFf1PE/J9OdsE3i8nd47VAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pbe0ruttMAjs47EZU3LRfJBPi1/ddDMEimSmkws3WYZLyJFHn2v0JvxHzp4h6R9i5es9UsaYBuu1BIU+DmbCpvXQ2DWcjjwKnWkySxg7evVZxL9eQrEQRwQXiQjxk4CCLIsmrKXILzUyNNI8n16qq0qUaFfSSrEoLkJuh4Jc0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxe8twKU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxZvutuy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757963387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rg0sLfTUnaivB4AoCCPKFFf1PE/J9OdsE3i8nd47VAk=;
	b=mxe8twKU+DFctBL4mNnuDrHLCnDCREgyHC2eN2OG0DDFxn+YICdn82hNpyYPA9feRqlLqu
	gV70YtgTNT+KXkujguizxxFU1LDe3wpDa1KM2lJ/jDoJvyzfmDvsz+mWbAM1SCP7rLITl/
	/xUtSxFQDhU3SoqhGP7GP1NJjBEJGSHJbh7YkmrhQZ965d94i/EaXbvSVXe7fXAJGWR2rs
	th4O2j4yhG9jdVxhjNkzyAjvxR7mKgGjCuhhe/bvPpqDT9jhsd/lKnloWXiKm69p7NcpxV
	zCF2XYUZ/H04h3trGh9kQ+j+oMTq4kJrYnLk6J7Wdv8UF7tUevQOdDOvCJ7g4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757963387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rg0sLfTUnaivB4AoCCPKFFf1PE/J9OdsE3i8nd47VAk=;
	b=TxZvutuykKEff0k45B/Tv6vfhnCd+1PAa+xEmT5aALfl173z4qcXE5oW5UeHY/IpOUv4oZ
	chWC90n1ZrBMxBAw==
To: Breno Leitao <leitao@debian.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Mike
 Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe
 write_atomic() for panic
In-Reply-To: <i6qgd5wcdl5gkwfc6cru2hnokcsawdd4yzez2i6klu54uxwx23@jl44kdpph3t3>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <74htjoj66srvussqvivbhlkdkj6lkm6ox4jdv2sedb4yzccdmr@sgzbd44mivfs>
 <84348n9510.fsf@jogness.linutronix.de>
 <i6qgd5wcdl5gkwfc6cru2hnokcsawdd4yzez2i6klu54uxwx23@jl44kdpph3t3>
Date: Mon, 15 Sep 2025 21:15:46 +0206
Message-ID: <845xdj8rd1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-15, Breno Leitao <leitao@debian.org> wrote:
> If there is a printk() inside an IRQ and the host is not panicking, then
> the message will be deferred to the kthread, which will print through
> ->write_thread.
>
> So, from a user/netconsole perspective, assuming the no panic
> (allow_unsafe_takeover=false) all the messages will be transmitted
> (always from a thread context), even if the printk() happens on an IRQ.
> So, no message will be lost.
>
> Is my understanding right?

Yes. So you will always have a safe context to write from (except in
panic, where you will do your unsafe code).

John

