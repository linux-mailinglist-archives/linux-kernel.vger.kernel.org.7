Return-Path: <linux-kernel+bounces-794452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D4B3E1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6323B2B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345CD314A9B;
	Mon,  1 Sep 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AldRqYG/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470472147E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727200; cv=none; b=F+lMcx9kCqCn7Ki2otM3b2eulEfbCfIhNTMKQmbh8OnMMzDvlqbL5UeHIjTqLfGxws4MBLYN3dBgUvQtlyLVkoXaPVIKdfrE7bhVz+0n2KSEocbidQT7EfoFSkzITmeuLArt8GhNkAkHr/JB6mCScXjQ+JL29mE9REicJBGFvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727200; c=relaxed/simple;
	bh=T79HEf18/vhGMeN12oWVNeBc/m7QTshbMlzzBuwcClk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loOhNNJDp1PkGxpOztdrNuSP0xmtvSuG5Bhr020MlnPa4AiolVRTH7hFDZPuBpa/vw0h63K6SHDAr7BjJ2uCxXDcjYOGGXdVUUaDaQ4v79liVTflfWGEr8XCpMCAZE9LkG8+n7xTMSHtU8JOIqNzrLdWnI6JTyZKxmI0emR/FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AldRqYG/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04271cfc3eso131050966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756727196; x=1757331996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Si7cvIm4kT7iUcAsCjZQKkX2sBc3X7IbtKb4obfzTV0=;
        b=AldRqYG/3m6igJGiOauEK+XvZ47eOYZ/ygdOHXw4TsCICwvzkXOohsNNCtBpn43zBF
         h8+tOq6ZLo6UapW3hecRsdiwM3VaWdfxMHp5zU8H+rkYr6WZsBt7RMY6o+dT+OIdAHf6
         /rGZQIway0/YWFIs9yrdT779V7DXlrezW2BFIDWzx5eRb6jp+8FiuvlRoJ0CTi37jMMg
         C03L4YgQ2eTwP8/1J6JAAywOG681wmJZlLBOQgOCmMufwJ7fiKrn6Ao3u4sgpCsX7es8
         J7Dgz6TNzMISWLVVB33XnwuyMFEk1d7KWcOjW8lVyqy2LPkcZs+ycL7ryj7O5EqwHck+
         CgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756727196; x=1757331996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si7cvIm4kT7iUcAsCjZQKkX2sBc3X7IbtKb4obfzTV0=;
        b=RzjcrqE9b2JRrPCyButxZyu210jp+DgC8fHSqVjvyhr/fEgn+6OxMVcg31rRyUcDuK
         2XAS0OubHFHl3q2zv3Uh+UsNw4tK3tt85KPoDNZ4lnUILZIKmRO/wSc6lz9HKeQT4WnI
         btSJJYz5BYS5cyJc1ggoECIx+7WDb6xEy9UY60E4/0LCTcoGaN7iPfdMkb+a+r8hgxBT
         RI4FYxj8+b+ZHO+kocaf5tSQMvUHfn334dsOk73dqYBHS0UoI/g6RP44/qQO7BQlvgQQ
         bnYOIEhjB4HWHshfgcFBqlrIkrpAfwcP2aqq2H/XErESfApkny5mNGqAJ+3Oz19nVPtG
         hd2w==
X-Forwarded-Encrypted: i=1; AJvYcCX0/Yr5hAlb4RQEEKH0m1ktJ4gKlUgIZPzy3zu9kSv8aiJqaClT7hTz77/9BWWQ/7tATj9V03VGDvtQuHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSvZjK0uXgqNWaLAEUR6yUUhzgmr/hEhQp06yeb82W/JTX0fU
	sMxyssLkN521BQ0sYYVSvTsnkIDYoHuXKR7UM/a5lLMgsNvKUIlTwUtHSASE1BQcvuE=
X-Gm-Gg: ASbGncvlkgAFQvFEyTQdL6FflLVqqOf90YEHnA/Ue2grjodUnFSIWDbs7iQfeb803mq
	QYYEP4xSSHSoraXdB4nhwlas88i2Na2qZLAp9dkK6+tR4A5VDsWsbc0FVrp5600rSUb0c9nY0ox
	Zrfj1YXdf97jw03N2iWD7oQNgJCMcPG6LPBY1LG1AI8wyK6hGXOCyCJz2X/GW4coTL+mm3tDgbn
	+g7j5ejE/Z+DlPNdLMTX4FlmRWjZ6XsnYAOBDOQMLKDMhcynQnUyEXirOj9ltSU4GR0E8KvnecX
	dsGt58VLCejWseCdgI4y56rNT9tbJRk5pUb9jUL8YOfBN19YspTL9HOjAP11XocRueF7czOee/d
	TpZX9QG23LIG1kacyk+izhrSvrQ==
X-Google-Smtp-Source: AGHT+IHbKzQmItE4cLHCWx13xdJv9du020t16y4zprr2xxZrTa+24IeCY7LXgw7MT9KP4RXiD72KDQ==
X-Received: by 2002:a17:907:3daa:b0:afe:6648:a24c with SMTP id a640c23a62f3a-b01d9774b47mr737349166b.52.1756727196486;
        Mon, 01 Sep 2025 04:46:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0681aefdsm784277166b.8.2025.09.01.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:46:35 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:46:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aLWHmY9_I4rbV0wG@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
 <aJoAYD_r7ygH9AdS@aspen.lan>
 <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
 <84h5xukti3.fsf@jogness.linutronix.de>
 <aLGoBDapczoLH9-Y@pathway.suse.cz>
 <84v7m6gqsz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84v7m6gqsz.fsf@jogness.linutronix.de>

On Fri 2025-08-29 16:18:28, John Ogness wrote:
> On 2025-08-29, Petr Mladek <pmladek@suse.com> wrote:
> >      c) kdb_msg_write() also writes the message on all other consoles
> > 	registered by printk. I guess that this is what John meant
> > 	by mirroring.
> 
> Yes.
> 
> >> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> >> index 79d8c74378061..2c168eaf378ed 100644
> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> @@ -10,6 +10,7 @@
> >>  #include <linux/export.h>
> >>  #include <linux/init.h>
> >>  #include <linux/irqflags.h>
> >> +#include <linux/kgdb.h>
> >>  #include <linux/kthread.h>
> >>  #include <linux/minmax.h>
> >>  #include <linux/percpu.h>
> >> @@ -247,6 +248,8 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> >>  		 * Panic does not imply that the console is owned. However,
> >>  		 * since all non-panic CPUs are stopped during panic(), it
> >>  		 * is safer to have them avoid gaining console ownership.
> >> +		 * The only exception is if kgdb is active, which may print
> >> +		 * from multiple CPUs during a panic.
> >>  		 *
> >>  		 * If this acquire is a reacquire (and an unsafe takeover
> >>  		 * has not previously occurred) then it is allowed to attempt
> >> @@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> >>  		 * interrupted by the panic CPU while printing.
> >>  		 */
> >>  		if (other_cpu_in_panic() &&
> >> +		    atomic_read(&kgdb_active) == -1 &&
> >
> > This would likely work for most kgdb_printk() calls. But what about
> > the one called from kgdb_panic()?
> 
> Nice catch.
> 
> > Alternative solution would be to allow it only for the CPU locked
> > by kdb, something like:
> >
> > 		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&
> 
> Yes, I like this.
>
> > Note that I used READ_ONCE() to guarantee an atomic read. The
> > condition will fail only when we are inside a code locked by
> > the kdb_printf_cpu().
> 
> Neither the READ_ONCE() nor any memory barriers are needed because the
> only interesting case is when the CPU sees that it is the one stored in
> @kdb_printf_cpu. In which case it was the one that did the storing and
> the value is always correctly loaded.

Let me play the devil advocate for a bit.
What about the following race?

kdb_printf_cpu = -1  (0xffffffff)

CPU 0xff				CPU 0x1

					panic()

printk()
  nbcon_atomic_flush_pending()
     nbcon_context_try_acquire_direct()
	# load low byte of kdb_printf_cpu
	val = 0xff

					vkdb_printf()
					  cmpxchg(&kdb_printf_cpu, ...)
					  kdb_printf_cpu == 0x1

	# load higher byte of kdb_printf_cpu
	val = 0xff

Result: CPU 0xff would be allowed to acquire the nbcon context
	because it thinks that vkdb_printf() got locked on this CPU.

	It is not fully artificial, see
	https://lwn.net/Articles/793253/#Load%20Tearing

The above race is not critical. CPU 0x1 still could wait for CPU 0xff
and acquire the nbcon context later.

But it is something unexpected. I would feel more comfortable if
we used the READ_ONCE() and be on the safe side.

> >> [0] https://lore.kernel.org/lkml/20210803131301.5588-4-john.ogness@linutronix.de
> >
> > Sigh, I have already forgotten that we discussed this in the past.
> 
> After so many years, I do not think there is a printk scenario we have
> not discussed. ;-)

;-)

Best Regards,
Petr

