Return-Path: <linux-kernel+bounces-880762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B096AC267D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0762189B4F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46D309DBD;
	Fri, 31 Oct 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxTUzgnh"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70642B640
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933262; cv=none; b=O+28gwUbRaelgYQi6vS1uw+LZmJRvW3tZDMT69QeilvNizDjAtpSeqwoq7GfQlAqSuk6zCwaiB0ngQ44qzcISL0lrYvE//bp+W80F+ZbAlAWvkA5qHbZOwE+FPT+nta75T29p8ujO3qUgFEeoShUeuxcrhDWpQ8GuI0akENHVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933262; c=relaxed/simple;
	bh=BJC365NvBJLU9lUiNa4UkX6iOV1coyxTNIhgT63JGUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVU9xVb4F6KGcEqr1z4mqELfQ4qDM/HjIqL0uWj2NTqJkrv/ZJl2yWKqGtbmbYowdz5DLWGN/q7EXPuyYij4UT9mWn2YvfhpOBlRcPHWgis073dKoGQFmV0wx9bCa/zrD+y6LyO/CnJbwYkAupoxRQiu1fkSG97KWPMKd21DV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxTUzgnh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70406feed3so496169666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761933259; x=1762538059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVkelFeolS50lDsHls6rqRFE6UXsrnRp9IbsGPdMMV4=;
        b=NxTUzgnhw/M7wHJfyqc+pp4EW49UammL0W5nA4ZgSEnLs8p05QiGKieGKtsKWn0+Mo
         YsuQfTgDILxaDhkzTcIIChvalZ5k68tWfT5BONYF4sC2WAp63BX/K2HDmLPUnl8olTwr
         NlY+wuTyP+rT9HAb5lxfVzC0Xnpx+6pWoCODwdrNY1ei6IRAWtPo6urXGjhc+C15Syqj
         r8l/l/f957/wiaua/N2CTlsatEw2npZy2GeL3r5Mu6+8+K6iLcmaC1McHR4eElDNiFZo
         cVLpYXGPCDU1UztMd+9MNzpe1SS8AelZD5cu12nd8wL5cEJdLFVsSE79pEyiNWqVZOQd
         fU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761933259; x=1762538059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVkelFeolS50lDsHls6rqRFE6UXsrnRp9IbsGPdMMV4=;
        b=shjFmy/FWBAio+uXVL7AFzNvCbap9zhJoObcI1BaPjviNghuJ3XRydyIH/CvfpgNXo
         hwxG6ir3MMv0GlEtKlE1nSoVIt7ShZ6GFQ+z5Tdl3KtOcbJ2Z/hccgQx/XdmlLZvCJsg
         8Z84d5MDB2WDulaj+RF9dTpa9lfT1CbVHnvhsWQjCgnL5CEjfpTrBqaAkn9dRYhbKQcj
         TaNDF1Laa6o6X5kT4g1OF9xV9Adl4Gg5VVxF0uY8NLkfUNZc2Hg4TozH4eT0p3YcOqhM
         nYcTFtUAu5Ra4y7LscxCeCC+eCfPVbQfFkDxTytTShfFJTSTu8DjIQ0eMoSx6znVhGqN
         Ntuw==
X-Forwarded-Encrypted: i=1; AJvYcCVcCYTLX79xZliknML98qRTT6zdJru8+IlHzMxEVwvuvEmPbambgAtRmNghDLf+YMacNmbyMKKh6XH/h5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnATLsGAfPlsFOCM31Nm1LfYZTsdarPRDAirn1x3AU0AHjPRce
	KRJ2Cc1MtxNkh4Jdth3myTiz1QfR/xsBnW17hIvGSv/DAtniR2xX19ko
X-Gm-Gg: ASbGncu8E3Ipb78lpP9EowWTCRZWQ7Yw7MyIJxBrj0Us6jX6IZoEucIHr1+unCpOQ9p
	fJ9dARn5q+dpVIq9FbsYKXdwfg8LK7yF+gUsnfB0GGF1pjzaMiFnkUUJZypwzAbGJcO3G5bmEB0
	ZKbuZjezDxxIs4fONbAW1EH5kMMAo1ExvRYwDVPyMEa/ua8MW8RFtWYMO2YAzhPOS3dYOOzWNF2
	BWRCQm1P+N9zO5sFQobNcjxzMOe8ImCQ9z3/jUXD8rJH2HE/4/9lriwQdBiaSuRVnaLCU2UUs1Q
	BG0T66dm5pK4Ne9yitrHTRXBJEGerrJo8Zh6j2Hy2r8AqyBPZGWfUheq1miQnJpmd1TkQpaaQOH
	tfUba5pIXNrHNhVbW8m7SfO832nVyZVXYbMJaQWPkQSpqlRNV7K8+YrJ4uVHl7gtOM73VYrDx/W
	i1gk24UWmdicyG72es
X-Google-Smtp-Source: AGHT+IERhTg7p36JQrABPLxGIu7O9YGa1ojGNBq15ZIwY31diEwHul3jylxpnfmBGpWv8x7vkC9GvA==
X-Received: by 2002:a17:907:7244:b0:b70:4ca3:bce1 with SMTP id a640c23a62f3a-b70704b3862mr487313466b.31.1761933258388;
        Fri, 31 Oct 2025 10:54:18 -0700 (PDT)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b392d5dsm2176021a12.15.2025.10.31.10.54.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Oct 2025 10:54:17 -0700 (PDT)
Date: Fri, 31 Oct 2025 18:54:13 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: xhci: Fix a format bug
Message-ID: <20251031185413.2eeefa2b.michal.pecio@gmail.com>
In-Reply-To: <2797d75d-693f-4a99-9465-a340f956cc4f@linux.intel.com>
References: <20251016182813.3d10a8a3.michal.pecio@gmail.com>
	<2797d75d-693f-4a99-9465-a340f956cc4f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 17:00:42 +0200, Mathias Nyman wrote:
> On 10/16/25 19:28, Michal Pecio wrote:
> > The width of 'addr' depends on kernel configuration and gibberish is
> > printed in traces and dynamic debug on some 32 bit systems like ARM:
> > 
> >    Removing canceled TD starting at 0xf9c96eb0 (dma) in stream 0 URB 54e247b5
> >    Set TR Deq ptr 0x205400000000000, cycle 0
> > 
> >    Successful Set TR Deq Ptr cmd, deq = @f9c96ef0
> > 
> > Fix it by casting to 64 bits. No effect on unaffected systems.
> > Remove the newline which casuses an empty line to appear next.
> > 
> > Fixes: d1dbfb942c33 ("xhci: introduce a new move_dequeue_past_td() function to replace old code.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> > ---
> >   drivers/usb/host/xhci-ring.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index c7f658d446cd..6d799a5a062d 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -776,7 +776,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
> >   	ep->queued_deq_ptr = new_deq;
> >   
> >   	xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
> > -		       "Set TR Deq ptr 0x%llx, cycle %u\n", addr, new_cycle);
> > +		       "Set TR Deq ptr 0x%llx, cycle %u", (u64) addr, new_cycle);  
> 
> Why not %pad and &addr instead?

I thought this would be worth fixing in stable and %pad annoyingly
doesn't support precision modifiers. So using it would be
- functional change (implicit %.16 padding) on non-broken 64 bit systems
- difference from other related formats which I am not updating here

I can do a v2, though I think such change would make more sense as
a separate non-stable commit updating more of related messages.

And I admit that I am not a fan of %pad in general, it's a hack which
defeats compiler type checks and allows passing any invalid type as
long as it's passed by reference. Probably made sense when review was
the only means of catching format bugs, but not sure today.

Patch 2/2 makes such bugs a build warning on affected systems. With
%pad, &addr you can change addr to u32, u64 or 'struct xhci_hcd' and
it will build cleanly on every platform, then print garbage.

Regards,
Michal

