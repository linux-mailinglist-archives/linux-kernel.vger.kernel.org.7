Return-Path: <linux-kernel+bounces-748860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33930B146D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7A541611
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E021D3DC;
	Tue, 29 Jul 2025 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksx1KzpE"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57B221704;
	Tue, 29 Jul 2025 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759588; cv=none; b=dh3aZg7ji76A/5LD+9e7qTsHBvCBxJ+QvdE642uyPpjLZJouZZUa/wNtIDEnkRodGhPC2y2BUx52nlOWOUs8OVU3hRBHyI2TsFRV3P7ACRMiOTBexoNxfQjpPToqRpQQiartzIT2eKKtgf19fbIcQC0Ig3UdD1SjTClhleSub50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759588; c=relaxed/simple;
	bh=vgYGedtd6MYvHM7mMWNHn+golN7U9Jf+B3AgNKwtOCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx5HbGosmLJgpgKvyBRhnakN95cfDxnYO8bZ6PoqFv06wSpXDSNRjlxF9TkZfQySN9ClzGT9d5ZNj/a2ERk2YbV1aoyxgVNGHNAT0bqL7BLfaKDBfoLFbdDgE54futrO3+vWsmZOzzagkz02Gk53Bq3S/U6QiQ9RDLbLiLzr8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksx1KzpE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab39fb71dbso53413091cf.3;
        Mon, 28 Jul 2025 20:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753759586; x=1754364386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQvdDiQnsqyrmek3KChLb2hBIpcbR+Huy8lPmt1fCtc=;
        b=ksx1KzpE4GKV+z2XgbJBJxHvTgrMX6kARPDGbFrA0DZshdgFC5z8+C+zWVPjH9x7Ho
         hPDtUUfaiHXc63gmNxybH1MYk99fBYgWuFT0hgRuHp48lExsoz3Ays8BFdVbKQJz69w0
         1PzHhbqq7XloS8KACk1sYNtktfm3DWushd/nhnGjFWqFYklr/Ls/IBWOei5eHR+jskJk
         FBd5PNO2M8U+9v9Zk0asemSkY+e9v5i2m2c7E2qmE9XfFx6dXI7Hu6C6d/0tIq711ZUE
         K2R2S9kNBW3HwxLsEkDhP+dRxgLZ8CFL+iKiCj9GMSwrhYKXmn37mqkSAnkEMpytjDMc
         P+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753759586; x=1754364386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQvdDiQnsqyrmek3KChLb2hBIpcbR+Huy8lPmt1fCtc=;
        b=lW9rRB4RLV/R4BvGNGXlSLWJs7kfdxrGLb3KWTxOBvoFwl9PtTYguq1koC/rzDB76T
         uwKfJD58+956Pms2dFcBcydZwECuU1n7zRfrwHZZtfuYx+Gi3ERTJUDkSFcY27pbnpEI
         0nECOLa8fOG3+IMjZiKsjWnHw0/GmD8/sVRpKgHi7fAxRXDynNWQlOjNXR6ub+0j/o7Z
         zlOO2b9DDp0GOa3hY9KnPmFjQyQWczNF0S4INdK6OZ1vkO4eRv7+OLvzaEqH6pajZH3U
         8BgerZpj/CGeEw07pAz8cpKV/wAMXSasxT2fWEDU/F7bQJwlROokK5PcvXZIYc8Igwpq
         LIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZLu3QZYQp1fpfL9zhpAlMKcmeZ1WzzPbwNwVSUfKQug4YRZIJUPDCxpSaZnmRyN9WVmWOM16cjMk=@vger.kernel.org, AJvYcCVjQP9rz7AuzYzD1RPI8Sod84Z3UBujmaqrNlr3Y+rSNRux1mKh0r77b55yOA8qaQmWR4vCIUOOMYJ9ys4N@vger.kernel.org, AJvYcCVr/OtRwsZ+MfLsb4m6hii4cyv3EAPzKNaanENL0PLpBlxgTHSeOGbAOHJQ8cBli9e7KR0tbW3jXOrNhmohuqt5rmJ5oA==@vger.kernel.org, AJvYcCX6oghJE1TfzOhdh1tA6QbW9GPeRvvYfeABNHQJrQ0dPqUFc9iQxdpIlJE3Wp4yrKXfYDjfTNyx66Aez3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxzzNl0HSfoNWs7qFArAuWXFBE7aCkc8uTQ5PmA19np97n/bI
	jf4vh/2DnSljGU0zbNAa61sNrWk3T9FPZX+V/YITtydFEz070ybTxzn4zRd4aJjoqj8IVNs2xG4
	6kU0WrVJHI3r61X/xBRVuKJqoPA4oT+M=
X-Gm-Gg: ASbGncv9U9d9IpyELZtDr9n67KZmpmwIy/r9A3FfA6/w1jgAU/KNEoH/Y564hFGMus9
	Pmid3mkQFaEoWWckSgCh+qCy56bkcAunMHIDr2j2uc4t6Xjc9hRn0kAHDmLFKnXu80a6VDiavGV
	+yimo9NAbvYYPwy8aP81qar4NycvSmSmxR78Pndo5XyMzgLM3B2/YK0Q7hoRMr7wr/T3NOCWL/F
	pnZAcA0YtDgW3W3eaw=
X-Google-Smtp-Source: AGHT+IE/Ne0GanegMDZVtx6xi+TT5LItODDPJdzGGVmCcxKsUnYeJ5GQ+EGFc7/6vZhkjU83nc3Fy4ezLizbXA47hw8=
X-Received: by 2002:a05:6214:e46:b0:705:c148:26a0 with SMTP id
 6a1803df08f44-707205a8958mr215405996d6.31.1753759585534; Mon, 28 Jul 2025
 20:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
 <20250726204041.516440-5-derekjohn.clark@gmail.com> <5e910391-5769-40dc-882d-90f79888c772@gmx.de>
In-Reply-To: <5e910391-5769-40dc-882d-90f79888c772@gmx.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 28 Jul 2025 20:26:14 -0700
X-Gm-Features: Ac12FXzgN5WmqWfFO6HCb9h408sHwelxzUryqXtjkNigmT-pcUQBF9kPdrDn5cY
Message-ID: <CAFqHKT=n-G-PaaF24A_S7BL3Pp_8gf=kznmX36_=_YKLx40YSg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] platform/x86: (ayn-ec) Add AYN EC Platform Documentation
To: Armin Wolf <W_Armin@gmx.de>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Alok Tiwari <alok.a.tiwari@oracle.com>, David Box <david.e.box@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:04=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 26.07.25 um 22:40 schrieb Derek J. Clark:
>
> > Adds ABI documentation for the ayn-ec platform driver
> >
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> >   .../ABI/testing/sysfs-platform-ayn-ec         | 59 ++++++++++++++++++=
+
> >   MAINTAINERS                                   |  1 +
> >   2 files changed, 60 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-ayn-ec b/Document=
ation/ABI/testing/sysfs-platform-ayn-ec
> > new file mode 100644
> > index 000000000000..32cb6f7ca2fc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-ayn-ec
> > @@ -0,0 +1,59 @@
> > +What:                /sys/class/hwmon/hwmon[0-9]/pwm1_enable
> > +Date:                July 2025
> > +KernelVersion:       6.17
>
> I think that this driver will miss 6.17, better use 6.18 instead. Also yo=
u do not have to
> document standard hwmon sysfs attributes. For documenting the special PWM=
 mode i suggest that
> you add some documentation under Documentation/hwmon/.
>
> Additionally please add the new files to the MAINTAINERS entry of the ass=
ociated driver.
>
> Thanks,
> Armin Wolf
>

Can do, thanks.
Derek

> > +Contact:     "Derek J. Clark" <derekjohn.clark@gmail.com>
> > +Description:
> > +             This sets the PWM fan mode of operation. Valid values are=
 [0-3].
> > +    Values [0-2] conform with standard hwmon operating modes. Value 3
> > +    enables user defined fan curve settings.
> > +
> > +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> > +
> > +What:                /sys/class/hwmon/hwmon[0-9]/pwm1_auto_point[1-5]_=
pwm
> > +Date:                July 2025
> > +KernelVersion:       6.17
> > +Contact:     "Derek J. Clark" <derekjohn.clark@gmail.com>
> > +Description:
> > +             This sets the PWM fan duty cycle for the given index of t=
he fan curve.
> > +    When the temperature reaches the corresponding pwm1_auto_point[1-5=
]_temp,
> > +    the EC will automatically increase the fan duty cycle to the given=
 value.
> > +
> > +    Values are [0-255]
> > +
> > +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> > +
> > +What:                /sys/class/hwmon/hwmon[0-9]/pwm1_auto_point[1-5]_=
temp
> > +Date:                July 2025
> > +KernelVersion:       6.17
> > +Contact:     "Derek J. Clark" <derekjohn.clark@gmail.com>
> > +Description:
> > +             This sets the activation temperature for the given index =
of the fan curve.
> > +    When the temperature reaches the given value, the EC will automati=
cally
> > +    increase the fan duty cycle to the corresponding pwm1_auto_point[1=
-5]_pwm
> > +    value.
> > +
> > +    Values are [0-100]
> > +
> > +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> > +
> > +What:                /sys/class/leds/ayn:rgb:joystick_rings/effect
> > +Date:                July 2025
> > +KernelVersion:       6.17
> > +Contact:     "Derek J. Clark" <derekjohn.clark@gmail.com>
> > +Description:
> > +             This controls the display effect of the RGB interface.
> > +
> > +    Values are monocolor or breathe.
> > +
> > +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> > +
> > +What:                /sys/class/leds/ayn:rgb:joystick_rings/effect_ind=
ex
> > +Date:                July 2025
> > +KernelVersion:       6.17
> > +Contact:     "Derek J. Clark" <derekjohn.clark@gmail.com>
> > +Description:
> > +             This displays the available options for the effect attrib=
ute.
> > +
> > +    Values are monocolor or breathe.
> > +
> > +    Applies to AYN Loki and Tectoy Zeenix lines of handheld devices.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b816883fe7d..199bebbffa0d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4039,6 +4039,7 @@ AYN PLATFORM EC DRIVER
> >   M:  Derek J. Clark <derekjohn.clark@gmail.com>
> >   L:  platform-driver-x86@vger.kernel.org
> >   S:  Maintained
> > +F:   Documentation/ABI/testing/sysfs-platform-ayn-ec
> >   F:  drivers/platform/x86/ayn-ec.c
> >
> >   AZ6007 DVB DRIVER

