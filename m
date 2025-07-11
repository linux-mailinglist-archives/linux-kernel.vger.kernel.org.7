Return-Path: <linux-kernel+bounces-728102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6FB023AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCC65C24A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BA1ADC7E;
	Fri, 11 Jul 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMal3bcb"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B12F2C5C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258658; cv=none; b=Q6yqC2+vIJqHvgx5fiiLNDz4wg6ggiO9pWpfN1xkdmmQtGswF9xlDQS11sEsRVxhXW9wDd8fWy944aFffiuxwG2621L97hXR7xw+inkL7xCGXFYpTGJjbwIL4dcRs5OuuzFcqExuMQW0TQN1j1kFISR4BvMHH9N1zhetFkr9LI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258658; c=relaxed/simple;
	bh=Nmg55UacNAt1MCkhGyguzInl29Fwjzoiq7ro0EkLYEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8I83DTNPfksmtKaJgwhc71p3T/sFLdhwMoIF+lyTkmAku1WZBGw7zsscJc53C+pehq1+gQZxW4/DI5gPfL8DlyxKfqtNOJfhWO/oBj5igqFkjLVIX+2HmlKtwcKlhG8fQdaZMJ/c2Ylt09o8T7ACE9epgikT+J1ur6I/Xt/inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMal3bcb; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5315acf37b6so1006986e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752258656; x=1752863456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE8nn0HHw9/47yIri3Y+l9GYg+RPDKGws82z0RKSszU=;
        b=lMal3bcbq+rLprZNxwArt6tp/TzN1/4IowGlvfA7HufPnbLHcSQ7fDxzLIpbunfPn/
         J4t+oPphFxwenIfm4h4c0m7lQkRNGEwOUw2ScTv8gP1C/tanzYW+B8dGwXf17yNPbZk0
         dBhY50XtakGuQoWE2qMTLPjtHvugWJ8An7CtTZ4eJi8clNt8ZYwN6z/timb+NLXJu0cM
         U8mo8tAnKYNrNn4nhnZ0klmFcEvXhGYkMNBinmXHxv8YkLBfvG3NEI2Zjg51X20cYM8x
         SmArqWut18gv5pvKlDpbmQwczF8ZoZkTHa64YCfME3KAwGTQjkub3LO69negGG8z4E+b
         Bi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258656; x=1752863456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE8nn0HHw9/47yIri3Y+l9GYg+RPDKGws82z0RKSszU=;
        b=lmOy2aLAsaL0ket7LP+UxIKVgCJS7v5sXoAAyXY+xpNLbPRqBgSWbcCKPaz5SOEsJI
         /sNvGbwkh/LCYaiJ76pDJwgIcaKP2wy2Auqc43rw1WjWLRQ25RYweQAOJZWUKfCNwgTv
         mLX0KXMg8i/pWNST6ZPK0Uu9N6g6b3tcLCGU+vxGMkVjZtaeowSdFQVTSZnoVUl9RIoQ
         Nk3NJ+Xsq3YctkPVzp/zIvzTQIQMm/gPTp/59IoCRqF+ZnDhWZHnoUBEstJAhGjX7T79
         fceTARQoABGTJV1BG/kKZZ+f2XK+5XaUO6X4fFifgllY+bCTXmXvxrNBaU+mrxgvbHs1
         9afQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXqjpjhusbnHmtCW/VDOyHE/OeGfHbosAXK2l01UkvH3UDqKZcI1865+nHoNNXKr++vO9tSgo+MfeYtng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2Yl5qhexBlKY5nYv6ctfzb1GKBzxCM1CuulUzxb0/gKfYhwJ
	IoiSrNG6aF4QIqQDsDOAVOcJJrDgCEKnkRqc9AOvIwZuBFLWidyzopQvK1hU4lGXfeH7qlyKq1E
	2TucovhQkflIBMJX2pxWJxcmOPC2F+BXy8J6qRjAd
X-Gm-Gg: ASbGncvO8LdOrZuNsHp/cVI8/le0jH+UBEuWsa1y+0GLkuZEtVS9QcmrgmpilHq9Y1x
	YX8OGV8RQgmw8p89g0WmajYVA+NthXJngY/nPOKr6T0wBBBgTi+kLszkC6uecSdDDURVHhtXd53
	mChXsUEHAzTZ+J49KARPo/mZbuL7QKPsLZpJib+4QkMBAN/U7jsmqUZvFmdpfm9QTgHy2U5Eazu
	5+3lg==
X-Google-Smtp-Source: AGHT+IEnIchNt9XXYjk8FflZHLYiuvT9hoitNJFrSaxPQeTPnk+uOC5uvDHLC9XkdNS6ptSNZRj89FbPoLaz28sCihA=
X-Received: by 2002:a05:6102:6d3:b0:4e6:d995:94f9 with SMTP id
 ada2fe7eead31-4f64275c1f2mr4367050137.12.1752258655328; Fri, 11 Jul 2025
 11:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <22630663.EfDdHjke4D@rjwysocki.net>
 <e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org> <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 11 Jul 2025 11:30:17 -0700
X-Gm-Features: Ac12FXxPhiTgQ7Xfo8HHWb4xtysDMU6yLS13OIYnZe5bVvAlPBVJWskWEcDJ_4w
Message-ID: <CAGETcx98iQqA_EOWjkFCkgtrt0JppMQE98OTuCXj2zZa2S1yPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	William McVicker <willmcvicker@google.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:54=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Jul 11, 2025 at 3:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Jul 11, 2025 at 3:08=E2=80=AFPM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> > >
> > >
> > > Hi, Rafael,
> > >
> > > On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > According to [1], the handling of device suspend and resume, and
> > > > particularly the latter, involves unnecessary overhead related to
> > > > starting new async work items for devices that cannot make progress
> > > > right away because they have to wait for other devices.
> > > >
> > > > To reduce this problem in the resume path, use the observation that
> > > > starting the async resume of the children of a device after resumin=
g
> > > > the parent is likely to produce less scheduling and memory manageme=
nt
> > > > noise than starting it upfront while at the same time it should not
> > > > increase the resume duration substantially.
> > > >
> > > > Accordingly, modify the code to start the async resume of the devic=
e's
> > > > children when the processing of the parent has been completed in ea=
ch
> > > > stage of device resume and only start async resume upfront for devi=
ces
> > > > without parents.
> > > >
> > > > Also make it check if a given device can be resumed asynchronously
> > > > before starting the synchronous resume of it in case it will have t=
o
> > > > wait for another that is already resuming asynchronously.
> > > >
> > > > In addition to making the async resume of devices more friendly to
> > > > systems with relatively less computing resources, this change is al=
so
> > > > preliminary for analogous changes in the suspend path.
> > > >
> > > > On the systems where it has been tested, this change by itself does
> > > > not affect the overall system resume duration in a measurable way.
> > > >
> > > > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-sar=
avanak@google.com/ [1]
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > I'd like to let you know of a suspend crash that I'm dealing with
> > > when using the OOT pixel6 drivers on top of v6.16-rc4.
> >
> > Well, thanks, but there's not much I can do about it.
> >
> > It is also better to start a new thread in such cases than to reply to
> > a patch submission.
> >
> > > Similar to what Jon reported, everything gets back to normal if
> > > I disable pm_async or if I revert the following patches:
> > > 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
> > > aa7a9275ab81 PM: sleep: Suspend async parents after suspending childr=
en
> > > 0cbef962ce1f PM: sleep: Resume children after resuming the parent
> > >
> > > I also reverted their fixes when testing:
> > > 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
> > > d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-com=
plete devices
> > > 079e8889ad13 PM: sleep: Fix list splicing in device suspend error pat=
hs
> > >
> > > It seems that the hang happens in dpm_suspend() at
> > > async_synchronize_full() time after a driver fails to suspend.
> > > The phone then naturally resets with an APC watchdog.
> > >
> > > [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend becaus=
e eeprom-m24c64x is in use!
> > > [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): pla=
tform_pm_suspend returns -16
> > > [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend ret=
urned -16 after 1596 usecs
> > > [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: erro=
r -16
> > > [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, list=
_empty(&dpm_prepared_list)? 1
> > > [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchroni=
ze_full
> > >
> > > The extra prints are because of:
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index d9d4fc58bc5a..3efe538c2ec2 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
> > >                         break;
> > >                 }
> > >         }
> > > +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepared=
_list)? %d\n",
> > > +              __func__, list_empty(&dpm_prepared_list));
> > >
> > >         mutex_unlock(&dpm_list_mtx);
> > >
> > > +       pr_err("tudor: %s: before async_synchronize_full\n", __func__=
);
> > >         async_synchronize_full();
> > > +       pr_err("tudor: %s: after async_synchronize_full();\n", __func=
__);
> > > +
> > >         if (!error)
> > >                 error =3D async_error;
> > >
> > > The synchronous suspend works because its strict, one-by-one ordering
> > > ensures that device dependencies are met and that no device is suspen=
ded
> > > while another is still using it. The asynchronous suspend fails becau=
se
> > > it creates a race condition where the lwis-eeprom-m24c64x is called f=
or
> > > suspension before the process using it has been suspended, leading to=
 a
> > > fatal "device busy" error. Should the failure of a device suspend be
> > > fatal?
> >
> > It shouldn't in principle, but it depends on what exactly is involved a=
nd how.
> >
> > It looks like something is blocking on power.completion somewhere.
> > I'll check the code, maybe a complete() is missing in an error path or
> > similar.
>
> It doesn't look like anything is missing in the core, so the suspend
> failure seems to be triggering a deadlock of some sort.
>
> The remedy should be the same as usual in such cases: Find the device
> that is marked as "async" incorrectly and make it "sync".
>

I'm very behind on this thread, but the patches I sent out were well
tested on Pixel 6 OOT drivers and didn't cause any issues. So I think
the rewrite is missing some condition my patches accounted for.

Also, comment on some questions earlier in the thread, fw_devlink=3Don
ensures none of the device links have any circular dependencies (as
does the device_link_add()) API itself. So, there shouldn't be any
cyclic dependencies. The only cycles that fw_devlink creates are
SYNC_STATE_ONLY device links that are deleted as soon as a consumer
probes.

Also, people facing cyclic dependency issues, if fw_devlink is not
discarding the "bad" link in the cycle, you can give it extra info in
DT if you use post-init-providers. Please try that out.

-Saravana

-Saravana

