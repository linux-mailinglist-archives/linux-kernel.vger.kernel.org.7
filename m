Return-Path: <linux-kernel+bounces-829554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89066B97548
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057A916B32F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA13054C2;
	Tue, 23 Sep 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R9ab1XSz"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AC303A27
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655440; cv=none; b=BS/Kawm6Ns443mD/jyGx+GnAgfYpyuCMuNSMiLCeQ/gmywVKnEbHeSDXFXp+lT+bMptj0ALBMPnYtnO1YDWICLH8YNCmafaNDunwTWtsnOU7USa8oOVouB3dnPim/w5vNy0nm6d9Ees6WqhDjtfTUzjPaaj2imjzh5Wt/rHQK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655440; c=relaxed/simple;
	bh=oaJj2rxBzf9LhkPpYhr/YHr6HBuAtC3qQZGrUsjzZm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNsTYMI5a1ocRX+O6USzUmEwlgc5cJxtIorHeKs3tm08TH9mwmE0dxln8xfJEvmPj8NKlJ1CwJmRYhdrOKbk07t4DnHIX75BSp7FSeNmZts28VjJTLx/yWrTrtc6zlkw/XIO+MXN7Rhw18f30VcJXFJmt82/gjK76Yn8iXUhoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R9ab1XSz; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ea473582bcaso273686276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758655437; x=1759260237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaJj2rxBzf9LhkPpYhr/YHr6HBuAtC3qQZGrUsjzZm4=;
        b=R9ab1XSzyLvcrJ7X+s9DAIaohbcU/UR6UcjJLNaSa1x3KZBoWVjakTTlNaIKQ2ZfAp
         /bNa3Cju55J40WTLI4Xgyzp76TwQJSH7YYG5Ld/5+m88GXmx+mQTaOXnabRkHoVPpsu/
         zgs2fBSuJH0PCZD4hF/AeDnFwwrBR5k0ddAvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655437; x=1759260237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaJj2rxBzf9LhkPpYhr/YHr6HBuAtC3qQZGrUsjzZm4=;
        b=DK4l0f+ic1BkQsbPELpIlZJwyLnGS8hHPxG1T0za+CdaiLGkJgQd/xmD/nLhNxEAaS
         daIIRmMLzGtBqc1HH3ONIF88fu46AvuGFg3MlXTX9zKdzo+bHxRJnfWTD10QwrocIED7
         QOjYhsefNSRfLTshZ67TT7XNuHmuZOzyKJIQJSx8jNvRfxXOaII6Wc9amzSoTkcloIBe
         saGQvm6yayMIUl3/G3NukNznzLAZak9mqmdhpdET27+qf+6DgJVV3fl9NQn7iG9E4hCQ
         /NwRsAD7ldQBeS6vMRxMtjdXs7vkgxG/qEIxnOkPep+03lbnbrUUdNSMVt27K+7Zxna4
         Tpkw==
X-Forwarded-Encrypted: i=1; AJvYcCVxixdiJiBR6MxnhsV+occU0MvQaZPPdwlc7j0Lp+2mLOy+MdV3mppsCQpyQJUqwv5+zesiJaxW+3ze16s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdD29kBNIupk7RnqdNlETnQAEUGrU2ibHSLmGmy4Uk7NP+bqRo
	f8hfsN7HwMLeHFZA6iL0WTST1rFgYV2t/NeBhlRq9QN1OU0CcUuYU8DLhVam+lHuoE1Wt5pUboc
	l5YLzV2WKvUkkCKmevuy/L2EvDHtmpShMTsM9cPy9
X-Gm-Gg: ASbGncscWRddR9JCv+TMwYoQfuIfy+nV7C/zRO5qh+kg5uSJJgCISSL+I9c8bzxMCxm
	qPo5nWIU5H/9b5M5FZmZRyURwGUH5NvCb2GOo0eaP2VQ0JOglULJTWVq/fjAsDxq90mV1PEWkMQ
	Pa8zI04VhYqC2+7te1bMSkyMl4AAm3Vm5BCK8KspDbyQEGYQDLtFJV3trwGp4b6e1UW/1CAiNx0
	BMIGdI=
X-Google-Smtp-Source: AGHT+IHBVKPlAvQs1Ta9poiQVupCk0+PV0rEv7mtUeSky/lTdi5KniqgAEQlZXAChfuKJrTFAmYfK/btu7xo8gJFgKw=
X-Received: by 2002:a05:690e:d5a:b0:635:4ed0:571e with SMTP id
 956f58d0204a3-6360502eeb5mr3016601d50.22.1758655437021; Tue, 23 Sep 2025
 12:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123028.2127449-1-akuchynski@chromium.org>
 <aMliLCWFKy5Esl0-@kuha.fi.intel.com> <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
 <aMqpe68m3rhDYsCt@kuha.fi.intel.com> <CANFp7mWk_TuA6Gxbtc8OmB7eq_vT8wUg=xkPJsxLCBTrQwOd6A@mail.gmail.com>
 <aM1DmJQz2PnEA6G_@kuha.fi.intel.com> <CANFp7mUDVPLja2QANYhJ2t6W9yPE7-qV8E2HTPHcJEYgOb8s2Q@mail.gmail.com>
 <aNFUDZQD5UiCtHW9@kuha.fi.intel.com>
In-Reply-To: <aNFUDZQD5UiCtHW9@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Tue, 23 Sep 2025 12:23:41 -0700
X-Gm-Features: AS18NWAz3TlD_PgNpaODdk9TZw12xXjZ7F3BVIu3By1KogVwdRlrib8D-1fQGDg
Message-ID: <CANFp7mXwbO8thf3vba4QxpBwZXudZJqe5=caT56Wh_A7yeuaXA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andrei Kuchynski <akuchynski@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:50=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Sep 19, 2025 at 09:58:05AM -0700, Abhishek Pandit-Subedi wrote:
> > On Fri, Sep 19, 2025 at 4:50=E2=80=AFAM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 10:51:11AM -0700, Abhishek Pandit-Subedi wrot=
e:
> > > > On Wed, Sep 17, 2025 at 5:28=E2=80=AFAM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 09:47:44AM -0700, Abhishek Pandit-Subedi =
wrote:
> > > > > > On Tue, Sep 16, 2025 at 6:12=E2=80=AFAM Heikki Krogerus
> > > > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wr=
ote:
> > > > > > > > This patch series introduces a flexible mechanism for USB T=
ype-C mode
> > > > > > > > selection, enabling into USB4 mode, Thunderbolt alternate m=
ode, or
> > > > > > > > DisplayPort alternate mode.
> > > > > > > >
> > > > > > > > New sysfs `mode_selection` attribute is exposed to provide =
user control
> > > > > > > > over mode selection. It triggers an alternate mode negotiat=
ion.
> > > > > > > > The mode selection logic attempts to enter prioritized mode=
s sequentially.
> > > > > > > > A mode is considered successfully negotiated only when its =
alternate mode
> > > > > > > > driver explicitly reports a positive status. Alternate mode=
 drivers are
> > > > > > > > required to report their mode entry status (either successf=
ul or failed).
> > > > > > > > If the driver does not report its status within a defined t=
imeout period,
> > > > > > > > the system automatically proceeds to attempt entry into the=
 next preferred
> > > > > > > > mode.
> > > > > > >
> > > > > > > I'm still struggling to understand what is the benefit from t=
his - why
> > > > > > > would you want the user space to explicitly start the entry p=
rocess
> > > > > > > like this? Instead why would you not just take full control o=
ver the
> > > > > > > alt modes in user space by enabling the them one by one in wh=
at ever
> > > > > > > order you want?
> > > > > >
> > > > > > I think after the many patch iterations we went through upstrea=
ming,
> > > > > > we may have lost the point a little bit wrt/ the mode selection=
 task.
> > > > > > We talked about this on the very first iteration of this patchs=
et
> > > > > > here: https://lore.kernel.org/linux-usb/CANFp7mVWo4GhiYqfLcD_wF=
V34WMkmXncMTOnmMfnKH4vm2X8Hg@mail.gmail.com/
> > > > > >
> > > > > > The motivation behind it was to allow the kernel driver to own =
mode
> > > > > > selection entirely and not need user space intervention. The cu=
rrent
> > > > > > alt-mode drivers attempt to own the mode entry process and this=
 fails
> > > > > > when you have two or more altmode drivers loaded (i.e. displayp=
ort,
> > > > > > thunderbolt). The original goal of the mode selection task was =
to move
> > > > > > the mode entry decision away from the alt-mode driver and to th=
e port
> > > > > > driver instead.
> > > > > >
> > > > > > What's missing in the current patch series to show this is prob=
ably
> > > > > > actually calling mode_selection once all partner modes are adde=
d :)
> > > > > > Andrei should be adding that to this patch series in the next p=
atch
> > > > > > version.
> > > > > >
> > > > > > Adding the mode_selection sysfs trigger is for another reason: =
to
> > > > > > re-run mode selection after priorities have been changed in use=
rspace
> > > > > > and there is no partner hotplug. We specifically have some secu=
rity
> > > > > > policies around PCI tunnels that result in the following need:
> > > > > > * When we enable pci tunneling, we PREFER tbt over dp and would=
 like
> > > > > > to select the preferred mode. When we disable it, we PREFER dp =
over
> > > > > > TBT and would like to select the preferred mode.
> > > > > > * When users are logged out, we always prefer DP over TBT.
> > > > > > * When the system is locked, we prefer DP over TBT for new conn=
ections
> > > > > > (but existing connections can be left as TBT). When we unlock, =
we want
> > > > > > to enter the most preferred mode (TBT > DP).
> > > > > >
> > > > > > While this is do-able with the alt-mode active sysfs field, we =
would
> > > > > > basically be re-creating the priority selection done in the ker=
nel in
> > > > > > user space again. Hence why we want to expose the mode selectio=
n
> > > > > > trigger as done here.
> > > > >
> > > > > But this would be a step backwards. You want to keep the kernel i=
n
> > > > > control of the mode selection, which is fine, but then you have t=
hese
> > > > > special cases where you have to give some of the control to the u=
ser
> > > > > space. So instead of taking complete control of the mode selectio=
n in
> > > > > user space, you want to create this partial control method of
> > > > > supporting your special cases while still leaving "most" of the
> > > > > control to kernel.
> > > > >
> > > > > I don't believe this will work in all cases. I'm fine with the
> > > > > priority as a way to tell the kernel the preferred entry order, b=
ut if
> > > > > the user space needs to take control of the actual mode selection=
, it
> > > > > has to take full control of it instead of like this, partially. T=
his
> > > > > just looks incredibly fragile.
> > > > >
> > > > > So I'm still not convinced that there is any use for this. Either=
 the
> > > > > user space takes over the mode selection completely with the acti=
ve
> > > > > attribute files, or just leaves the selection completely to the k=
ernel.
> > > > >
> > > >
> > > > That's a fair stance to take. We CAN do our special cases via the
> > > > "active" sysfs node. I've had a bit more time to think about the
> > > > problem we are solving and I'd like to elaborate a little.
> > > >
> > > > When we designed this mode selection task, there were two motivatin=
g factors:
> > > > * The existing typec_displayport and typec_thunderbolt modules will
> > > > both automatically try to enter a mode when probing and that does n=
ot
> > > > work well. You want a deterministic entry order.
> > > > * There is no generic typec daemon for userspace on Linux and there
> > > > isn't always a need for one (i.e. UCSI systems). The kernel has the
> > > > most information about what any given system needs and should be ab=
le
> > > > to handle mode entry timing better.
> > > >
> > > > For those motivating factors, I think an in-kernel mode selection a=
s
> > > > designed in this series still makes sense. Let the kernel do the mo=
de
> > > > selection, inform userspace when it is completed and userspace can
> > > > simply set priorities + report success/failure/errors.
> > > > One other change we will probably want to make is to turn the partn=
er
> > > > altmode Kconfig options to boolean and roll it into the typec modul=
e.
> > > > Alt-mode module loading breaks mode selection ordering because you
> > > > can't be guaranteed the partner altmodes are loaded on the system w=
hen
> > > > you do partner altmode enumeration.
> > > >
> > > > Heikki, can you confirm we are on the same page up till this point =
at
> > > > least? The net effect here is we are moving partner altmodes
> > > > individually entering modes to centralizing mode entry in the typec
> > > > class itself.
> > >
> > > I think we are on the same page, but I don't think you can incorporat=
e
> > > the entry of the modes into the class itself (you should not do that)=
.
> > > You can't even make it a problem for the altmodes - I don't believe w=
e
> > > can make it work in the long term.
> >
> > It probably needs to be a port driver decision. UCSI based systems
> > will mostly expect that a mode has already been entered after a
> > partner connects (and reports the SUPPORTED_CAM_CHANGED bit in
> > Connector Status Change) but with UCSI 3.0, some systems could
> > potentially make this decision in kernel (via sending SET_NEW_CAM
> > <connector> 0xff 0 which would prevent the PPM/LPM from entering any
> > modes automatically). Even with cros_ec_typec, only devices supporting
> > TBT/USB4 will need a mode selection decision in the port driver (since
> > others just auto-enter DP).
> >
> > >
> > > Here multiple modes need to be handled as a set, so the set itself
> > > needs to have an object that represents it. The altmodes will be part
> > > of these "sets", but they remain independent of any particular set.
> > > So the "set" defines the order in which the modes are entered instead
> > > of the class, or any individual altmode.
> > >
> > > I don't think there is any other way to make sure that the altmodes
> > > continue to work as well independently as part of these "sets".
> > >
> > > If you guys think that this makes sense, let me know. There are a
> > > number of ways we could implement this.
> >
> > The idea you've described here of sets sounds like what this patch
> > series hopes to implement. The set is just all the partner altmodes
> > which the port supports and the ordering is the port priority for
> > those altmodes.
> >
> > >
> > > > Also, with respect to dropping the mode_selection sysfs node and
> > > > simply using the `active` fields to override:
> > > > * How can we ensure that user space does not race with the kernel m=
ode entry?
> > > > * Should we delay exposing "number_of_alternate_modes" until after
> > > > mode selection is done? Should we keep the mode_selection sysfs (or=
 a
> > > > similarly named file) as a read-only indicator of current status?
> > >
> > > Races are definitely a concern. But I don't think that is a problem i=
f
> > > we go ahead with the above idea of separating the mode relationships
> > > and entry into those "mode sets".
> >
> > Is the idea to give userspace the ability to create a set and try to
> > enter atomically? Who decides what constitutes a set?
>
> It's really up to what we want, and how we you guys want to implement
> it. If the mode selection was a device (associated with each port (or
> partner) for example), then maybe the "set" could be a driver attached
> to it. Maybe :)
>
> I'm just asking that we isolate the feature, because I think it can be
> separated in this case. I think isolating it should give some
> flexibility on things like where the control is in the end, but more
> importantly, that should minimise the impact to the existing bits and
> pieces, maybe allow the feature to be selectable, etc. etc.

Mode selection is already opt-in in the current implementation and
needs to be called by the port driver.

When integrating with existing altmode drivers, the major change will
be in the probe functions:
* When mode selection is not in use by the port driver, keep the
current behavior (automatically enter the probing altmode).
* When mode selection is in use by the port driver, do not enter the alt-mo=
de.

Port drivers that enable mode selection could also be required to
select all typec altmodes as =3DY so that they are all loaded by the
time the mode selection task runs.
i.e. the way this could work is by introducing CONFIG
TYPEC_MODE_SELECTION_SUPPORT, which selects TYPEC_DISPLAYPORT=3Dy,
TYPEC_THUNDERBOLT=3Dy, TYPEC_NVIDIA=3Dy and have port drivers select them
(i.e. CONFIG CROS_EC_TYPEC selects TYPEC_MODE_SELECTION_SUPPORT).

Does this meet your expectation for isolation?

>
> thanks,

>
> --
> heikki

