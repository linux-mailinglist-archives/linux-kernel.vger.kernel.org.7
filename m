Return-Path: <linux-kernel+bounces-807436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE70B4A456
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FF21898F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26E23D7EA;
	Tue,  9 Sep 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pir1gPcG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="633o4RpS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A223C4F3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404630; cv=none; b=Dls8C+Eu/XAeUSes+dL0EawqmSQmNhqdg1CP8E5gNvnek3hBTJDhhK9oU8HQ5x8UMT5YhFKvP1Tr4qciri7cd5mr9BvGPru6sScSSPkxI/JmUbBHFS0M4oLbsOidlb5a9sC0WT9Ya+VQEpIGn5Al9T/RfI21V8uWa6CJjWVREU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404630; c=relaxed/simple;
	bh=0bUET/lr+b46XXuC/GqehhkrDpeejef0DLMFaJbOR1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lk/Pe6PkjzZFdkjrqPSf/YLuYOFFZKOJaPUn3O7VoF0mLgHnULlizub6piUlOOSm8qlYK1K5vFigklRZwyCOi0srhektFI4H7fq8nXWQ2u+pXhMhZloZ7kCxh4GuiWTaRLMZ7Ts8sRGeEv2DmHfpg/LmnhO6erNNClmL0Ucucs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pir1gPcG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=633o4RpS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757404626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlA4fNeih3Yuh862kDvLzQfFmFoDZ1djlkzFIKbBwH0=;
	b=pir1gPcGIuy/zUO83ooLypux2Pokq5tlqGwL6Ruxaff1BdVT7P1L7b9wVsuEU2GQSWZnfh
	znaZszpwMIvUndwHgNI2Z3MWO8E3IoQag14zrz7YfJN15RkwxfEut79XgJGUjWPrQYkWJd
	r7YwAMs5co40OG+YZTQitJ3InvEc3p4Oa8N/UT2WEyuxswQlkCFtK5xGf05JAViNjN8GGg
	ngSjHq1eMIrN9fJUC9vNORfWreWrMDsDUNzdcmaqXi2hhzQuGhmObWjLEQFLBaWrTdTE/f
	sjKqyDhmBu1CWOrtwNaEms/MiutsE9D6x0xdu7xe1agClyoY6uko9kvTRvs3sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757404626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlA4fNeih3Yuh862kDvLzQfFmFoDZ1djlkzFIKbBwH0=;
	b=633o4RpSGY9ffnBY2DE7J3M9XmJxcJVm8kdqos4GNAGGqBwpJeW3m3Dtgg1fwYBSwIMulv
	Jdhm+5d/J9DjdEDw==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
In-Reply-To: <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
 <aL77aq4gZBsn4epT@pathway.suse.cz>
 <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
Date: Tue, 09 Sep 2025 10:03:05 +0206
Message-ID: <84segwjbxq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-09-08, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
>> > --- a/kernel/debug/kdb/kdb_io.c
>> > +++ b/kernel/debug/kdb/kdb_io.c
>> > @@ -589,24 +589,40 @@ static void kdb_msg_write(const char *msg,
>> > int msg_len)
>> > =C2=A0	 */
>> > =C2=A0	cookie =3D console_srcu_read_lock();
>> > =C2=A0	for_each_console_srcu(c) {
>> > -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
>> > +		struct nbcon_write_context wctxt =3D { };
>> > +		short flags =3D console_srcu_read_flags(c);
>> > +
>> > +		if (!console_is_usable(c, flags, true))
>> > =C2=A0			continue;
>> > =C2=A0		if (c =3D=3D dbg_io_ops->cons)
>> > =C2=A0			continue;
>> > -		if (!c->write)
>> > -			continue;
>> > -		/*
>> > -		 * Set oops_in_progress to encourage the console
>> > drivers to
>> > -		 * disregard their internal spin locks: in the
>> > current calling
>> > -		 * context the risk of deadlock is a bigger
>> > problem than risks
>> > -		 * due to re-entering the console driver. We
>> > operate directly on
>> > -		 * oops_in_progress rather than using
>> > bust_spinlocks() because
>> > -		 * the calls bust_spinlocks() makes on exit are
>> > not appropriate
>> > -		 * for this calling context.
>> > -		 */
>> > -		++oops_in_progress;
>> > -		c->write(c, msg, msg_len);
>> > -		--oops_in_progress;
>> > +
>> > +		if (flags & CON_NBCON) {
>> > +			/*
>> > +			 * Do not continue if the console is NBCON
>> > and the context
>> > +			 * can't be acquired.
>> > +			 */
>> > +			if (!nbcon_kdb_try_acquire(c, &wctxt))
>> > +				continue;
>> > +
>> > +			wctxt.outbuf =3D (char *)msg;
>> > +			wctxt.len =3D msg_len;
>>=20
>> I double checked whether we initialized all members of the structure
>> correctly. And I found that we didn't. We should call here:
>>=20
>> 			nbcon_write_context_set_buf(&wctxt,
>> 						=C2=A0=C2=A0=C2=A0 &pmsg.pbufs-
>> >outbuf[0],
>> 						=C2=A0=C2=A0=C2=A0
>> pmsg.outbuf_len);

Nice catch.

>> Sigh, this is easy to miss. I remember that I was not super happy
>> about this design. But the original code initialized the structure
>> on a single place...
>
> Ok, so I'll need to also export nbcon_write_context_set_buf, since it's
> currently static inside kernel/printk/nbcon.c. I'll do it for the next
> version.

How about modifying nbcon_kdb_try_acquire() to also take @msg and
@msg_len. Then, on success, @wctxt is already prepared. I do not like
the idea of external code fiddling with the fields.

John

