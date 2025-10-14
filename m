Return-Path: <linux-kernel+bounces-852501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25106BD922B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608001920225
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772113101C7;
	Tue, 14 Oct 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQ6DUUKs"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75E2F6588
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442882; cv=none; b=cNmyXkU8J71NeIHWCB5MYJxfyhYJqQvKKn1ARthr5Y0C953dp+9nwleE/Zv/EBfwCWsavvLpHHISItviqxYkI5A+WjiQfZr/TbS3bwHC1TAAXngB+K8TFAPBxjEDTFWwAkNAGmFZ/R2+e7WXYBRbiqJDoUZEqm6Js7EjQ5snW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442882; c=relaxed/simple;
	bh=uRuCQgVqDHabbWDraSMlQanEm0gEo4jcOIhwPGCUyD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQRFnbf8rN+pM4dFHTachuj2+4juOyHRGJ34jBlNiKHTHgDeyFzODSXreOKQYb37WocDE2ACmTY+zSwsC0jq0Z5QkP3v5M1HoRN/JOJJxBxUaWPWZb581KeJMwmEMN39g8CtWBY8WTjuy21RFAe7y01fTDzCb0liYPEuCaiW37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jQ6DUUKs; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57ea78e0618so6077559e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760442879; x=1761047679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQCiGSq55phSqChEavqznNli194wFmUsJo+7nVVLw0k=;
        b=jQ6DUUKs/DigB4VqXdE0nClNz/phokYA0Jm5JYI2E4o84fhkAOxkhP2yXcnPi+Pjx9
         29306AeRRKjHtc7ujtJLSbeEtFejERgUNcldLy8tvLVbEpbM5NTKkBJFIg7tV6doBJ1I
         kPiNNvtTTy9fL25ACq1+NDunaw9Uu+J/1qvyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442879; x=1761047679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQCiGSq55phSqChEavqznNli194wFmUsJo+7nVVLw0k=;
        b=wT+bYM+NtNSKfhupJRd/GlCKX/zt4VpJqqrMcPdRd2TceJSkiJxNnYsmforWAdNn0l
         FPEy8gZoRzBc75WOedEs+2nBhuXTDQo7Aofs31Ue2wf1+Cg2KsiPRp7+lbAwMm/Kzfa7
         LsjljJQvlCppkFI5ssV0sm8jimnoCQez90sQct3MCMI+7CK0KpVrcCkMHNmY2H5FKS/V
         DDzIIUd6XMA74qLESw1olueM+OW+3PmGo4+KnOnqeNsdlN193DpBUibUGsNYuOgXMEoJ
         XgTz1AQfkHKVJDxPiyOL31o1ItOXP5A82dqxwXLMAMmqwKGp87ax5USitUomvv1IDkrL
         1Gaw==
X-Forwarded-Encrypted: i=1; AJvYcCXWj+U1bADjnKUrpiGiLxl/abP2fE3743i7NgHqmqLgGSkOQq5iAnLUxywkxPxl4m4IImcM3vEV6UkNpr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfmTbKBCnewSI3tTjjFZ/TaK6+CFd+DBKDjKfCOv5N8FPTeVa/
	Rg12+UgcBXL19BApfpVOI5HzRkGxosWd3A1dZIOidZERQ4xu/vARBrazZXN8eCiwMWsXMqjVQGg
	/F5f3t7Y0
X-Gm-Gg: ASbGncuHr8XhYXzlMTIfpUfR/bs5Bq1y071f4+70WuJUxyUqTnx3VSXUax+4A5tnmtw
	QwRzo5werJxKpveiRZkIyPNP/j+fLw7WGFSJ/ge82VscUOMym32da1pVpyTjRUpSwA9NXrF4AtG
	n3Gv3NVrJaiSPpGRAHZE+SUWcUHQH/5/uG6KzH92jvzNjcVzQ4JQwXtv7k078/+16fKYd8tzyle
	7sVchTIkDUGlxf7EBdxls3m/agazrSYAwA+Uw7xpb5SljON7o9crs1caxaawv+RuCQlmnDdRnFw
	3+tw7x7i1rHkD7q3xeNyO3t5vXjOjZWs6LxfTrnBodJ//pOKC1Yv7d48PpInCiTh9X5J/5eRlC3
	BO2FNyBX8KwVH2z0qiQfdD6J/VPtHSWKogiI5FwUt5GQeCuFBY06onFWgGAWwGkDk8frb5iWf8u
	3tTT7hl+o=
X-Google-Smtp-Source: AGHT+IHSqvTMawvkBSn9eKDg7v6ydIlzj8pXGk5vUG/rJ+gxVMLxkY6+CRCxkTcq+y3TvNaYJ870AA==
X-Received: by 2002:a05:6512:2251:b0:55f:4ac2:a595 with SMTP id 2adb3069b0e04-5906dc0e664mr7320161e87.16.1760442878882;
        Tue, 14 Oct 2025 04:54:38 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e688dsm5210273e87.13.2025.10.14.04.54.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:54:38 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-367444a3e2aso54528641fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:54:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8Lg1ZeZzJ2VrY5vVBWQFNhVzgu+we+LkT3FU8o4JBQQcZIBFIHbKhc1RY6ofxiIrZMqex0ACcvCAcdHA=@vger.kernel.org
X-Received: by 2002:a05:6512:6192:b0:579:f4b3:bc3c with SMTP id
 2adb3069b0e04-5906de86e2fmr6383788e87.55.1760442877639; Tue, 14 Oct 2025
 04:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-imx214-smatch-v2-1-04218043086d@chromium.org> <37ceef4f-4ed6-4554-9baf-3cddf3e36bd7@kernel.org>
In-Reply-To: <37ceef4f-4ed6-4554-9baf-3cddf3e36bd7@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 14 Oct 2025 13:54:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCvwKsQcCurmgUR=44z2fVF9NDQLHdHF4v-V+_4Z5jN9=g@mail.gmail.com>
X-Gm-Features: AS18NWBHlvYBWDNJ_j-z0a4YSqFKtR2VerLnYZZh9W0FQNbk092juNVG0PJo2C8
Message-ID: <CANiDSCvwKsQcCurmgUR=44z2fVF9NDQLHdHF4v-V+_4Z5jN9=g@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: imx214: Exit early on control init errors
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 13:52, Hans Verkuil <hverkuil+cisco@kernel.org> wrote:
>
> On 14/10/2025 13:00, Ricardo Ribalda wrote:
> > Now we try to initialize all the controls and at the very end check
> > ctrl_hdlr->error to check if one of them has failed.
> >
> > This confuses smatch, who do not know how to track the state of
> > imx214->link_freq.
> >
> > drivers/media/i2c/imx214.c:1109 imx214_ctrls_init() error: we previously assumed 'imx214->link_freq' could be null (see line 1017)
> >
> > Fix this by exiting early on control initialization errors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Right now we are handling this with a quirk in media-ci, if Dan cannot
> > fix smatch in a kernel cycle we should merge this patch.
>
> OK, will you keep track of this? This patch is delegated to me, so if you tell me when
> it should be merged, then I can do that. And if it is fixed in smatch, then you can just
> drop this patch in patchwork, of course.

Which is the latest rc that you will feel comfortable merging this? rc5? rc6?

I can ping you then if smatch is not ready by then.


Thanks :)

>
> Until then it just stays in my TODO list.
>
> Regards,
>
>         Hans
>
> > ---
> > Changes in v2:
> > - Fix typo in commit message commit
> > - Move error tag where it belongs (Thanks Hans!)
> > - Link to v1: https://lore.kernel.org/r/20250829-imx214-smatch-v1-1-f3d1653b48e4@chromium.org
> > ---
> >  drivers/media/i2c/imx214.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> > index 94ebe625c9e6ee0fb67fe1d89b48b2f1bf58ffc6..c66f0e18726c3fc15df91c37888a797bcea82134 100644
> > --- a/drivers/media/i2c/imx214.c
> > +++ b/drivers/media/i2c/imx214.c
> > @@ -1014,8 +1014,10 @@ static int imx214_ctrls_init(struct imx214 *imx214)
> >                                                  V4L2_CID_LINK_FREQ,
> >                                                  imx214->bus_cfg.nr_of_link_frequencies - 1,
> >                                                  0, imx214->bus_cfg.link_frequencies);
> > -     if (imx214->link_freq)
> > -             imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > +     if (!imx214->link_freq)
> > +             goto err_init_ctrl;
> > +
> > +     imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >
> >       /*
> >        * WARNING!
> > @@ -1099,6 +1101,7 @@ static int imx214_ctrls_init(struct imx214 *imx214)
> >
> >       v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx214_ctrl_ops, &props);
> >
> > +err_init_ctrl:
> >       ret = ctrl_hdlr->error;
> >       if (ret) {
> >               v4l2_ctrl_handler_free(ctrl_hdlr);
> >
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20250829-imx214-smatch-c4d4d47428d5
> >
> > Best regards,
>


-- 
Ricardo Ribalda

