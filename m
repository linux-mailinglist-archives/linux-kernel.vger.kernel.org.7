Return-Path: <linux-kernel+bounces-885159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C807C3226A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04B614F0016
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613B3375D1;
	Tue,  4 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6MUDZUw"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F466333426
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275159; cv=none; b=X+c95A4CH0l/CD4MQ7Dhd9966Pv00EDm9qZPf5i58mRswjd5trKtTZ+23YBxZI0oSEoJhhODVqBICzUOc0FXdZu8a5gZvg/vFvB+O+vYGrH1zqE4Cq0B2WE87iUweBBAEidzQxspVcyyKg791sxfaTEvQXW/3qMkqCxmDzppa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275159; c=relaxed/simple;
	bh=CYd8iBDxSOMUBlm8NjiD6Yadgmla1VlAK9u5AU7CO3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds+VxvHS0u9/v26S2CsRGqxWCulhreNkFfzetEqcV850y6qpLS6DWwMGGdDRwYbM0T4wfMrNkY+hI4Tyem4K8srj74OLUEW309EVeBi6qUuYtC5UJGN5Fq2Aq2goQdgiQ1OSy+JinoBG5BJrlhr5RzPFXRs2S5fPFvoYA2bpqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k6MUDZUw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7867497ad2fso402257b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762275157; x=1762879957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYosJRhaR8FvO5SmMiANWOWC/QX2IyOm4sQlU6bkTdw=;
        b=k6MUDZUw9OUiQmTr2+fETub6UOG7YASFZAal0t2+oyobmQ1CjdxLGCOd4byJ8YEBkZ
         RU6IFKjvdnTBixcnZ843C2guB1kIg9btyYU+8eTc6+vr6TFCiGtKWkdPNMWRy63VpaBJ
         WOjyJYzfHsJo1jetHlKyijep8jRROShzwHZ5sqolvc0tPP21AhoN20bjn0Gg+hVsNWid
         +7R+YbFxK6TF+n5mSW3VnVVmw6Oicy+DEeyFTUjmdTmz83uly2xF/iHR0edaorqdoubI
         OrAsCtPFjXZz8C0YgcnsveEhy60vADUQRy1ZUS9JGW6RAwHxRgmWId726iV2rN/P+u3Y
         eL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275157; x=1762879957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYosJRhaR8FvO5SmMiANWOWC/QX2IyOm4sQlU6bkTdw=;
        b=OF3mMERPmoaJvnsbqXkuOXMDjDh95/cC4zAEs7Xi32Ex+u1S9X2Coe0ccqiVNvhYTO
         aM4VCGBn9mN2vN+lwlLR/8UYJyTZbyRobh8+sGI5UQU/SYJG8fQXdpngElN9FibSNzo6
         au2NNJTw3DlR7zArcqiolJHfrLplWLFO49sAystbxy21D4e602PZO+sQIoOdc199mery
         hm8OkDu5KLehUjIBqY7yzX08eIyxQW7jCSfmWgx0lsGa9nRf9fhiZqNcD+cnCigt1oUP
         gfZQrCs5VoUnWWJeyFIjGdcVjFMTIunyNZ3XE/FCvwHAIRjuqLejf4YsYtGYjitejgOx
         77dA==
X-Forwarded-Encrypted: i=1; AJvYcCV1vhLyKC3Hcz8+kkKmBsOWM+bKSY+T8bXPmZamEPbDWqQ4I7oZ+lkpbGy4uMqxOEZQ/DUVBaZe1Tevi8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAhkH9TVj2kqz71IIbOVe2vrZjOfOH8bzSihLYuKDWbX1rjf2
	z5CuVPt4Z8i8fNHwWZLDqhE5oYbwn7pw6vN0yARcE80B4VvWiXuN11E4KVVws1qJ7iuGTUKXkmh
	CM7SABZxRTSdYDnT+CJfDd/QsPeEc44clLa9Fx56Zrg==
X-Gm-Gg: ASbGncv+5wOIBuNsZDhIWTEsG01GeLGnYSznKbMjwDncVmPOUE1sEmXQcImma6PvJgc
	7KGHT4pHhXYQvaJpEg2pKgVluJTsbGwNFSGUK9wJXOIajCxWYuStFq1S5OAMshdNKPEg36GlTSs
	D1TubiHTvf/acmfzE+oJkeTRaWgzMiiB1IUxRl2Ll3w0vGTsk8RPUuJ6G9eQG2NGpXZTl+3oQGL
	h86CvC3H8e5Vfc28O654hIElwDb7oZsZw2Lrcwpik8beM8REKr8qiEnmOfhFg==
X-Google-Smtp-Source: AGHT+IH4DWqHdq68Z95E7a3kcFwdmE1ttrKvzgDaKNQAybNdR+pb4ADyv+Nk0hIhnmBzELBiqefCjmyokNaq01E80go=
X-Received: by 2002:a05:690c:950f:b0:783:7768:55e6 with SMTP id
 00721157ae682-78695019263mr32047557b3.13.1762275157127; Tue, 04 Nov 2025
 08:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <7h1pmik3w9.fsf@baylibre.com>
 <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com> <CAJZ5v0gfd+nvvkthtjtKgw22kek02K68rOLYTy=a39D0uZYpMw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gfd+nvvkthtjtKgw22kek02K68rOLYTy=a39D0uZYpMw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:52:01 +0100
X-Gm-Features: AWmQ_bk1xE1CCmQc4sBp1rdNt2XT8Oy9Wrzyn6mucaP_tsqx6EQWhSuN5eLDsIA
Message-ID: <CAPDyKFrgJf05H8S8_p9+w3V3ND7NPpHSU=bpEBk75-goO+FUjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 at 17:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 4, 2025 at 5:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Sat, 1 Nov 2025 at 01:11, Kevin Hilman <khilman@baylibre.com> wrote:
> > >
> > > Ulf Hansson <ulf.hansson@linaro.org> writes:
> > >
> > > > A CPU system-wakeup QoS limit may have been requested by user-space=
. To
> > > > avoid breaking this constraint when entering a low-power state duri=
ng
> > > > s2idle through genpd, let's extend the corresponding genpd governor=
 for
> > > > CPUs. More precisely, during s2idle let the genpd governor select a
> > > > suitable low-power state, by taking into account the QoS limit.
> > >
> > > In addition to a QoS limit requested by userspace, shouldn't any
> > > per-device QoS limits from devices in the PM domain with CPUs/cluster=
s
> > > also be considered?
> > >
> > > Right now, if a device is in a PM domain that also contains CPUs, any
> > > per-device QoS constraints for those devices should also impact the
> > > state chosen by s2idle.
> >
> > I am not so sure about that. The existing dev PM QoS latency is
> > targeted towards runtime suspend of a device and the genpd governor
> > also takes it into account for this use case.
> >
> > If we would start to take the same dev PM QoS latency constraint into
> > account for system suspend (s2idle), it may not be what the user
> > really intended. Instead, I think we should consider extending the dev
> > PM QoS interface, to allow the user to set a specific latency limit
> > for system wakeup. Then the genpd governor should take that into
> > account for s2idle.
> >
> > >
> > > I just tried a quick hack of extending you cpu_system_power_down_ok()
> > > function to look for any per-device QoS constraints set all devices i=
n
> > > the PM domain (and subdomains).  It takes the min of all the per-devi=
ce
> > > QoS constratins, compares it to the one from userspace, and uses the =
min
> > > of those to decide the genpd state.
> > >
> > > That has the effect I'm after, but curious what you think about the
> > > usecase and the idea?
> >
> > It makes sense, but as stated above, I think we need a new QoS limit
> > specific for system suspend.
> >
> > Rafael, what's your thoughts around this?
>
> Well, it's analogous to the CPU latency limit case, so if a new
> "system suspend" QoS limit is introduced for CPUs, that also needs to
> be done for the other devices.

Agreed!

>
> However, as in the CPU case, my personal view is that the "system
> suspend" latency limits should be greater than or equal to the
> corresponding latency limits for runtime PM.

Right, we should treat general devices similar to CPUs.

>
> One more thing that has just occurred to me is that there are systems
> in which I don't want to enable the "system suspend" limits at all.
> IOW, all of this needs to be disabled unless the platform opts in.

Okay. So are you thinking of using a Kconfig for this or better to
manage this in runtime?

Kind regards
Uffe

