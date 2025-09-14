Return-Path: <linux-kernel+bounces-815705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F26B56A28
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26C23B3905
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3C2D9EE1;
	Sun, 14 Sep 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0actOFo"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2922857CD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757863231; cv=none; b=sUfH2p8Z2pKFfH8riI+4pr9PcFwva6Us+LZWXp2mp6w9zSPiHf1hcoA84/nUbTqyUEJ8amKKjgFHG2+dii/0Lp2vOqZ/O5cq6Euxsn/deeXzV7komz9Yz2z8flwP93adtUSpia5UUFPfsMW+xfrgbSSN6QlVtmGYXah+kbWPbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757863231; c=relaxed/simple;
	bh=8k+nJtDsuoPZkKT6XUJmXpNomth89X9LTT+a3orMk8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERiXZXGb2QKTC8jv6NpFM5ovgB562zN83fOZGUm6sHJQYzExIFCQhaDA0vq53BrOoQg3MVZUtqIIm9o1LJfhE7QMmpVQh6NZDjxmRwc3vAaN2Kk/aasT6QeB94wUtksmi8Tx0+MtvWX1dwqYb+u7BzOx8o5mCDoCaI9H+d+QFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0actOFo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so6734227a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757863228; x=1758468028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAX4epvx2yfbrAYRoI1Myq8YDs/AsdoHkdS8EZpoCP0=;
        b=g0actOFoVOYITrJTb1jrkG/I95HQwpX83oJXH3WimLosYChnuNo5U686JVd2uyUiiC
         wxiQQtzJ9GcqKydocvk9b/DZLJJBCNFM/ExzrJSlugPQ4VzRJjyaCQ3nBaQbXM/b0+S0
         thTjdctMcUIifR7Qv0Y18t+FknY68JDHACQDr2OXYizOxdkCL/M4431cJPt9Bz7vg2ab
         2z5RVjPiZxw+hYUDwDeGlwL9SnYo18ko4RK3QCQO3jTnH9oGTzbELt6cp8qMlNna6UaG
         o0CU4Lo/Dns3CtFTxW6sbCsAVaAqWsQLToYA9N1H+3UUbgXn74te/mgkC0sj9RFFgqb3
         /wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757863228; x=1758468028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAX4epvx2yfbrAYRoI1Myq8YDs/AsdoHkdS8EZpoCP0=;
        b=rvMvgT/u6fAP+3CRxYEVq848kIUZkO0CrKjqGzSW7MEj+dlp/xFN2+X26Zuz4o5oY5
         ZehCTwnR1uEpC+gHszmhy9ZF2z7rwWyo3hiwOCcH/wc9TeTjayMcxKF2pNJcvQlU5T+i
         ymQ2tZ+e6xI0cdP+RqoAq5Jf38bBbMhEBV/QlukBHr3kea3lV+khE7Trix/1b6inR9jM
         QIm8P8ys3L3Se7JCyQDa6TQn+jFyKd7X1Ao7fvVgsbaYT1Nq7D6/vFVpbTh8TeyGEDHd
         iGDUH9dzP0LldamcunHImkhRffDOg18WczN/k5SrmHoIfg5RjcSDfvPOWLZceVp49XTi
         smww==
X-Forwarded-Encrypted: i=1; AJvYcCX27ylwCtg5trQ4gqrjZcPg1O4KnuZF2qsVDsk4Rs7BM1t54hHKcS4JuBpKNsfV2r8eIe7EwDscCeE83Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRwYVjKlwjLdN/yxzihU9gJg2UmCRjzhomEjzYyIxQb9/TXsW
	IBhV+a62P7E0howQr72VziDtwcQrLkPxO+IVIIqffTIqDnR8ufeKnIxHtrlLnufYfMe6MUDXjr/
	OenA8GSvMVg9u26x1okIiLSHVz3J2lDA=
X-Gm-Gg: ASbGncu5KyvjCcGE0gv6q5Qk759jenMt2YMzCcjk/z7jLUMvNSqn3hdGNb4lZbX6hAC
	Yb6GZaXvebHSN+oLxOAjHbUGA6JVTGwjrzJpMOTFAl5bVxSnekXsjL9rGR+O2ca3UTaZvPuUx5k
	oeyFjiJvBxRjw39oi0kRrB1S3bc9J3N+FVqrL7chsHy4NUajtu9ziQvFQGAkmh4L0RDzo3+7mrr
	MDYaB94o+qjANsGrnpfvngbWLSyMc/BbtsZmpCe
X-Google-Smtp-Source: AGHT+IFoUsbKdgvI7DUejNdZApGLucGmUXzgKN910ohumYEzbO+YqD5vnc8n/gSlGLo4Mx79goBc79Q3vctUqPXpjLE=
X-Received: by 2002:a05:6402:21d1:b0:628:bee2:b31d with SMTP id
 4fb4d7f45d1cf-62ed8240c8bmr9077078a12.3.1757863227989; Sun, 14 Sep 2025
 08:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
 <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
 <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
 <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
 <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
 <99c1c03a9f7fe55b8f73e5574612dc3e1cd1af55.camel@perches.com> <CABPSWR6uKR0fz1-jJcJ1_JCsBbXhHioUe3o02DMSP8T18y1T1Q@mail.gmail.com>
In-Reply-To: <CABPSWR6uKR0fz1-jJcJ1_JCsBbXhHioUe3o02DMSP8T18y1T1Q@mail.gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Sun, 14 Sep 2025 20:50:17 +0530
X-Gm-Features: AS18NWA5MnTxW52jaWoActttcI8oI6C9FzhQLxTYHfGoPcsoBk7tygFSKvGAp8w
Message-ID: <CABPSWR4kcdwEvC6zMTOGgME4ZDPpOsdtjheD8ZgTa0iaTqQwhA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Rafael J. Wysocki ,

Is there any update for me on this patch ?

~~Vivek

On Sat, Sep 6, 2025 at 10:52=E2=80=AFPM vivek yadav
<vivekyadav1207731111@gmail.com> wrote:
>
> >On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> wro=
te:
> >>
> >> On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> >> > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.=
com> wrote:
> >> > > >
> >> > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> >> > > >
> >> > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> >> > > > sysfs_emit_at()
> >> []
> >> > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> >> []
> >> > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(stru=
ct device *dev,
> >> > > >                                         struct device_attribute =
*attr,
> >> > > >                                         char *buf)
> >> > > >  {
> >> > > > -       ssize_t i =3D 0;
> >> > > > +       ssize_t len =3D 0;
> >> > >
> >> > > The variable rename is not necessary or even useful AFAICS ->
> >> >
> >> > There is no harm if we leave the variable name as 'i' but it would b=
e better
> >> > if we give it a suitable name like 'offset'. It will definitely impr=
ove
> >> > readability.
> >>
> >> size and len are most commonly used.
> >> I prefer len.
> >
> >Fine, in new code, use whatever you like, but what really is the
> >reason for doing a rename in code that has been almost unchanged since
> >2.6.22?
>
> Hi Rafael,
>
> You are correct that the variable name =E2=80=98i=E2=80=99 has remained u=
nchanged
> since v2.6.22. Its long-standing presence is understandable, but it
> doesn=E2=80=99t necessarily mean it can=E2=80=99t be updated in the futur=
e if needed.
>
> As @Joe pointed out, statistics show that most developers prefer using
> more descriptive names such as =E2=80=98len=E2=80=99 or =E2=80=98size=E2=
=80=99 when possible.
>
> With this in mind, I believe it=E2=80=99s time to bring this discussion t=
o a
> conclusion. Shall we move forward with this change in variable naming
> =E2=80=94 YES or NO?
>
> Looking forward to your input.
>
> Best regards,
> Vivek
>
> On Sat, Sep 6, 2025 at 12:43=E2=80=AFPM Joe Perches <joe@perches.com> wro=
te:
> >
> > On Fri, 2025-09-05 at 20:34 +0200, Rafael J. Wysocki wrote:
> > > On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> =
wrote:
> > > >
> > > > On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> > > > > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gma=
il.com> wrote:
> > > > > > >
> > > > > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > > > > > >
> > > > > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> > > > > > > sysfs_emit_at()
> > > > []
> > > > > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.=
c
> > > > []
> > > > > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(s=
truct device *dev,
> > > > > > >                                         struct device_attribu=
te *attr,
> > > > > > >                                         char *buf)
> > > > > > >  {
> > > > > > > -       ssize_t i =3D 0;
> > > > > > > +       ssize_t len =3D 0;
> > > > > >
> > > > > > The variable rename is not necessary or even useful AFAICS ->
> > > > >
> > > > > There is no harm if we leave the variable name as 'i' but it woul=
d be better
> > > > > if we give it a suitable name like 'offset'. It will definitely i=
mprove
> > > > > readability.
> > > >
> > > > size and len are most commonly used.
> > > > I prefer len.
> > >
> > > Fine, in new code, use whatever you like, but what really is the
> > > reason for doing a rename in code that has been almost unchanged sinc=
e
> > > 2.6.22?
> >
> > If a sprintf -> sysfs_emit conversion is done, it's IMO better
> > style to be consistent with the typical sysfs_emit uses.

