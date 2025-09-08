Return-Path: <linux-kernel+bounces-806194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10510B4933A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A5A3BD21B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A030DD32;
	Mon,  8 Sep 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="EU2cyAgY"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04542F0C78
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345246; cv=none; b=iu5JGa5xANfUM3OkaVZP+rq28LEoyOKI4izTr1AduHln0BhdZRpE+C3KBT9iadcnmWlJzDeOPAIM6fWqztSf1kU1zi7jN6CIW0mEnGobdgY+Ft3hfHlfbJDTGW/9d5Yus8mllLcqHA07Qqi/CQB8O2FF1aC5nC3uVTXIKiftWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345246; c=relaxed/simple;
	bh=7gFq6VypTDHyruMyiJeYVKPAb80OMpaoAGS5lkbz+sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbpynOuG0uIog91dgbBtn0xU9jmOwP0xo++eR5Fj9db16EklVW0ya1vIduqdqXGJnIyDv7kaectpCcVh5emgp2HZ7TQwsazw0azm6qKESYuBxYX//AC1hysApARTnWmI/y+/5OZqSW52/IuBkPgfWWY2GJwGW5U4AvHL9jAMlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=EU2cyAgY; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74542b1b2bcso3403478a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1757345244; x=1757950044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jQqNVYIuMbhaHikEyc6LfEfgr3MBf/W2+nUiSWCx68=;
        b=EU2cyAgY6dz3NiakLiKhVLjdCU4bkFssY45Z3PGXZcLMtmkoWGftbk0x+5s//no4wc
         R9XteLzHGzb/9XnhiMPNC9upmUB5UPXDTECUkK56GOrkZ3JdH0z4F2bPt6+P6mKdUvvZ
         hD2pu/EtxrpzezRxj1k94H6meC9U/4F/zarsxwJ+vK+wq8Z97X/D4k2uRL2wHYyzKXqB
         +8QypE5f7CnmXn8Dx2rxBEfvKZ6STWfyv1Q0iOoHWZHcrt7Vg1OWrP0exhV/L4jzzg+P
         BNeMDFyTtrEmCtuB3LZOjBqHDeC3J1sKDXVPjJe+2y8Fd6CxoyB2/ITfV31Pkl/gBYED
         Xz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345244; x=1757950044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jQqNVYIuMbhaHikEyc6LfEfgr3MBf/W2+nUiSWCx68=;
        b=K/e6Ooky/ZX23Iht9EwFfU3oPUQLCT0QDeH8qOjDgt3RcZVGGSs6+4imWTLgmtHoC6
         nqCThlu3vwEDB5+b8f+gN1kCKKQgth8215izhHRJvBaLLcXa6iTRnVlAsdSFLjAe9tyx
         GW+ls/iep4+GpSWyEsi5qBLerRTlrf/mYnYdPNUb5kNTRWDAzRw/arl2VMrLlKc8yRx0
         A+YxSE5auCUkuBaFoI9d+6umOq5+Mk8a9wa+QMx0aVZbpPm8i9gdX/1GwSrixdSwabeW
         HF1FyYi0XRtuapbONaF6w353zSNZKthsLSClTOF98E0i3HyeFTnG8ogERzpZ86+2LBa2
         VRtA==
X-Gm-Message-State: AOJu0YynCz8Tgyb5aHjZxrngDnuUq3dHpunZ+i2GfCVl8ULD+L0SEMzX
	mWamKFeFZbQi4/Y7TY8PQvyPrq2wx9D8JJdh0bTTbd6uBc54nyvPjOG32zvBxV5I/TQ=
X-Gm-Gg: ASbGncufSWL/IS26RW3lPuxXqsJEuUwgrUbmmbEj1YIRrGIiBLKoAKAXbEKA+S2eTVT
	J4gCRchmkdqGKfh4vzFViq89R05Lw9Q/y2/b7y/7k8Bg2V90kDiWmJRy0GD4IA0gR3V4SmfSTww
	PtKb/cnnO8FbBmN7lsBhI8ZxvhXvrFjumMLuwf5gLH1xoQ7GDLmh9qftIo/2PN5M1xk3zIgkuNO
	5z1BKI9aFiQWG7XSEImWS7w1RlLR+Jf/4z5cLn792S812Xfr0Fl1Bnppj1cbzId4ceFK/kUh4CM
	vbPLmVyz94aiL/CZNy5y4thwaYOeaAD/OAhBlA0EaMAIslLto+hJzFSXKJHPkjRhyKShe2tvFTL
	zvIBNIcgovqrtLvH4WcP4if3akg==
X-Google-Smtp-Source: AGHT+IE2MMTUnKpOyARn855O4YY8YtMTYEMzR8gQvezmFV/9+j61YPoiDT1MhIgNdx9G81aUDa0RzQ==
X-Received: by 2002:a05:6808:6f8f:b0:438:133e:635c with SMTP id 5614622812f47-43b299dd05fmr4341409b6e.10.1757345243578;
        Mon, 08 Sep 2025 08:27:23 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:6c2d:e6cb:9ddd:bb13])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43836abed32sm3610146b6e.29.2025.09.08.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:27:22 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:27:19 -0500
From: Corey Minyard <corey@minyard.net>
To: Gilles BULOZ <gilles.buloz@kontron.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: user->nr_msgs going negative in ipmi_msghandler.c
Message-ID: <aL711299g2yKstat@mail.minyard.net>
Reply-To: corey@minyard.net
References: <5cc48305-d88d-ac15-ce0d-55306a60a0dd@kontron.com>
 <aLrPbzfho1d2kMsn@mail.minyard.net>
 <aLrRlQZdeToIgPBG@mail.minyard.net>
 <c3c0cba1-a45d-8619-06c0-64046d8ecd76@kontron.com>
 <f14bd1ca-c47a-13b3-fd5f-5f5ad0c89fad@kontron.com>
 <aLsw6G0GyqfpKs2S@mail.minyard.net>
 <5c0d8998-6cb2-5ce5-e3a5-67237a51049f@kontron.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0d8998-6cb2-5ce5-e3a5-67237a51049f@kontron.com>

On Mon, Sep 08, 2025 at 04:54:50PM +0200, Gilles BULOZ wrote:
> Le 05/09/2025 à 20:50, Corey Minyard a écrit :
> > I'm adding the OpenIPMI mailing list and the LKML.
> >
> > On Fri, Sep 05, 2025 at 05:04:28PM +0200, Gilles BULOZ wrote:
> >> Le 05/09/2025 à 15:15, Gilles BULOZ a écrit :
> >>> Le 05/09/2025 à 14:03, Corey Minyard a écrit :
> >>>> On Fri, Sep 05, 2025 at 06:54:23AM -0500, Corey Minyard wrote:
> >>>>> On Fri, Sep 05, 2025 at 10:16:19AM +0200, Gilles BULOZ wrote:
> >>>>>> Hi Corey,
> >>>>>>
> >>>>>> I'm HW/SW developer at Kontron (computer manufacturer) and don't know what to
> >>>>>> think about an issue with user->nr_msgs going negative in ipmi_msghandler.c.
> >>>>>> Not sure if it's a weakness in ipmi_msghandler.c or a bug in the IPMC software
> >>>>>> of our computer board (satellite) with event messages.
> >>>>> I worked with people from Kontron a long time ago.  Those were good
> >>>>> times :).
> >>>>>
> >>>>>> I see this when I run ipmitool on this board while some event messages already
> >>>>>> available. In this case deliver_response() is processing the messages and is
> >>>>>> decreasing user->nr_msgs below 0. Then when ipmitool calls
> >>>>>> ioctl(IPMICTL_SEND_COMMAND) it gets an error with errno=EBUSY because in
> >>>>>> i_ipmi_request() user->nr_msgs is incremented but still negative, casted to
> >>>>>> unsigned int so becomes huge, and found greater than max_msgs_per_user (100).
> >>>>> Thanks for the detailed description.  The fix for the bug is:
> >>>>>
> >>>>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> >>>>> index e12b531f5c2f..ba33070622b1 100644
> >>>>> --- a/drivers/char/ipmi/ipmi_msghandler.c
> >>>>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> >>>>> @@ -1634,6 +1634,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
> >>>>>
> >>>>>                 list_for_each_entry_safe(msg, msg2, &msgs, link) {
> >>>>>                         msg->user = user;
> >>>>> +                       atomic_add(1, &usr->nr_msgs);
> >>>> Sorry, that should obviously be user->nr_msgs
> >>> Thanks very much !
> >>> I've tried it with kernel 6.11.8 and it's better but still not enough.
> >>> Running "ipmitool sensor" with some debug in ipmi_msghandler.c shows that I always have nr_msgs=1 right after the atomic_add (called
> >>> 9 times), then when in i_ipmi_request() I reach line "rv = -EBUSY;" with nr_msgs=-2 (twice).
> >> My understanding is that ipmitool calls ioctl(IPMICTL_SET_GETS_EVENTS_CMD) calling ipmi_set_gets_events() and thanks to your patch
> >> for each event available the nr_msgs is incremented here and decremented in deliver_response(). So your patch is OK for that.
> >> But after that if other events are coming, deliver_response() is called and nr_msgs gets decremented. So when ipmitool calls
> >> ioctl(IPMICTL_SEND_COMMAND), this calls i_ipmi_request() with nr_msgs < 0 and that returns -EBUSY
> >
> > Yeah, after I sent my email I started looking through the driver for
> > other issues around this, and there were several.  That change wasn't
> > well thought through.
> >
> > So, I've added some tests around this in my test suite, and I've
> > reworked this to be a much better implementation that's harder to get
> > wrong.
> >
> > I'm going to send the fix in a separate email.
> >
> > Thanks,
> >
> > -corey
> >
> Thanks Corey
> I confirm your fix (separate email) is working for me. Applied on kernel 6.17-rc5 sources, with few changes under drivers/char/ipmi/
> to build the kernel modules there for kernel 6.11.8, and then using these modules.

Thanks a bunch for testing and reporting.  At this point it's destined
for 6.18, marked for backport to 4.19.  It's a little late to push this
to Linus now.


> Another simple fix that worked for me on 6.11.8 was to replace atomic_dec() with atomic_dec_if_positive() in deliver_response), in
> addition to your suggested change to add an atomic_add() to ipmi_set_gets_events().

Yeah, but that's just covering over the problem.  It's ok for a quick
hack, but it's not really fixing the issue.  The refcounts need to be
right.

Thanks again.

-corey


> >>>>>                         kref_get(&user->refcount);
> >>>>>                         deliver_local_response(intf, msg);
> >>>>>                 }
> >>>>>
> >>>>>
> >>>>> Can you try that out?
> >>>>>
> >>>>> I'll forward port this to current kernel (if appropriate, this has all
> >>>>> been rewritten) and required a backport.
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> -corey
> >>>>>
> >>>>>> As workaround I set module parameter max_msgs_per_user to 0xffffffff so that
> >>>>>> user->nr_msgs is never greater than this value.
> >>>>>> I was using kernel 6.11.8 but updated to 6.16.3 and get the same issue.
> >>>>>> I'm also not sure if our board is supposed to receive such event messages as
> >>>>>> it is not Shelf Manager, even if these events come from the local sensors of
> >>>>>> the board.
> >>>>>>
> >>>>>> Best regards
> >>>>>>
> >>>>>> Gilles Buloz
> >>>>>> Kontron Modular Computers France
> >>>>>> R&D SW/HW senior developer
> >>>>>>
> >>>> .
> > .
> 

