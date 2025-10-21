Return-Path: <linux-kernel+bounces-863103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3BBF7054
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D9545F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E5C32B9BD;
	Tue, 21 Oct 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE91G58O"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3423A9AD
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056367; cv=none; b=OogEephZqOpNcfJ18K9xlQmatbIK9xWo3wUekEbIdP4aZjj/wQ73is8kvo/285k0MkQzMEAKobMZfmy36iiDXGUK/rZa50227Lp6HCwZCjP77s4A80QPnrZS1uqWaUD9ykMF7IyxYKHpGaeSRO4no8VyDwaJuceLpaFd7b0XXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056367; c=relaxed/simple;
	bh=L2kPsqPKw1JgCCFXpbyfRvm/7VjWm7EVFxxOo1tNXMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4ZYXyynCJVRUt/16i0OaCnTp8lgQ6r4G/LWBkvYqrjRju+KwUM36SmkQHNxmpsWQdB6RZb28bmpKY/fMes9CuE6+oBHIiaf+jvSZfKfQY+/VQFIRTkXIPHGZWQybQOCTr9eO2CDkly8s2ftqTMu0gaJg7js6RfAmoXeN58qZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE91G58O; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711b95226dso45227605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761056364; x=1761661164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJsoERq+lbtNyBXS9BXRJIRxk8+1s/ACK0Sp04sYLmo=;
        b=UE91G58O3po8+pUM55mgcQ7DjQ2f/C/x5sb3gffPcGZzdf808apvNVF/ztXs235D46
         wR+U//YtOgMR9uJKr6C28XbuM0RRFdZKOiuax9o9cTE7eo6PXTSAnMLfcG45fbtf7hNK
         udDSvo9byi0AGSM59iCQZ8/jnpUe7qWHqEnu87yqbP403Esagx00r8vSBg74bgSP5ZBs
         osH9F4gRfjd736JqCo6KzO5kw3Yj92FG+16fZ+YdW8oTbLY4EJ8iZB/Ft35Pcxd8qoJA
         lRdBbAauW2eV/1gHYcRSOR36/wzOeXyUYpVD02C7Oo2TSi+/JDxTfNw1xkubUPue3oNp
         Wpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056364; x=1761661164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJsoERq+lbtNyBXS9BXRJIRxk8+1s/ACK0Sp04sYLmo=;
        b=fbsJVvkkQh2uzIBhysguDcivwt93NMcvWAWkj6sRX5z5F1K6Lg0omabPsvMYe9f2rk
         VoR+9zUF3PItbbA9uH25vqbWfHBl9KnTheUBgX9FPNSuwcbfMJ2ZHoWl79mxvFliL4kg
         +iluYsfPiPRoE7Q+Exsr5+ylzFakCUeN1eYheHr/yETtvzwImUXRazzhXly98bLYbWb8
         WsxK3rntHkucmXMZQW4QsdqQIZGCcNc4YTTLEP07IIa+pnnqWVYUknu73EYNKe8Ug4P2
         OhPfwCZSoaGhURC+sqXqWiifJvfCQoAcKfSMXqlSUAH7DS+rspwQPPs0l/kR4XhuMwom
         dhow==
X-Forwarded-Encrypted: i=1; AJvYcCUaXdI1NYM/YEctG/vbcRyTzym//NmHv3nJFOle9tH1vNvCN+ynjEJuw7DeylfOfbM3bd9nJTv2/se2AKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbQa2S6wUm6SHQExNwDbc/2DPLycMlNUMJvkumefhlODT6LIE
	MhHiOJd/ZqtvVQPIA7lN011vUenLazi+cKTJBWH7zeDtCSCK8hfY3Rjgj2mHaF1+rQToArg/C5K
	RPxZWkOxdHCjvB2g+eUotKRyjLWRXOtY=
X-Gm-Gg: ASbGnctpn4EyUVo10Zkg88ouHOodvouSm2iar5vjhEgFENiIZUv1DZG15nOK30r5IAl
	tORchtK+KXl+Y9SqNlP7gq6LWPh7nt5lNogj3Gly2aC4UlIHRzJqobzVlD6cP8FANYTpKqP3Rd+
	HMyy3GlISVF4K4lebU+yMrb69bfzdriK/fjbd71Fyj2llLIfEO8EQx/+CycFtciIOWvChIAcOV5
	mFc3oTt473AogN5CQP9GprvPxCnO9+tLqS7zygX6BScI7NApQ+lCw0iadD5tc8mcCZ6kIJC4/WB
	MjBjcVab/9g5t0EqDyI=
X-Google-Smtp-Source: AGHT+IF90bxjz8ix40Ll9PxzTcZHjhnAQi9gB+R9Z+uHtbgPIaVOQudoZ+vcDoGIlUSSnwqhVwARNc6fqY+obGVADgc=
X-Received: by 2002:a5d:5c89:0:b0:3e8:ee5d:f31e with SMTP id
 ffacd0b85a97d-42704d7eb32mr13379995f8f.25.1761056364261; Tue, 21 Oct 2025
 07:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
 <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
In-Reply-To: <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 21 Oct 2025 16:19:13 +0200
X-Gm-Features: AS18NWCPMHLTced0Dmr8zTG585fd-t61s0ttRFUl_G7jBr-X0tGHFlvGwKtayRE
Message-ID: <CA+fCnZdHJtHgZuD9tiDGD8svXTEdP=GK8HSo71y_UfKgZcaUxg@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: do not limit transfer length
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:18=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Thu, Sep 4, 2025 at 10:08=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Drop the check on the maximum transfer length in Raw Gadget for both
> > control and non-control transfers.
> >
> > Limiting the transfer length causes a problem with emulating USB device=
s
> > whose full configuration descriptor exceeds PAGE_SIZE in length.
> >
> > Overall, there does not appear to be any reason to enforce any kind of
> > transfer length limit on the Raw Gadget side for either control or
> > non-control transfers, so let's just drop the related check.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadge=
t/legacy/raw_gadget.c
> > index 20165e1582d9..b71680c58de6 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io=
 *io, void __user *ptr,
> >                 return ERR_PTR(-EINVAL);
> >         if (!usb_raw_io_flags_valid(io->flags))
> >                 return ERR_PTR(-EINVAL);
> > -       if (io->length > PAGE_SIZE)
> > -               return ERR_PTR(-EINVAL);
> >         if (get_from_user)
> >                 data =3D memdup_user(ptr + sizeof(*io), io->length);
> >         else {
> > --
> > 2.43.0
> >
>
> Hi Greg,
>
> Could you pick up this patch?
>
> Thank you!

(Greg to To:)

