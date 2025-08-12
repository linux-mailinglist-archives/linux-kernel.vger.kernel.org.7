Return-Path: <linux-kernel+bounces-765570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89648B23A19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846C77B78D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC32D323D;
	Tue, 12 Aug 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1b5xWn4"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFC2D060D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030854; cv=none; b=uvO+Wc2ZkDjzMXKceHw6o4usydlSiBrMZaxmf2XrkyCnDRTfkPsIuD2W+h+9ZVZUUSFUdU2pb3TNJApDMeqykvHrDnqFBNw/tsR5mwjaulUcsTgUKdyDoAFV4EeQUkZcZckb+vioVrAxtICK7pd3Zo1orHe1be9B+AH/iBs+KkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030854; c=relaxed/simple;
	bh=sc5Szj9DaKl32962dz6jW5WEWwuoiEYfcZH2OgxoK/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUkuSoqsv+DEcdJ4Swocl+Jynm4UuJ4OYbJRHf45NYE7RJGljBWyArIRCrer9P5+kB/E0Xku+THei3K0ZozI/jFp4Y42Dh9zWXNQxJUzGhuLbvV/D3AzjJmR/pCB7bgMuBNTeOxvMsaSss52K0T0GK78ZYFI+hUPhDTps+TyHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c1b5xWn4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71b6703ba32so56799327b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755030850; x=1755635650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CesmGPtKuDUWY4MQccWH2mnWQ8QDSsrtS7Gzevtd68w=;
        b=c1b5xWn4aq1Kf+VgiLz+FkRPuQzE9TX/oheSON72XlP/t0DIUJZxGxeeqVJRrS+8fp
         W8pkpvh/WAlwVf6tnlOC8bTa+BLipkBqjWcghoH/2vml2+eMrRsl+yJ8FZqCck5wpvJI
         XCpU7poiYcsXILBUMiXD5G/aYpVBWk+a9oaiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030850; x=1755635650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CesmGPtKuDUWY4MQccWH2mnWQ8QDSsrtS7Gzevtd68w=;
        b=H6qAbKuOE3PscJhcahi+KVZHifDV2i8z+j5LuFwuTFpTcs4o/TsWOHQho8lN4TsQtl
         q9AXqeu6+dDcIUvodTyG5IGVcMmq9QMDDLVA6q/j/M+PKdbFbOg+Jias6DSVcNU/Oe/Q
         lhRxjKdJ0WvKHxrsycoksMH7PhhU13FqbgSEChJGhAyh8NhanRx8uxRNsgVXrIx4Xn9p
         qB77HAywqhHwXJ5VLGRPwmX3f/mhpDXkmCcqDpLrgzykeip9xhjLmvHP/tMBtGH4dXR3
         E6EO4g1RvKn+qEQvwiMQDfT6BucHTNHPYjMX6D2nLzI1Tu8uUB9bK3+9pTqRy1HAMBNh
         /6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCW3dmnjxOfoyoVxQ8kgolvSAV6DXvlb6Kh7AVqdmjER2QQjJEQfUKoEc9a9jhAw/YFgkvHQ8/15Jup/FD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0HBmPMQraxCuITMooDv/eIenOkJHre2eMo3pS5t1toDAJ/Tf
	N15AehnFsa1SJPbY0+UE/2GO5kyEvL4mmo7zMuFCf3objD+efOAsR81U3mnZkZXmA3lPfIAB+3x
	pz5qZfka3VCLRgr/tG9vCpg0d1I6FQtL87XDWVkpU
X-Gm-Gg: ASbGncswjVxfR+XlcFHsYYmJYwlxBH0ahpwVFQDi9d8oexlr2hSzF+NC3XzbMKaYt3b
	XA8GguAm/6K6hCq8YChIQeSPUQTd3E2aWbMP1nWpeDIjce4N55Cr4pZHhiNBX1TKgzGzjAQoUcw
	ukcLWzdo3G+VTpvUxQtNRG/TKT+pCFJXjeUukWEmBYXl8kUafqLU12L6GKTGjmgJxsMSzolMvPM
	f5i77M=
X-Google-Smtp-Source: AGHT+IEerpIXF67J3Ps9rtYB7F6lok4NcCvujccjf6KzzrBDAggAVaGU8Y6kayvIYrX4gW3PQuZjQojWFbC0ahif9Zo=
X-Received: by 2002:a05:690c:688c:b0:71c:1d31:e693 with SMTP id
 00721157ae682-71d4e52955cmr7726027b3.24.1755030850150; Tue, 12 Aug 2025
 13:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804090340.3062182-1-akuchynski@chromium.org>
 <20250804090340.3062182-5-akuchynski@chromium.org> <aJn9ZSy3w4zW4Xvq@kuha.fi.intel.com>
 <CANFp7mVUFZyF8z0dN-Mo7ntPOXh06ZD0RH5GyvJJymOXrhSD1g@mail.gmail.com> <aJsoS3EXgoLP-f-E@kuha.fi.intel.com>
In-Reply-To: <aJsoS3EXgoLP-f-E@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Tue, 12 Aug 2025 13:33:58 -0700
X-Gm-Features: Ac12FXzX_w_wK4vvlBMCy61zeWwZCbfhZWbGwyjBDcHuxh7vMIEodeZCUXnKDwU
Message-ID: <CANFp7mW92PgjSWyJq7Bz6ZLJ8ZgnsCRw2kAYAjKX3yymKW9hBA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] usb: typec: Expose mode priorities via sysfs
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andrei Kuchynski <akuchynski@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:41=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Abhishek,
>
> On Mon, Aug 11, 2025 at 11:22:38AM -0700, Abhishek Pandit-Subedi wrote:
> > On Mon, Aug 11, 2025 at 7:25=E2=80=AFAM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi Andrei,
> > >
> > > On Mon, Aug 04, 2025 at 09:03:33AM +0000, Andrei Kuchynski wrote:
> > > > This patch introduces new sysfs attributes to allow users to config=
ure
> > > > and view Type-C mode priorities.
> > > >
> > > > `priority`, `usb4_priority` attributes allow users to assign a nume=
ric
> > > > priority to DisplayPort alt-mode, Thunderbolt alt-mode, and USB4 mo=
de.
> > > >
> > > > `mode_priorities` - read-only attribute that displays an ordered li=
st
> > > > of all modes based on their configured priorities.
> > > >
> > > > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-typec |  33 +++++
> > > >  drivers/usb/typec/Makefile                  |   2 +-
> > > >  drivers/usb/typec/class.c                   | 103 +++++++++++++++-
> > > >  drivers/usb/typec/class.h                   |   1 +
> > > >  drivers/usb/typec/mode_selection.c          | 130 ++++++++++++++++=
++++
> > > >  drivers/usb/typec/mode_selection.h          |  23 ++++
> > > >  include/linux/usb/typec_altmode.h           |   7 ++
> > > >  7 files changed, 295 insertions(+), 4 deletions(-)
> > > >  create mode 100644 drivers/usb/typec/mode_selection.c
> > > >  create mode 100644 drivers/usb/typec/mode_selection.h
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Document=
ation/ABI/testing/sysfs-class-typec
> > > > index 38e101c17a00..575dd94f33ab 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > > @@ -162,6 +162,39 @@ Description:     Lists the supported USB Modes=
. The default USB mode that is used
> > > >               - usb3 (USB 3.2)
> > > >               - usb4 (USB4)
> > > >
> > > > +             What:           /sys/class/typec/<port>/<alt-mode>/pr=
iority
> > > > +Date:                July 2025
> > > > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > > > +Description:
> > > > +             Displays and allows setting the priority for a specif=
ic alt-mode.
> > > > +             When read, it shows the current integer priority valu=
e. Lower numerical
> > > > +             values indicate higher priority (0 is the highest pri=
ority).
> > > > +             If the new value is already in use by another mode, t=
he priority of the
> > > > +             conflicting mode and any subsequent modes will be inc=
remented until they
> > > > +             are all unique.
> > > > +             This attribute is visible only if the kernel supports=
 mode selection.
> > > > +
> > > > +             What:           /sys/class/typec/<port>/usb4_priority
> > > > +Date:                July 2025
> > > > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > > > +Description:
> > > > +             Displays and allows setting the priority for USB4 mod=
e. Its behavior and
> > > > +             priority numbering scheme are identical to the genera=
l alt-mode
> > > > +             "priority" attributes.
> > >
> > > I'm not sure those above two file make any sense.
> > >
> > > > +What:                /sys/class/typec/<port>/mode_priorities
> > > > +Date:                July 2025
> > > > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > > > +Description: This read-only file lists the modes supported by the =
port,
> > > > +             ordered by their activation priority. It reflects the=
 preferred sequence
> > > > +             the kernel will attempt to activate modes (DisplayPor=
t alt-mode,
> > > > +             Thunderbolt alt-mode, USB4 mode).
> > > > +             This attribute is visible only if the kernel supports=
 mode selection.
> > > > +
> > > > +             Example values:
> > > > +             - "USB4 Thunderbolt3 DisplayPort"
> > > > +             - "DisplayPort": the port only supports Displayport a=
lt-mode
> > >
> > > Why not just use this one instead so that you write the highest
> > > priority mode to it?
> >
> > Feedback from Greg on
> > https://lore.kernel.org/linux-usb/2025070159-judgingly-baggage-042a@gre=
gkh/:
> >
> > "quote":
> > Multiple value sysfs files are generally frowned apon.  sysfs files tha=
t
> > also have to be manually parsed in the kernel are also frowned apon.
> > Are you _SURE_ there is no other way that you could possibly do this?
> >
> > The reason we originally suggested a single "mode priorities" was
> > because we weren't sure what to do about USB4. Otherwise, it makes
> > sense to push a priority field to each alt_mode sysfs group and keep
> > it internally ordered. This is where I really wish we just treated
> > USB4 as an alternate mode :)
>
> I'm probable forgetting something, but I'm pretty sure I already told
> you guys that I agree, it should be an alt mode. So why not just
> register a special alt mode for it?

We interpreted this a bit differently (as just rename it):
https://patchwork.kernel.org/project/linux-usb/patch/20250616133147.1835939=
-5-akuchynski@chromium.org/#26431992

Thanks for the clarification here. In that case, we'll get rid of
`usb_priorities` and `usb_results` and just add a new alternate mode
for USB4. The vendor ids list on usb.org
(https://www.usb.org/sites/default/files/vendor_ids072325_1.pdf) shows
0xff00 for USB4 so that's what we'll use. So the attributes should be:
.active (similar to other modes), .mode =3D 1 (unused really), .svid =3D
0xff00, .vdo =3D <usb eudo> (if supported).

>
> Sorry if I missed something.
>
> > As such, our current API recommendation looks like the following:
> >
> > * On each port, we lay out priorities for all supported alternate modes=
 + USB4.
>
> This first part I understand.
>
> > * We expose a file to trigger the mode selection task. Reading from it
> > gives you the current status of mode selection (single value).
> > * Detailed results from mode entry are pushed to the mode sysfs group
> > (via entry_results). Converting these to UEVENT is fine but a more
> > persistent value in debugfs would be useful for debugging.
>
> This second part I would really like to handle separately, after we
> have a solution for the first part.

Ack. We'll reduce the series so it's easier to review for mode_priorities f=
irst.

>
> thanks,
>
> --
> heikki

