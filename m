Return-Path: <linux-kernel+bounces-733221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB7B071BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E764E4688
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA282EE96D;
	Wed, 16 Jul 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kiN4lXFF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50332727E1;
	Wed, 16 Jul 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658322; cv=none; b=lq3Y+pCD2YKcFv3fFpVLLX6mrB9P3VtC3XmuzlgZ2AIhvZvRTBJ7QxwK+NX26APnEgunO+PDVkvP8aPyHmQQ1lqk+nrXbW3uLD36RuOZW1A3SFPI/BTS7UW5qkz1Lqb5HThX2cdWIjcVlUeRM7nC4RRc3TT4KtVEObX6xwoVfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658322; c=relaxed/simple;
	bh=yKqWutVQoIXJSjpvgYXXyg2Dmb9CvmAsJ8fZvEUtISk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8kQ9H7pp9SDbt2Fj2e27skPMDwjIyhI0+BoGqqeP7qv9Bq4RTtj6FVwKqqItaAHtb3Gkon5kHmU0tqhfbdnfhFBwDeA27vvFKhpRS4khnn/LWVHlBiGI7vG4Z05yP+GNICLbN7d8tNIEZkRfwbqwHRnUdQOqIViRHChmqbeAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kiN4lXFF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23508d30142so67832755ad.0;
        Wed, 16 Jul 2025 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752658320; x=1753263120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnwkZ9R1fm4X7i76UqKywh7B6iPRGABfvKieGNC/2LM=;
        b=kiN4lXFFz7SCEIwRAwO5qlx0TjbC6TZGXzmE6xvHcNWCOkhrQ2eC/HrCncCaDqrrNG
         IzJbiS4RuylQXx6tzcq736mZMHhjxcp83bCnVJ0qVytCD4XjA8l48FEjr7Ajq4pZdF0z
         gWsAM8D7UwW31GOxSYT8u8ifVycI5rnelOqK/iXtVmdGwC+WSH9zrG+G3r/kmvOrt+8g
         T5cNIslfmBkVpaK7DwsgRrgfpwmts6abCzcEW7ev4NEiAgzxBLBX1WPo5xbOfEHMbAaP
         5kUmD2hXs0I2Sx6SHHjULCvp7dYAN5yY7GZCysNcTxDKSlK4C8F/5I/Hvd2vAx4aBCBO
         BwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658320; x=1753263120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnwkZ9R1fm4X7i76UqKywh7B6iPRGABfvKieGNC/2LM=;
        b=DRcxlf3DGiKUzPmWARWCyKJme8GCKRL1cITeaM6pAMNdM9vOJdcmW655q+gphD/NuJ
         xV5OsOXcddjsevtLd3eWaKZFeCG9X7EaTQL3zOcHXMnkGTM7hzsrD4IZCtXsl5+dEhgJ
         Z+v9QUtDYU0i+9G5E0yavMrE0jkZ+BUxiBpcyAFwdjR2Q5hDbQ/7sz4lZLELQ4C/xfrM
         GRs9B14z53v+7JGEzXGEeLaEcEzqyD+zWEgj4KMoaWl4jc5VkOY0yioseUV8VMrBGZaE
         a62md8BXqt57TQ/pDrNktsbZrMlqdaLWuExJAOJgnzllLPShBaGKQzpU8U8MTgAD9Clo
         OOgw==
X-Forwarded-Encrypted: i=1; AJvYcCUmllpi7PqEF8khftVl+54JSM/CX95JYAQZ8/Kh9hfcyfkfahV/ucQNzrLeqC22nTW4BhEN+WpNLugnwCU=@vger.kernel.org, AJvYcCV7WDeedXpWO2Q95jRMIp02+6bMZPzxIKcOkQDbZQfSDUtrPM0bpXBrI0GSE/YXcETIJNRNjIyn7n2E@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoHZ4xj9y35Ki1RhEiw1tlzqoUGGxrPniVzGacfwTdJSb7dFx
	NBfb/44dqo/xXpNet1jq/exI8e5sEmLYqA7MewTXK7PM0XwqlBn/QgkLDboZjc7HjjH6xSyEpbx
	Seeoa5lfKBWtBarg8b9bQCA72HPWeckh0qp0j
X-Gm-Gg: ASbGncvmLy2qtlZd4/iEU4JE7hgQs8R6xEU8/s2MJB2auNze9Kq4uSyVR2mNxgCS0+C
	Qq8DwMLtpF4R4nktqWga4MaSqpQl+hJZZ7ZWyHHZ952hZECLS9R6InV1kjma2rYpSqYP8EPOKJF
	5dgExKpo5+HQH0Ok05HxGU6x9tzcW9nt4xi2RnAVqe4sn0nspFIQzO5jyRCwtgK3MjV9D240NPY
	/Eo7SNo5aC0gjqubnMjs4rwBhgkUgQl2jcezcE7
X-Google-Smtp-Source: AGHT+IGXU0jh38lV+x+5+TbQMyosFk1wul+7Gnz5Q4UXJIBbJoK9XTVMjzaJpGhBXpz0DfkBEfNM7YHcSqP0sWFBPXE=
X-Received: by 2002:a17:902:ef08:b0:23d:d9ae:3b56 with SMTP id
 d9443c01a7336-23e256b7467mr31603105ad.22.1752658319993; Wed, 16 Jul 2025
 02:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com> <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <2025071631-thesaurus-blissful-58f3@gregkh> <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>
 <2025071613-ethics-component-e56d@gregkh>
In-Reply-To: <2025071613-ethics-component-e56d@gregkh>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 16 Jul 2025 11:31:49 +0200
X-Gm-Features: Ac12FXzsx3Iwjc93Y_xAihZbyopvJXmbfLDHrnjW_t-ULvyPYxLbLtVYNYTiLD8
Message-ID: <CAFBinCA8cMP3o483c40RjHkMAEt4RCmL6uCTTk5DPmrNVN6_NQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:57=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Jul 16, 2025 at 10:28:22AM +0200, Martin Blumenstingl wrote:
> > On Wed, Jul 16, 2025 at 9:44=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Jul 15, 2025 at 11:20:33PM +0200, Martin Blumenstingl wrote:
> > > > Hi Johan,
> > > >
> > > > I'm excluding comments that are clear to me in this reply.
> > > >
> > > > On Mon, May 12, 2025 at 12:03=E2=80=AFPM Johan Hovold <johan@kernel=
.org> wrote:
> > > > [...]
> > > > > > +     if (ret) {
> > > > > > +             dev_err(&port->serial->dev->dev,
> > > > > > +                     "Failed to configure UART_MCR, err=3D%d\n=
", ret);
> > > > > > +             return ret;
> > > > > > +     }
> > > > >
> > > > > The read urbs should be submitted at first open and stopped at la=
st
> > > > > close to avoid wasting resources when no one is using the device.
> > > > >
> > > > > I know we have a few drivers that do not do this currently, but i=
t
> > > > > shouldn't be that hard to get this right from the start.
> > > > If you're aware of an easy approach or you can recommend an existin=
g
> > > > driver that implements the desired behavior then please let me know=
.
> > > >
> > > > The speciality about ch348 is that all ports share the RX/TX URBs.
> > > > My current idea is to implement this using a ref count (for the num=
ber
> > > > of open ports) and mutex for locking.
> > >
> > > How do you know if a port is "open" or not and keep track of them all=
?
> > > Trying to manage that is a pain and a refcount shouldn't need locking=
 if
> > > you use the proper refcount_t type in a sane way.
> > >
> > > Try to keep it simple please.
> > I'm currently refcounting from usb_serial_driver.{open,close}
> > The additional challenge is that I need to open two URBs at the right
> > time to "avoid wasting resources". At least in my head I can't make it
> > work without an additional lock.
>
> Urbs really aren't all that large of a "resource", so don't worry about
> that.  Get it working properly first before attempting to care about
> small buffers like this :)
I understood that this is a requirement from Johan, he wrote (on May
12th in this thread):
> The read urbs should be submitted at first open and stopped at last
> close to avoid wasting resources when no one is using the device.
>
> I know we have a few drivers that do not do this currently, but it
> shouldn't be that hard to get this right from the start.

The original approach was to submit these URBs in .attach (e.g. during
probe time) and kill them in .detach

> > The following is a simplified/pseudo-code version of what I have at
> > the moment (which is called from my ch348_open):
> > static int ch348_submit_urbs(struct usb_serial *serial)
> > {
> >   int ret =3D 0;
> >
> >   mutex_lock(&ch348->manage_urbs_lock);
> >
> >   if (refcount_read(&ch348->num_open_ports))
> >     goto out_increment_refcount;
> >
> >   ret =3D usb_serial_generic_open(NULL, serial_rx);
> >   if (ret)
> >     goto out_unlock;
> >
> >   ret =3D usb_serial_generic_open(NULL, status);
> >   if (ret) {
> >     usb_serial_generic_close(serial_rx); /* undo the first
> > usb_serial_generic_open */
> >     goto out_unlock;
> >   }
>
> That's odd, why use NULL for a tty device?  Ah, we don't even use it for
> anything anymore, maybe that should be fixed...
usb_serial_generic_open() doesn't use the tty internally - which is
why passing NULL doesn't matter now (but who knows what's going to
happen in future, so better move away from it).

> Anyway, just submit the urbs, why use usb_serial_generic_* at all for
> the status urb?  That's not normal.
I can either submit the urbs myself or use usb_serial_generic_submit_read_u=
rbs()

> And are you trying to only have one set of urbs out for any port being
> opened (i.e. you only have one control, one read, and one write urb for
> the whole device, and the port info are multiplexed over these urbs?  Or
> do you have one endpoint per port?)
CH348 provides up to 8 serial ports using these four endpoints, so
multiplexing is going on:
- one bulk out for TX (see struct ch348_txbuf)
- one bulk in for RX (see struct ch348_rxbuf)
- one bulk out for CONFIG handling (see struct ch348_config_buf)
- one bulk in for STATUS handling (see struct ch348_status_entry)

> If you are sharing endpoints, try looking at one of the other usb-serial
> drivers that do this today, like io_edgeport.c, that has had shared
> endpoints for 25 years, it's not a new thing :)
My understanding is that io_edgeport is submits the URBs that are
shared across ports outside of .open/.close.
So this will be a question for Johan: am I still good with the
original approach - or can you convince Greg that a different approach
is better?

[...]
> > > > > With this implementation writing data continuously to one port wi=
ll
> > > > > starve the others.
> > > > >
> > > > > The vendor implementation appears to write to more than one port =
in
> > > > > parallel and track THRE per port which would avoid the starvation=
 issue
> > > > > and should also be much more efficient.
> > > > >
> > > > > Just track THRE per port and only submit the write urb when it th=
e
> > > > > transmitter is empty or when it becomes empty.
> > > > I'm trying as you suggest:
> > > > - submit the URB synchronously for port N
> > > > - submit the URB synchronously for port N + 1
> > > > - ...
> > > >
> > > > This seems to work (using usb_bulk_msg). What doesn't work is
> > > > submitting URBs in parallel (this is what the vendor driver prevent=
s
> > > > as well).
> > >
> > > Why would submitting urbs in parallel not work?  Is the device someho=
w
> > > broken and can't accept multiple requests at the same time?
> > I don't know the reason behind this.
> > These are requests to the same bulk out endpoint. When submitting
> > multiple serial TX requests at the same time then some of the data is
> > lost / corrupted.
> >
> > The vendor driver basically does this in their write function (very
> > much simplified, see [0] for their original code):
> >   spin_lock_irqsave(&ch9344->write_lock, flags);
> >   usb_submit_urb(wb->urb, GFP_ATOMIC); /* part of ch9344_start_wb */
> >   spin_unlock_irqrestore(&ch9344->write_lock, flags);
>
> that's crazy, why the timeout logic in there?  This is a write function,
> submit the data to the device and get out of the way, that's all that
> should be needed here.
From what I've seen during my tests:
- we fire the URB with TX data
- the device receives it and puts the data into a per-port TX buffer
- it indicates that it's done processing the URB
- the TX buffer is then written out (the host can move on do something else=
)
- the device signals to the host (via the STATUS endpoint) that it has
written out all data from the TX buffer

With that timeout logic my understanding is that they're trying to
catch cases where the last step (STATUS signal) did not work (for
whatever reason) so that the host can continue sending more data.

> > If you have any suggestions: please tell me - I'm happy to try them out=
!
>
> Try keeping it simple first, the vendor driver looks like it was written
> by someone who was paid per line of code :)
The original approach when upstreaming the ch348 driver was just to
submit TX URBs (without any custom code, just letting usb-serial core
handle it).
Corentin and Nicolas even wrote test programs to help reproduce issues
we've seen with the initial driver versions.
In other words: I don't know how to simplify our (to be upstreamed)
version without breaking something :-(

Also I'm not paid for this driver (at all - that also includes payment
per line of code), so there's no incentive there ;-).


Best regards,
Martin

