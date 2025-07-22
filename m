Return-Path: <linux-kernel+bounces-741222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39954B0E1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E27A7B0250
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566E27A476;
	Tue, 22 Jul 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrwOXQRG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609D27A916
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201378; cv=none; b=IdbE54+lYe38nvDWTE+8B3aby40kCmnkztbuwYU8EJ174gXHJ53ThHWM6S4ymRg0cBUePWDCgsoRwzP6t5sH3RWVVNESctnzMV180PIFX6Y8k8vus+Pm6GBeyMg0eBjQuF3UGMbCGRzmQ4De0d7+11zAJaTBeMxIeVU1cdsPcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201378; c=relaxed/simple;
	bh=0I/bNUuFobxytL160W+kJ+iaUFZ+hUI/bFGemXe6FPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXCgPgRifgmD+bQOeH3Xws+c3Do2gQhqs7Eb+qvQy6tedRjo7QUs0FIslsl9tr81slAiUJ0ZqtKn4wFQ8G1rq9hLUgj81XSw1SwXcF3smN05tG6gpaUFcbVfaKYfqQCxbCuXbXgGOqVJgyimJG2hI3CDjW+73wWJhjFSEnwAavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SrwOXQRG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dea2e01e4so68441985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753201371; x=1753806171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEXUdZr0ohXXfzmWQ2dHHBxRJSqO63DOp1ZvGK6vo/c=;
        b=SrwOXQRGn30dxNf+k1ox+XIbWjz2Lq1Qn5V7ou1M6WJBBZM3UfnGYfcH5PAzRKXbF2
         uVb8iELlPzlwgt7gAKLGdTa8vnXFta6v29hJAi58VpsqeRubafcXSRuYcmpVRxjpEWYE
         Jvnoyb8GOviR0mFIZXU1CCGHP+H7/sfGahAQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201371; x=1753806171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEXUdZr0ohXXfzmWQ2dHHBxRJSqO63DOp1ZvGK6vo/c=;
        b=mrgM+PYXtdq9CUfzbGEKiQmzr+umY/Pa/ylwmCwVzlNz7h04TvPf8xmqPaK72RJ7cF
         or7nyWjlHNDEiEvmEFrnnqHNjsSyVVnSmgJsZZIlHuxpM5qgQhq/Nf9LuSVdZ8RpEeJS
         JpuQTi8qluk00JYykjW6tUeBcyKsws5LYNrSpChguMW0kNuyI6StsxnMY2zcBaRKm4nS
         9StXMWCSwcrm6YtyXW/sAmzcrcsK8xalehHi0vnpWTfHFjQzUCYBMS6cHP69Y01Bex2m
         dBPlrmwyhYFoMScVxMubSIiw2pjPfvv+91HYfNnlBARBf+HnsAzOIP+4KSqVAaax5Q2Q
         Q+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj9m6PLEPYmFiC64wn1Hi91MxiqtF5+jQ9L50xhs4aM1eRDeMXV7gk+5W4qQh5l0Cqr9ZDRbB81SIoeDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnmZQMS3XdZS7NsmjMN42KyK6ZqcKwLr0NkrINditJNut8hnU
	uRFwAZqgYuXYQp1SuMYqP6F/r8Z2yFMrCcoh/S3VXdC1G177KXokqBJ+NfdPS8kLoJZRJb4lC1y
	sfAs=
X-Gm-Gg: ASbGnctvfkE0D0o25jYtUsU+RhE0njLPSsXBatRz6sjHLOcVmL7ac/RtpjacNB5JYZP
	6H3sgvVdlFTz/hfGXKr/zcZYsNWMDXIqP6yh8UcYmHn7+D+NPEF9Hlt8D/eH6JF2k3db6LOW6Ph
	xlXjbXWwp9MLQZkrhktAFA75xmd3Oy8yFYo1lanr6Z4LeOFv/by2aqQtSy5uazmD8kQ8mSoBtAb
	BbCzJwbXa2GKWUavuvRhfKykcABzex9rqesYIGevgX9a557UFYAis7z5eAKFHWRRGc4TFkmCWbm
	bRS+Qete0l3W0WSlw8n9MPtOb7hSKxQq2tnU/1lyzdy2byjIj4Kn3K1lRIFIeQtWFO6UlJf9Fgv
	3gTmDwIsMoZKfRCGq3XSpcF1a2sr/azoYU8hARjFynJj3J/qlIduR8yw6Tt85ig==
X-Google-Smtp-Source: AGHT+IGxt79mQYzabv+ZcmECHbw/fzSyaeK7Z/A6vgzcLyp+kRJc705lB9lZfZ6SCiQLu9YIlNQCfw==
X-Received: by 2002:a17:903:230b:b0:23d:ddf0:c93b with SMTP id d9443c01a7336-23e257435e3mr332793035ad.37.1753201371143;
        Tue, 22 Jul 2025 09:22:51 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4e79sm79069545ad.105.2025.07.22.09.22.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:22:49 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313154270bbso5626982a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:22:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbb26qlPCFysD3ryxjQqBtmzpqgsYn07SujwI9nTfchiiRhJCBQu4xPwLRqtMzaB89YP+pn+SLHgkOoAM=@vger.kernel.org
X-Received: by 2002:a17:90b:4f49:b0:311:c970:c9c0 with SMTP id
 98e67ed59e1d1-31c9f45e26cmr31413464a91.22.1753201365336; Tue, 22 Jul 2025
 09:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719082639.307545-1-me@brighamcampbell.com>
 <20250719082639.307545-2-me@brighamcampbell.com> <CAD=FV=Xzno3ReSyp9w+DC+nLoy1AXmcwd+j1=_XRxFi_k+bmng@mail.gmail.com>
 <DBI61MARVMJA.1DDSNK4TZE5TG@brighamcampbell.com>
In-Reply-To: <DBI61MARVMJA.1DDSNK4TZE5TG@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jul 2025 09:22:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7rAhChkJgOXW09z6O0ad2n478oRXpeT5p9EzYTAr3mA@mail.gmail.com>
X-Gm-Features: Ac12FXwxEcBNTtJQox66nAzXomf74eWKkhHW-9gxqeg5dTLC3EZLkMZuuh1RwxM
Message-ID: <CAD=FV=U7rAhChkJgOXW09z6O0ad2n478oRXpeT5p9EzYTAr3mA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm: Create mipi_dsi_dual* macros
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 5:43=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> On Mon Jul 21, 2025 at 10:30 AM MDT, Doug Anderson wrote:
> >> +void mpi_dsi_dual_generic_write_multi(struct mipi_dsi_device *dsi1,
> >
> > BUG: above should be "mipi", not "mpi"
> >
> >> +                                     struct mipi_dsi_device *dsi2,
> >> +                                     struct mipi_dsi_multi_context *c=
tx,
> >> +                                     const void *payload, size_t size=
)
> >> +{
> >> +       ctx->dsi =3D dsi1;
> >> +       mipi_dsi_generic_write_multi(ctx, data, len);
> >
> > BUG: "data" and "len" are not valid local variables...
> >
> >> + * mipi_dsi_dual - send the same MIPI DSI command to two interfaces
> >
> > It could be worth also pointing people to
> > mipi_dsi_dual_generic_write_seq_multi() and
> > mipi_dsi_dual_dcs_write_seq_multi() below?
> >
> >> + * @_func: MIPI DSI function or macro to pass context and arguments i=
nto
> >
> > nit: remove "or macro".
> >
> >> +               struct mipi_dsi_multi_context *_ctxcpy =3D (_ctx); \
> >> +               (_ctxcpy)->dsi =3D (_dsi1);                        \
> >
> > nit: now that "_ctxcpy" is a local variable you no longer need the
> > extra parenthesis around it.
> >
> >> +               mipi_dsi_dual_generic_write_multi(_dsi1, _dsi2, _ctx, =
d,        \
> >> +                                                        ARRAY_SIZE(d)=
);        \
> >
> > nit: the indentation of ARRAY_SIZE() is slightly off.
> >
> >> +#define mipi_dsi_dual_dcs_write_seq_multi(_dsi1, _dsi2, _ctx, _cmd, _=
seq)   \
> >
> > BUG: doesn't "_seq" need to be "_seq..." ?
> >
> > BUG: You need to remove the definition of this macro from
> > `panel-novatek-nt36523.c` or else it won't compile anymore since the
> > name of your macro is the exact same as theirs and they include this
> > header file. It would be OK w/ me if you squashed that into the same
> > patch since otherwise rejiggering things would just be churn...
>
> Sorry to have sent out such a poor quality patch, Doug! I always compile
> changed files and test my changes when I can, but I think I must have
> compiled just the lpm102a188a panel C source file itself by mistake when
> I sent out this series revision. From now on, I'll simply enable the
> relevant kernel config options and rebuild the entire kernel.
>
> I'll address each of these items in v6.

Don't worry too much about it. While it's good to make sure you test
your patches, everyone makes mistakes! :-)


> > I guess we also chose different argument orders than they did (that's
> > probably my fault, sorry!). They had the "ctx" still first and this
> > patch consistently has "dsi1" and "dsi2" first. I don't think it
> > really matters, but we should be consistent which means either
> > adjusting your patch or theirs. It's probably worth confirming that
> > the novatek driver at least compiles before you submit v6.
>
> No, this was my fault. You had suggested the correct order. When I
> implemented the change, I preferred to put `ctx` after `dsi1` and `dsi2`
> because that's what I had done when I implemented the mipi_dsi_dual
> macro. I'll swap up the order, remove the function definition from the
> novatek driver, and compile both lpm102a188a and the novatek driver
> before sending out v6.
>
> By the way, we can discuss this further when I've sent out v6, but the
> novatek driver appears to pass a mipi_dsi_context struct into the
> write_seq_multi macro directly instead of a mipi_dsi_context struct
> pointer. We opted to use a pointer in this patch series so that it can
> be passed to a function in order to reduce the compiled size of drivers.
> For now, I'll plan to solve this by changing calls to write_seq_multi in
> the novatek driver to pass a pointer. I hope that the churn that this
> will cause in the novatek driver isn't unacceptable.

Looks fine. It probably should have been a pointer in the novatek
driver to begin with, but when it was a macro it didn't really matter.

-Doug

