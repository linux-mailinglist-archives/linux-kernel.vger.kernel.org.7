Return-Path: <linux-kernel+bounces-822985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E63EB853D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45705560D57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E53101B8;
	Thu, 18 Sep 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FY1PXBLQ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D5220686
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205152; cv=none; b=GkyiAez40QAxvkNbnxxhMDFBxvYleE6xzNWzNxlk1lmEsyRJnqkRZvCP+78aSuuyageeEhzeX2EWoNAjwHDDQGtiRndoUtFSy8BxuZhomMRS/41Gc/eXFgn3kZAEcm7mF4yELeUnc82u2AOLTQZpbnlIF3hG2NaxJNe6PgAjZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205152; c=relaxed/simple;
	bh=efV7ND5peOzZ6wFre05dZsI2sW9Mwg+FnrXTj0ULe04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSw6Sefbdfm8E2tbOPPyiaVpq+ld3rAQsE18tYwtagep//y1bkhtyt78vF554h19qjpqT7YE6e3DDu8a6kHTuC5CdtaXqsZEd+dd5FvlZGlUI7q+AFjMlssj+kMmhIQ5VDFpvIFgxrMMatjT1mtsfnqa/OD84ckrpEZAiltfXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FY1PXBLQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60150590so7250967b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758205149; x=1758809949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwnJ7MfncjQZZqEO7RPiB5wvlA6TdyUbKRJ/WpUXEpc=;
        b=FY1PXBLQW7nyZrUWVKrDHMIsBsJSdJjNWVsRJRCKwHuSlAwV9XIxG7Pr40MjxY4/wm
         7rwDY/TNygK4sLnCKqN4moCCuhjbEwdc5/fkDJk5h1KD8CDb1auRcHmeqy00tXn9gj5w
         R/3zF40CbHsvkzpJZQ+g71AgvBg8IuFwX/hjKzde9N4ptRmc4RM6igGaVd8CCp6MeycS
         KzjnMgQ7QZaqIjlcUtmKpkJjIuWYRJyqptse0It3YUADaAeO6tbtMiH0xDRdgIzj1kGU
         tNO1D4tx19AZ7v39laPYSMERNAgR4UHqXbMAvog/OqJWE/grfwxqddymT99aOBS/YK7Z
         Qk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205149; x=1758809949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwnJ7MfncjQZZqEO7RPiB5wvlA6TdyUbKRJ/WpUXEpc=;
        b=SDOWSk0Quy6KyABNmaARVci2Hl33hxLgJNKu0ASp2iV0qypuybpk4T+t/L6bfo/Arr
         Sg7Af69Nxxkbu/Mawmrt509sPSET/d8rcwGLfsjt9BbEHHm7HvrqKYaTUuxWi29MOUqW
         Kt3AZ36ArXgTfwK0BhZghCZdhqxXfaXEGaMxxLAHwy/pLdiSFFYCp2C3FXgyJEHrKaci
         YiuILlU9g6fodCrrG5UJubG+irUKc4jp11g8KMsDdP+Q1AEVD/GQC/KErKf/uiRcgqOf
         PPqm0plSArzHpyJWs/4IM+cG1r9HUsxQ2jQLW8Kfk4MobVYvWWbLmEZ9m0kLD5NMInlr
         d1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHREMWBAAf/PLtEOyXwXTkMn6MYR9ejOBmaSjt76Yvige8QtfyNcIhYg1Dlxp1KMVq4JGMOZ7/jtV5FFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySc69ql+ogXE9BudESxwSWjQ1csAPdLG71lvkxemYZtzyf2FJw
	osbhiBijef64uRWf8gp7LPD0FvXrdOCdAv/+TrOdTZWRMTpDLs3UVLJJcS4Dc8JCKxd+ZNccABB
	/D60Gg4QZhI+GW4BoENr0b99CXMPb2BlTgUUuUAqMUQ==
X-Gm-Gg: ASbGncsiCNXDd4CE9APg3fyMCSbJtErZvo7gpjZRpJ2tSoDv5StAM7W28fd931+gU4T
	HPAkyqz45MG5Pd6DgolKXBKmMYsxpiTKKFjXrxJQEgAZvdI1iw/xO3jZJ6+uK5sD6rw2xPHRBeg
	/gsTwIBlCEuKFwN8/B7wuZqgbY2sxdgDo69O/EfKbJuALOIqDaE+G/8ivopS8uxu67olGwcNUHi
	KeQ633/SWIqGYCssj/79NCA9rM=
X-Google-Smtp-Source: AGHT+IFja2SGfrTtCyPdRJCCefTmrgo0mQhH1O6x561N6cabqmvG2QM8w3ohhfxToBTf2XJdX84zA191m+AeXdLVuso=
X-Received: by 2002:a05:690c:3582:b0:735:8634:be68 with SMTP id
 00721157ae682-73890cb0553mr52912587b3.23.1758205148353; Thu, 18 Sep 2025
 07:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com> <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
 <20250918095950.h7wmz2qj5e6khtwr@lcpd911> <20250918131230.GD9196@nxa18884-linux.ap.freescale.net>
 <20250918134039.zkpeqsbf6m2ymxvt@lcpd911>
In-Reply-To: <20250918134039.zkpeqsbf6m2ymxvt@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 16:18:32 +0200
X-Gm-Features: AS18NWB-C7Q2eLiy5k262B4Ual4xN_o15_I0cJZ8lRcTd3E2RvJskp1XeHp2s5E
Message-ID: <CAPDyKFrweJTBHfOOU5r8Lcfs-dsTj94A=JK8+jKDqwJ0jNfiQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pmdomain: core: Introduce device_set/get_out_band_wakeup()
To: Peng Fan <peng.fan@oss.nxp.com>, Dhruva Gole <d-gole@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, imx@lists.linux.dev, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 15:40, Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Peng,
>
> On Sep 18, 2025 at 21:12:30 +0800, Peng Fan wrote:
> > Hi Dhruva,
> >
> > On Thu, Sep 18, 2025 at 03:29:50PM +0530, Dhruva Gole wrote:
> > >On Sep 02, 2025 at 11:33:00 +0800, Peng Fan wrote:
> > >> For some cases, a device could still wakeup the system even if its power
> > >> domain is in off state, because the device's wakeup hardware logic is
> > >> in an always-on domain.
> > >>
> > >> To support this case, introduce device_set/get_out_band_wakeup() to
> > >> allow device drivers to control the behaviour in genpd for a device
> > >> that is attached to it.
> > >>
> > >
> > >Thinking more into it, to me it seems like if the intent here is to only
> > >allow the device drivers to figure out whether they should be or not be
> > >executing the suspend/resume_noirqs then that can still be checked by
> > >wisely using the device set_wakeup APIs in the driver itself.
> > >
> > >Not sure why this patch should be necessary for a
> > >driver to execute the suspend_noirq or not. That decision can very well
> > >be taken inside the driver's suspend resume_noirq hooks based on wakeup
> > >capability and wake_enabled statuses.
> >
> > I should join today's SCMI meeting, but something else caught me (:
>
> It's alright, maybe see you in the next one ;)
>
> >
> > Thanks for looking into this.
> >
> > In genpd_suspend_finish, genpd_sync_power_off will be called if
> > "(device_awake_path(dev) && genpd_is_active_wakeup(genpd))" is false.
> > So if the device is enabled wakeup, the genpd will not be turned off because
> > the check return true.
>
> Umm I think this device_awake_path stuff is only going to be true when
> someone calls device_set_wakeup_path, I don't think it is going to
> return true for a wakeup_capable device. I know all these "wakeup"
> terminology and APIs have become all too confusing :( , so maybe Ulf can
> correct me.

The PM core checks device_may_wakeup() in device_suspend() and then
sets dev->power.wakeup_path = true;

The device_set_awake_path() and device_awake_path(), is to allow
drivers/subsystems to enforce its device to stay powered-on during
system-wide suspend. This may be needed even if the device isn't
configured to deliver system-wakeups.

> I maybe misremembering, but I have seen in some cases where a driver may
> have marked itself wakeup_capable but the suspend hooks still do get
> called... So your concern about genpd_sync_power_off not being called
> due to wakeup capable device driver may not be valid... Again please
> feel to correct me if I am wrong.

The system PM callbacks should get called no matter what.

The problem Peng pointing out, is when genpd_suspend_noirq() (which
calls genpd_finish_suspend()) is called for a device that is attached
to a genpd, we may end up bailing out, preventing the power-off for
its PM domain, while it may be perfectly fine to allow the PM domain
to be powered-off.

The particular code we are looking at, is in genpd_finish_suspend():

        if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
                return 0;

>
> Did you also look at the wake IRQ stuff I mentioned?
> In the path you're talking about it just checks
> device_awake_path(dev) && genpd_is_active_wakeup(genpd)
> However if the device irq is just marked as a wake IRQ, I don't think
> that is checked anywhere in this path. So definitely if the IRQ of your
> device is set as a wake IRQ, it will still get suspended and resumed as
> usual and that's what you want right?

The missing piece for the wake_irq, is to know whether the interrupt
can be delivered via an out-band-powered-on-logic, thus without
requiring the device to stay powered-on during system suspend.

[...]

Kind regards
Uffe

