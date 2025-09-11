Return-Path: <linux-kernel+bounces-811490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30765B529E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E96A029E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5426CE33;
	Thu, 11 Sep 2025 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BI34y01B"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7E256C61
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575705; cv=none; b=bMXDYuoSjxcqb9NZrlPGrBwT48y+KS+tSkqPuq1FL85sjHNnmTjoegymmEgZHQKiW7qaujVHcsiO8TDHiRAozpNmZMd3RGdiP79qEMog7cLf+RvXxLBT2tFu81shy9jhbT+q7uROzaudX5atc6ZubK9hKGjzaMnzTlaNUIdZD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575705; c=relaxed/simple;
	bh=3LhkY1jX7VWQuXhPNbPkpRjL05D6uPNjtQLzUhymk24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvHIfLBXb2n4XbAuJBly7dLxB2JTBeW20rj7P9wXkl1JmBfM01+qgw8ptc35FyoeDgz5NB8Y2p0w2W5zsb3nq05eq0ATz+AilGfqme6fF3sbanBnY3z3/0wi4DBCG8TIHWsKCu3pFHDcJSFNyMMJ6J3QlIfsA96racyl18r219g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BI34y01B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so37415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757575702; x=1758180502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK7U3lnC3y7/ffQqOSxbeSeWtjBYH2LRmWQkOy2vWj8=;
        b=BI34y01Bi9b5mt85ULdCsq2yDo6aOmkHLrmKltQbP5knXvX57Hgq+up2ZFKDFy36FM
         ZY9gZHF6HoKW3adLm+X/mIHntwSx/wRY0QxlfA57Sqfci8Zzl6Y2V0OlAK1FUmZNudpp
         dANhUrVQE2pLPJ5W0gNUQScgXTBXjUHVxb4f8tPpK42q+SF2RTzujVAs2AXUuU9xzoYR
         v3ot67AzUlQ64pLDWI1U4bncCeFk9aQKclUhnqlIq4gS2vvYeVFc2fU/1TjVNRZ43sSW
         8QkO8RbGMnqV814XaXAzYe3vz3p317lkBYPT+zIM+t2dwCzAY6MxwHUFo0C6rUddsnRv
         7Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575702; x=1758180502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK7U3lnC3y7/ffQqOSxbeSeWtjBYH2LRmWQkOy2vWj8=;
        b=TXRNQuIurDzeVL9wGKON++d0FxozCCVFeFaMF8hKoyzddoGBxQS/lhN8TCFPGJZ5SD
         9O0ttd2qJPofLZjpwaZ6r8KeDYysxNr0v/OX1LrMWKTnLJnJ+eAUljXmRj59+mUP9hw7
         s7bTr0OXwNBF4QnkNDwcOnGAoMskJns0Z+fqMGsXzO2RkVwW/aXWIs2CUhm/U/t7UFIS
         UMF5TLFuqPxsQ+wW+cukboVmfLsZWf9dY51g5gc0sOnNVKeLlPU+ii0zbK1imy5hG++Q
         ENe2bwZvHlwhyrfKGa1pFKkNpYbJvg0CIxFltgCMIhtzHcQMbE89qTBMw7pMrHEg3TtW
         h6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUfoQqdok0ygHnQCQ624VMeLgL5kOpH4jC1aKcMEu46Vp8asiRw1Kesnu3k8cTGdb8egvdo5/1VHoLCGoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2+lpQXMK21I7uEFJ9DiiM+Obv0v8oWcEOppYl7bLkAZlfhfF
	Qi1nCedjCT4VvFujg5QFSinhfi4jp0J7ozDWHqll4W1PXqS49SKmVVN4fwSBkrsIxsuQpUwjyHq
	XdgXCDkemw2zrlWcnQ6MfVqtLdDXYq8Bj3w6h3uDo
X-Gm-Gg: ASbGncukVwTNkxBcGwpR7EIRhfqPnQp2pb93qMNmvAGxtbjg+qDC3MQfDwXL7+iiOR9
	EaRMkk7SEFpFLqUy0vLHGLAYWRa0d9TVw7Rdd9BkSrexZi62fq7fNP27CseGtNwF2ebQfez1khX
	0uQXeosbvKtlc273Bo4WzxzOkhcYXGaTGSgP1zGcFL9Gzmlf0BCww5ELV1QS2/SoK7wJjxWrQCw
	PYYQK7k+LJ7doTBuAc0D33lG1hJJpCRy3cZrcM/7qnHK+BZUCbGhn3opglbCg==
X-Google-Smtp-Source: AGHT+IEbjA8wA5uTk3TcHbPBQJWjhclijtbB5//wAB0Y6KJCSvzkuEDQ/JZz09gc9AUpAZcVbdPxutDodlFxxbV1cXQ=
X-Received: by 2002:a05:600c:c058:b0:45c:b4fb:f0b3 with SMTP id
 5b1f17b1804b1-45df81fcfe9mr2603385e9.3.1757575702354; Thu, 11 Sep 2025
 00:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818082722.2952867-1-khtsai@google.com> <2025090657-unpinned-unnatural-2ccd@gregkh>
In-Reply-To: <2025090657-unpinned-unnatural-2ccd@gregkh>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Thu, 11 Sep 2025 15:27:55 +0800
X-Gm-Features: AS18NWBti6JrawpdlOsgZ6vAT-gYWOrF4Yel8dW_q6Hc4XuwW9RLv4IpCjBtqnk
Message-ID: <CAKzKK0oyBomOOFGv4LHM18BgN8tS=Mcyok4gfq4q81vgk54iVA@mail.gmail.com>
Subject: Re: [PATCH] usb: udc: Add trace event for usb_gadget_set_state
To: Greg KH <gregkh@linuxfoundation.org>
Cc: royluo@google.com, jkeeping@inmusicbrands.com, stern@rowland.harvard.edu, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, Sep 6, 2025 at 9:16=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Aug 18, 2025 at 04:27:19PM +0800, Kuen-Han Tsai wrote:
> > While the userspace program can be notified of gadget state changes,
> > timing issue can lead to missed transitions when reading the state
> > value.
> >
> > Introduce a trace event for usb_gadget_set_state to reliably track stat=
e
> > transitions.
> >
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> >  drivers/usb/gadget/udc/core.c  | 1 +
> >  drivers/usb/gadget/udc/trace.h | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index d709e24c1fd4..e28fea614496 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -1125,6 +1125,7 @@ void usb_gadget_set_state(struct usb_gadget *gadg=
et,
> >  {
> >       gadget->state =3D state;
> >       schedule_work(&gadget->work);
> > +     trace_usb_gadget_set_state(gadget, 0);
>
> Will this show the state the gadget has been set to?  And why not just
> do that in the work callback, as that is when it really happens.

Yes, it shows the new state by logging the state field from the gadget obje=
ct.

The work callback is for handling asynchronous sysfs notifications
that occur later. Placing the tracepoint here accurately reflects when
the state change actually happens.

>
> What is the output of this trace line?
>

The output looks like

usb_gadget_set_state: speed 5/5 state 5 100mA
[sg:self-powered:activated:connected] --> 0
usb_gadget_set_state: speed 5/5 state 6 100mA
[sg:self-powered:activated:connected] --> 0
usb_gadget_set_state: speed 5/5 state 7 100mA
[sg:self-powered:activated:connected] --> 0
usb_gadget_set_state: speed 5/5 state 7 900mA
[sg:bus-powered:activated:connected] --> 0

Regards,
Kuen-Han

