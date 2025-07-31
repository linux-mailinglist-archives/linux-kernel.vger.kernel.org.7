Return-Path: <linux-kernel+bounces-751707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19225B16C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0293B80A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49729AAF5;
	Thu, 31 Jul 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwtKbkol"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949029A9C8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946113; cv=none; b=gaeA01ACSD6/3NUXaWW6CYmgnutO/TBfgENmHgyt4t21WIzMp7JeYf1MC7fZ6GXzyYESiyPimp9suDC/io72p44i1XnoYxrz/5owAReJ9tp7Nzpr63Mbky2R9K9aWDP1s2IE5LNbrakf4o1jU6rkOzDKYdTXq/QYQ3jVTmp8row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946113; c=relaxed/simple;
	bh=xiXLrUPIxlTwJcraKjLr3lhafzFTzTlsrmUKH6csDrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se3vYz6gZVpGZ4Ih7IZgUEidF6/md/67cDJpFiunu7YSQA95cUHO4YZ6GOyreEzbLSffvgMOobjxTENy/cdrCd4M7jRtcz+GwgM6iVeOXb9P5sZkRWvHsO6NQ7EUUjaMEmBYxkm5UKOXSSsV6F5YK+OYPT1BGfz7CxNMY1+lko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwtKbkol; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426c44e014so597492b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753946111; x=1754550911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebIwp+3F9+NHey8VVOff1SO0dtsb8JA0khxWTB2N6sU=;
        b=DwtKbkoldZ+cY7M80Cgij/pSoN63cDVDqJxL3eB31ZDfePi0O3a9TygtusVXSaEfjL
         bkV9Zsb0iDqszP73B/I+0TcWvigDquNESXBC+tjS3fggXIdRI4HwBUFZGYqtikZvggzB
         FpjN0+VrCAioS0wSUOaWIbzUwFymp/Rvc/vDhIGDoeDdoMgw/DZRTTG7pZMYc88kgBuv
         28dH9hbAe9B5IdZslq516WkPZFYQPcAgfMyKfc2XTtLWs2vTAeEqRzZqkEWZXw+9clV5
         4LQNMSvLKNt5hQiwQ4f75hwA94McE0BzbVb5PCjp+VLt+J5tE1BiwjfyUzcF5PixVeam
         /qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946111; x=1754550911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebIwp+3F9+NHey8VVOff1SO0dtsb8JA0khxWTB2N6sU=;
        b=tKmKX4izGAo9glW+alvhFGPJIIL//zjtJPKfYJi3ysa3XrQCOBQVqjxMJYESOOvMJQ
         9kT1zOqJNdOrPAhWI2pkaHbU8n2y0Wewblbf4UqQtt5mzfVt2IEqwEKVYL18n+HFDm/0
         QCpuS79igdsYbHB7eVLap96YWjbdoJpvQGFBzEN2Z3RykGYWcV5dLnql9psL+O5nrCSH
         O476zVhZhc5GtdWjHYnlv50cmg+q6INvTvo6I5zmeFQvYmKt7laXQ5NNtZocZaUZ4qRa
         evxiun6znwjmpKnAdDhSZCsEy3YNqIUN1JA4iv4y+oL1HgrBQ10N2sqlrNbI/aaLR0jX
         QiwA==
X-Forwarded-Encrypted: i=1; AJvYcCVoOCDMXvhY9wlsH00aeSDXFYr73GUJUv9FVDsC6URM11YqaolK5J2WRAVxdIlOgtAjPTV9qibANGd/A+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXX+kj/pJFyySEFGS4iYHJKao9hNBTxaj4D91tVBPn3SnFBqc5
	/VJOkLS/olgwxznUWqOetU8u9tfX67jmP2iStBQDPQP8w+g12MxKLOvMeENlxONDBBtDo3KTpPW
	oO43wtqC6Pg1syMdfyHpci1cDZtJPEUUg7lIiNOF5lw==
X-Gm-Gg: ASbGncv7tynpkbpXXhU6vwmsxWPO1eCOnVeknC6Yvw8XleTK4O0Y2yJQvFZ2yzduh+Q
	6AbzKvZA4kZt/rJjH+tE0FZiKC/VrkfgTzqeUp7fBaNggmWtefWy9FyqGGd8H3BhfTexMuX1M/B
	CdqXxBxBnb7Cwdn5PpAQ9nsmInhspES+2oCTVVPT0yTp0lwtk78bpo9rj4WdSzmiYiBfIkkEP+C
	pztGy83jxon1U5x+4g=
X-Google-Smtp-Source: AGHT+IFxCb3ARGfnETbTMRgPvvmnockXkwo+EiwvwDtTxMifOrAfoOVw0QE01/bhkomwOXauA6I5K//DbPK1RBEnXLY=
X-Received: by 2002:a05:6a00:4b0c:b0:740:b394:3ebd with SMTP id
 d2e1a72fcca58-76ab092312amr9210141b3a.7.1753946111170; Thu, 31 Jul 2025
 00:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730071629.495840-1-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=XThBbAwQcuR8Po6KfR0LwsfwR0HCr7j0Pk57n5XeQu9g@mail.gmail.com>
In-Reply-To: <CAD=FV=XThBbAwQcuR8Po6KfR0LwsfwR0HCr7j0Pk57n5XeQu9g@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 31 Jul 2025 15:14:59 +0800
X-Gm-Features: Ac12FXxI0TJh030Bm5HklbALhYKAI_pWpuJqLomZkTDF9e-W0HFnUtTz4czMwQg
Message-ID: <CAHwB_NJ3yQxf9fTMT_cQv50z8X_NKyQMOJEuqDqY-BfKX8QzXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add several generic edp panels
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, treapking@chromium.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Doug Anderson <dianders@chromium.org> =E4=BA=8E2025=E5=B9=B47=E6=9C=8831=E6=
=97=A5=E5=91=A8=E5=9B=9B 01:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, Jul 30, 2025 at 12:16=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > Add a few generic edp panels used by mt8189 chromebooks, most of them u=
se
> > the same general timing. For CMN-N116BCA-EAK, the enable timing should =
be
> > 200ms. For TMA-TL140VDMS03-01, the enable timing should be 80ms and the
> > disable timing should be 100ms.
> >
> > 1. AUO B122UAN01.0
> > 2. AUO B116XAK02.0
> > 3. AUO B140UAN08.5
> > 4. AUO B140UAX01.2
> > 5. BOE NV116WHM-N4B
> > 6. BOE NV116WHM-T01
> > 7. CMN N122JCA-ENK
> > 8. CMN N140JCA-ELP
> > 9. CMN N116BCA-EAK
> > 10. CSW MNE007QS5-2
> > 11. SCW MNE007QB2-2
>
> nit: CSW, not SCW.

Fix next version, thanks.

>
>
> > 12. TMA TM140VDXP01-04
> > 13. TMA TL140VDMS03-01
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>
> Please make the subject line a little less generic so we can tell one
> change for the next. If all changes just say "add more panels" then
> when cherry-picking and looking at patch subject lines it's hard to
> tell which patches have been picked and which haven't.
>
> In this case you could mention that the panels are used by mt8180
> Chromebooks, like:
>
> drm/panel-edp: Add edp panels used by mt8180 Chromebooks
>
> Also: even though it's a bit of a pain, can you please include the
> EDIDs in your commit message? I know there are 13 panels and that can
> make a long commit message, but I'd still rather see it here just in
> case we have to later go back and reference exactly what panel you
> were working with in case some manufacturer re-uses panel IDs (it's
> happened in the past).

Got it, fix next version, thanks.

>
>
> > @@ -1865,6 +1880,7 @@ static const struct panel_delay delay_200_500_e50=
_d100 =3D {
> >   * Sort first by vendor, then by product ID.
> >   */
> >  static const struct edp_panel_entry edp_panels[] =3D {
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B12=
2UAN01.0"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B11=
6XTN01.0"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B12=
0XAN01.0"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unk=
nown"),
> > @@ -1883,6 +1899,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "=
B116XAK01.0",
> >                          &auo_b116xa3_mode),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unk=
nown"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x52b0, &delay_200_500_e80_d50, =
"B116XAK02.0"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B13=
3UAN01.0"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B11=
6XAN06.1"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B11=
6XAN06.3"),
> > @@ -1890,10 +1907,12 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B14=
0XTN07.2"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B11=
6XTN02.3"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B13=
3UAN01.0"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x8bba, &delay_200_500_e80_d50, =
"B140UAN08.5"),
>
> All the old AUX panels seem to use just "e50" but all the new ones
> you're adding use "e80_d50". That looks really suspicious. Are you
> sure that these new panels need "e80_d50"? Were the old definitions
> wrong?

I checked all the panel specs again, most of them require "e50", only
a few require "e80_d50".
Sorry, I took the maximum value, will fix it in the next version. Thanks.

