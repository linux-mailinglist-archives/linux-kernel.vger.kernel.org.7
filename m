Return-Path: <linux-kernel+bounces-847905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDDBCBFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3965E4F522A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C5240611;
	Fri, 10 Oct 2025 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRbGvTbW"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0901DFE26
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082794; cv=none; b=to0mKrqqYvPIeH1Dre9lsBSiDQXJBxHLm33zOmk2ysO62IOqsBJ/X6QaLdd2MUi5ForwACum2mJu53AX0jbUIyFjE+JRB+Yeht6GbnnZDfaVmlqcCeTNAG2UcblFi9fm5e7UoCRevWfpG/khezX/mBjLSmaJLHoigKw1yusLSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082794; c=relaxed/simple;
	bh=DHqSm5NgIZTWpIeyFda2uZBgSRaGewPdAR8APEw7rw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5h7tokYvY+4AmlxGrP0UeA/fG98nuGWZvNlEse4k+LzY06xPFxnYOuCM8Z2I0d6rTcQEcCcluKiQGgNPWOi0hjdiVw99GzSRuyIyeppHPhR64e62j6gOYzz7rK+dl/JMxxE3jV3H9wrrzVcS3e1XMYD4cLtOuSq0psw3Nb6/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aRbGvTbW; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63cf0df1abbso46629d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760082791; x=1760687591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHqSm5NgIZTWpIeyFda2uZBgSRaGewPdAR8APEw7rw4=;
        b=aRbGvTbWWLAMowNzQK33UcmqpJ0C6uDinKM8TrTByNhUVnX4oT7RspCS97uboADmUv
         +iD0UuM1o2ZAMC02QdZq9+44d32SkGOEiupcnkUg46QEszZLQUiBOsefF6qZ6DUirTtT
         cVuytJSjzMvqbaI3yHySQs7KsETGzZSiAdOBcoAICKV9HHHev5jnfGeYJi1I+iBYOSpw
         jYkFRiURMY6sj7ibo5pYFDKglV0SJGrfpCwnZ5S6jO493tvuqb9VCQyLXAJES79YcSoa
         nd2ygwPHv0uI/4FzegbO8c33vf7gBMvKiau+WUmJNXG08Q7/u5npFNADQgfkerJFx2FX
         4lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082791; x=1760687591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHqSm5NgIZTWpIeyFda2uZBgSRaGewPdAR8APEw7rw4=;
        b=mS35bthRpTRCu2vaULIO57Qhnxjp5fepyFyM7C5b1Qq9svMSkkp0QqA+FkgTruh6bn
         rengnKUoAlCfSrmqrFx2fNfM5EB7PJxROSBwboZdmWVVfG2LN+NLRC8sRF3b0WwzDJCT
         Rgfy8zEMjS4XRqEYLE24U93/uhRaDOMeV1v0gFXmi929mVFYaXQdMZyITj5Lo645nRoV
         M9rytATXEsjCb2WFNd/XjkZLmtEIONvESMASiZal8PnXFlP+GVnUwB/DPDP6cRR6Qjn7
         44JSSWqoSzvYexE704LYztnTSH5X8lLt9VrZJkN6Xi3PGylufrYRseHbAfBYzishQkcd
         KzIA==
X-Forwarded-Encrypted: i=1; AJvYcCVq0/N28eRrQuq+Lblr5fFJ1ySNgGvEmdVJrkM3f4ISkeWClzEW8ylG45iR09bSzBlLMJLY7alj6/cuNbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMR1ocQHHeBjU0U2yb7gbqn0OwrUf7Ba/IOXgdxNUD8mUf51M
	4SUcblHmIuKfGlTOcqIr74jN+QYju/tdh1nimU5DEIOjokhKSZIEIg7VaKgLia/M3JifOFBLeTS
	QBVCl70/AE8nV8RTxp54vt2o63x54c3U+h1guZBxsyw==
X-Gm-Gg: ASbGncuOnxlB8nivBLdxZM6g7KdAF0GTujKANK+eVQ68kABsnWTr+qa8Qtdp2HWbmBw
	4FUdg6vXdh+xPigQKGT1l0jBe5MtYkdsYtZ3EfY0hxKJfjVkZH/vpaMDtF85XLHDpfeEERcNrAG
	xghp9+iAOXDDqwHQttHBbbQMwIdfYhPcjyF2WmCGhkA3nTIc1cRUOFrLL9F7nrSMduonWX9Lvcv
	G+y1wSsbaiokkAWmm9tNjU+GRIj/Q+3Nup9EBH/bw==
X-Google-Smtp-Source: AGHT+IEnyq80ACUu37tcZXlzziIoOjXYva5YJrTeAlxVjWlNNTGe7b3l2TEzAxaUZRDoT0ueLBKhVdK8QVQuA2xTx2E=
X-Received: by 2002:a53:b806:0:b0:635:4ecd:7599 with SMTP id
 956f58d0204a3-63ccb8dba03mr7918670d50.39.1760082791492; Fri, 10 Oct 2025
 00:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org> <20251006-barnacle-of-pragmatic-faith-e6ca0d@sudeepholla>
In-Reply-To: <20251006-barnacle-of-pragmatic-faith-e6ca0d@sudeepholla>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Oct 2025 09:52:35 +0200
X-Gm-Features: AS18NWDvepcO2JLruDjD5wrLTae5DuV85tbk2iUenQa_mEnTJqXVNaVAhQe1lcQ
Message-ID: <CAPDyKFq64RD6UAjfLyKSBG3EU=T0DFk7v6jzBCBTGGg_U784Jw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: Improve idlestate selection for CPUs
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 17:36, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 03, 2025 at 05:02:42PM +0200, Ulf Hansson wrote:
> > Platforms using the genpd governor for CPUs are relying on it to find t=
he most
> > optimal idlestate for a group of CPUs. Although, observations tells us =
that
> > there are some significant improvement that can be made around this.
> >
> > These improvement are based upon allowing us to take pending IPIs into =
account
> > for the group of CPUs that the genpd governor is in control of. If ther=
e is
> > pending IPI for any of these CPUs, we should not request an idlestate t=
hat
> > affects the group, but rather pick a shallower state that affects only =
the CPU.
> >
>
> Thinking about this further, I=E2=80=99m not sure this issue is really sp=
ecific to
> pmdomain. In my view, the proposed solution could apply equally well to
> platforms that don=E2=80=99t use pmdomain for cpuidle. Also, I don=E2=80=
=99t see why the
> solution needs to be architecture-specific.
>
> Thoughts ?

From PSCI PC-mode point of view (I assume that's your main target with
this above comment?), it would *not* make sense to bail out for
idle-states that could affect other CPUs too - because the CPU only
votes itself.

However, if there would be an IPI pending for the current CPU that is
about to enter idle, we should bail out. Although, as stated in the
other thread, we already have the need_resched() thing that helps out
with that, I think.

That said, I think this change is mostly interesting from pmdomain
point of view.

Let me comment on the architecture-specific part in the other thread,
as it seems like Marc also had some comments around that.

>
> I understand it won=E2=80=99t handle all IPI cases, but generic helpers l=
ike
> local_softirq_pending() and irq_work_needs_cpu()
> should already cover some of them in a platform-independent way.

Thanks for your suggestion, but unfortunately these don't really help
as they only have information about the current CPU.

Kind regards
Uffe

