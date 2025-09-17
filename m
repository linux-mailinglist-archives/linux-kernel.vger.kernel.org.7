Return-Path: <linux-kernel+bounces-820907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73AB7F9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CA1523FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CA3161A8;
	Wed, 17 Sep 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AXcZf2Un"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC0316193
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117082; cv=none; b=lKMkc/ruiI7JZk/lGVoVYZTqaYBuuitl6YlRfhyqdfCqOakKA/imLqKdVeVB3LEE1wfDwQGB5FpbZLxtvRfDbERwIhQHbcjCQTW1btvbuB8g5nHUPURrSbwoIKNXpZRHFJzwzQKzREWmNoS9e2XtJwm2RK2se8faopic/SqHcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117082; c=relaxed/simple;
	bh=9qUZT1crtWOUyoXXJQPP9NGJvBK9M9uYfI2FKUWxdrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ+YgDEfzO1JaHiUl8f4gbLCX5ixwx7adzgweQaWTN/N+EfAEWuDLsWDm/Wa1lTlF+av2Yj/SRKYlnaPkqGQ319V3o8HhXCnJWzbhd7TbuamFyrQskDVzKlvhz0Txc4DRA7kqYtaL5Pq0QMbnuJ8i1WsRAD7PuEqjUyYY9F+VnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AXcZf2Un; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b079c13240eso1082051266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758117078; x=1758721878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzslX0FAKCyHzwTYwPr7j8DXDFar2BwYpUuekbel1A0=;
        b=AXcZf2UnBLuwIlDUshwn6WFU9rx72byeRJ0ehBiSlDtYApLa5m+zxZRHCasQWSNuCi
         lnWwRAqYBA02kO7i+grK4GzTht/wUv/s8yuo2DMTLD4UpiN2S4sBzYihkKMkZEOyilGy
         Ir1aHhFAJzuDfgvqb0d6pZqr44A1U/JwnKuRIJhwh31PTBDXD7HoV3GLHSiwRswHqDNH
         5gqISLrQ9UjO6HNHx0Rz4V0R+WW1X0lDkLnaXjFk7Xu7xHOXzfzgWz8F0TEj5cKmnBqk
         xRJqyeHwx9vfE9KtniZjchj1J305Hvddd0CtXDzJ5qjogtabOZV4FjsTUyjnpeMqPH7G
         KmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117078; x=1758721878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzslX0FAKCyHzwTYwPr7j8DXDFar2BwYpUuekbel1A0=;
        b=jtheZiXx0zr8WJ06hA4vTBgrFRB2z9qHdNUDpONGQ4LFeXFdtNECV9NL9omfYzhVFm
         uy9A7BAS6y0y1ej4+1H3bMRwmR+TwNFAsm4OF00tbGScM8AeUXPkTopxWlFgBbVk6ktx
         mW7jChGgWbP/rjF1wQmqsIYZb9ARBMy+4K72KjgDXrNseM20wemVgGZQfIo5aITMFv+z
         k2kypMYGLHjZENLyXH/AshA37mMD+xAyM9446isQ7OyE9wtZFarQARFnJWLYa+ajEkWj
         qPOS0oUi32Uqv1o5I0+X26UQwD4u/6YKHETIgc4TYNsZXfoJqclqtdkq53zQW4IKHPA1
         XgPg==
X-Forwarded-Encrypted: i=1; AJvYcCV5o0t4g9pRZhXokNExXiZ9zNiwDrg3rTMVVIe5E4Eeg1cWuowrAXKmi1nt/XNXBfVRak5dE7T7wBK2QjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIdL8Rc7z6Ufj60cx53K2fCSYeE+NJNuCNW4IN84s2QD7gVA+
	zlGDrU0z2Efq9w6QIA4fh/mpGAa9FelXPiwX5s6T4eRc+RSfUZK4uVOG3ZGCt2pt0d8=
X-Gm-Gg: ASbGncsBPZ8rCF1xUh/CAhmn0aSsDYwsK0rBh7UxkrXbiTmS/im4g106yD7RfhYfS7u
	Y2TdgT1z+UmGs8jt/CkJA3Ix5ZrygLxGNr/0hNXJNYXeZxssciQ4WrEbItPc4r242MPfxxMeUMG
	0l4xFpeJSB9gz0U62YQOWYF0bJZbZ53vvH4wWR1dzRgNY+zVFpbFcpIGGFprd42A8WBZvmNo63W
	id1PdHZQNrEGNEh/05kR4ETUON4Uzi2p5BiALF1+KBdF7mKNdlmPmcpjh3XblF7PZayuHUeTJ8I
	cRfvAQUz3qzffcFEV1RzDRQU1jBnLv/B2Wjc+r7WWH/GRkH8YsOfVu5YXaMa/tNRe2TmOxJwsP9
	RAZknhn4+T9M6x/5L0rHX22QIog==
X-Google-Smtp-Source: AGHT+IGwu+AJb+gKhXwbC2yXSQf9ZU6BEokD8jxRPRis8SFvc9K+rEszxY1TnNayznY2p3lr0ZywHg==
X-Received: by 2002:a17:907:8691:b0:afe:ea93:ddbb with SMTP id a640c23a62f3a-b1bb8300984mr268616766b.45.1758117077953;
        Wed, 17 Sep 2025 06:51:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f054b5522sm8971375a12.19.2025.09.17.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:51:17 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:51:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <aMq80xcRtQbthDiT@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <aMl8xX9QCM9jslLH@pathway.suse.cz>
 <848qidw8ip.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848qidw8ip.fsf@jogness.linutronix.de>

On Wed 2025-09-17 14:53:26, John Ogness wrote:
> On 2025-09-16, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> >> index 646801813415..8c2966b85ac3 100644
> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> @@ -972,14 +972,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
> >>  	/*
> >>  	 * This function should never be called for consoles that have not
> >>  	 * implemented the necessary callback for writing: i.e. legacy
> >> -	 * consoles and, when atomic, nbcon consoles with no write_atomic().
> >> +	 * consoles and, when atomic, nbcon consoles with no write_atomic()
> >> +	 * or an unsafe write_atomic() without allowing unsafe takeovers.
> >>  	 * Handle it as if ownership was lost and try to continue.
> >>  	 *
> >>  	 * Note that for nbcon consoles the write_thread() callback is
> >>  	 * mandatory and was already checked in nbcon_alloc().
> >>  	 */
> >> -	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
> >> -			 !(console_srcu_read_flags(con) & CON_NBCON))) {
> >> +	if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_NBCON) ||
> >> +			 (use_atomic &&
> >> +			  (!con->write_atomic ||
> >> +			   (!ctxt->allow_unsafe_takeover &&
> >> +			    (console_srcu_read_flags(con) & CON_NBCON_ATOMIC_UNSAFE)))))) {
> >
> > The condition seems to be correct. But it is evil. I wonder whether
> > it would make sense to replace this with:
> >
> > 	flags = console_srcu_read_flags(con);
> >
> > 	if (WARN_ON_ONCE(!(flags & CON_NBCON) ||
> > 			 !console_is_usable(con, flags, use_atomic, ctxt->allow_unsafe_takeover))) {
> >
> >
> > Note that I have added the 4th parameter intentionally, see below.
> 
> ...
> 
> > It would be more reliable when the check was integrated into
> > console_is_usable(). I guess that you did not do it because
> > it added another parameter...
> 
> Not all console_is_usable() call sites have a printing context. That is
> why I only added the checks only to the actual ->write_atomic() paths
> that were possible via nbcon_atomic_flush_unsafe().

I see. But I still believe that it fits well into console_is_usable().
It is similar to the "use_atomic" parameter which depends on the
context as well. We could guess the context most of the time,
so that we hardcode the "use_atomic" value, ...


> > Or maybe, we could define @allow_unsafe_takeover via a global variable,
> > e.g. panic_nbcon_allow_unsafe_takeover. And it might be valid
> > only on the panic CPU, e.g.
> >
> > static inline
> > bool nbcon_allow_unsafe_takeover(void)
> > {
> > 	return panic_on_this_cpu() && panic_nbcon_allow_unsafe_takeover;
> > }
> >
> > It is a kind of hack. But it might be better than the 4th parameter.
> > And it would simplify few other APIs.
> 
> After weighing the pros/cons I think that a global variable makes the
> most sense. It will simplify internal APIs and provide all
> console_is_usable() users a correct value. And the end result is no
> different than what we do now.
> 
> We could also keep its setting inside nbcon_atomic_flush_unsafe() so
> that the variable remains a printk-internal variable.

Sounds good to me.

Best Regards,
Petr

