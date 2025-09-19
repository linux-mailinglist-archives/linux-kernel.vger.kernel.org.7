Return-Path: <linux-kernel+bounces-823965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184AB87D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13981C8673F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0A24DCE6;
	Fri, 19 Sep 2025 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIxDtqrI"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D071714B7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253414; cv=none; b=gDRjQ4WpP/gK92Ntmv+Rdtydrntx+4AE2sWdWi2kQ4xgPF0Hz9GgoSYLaY7BUiqCR0K3KBbJqonygYVWV970ar9yuN9Db09F5iiYASBNKYX70mCeQ7IjHyPLXh6JZPG7fCP0J1dLLVZvoRNyp2SSRmCPMolWFIknz1terJkz9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253414; c=relaxed/simple;
	bh=aeNvmUS62k0jH566cB0cmH9oXeO2gW4GJlD3nXTVxAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHTGbsZS1+WbEF12R9KvRWULv8CvDtHB4gpG/UskzhnmAy0vjt79HzGE3aflteQO167PCfnuS7WAqDN9GYN+Jh1UTrWWK2RVPvtPr5y90RsKt1RX4KCr9iXIMX/Cf++NjMhhUVLZvDXoXFrjayhoYT5+SXTScE0VHobX4tg+PR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIxDtqrI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1927755a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758253411; x=1758858211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKMYfdVwb74kV6i8GOAfD4K3WUGY3beOoq2S/aiwLCo=;
        b=dIxDtqrIrCp4cPKXfIU5TerzBN/RFflIZJhRI2o0C7PZj0xqhgCSnTR9wuu2IygBEV
         HnDKO+QAWk0oklLefn4yFD8T79588JuR++FGfU+31Ax5fRWn77kD/oIuZZL5rkRntNzx
         xX58bSlAqOgWJSCB6H3rtg7oBQat4pAt/28IfkFORWjiJepxb2fFpGV2NgLonWE2uSRF
         ioKbhtyfMdwm4OPlm5TWY+dtYJqjNibi/FFtQQHuJPTn54ohgU/hNCLOa4iI8foZfb5T
         s7lBS2q4Qabbscep8/N2oDy5Ej5rw58IWMqbIKEW4vEKYCAXv4gnKoDglOSjyJFNv/Ev
         TqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253411; x=1758858211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKMYfdVwb74kV6i8GOAfD4K3WUGY3beOoq2S/aiwLCo=;
        b=p5H+hDLSs7RXQTrnMjiboHzRsAMCnR2VSjT8rrkM4iimdOhO1y1l9z6Rg4S31K2z1H
         ePphPogD/f5dhYZNnAjSewjCVvgNSjxrE3O1IF3MCNLPtL5whv7IExRimSdWe6+W97+S
         2hhLbmxx563hiKFbGYHr625isb40fkesDord2OBSbUqQzUNGKBVqOriUIyerCszzT10b
         L79fblC1rOulOUpF2vTE18/MjefXh0HOdVKXC8nvJkTxg2YUemTdsQUG5pRlmZT7kazr
         mI2BfnM/WV/s39o8iyrmup4Rug2eaBLmkW7pGDjWok9k+bhf8kYXIoZnYRlXD/rx7z08
         S62Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9n5050AHKnSQ1pEmetARJXXAXBddcsIaDhD4QixL2v6RRIsm4boXeWhmxx+fyNsY7sZXmtjIWcLYskNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22HucHavHqPbZ52RvBFLaSmR8FsiP78hx/bvqU7uq9yjOblxB
	G9VUSTGaKW/RF+J7OPxFSPvkLJKeHBonX2R9A56OEcSQi+OlTLibHOVAJH++YQPX0sKkEO0vZeW
	CwTDutJ+XhUcydNjYxbBxIxWyLSFwYYs=
X-Gm-Gg: ASbGncuKZr/6HJlWPkvlzqBiMtdlJ5mCST7lX2koG3/WnOz4u5lctTLCOS7Na+TwwxQ
	yKv8bKaO+j//usv3tc+BjHzOMzLhIOJO5S51Yl/RemvgpSiP5sikpbUQN1O0l6qr0Unymd0IRwg
	QbGb6f7qNDiwhWd5rtczFVVOCnpcZcDvUiecTNzCXq2HolSXmua1AN2dbHsYPj8xHGH6mbHpFYr
	utSQ3k=
X-Google-Smtp-Source: AGHT+IF3ku8gvZB1hxFYXtLnd7iwTR3jkeyD4oKxxo5kWDQcOyxdH6t3IjIvgH7PYtQujNBSFI44t24lqUYUtwzzka8=
X-Received: by 2002:a17:90b:52d0:b0:32e:d011:ea1c with SMTP id
 98e67ed59e1d1-33097ffd1b2mr2599824a91.15.1758253411070; Thu, 18 Sep 2025
 20:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821073131.2550798-1-shengjiu.wang@nxp.com>
 <20250821073131.2550798-5-shengjiu.wang@nxp.com> <20250901185208.394cd162@booty>
 <CAA+D8AOCTqb5jLeRapYk4wRGZrsrPiuAR=ow3OA1B0+M9X4k7w@mail.gmail.com>
 <20250909-omniscient-honeybee-of-development-adca8a@houat> <CAA+D8AM=aRU-0QcgtxZ+=YBZ2+kMrP2uzSE3e+NJs3Z3zkrSVg@mail.gmail.com>
In-Reply-To: <CAA+D8AM=aRU-0QcgtxZ+=YBZ2+kMrP2uzSE3e+NJs3Z3zkrSVg@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 19 Sep 2025 11:43:05 +0800
X-Gm-Features: AS18NWDra1nGW4hE_RulzgXqUXLGFVIDrxwneg_8Sfyhy5B_85F5WDGUq5FPeS8
Message-ID: <CAA+D8AP8eJ8_pueq1ZSb-ORzTJbNT7HOwKFOO5ZCXqgqoQ1qGQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958()
 for iec958 format
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, victor.liu@nxp.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	devicetree@vger.kernel.org, l.stach@pengutronix.de, perex@perex.cz, 
	tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca

On Wed, Sep 10, 2025 at 6:29=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmail.=
com> wrote:
>
> Hi
>
> On Tue, Sep 9, 2025 at 2:39=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
> >
> > Hi,
> >
> > On Wed, Sep 03, 2025 at 06:41:05PM +0800, Shengjiu Wang wrote:
> > > On Tue, Sep 2, 2025 at 12:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@=
bootlin.com> wrote:
> > > >
> > > > Hello Shengjiu,
> > > >
> > > > On Thu, 21 Aug 2025 15:31:28 +0800
> > > > Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> > > >
> > > > > Add API dw_hdmi_set_sample_iec958() for IEC958 format because aud=
io device
> > > > > driver needs IEC958 information to configure this specific settin=
g.
> > > > >
> > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > Acked-by: Liu Ying <victor.liu@nxp.com>
> > > >
> > > > [...]
> > > >
> > > > > +void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned in=
t iec958)
> > > > > +{
> > > > > +     mutex_lock(&hdmi->audio_mutex);
> > > > > +     hdmi->sample_iec958 =3D iec958;
> > > > > +     mutex_unlock(&hdmi->audio_mutex);
> > > > > +}
> > > >
> > > > Apologies for jumping in the discussion as late as in v5, but I not=
iced
> > > > this patch and I was wondering whether this mutex_lock/unlock() is
> > > > really needed, as you're copying an int.
> > >
> > > Thanks for your comments.
> > >
> > > Seems it is not necessary to add mutex here. I just follow the code a=
s
> > > other similar functions.  I will send a new version to update it.
> >
> > Let's not be smart about it. Next thing you know, someone will add
> > another field in there that would absolutely require a mutex and now
> > you're not race free anymore.
> >
> > Unless there's a real concern, the mutex must stay.
> >
>
> Ok, thanks for comments.  Then Patch v6 need to be dropped.
>
> Is there any other comments for this Patch v5?
> If no, can this series be accepted?
>

Can we have a conclusion that keeps the mutex as Maxime's comments?

Best regards
Shengjiu Wang

