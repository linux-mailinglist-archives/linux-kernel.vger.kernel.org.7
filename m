Return-Path: <linux-kernel+bounces-876048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667AAC1A9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23A6568282
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78139340A62;
	Wed, 29 Oct 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBsqcdD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223B30748D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741641; cv=none; b=d62xy3vxWI/1w/CZBkuubVCtqRhLMTIq6DPB/g2vA2xVk1ylYghTlduUouh+YcOtH7boRaCdnHnghNbN9ReKedM4/uqZh8BQxDeznR/hJtVz0TcYJnOq28c0vbs1ilXGw3UWmxsrWNnBt274TmtRexSpkTt0Gt5UoJr/7hdy7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741641; c=relaxed/simple;
	bh=HLyHzsIaMwJmvkk7chpxGJkKDCM2GZFPnaxVFoPfG2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omkk63t+TZLPvqD55H1AaqMpQzorDG4DP4iHiU6I/O53EgiqaHTcrpd5FKsaw4FW6wzoUqL2GA4BzOES7suAaQ9zV7fLhQQ59P+RvaZgYznjgSjkib0ACag1oQzyLnmupWZc3zUow3E74cvsrmoeVWihaN9JYm31bNTXxYaStTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBsqcdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5125C4CEF7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741641;
	bh=HLyHzsIaMwJmvkk7chpxGJkKDCM2GZFPnaxVFoPfG2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XFBsqcdD446gGo2qwB9AHKHR60Jqc6qQ4Hzh98+WpBeieeEqlHG7PRVTXPleazCm9
	 E1MRUiI5JZ9djk/L6Pz54PTGH3rA0ZQ8LojBjn4stJm3KwKjiW4Bw3/v72PdZ47lmj
	 e4e1sZ7COVAAeJJ/dNZSqynpVXs32rQTYwVfdNOTqn7IeK2ybJAUwUzxFffTZ17uNc
	 rqTnZqvhASn0m594tTjSbHN39u4jhdsXjTgRBRANZ++GYIC3xlv/Da7iqqj8dYjqwe
	 n4OWldBPasDQnx9tw7o9nc9PCl1oUA/4JHIuRnrH8316NNsCKOWM3DIGMKVyID1ga7
	 5Xf0u41Uv536Q==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c2846c961fso4612470a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:40:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXluRS61JWENbahwsmcuWKrHoYkVR4PCZkb/1IhxV8OWOFBK6/JnttRykcIwQz3/c52IY/PiPzk9Zj//2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tW8Ke3xb+EVlB+hAZ7i2ltLzKPgYiQTELTTujiym4ivYt594
	1D3unkAAksyVVgpG+w6W4zT689HE9sa2pf12ZHFkEqPxgQxZKUqFHJB9xxr2/v8V06C9RcL5ZJ3
	nPbpWegqyhdlt2XCvci+PsT5FHvga+yU=
X-Google-Smtp-Source: AGHT+IFLVKnwIIB4XqhE3o7qLBAL4OIdeCzcw/6i3Psjve4CcWWNJZTgMBA+WmTTq+UkAbwEf6DwDvPURJ99rfKYc2U=
X-Received: by 2002:a05:6808:218c:b0:44d:a5ff:dfc5 with SMTP id
 5614622812f47-44f7a54f9efmr1226879b6e.47.1761741641032; Wed, 29 Oct 2025
 05:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com> <40c2f7d9-23cf-4536-a1b1-0a55a0707830@arm.com>
In-Reply-To: <40c2f7d9-23cf-4536-a1b1-0a55a0707830@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 13:40:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hMSNfEVg-PUrzvPLO2oMFRJypgn26w7B8XqsD1_9KT4A@mail.gmail.com>
X-Gm-Features: AWmQ_bkLCpdDmvZP6qSfrPZvMq_s6DscBj09Lsu1HyP9BjEkEcmTkBf7tEIC-I8
Message-ID: <CAJZ5v0hMSNfEVg-PUrzvPLO2oMFRJypgn26w7B8XqsD1_9KT4A@mail.gmail.com>
Subject: Re: [PATCH RFC] PM: EM: Add to em_pd_list only when no failure
To: Lukasz Luba <lukasz.luba@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc: arm-scmi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, 
	Pavel Machek <pavel@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Changwoo Min <changwoo@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:00=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/28/25 14:23, Peng Fan wrote:
> > When em_create_perf_table() returns failure, pd is freed, there dev->em=
_pd
> > is not valid. Then accessing dev->em_pd->node will trigger kernel panic
> > in em_dev_register_pd_no_update(). So return early if 'ret' is non-zero=
.
> >
> > Kernel dump:
> > cpu cpu0: EM: invalid power: 0
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000008
> > Mem abort info:
> > pc : em_dev_register_pd_no_update+0xb4/0x79c
> > lr : em_dev_register_pd_no_update+0x9c/0x79c
> > Call trace:
> >   em_dev_register_pd_no_update+0xb4/0x79c (P)
> >   em_dev_register_perf_domain+0x18/0x58
> >   scmi_cpufreq_register_em+0x84/0xb8
> >   cpufreq_online+0x48c/0xb74
> >   cpufreq_add_dev+0x80/0x98
> >   subsys_interface_register+0x100/0x11c
> >   cpufreq_register_driver+0x158/0x278
> >   scmi_cpufreq_probe+0x1f8/0x2e0
> >   scmi_dev_probe+0x28/0x3c
> >   really_probe+0xbc/0x29c
> >   __driver_probe_device+0x78/0x12c
> >   driver_probe_device+0x3c/0x15c
> >   __device_attach_driver+0xb8/0x134
> >   bus_for_each_drv+0x84/0xe4
> >
> > Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a perfor=
mance domain")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >   kernel/power/energy_model.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index e669d5057fca6da9612575a1c626474e60e7f7c4..11af9f64aa8276e47e0a5b2=
d615b227368af5480 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -693,13 +693,16 @@ int em_dev_register_pd_no_update(struct device *d=
ev, unsigned int nr_states,
> >
> >   unlock:
> >       mutex_unlock(&em_pd_mutex);
> > +     if (ret)
> > +             return ret;
> >
> >       mutex_lock(&em_pd_list_mutex);
> >       list_add_tail(&dev->em_pd->node, &em_pd_list);
> >       mutex_unlock(&em_pd_list_mutex);
> >
> >       em_notify_pd_created(dev->em_pd);
> > -     return ret;
> > +
> > +     return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
> >
> >
> > ---
> > base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
> > change-id: 20251028-fix-energy-6b63b72ae9c6
> >
> > Best regards,
>
>
> Thank you for the patch!
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied, thanks!

