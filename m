Return-Path: <linux-kernel+bounces-734322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B61B08000
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE6C1C433CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94312ED865;
	Wed, 16 Jul 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjvcdJOC"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC72ED84A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702722; cv=none; b=gHZv+m0Xou7az//z2+lLgbxemhi6n/Tc92vYdFLTVNI2v6mtEAx7IJO2CWzdnFpXKhFI0NqSTp0RbbDaHZI82P4/nOi45z303g96qYYPluOFpni2eRHRnMv8ZR8Kshl6LjtlzDdvsdVf/EgLPZd6YM4ZrPPXkVe1wmhQ/D7Yj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702722; c=relaxed/simple;
	bh=Ch2tlYK+lFkiqXgNSqOKPn2MlZ4gJgr8uMm/TnLT6Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtQmLXfWri1ZmGTFvY/seTk7bQ72yG//j05SI/QK6YtosvO1IGeAVlx81ute4RwmzEyTFsg/M3opVyaXGRl0bAU8eYqqQar1k5SotWpWpSKjjMj27JmUXLPb/bR+ZxMXavpOBuvZHhVGYh3iU34uU9gi5zjJoT0V55vJ0OK27RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjvcdJOC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5344894a85aso209881e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752702719; x=1753307519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uXPQk6hRmhbSF8V14DLc/yhNRvrgo1G1fT5+KjBk5c=;
        b=BjvcdJOCjBwqreSvPEGcaNvXgnY8k5LwU13e5RGr0uOhUwJGPowVoboQemfTIqwfVK
         KsKUvWuh81SDQsZG1gTWKfO1j9f5Z3E0q6kg+qUQuN77gqiPG6eD4yIJdw1TRE5YDOPg
         Sp2reTZ0HUYJJo0/xeuVS5IJHrM8skPtfmDrm/8J+W5YWNdr2q+p+aWNWLcUybW7mNEn
         BIlLYACtjQscJHLqdc9z7r6dG8l9//HOZf8vnlsp56BKp1Qr/vDcSUfwTdewITgcoA5P
         aDYlrQqw53NSUZ23zHov3l6FUVzdoI5wTUbEJ2Nleg8CNc+WajA0RX8yu0csiesVJyi9
         WdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752702719; x=1753307519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uXPQk6hRmhbSF8V14DLc/yhNRvrgo1G1fT5+KjBk5c=;
        b=EIPrUTb9MCM/U8zpvKB1NkrTLA4GMPPoDA3Wrux1n7QOj3TcXg4cYqzlgmE0fGus9L
         u1AN/D1F5sclxborYrc9PkmKk16UL0E40BDEj3hEzruxiUZ6abzeTki3k8b17q+M67Gz
         WjmB7fBdcyR1uTy1/OzykLONjViR9d56XPcCO2mLxRe8vjqNcIXwY2Em16wf+QOlm/KM
         lg5BnBfyHZAO4pVOrS+6sbhnoL8JgtnOjLyuXumyFqkVPHLriKZ0TNyP4yklCLXRokjF
         JAZ9nNYkUQIEWZK2nL7xc+KPijdzY8qRhg9ComJwKYVQHfw6f0YP+7ysibQyuhpXblCp
         yCog==
X-Forwarded-Encrypted: i=1; AJvYcCUqUmeXC05K25o6m+8cOeCCeaULwHRVwVMbJ9L1qS0rv2yVMm3bT7KpY/oC5ifHKDKMYImcl/J+DhgYigg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfTMNjyR7jFC+ldzbheDQyXP6YPFzOS++z7b5xdulDq7yt1Dc
	m4S38BjPN2JaWb07L0oUO+dAuIIk2pZkwlsL//csMq32CyvZMSXrX/YS/cpXT055fVDSBVhsp2n
	EYMq6RijydMlQFcOjCg5DPEwJEWUHola6WnmzAbnC
X-Gm-Gg: ASbGnct3LRk3/fx8v4uZ85ffot+tYIteB9DzkdVN2Z1UdEB16LJe/YANiyxvUv0xZrv
	y5u3Eo7eMmykxXYRxFBaDTUq+lQ12/qoblIYGExbz34QIsZjm/oxKNGDcyxVkmFGrbj38hOyK7f
	np6QG04cI96UP6TB0OSNExOzATlGYNypJISn1MdytpI6wcqCDzHQ4kEaN4CZw7zHMRC7c2SAgvF
	VHH0hS4V5S7Dq0tv/GB27oVXns0on2UCvLRDA==
X-Google-Smtp-Source: AGHT+IGQWwBEzsHdrraNzyCDa0q42Pd5XLN5TuBKkjyYAtZa4roG3jaLawrftuxYZzBsy4p9g1N6LTwy4QoFO9mmN6U=
X-Received: by 2002:a05:6102:cc8:b0:4f3:36bc:554e with SMTP id
 ada2fe7eead31-4f890239799mr2960352137.16.1752702718422; Wed, 16 Jul 2025
 14:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6198088.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6198088.lOV4Wx5bFT@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 16 Jul 2025 14:51:21 -0700
X-Gm-Features: Ac12FXxMul7_ze1EjafvCq-YvJEn1jMq6HOKboTbOX10FBO1bERgm-lOY4avJSg
Message-ID: <CAGETcx-ddJMua5_VMNofr2vZ9n5Oyo4iT6Bac825L8tFqqQsxg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Rearrange suspend/resume error handling in
 the core
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that device_suspend_noirq(), device_suspend_late() and
> device_suspend() all set async_error on errors, so they don't really
> need to return a value.  Accordingly, make them all void and use
> async_error in their callers instead of their return values.
>
> Moreover, since async_error is updated concurrently without locking
> during asynchronous suspend and resume processing, use READ_ONCE() and
> WRITE_ONCE() for accessing it in those places to ensure that all of the
> accesses will be carried out as expected.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Based on the current linux-pm.git material in linux-next.
>
> ---
>  drivers/base/power/main.c |   79 ++++++++++++++++++++-------------------=
-------
>  1 file changed, 35 insertions(+), 44 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -767,7 +767,7 @@
>         TRACE_RESUME(error);
>
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>         }
> @@ -824,7 +824,7 @@
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
>         dpm_show_time(starttime, state, 0, "noirq");
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
>
>         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false)=
;
> @@ -910,7 +910,7 @@
>         complete_all(&dev->power.completion);
>
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async early" : " early",=
 error);
>         }
> @@ -971,7 +971,7 @@
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
>         dpm_show_time(starttime, state, 0, "early");
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 dpm_save_failed_step(SUSPEND_RESUME_EARLY);
>
>         trace_suspend_resume(TPS("dpm_resume_early"), state.event, false)=
;
> @@ -1086,7 +1086,7 @@
>         TRACE_RESUME(error);
>
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
> @@ -1150,7 +1150,7 @@
>         mutex_unlock(&dpm_list_mtx);
>         async_synchronize_full();
>         dpm_show_time(starttime, state, 0, NULL);
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 dpm_save_failed_step(SUSPEND_RESUME);
>
>         cpufreq_resume();
> @@ -1387,7 +1387,7 @@
>   * The driver of @dev will not receive interrupts while this function is=
 being
>   * executed.
>   */
> -static int device_suspend_noirq(struct device *dev, pm_message_t state, =
bool async)
> +static void device_suspend_noirq(struct device *dev, pm_message_t state,=
 bool async)
>  {
>         pm_callback_t callback =3D NULL;
>         const char *info =3D NULL;
> @@ -1398,7 +1398,7 @@
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 goto Complete;
>
>         if (dev->power.syscore || dev->power.direct_complete)
> @@ -1431,7 +1431,7 @@
>  Run:
>         error =3D dpm_run_callback(callback, dev, state, info);
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>                 goto Complete;
> @@ -1457,12 +1457,10 @@
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
>
> -       if (error || async_error)
> -               return error;
> +       if (error || READ_ONCE(async_error))
> +               return;
>
>         dpm_async_suspend_superior(dev, async_suspend_noirq);
> -
> -       return 0;
>  }
>
>  static void async_suspend_noirq(void *data, async_cookie_t cookie)
> @@ -1477,7 +1475,7 @@
>  {
>         ktime_t starttime =3D ktime_get();
>         struct device *dev;
> -       int error =3D 0;
> +       int error;

Are we still keeping around the error variable ... (question continues
further down)
>
>         trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true)=
;
>
> @@ -1508,13 +1506,13 @@
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend_noirq(dev, state, false);
> +               device_suspend_noirq(dev, state, false);
>
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error) {
> +               if (READ_ONCE(async_error)) {
>                         dpm_async_suspend_complete_all(&dpm_late_early_li=
st);
>                         /*
>                          * Move all devices to the target list to resume =
them
> @@ -1528,9 +1526,8 @@
>         mutex_unlock(&dpm_list_mtx);
>
>         async_synchronize_full();
> -       if (!error)
> -               error =3D async_error;
>
> +       error =3D READ_ONCE(async_error);

Just to cache the value locally so that the value used for the "if()"
check is the one that's sent to dpm_show_time()?

Put another way, why can't we also delete the local "error" variable?

Assuming we need to keep "error":

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>         if (error)
>                 dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
>
> @@ -1585,7 +1582,7 @@
>   *
>   * Runtime PM is disabled for @dev while this function is being executed=
.
>   */
> -static int device_suspend_late(struct device *dev, pm_message_t state, b=
ool async)
> +static void device_suspend_late(struct device *dev, pm_message_t state, =
bool async)
>  {
>         pm_callback_t callback =3D NULL;
>         const char *info =3D NULL;
> @@ -1602,11 +1599,11 @@
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error)
> +       if (READ_ONCE(async_error))
>                 goto Complete;
>
>         if (pm_wakeup_pending()) {
> -               async_error =3D -EBUSY;
> +               WRITE_ONCE(async_error, -EBUSY);
>                 goto Complete;
>         }
>
> @@ -1640,7 +1637,7 @@
>  Run:
>         error =3D dpm_run_callback(callback, dev, state, info);
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async late" : " late", e=
rror);
>                 goto Complete;
> @@ -1654,12 +1651,10 @@
>         TRACE_SUSPEND(error);
>         complete_all(&dev->power.completion);
>
> -       if (error || async_error)
> -               return error;
> +       if (error || READ_ONCE(async_error))
> +               return;
>
>         dpm_async_suspend_superior(dev, async_suspend_late);
> -
> -       return 0;
>  }
>
>  static void async_suspend_late(void *data, async_cookie_t cookie)
> @@ -1678,7 +1673,7 @@
>  {
>         ktime_t starttime =3D ktime_get();
>         struct device *dev;
> -       int error =3D 0;
> +       int error;
>
>         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
>
> @@ -1711,13 +1706,13 @@
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend_late(dev, state, false);
> +               device_suspend_late(dev, state, false);
>
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error) {
> +               if (READ_ONCE(async_error)) {
>                         dpm_async_suspend_complete_all(&dpm_suspended_lis=
t);
>                         /*
>                          * Move all devices to the target list to resume =
them
> @@ -1731,9 +1726,8 @@
>         mutex_unlock(&dpm_list_mtx);
>
>         async_synchronize_full();
> -       if (!error)
> -               error =3D async_error;
>
> +       error =3D READ_ONCE(async_error);
>         if (error) {
>                 dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
>                 dpm_resume_early(resume_event(state));
> @@ -1822,7 +1816,7 @@
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being suspended asynchronously.
>   */
> -static int device_suspend(struct device *dev, pm_message_t state, bool a=
sync)
> +static void device_suspend(struct device *dev, pm_message_t state, bool =
async)
>  {
>         pm_callback_t callback =3D NULL;
>         const char *info =3D NULL;
> @@ -1834,7 +1828,7 @@
>
>         dpm_wait_for_subordinate(dev, async);
>
> -       if (async_error) {
> +       if (READ_ONCE(async_error)) {
>                 dev->power.direct_complete =3D false;
>                 goto Complete;
>         }
> @@ -1854,7 +1848,7 @@
>
>         if (pm_wakeup_pending()) {
>                 dev->power.direct_complete =3D false;
> -               async_error =3D -EBUSY;
> +               WRITE_ONCE(async_error, -EBUSY);
>                 goto Complete;
>         }
>
> @@ -1938,7 +1932,7 @@
>
>   Complete:
>         if (error) {
> -               async_error =3D error;
> +               WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
> @@ -1946,12 +1940,10 @@
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
>
> -       if (error || async_error)
> -               return error;
> +       if (error || READ_ONCE(async_error))
> +               return;
>
>         dpm_async_suspend_superior(dev, async_suspend);
> -
> -       return 0;
>  }
>
>  static void async_suspend(void *data, async_cookie_t cookie)
> @@ -1970,7 +1962,7 @@
>  {
>         ktime_t starttime =3D ktime_get();
>         struct device *dev;
> -       int error =3D 0;
> +       int error;
>
>         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>         might_sleep();
> @@ -2005,13 +1997,13 @@
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               error =3D device_suspend(dev, state, false);
> +               device_suspend(dev, state, false);
>
>                 put_device(dev);
>
>                 mutex_lock(&dpm_list_mtx);
>
> -               if (error || async_error) {
> +               if (READ_ONCE(async_error)) {
>                         dpm_async_suspend_complete_all(&dpm_prepared_list=
);
>                         /*
>                          * Move all devices to the target list to resume =
them
> @@ -2025,9 +2017,8 @@
>         mutex_unlock(&dpm_list_mtx);
>
>         async_synchronize_full();
> -       if (!error)
> -               error =3D async_error;
>
> +       error =3D READ_ONCE(async_error);
>         if (error)
>                 dpm_save_failed_step(SUSPEND_SUSPEND);
>
>
>
>

