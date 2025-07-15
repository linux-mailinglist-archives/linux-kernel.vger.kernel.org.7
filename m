Return-Path: <linux-kernel+bounces-732547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C578B06871
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3283ADEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB52C08CA;
	Tue, 15 Jul 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S3Vq++lM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F81E501C;
	Tue, 15 Jul 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614446; cv=none; b=VfRBXC3ufkv7WibPm1yqdJOTHtHBDdagCdhrTGR9xjg5n1/bay7ZcYjS21Gb2jWBZjABbKri5rlas7sZ5mn4ZBjdytZjhB/hCdNJ21Aq4u67RuMnF8FkSZEHSzNws8gdy6tkBmVfxSlPzhvG5AlRjj1KCiIbZHD4DcWNlaZ+yqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614446; c=relaxed/simple;
	bh=a7JexUOfP1RzuGB/hlvExynfeLaFztOYQ1Ix59QcC9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWw2Ya713hw+xO3V6zSOWOKIC3z9dZUm/xFVpvc/nIasCumNIFs9V4zZz62bn8XpMaBu3fI4LPla9jKGw7CEIBjk8axpv1l5e5EjvoHZ5bbCtzd5To5inOwGPAqwuGRClu4CbVrV8jGFcz6Cv64cQqMYlVUQ3p5VTctz7rxMbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S3Vq++lM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23508d30142so62932875ad.0;
        Tue, 15 Jul 2025 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752614444; x=1753219244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pceszCzoaqzDgo0HTGrseccItyjoYnZ8vPFKXVSiedc=;
        b=S3Vq++lMy9LSo43q0gLeMdjlhZ8/TAGKfxULTq/poV0CBaRaq718OGZWs6FlZoYVzn
         9AdHJpIBVPC31e5HocmmYWIiOJ8JJxIG/FhvVdsZaMYZEs+1SASQmVuDB3z0Tgo4F0dr
         ffZ6g9X6ZKKNDwPjvE82JEIyroIxqq3c1uxlsqL1SKUHlZSmCi7xsOUPgNNznHwOdCrI
         b9HidV4HNB+e4CWSZd9IGSyn1fj1dwS23ItuHi7IWs6H7lxs03SM47TSNcnUi7KxIFrH
         fdeUWOHtW0NYYt9P4+kOrap2fPnQq34h9rWpUFIyXYfEMEubaDwpgZ9Ta3n0guTeyH+q
         Zj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614444; x=1753219244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pceszCzoaqzDgo0HTGrseccItyjoYnZ8vPFKXVSiedc=;
        b=Af2gK+GLWyEvxdsZtbkd1XTVPc0v5IKgKALn6V56VcmXF6g6AU6a08Ve7BjmOIqXw8
         L85njo589WIzyGolbR55Y8vShctR2TMu60+K0l+zuwkUodOWSKg44ntUF6uBAsrHaIkf
         EDyGRNh1vfWo0UJvyy+ijUjxnQGg4tgGst4Y/UaAc/pO6SLHlUCaekLm0L8GUWRcNu8Z
         2QEN80eYBMAU3piya4CrJiGXND/yX1W4Y0RheVtcOeW4Nik83zqZ6KRvtlkwf9orDHwu
         NqAARF/pgKLv9raxqobnvt0ispJATygDSjQvNSZcvD14gFDzNOCRrDfC+3zcPi5rSuO2
         pWOA==
X-Forwarded-Encrypted: i=1; AJvYcCVNQi5MAMLbUjC6mclFhtSxZeG7WW/gkKHAks1xDGydGJlun5mfbb91Ck6+w2lDoFGVALk0jxMg33q0@vger.kernel.org, AJvYcCWul5IRxTacukTOY0cF+r1LHFTzBn7BpSPjC/ugVc7Fv3HgIeNWynFPP3mXK4ZZpcpw2BTR8tpv4F8vCJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbjQLSHWJaUFLlauD2/asGQlOb39PWQnrSjFW9FOMcvPofPyxf
	MMhmNkliWr+iom9OpRFegWAw4x+qH16Djc0aKFXfLoL2jp3SR5SJzsPFjuwB9fXMz/R4IX4zfqH
	cwk6zGpbZYU6u9aEL1pES0ZvCd7PBg3s=
X-Gm-Gg: ASbGncvlXfdx3iHUggy+NYlRsga1I5+I5S9ylrS0GkC68cnlsRt/VSOsFvUDfvAt0hb
	542/+UPrIHjg2OfuswuR1TLapoqbKqKJCjxsGZetbhTMZZUexStjrkb3mFn5M80hMQs3bCQal8D
	DXIPKIHsz4jQ4tTkVMOX/JH8aJelf/OnjNt0SK4W9wi8MjSLsUYKPKV0yRL0RNgkKFQ88kt9Nes
	XP9YeVMv/P3fQrfpnk3qo0FJCnkuWTEiqP+BE8N
X-Google-Smtp-Source: AGHT+IH/YTnCMy5/1xcQEG/PPen51iAjqri4GZsVIo/c6xPgKsCuSDARMJtZfsK1QGRfnoBalJ7yPcbOVl0Jqd7s2M0=
X-Received: by 2002:a17:903:187:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-23e2566aebdmr4036275ad.8.1752614444383; Tue, 15 Jul 2025
 14:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
In-Reply-To: <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 15 Jul 2025 23:20:33 +0200
X-Gm-Features: Ac12FXypXxX9YJ4bMlrkYXgqByIon5aSB93Zws8b9eZJEe6n_d-LEWX9xQ3cKKs
Message-ID: <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

I'm excluding comments that are clear to me in this reply.

On Mon, May 12, 2025 at 12:03=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
[...]
> > +     if (ret) {
> > +             dev_err(&port->serial->dev->dev,
> > +                     "Failed to configure UART_MCR, err=3D%d\n", ret);
> > +             return ret;
> > +     }
>
> The read urbs should be submitted at first open and stopped at last
> close to avoid wasting resources when no one is using the device.
>
> I know we have a few drivers that do not do this currently, but it
> shouldn't be that hard to get this right from the start.
If you're aware of an easy approach or you can recommend an existing
driver that implements the desired behavior then please let me know.

The speciality about ch348 is that all ports share the RX/TX URBs.
My current idea is to implement this using a ref count (for the number
of open ports) and mutex for locking.

[...]
> > +                     /*
> > +                      * Writing larger buffers can take longer than th=
e
> > +                      * hardware allows before discarding the write bu=
ffer.
> > +                      * Limit the transfer size in such cases.
> > +                      * These values have been found by empirical test=
ing.
> > +                      */
> > +                     max_bytes =3D 128;
>
> This is a potential buffer overflow if a (malicious) device has
> endpoints smaller than this (use min()).
For endpoints smaller than CH348_TX_HDRSIZE we'll also be in trouble.
Validating against CH348_TX_HDRSIZE size here doesn't make much sense
to me (as we'd never be able to progress). I think I should validate
it in ch348_attach() instead - what do you think?

> > +             else
> > +                     /*
> > +                      * Only ingest as many bytes as we can transfer w=
ith
> > +                      * one URB at a time keeping the TX header in min=
d.
> > +                      */
> > +                     max_bytes =3D hw_tx_port->bulk_out_size - CH348_T=
X_HDRSIZE;
> > +
> > +             count =3D kfifo_out_locked(&port->write_fifo, rxt->data,
> > +                                      max_bytes, &port->lock);
> > +             if (count)
> > +                     break;
> > +     }
>
> With this implementation writing data continuously to one port will
> starve the others.
>
> The vendor implementation appears to write to more than one port in
> parallel and track THRE per port which would avoid the starvation issue
> and should also be much more efficient.
>
> Just track THRE per port and only submit the write urb when it the
> transmitter is empty or when it becomes empty.
I'm trying as you suggest:
- submit the URB synchronously for port N
- submit the URB synchronously for port N + 1
- ...

This seems to work (using usb_bulk_msg). What doesn't work is
submitting URBs in parallel (this is what the vendor driver prevents
as well).

[...]
> > +     if (!wait_for_completion_timeout(&ch348->txbuf_completion,
> > +                                      msecs_to_jiffies(CH348_CMD_TIMEO=
UT)))
> > +             dev_err_console(port,
> > +                             "Failed to wait for TX buffer to be fully=
 written out\n");
>
> This would also avoid blocking for extended periods of time on the
> system work queue.
I'm moving this to a timer instead.

If you have any comments on the (new) TX logic then please let me know.

[...]
> You should implement dtr_rts() as well.
This will be the first time we need the "package type" information as
CH348Q only supports CTS/RTS on the first four ports, for the last
four the signals aren't routed outside the package.
I need to see if I have other hardware with CTS/RTS pins to test this.
If not: can we omit hardware flow control in the first upstream
version?


Best regards,
Martin

