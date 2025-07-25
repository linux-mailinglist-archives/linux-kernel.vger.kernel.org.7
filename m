Return-Path: <linux-kernel+bounces-746369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E8EB125D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3975E189D0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01425B692;
	Fri, 25 Jul 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjhrxQr+"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07D24EF7F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476687; cv=none; b=HdmcNGh5GRdz1tRFbnD2rLDqwEPKYASvfmoJmS7xhwu+ortAWau6MT4M2J79owHKBNFTFuDvTKVO/MnyT0nVHSUltH9/6q63X3ZqFTSrU0coTHebXkXmtSev061msGry7WMnN8yM3O8GEtMkS7Itov/U7gC18n4MehmV+9KrIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476687; c=relaxed/simple;
	bh=FthdTqsDncCCx6NjU7yT98rPjj0CY461gcD1JzafDOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhPNe5Wvl9yTsR+DA/hAHSLgwp30nenGdh7vXbgKJ5I4Cn9mPKA3MdIe+tGDrEFSExhMsRaeIqzTeK30xTd9A0QKFe7LTudfdh2FXY/kJ6j4PZfbnBpHtdYOWrJ345mHRYvamLBpv5Par0OPcRTbLj632BTYKktsTjqvNtEFpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjhrxQr+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55a25635385so2920668e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753476684; x=1754081484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a5BT1SS+jMIoUQB40I1MJEAumu30MbcFpZLbewQz58c=;
        b=OjhrxQr+ioDs4SV22uosvInNx6w6EjDEn+ndoCzOoYmcxC/6vAYxoKq1zkvtDMVsgE
         6qDjrO6br1mb3QWByg/XBW7e9wb3Gta9APgnkKfvB0Ns6JAff2QaalVRsR76NwU3ymoI
         QqGhn7ssMxW1qABlYR/syhcPv9dqCgFkH2OZNutXZTgZuefn+fEaE8e91cC7Qo7IlebP
         iK87DOvNtzdnPOtYCOHRJKEP5iGsY1G2jaIn6ViTzgPU/pGjGaqZeZWa9DQ1s+hsO0B7
         rvEKTqFZStT89iOSDaI2rpUBtjh/0Cc3/m9nrwU+Y+I0Nv5JbX3dD8+azS80086yllvr
         u7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476684; x=1754081484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5BT1SS+jMIoUQB40I1MJEAumu30MbcFpZLbewQz58c=;
        b=qC01Gy2FVKyouPOFJ1Zn02oGh/T5weNQp7uyOLX9QkYrpi8amHYNSkqfR0EKLWm5j3
         gwXLFyig4vlybds9kRMkSqpwzaUeFIZkdInhlxhoz/vntrH1tbhE565bsbmlMXaSwKuP
         9MVi8OXEl4F63SJaroxTl428EBy9A2ZJctZr/4tR40dP1sxsi+tum/JCLYQZ2hCTxdIX
         6uromtAgTs4xQ+sX6K4ydvMGeLQPvxGZJpXLM+ff2T/IRe81fHaOrjP0ySoD0MV9RKHC
         ehYbQZ7nrojjryuefcyUns6hux9lcTgViD0tENZ70y/wO55PAECCmNLVOR12mNqped05
         0d8Q==
X-Gm-Message-State: AOJu0YyqxssMPyzCOYACuNGFg93K+opW+Zc4RPlsoYV/cwoYCJxQewnW
	sv9r57w9h0L41cGLJtgEJcmk6qgu7Jm6MphtixcPIlWv96ivOLvywq1mG1ox/nxkl1YW+iN0GuB
	gJjd6DQOjSIZbVDrmZZhV7Na4KobwMqvkK195onB9
X-Gm-Gg: ASbGncswJKitQ1tAqQGsr0L5VBRF0/x3TGKZNM3EPWX9rPEodlyKALWmIgDoN+eDF7q
	rQJWLfeXyFmGtFpX9fha8yILr27eIuh3aODcGJOURu6bTTeJYzcl5u8MdlqNoC9gzq36kXD0vC8
	s0Y3SUNKeJhIb3leGtSOPMilj7Dj2bEK1T6D23oYVAAsjkbsLAekiQ2j2N5AFgXXBK805v5hTaD
	HUzjRf7wGV3tnOltg==
X-Google-Smtp-Source: AGHT+IH+Jx4ZVR8xsi+R7T5/6uBGsohHzNqjS4AjQ+RbAbQSOQFok2ZyRsJDVjLzhi47t1GIEtgSaXyg0LMrkdLcVa0=
X-Received: by 2002:a05:6512:1101:b0:55a:521a:6e8a with SMTP id
 2adb3069b0e04-55b5f495b6cmr1063198e87.37.1753476684043; Fri, 25 Jul 2025
 13:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>
 <2025072527-entrust-childless-3ae9@gregkh>
In-Reply-To: <2025072527-entrust-childless-3ae9@gregkh>
From: Olivier Tuchon <tcn@google.com>
Date: Fri, 25 Jul 2025 22:51:08 +0200
X-Gm-Features: Ac12FXxB6lJSsBmXWiJdn2DxsrweBfmgkR5E-bsr6x5D-7RampktPFHTwlVDO4Q
Message-ID: <CALU+5Va2Onf8AaZx0WEVN4fVY8ErrvHQmRDF+gPFmLEV7HsMiA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: Add gadgetmon traffic monitor
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Oliv <tcn@google.com>
>
> Doesn't match the From: line :(

Indeed, fixed for the next patch.

> > +config GADGETMON_BUFFER_SIZE_MB
> > + int "Buffer size for gadget monitor (in MiB)"
> > + depends on USB_GADGET_MON
> > + default 4
> > + help
> > +   Sets the size of the ring buffer used to transfer event data
> > +   from the kernel to userspace. A larger buffer reduces the risk
> > +   of dropping events during high-speed traffic bursts but uses
> > +   more kernel memory. Value is in Megabytes (MiB).
>
> <snip>
>
> Patch is totally corrupted with whitespace issues everywhere, making it
> impossible to apply or even review :(

Arggh, not caught by ./scripts/checkpatch.pl.
Fixed for the next patch.

Thanks,
Olivier

On Fri, 25 Jul 2025 at 17:33, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Cool, but:
>
> On Fri, Jul 25, 2025 at 05:25:49PM +0200, Olivier Tuchon wrote:
> > Signed-off-by: Oliv <tcn@google.com>
>
> Doesn't match the From: line :(
>
> > +config GADGETMON_BUFFER_SIZE_MB
> > + int "Buffer size for gadget monitor (in MiB)"
> > + depends on USB_GADGET_MON
> > + default 4
> > + help
> > +   Sets the size of the ring buffer used to transfer event data
> > +   from the kernel to userspace. A larger buffer reduces the risk
> > +   of dropping events during high-speed traffic bursts but uses
> > +   more kernel memory. Value is in Megabytes (MiB).
>
> <snip>
>
> Patch is totally corrupted with whitespace issues everywhere, making it
> impossible to apply or even review :(
>
> thanks,
>
> greg k-h

