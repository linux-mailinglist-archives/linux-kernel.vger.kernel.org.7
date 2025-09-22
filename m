Return-Path: <linux-kernel+bounces-826609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF7EB8EEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD333A919A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54042EE268;
	Mon, 22 Sep 2025 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B80nH3h9"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4823CB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758514523; cv=none; b=o2ORPHlWoW1QgmWbgJw9cqb5c0KVsZd2ptCr1HN6oi19mkT8kZwoyu60jRUFmIPyX9xO0IaMsDFKl/GTnGoQ2w0O9zXscau1f6OqGXFwapt+fp+O8DbWtFSRfvTb1v3BNGtF/D+gfw8zgSSP9P61KNNuFtEaU+qwozJ5BBOXjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758514523; c=relaxed/simple;
	bh=Dj1FiyXZnI6zjDauahPBwi3djRXbi1Ji2H6ZnCg2esM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aySlDpbXtHPbWz0hWtjAfHnr87iwWyxw92Yf5gtJg3mAhGgHD3+Tck0X15Q70wOYG0jFboLjJEUNdHfRzqNvhdvUg7jkric3teCUEqssqexBtdoh/Da1ArQw7HY5EuCW4+XNUTfDIlhHFO3pTab2HDFu7P/YCujrfMiunUhPKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B80nH3h9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54dc768f11so2841888a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758514520; x=1759119320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9g/KVsrwC/FwEow5Ck08lDA75NOhOHaeTQv2RU/j14=;
        b=B80nH3h9cLUj9SGHMpQ5Dh00ZWRapagF0AV+DEKGTAiRXFwxAzpvIwolK+W6WAevBq
         VwVNvtpkYA7q1YWfSERW+QX17P8T7HHXs7CvmMsyoTh5n0HW5pPZi5UGnVjgInBO1EcO
         gPrgeAK5GHaFuoqvtebgP0N6IzIBxRn4cAgURawOeRF6m0iqvbmRiN6a4l/MSp1tviF1
         TEbFLb6aEYoKbIeeaTDvzTihN/jrPTTGYI5bLrJMDNNI9wxZHwz3Sjx9EGHstnjDkbv9
         DN5506RU2v9puXtimhRLBRcJmf/7B4uGeTw8MN2FwM98kAF5NZpHkMsv/a1Ca98uKRyr
         zniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758514520; x=1759119320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9g/KVsrwC/FwEow5Ck08lDA75NOhOHaeTQv2RU/j14=;
        b=EX1UVzTU/Y6hsA1QqwOr4vqUNTE/9C0R8urzxYB9v6vyWDd01nOxgMNgEYf3Xu+dFU
         L80QEsPu/j0vxmwcrUubYJwtlgp8TR/fWKRWwqsOXAOInG0Now1G+g1uCqFlmOFnX04Y
         mRMIR7oQyLsqF5Mk6Wxt1+Xm2lbaO4E+ZZQ9bIN8i1g8hyMxj0nEAnnYKh0kSRpeTwFi
         pGASM+ibgfZQmMKi2wX9IyW2GqXEyKCz0yloOULh8WAV5Yt7MxI4jwcwdfca5M1pne2f
         xSu9EtJMJXU4t/5HXlJp7apGlkE6pU9mX1v4AHq5r66qbaZgbqhIp4JpXuq0781GCYmc
         qWZg==
X-Forwarded-Encrypted: i=1; AJvYcCV42+tcm1JkiYkaSE/WavlTt0a1yNJ1XW/MlFYJ2mmpeK0hH3iRqJ+16oR2am6qo15FRq4XBakOKQIMVKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUHrJFEEpVhTUQkq0xAnc6Kd95nW23WTkv6Zs7dtZMISivlEV
	KQrNu9frrzC7PYBb6aSQEdUbYWnfSdkBJtmk+S7YQHaYdSRkFa4xLdOfhe3aWBSucUBi+J/x3nZ
	cYwtldkcLULf1ctOoauR8eYxNZRxOxps=
X-Gm-Gg: ASbGncskXNkKnkCgpzUUY7AtjYqvdNNBViRhurdQssF2gRQPt+JKlmoCvBBYAFh5qs5
	UqCNL1BL9bsx/vLrHVFsK97+tlsfLpDDvSF5vWYPG+2xOQ9mCAjjxISGpjSopxltEf9CZBZJdsy
	cci5zIDNntzuB/+IHAhQHR/pZq3p/njZiqeXOr3GmMeII69X7jwIFNIFW0AGd6e86n+z+MgczQP
	sf1
X-Google-Smtp-Source: AGHT+IGlSVg6WtdubAmSf7YKVFuHJS2Il6Ej6yGRYXbo1aUBqyvNBamQdFvQDLFBAPqi0On9z7iSt09urim2/WABPIo=
X-Received: by 2002:a17:903:1b10:b0:269:6e73:b90a with SMTP id
 d9443c01a7336-269ba4107d9mr136499045ad.15.1758514520106; Sun, 21 Sep 2025
 21:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901135308.52340-1-vishnuocv@gmail.com> <cr7jgtztf65balwxu6cpu6hqzzzluitrwu2f66o75kcip5k2zd@sxixvhotead5>
In-Reply-To: <cr7jgtztf65balwxu6cpu6hqzzzluitrwu2f66o75kcip5k2zd@sxixvhotead5>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Mon, 22 Sep 2025 13:14:43 +0900
X-Gm-Features: AS18NWBEvf7oKPrcDE2KiwIRFNO9VSMjG3cdhElEXQj5KA1CgxREnOpc6EmtHFo
Message-ID: <CABxCQKtmJb81UK-3j8sd+FW=2tjc5UkN4nu9L=GcDOG=GinHuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] input: mouse: trackpoint: Add doubletap
 enable/disable support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: hmh@hmh.eng.br, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	derekjohn.clark@gmail.com, mpearson-lenovo@squebb.ca, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
	vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitry,

Thanks a lot for the comments.




On Thu, Sep 18, 2025 at 1:57=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Vishnu,
>
> On Mon, Sep 01, 2025 at 10:53:05PM +0900, Vishnu Sankar wrote:
> > Add support for enabling and disabling doubletap on TrackPoint devices
> > that support this functionality. The feature is detected using firmware
> > ID and exposed via sysfs as `doubletap_enabled`.
> >
> > The feature is only available on newer ThinkPads (2023 and later).The d=
river
> > exposes this capability via a new sysfs attribute:
> > "/sys/bus/serio/devices/seriox/doubletap_enabled".
> >
> > The attribute is only created if the device is detected to be capable o=
f
> > doubletap via firmware and variant ID checks. This functionality will b=
e
> > used by platform drivers such as thinkpad_acpi to expose and control do=
ubletap
> > via user interfaces.
> >
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > Changes in v2:
> > - Improve commit messages
> > - Sysfs attributes moved to trackpoint.c
> > - Removed unnecessary comments
> > - Removed unnecessary debug messages
> > - Using strstarts() instead of strcmp()
> > - is_trackpoint_dt_capable() modified
> > - Removed _BIT suffix and used BIT() define.
> > - Reverse the trackpoint_doubletap_status() logic to return error first=
.
> > - Removed export functions as a result of the design change
> > - Changed trackpoint_dev->psmouse to parent_psmouse
> > - The path of trackpoint.h is not changed.
> > Changes in v3:
> > - No changes.
> > ---
> >  drivers/input/mouse/trackpoint.c | 149 +++++++++++++++++++++++++++++++
> >  drivers/input/mouse/trackpoint.h |  15 ++++
> >  2 files changed, 164 insertions(+)
> >
> > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/tra=
ckpoint.c
> > index 5f6643b69a2c..c6f17b0dec3a 100644
> > --- a/drivers/input/mouse/trackpoint.c
> > +++ b/drivers/input/mouse/trackpoint.c
> > @@ -16,6 +16,8 @@
> >  #include "psmouse.h"
> >  #include "trackpoint.h"
> >
> > +static struct trackpoint_data *trackpoint_dev;
>
> Please do not use globals.
Understood.
>
> > +
> >  static const char * const trackpoint_variants[] =3D {
> >       [TP_VARIANT_IBM]                =3D "IBM",
> >       [TP_VARIANT_ALPS]               =3D "ALPS",
> > @@ -63,6 +65,21 @@ static int trackpoint_write(struct ps2dev *ps2dev, u=
8 loc, u8 val)
> >       return ps2_command(ps2dev, param, MAKE_PS2_CMD(3, 0, TP_COMMAND))=
;
> >  }
> >
> > +/* Read function for TrackPoint extended registers */
> > +static int trackpoint_extended_read(struct ps2dev *ps2dev, u8 loc, u8 =
*val)
> > +{
> > +     u8 ext_param[2] =3D {TP_READ_MEM, loc};
> > +     int error;
> > +
> > +     error =3D ps2_command(ps2dev,
> > +                         ext_param, MAKE_PS2_CMD(2, 1, TP_COMMAND));
> > +
> > +     if (!error)
> > +             *val =3D ext_param[0];
> > +
> > +     return error;
> > +}
> > +
> >  static int trackpoint_toggle_bit(struct ps2dev *ps2dev, u8 loc, u8 mas=
k)
> >  {
> >       u8 param[3] =3D { TP_TOGGLE, loc, mask };
> > @@ -393,6 +410,131 @@ static int trackpoint_reconnect(struct psmouse *p=
smouse)
> >       return 0;
> >  }
> >
> > +/* List of known incapable device PNP IDs */
> > +static const char * const dt_incompatible_devices[] =3D {
> > +     "LEN0304",
> > +     "LEN0306",
> > +     "LEN0317",
> > +     "LEN031A",
> > +     "LEN031B",
> > +     "LEN031C",
> > +     "LEN031D",
> > +};
> > +
> > +/*
> > + * checks if it=E2=80=99s a doubletap capable device
> > + * The PNP ID format eg: is "PNP: LEN030d PNP0f13".
> > + */
> > +static bool is_trackpoint_dt_capable(const char *pnp_id)
> > +{
> > +     const char *id_start;
> > +     char id[8];
> > +
> > +     if (!strstarts(pnp_id, "PNP: LEN03"))
> > +             return false;
> > +
> > +     /* Points to "LEN03xxxx" */
> > +     id_start =3D pnp_id + 5;
> > +     if (sscanf(id_start, "%7s", id) !=3D 1)
> > +             return false;
> > +
> > +     /* Check if it's blacklisted */
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(dt_incompatible_devices); ++i=
) {
> > +             if (strcmp(id, dt_incompatible_devices[i]) =3D=3D 0)
> > +                     return false;
> > +     }
> > +     return true;
> > +}
> > +
> > +/* Trackpoint doubletap status function */
> > +static int trackpoint_doubletap_status(bool *status)
> > +{
> > +     struct trackpoint_data *tp =3D trackpoint_dev;
> > +     struct ps2dev *ps2dev =3D &tp->parent_psmouse->ps2dev;
> > +     u8 reg_val;
> > +     int rc;
> > +
> > +     /* Reading the Doubletap register using extended read */
> > +     rc =3D trackpoint_extended_read(ps2dev, TP_DOUBLETAP, &reg_val);
> > +     if (rc)
> > +             return rc;
> > +
> > +     *status =3D reg_val & TP_DOUBLETAP_STATUS ? true : false;
> > +
> > +     return 0;
> > +}
> > +
> > +/* Trackpoint doubletap enable/disable function */
> > +static int trackpoint_set_doubletap(bool enable)
> > +{
> > +     struct trackpoint_data *tp =3D trackpoint_dev;
> > +     struct ps2dev *ps2dev =3D &tp->parent_psmouse->ps2dev;
> > +     static u8 doubletap_state;
> > +     u8 new_val;
> > +
> > +     if (!tp)
> > +             return -ENODEV;
> > +
> > +     new_val =3D enable ? TP_DOUBLETAP_ENABLE : TP_DOUBLETAP_DISABLE;
> > +
> > +     if (doubletap_state =3D=3D new_val)
> > +             return 0;
> > +
> > +     doubletap_state =3D new_val;
> > +
> > +     return trackpoint_write(ps2dev, TP_DOUBLETAP, new_val);
> > +}
> > +
> > +/*
> > + * Trackpoint Doubletap Interface
> > + * Control/Monitoring of Trackpoint Doubletap from:
> > + * /sys/bus/serio/devices/seriox/doubletap_enabled
> > + */
> > +static ssize_t doubletap_enabled_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +     struct serio *serio =3D to_serio_port(dev);
> > +     struct psmouse *psmouse =3D psmouse_from_serio(serio);
> > +     struct trackpoint_data *tp =3D psmouse->private;
> > +     bool status;
> > +     int rc;
> > +
> > +     if (!tp || !tp->doubletap_capable)
> > +             return -ENODEV;
> > +
> > +     rc =3D trackpoint_doubletap_status(&status);
> > +     if (rc)
> > +             return rc;
> > +
> > +     return sysfs_emit(buf, "%d\n", status ? 1 : 0);
> > +}
> > +
> > +static ssize_t doubletap_enabled_store(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     const char *buf, size_t count)
> > +{
> > +     struct serio *serio =3D to_serio_port(dev);
> > +     struct psmouse *psmouse =3D psmouse_from_serio(serio);
> > +     struct trackpoint_data *tp =3D psmouse->private;
> > +     bool enable;
> > +     int err;
> > +
> > +     if (!tp || !tp->doubletap_capable)
> > +             return -ENODEV;
> > +
> > +     err =3D kstrtobool(buf, &enable);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D trackpoint_set_doubletap(enable);
> > +     if (err)
> > +             return err;
> > +
> > +     return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(doubletap_enabled);
> > +
> >  int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> >  {
> >       struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> > @@ -425,6 +567,9 @@ int trackpoint_detect(struct psmouse *psmouse, bool=
 set_properties)
> >       psmouse->reconnect =3D trackpoint_reconnect;
> >       psmouse->disconnect =3D trackpoint_disconnect;
> >
> > +     trackpoint_dev =3D psmouse->private;
> > +     trackpoint_dev->parent_psmouse =3D psmouse;
> > +
> >       if (variant_id !=3D TP_VARIANT_IBM) {
> >               /* Newer variants do not support extended button query. *=
/
> >               button_info =3D 0x33;
> > @@ -470,6 +615,10 @@ int trackpoint_detect(struct psmouse *psmouse, boo=
l set_properties)
> >                    psmouse->vendor, firmware_id,
> >                    (button_info & 0xf0) >> 4, button_info & 0x0f);
> >
> > +     tp->doubletap_capable =3D is_trackpoint_dt_capable(ps2dev->serio-=
>firmware_id);
> > +     if (tp->doubletap_capable)
> > +             device_create_file(&psmouse->ps2dev.serio->dev, &dev_attr=
_doubletap_enabled);
>
> Please use existing facilities in psmouse driver to define and register
> protocol-specific attributes. Use is_visible() to control whether the
> attribute is accessible or not.

Got it.
Will change this.
>
> Thanks.
>
> --
> Dmitry



--

Regards,

      Vishnu Sankar
     +817015150407 (Japan)

