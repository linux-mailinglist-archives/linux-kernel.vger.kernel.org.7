Return-Path: <linux-kernel+bounces-884817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614BC3139B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48561890A38
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16972D9EC4;
	Tue,  4 Nov 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C76AKnm9"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88231A06F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262871; cv=none; b=isiBNwbR5nMyLIJ9yRybVfYTYOQCcFa44kQ0JSQKfv54xmRjUFLhicw6SiYHeUCNQfebkYSpCKXEnylDI2OXPss+zsF6Xl6BGsQKxN2shmG7fUSlf4wKk/+oS03Bafbku+kzaiGzZ4MQEbzzIsNmfBRhsSxwRBdrLFEAcQGRXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262871; c=relaxed/simple;
	bh=xYFy9FvuPfNQPztS84ipLwgad6MW8ZjCqUyalulzpdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfvYtKP6UWSPAbdqIMVL6gHL2tAh+zy1Glty7mFiuU+eC7BrChvr/5GdlE3OpgcSqjZiwXCdhYWpxzI7o216G/Swn0urC39wjRG70iLQbUoDxYp7Off9Kt0nrKCc2s0yt+ks1evyPVTVvSpfT3JgRWvXHvRlU/Mcz+yfncALTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C76AKnm9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7867497ad2fso29971077b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762262869; x=1762867669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9K6kgfVqBppsAmCOCyx1kErguRE3B1GwWQGCap1HUE=;
        b=C76AKnm9F392/QLM1fOKtR7YaKjA8bDZ282OXtGHFtA8wmg7XsZE5OMn+f0CR+bjTE
         y1JuivN3L3d7lAFpjlsHcHyRtSmTKeU8Gt3pYgfNaK8+GufUtAX9XUk5Q8Ad7m4S4hQ1
         DNMXOZuHnktKvqRZhd0/GtNzNbqNB0fOHAOcDARQaftYgoqQvQRLJ9Q4xMz9Qsf9bP+4
         NDhVAcYSxzaWskpVcynVxMNW8ECkVG0wepYhULK1z9MSZZYA4sJGysX2L3cR+EaKr/sy
         3wzYPcoM26puimX8oGAznyEnYLKlQJxMk2OZaMhbe3aw/2ld0o6MZ1c89J7VAcKvWOwW
         D1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262869; x=1762867669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9K6kgfVqBppsAmCOCyx1kErguRE3B1GwWQGCap1HUE=;
        b=Eo1q/bi+ouuTsbPEpRgzCvrqrMZmchD4rNe3XnHydjse+AZcndP/YC1IlqTZFjLHWa
         5r9Ifgt6/9unTjB4iwyOxsI4hYgjlI+FlVu7Bu/E5Q7l1Dey52yykzuC5bZh7jYuBn/P
         MgpJJ3IyiAD1RKU+VNwQeqCKhzHIfphnbrtlyzYWiXy/dscEZHQSnYXEv0PRCOmivL83
         fdS7BgE7viXz0xQW7w7lvoX8RmCvi4z2aRlTS/91gQmegn3qdg0kqC/MvFP/DvmCjJ7L
         oN7jkZZT65FdVyhfAyTxIsoPFn0XOdJBvIzCx4VUzws/VJ/C1vSpfcvh5yZnZ/wPdOwV
         As3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9jVOKMD/1D4p/Ze/jkfxTEtou1xBY2W/P4+6+gaiZMqeb+wnLiWMXsU4BGQJ80gTr5+HgpgtVPCGqKSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmysZO0Uo0B+MmkCSsGH3Gk6AeLt5onuRCT49K1JhNKS+IK+A+
	l3HzmpjsgVo9WOni7KMA/ZDxu9KxVj+v5Nd4qa3k+bFcdDyRtyHNv7uBw5jjHYE7TpZ/qNBvEYL
	z9qdoGjqVwYm89qXobRRaf5TeyrkR1rwOfUuNXE7CSg==
X-Gm-Gg: ASbGnct9LJnLupBAPdzJdIpOnPbuSVyzi4PEevSzietXAzdYnHpdWzhwNgreCbKP/K7
	aYe+rQ7KqADe14Tggl4ntOEiCnO7OvRZ/Sc+xmJ187XFCe/w6qKhnKBAqRERZ7IunGVaSMomHCR
	Q95zLs9sirh9vMu0dwhFY41EbnsHHOxxSVKGd3FRFo64Lh+y9GAjMN9zcNacYrxN5qWDOt7/GTy
	oneUoewEcJAnFLtAyZuplkQ/Zh1wNa+3RoivKD4e1E376+NM811oG7KZsOAiVwBrd3q82my
X-Google-Smtp-Source: AGHT+IFzUemwxrYRkIidNJk8Gu5NYrvaF6biCWhPxX1iUkfnGLHCgGf3jtLrSqkXnA51haW816YZzBSUheLb33VKrO8=
X-Received: by 2002:a05:690c:5507:b0:786:8abd:bbcf with SMTP id
 00721157ae682-786951653bfmr24861227b3.31.1762262869125; Tue, 04 Nov 2025
 05:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org> <20251029081014.443psmqznd2pqm4i@lcpd911>
 <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
 <20251030164542.atnhs4wgk6ggmmly@lcpd911> <CAPDyKFqTS6-69QfqdPtRrbkSqwxEnO1CPXLnRvM6WsOKNZgyQQ@mail.gmail.com>
 <20251031183724.2opdnjya7gu6fx6v@lcpd911>
In-Reply-To: <20251031183724.2opdnjya7gu6fx6v@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 14:27:13 +0100
X-Gm-Features: AWmQ_blLizT1f9WrbeiHr43xiYViNgQnDVhrGGdghJQaJwQNmb9X1hfQr-6XS_I
Message-ID: <CAPDyKFqyQuGC=ByxbDfJfFK_VRkwjTEQDXj1ket-51u+4_FYpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 19:37, Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 31, 2025 at 14:47:29 +0100, Ulf Hansson wrote:
> > [...]
> >
> > > >
> > > > > It seems an overkill to me that a userspace program be required to hold
> > > > > open this file just to make sure the constraints are honoured for the
> > > > > lifetime of the device. We should definitely give the freedom to just be
> > > > > able to echo and also be able to cat and read back from the same place
> > > > > about the latency constraint being set.
> > > >
> > > > So you'd want a sysfs attribute here, but that has its own issues (the
> > > > last writer "wins", so if there are multiple users of it with
> > > > different needs in user space, things get tricky).
> > >
> > > sysfs makes sense, then would it make sense to have something like a
> > > /sys/devices/system/cpu/cpu0/power/cpu_wakeup_latency entry?
> > >
> > > IMHO userspace should decide accordingly to manage it's users and how/whom to allow to
> > > set the latency constraint.
> > > We already have CPU latency QoS entry for example which is sysfs too.
> > >
> > > >
> > > > > One other thing on my mind is - and probably unrelated to this specific
> > > > > series, but I think we must have some sysfs entry either appear in
> > > > > /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> > > > > state that the governor has chosen to enter based on the value set in
> > > > > cpu_wakeup_latency.
> > > >
> > > > Exit latency values for all states are exposed via sysfs.  Since
> > > > s2idle always uses the deepest state it can use, it is quite
> > > > straightforward to figure out which of them will be used going
> > > > forward, given a specific latency constraint.
> > >
> > > I disagree regarding the straightforward part. There could be
> > > multiple domain heirarchy in a system for eg. and all these multiple
> > > domains would have their own set of domain-idle-states. All of them having their own
> > > entry, exit, and residency latencies. I myself while testing this series
> > > have been thoroughly confused at times what idle-state did the kernel
> > > actually pick this time, and had to add prints just to figure that out.
> >
> > If I understand correctly, most of that confusion is because of the
> > misunderstanding of including the residency in the state selection in
> > regards to QoS.
> >
> > Residency should not be accounted for, but only enter+exit latencies.
>
> Understood your point on the latencies, however the point remains that
> in a multi domain , multi idle-states case, do we really have an easy way to
> determine what the next choice of idle-state the governor is going to
> make? We don't even expose the entry exit latencies in sysfs btw...

I agree, we should extend the sysfs/debugfs information about the
domain-idle-states with this too. Especially since we already have it
for the regular idle states that are managed by cpuidle.

>
> >
> > >
> > > When implementing these things for the first
> > > time, especially when one has complex and many a domain idle-states it
> > > would indeed help alot if the kernel could just advertise somewhere what
> > > the governor is going to pick as the next s2idle state.
> >
> > The problem with advertising upfront is that the state selection is
> > done dynamically. It simply can't work.
>
> I understand it might be done dynamically, but as IIUC the only
> constraint being taken into account is really coming from userspace. I
> don't think this series is taking into account or even exposing any API
> to kernel world to modify the cpu wakeup latency (which I think you
> should, but that's an entirely orthogonal discussion, don't want to mix
> it here). So as far as "dynamic" is concerned I feel if the userspace is
> having control of which processes are setting the cpu wakeup constraints
> then it's entirely okay for kernel to tell userspace that at any given
> moment "this" is the next s2idle state I am going to pick if you do a
> system s2idle right now.
>
> >
> > >
> > > Also, I am not quite sure if these latencies are exposed in the
> > > domain-idle-states scenario ...
> > > I tried checking in /sys/kernel/debug/pm_genpd/XXX/ but I only see
> > > these:
> > > active_time  current_state  devices  idle_states  sub_domains  total_idle_time
> > >
> > > Maybe an additional s2idle_state or something appearing here is what I
> > > was inclined toward.
> >
> > That sounds like an idea that is worth exploring, if what you are
> > suggesting is to extend the idle state statistics. In principle we
> > want a new counter per idle state that indicates the number of times
> > we entered this state in s2idle, right?
>
> Absolutely, having a "global" kind of a place to find out the s2idle
> stats would really be useful.

For regular idle states that are managed by cpuidle, those have a
per-state directory called s2idle (if the state is supported for
s2idle), with usage/time counters.

That said, I agree, it's a good idea to add something similar for the
domain-idle-states that are managed by genpd.

Let me think about it and I will post a couple of patches that add
this information about the domain-idle-states.

Kind regards
Uffe

