Return-Path: <linux-kernel+bounces-817160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48754B57E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F174416DFB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2731D722;
	Mon, 15 Sep 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hY1Tmbvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4QWc4/e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615531B806
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945678; cv=none; b=niTPGDabTq7qWpJfGTKxadgsU5EB3GZofCauMWXzam/XbH95IpTdoivbiVyaAlEFJK7qHhpW2FUtnEytp7JU/XaG5yz4AzuzB59YfX+sHLdCZUjV/ZDYtmNTIOmFe3amRgdXlgetd45Lv1eMpqL23Ho/ZU3sVPosQr6qe4yleCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945678; c=relaxed/simple;
	bh=QDugyRpiixWt749N5GWxuUW+X50o9ET36r5Sfr95if8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ogc72kASWJY6j4We1BDee9IFeMB1NxsU8jtpDPdF/mtxnf2t3S9PPGt6tgyCJ5u8rLnUiwyYW3CHzGgMgaYJWNk7Kk4rko6bGgP7xtZ3AF+QkIDmXMO1liDxkpn0wAtvaiYgUlHPOVCf8XVunmX9IusPCN073+CMEB119UThe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hY1Tmbvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4QWc4/e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757945675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUHPQyb6JN+JZaV8GGp1HAR2CuDNiJ0vjIMBbkSi1wo=;
	b=hY1TmbvuTb8g989DKJXLIoAcysKUWwkc+MhB8xBI7TGbBTGwH10YMUh+AbVDc+9AG+cRcF
	5uTDwCuUoCMdXmOqTHDMtdgL+nVpsE6yA2vg+eFCyE0iT8yynFdEZeZ/yWnFUqIYnIL9ZD
	y0a2huGb8JO1ZskmT2yaKLOZu+uAcWgiHTwlZdPaCHrnOPUphIw6SzCdhRbSPUS6fQB6K9
	e2lrrn2yGMYeOZGX8ZYnFe3qkKFGDXXeO/FGUmx/HIOktQOLps1NXXhKiL4veCzySIcN6e
	NTEdcKfqunni2hujn2mfHq1Y2zyOeUupki0u+ogJsgX+t5+0yNtMLGl/F/ivTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757945675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUHPQyb6JN+JZaV8GGp1HAR2CuDNiJ0vjIMBbkSi1wo=;
	b=Z4QWc4/eqdwowyeosLFLPQeHzCqxo/CzYaqw9rHEyKkcLT15i+AO0I9DolKA/W6kHrxCaV
	ndxzfPlcZHVdV2AQ==
To: Breno Leitao <leitao@debian.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Mike
 Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe
 write_atomic() for panic
In-Reply-To: <74htjoj66srvussqvivbhlkdkj6lkm6ox4jdv2sedb4yzccdmr@sgzbd44mivfs>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <74htjoj66srvussqvivbhlkdkj6lkm6ox4jdv2sedb4yzccdmr@sgzbd44mivfs>
Date: Mon, 15 Sep 2025 16:20:35 +0206
Message-ID: <84348n9510.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-15, Breno Leitao <leitao@debian.org> wrote:
> On Fri, Sep 12, 2025 at 02:24:52PM +0206, John Ogness wrote:
>> @@ -1606,6 +1610,13 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
>>  		if (!console_is_usable(con, flags, true))
>>  			continue;
>>  
>> +		/*
>> +		 * It is only allowed to use unsafe ->write_atomic() from
>> +		 * nbcon_atomic_flush_unsafe().
>> +		 */
>> +		if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !allow_unsafe_takeover)
>> +			continue;
>
> What will happen with the "message" in this case? is it lost?
>
> Let me clarify I understand the patch. The .write_atomic callback are
> called in two cases:
>
> 	1) Inside IRQ/NMI and scheduling context
> 	2) During panics.
>
> In both cases, they go throught __nbcon_atomic_flush_pending_con(),
> right?

@allow_unsafe_takeover is only true at the very end of panic. In all
other cases, the ->write_atomic() callback is ignored as if it wasn't
implemented. That means it will rely on the deferred printing kthread to
handle it.

> Let's say that netconsole implements CON_NBCON_ATOMIC_UNSAFE. What will
> happen with printks() inside IRQs (when the system is NOT panicking).
> Are they coming through __nbcon_atomic_flush_pending() and will be
> skipped?
>
> Also, are these messages even deferred for later flush?

When the system is not panicing, CON_NBCON_ATOMIC_UNSAFE has the effect
of acting as if you never implemented ->write_atomic(). So yes, only
->write_thread() will handle everything in a deferred context. If the
system never panics, your ->write_atomic() will never be called.

John

