Return-Path: <linux-kernel+bounces-847927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF8BCC113
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AA5C354E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D027B34A;
	Fri, 10 Oct 2025 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TV0C8y4T"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9D2765C1
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083466; cv=none; b=m90LdksRnVVBDCV3Wj+yEsXzjF1lQrQbQlWay2HzoXWbjqRehYpLwrZUrUZh+nLT/mZutuuz9Q8pFgjbJG1aLcORTA0KV+o1Nd7UhsatVlQ+fnLmtNZT2WrMHE0JFO5JVw2ZahJy2XJMXdSRbl2pOb8s1EPRLo72YavNsKDKeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083466; c=relaxed/simple;
	bh=NAJI2e2zpD5jqXvNvOUrcoN4gga7YRlnsMtMjMQymEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+461Peiq748iyaISJ59N8mYqFZPkZSjehK4uez028NcO7CV6gakjL7NMfoM3swCfUEN+5SZ9MZObC0AyrrPokzABgVBQiYUGMLdILs8GRUTPgLGZmKaijbE13KkfLNw+jbDvo0jkaefsPYtmDP+Hf1NjktFKJTposp9nQAPNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TV0C8y4T; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-73b4e3d0756so21033757b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760083464; x=1760688264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/Xo8ew0L5FECVPdkYszzTEPu1YGq0tz2Pf/3efb/XY=;
        b=TV0C8y4TDsil934A+1o90idpnqGw0uo/91xmwezcNhdzu/st70mOqsvZy7c7z3Q2f9
         1n4SJ/YkwoxiNqU5Y4k0qkckaJ94CemR4upZeDiRcwPP6PBzwGvurORlj3a2PmRe+TeP
         o/NrAmLUl/MjeKCspr59Eoa9GxkXadANe5b/TwY5f8NHYMxZM7WOVs7yn65uWQ4QLFDE
         rRkqiWyeZUgXZH4Xhsp8ggnuU3RgIhrVFqdRA6Qk2pBWnz69zoJQMjn+JZAVOAYY/Da4
         Y+SybTG9K4stgmVhiJRxsqvORgLfkJbZ3oVsr9h85Nfvy1j6WbOFvqSfV64HOjJ0DWPS
         ApyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083464; x=1760688264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/Xo8ew0L5FECVPdkYszzTEPu1YGq0tz2Pf/3efb/XY=;
        b=GqfHR3UtFZRUGp8t2CFjEKZcFAju5CP5phtskT0rBZkNmgX/DTFcOmU7kT81hkPRd9
         Yzg2zq/2hvP+Jr+Etojck2PydRiCfyICQyYeJCd10LwHKTnZp3GW0uod5yN2nS0t+9Jj
         l4o6G6/PrpaMb1Tl8xtTTYdV2ytWat2VsUXy0CV0B24qQQAK+skNx3Gucnv7UexoHgb1
         nydokHmDKvNOtuCOWhxLQC+7ek8fVc85SXfZb2cyxl3FGJu7j3NhRtjyDSMqq6jm0AyW
         tRnzFQ+za5I8iBAM/SnEGDMD1gzRS3hMVJQpF10XJK1CmNpofEtYmq4I4y6oNLi63+4K
         2peA==
X-Forwarded-Encrypted: i=1; AJvYcCVnEk1npWQZPLa79r1DPpC+DCVdw1D5UVufd+IZ4RKmJYDSuROEg70L4C08F+1mpZnilVIqnlB7OgJENRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBL3sYPG8LA4mmeSG5D6NhEM7gzOtqgBYqgWfUXlZQ3VfQ9p6Y
	/p97SZrwgAf9oLGHFsK9nWg1hYwd6l7aTULbDrGtvvWS3oSnxe+EPzdX6qmCs6PS7I/hXROkUch
	hDMcs6dDZWljhkKdGfl+eUd63x8quPRet7TKa3GPi3Q==
X-Gm-Gg: ASbGncsO8WmtWpO9SDvrNCOQmBqHr61n5m+e7i5CQV8m2VlTRc6Ibu7DfoWGniwaqT8
	Pl1quoQqGHoGM2GB3dbfoEsGglp83QwN3rBAjqn2DbPaRGO+RAlU6+T1IBoU4RXDluoQa8th4Gg
	0fdv1YhTI1R7BBtPJFyc6DmhBaQ3gZDnFRSc1BelZa7kawCYN4O8eFxXgc0tf+JvxMkUsvPgMqs
	aemLSqpCIjmpux5Ii15bXQ6W5Rqdgc=
X-Google-Smtp-Source: AGHT+IHK7SB5Cnn9QOkw+sbnesDp7lzRrH2FM7xkTeY2Yi0ZWo4oU7txEbfLgYeg0eGw6i4221NM2N1SzpTNshdDD5Y=
X-Received: by 2002:a53:d90e:0:b0:632:eed1:da93 with SMTP id
 956f58d0204a3-63ccb90ae22mr7823351d50.25.1760083463910; Fri, 10 Oct 2025
 01:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org> <20251006-manipulative-urban-antelope-31101f@sudeepholla>
 <CAPDyKFoz4P6cZWNA-omNtF3XqKKciC07aVXBTVQp8ueyyYxmxA@mail.gmail.com> <20251006-spiked-beige-gecko-6d8748@sudeepholla>
In-Reply-To: <20251006-spiked-beige-gecko-6d8748@sudeepholla>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Oct 2025 10:03:47 +0200
X-Gm-Features: AS18NWC0yHpFVuf7m0XvJ_onIcbcboSuQo-XWvaukKreqMILTAM4kGmbpyMFXbg
Message-ID: <CAPDyKFrGbeAzSTA+05ZLern-tBKq150Odo4Oi6tvLAWV6R9iYw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 16:41, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Oct 06, 2025 at 02:22:49PM +0200, Ulf Hansson wrote:
> > On Mon, 6 Oct 2025 at 12:54, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > 2. I understand this is intended for the DragonBoard 410c, where the =
firmware
> > >    can=E2=80=99t be updated. However, ideally, the PSCI firmware shou=
ld handle checking
> > >    for pending IPIs if that=E2=80=99s important for the platform. The=
 firmware could
> > >    perform this check at the CPU PPU/HW level and prevent entering th=
e
> > >    state if needed.
> >
> > I think this is exactly what is happening on Dragonboard 410c (see the
> > stats I shared in the commit message in patch3).
> >
> > The PSCI FW refuses to enter the suggested idlestate and the call fails=
.
> >
>
> Ah OK, the PSCI FW is doing the job correctly, we are just attempting to
> reduce the failures by catching few cases earlier in the OSPM itself ?

Correct!

> Sure it only reduces the failures but it can't eliminate those as IPI mig=
ht
> be issued after this check in the OSPM. I understand the call to firmware
> can be prevented.

Yes!

Although, it seems we are ending up doing a ping-pong game with the
FW. Note that, if the FW responds with an error because we have tried
to enter an idlestate for a group of CPUs, nothing prevents idling the
CPU again and hence we might re-try with the same idlestate (at least
until the pending IPI gets delivered).

My point is, this problem seems not negligible, as you can see from
the stats I have shared in the commit message of patch3.

Kind regards
Uffe

