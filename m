Return-Path: <linux-kernel+bounces-808394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB501B4FF34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09003BCF3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BD3431F0;
	Tue,  9 Sep 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L/dMcRVy"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B37341AA1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427688; cv=none; b=dEEnkAAOfDOT5Mbnyotx/1lElOprRjvOAdQBrzPYN7AVCTH+pnBqE8n4hen2oXDmnBV4/SINkeAlaWE+NPLbX3Q9ewWQlWlN2KdBbtBRHwUT8qBfOCrFC7QWJkKxE7CdqCFeiXo1QAjdncZoWMjYcG9/GkMiYWLiOSCUyEKPDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427688; c=relaxed/simple;
	bh=+0lHl1eMe/JD8H/r0p+Yc7NV3Bd6WAxWxOP8yyfTEEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmse31V7XWSh2yl4oNmLYmBKVR9Qv0k1o/WhpbRTPn0RjHEryPprpFMhrWpQ92z4iI/8U6ExBEzpsjzBRb1UxjCeOvP9mCmuIxl1x2VA7d3SKg/pUKElagi7jp4E2HeFR0+s25aS6PVogNSEZC3a61OnBSXI9z+OvxAfmkQG9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L/dMcRVy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b045d56e181so849909366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757427685; x=1758032485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9XzVsrF/2kVcEs9PtV7OlqggBEMEvqZHeycAS9T7Mw=;
        b=L/dMcRVyl1vNMk7JAAZacFRbJhgqHN/hV+sQiBusSbRfbW8x+zkps2CsUng2bq1e/+
         JBWJsufRp5abmXGfMc6FzEjfJZv0xxb3XSnjHtndl3hYOr+Be4fGjiQeSYPbqIpKzclg
         hRyiDIFhU94iDfRS7GI2K/dxnIizEKYG4F/xTLPL7pC4F4n1zZU7sdkBMxhjmir4Iraf
         aM6Whe2cdFzCRXoDRF+hVIRpEaoOtmfCSrVMnNR6WLThbWNmcSFLzEQJB2m2LiEgzcdV
         1hz/BJj0yhhYQCl/RF/azk2jWOZaXnnarpFJOerGN5xwJcf8pV0j5ZGmmxvypZSfU9sV
         BZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427685; x=1758032485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9XzVsrF/2kVcEs9PtV7OlqggBEMEvqZHeycAS9T7Mw=;
        b=wTVbGO7y3Cob3VUu8MgGfUxW1FglBiboQN3uBqkhBNP9U5sxIzilnaLs8mBG9UljaQ
         i9P0vrvES5Pi0J3+OfLhMU2eQlFqYr3Hl9YzMmJUQPh00ed2IuDzUQeJfjR9B5ieJxyq
         qzFBH13JISxBafmj2Mo/hbHfPsXf8Dy50kHisO8k6hqWEMJt2yw/p3AgOTbMdj7ZNXMs
         KsQARTDfhs1ef6bCQ43Tuf+r8AvwmDzLRWsU4gxz67ErxYCq7gOyn/LUQ/oohSGWVmvy
         VPFzUa1TG+FWmxQFHDkA5h9si9plG54SfjxX79d/21ZgOFaf4o9hnlPHuKhHFOcPnILK
         rhWA==
X-Forwarded-Encrypted: i=1; AJvYcCUoTmYAphzG0EY5oiBC5+6HLYkR1wYVVVnIOOMvt6CNHkTRgKD/eXuo4JzoeHqyANA5tNzABw1VwYmeaz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXu44v1weij2Jlt/vJdPGNdXsgWYVxmZYPCUbDmHpJpLBRC9i3
	EywWeJMe1DebGij6EYbHl3nyjbK+huAIpIAm2N8OqHCYH2J7EMpQy9v3OLY+tugqCd4=
X-Gm-Gg: ASbGncvOPRwvY2FrnvcQ3nRh4O31pWMlYoljVTnNfzr2EQJnBaiSUPQ+8SBThAXRTvm
	dm72MXDhtnbhn7Ym5+36ZaCFDQpa+N+y9W3Tl64Dg7IUyF4585dtZziA8w5LSFtKfRhOcIfxWlG
	HdqwSkWMWekStgB+ImdRebPdKeucKR7+v+AN/150l8q3k+kmsXamIAKAkDpme7aIEMu+Wf0GbAT
	un454LanhxAwq3lZvQknD8LgMvbXuDVWzu4qr3XeNxQJ9InvhJYeQlO69OOvVtzIsc7aexvNgdf
	p4svPnFaLvZpw4DiUAOv/aawczA6oeO9BdAlO8WIhk0BSOv5m0ZX5otAeemwiNtp48hEVPIRPNJ
	4UerwYGoMKpfjz/mK+5j14iYT9Jz7a9OGCMrz
X-Google-Smtp-Source: AGHT+IFVx676s5fDldPoppGP+0iD62Fg0ydmFsY1JlJe8Cg8op6tEbpehOmgYitI9uLDtJtauCQmdg==
X-Received: by 2002:a17:907:c21:b0:afe:a446:b22e with SMTP id a640c23a62f3a-b04b13bbf13mr1201532366b.12.1757427684927;
        Tue, 09 Sep 2025 07:21:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0466a962c4sm1591055666b.71.2025.09.09.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:21:24 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:21:22 +0200
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
Subject: Re: [PATCH v3 2/4] printk: nbcon: Introduce KDB helpers
Message-ID: <aMA34mPqHFC3v3Kf@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-2-cd30a8106f1c@suse.com>
 <aLsOBwV6CVBwG9JV@pathway.suse.cz>
 <84ikht87tn.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ikht87tn.fsf@jogness.linutronix.de>

On Mon 2025-09-08 14:15:08, John Ogness wrote:
> On 2025-09-05, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2025-09-02 15:33:53, Marcos Paulo de Souza wrote:
> >> These helpers will be used when calling console->write_atomic on
> >> KDB code in the next patch. It's basically the same implementaion
> >> as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
> >> acquiring the context.
> >> 
> >> For release we need to flush the console, since some messages could be
> >> added before the context was acquired, as KDB emits the messages using
> >> con->{write,write_atomic} instead of storing them on the ring buffer.
> >
> > I am a bit confused by the last paragraph. It is a very long sentence.
> >
> > Sigh, I wanted to propose a simple and clear alternative. But I ended
> > in a rabbit hole and with a rather complex text:
> >
> > <proposal>
> > The atomic flush in the release function is questionable. vkdb_printf()
> > is primary called only when other CPUs are quiescent in kdb_main_loop()
> > and do not call the classic printk(). But, for example, the
> > write_atomic() callback might print debug messages. Or there is
> > one kdb_printf() called in kgdb_panic() before other CPUs are
> > quiescent. So the flush might be useful. Especially, when
> > the kdb code fails to quiescent the CPUs and returns early.
> >
> > Let's keep it simple and just call __nbcon_atomic_flush_pending_con().
> > It uses write_atomic() callback which is used by the locked kdb code
> > anyway.
> >
> > The legacy loop (console_trylock()/console_unlock()) is not
> > usable in kdb context.
> >
> > It might make sense to trigger the flush via the printk kthread.
> > But it would not work in panic() where is the only known kdb_printf()
> > called when other CPUs are not quiescent. So, it does not look
> > worth it.
> > </proposal>
> >
> > What do you think?
> >
> > My opinion:
> >
> > Honestly, I think that the flush is not much important because
> > it will most offten have nothing to do.
> >
> > I am just not sure whether it is better to have it there
> > or avoid it. It might be better to remove it after all.
> > And just document the decision.
> 
> IMHO keeping the flush is fine. There are cases where there might be
> something to print. And since a printing kthread will get no chance to
> print as long as kdb is alive, we should have kdb flushing that
> console.
> 
> Note that this is the only console that will actually see the new
> messages immediately as all the other CPUs and quiesced.

I do not understand this argument. IMHO, this new
try_acquire()/release() API should primary flush only
the console which was (b)locked by this API.

It will be called in kdb_msg_write() which tries to write
to all registered consoles. So the other nbcon consoles will
get flushed when the try_acquire() succeeds on them. And the
legacy conosles were never flushed.

> For this reason
> we probably want to use __nbcon_atomic_flush_pending() to try to flush
> _all_ the consoles.

I would prefer to keep __nbcon_atomic_flush_pending_con().
I mean to flush only the console which was blocked.

Note that we would need to increment oops_in_progress if we wanted
to flush legacy consoles in this context... which would spread
the mess into nbcon code...

> As to the last paragraph of the commit message, I would keep it simple:
> 
> After release try to flush all consoles since there may be a backlog of
> messages in the ringbuffer. The kthread console printers do not get a
> chance to run while kdb is active.

I like this text.

Best Regards,
Petr

