Return-Path: <linux-kernel+bounces-843034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E67ABBE416
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0318897A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA82D3756;
	Mon,  6 Oct 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JnquPy/9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0972C326E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759109; cv=none; b=akpm981lhlW3+m8BZZgNiYIKqLSHxKDe6SlkK6tfTRjWCqW33q99OS8fq30d/1jGEr5+22DUmi/komDQ+qpeMYZUoK6PA+7zeTBsr+ZtG+Sd8YVbIk+bzEKcu8fp/PIkDlXb1JRWcw38oGDAInG+rTr3EcUwlL/C4DyVyiEMP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759109; c=relaxed/simple;
	bh=jwM1rLikn2mT2EOzxJOL6CFwBUhDW+lzfDGZ1e9u9Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odNjSHcjs52IoEsaCx06YvVf2TkMUT/p3+oYQ7jLnI0qUtbsPmoFRz+n+RKrfX9sqhtHTlHcQ1LVeN6kTdnDev2OYEJTcCP/i202C/GHKDMIvNrTifQslCdGHVautDMFTfo2SWNr8qjoIKw4VFQebx8oivqcBb/6zFzF+KOvlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JnquPy/9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so984746266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759759105; x=1760363905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FyJ6ZNCpZC3ZZiSi8rs4q34qq1Mtarm5I9fCpvcYs=;
        b=JnquPy/9V1huRPuN1C6rMZ1grOhcIEj7+Ct4NYBisUcbQm1UT02DK08IgJuEB6jEQK
         f86abwwaZ2VuyKPHxRwSBVCXT7drmJA6z9u/54060U/Tlx8KZoTzWlQVvEAcZd8LVWc0
         jN4yFzhj9LzrIdPa8ULTRIGM5agOdl3A1XLrPHjIf2630WXuxcZ6JieJ2X0fcbT5IDyt
         rfGFn+ooyZMStcJP8ZBY2hTTDK8heL4Ntl8p1sb10Q/m8+jRdT7myPmWeBmDbfzPsTAO
         tiri+OsjG1xWL/DUBHYzLEXMmQkbPa1lOIfpBWNdI7ckZEOJtZArOKCCTXqGBXFGDe8M
         x5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759105; x=1760363905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7FyJ6ZNCpZC3ZZiSi8rs4q34qq1Mtarm5I9fCpvcYs=;
        b=f/nHuQid06VssDa9IhT6tVmwP8aN2R+RppxLOx7XojNpR61QzOyZTI0m4rCl7HnxhF
         E93QjnF/z3yAyWZ//Wlintf9bFJFToztFezeVltmyoqmnId3mjcx6ByI/gubM9spk3ri
         24/6Ipd5LCwS+Uf94hZUamrv8WBrbm3PoviEsS5qevFuDFiTdZxNcMgIDp9TIaps0xI6
         4I/dQgVR8WMyQma9OLyoBchH7vnjG/ajXnmHlMh7IKzTDHXVtGEJzfquSUyIjuWW1fzW
         kJ/x9RFI1S4CwouEFcCwZbfWoA60OPg+8m02xd/uBmLtZfPPjR4IdUiGIu4MYGDXFE92
         acPA==
X-Forwarded-Encrypted: i=1; AJvYcCWpzhGoYc3o5kDxvCCmDmMhDqw5zlSXjQZzCvuAvyDPy79kCCmRgAbeojckRrcPozeMXlNpTdiu9L4VmBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf006QOkvu3bBBuDIuo5NcdwqynQs41Ytu1gnMhaC6Eout+8xH
	OL7HWY76ZGSZCkOCnWH1QaGKbZ/J/FhPpQoODfy7vQE1rRLE4Gd+OA1xs31uu0lanHU=
X-Gm-Gg: ASbGncsLBq56G4dzOjkl+tJL+Cs4bu5gjvqJ5VIBTN5ZIbxMvr7Gywm6g47sP009D79
	LyLs3qIP5YzZVqNIvBd0V+X/vdDVEDanXqsehsg5pi31DU5TPhDeVNq46PtdCGJRNvmfpbEU1ig
	vUJDSqK3djR+SULxTELoPsWo/wYmBpFNFy9v7ZfrTY8LY1MrcdOruvptK8o63oxx0X99HjJFA6J
	N9jxXvLRd9QT1Y0Tw7Tqu+23FeOtbndYysJBTVAop4m+nE6o6V5CnwamFRP+JCd5H+MrgcLho22
	Knbl0s5lfixXbapZJ7jNjA/1Y5g6tRA7ch5Itzq7xiBBfWE+iflZflxR8VG9gWvqTe4HQXjvYtd
	fuLFIKrebVsg/4AacKmKFGVYVnPZWh/hmCQR/QYQUBw6pH+MTKEU0xyELUxMN
X-Google-Smtp-Source: AGHT+IFV2SJ4kzBGN402SmNw/Wkg3HuCOd29mUk2xP3fAhXRSYMPNwRBZ0YPC6/b3KAmvr60S4ff+Q==
X-Received: by 2002:a17:907:3d42:b0:b41:2fd0:2dd4 with SMTP id a640c23a62f3a-b49c449a697mr1576655566b.61.1759759104873;
        Mon, 06 Oct 2025 06:58:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1145209266b.20.2025.10.06.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:58:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:58:22 +0200
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
Subject: Re: [PATCH v5 2/5] printk: nbcon: Introduce KDB helpers
Message-ID: <aOPK_jgFJwM0TWTY@pathway.suse.cz>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-2-8125893cfb4f@suse.com>
 <84h5wihdqu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84h5wihdqu.fsf@jogness.linutronix.de>

On Wed 2025-10-01 17:02:41, John Ogness wrote:
> On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index 558ef31779760340ce42608294d91d5401239f1d..c23abed5933527cb7c6bcc42057fadbb44a43446 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > +/**
> > + * nbcon_kdb_release - Exit unsafe section and release the nbcon console
> > + *
> > + * @wctxt:	The nbcon write context initialized by a successful
> > + *		nbcon_kdb_try_acquire()
> > + *
> > + * Context:	Under console_srcu_read_lock() for emiting a single kdb message
> 
>                                        emitting ---^^^^^^^
> 
> > + *		using the given con->write_atomic() callback. Can be called
> > + *		only when the console is usable at the moment.
> 
> I do not think the "Context" is relevant. It must be called if
> a previous call to nbcon_kdb_try_acquire() was successful.

Makes sense. I am fine with removing the "Context:" secion completely
from nbcon_kdb_release().

Just to be sure. I think that we do not need to mention that it can
be called only when nbcon_kdb_try_acquire() succeeded. It is kind
of obvious.

Best Regards,
Petr

> > + */
> > +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	if (!nbcon_context_exit_unsafe(ctxt))
> > +		return;
> > +
> > +	nbcon_context_release(ctxt);
> > +
> > +	/*
> > +	 * Flush any new printk() messages added when the console was blocked.
> > +	 * Only the console used by the given write context was	blocked.
> > +	 * The console was locked only when the write_atomic() callback
> > +	 * was usable.
> > +	 */
> > +	__nbcon_atomic_flush_pending_con(ctxt->console,
> > +					 prb_next_reserve_seq(prb), false);
> 
> This can all be one line. 100 characters is the official limit for code.
> 
> > +}

