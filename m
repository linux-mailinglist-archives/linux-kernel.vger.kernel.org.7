Return-Path: <linux-kernel+bounces-808321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F88B4FE20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84FE3A4175
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8E340DBE;
	Tue,  9 Sep 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GWDYWPCY"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A302EDD75
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425721; cv=none; b=cu0LYTtA6ePieq2G/dwvZiP7TMO0rWZ+PKmb/CUxVAggQTDMn8oHXQYW66BHspDX3wtmpVn68dPbP8UChKUUMiwN8C2PXu2tzRNbCfXNxvB8WSYCJXy/p2iosb5ClA4KLFL9IYLXMzR8n2GQZQQEeKJ9y24sbJSB3xggCp+C78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425721; c=relaxed/simple;
	bh=Q/rf0hXU1P1k8eJegbrnRW6Jj+I4GLDmb1uP8AB9R9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwVsQ9ty4VNrzA/4NnDnzAjFP4NxbROBkMcHNyTl3khmDZArkvYOCDqPrL0uiUwf/pyjfm0xsaGUzoLsQjzpQzi6gydeuOJwMCnUcwGRByy72bdYsmIg22OTgFZJVtEkFMRn5U5s3LCI1jxNf3C08AfULRBew00lSD+XQhCuiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GWDYWPCY; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b046f6fb230so183031366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757425718; x=1758030518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wzdJUr2aAZ317oMLdDooM8ha31xvzXYVNa8DDq4GgnM=;
        b=GWDYWPCYSMt0LvVvX8eSaAGnJ/OvqCNAJYi7jbA3Zqgyd8O+pPbkx2lpHrqSAkddwp
         t6MUz4/4AbbLmO7+ePHeSqRVfZsIpMEmVb5dfo7WsKclHp9Xc2KAfN3kPnEK5ACu0b5Y
         L3cn+OcOb9/h0iXqomBKYDH9EzDtfOx1+lPoZASVs/i7MWSlzKa5wpApYzUNxOsx0s5p
         MIYrwTkDDaapsFTFjOiq+2Ot/IU7mrDCUekkwgKXQp3EZos7q75uRiI0mbs0ZS4FroO9
         gLHxBsx2wv9KlONV16N9Nmn8itftZN5FqcjlTsIUEf8D2kYxX3McYnJIj+0zOq2ze5I9
         +clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425718; x=1758030518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzdJUr2aAZ317oMLdDooM8ha31xvzXYVNa8DDq4GgnM=;
        b=XPlOTCbDw4cjbUrcHha23TiWyIBw5BCXNmXRXkfL60O19dHt8tdMj6HB36+iBtujdQ
         y3+aeMSmlkfAMhSoIIUwZVibOGc0Tu/GGtjG4DcS6uvyf8sBMkez5+Xca4QK6miJkURk
         8nvH7GeoxKhrAxCYhAixwRDWyAGJWFfQ2wqJq612k7Eylivcs/SoG4RkT2NLybL2a9yj
         1jnb5H3dX8mH2QyzQgdCcWeNw7RIZjF2e9gwKH7BY3JkZIDSQiZcvB9aMbsIjRhDB4jd
         fkYCoSytGdN457kVtkBMEfFc8Ibcp1rch7p4EFyp9MB8soHHen8edgbCJamgYu5+GjWg
         Scrw==
X-Forwarded-Encrypted: i=1; AJvYcCXN/BYUqjAyVaH2I5Ms6QHz2W1FFk+0OLNP2JFlJGkeVzqR4eYs1806coJ3+4Z+iXOavIPm5p4ZqdH88C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFS41lHCNwf9/Sz2g0sl892LKhck4ounK/6UsjK5OYql7Ij3HR
	y4ZRO/bf65Y0pL1x28WFXQloRvXln7W7XjhU4QzgkqjRMWQfnnacIsj2JctPrrmk6a8=
X-Gm-Gg: ASbGnctds6b/7MU7NG589pETAeB9ttRS/U/vlmYtaiatOz/mZBINYI098s02unp80bQ
	KTP5KDhAjxZt/d4K/JbAJBFFjPlotFTpJN9EQ/vYHZWGzZ/PGv/ko/zjwQgdHxHtpBi+QRGHpvl
	mz5sSOBEo3SMM5ujG0w3FYp6XiuGt9IAhKHJM4GiUm8IcgnJxJGXypaJNTQG346vD9pl1ZJUmNz
	8A1yYRe7Fq83gp33D5pKV5ra+7FAJW5HduHnT+wcGc7YxSvjgWDa7+se3jpN60JQGQQ9TfIo5J3
	hrtnPLmMUTizHQn2HGfyIQa8iJZoz6tP06R1z2cdoQi9+RHbKjdXtGYujzY7heH8A01TVoy9Pwr
	3kl9b/61bmdzoDUoguz2vEM4Wqg==
X-Google-Smtp-Source: AGHT+IHgk5tFhwF30rudU5mtYNqfAuQeHF11cAlAbcY+uYtRgicaAE41/MCIBs7pCIURzp5gb19rEw==
X-Received: by 2002:a17:907:3e09:b0:afe:6648:a243 with SMTP id a640c23a62f3a-b049307ef09mr1831123266b.3.1757425717645;
        Tue, 09 Sep 2025 06:48:37 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046af12536sm1492637866b.100.2025.09.09.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:48:37 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:48:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aMAwMz4vWC5u9OpN@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
 <aL77aq4gZBsn4epT@pathway.suse.cz>
 <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
 <84segwjbxq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84segwjbxq.fsf@jogness.linutronix.de>

On Tue 2025-09-09 10:03:05, John Ogness wrote:
> On 2025-09-08, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> >> > --- a/kernel/debug/kdb/kdb_io.c
> >> > +++ b/kernel/debug/kdb/kdb_io.c
> >> > @@ -589,24 +589,40 @@ static void kdb_msg_write(const char *msg,
> >> > int msg_len)
> >> >  	 */
> >> >  	cookie = console_srcu_read_lock();
> >> >  	for_each_console_srcu(c) {
> >> > -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> >> > +		struct nbcon_write_context wctxt = { };
> >> > +		short flags = console_srcu_read_flags(c);
> >> > +
> >> > +		if (!console_is_usable(c, flags, true))
> >> >  			continue;
> >> >  		if (c == dbg_io_ops->cons)
> >> >  			continue;
> >> > -		if (!c->write)
> >> > -			continue;
> >> > -		/*
> >> > -		 * Set oops_in_progress to encourage the console
> >> > drivers to
> >> > -		 * disregard their internal spin locks: in the
> >> > current calling
> >> > -		 * context the risk of deadlock is a bigger
> >> > problem than risks
> >> > -		 * due to re-entering the console driver. We
> >> > operate directly on
> >> > -		 * oops_in_progress rather than using
> >> > bust_spinlocks() because
> >> > -		 * the calls bust_spinlocks() makes on exit are
> >> > not appropriate
> >> > -		 * for this calling context.
> >> > -		 */
> >> > -		++oops_in_progress;
> >> > -		c->write(c, msg, msg_len);
> >> > -		--oops_in_progress;
> >> > +
> >> > +		if (flags & CON_NBCON) {
> >> > +			/*
> >> > +			 * Do not continue if the console is NBCON
> >> > and the context
> >> > +			 * can't be acquired.
> >> > +			 */
> >> > +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> >> > +				continue;
> >> > +
> >> > +			wctxt.outbuf = (char *)msg;
> >> > +			wctxt.len = msg_len;
> >> 
> >> I double checked whether we initialized all members of the structure
> >> correctly. And I found that we didn't. We should call here:
> >> 
> >> 			nbcon_write_context_set_buf(&wctxt,
> >> 						    &pmsg.pbufs-
> >> >outbuf[0],
> >> 						   
> >> pmsg.outbuf_len);
> 
> Nice catch.
> 
> >> Sigh, this is easy to miss. I remember that I was not super happy
> >> about this design.

I looked for details. I described my concerns at
https://lore.kernel.org/lkml/ZNY5gPNyyw9RTo4X@alley/#t

> >> But the original code initialized the structure
> >> on a single place...
> > 
> > Ok, so I'll need to also export nbcon_write_context_set_buf, since it's
> > currently static inside kernel/printk/nbcon.c. I'll do it for the next
> > version.
> 
> How about modifying nbcon_kdb_try_acquire() to also take @msg and
> @msg_len. Then, on success, @wctxt is already prepared. I do not like
> the idea of external code fiddling with the fields.

I was thinking about another solution, e.g. an nbcon_wctxt_init()
function. The problem is that wctxt->unsafe_takeover would need
to get updated after acquiring the context. And might be reused
for different consoles, ...

But wait. I do not see any code using wctxt->unsafe_takeover.

It seems that the motivation was that console drivers might
do something else when there was an unsafe_takeover in the past,
see https://lore.kernel.org/lkml/87cyz6ro62.fsf@jogness.linutronix.de/
But it seems that no console driver is using it.

So, I would prefer to remove the "unsafe_takeover" field from
struct nbcon_write_context and keep this kdb code as it is now.

We could always add it back when really needed.
Alternatively, we could create an API which could read this information
from struct wctxt.ctxt.con. But I would create this API only when
there is an user.

Best Regards,
Petr

