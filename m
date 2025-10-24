Return-Path: <linux-kernel+bounces-868870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC1C065FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 061215008F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B631A558;
	Fri, 24 Oct 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fyWV3AdL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECB30FC26
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310640; cv=none; b=lpVb3NU1JEdQ0DhaxJKMuY0OLZFtZe8L313CaZjYqYzrlK9wqUckTuJlRjDvkwhTwsCtqwMA8CcBZIgRm9tFk1WuJgzPxnnPjonQD73YcLVVgxCz1/dREe2n5+TFW34vH6n626gViCgkMEwAweGSJzmQqFbHcid+kUGcxwqUYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310640; c=relaxed/simple;
	bh=RwDxQ8jI3KLJbyYwqGranXHt6VMp2gkpChSnWU77ndY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGaWkRUjW/ILVO5K4RRCOG8gpN8wSOW8Pq6IcNgt6ziK814WjvsI2PjVqY7a+0nSodGLAXijLidmn39GxmWYIME2YpefpHbhKwbcLfe7F99dthG5vpGoVt3UPaVj56DHtdb0eE6/Y+BC3CfaAPqRm/H7/N+94g6DNSNBk/2N4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fyWV3AdL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so12176895e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761310636; x=1761915436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjMFEVOFcOEvwwbHj/Z2pDqHP9VYVGY+HiybmL/Q81c=;
        b=fyWV3AdLDcgdYUvjoBk/AxdE6SQh8RKX35rP36GzC1ffu4DbGPPKlcYAv7RZ6zeSTJ
         /8eUt5qLNnOWKz1Tg7QKSFi3xnp3nQ3HvgWkUeujlUHkPZykXMbUWEddYn57Bkv1bxzE
         FQP9StqkJHW6VY5YcKbK+NesP46jOiwypTFArA0jiKrYsUF0jgAWycIVDlegpUH3+r0H
         j0pSJ3OP/pdY/3DLBag+N6agav/NDAZHdOpPpCIzT3e1HXBDffA6gspqQshShqlOAT+B
         y1YSo4TR3zFz7iFHkYYnu2BS37UPGsQ0eyH0LwmTelQDKVMTmfdB9jgZnWp2ADnVMr33
         13Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761310636; x=1761915436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjMFEVOFcOEvwwbHj/Z2pDqHP9VYVGY+HiybmL/Q81c=;
        b=MBKYRjs3TMuVW8Erq+eS+luiImp+5JiGex5dT2WyQb+xBgEgVIIxE8EqAbvvdEO8qr
         BTJlNdmtrtIcH5fudgHy8m3/6ZYV+9n55NYWalbuswMnpRF4sUN/NgnIP0DQ9of3vuhY
         iP9d9Mi8nw8Wp5OXvLqNEE2t8C83SWm9qDq24pGcyocBEc26dAVeYYT6DTeqSGD3moWv
         7G1pOvmrw8iz0XmCmG+8AY1CuRO0cHRNsiGpb/XKmkpclYZrJCP0+6icP8JCh0d8seyw
         7D+2CeRgG8Ntzs/2LjKtgy1aumzcvO0rMO2+03Sl8kpjYqLwuE5FIKzDRfM7peAw0uSj
         fnIw==
X-Forwarded-Encrypted: i=1; AJvYcCVxcMCr+g+Bb/ugB783TarPzZB/pzK0U4asfR+WtJi7q/aop2cPYA+e6TfcYLyU1L5/IScDTTLyVMawxl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dJnpFFuZJIOPiajtFsFBUcMMz1Dx4KIEuR15Bk/vsXhXArVw
	t8QwG7AoK5K0NyoxocMi3v3xSbdek74nzhsVjPBf7HEuqUVUAVZH/ewmRBWFsYt6V9I=
X-Gm-Gg: ASbGncumxfRZdOgIQ0Ol33YgYy+Wtaj0eGKdNwrq+0O9dcyoG+4B9AQdaQQW0uIYYJA
	4AYjQXJbqKNposN6q1ucPr2HuWa8AXFeowXwSigk/keaA7KugwRQahETNY7gptvJ1hpt3mp20cu
	2fzXZV2TF517QzE0p7+iuUk76we2yod3vNlBxuA74BZqAYZeoqmKyHIJ2wnsHSaIg5gO5H0vqNi
	/gejN5vdUS17G7auKjtX3W6vCODEknhj4B/BRJJNVugUK4O4HtSqAIWrCgTlI64fV5+DtJpVMxZ
	B0sZb//FNESZZaYg05wSVeB5liftVtpVxlJGFFW3m0HA3oP6mHwtRJA8b78mKRDSLr3TwA8YCB2
	UQPPfX2gHDKU5fu6YfkZQIhrs+v2Qonfw1iNzK8kXZt+djwuOu09t3srAU/Neph/Natm5oS7+ff
	hbSTgo5d0WOw1NGQ==
X-Google-Smtp-Source: AGHT+IG7cMp9dyvtfBnqnX7+sZGr9d2TX6hz3qGbPcP3kQ0bQX5Ms0n4ESLjp17VcAiPyf/ZPMcTZQ==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-4711786c79emr239176885e9.6.1761310636462;
        Fri, 24 Oct 2025 05:57:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427ed3fsm174821685e9.1.2025.10.24.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:57:15 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:57:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <aPt3qje1IQU8i9Md@pathway.suse.cz>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
 <20251023154657.GD26461@redhat.com>
 <20251023191442.Uu0mD_Nq@linutronix.de>
 <aPtIUq7hf4R5-qfF@pathway.suse.cz>
 <20251024103808.umPAqCda@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024103808.umPAqCda@linutronix.de>

On Fri 2025-10-24 12:38:08, Sebastian Andrzej Siewior wrote:
> On 2025-10-24 11:35:14 [+0200], Petr Mladek wrote:
> > It is clear that the commit message and the comment above the mapping
> > caused some confusion. I thought about better wording.
> > 
> > I wanted to be as clear as possible, But the problem is that everyone
> > has different background and might understand the same term
> > differently. Also I am not a native speaker.
> > 
> > /*
> >  * Some legacy console drivers might violate raw_spinlock/spinlock nesting
> >  * rules when printk() was called under a raw_spinlock and the driver used
> >  * a spinlock. It is not a real problem because the legacy drivers should
> >  * never be called directly from printk() in PREEMPT_RT.
> >  *
> >  * This map is used to pretend that printk() was called under a normal spinlock
> >  * to hide the above described locking violation. It still allows to catch
> >  * other problems, for example, possible ABBA deadlocks or sleeping locks.
> 
> It is not "Some legacy console" but all of them. The only exception
> would if they don't use any locking. Serial driver should use
> uart_port::lock, VT has its printing_lock and so on.

I had raw_spinlock in mind. But you are right. I guess that no console
driver is using raw_spinlock for writing the entire message.
Otherwise, you would need to fix it for RT.


> Don't like the "might violate".
> "should never be called" is misleading because we know how things work
> and they must not be called. But this is minor…
> 
> But why bring ABBA deadlocks into this and sleeping locks? Especially
> since different people assume different things when "sleeping locks" is
> used. And clearly the last was not handled well :)
> 
> I would suggest simple and focus on the change and why:
> The override addresses the nesting problem on !RT which does not occur
> on RT because the code flow is different.
> 
> What about the suggested:
> 
>   The legacy console always acquires a spinlock_t from its printing
>   callback. This violates lock nesting if the caller acquired an always
>   spinning lock (raw_spinlock_t) while invoking printk(). This is not a
>   problem on PREEMPT_RT because legacy consoles print always from a
>   dedicated thread and never from within printk(). Therefore we tell
>   lockdep that a sleeping spin lock (spinlock_t) is valid here.

Looks good to me.

> >  *
> >  * The mapping is not used in PREEMPT_RT which allows to catch bugs when
> >  * the legacy console driver would get called from an atomic context by mistake.
> >  */
> > 
> > 
> > And the commit message might be:
> > 
> > <commit_message>
> > printk_legacy_map: use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP
> > 
> > printk_legacy_map is used to hide possible violations of
> > raw_spinlock/spinlock nesting when printk() calls legacy console
> > drivers directly. It is not a real problem in !PREEMPT_RT mode and
>   s/real//
> 
> > the problematic code path should never be called in PREEMPT_RT mode.
> 
>   because this code path is never called on PREEMPT_RT.
> 
> > However, LD_WAIT_SLEEP is not exactly right. It fools lockdep as if it
> 
> Why is not exactly right? :)

IMHO, it was answered in the following sentence. :)

> Usually you describe _why_ you do things
> and because it wasn't right is okay if it is obvious to everyone.
> 
> > is fine to acquire a sleeping lock.
> > 
> > Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.
> > 
> > Also, update the comment to better describe the purpose of the mapping.
> > </commit_message>
> 
> For my taste it is too verbose and you bring too much context. It is
> *just* the lock nest override. No need to bring other aspects of lockdep
> into the game.
> 
>   printk_legacy_map is used to hide lock nesting violations caused by
>   legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
>   for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
>   lock type which are sleeping while spinning on PREEMPT_RT such as
>   spinlock_t.

Looks goot to me.

> > Is this better and acceptable, please?
> > If not then please provide alternatives ;-)
> 
> I made some suggestions. However you got rid of the points I complained
> about initially so I fine with it. Thank you.

JFYI, I do not mind which version is used.

Best Regards,
Petr

