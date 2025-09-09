Return-Path: <linux-kernel+bounces-807424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22858B4A43E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8BF4E5A07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F123D291;
	Tue,  9 Sep 2025 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAod9PKy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0JumJWy/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECD2367D3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404399; cv=none; b=sisb55PgBfhIEeXdVnGFnK8yo5EKUtVFVnhQ2sxX9KDCn1VQJqVZ6vN+3hQfWJ1ZH9rfOTI9w+d/00xtMjm0AxwXRk7s2iMCUP9h5RkoLn7k1TSSRYX/S2c2nyTkkB5tIWAppFZpmHQk+Fy4JM7cJwa77T0bhscsCFQwcVw4trw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404399; c=relaxed/simple;
	bh=T2lSFhfZdNz6Un5WjwTSq9/3LhiWQNRQNC+8u+butXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCJKQ0zinCtXxt5LAiKYN9g8hMEDKqEVf2U6exlSeQ9bTASJoWBQPzIYHjgh62PEq8RjeIAjFJbNL7HgO8xV0Bi5GqB48fnuAkPw41v5zR8rE35jV6NlH9tG+645KznMeXx8oXBMZj2JO/xeN2Gq4hH09T8x1wxIoTKiPjbzEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAod9PKy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0JumJWy/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757404395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/YV2Xs3MZWR9AfRGDhIN7j6fqwzuHQapoEFHafdQzc=;
	b=RAod9PKyn5r7N5VU7PHKl/DdKkCSqsRh9BjiNGRXJALPE5Fbq7ZoY6WsY0LUi/5x6BKekt
	fHzD8SPlyQOlAPfDqwcXklFGaAiapB+jhCEB7jk+yWIpBqp9Dza+Y0QklUBLgdDJmX5OJv
	DMCUT/fhISYcs2CV39g2A3y6onjyn9WvExmnBWOkNzzHXKALM9iFnUOO29dsY42TAigNXQ
	uNr7SDNSZZIoOg8V3XiKMjizA21kJzsQ6k2QiVPH1/EnGHhb0aZRfftqfEtQ7eclE9fqGn
	qWVdzaVxq2LMNrk1nGrzKJdthNAl8R5WmSQk3kZYitn5sZ0xGXdwwoxPrkKwFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757404395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/YV2Xs3MZWR9AfRGDhIN7j6fqwzuHQapoEFHafdQzc=;
	b=0JumJWy/2GJ+ND8AtHF1LAEJcfBl062EYNkFxgPGw6YgWvqgKpWDTSVq9M6Y3oqJZfP+oG
	RtrFQKyMERw2wuBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 3/4] printk: nbcon: Allow KDB to acquire the NBCON
 context
In-Reply-To: <aL702dMFPy2bvfkp@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
 <84y0qtdk99.fsf@jogness.linutronix.de> <aL702dMFPy2bvfkp@pathway.suse.cz>
Date: Tue, 09 Sep 2025 09:59:14 +0206
Message-ID: <84wm68jc45.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-08, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2025-09-05 16:58:34, John Ogness wrote:
>> On 2025-09-02, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
>> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> > index ff218e95a505fd10521c2c4dfb00ad5ec5773953..352235a0eb4a484caccf86d3a57d1a149218ecec 100644
>> > --- a/kernel/printk/nbcon.c
>> > +++ b/kernel/printk/nbcon.c
>> > @@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>> >  		 * interrupted by the panic CPU while printing.
>> >  		 */
>> >  		if (other_cpu_in_panic() &&
>> > +		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&
>> 
>> This needs some sort of ifdef CONFIG_KGDB_KDB wrapped around it. Maybe
>> it would be cleaner to have some macro.
>
> Great catch!
>
>> #ifdef CONFIG_KGDB_KDB
>> #define KGDB_IS_ACTIVE() (READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id())
>> #else
>> #define KGDB_IS_ACTIVE() false
>> #endif
>
> I like this. It would fit into include/linux/kdb.h which already
> contains the #ifdef CONFIG_KGDB_KDB / #else / #endif sections.

BTW, if there is such a macro created, it should be KDB_IS_ACTIVE()
rather than KGDB_IS_ACTIVE().

John

