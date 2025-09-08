Return-Path: <linux-kernel+bounces-806258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C9B4944C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579B43AA7DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741E2D5929;
	Mon,  8 Sep 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XH1nzpf6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B02B9A5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346673; cv=none; b=kfB/ob/Fx2DYUBuOyjb7r26qp1zxxqhkdLnTe+ukxK+hLkWxdPEPXqSx3d9mJlEXTe9j6YeuB1/MNsHsNOU/Xx0Q6ueZepzd3W15LlYRqHqTtiWRXEPLPf0EGed/2BIlzGEr4sKtLclg2usaI1+0h5InCkmuYtqq+CjXgikSft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346673; c=relaxed/simple;
	bh=/Nm6jYIFmzk8YLJ2/CqPL7z9rZmueM4ITfckw4f0daE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK0gPrLLczRPYk9cOBqivRV9ZSudwKKxNDsmbtQP9ZDqifxTupzum2CeXY8cFvzG7ODt8JpX5FgJXOr1ncXPUWkN60bJW0v7xXhuhX6ZAzyZ9FF18XgRrD+hsyst+m6c0Gj02yq0u18bBKPk2L8PA6mIti6+Dfbb2pgsjIeT6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XH1nzpf6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so5526589a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757346669; x=1757951469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSVWNylrScXe1y62XnvPM0BOnL0/TLepz30BeNFntlY=;
        b=XH1nzpf6UuUXgCFYhtRStEwqAS2xtCSILXjuE/Fxts+F3kyuIDDY2VKD6VmwQ0g2ZI
         zQ4d6GW9Sz+hRYVi1timBZIjoRNU8IoXUTnITXlwZcy8UXNBLFcEzYqAXC9Z2gi/O4id
         XShcYUs9fyl+u9LM4BM0C3fGrZBuQBJpXT3ufOsOAjNZqYMeznUO31EQatkRmkScoagT
         gYoJt8+aSaQTiD/oqNrQL4vJspQGgEIJgT3BN406IBQqlVECEutX9cGa4DtLoG2S0uPq
         qBBquwx2SNyQHDovVjcDbstyY+JT7/78vOdLqrx+o4KW1CpNatCfeyFm+szSo9DpB1am
         /uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346669; x=1757951469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSVWNylrScXe1y62XnvPM0BOnL0/TLepz30BeNFntlY=;
        b=BcyOtuQgjMgT6xqD22NcHM7aDsMdAUry0M/76GHvbHfXTV8nRPWuIowJX+IsBwa5YN
         8x66A6Z8o07GmrFDT++Ep+E3pQIii3Tzea/gb2DR3cRwxz4cXoD+RvuKUXVvrffhe/A5
         wS8CIhUhPNT4Tq+J9xJbKj3y5PDgIaxnVM0ze+cSx2tLX1Wkv0OIs9o8Eb/xwTd+CaHD
         2SFCy0RSFCLX9ZOk15TU7dzPmCmAaypxEoEoBkWNK8JNPjGRTOtLKYw6Az7RpNSuua8z
         zzHxpBVkEHaNjQH9vkX6Wi5f1P9unAmtG4BTXViR3EmDdV8V0HBdTCC9ygG4P4YYHigX
         FnMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyM5QRIOWofSqmEcZJyaHEz/ZLoQSzkYwT/9+JGlkZK+kuSfEhFvIKix/GXWlK7nCk3xPjbwiK0gjI/0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyerMQ9jrCGqoQuhVACyT20b+C74AOSaJ2GTOXig4hhXDDDO+ok
	RchBXnGC4hvXul6dRSoWSbdb+GDlEA3/E6UwUlgsWAZo5QsiHzSUKrvacoTeMfwJ8PE=
X-Gm-Gg: ASbGncuc5YwXcwhOzRrQjI1ZbSBukFHhSWylrHt3wT+i7PuX9663rmwfYhrLjYatFhP
	iQ4XV32NmU1oIJ2S8o4I0umctw9mjOHOzP62FNjpn+KxCfAMjMhjH039lEnNFLnrVcB2KzdWNOx
	BrO22eJVdJegjVW/O2Fdkb9H1MY9Cy6a4Wc0ep+Ce6P4k2EMvVPdV1EOHM85VFbVeP8IRR+n7Sl
	ibW/HP6mOrERDYYNjV8dTMnnyRUBa6/dP8VJDDApyJsgNbE7S11Tnss6qsxsGpuBG0qw2uNANZ9
	kvuPoZfnFmniavXCFKvfbvECM1Wx1qkH1GdYjCb8J3aK9iDkV4zQJzKd5hSDS7X9YtfB/QN1pRY
	0AXOK5ElHs9fi6qhxbV+xP415dCK9Ah/r2+lM
X-Google-Smtp-Source: AGHT+IFg7xcTkV4isSmekN5I9cnRSz/n5xTff1o3IH8hLRh212Y5ihp6hXV9C7WQZ+WEVfGayJkoMw==
X-Received: by 2002:a05:6402:1e88:b0:628:a4fb:3b1c with SMTP id 4fb4d7f45d1cf-628a4fb3dd2mr3913781a12.13.1757346669016;
        Mon, 08 Sep 2025 08:51:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-625ef80347asm4728258a12.1.2025.09.08.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:51:08 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:51:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aL77aq4gZBsn4epT@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>

On Tue 2025-09-02 15:33:55, Marcos Paulo de Souza wrote:
> Function kdb_msg_write was calling con->write for any found console,
> but it won't work on NBCON ones. In this case we should acquire the
> ownership of the console using NBCON_PRIO_EMERGENCY, since printing
> kdb messages should only be interrupted by a panic

I would end the paragraph here.

> in the case it was
> triggered by sysrq debug option.

This is not important. Also there are more ways how to trigger
panic(). For example, it might happen by an error in the kdb code.
Or I heard rumors that some HW even had a physical "trigger NMI" button.

> This is done by the
> nbcon_kdb_{acquire,release} functions.

I think that this is more or less obvious.

> At this point, the console is required to use the atomic callback. The
> console is skipped if the write_atomic callback is not set or if the
> context could not be acquired. The validation of NBCON is done by the
> console_is_usable helper. The context is released right after
> write_atomic finishes.
> 
> The oops_in_progress handling is only needed in the legacy consoles,
> so it was moved around the con->write callback.

> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -589,24 +589,40 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(c) {
> -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> +		struct nbcon_write_context wctxt = { };
> +		short flags = console_srcu_read_flags(c);
> +
> +		if (!console_is_usable(c, flags, true))
>  			continue;
>  		if (c == dbg_io_ops->cons)
>  			continue;
> -		if (!c->write)
> -			continue;
> -		/*
> -		 * Set oops_in_progress to encourage the console drivers to
> -		 * disregard their internal spin locks: in the current calling
> -		 * context the risk of deadlock is a bigger problem than risks
> -		 * due to re-entering the console driver. We operate directly on
> -		 * oops_in_progress rather than using bust_spinlocks() because
> -		 * the calls bust_spinlocks() makes on exit are not appropriate
> -		 * for this calling context.
> -		 */
> -		++oops_in_progress;
> -		c->write(c, msg, msg_len);
> -		--oops_in_progress;
> +
> +		if (flags & CON_NBCON) {
> +			/*
> +			 * Do not continue if the console is NBCON and the context
> +			 * can't be acquired.
> +			 */
> +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> +				continue;
> +
> +			wctxt.outbuf = (char *)msg;
> +			wctxt.len = msg_len;

I double checked whether we initialized all members of the structure
correctly. And I found that we didn't. We should call here:

			nbcon_write_context_set_buf(&wctxt,
						    &pmsg.pbufs->outbuf[0],
						    pmsg.outbuf_len);

Sigh, this is easy to miss. I remember that I was not super happy
about this design. But the original code initialized the structure
on a single place...

> +			c->write_atomic(c, &wctxt);
> +			nbcon_kdb_release(&wctxt);
> +		} else {
> +			/*
> +			 * Set oops_in_progress to encourage the console drivers to
> +			 * disregard their internal spin locks: in the current calling
> +			 * context the risk of deadlock is a bigger problem than risks
> +			 * due to re-entering the console driver. We operate directly on
> +			 * oops_in_progress rather than using bust_spinlocks() because
> +			 * the calls bust_spinlocks() makes on exit are not appropriate
> +			 * for this calling context.
> +			 */
> +			++oops_in_progress;
> +			c->write(c, msg, msg_len);
> +			--oops_in_progress;
> +		}
>  		touch_nmi_watchdog();
>  	}
>  	console_srcu_read_unlock(cookie);

Best Regards,
Petr

