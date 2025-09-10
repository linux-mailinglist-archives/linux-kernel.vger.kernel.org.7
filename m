Return-Path: <linux-kernel+bounces-810890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A5B52129
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8600358564A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E902D7806;
	Wed, 10 Sep 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZMt4LIT"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D6329F02
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532890; cv=none; b=Py3Cu3e+vF+zhQ6vbvERZo7XqAafmlIuX4srUn94yEVTd8ZKPRGon8b1gNhA3YBvMXEC+zeSg9f13ijhM+MTvmZ9PunuhgEiMVJ5nE5sFELeI2wJlZRNqL8NzNopeX6qPGcAqYvtWYdl2mfSmuNdNbnyHrYrSaFYH+QGFpJCcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532890; c=relaxed/simple;
	bh=TlFZ876ym1zPhLDfhX7aHxJ50xGVPk5BB2YMzIfIBGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUzJR0sMJYVywROXw2Yde9wYKu+wXAP7PBA3ls60qVIfUZHBkW1snnwnoXF3IrbwWptdRIpo8dFEiegC3puC6y3OtGYDhOzOy6mfQ8xvkDmphBqA0RyrLX/9G0ybyjVwE5UdOoHzazEPQ2sPo1PKqhQ+W69qv/jXJ1fjXnaT1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nZMt4LIT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4d5886f825so17269a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757532888; x=1758137688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7nv+RpfQptx2Dl6xXJ4qT+jcDztk0WNklxglJQoI+8=;
        b=nZMt4LITvt9xzu2JA8K6zTT/bOZybYFNnYK5vEWgzNDAziGl9aTXWbCx4Prc6o74Yq
         ilEE72aRFZ5VSMCVDFCiMxYPYxtKJXFVbR+IEocRAJyyTJJA5i+k1v+UMYI1+V23gOVM
         5Oc0S1iwdHnbJAyIJvBJSqGItcxJaKXHvPwMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532888; x=1758137688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7nv+RpfQptx2Dl6xXJ4qT+jcDztk0WNklxglJQoI+8=;
        b=OWaT36g9t0Ug3K9uN3KUf6k3wltlEC343NPKW3SvnDnV0FF8mW5nhIIXo6zNUdIIqf
         rC+o4XnAgeVipeP/GO8F9cnr7L21V8gZvrh2TRNsgwfoJ5wdkgIoZp7PCZ/ugFpWVx/x
         EiozFl9dMNcoi2rvOsTiVtQebJR8HjED8eOxZUNn0ZHvfjqKsnAnpWha60qO3yBWMUzW
         Sz2QOh53x5mYcJM0go2NtF1AActeKGfgvRZaoWNY7t8JLkxO9SJx11H6tD2ZvQduUiZw
         LMsMdqC9UMlcvytoPsI67hyaRrMYBspUreMZCGKK8hcXCj/50pk4UbTMIbq3NcW6ZAfJ
         Wg+w==
X-Forwarded-Encrypted: i=1; AJvYcCXGUQLaRJWA5UFpy8p3U7xlPDmAmk/F4UkR1z+u1GjM8aeYNExJ5avNdiuzaMkOwaSax6TxmjvLDg0DWN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmmTtp96EJIWXiGsaKdfgGG3voc+Ze3ivOtd6OzI6k0bNoxDm
	+VptJVl6x5ZK1/U5gdI3JFNeGhddKiSqvAy1S8OqEBjNn5sWmxza1m9mjEE4/Rfu+uHM7pssfW8
	5OFbuJklccyWJX2Ub3pgw1T5udoVkfDFKQ9cDUODv
X-Gm-Gg: ASbGnctZOpUTuCEA2hFh916REykPvHp/DeoyxPfa/Y9qGfaD4ywsteDcBgenpVDRPtu
	xIa3c2IsNiNRReU1QQGH3d4Usu17MH+0OKEja5A8cR337VvIIIRQVhJnFhk10EAVmfV5fLR47+O
	U/yBv5chOp/6VKdOPCCPEB9Q+61jcTNnKlzhMu8WXMDkrv71YDdm0UBrsC8yTwaax4/1SDcQIgf
	MJpWD0j32je0XUYGAwbjCa78rNCfaxK2AQ=
X-Google-Smtp-Source: AGHT+IE/at+K4KcGofhNw+REQdpZKQ8VO1T6F/D0h+7ljw7nkukWyHLVVN9Bi1RQy5b2/QZoegCU8M/V8D5zD+/sXjk=
X-Received: by 2002:a17:903:4b4e:b0:24a:a724:717f with SMTP id
 d9443c01a7336-25173301d16mr220825655ad.47.1757532888514; Wed, 10 Sep 2025
 12:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-6-akuchynski@chromium.org> <2025091028-darkish-washcloth-3d02@gregkh>
In-Reply-To: <2025091028-darkish-washcloth-3d02@gregkh>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Wed, 10 Sep 2025 19:34:35 +0000
X-Gm-Features: Ac12FXxPC50d353IUIsG2_cG43UVWgmx2EKjnyX-DHWSloYkCCDiVnxHD9i8OX4
Message-ID: <CAMMMRMcqVMeyHnGHPsr6XH+npY2foCXae6psOhCLz1C6+bGPYA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] usb: typec: Expose alternate mode priority via sysfs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 05, 2025 at 02:22:06PM +0000, Andrei Kuchynski wrote:
> > This patch introduces a priority sysfs attribute to the USB Type-C
> > alternate mode port interface. This new attribute allows user-space to
> > configure the numeric priority of alternate modes managing their prefer=
red
> > order of operation.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec | 11 +++++++
> >  drivers/usb/typec/class.c                   | 32 ++++++++++++++++++++-
> >  2 files changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentatio=
n/ABI/testing/sysfs-class-typec
> > index 38e101c17a00..dab3e4e727b6 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -162,6 +162,17 @@ Description:     Lists the supported USB Modes. Th=
e default USB mode that is used
> >               - usb3 (USB 3.2)
> >               - usb4 (USB4)
> >
> > +             What:           /sys/class/typec/<port>/<alt-mode>/priori=
ty
> > +Date:                July 2025
> > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > +Description:
> > +             Displays and allows setting the priority for a specific a=
lt-mode.
> > +             When read, it shows the current integer priority value. L=
ower numerical
> > +             values indicate higher priority (0 is the highest priorit=
y).
> > +             If the new value is already in use by another mode, the p=
riority of the
> > +             conflicting mode and any subsequent modes will be increme=
nted until they
> > +             are all unique.
>
> What is the units here?  0 is highest, what is the lowest?  What is the
> range here?  I can't determine this from the text, sorry.
>

Hi Greg,

You are right, the lowest range is not specified; the only note is that
the value should be an integer of 0 or higher.
The mode selection algorithm does not impose a maximum value. It
operates with any priority values returned by kstrtouint(). Any MAX
value would require an explanation as to why that specific value is
the maximum, and I do not have such an explanation. The only
restriction is that it must fit within an unsigned int variable, which
is checked by kstrtouint() against UINT_MAX.

> > +
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >
> >  What:                /sys/class/typec/<port>-partner/accessory_mode
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 9f86605ce125..aaab2e1e98b4 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -19,6 +19,7 @@
> >  #include "bus.h"
> >  #include "class.h"
> >  #include "pd.h"
> > +#include "mode_selection.h"
> >
> >  static DEFINE_IDA(typec_index_ida);
> >
> > @@ -445,11 +446,34 @@ svid_show(struct device *dev, struct device_attri=
bute *attr, char *buf)
> >  }
> >  static DEVICE_ATTR_RO(svid);
> >
> > +static ssize_t priority_store(struct device *dev,
> > +                            struct device_attribute *attr,
> > +                            const char *buf, size_t size)
> > +{
> > +     unsigned int val;
> > +     int err =3D kstrtouint(buf, 10, &val);
> > +
> > +     if (!err) {
> > +             typec_mode_set_priority(to_typec_altmode(dev), val);
> > +             return size;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static ssize_t priority_show(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +     return sprintf(buf, "%u\n", to_typec_altmode(dev)->priority);
>
> For new sysfs files, please use sysfs_emit(), otherwise someone will
> come along with a janitorial patch to fix it up after it lands in the
> tree :)
>
> thanks,
>
> greg k-h

I will change it, sysfs_emit instead of sprintf.
Thanks!


Andrei

