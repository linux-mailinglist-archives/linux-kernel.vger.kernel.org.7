Return-Path: <linux-kernel+bounces-880283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE7C25571
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CA6B4E9DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF82BF017;
	Fri, 31 Oct 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQQwEpWW"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E5241679
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918489; cv=none; b=Df8CGXyELYwyOUYBSg491290YvaTRG5miqOXPJH2yJaSnW1QBKvd30KeSsTaBsldi7SohNbvinhK2TTlZKhCJTw4Q0HOknmHDk80D1oQmzRN7AW8DhqmZ9NQaHNX2TWC6eC3i2LfEj/raqSj2oFS+pvrbi2B+Y0gXizpXzhR+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918489; c=relaxed/simple;
	bh=m4d0TEVEKPm8SxpLnu/gK8YS9LXAMy6B2RvDA6hQIcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yddmn5rDUKQRswCF02h3zXdt+0zyjgZW03YQPU2SUVGm2yGrHGmq1VBobe/qyKC2RSOa9F2CPZgvf54qzxgRZ5TPV6cRpCBIRLFhJhNoLlaoo1bg1/dou74++MlTFIzlXzumtz2EULPI31CbXDCF7Sru5VcUPR5c5tuxfJHQ3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQQwEpWW; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e16fbdd50so2174412d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761918485; x=1762523285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IKMsypE+yNRUurFmetSHUW8DIToelSK2hDWwm/+SOg=;
        b=eQQwEpWWCjo3DTyh7AnsJMlLnAE1zTc3nR+9purxkZvLfKTFuDBKqYxGW/GhA4Quux
         GAI6VSbsr0AtZKEkRm+CUCsTGaQ9zBLRfo+1bDHtIHO9zrSdag1rX7wcIyqhIi9GcdM6
         NoPzD7DkF/qLMBQZApBj1Zf5lW6m71AZ3Hju+ws7IUnqLAnB3fyIwlR6Z7/VkC5ILwtI
         yyYICYUEKGGLL7787t66IUE2/y8BMk4nN4+TNpLJqBKiEhF5Fu2JsqO4Bnp0vpXMgrhx
         ltBvCWGD9wNXm1xbAXVkxReLEwIKM5ClE+5ENYSWG72lMXcdBeJFeO5lJQ7bI1/eKkN5
         z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918485; x=1762523285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IKMsypE+yNRUurFmetSHUW8DIToelSK2hDWwm/+SOg=;
        b=SkbRQJETUtmmPG+YkADu5Jm/hzFDqL1FLIH+fzbi4v2Hyj2iD7GFWijVdWO0gkJazA
         EDEIbmJsTAaIm/VJphnB0sXtCOUMFPLQeNvJj+n26v9j2Ff0sYwXxZqZ7DawvL1Fh3fM
         ABfLmuvQl4LZtOD8nuBtgVHlzF4UVv0VnvM7bn3zJe0kU3A2FOTStiNP2nSifCvxxSVY
         rbknzHJwFIuDTgoEfwahrenndAsLdJ+Ow6ZjzBm6spzFoSE1gllP74gSa2k+JWzT0zCr
         4X+Jg3gA6kTx4UYP2i8HAWND/JIeSOA7QcKA2Je/CWKkoOdgRoMBp/jDNujGRKrFdetC
         5TVA==
X-Forwarded-Encrypted: i=1; AJvYcCXWPo3SFAMaWya0hDGfwaKKc/M1HSrAfIqBVmo7c3IFH2IPqE3JhO5+cR4WgN9OK5TJz8KB8ZUGPXtLswc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjXrUKJuUhRUQycWZY0NrN9WEmj9RYpkMEnGsr1b9wmsPYxJo
	ZWpbJ3KZaKCQYZ3fD9AVPsJMLsH6323yy//BVhKWgra8qh3Qv4pS7lZi1U8FcWj0o0dB0QKlisU
	7V53at3TmVauGKqLFJKP3FROIjvuI7WsxxAuTAX7teQ==
X-Gm-Gg: ASbGncsf391ELLIwLpqLPX1MMBAgfOiNFSg6Mj/fV0G1FIdNuLtUXZFCa6bP0G8VIsy
	zh9Tf4wHql9qjMs73ICQwEanfqAgI7YM0ytjN1Drb3FrLiXAHErJSVrSPi3rvolPVtOyuvZYTUy
	zuijPKCnBFU4FeNGv6Q5OMbHuDPCpeQHlbB0OD+IVCOTktdWIVKxNS0+ESpt8zDo6fArLfaWMQY
	JYtl9rem3PDD9qL7lwwtrUu6HXgfCkkiRRGXr555ixhMw/OjQ9CeJFWxMhg3A==
X-Google-Smtp-Source: AGHT+IGVcGqzFiIeaGUMTxGjSBMNFcrT+skyvR/Zq38w4b0meGhVP0vyEmyQ6O9HNiJoistD3h5W4kD1DiETyutaiP0=
X-Received: by 2002:a53:d018:0:b0:63f:556b:5b6 with SMTP id
 956f58d0204a3-63f922eff6emr2519034d50.39.1761918484805; Fri, 31 Oct 2025
 06:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org> <20251029081014.443psmqznd2pqm4i@lcpd911>
 <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com> <20251030164542.atnhs4wgk6ggmmly@lcpd911>
In-Reply-To: <20251030164542.atnhs4wgk6ggmmly@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 31 Oct 2025 14:47:29 +0100
X-Gm-Features: AWmQ_bkXYtLkHgQjUQNJqO9va0xDnvSagkeSDoJ8ysCheRg4L2MKvBY7iRS11PA
Message-ID: <CAPDyKFqTS6-69QfqdPtRrbkSqwxEnO1CPXLnRvM6WsOKNZgyQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> >
> > > It seems an overkill to me that a userspace program be required to hold
> > > open this file just to make sure the constraints are honoured for the
> > > lifetime of the device. We should definitely give the freedom to just be
> > > able to echo and also be able to cat and read back from the same place
> > > about the latency constraint being set.
> >
> > So you'd want a sysfs attribute here, but that has its own issues (the
> > last writer "wins", so if there are multiple users of it with
> > different needs in user space, things get tricky).
>
> sysfs makes sense, then would it make sense to have something like a
> /sys/devices/system/cpu/cpu0/power/cpu_wakeup_latency entry?
>
> IMHO userspace should decide accordingly to manage it's users and how/whom to allow to
> set the latency constraint.
> We already have CPU latency QoS entry for example which is sysfs too.
>
> >
> > > One other thing on my mind is - and probably unrelated to this specific
> > > series, but I think we must have some sysfs entry either appear in
> > > /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> > > state that the governor has chosen to enter based on the value set in
> > > cpu_wakeup_latency.
> >
> > Exit latency values for all states are exposed via sysfs.  Since
> > s2idle always uses the deepest state it can use, it is quite
> > straightforward to figure out which of them will be used going
> > forward, given a specific latency constraint.
>
> I disagree regarding the straightforward part. There could be
> multiple domain heirarchy in a system for eg. and all these multiple
> domains would have their own set of domain-idle-states. All of them having their own
> entry, exit, and residency latencies. I myself while testing this series
> have been thoroughly confused at times what idle-state did the kernel
> actually pick this time, and had to add prints just to figure that out.

If I understand correctly, most of that confusion is because of the
misunderstanding of including the residency in the state selection in
regards to QoS.

Residency should not be accounted for, but only enter+exit latencies.

>
> When implementing these things for the first
> time, especially when one has complex and many a domain idle-states it
> would indeed help alot if the kernel could just advertise somewhere what
> the governor is going to pick as the next s2idle state.

The problem with advertising upfront is that the state selection is
done dynamically. It simply can't work.

>
> Also, I am not quite sure if these latencies are exposed in the
> domain-idle-states scenario ...
> I tried checking in /sys/kernel/debug/pm_genpd/XXX/ but I only see
> these:
> active_time  current_state  devices  idle_states  sub_domains  total_idle_time
>
> Maybe an additional s2idle_state or something appearing here is what I
> was inclined toward.

That sounds like an idea that is worth exploring, if what you are
suggesting is to extend the idle state statistics. In principle we
want a new counter per idle state that indicates the number of times
we entered this state in s2idle, right?

While I was testing this feature, I used trace_printk - and afterward
it's easy to digest the trace buffer to see what happened.

Kind regards
Uffe

