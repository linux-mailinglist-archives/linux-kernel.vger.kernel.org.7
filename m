Return-Path: <linux-kernel+bounces-810895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF7B52133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66FD562BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E42D8799;
	Wed, 10 Sep 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlC3EKUD"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907792D781E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532975; cv=none; b=XhyL9TUMy5HyiFYnSlhSEk0ePNheqg+vxom+EdvHdNTgaIKbMM5yEDJ4HnMKCHDjVxbWHvXpzlLg/vHvoUBX0Y2mAuv7sUXgqA1f88cLmB/TOcNMb0hEHhnJhkEPXO2/kWk9VF/Ew8rsiIG5fB+nr9vz+SqNrXzPy+nt8sbZ+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532975; c=relaxed/simple;
	bh=AV456wGx4AS1v+tWNKPuHFhSCTC9E7/Gz+sOHtQdrVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL83eaJMJ4R9QYAvH868vbv9+9/gW11MMwVLw+C8vU4UIlNShRgL3rMwVqyMY5ayRZNdOmzToYmixeQHBXq3s9/8mEK0azdjBhxOF1vttD9OVfwDBs5gXYjfBnX63WdiKKpvyPgwBbPb7P1sE6Ze4kbTXBjQKa3lOBIIEuTr0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DlC3EKUD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so6537955a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757532973; x=1758137773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQPkqSciunRqKLia3Mm+0rllHHUFhVihDlipeR5N4p8=;
        b=DlC3EKUDkhA7/Dt14CSo/RkGBxbWyLGRPmRws0lHHwYpthqEOQrvmh2gS5E//6bimv
         i0ZYRDeCbEYQlXs1n5F5HuuXaJxT8CLxfnPg6qHyy2tdxZIUvbO3IuWvhBG7qtjddyXm
         VN3w0/3gqRELfdHRlgOJiqF5ldFDjIKMZ44iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532973; x=1758137773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQPkqSciunRqKLia3Mm+0rllHHUFhVihDlipeR5N4p8=;
        b=mD1le1TADn5COmz7R0MuBVRF+LGmhjJWwP0I+yJPqza5YiS4y9QjGCzgiX2RqA2G8x
         BR/IMrreUVGkb2oY/yTxoEOYPuqq3GiEjz/r13QHG8sR6dQY4SVQqK4RgUDqFuVaQvaG
         LY113dwXPBZgMmDGLrFfoxS0ws8X1PwEnmYO1pVf4fpfcOiox5NiWktvc2EffqvROAoH
         w2ZR/+q3unUP5X+48Ym0FSdZ1AGfTipO/ImtR3Q6UOFvvV283QkRok0gPmUxv3+kLRdb
         L6EzEbRAt7w9Toe82LeBVjIFzhCgmEyG7XocVEZIvhWYZXgiV3ouYUbVRjV3QSJD7R49
         kn1g==
X-Forwarded-Encrypted: i=1; AJvYcCW7H2TKLuavkplxSijzaOaPWSreduN9DSI1NHW6VNV4BvXIQP8Lf7MMbdlPRHaQQEabgEEj4rzzjUd97hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3C9DcqQefPjJwGodHS6it3oFtX0p3JjM41QxtAlfs7+hbF2O
	/Jw/BhzUhpDat6IWgQvH9xGyHzLY2FRe6ZBGFWwzsS4krelPHPtGCQ5BmMrgQdwN6cXv34jyOSc
	rCFNlfGQG3MGd0sU8Pnv6C+Hs5fF/pn0I23pzIkIg
X-Gm-Gg: ASbGncsqIgibUOkYT/XxQSHAdzhWQhsZpAv3aENwUpORAl62HvJ27vxK2tcNk2emFnP
	dr5BEh7DDWTVuJ619eyTq2UYjZ6sCGbp1pWaWEpbp/HGuDpY6KUHZfIbBA1QefJRu/qg6pCMyna
	9PUe2ZLRJYMoI2VbyOjj2qFVb6Mcx//Bq3TP2P5f3pp4zgimqx3JZrgITVtJbVzd+Gzv/mKMZcB
	3L6lXdgMMzyf8RzKfW+FVcfDt4VxVPVNCc=
X-Google-Smtp-Source: AGHT+IFLlqBtDvao2RSq+mhvGeHwBwcVPZTa96veAgv1c4asfQuU7YhSG8xzoqQz1gsfHfDLzgkwBOAWmBsrpMX6k00=
X-Received: by 2002:a17:90b:350b:b0:32b:9d3c:13c4 with SMTP id
 98e67ed59e1d1-32d43f8ea76mr22921491a91.24.1757532972973; Wed, 10 Sep 2025
 12:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-4-akuchynski@chromium.org> <aL_uZxBkBfC9Etrk@kuha.fi.intel.com>
 <CAMMMRMf_zDx43-Orf1zE31hE+QmPgkDMz2UTrYjyS=pjHUZvYA@mail.gmail.com>
In-Reply-To: <CAMMMRMf_zDx43-Orf1zE31hE+QmPgkDMz2UTrYjyS=pjHUZvYA@mail.gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Wed, 10 Sep 2025 19:36:01 +0000
X-Gm-Features: Ac12FXxddXEMRnJtLrfvERjfHZezzuZuMnfwdZigQDg7YqiQEYPvS9eHewf1Njc
Message-ID: <CAMMMRMcX4k3Ry6ruQhA39hFze+fMttUajwaBP5TrbvP7Ryy9zg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] usb: typec: ucsi: Set no_mode_control flag
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:22=E2=80=AFAM Andrei Kuchynski <akuchynski@chromiu=
m.org> wrote:
>
> On Tue, Sep 9, 2025 at 11:08=E2=80=AFAM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Fri, Sep 05, 2025 at 02:22:04PM +0000, Andrei Kuchynski wrote:
> > > This flag indicates that the PPM allows the OPM to change the current=
ly
> > > negotiated alternate mode using the SET_NEW_CAM command.
> > >
> > > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/u=
csi.c
> > > index 0d6b0cf5a7cd..9f754344a841 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -1632,6 +1632,7 @@ static int ucsi_register_port(struct ucsi *ucsi=
, struct ucsi_connector *con)
> > >
> > >       cap->driver_data =3D con;
> > >       cap->ops =3D &ucsi_ops;
> > > +     cap->no_mode_control =3D !(con->ucsi->cap.features & UCSI_CAP_A=
LT_MODE_OVERRIDE);
> >
> > The flag is now used to expose the priority file, but you can't affect
> > the order in which the UCSI attempts to enter the modes, or can you?
> >
> > thanks,
> >
> > --
> > heikki
>
> Hello Heikki,
> Thank you for your review!
>
> You are right, this patch does not affect the order in which UCSI
> attempts to enter modes. Currently, UCSI implementation only has
> DisplayPort alternate mode support. We are preparing to submit patches
> for Thunderbolt.
>

Hi Heikki,

should I send this patch later with the Thunderbolt UCSI support
implementation?

Thanks,
Andrei

