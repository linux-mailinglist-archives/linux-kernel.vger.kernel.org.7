Return-Path: <linux-kernel+bounces-733126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941BB07087
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C7D188B50E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F72EACE2;
	Wed, 16 Jul 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vtu2jxUF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F92EA470;
	Wed, 16 Jul 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654516; cv=none; b=emFsXacWlYbPXpzWFC87RRwWS/zdBmw0HRvECPkuP19xD9PnfdzDw5jFbGslb6JwkY/qD9ehUsGNVMSbUkOkzoO9sOqbg02jxb+s5EfktgJh7oOeS/PNA59+BzRcmsTPOpjYyg/5wlQp7Y1fhSi3gvLXrnXb6D2Yx5E9KNopWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654516; c=relaxed/simple;
	bh=RNftaCGYd13yFx540oBssjX8Jc8xFPzXzRNlIMRb0tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6Al2Oi4ClJEAB4GHiu/lbk8INfyh12ViqZrySYlVey3zIsNjfhhHGm9TtC55Fxp18VEjkX+kjvc30cuzrI4IPuQvXovko4k6EnXti3UhtMWAlfGJxWbxIiaVQCUOhBuIz5Nz3vO77RntWS0JnYkKbFipLMRXm4DnYT+GO26Gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vtu2jxUF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b52bf417cso4027010b3a.0;
        Wed, 16 Jul 2025 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752654514; x=1753259314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVivwlquhc/xyQSlolPcTCMefY5MmFW6ZwXvG0y8FSI=;
        b=Vtu2jxUFNsNjIWpGRZjo0nwOoQHRbYGmrJwbwhP1TOXuj+GlJ9xb6xriqtJc3Nc3Sj
         qVIX6P7Mdp2G6TA7kDBHX9LCZhjA5jmwGZhcCWHXPXAeU5b7+jLk5DL5zWLAxm6EXxzf
         PajwPTFJQJ9JnAnTbN9nePc2oy7xVB1ZFdCfO1R53ogI0ursUdqJsuTzyM90maqFeIw+
         VGRat2BJiX/ccf09OR6Qtpk8X0em0AcDRo+GKA+XNFKNggM+ujRK6lyL5mR7SkRSjSxu
         mVdBWvjU1eWIOOXCC7qbWbMZ3op3EJshZg/dtmNKU7bT0Yo/vWiYbC+3MQmqrHhm+anG
         NG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654514; x=1753259314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVivwlquhc/xyQSlolPcTCMefY5MmFW6ZwXvG0y8FSI=;
        b=L5NFqoXTjS0WwBAhm2nNkNNyzDVUaWMklFkUYK8NPCTmLtSmHJi9VA38by3B8qvPAv
         iLUn1LgDU+w2Mnt3+Ha+Y37jgL9Oin+Gh9LlKBD3N9+fE5xzJbO+H8EHpNsA92Ou6TQY
         3YqT534/7Iytwvh833kdcJXqVh6SVDKH2cTfXJwGTQgAzby3W1jZWJ5FQ9Gzk4fCJT1P
         K+0jaQc/VIrXqUt+mdJXMAgLWZ7IWYpXkLAt6R8CNS8myXiHbatkhUfLFI9pAyt7rPTU
         jNL4uts8N7mHIfTel9P7EvB6Llbi8x2+vxouXfimp0FeSKusQPnWw47CViC4Rxwf9HUo
         FTlw==
X-Forwarded-Encrypted: i=1; AJvYcCWOLHPo+23GD9TponIPiprYqBTPTrXuFmYrpUoCcWWRhoADrz2LtvsB7IW8p8PuRxu7sRCECX1D5QDmt6E=@vger.kernel.org, AJvYcCXvWKBoK3NqyxN7bMpEPJPKI6pxh5XieorHq7ueW1ynkKNmOVq2rSlmfFCTx5m5leR6yj5hYDjyEjaG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nxreqL7zqDaXzTmO20GcieBRHJxDzs3mlt2oGwqwHrMG9gn/
	tdSZ7Z/FxddZX6XJFwICK1gmh+haX0snFPkWcQXvAY/i6I7MZu1Uz3V2U39eI0dnFHB+k5b0Alz
	Fm7BWWvF24QzH0DY/QzwMiwV3hRCSYCv/Ri5j
X-Gm-Gg: ASbGncuwKEgK7RsgRA/oF3ePCJRrdzROgrOV/Z4XSKsf0zqDwI+X3nhEKUgwjU0Pu4p
	fZlepTlhW9cBmHrIWRyASABXiGOxUsISxHXEy+lj6/8Dabdf2kwRBRB0FeM2Biv6sXS1xJv18DR
	YKIG2jv9f1mhi/OVMDNi+2ej/V0jTV/ObPjkDz7O0/E3KBQi7HwYzG7KzFdCGCyf1IihzKc3vrl
	GyyGYlYDwy1OZM1x/VQqrySm0GL/aEbzyfsPLZudlgdE34jES8=
X-Google-Smtp-Source: AGHT+IHeGlTTxR0kqDnhS2FvvtUVIfj50IUbTGbzan635qZ0kDyA8KmbB70izucfKYP8rB5gL0UFvnSyeeo/qafPSak=
X-Received: by 2002:a17:902:ef44:b0:234:d7b2:2ab4 with SMTP id
 d9443c01a7336-23e256b442dmr29637355ad.17.1752654513843; Wed, 16 Jul 2025
 01:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com> <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <2025071631-thesaurus-blissful-58f3@gregkh>
In-Reply-To: <2025071631-thesaurus-blissful-58f3@gregkh>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 16 Jul 2025 10:28:22 +0200
X-Gm-Features: Ac12FXzZ-IsMLLWh_4YKVYAdEdGILKB-IGO51SXas0OzPziA9My0dT2eSUfiSDs
Message-ID: <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:44=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jul 15, 2025 at 11:20:33PM +0200, Martin Blumenstingl wrote:
> > Hi Johan,
> >
> > I'm excluding comments that are clear to me in this reply.
> >
> > On Mon, May 12, 2025 at 12:03=E2=80=AFPM Johan Hovold <johan@kernel.org=
> wrote:
> > [...]
> > > > +     if (ret) {
> > > > +             dev_err(&port->serial->dev->dev,
> > > > +                     "Failed to configure UART_MCR, err=3D%d\n", r=
et);
> > > > +             return ret;
> > > > +     }
> > >
> > > The read urbs should be submitted at first open and stopped at last
> > > close to avoid wasting resources when no one is using the device.
> > >
> > > I know we have a few drivers that do not do this currently, but it
> > > shouldn't be that hard to get this right from the start.
> > If you're aware of an easy approach or you can recommend an existing
> > driver that implements the desired behavior then please let me know.
> >
> > The speciality about ch348 is that all ports share the RX/TX URBs.
> > My current idea is to implement this using a ref count (for the number
> > of open ports) and mutex for locking.
>
> How do you know if a port is "open" or not and keep track of them all?
> Trying to manage that is a pain and a refcount shouldn't need locking if
> you use the proper refcount_t type in a sane way.
>
> Try to keep it simple please.
I'm currently refcounting from usb_serial_driver.{open,close}
The additional challenge is that I need to open two URBs at the right
time to "avoid wasting resources". At least in my head I can't make it
work without an additional lock.

The following is a simplified/pseudo-code version of what I have at
the moment (which is called from my ch348_open):
static int ch348_submit_urbs(struct usb_serial *serial)
{
  int ret =3D 0;

  mutex_lock(&ch348->manage_urbs_lock);

  if (refcount_read(&ch348->num_open_ports))
    goto out_increment_refcount;

  ret =3D usb_serial_generic_open(NULL, serial_rx);
  if (ret)
    goto out_unlock;

  ret =3D usb_serial_generic_open(NULL, status);
  if (ret) {
    usb_serial_generic_close(serial_rx); /* undo the first
usb_serial_generic_open */
    goto out_unlock;
  }

out_increment_refcount:
  refcount_inc(&ch348->num_open_ports);

out_unlock:
  mutex_unlock(&ch348->manage_urbs_lock);

  return ret;
}

My understanding is that usb-serial core does not provide any locking
around .open/.close.

> > > With this implementation writing data continuously to one port will
> > > starve the others.
> > >
> > > The vendor implementation appears to write to more than one port in
> > > parallel and track THRE per port which would avoid the starvation iss=
ue
> > > and should also be much more efficient.
> > >
> > > Just track THRE per port and only submit the write urb when it the
> > > transmitter is empty or when it becomes empty.
> > I'm trying as you suggest:
> > - submit the URB synchronously for port N
> > - submit the URB synchronously for port N + 1
> > - ...
> >
> > This seems to work (using usb_bulk_msg). What doesn't work is
> > submitting URBs in parallel (this is what the vendor driver prevents
> > as well).
>
> Why would submitting urbs in parallel not work?  Is the device somehow
> broken and can't accept multiple requests at the same time?
I don't know the reason behind this.
These are requests to the same bulk out endpoint. When submitting
multiple serial TX requests at the same time then some of the data is
lost / corrupted.

The vendor driver basically does this in their write function (very
much simplified, see [0] for their original code):
  spin_lock_irqsave(&ch9344->write_lock, flags);
  usb_submit_urb(wb->urb, GFP_ATOMIC); /* part of ch9344_start_wb */
  spin_unlock_irqrestore(&ch9344->write_lock, flags);

If you have any suggestions: please tell me - I'm happy to try them out!


Best regards,
Martin


[0] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/e0a38c4f4f9d4c1f5e=
2e3a352b7b1010b33aa322/driver/ch9344.c#L1330-L1404

