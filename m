Return-Path: <linux-kernel+bounces-807694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6FDB4A824
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3013BB59B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206A2C21F6;
	Tue,  9 Sep 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9y6Adkt"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC48289358
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409792; cv=none; b=NJGlHp+UNpoM6SjBMeSl0a4bSICSCCtJVHgy+hxLmZ2UozkPelWHl9RD7AN8taWRBkFs2EBGdc4RJJ6NedQoCtwniqhTd20VQWOsW+0C9S3VjnUt4JyQ7+zf9mZBV9OmEi9e1YsxzVZlgM+R2oOoepyWD0TPbZINN/R9LpauuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409792; c=relaxed/simple;
	bh=IhwGmnTPROJ8UMJ/ZIJKXloDry6OSxr5zsCSo3X2V4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD4ZynPaBOoe6ckCZ0yCRd9Wt5UvRtRjYhkQgQB1HOi+d3j3KmRLqBQEGVZCYnJ7bpxDTy1uRnKevlGwPt3wjkAKeGMWebnSSz08P1XXUXYnaxNuc1rlfZTwFCg/T2wuYvo5EeyjL4f68FvQyTm+aYeDlu59ECLGcdCzFGDQdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9y6Adkt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32b5d3e1762so4220718a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757409790; x=1758014590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w3Ph4E5BTw4rV1tmXtmqkj8lq5Hk2RR7067ccGSdZI=;
        b=k9y6Adktq1Fn1bgDuPjvDdP3h7Ft/LwbACtAoVMbBezqAg2E6Msn4GRo+/GWvuJFPV
         bAgOAW9BwQ3b6vJ7BsiawgFD8UFU2EFK2OsFBxqWAzBzL8xtUoUd6A8n9CLtZG0MyZRm
         6vgqnHLAwbpWXeIA1ypbmEGHF1G3kUojv2MiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409790; x=1758014590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w3Ph4E5BTw4rV1tmXtmqkj8lq5Hk2RR7067ccGSdZI=;
        b=vcFHsSaVr+Bzgt60L9tD1vJUYPczJvxDxRHcqfQXZQ7Ly9AIXpoI+JAG7KP8rjoTAt
         jeiXsqttcx1Us7TLqh4oFokATNFFHKxPT39U1stlShhnCAVQMFK602vEVCdLdky63xpo
         JGWAZcGXHYmHq2zvPlmpubBaVc0X0Y0vcFkLzFz/ZoPLZ3AUv9f9B9/7B5cOYazL6eqE
         wjWt1eMjktfPgcenv4htf1nLO5BLvSHd4b0X+7chJjbvBHT3tVarBVFeMFwxWKIwVmB/
         rAOvaoioOKhqUR3ZAJaRrXZaiURg8wm7Yoq2l8jmL/cV/AdAtr5Sy9Aknu90YCmvAMB7
         145A==
X-Forwarded-Encrypted: i=1; AJvYcCX43ungFmTBdIUegruE7DlCF05DtaHxNF4mpPrsALLe+fWVBfHfh0rLjtid4PMvG3PAb2S5b/Z9FzmkcgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzATP200AdZ8h95i0Z5FpOZk7Vw4Fj7cLpOqOmqsnrdh+G1YBk/
	mPYSpfDr+RZsI/qLLwj7oTsniON7HJ0mQZ1cDuREgM7gR6UzEmfYiyWnOyqNuDuhPSYIbvSbrdB
	mbQVHtAd8EKFb5SPf2hC1twPk7KVo1roZxwAAok1C
X-Gm-Gg: ASbGnctaloOyHkAj4lk0Ed32dDiEOxlanMCLgXqGCM4VMvIOLIT1gjwDkZIRy+rSA4C
	1bRdinvF87rmWCVwrxNngRUJvgz3JRU8uxEn4kxgSrE+f4urEgAPL92jij95HLSqgy9yOZXmNLA
	u3jf5JZteiBpFkC0+FWTLjLhIij2EWQcYk9aV9CKGf5MUSzaPe+7KAIGyHEKGPYmwyLfdK/ZPcv
	PD2jX5bLw+snbx+qqmUFyV7xYkpFXGTGPo7Aw+p9IEx
X-Google-Smtp-Source: AGHT+IFW+hLO5Yu6lqanuOKaST+yfom90ApVBsBONoL1QtFCXG1kgy1XSNSymbhKgjXDmLZVRuj1xAmF3kl3ji8pOsQ=
X-Received: by 2002:a17:90b:3952:b0:32b:b514:3935 with SMTP id
 98e67ed59e1d1-32d43f006f7mr15206818a91.16.1757409789756; Tue, 09 Sep 2025
 02:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-4-akuchynski@chromium.org> <aL_uZxBkBfC9Etrk@kuha.fi.intel.com>
In-Reply-To: <aL_uZxBkBfC9Etrk@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Tue, 9 Sep 2025 11:22:57 +0200
X-Gm-Features: Ac12FXw4Dq1SaeVI2SOpFgqyAjRayu5Yet0cmirzQc2om1uhPkt-AFM8Ejmd-cE
Message-ID: <CAMMMRMf_zDx43-Orf1zE31hE+QmPgkDMz2UTrYjyS=pjHUZvYA@mail.gmail.com>
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

On Tue, Sep 9, 2025 at 11:08=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Sep 05, 2025 at 02:22:04PM +0000, Andrei Kuchynski wrote:
> > This flag indicates that the PPM allows the OPM to change the currently
> > negotiated alternate mode using the SET_NEW_CAM command.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index 0d6b0cf5a7cd..9f754344a841 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -1632,6 +1632,7 @@ static int ucsi_register_port(struct ucsi *ucsi, =
struct ucsi_connector *con)
> >
> >       cap->driver_data =3D con;
> >       cap->ops =3D &ucsi_ops;
> > +     cap->no_mode_control =3D !(con->ucsi->cap.features & UCSI_CAP_ALT=
_MODE_OVERRIDE);
>
> The flag is now used to expose the priority file, but you can't affect
> the order in which the UCSI attempts to enter the modes, or can you?
>
> thanks,
>
> --
> heikki

Hello Heikki,
Thank you for your review!

You are right, this patch does not affect the order in which UCSI
attempts to enter modes. Currently, UCSI implementation only has
DisplayPort alternate mode support. We are preparing to submit patches
for Thunderbolt.

Thanks,
Andrei

