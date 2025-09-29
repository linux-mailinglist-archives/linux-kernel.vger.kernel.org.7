Return-Path: <linux-kernel+bounces-836279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A21ABA92EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C133C1C50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03052FDC3F;
	Mon, 29 Sep 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YSLMeOLO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8D263C9E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148290; cv=none; b=my4JgqV2PYp2Ib3pR1RfnF37pNDQcK+EDLR2vAiSESyMAHVJRzAe73Qc+7Cu9bdQMY7iqnA9X21FAdz4phAJatpshnJF7l/x3QzTKzCMuT3aOCcSFLwrpsoFq4kICmDS41gCH028RgCBfhG2C8dAALYlcFzKNbFHHZEqWO/jp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148290; c=relaxed/simple;
	bh=RaNJ2xv1Qex3xzGO5ikkMpHr2qCYlipHgRZT7sB95J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iroZZy7eVqvPqcN9wczs9Gynb75evUEHSrNbZdS4NUP015IeP+c094+Vdbd8uEx1cpHxrgPKUVqf72eLuEoknryO1cgMClvRihKqN75/RBwnVjjJ6J+5/nZTn6nwYrdxTiRXmbkRmjpyxGLy45K72O7DpSBOzIYLQCx2gpiW7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YSLMeOLO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so323471766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759148286; x=1759753086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJTlBc7e0UGPbCvtSLpySZFrvddmGs7zW6KyxEHAB9s=;
        b=YSLMeOLOPJyTkjJKbmOgoxafHOyzM4Pw8KsUnYa4zu8g3iFW3orMO4UTdhrvisHep6
         PiQgOuIfAYbJaF85i/Q5R/1wesUzcS3xTSWp+Hp9kfmjlC0YnUoCTGODh8Xz1Ki2PnLS
         8Xp2Gu801qMShrz3I8vb1ZcMASm5lioXcEcyGOB6VLj45d4VGF7YZNAMacAOsU4izDpu
         SUWyQZTUqpQZrENs/28me2HTH7lE49cJhKGoSPSt/WKs3KjuvU9p9cMsItUZz7cZOUCs
         Iys4fRrQ2xmb/6T5KR6KCFktmqrKtQTE9fTAJlsoYSpssq70jn3pMVn2bpc5X5QBCFZk
         3w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148286; x=1759753086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJTlBc7e0UGPbCvtSLpySZFrvddmGs7zW6KyxEHAB9s=;
        b=Mju+/35Is3Fy59Ykflnn6hBb5PjpIrqFBOeI//sUzRHXMNOLu8uTsWDXVsTskOmcLV
         8zMfR8e2u68w8Bg6si/c436Zmha87ERx6LD0tMDpytr8667Tpwsvuzeq7x4gIfSa+t/M
         izaV8PtpjKm4/kt2cCOP5wIfYhYJ8GyTLdse+5UyL5zEOOsKtRHtzUN2rLhcfZzCpIkE
         Kh9kYj5gybr7VLbRCm9PDZ/6cxbFi/2fCYzoZaZGmO4J2aab1JXTAdy2UgaLQKM7p3jV
         w5uBSRPB6rmVNpWCGdBLwEqIAL8AtM2RqkARzGsgL/Ii5mawYWzZvbcperatx5R6fiQK
         pTqw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lU9al0uzPSQCtoprOx8mDa3V1sSKZyvPiL9QeD3s7n6J3kQarTHRvMPKEzEeqamqwGojq7Q1gsx8G5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYb5nQMkzoECebptWWVFwIum8XO3MD0P3QeFrtQMIPHCY3lG6u
	UPkov15/OcmIKYHpyTvl1bvDwPdi4IzYuN0URG6Frnu+Cvj8/U/OBogFSZUN3Zk3JKo=
X-Gm-Gg: ASbGncv6pS4DsA6s78Asaw9wTK9BTAyX0syxDp8Z5jQup3Rk67+M3FpLktm+gdhQrHh
	/faXjfjDpGEthHnljjdi6VQRmUIGdBlUgPqym/x/J6x48D/ipxgcl+wnMn9xDEfc6NQy7iTcrkA
	R551Nv2oVFo84f6DbAzGTI89i9t3Be1NrKMEc+046B5FqvbJsJuHYeqCrUKZeBeCTZ+F+yJhzk/
	ebK+VsA9zm12lcgwmlHkPhfxwRpyDKD0bFxvwyfnhk34/cbGP/PPKNNoUfJxGnFRl2tcigksT73
	zKVV3HaKh9LrEdGWwmPNuI5PgQRTF+N3Tkpi4bIaJRq9JrTucyeWsfBnxVBPqVspnp5c4/Lb3Vf
	ZHozaTNHWfyqFzIxl+FyfpHTiEDwLX/6UF1u7
X-Google-Smtp-Source: AGHT+IGAZf3Av6RZk1uN6GRr+3I8Y4RqRRbIsiCyQ2gdELUp1+rf6Uu/n4ttTd0Mnoq/jbgycwGAMw==
X-Received: by 2002:a17:907:1c89:b0:b3a:ecc1:7767 with SMTP id a640c23a62f3a-b3aecc18344mr872606966b.32.1759148286030;
        Mon, 29 Sep 2025 05:18:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa494esm914493166b.25.2025.09.29.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:18:05 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:18:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 0/1] Allow unsafe ->write_atomic() for panic
Message-ID: <aNp4-xslkeO-29BP@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <5hgyof3yowdw3v76ygz2oxkzv7vpz5kp62nx36gynmr646yrjs@ag4mvynlin4k>
 <844ispin6a.fsf@jogness.linutronix.de>
 <bqihuqqrfc4ayghycmtfjcowyflvbku4ledy7pwajryptlp2wg@hq6cctbmimi3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqihuqqrfc4ayghycmtfjcowyflvbku4ledy7pwajryptlp2wg@hq6cctbmimi3>

On Fri 2025-09-26 08:17:53, Breno Leitao wrote:
> Hello John,
> 
> On Fri, Sep 26, 2025 at 11:27:49AM +0206, John Ogness wrote:
> > On 2025-09-17, Breno Leitao <leitao@debian.org> wrote:
> > > Upon further consideration, it's worth noting that not all network
> > > drivers rely on irq-unsafe locks. In practice, only a subset of drivers
> > > use them, while most network drivers I'm familiar with maintain IRQ-safe
> > > TX paths.
> > >
> > > If we could determine the IRQ safety characteristics (IRQ-safe vs
> > > IRQ-unsafe TX) during netconsole registration, this would enable more
> > > optimized behavior: netconsole could register as CON_NBCON_ATOMIC_UNSAFE
> > > only when the underlying network adapter uses IRQ-unsafe locks. For
> > > adapters with IRQ-safe implementations, netconsole could safely utilize
> > > the ->write_atomic path without restrictions.
> > 
> > This is good to read. But note that if CON_NBCON_ATOMIC_UNSAFE is not
> > set, it is expected that ->write_atomic() will also function in NMI. So
> > being IRQ-safe may not be enough.
> 
> What are the other requirements for ->write_atomic() so it could be
> executed inside a NMI?

Ideally, it should be synchronized only via the nbcon console context
API and should not need any additional lock.

Note that the nbcon console context should get synchronized with
the normal device lock via some wrappers, for example, see
uart_port_lock() in include/linux/serial_core.h.


> That brings me another point, I suppose that netconsole callbacks are
> currently being called from NMI, given it is registered as a legacy
> console, and legacy consoles are printked from inside NMIs, right?

The legacy console handling is automatically deferred in_nmi(), see
is_printk_legacy_deferred().

The only exception is panic() where the consoles are explicitly
flushed. It is not 100% safe. But the risk of a deadlock is reduced
by calling bust_spinlocks(1) which sets oops_in_progress.
Console drivers use trylock when oops_in_progress is set.

I could imagine that we allow the trick with oops_in_progress
and trylock also in the "unsafe" write_atomic() callbacks.
But it would be better to use only the nbcon context ownership
as suggested above.

Best Regards,
Petr

