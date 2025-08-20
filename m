Return-Path: <linux-kernel+bounces-778566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E649B2E774
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33762AA3F19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F582DC32D;
	Wed, 20 Aug 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uk0jgYJK"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4642857CB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725132; cv=none; b=Nsmx11nl6dyE4gxMAEQ1FLFC4/VP9k8L2xzx2Om1T4ATkY2bule8AhK88yWOaPVItPf+NAvyBS2rRelWMx1Y1aEqOWTGqTEaVWF5fd/c+3eCtCa3LfoI9UPJzWpfVKQslvkbYkIGrbvmCXZuCB1yF4G5ZABy7yHpMSIulwWoObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725132; c=relaxed/simple;
	bh=u9r76BMJJfWhucAO3yzxygt5Qnq0pSN9t4fFZjYp7ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsD1WU08ais4/3gCI0/2clFQjED+JwmQ2owtBqZeSr28HICd++hPUurw00zdDRCvw0pqDAzUtLwCe0M4aLvwXK8xIVVMIikcHFQiCi9SpaooZucCRML2uFVfrCfeHZ2AsyU3nUhPDEwcaXpFvHMczHY9emrvQ5Yx6fBhvSuO2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uk0jgYJK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b29b715106so50801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755725130; x=1756329930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk0NYRSmXu17q95NpbKfrVaqqHlSVKZHOmuX2RoJU9Y=;
        b=Uk0jgYJKnHsz2GX1W3cyevJtN41I8GYGVYFu3rz71l2tZtI1befVUxnZ5jrRzJhBLD
         jLGaFzMguiM4kh0SKOmGRviVA/QSfyctQ5f1GYFNDErd2FDadlhGhfbT8rAgs93eL5tN
         EMTXk6ropfKFLpg4ITPaCM8VofzMOIe+01/CJRXOIwpnUNQColyKvxvmo+Lvh/f5MfuD
         5TShYOOCi1evP/i4Rr/ODFnG5LvWfj7xqSirWX1RRDdQ+R0qSZw/aAKYIrcWVfrAj3XJ
         rc71Gw6Bb3tisrOve8LXF69wuh+t6ZV9eOpgkZgiSflUsV2yJD0BkUXmWy+5qDdq/1nv
         fNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725130; x=1756329930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk0NYRSmXu17q95NpbKfrVaqqHlSVKZHOmuX2RoJU9Y=;
        b=L3dK7S+EslGDi04wxh4MfVRBKzcpZZ7b9DRsafeovSYNfU3J/y+ekRCCqV6lz9FTKI
         lewa+BkLL570DFnX1WLUqN4Vnjn9+lPdXU+iX7okQBe+EFYUjvCbsg++ef7lHkP5EuOI
         52K9E3s2aTlz64uwrh57A5eg/azZPv/6id+NM2I7+OZHrWmNlAdP8dItareaXrxAg9Se
         btxNokygz62olO2V0QRWRZsLNClHPrVwlALw9iFZ+Y2Lu9uPXk6Z3wWz7nobTHZUG+gn
         822wCZzAU2uYMKlA6IGgES8jlilZXvf8QUx/K8FuOyxKvH0HNfpYXpp7Y/YKvZDG30I8
         fGrA==
X-Forwarded-Encrypted: i=1; AJvYcCV4vk4AE//c53QOuX3yRIsnHEn40z+NKb2Vto+dpjiCtWKQTLFiDzjaU55UwvhH+t4EqITNnqA1b+3g0tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkORTTmJm+v+PawbErYtR4U7uJ3hSKzN3p8Y4ySSH73nD3JhGQ
	+VlcE/0JKg2kE4y4OnoGhx+4lF9t6ByLp44ju+WPjNx9Tky9IEHJejA4C7yDwGsGBo1+wBqbIL8
	EURkJYP7oGH0oJJ27mapw4wKQNRh3/NmFLQhnLyRgXi9CtovqjLUcOI+7sDo=
X-Gm-Gg: ASbGncsBDT1Au8c1I8fV16A/WLJHejMpV94ob+zsqgt53GI2WOBYhralkJ4kKrY2nY9
	lOksXlcMT8UyCVtMy6TBqJjKHr0Lwe5m2OYhVN2Df3yGiog5psbDpi7ITNG1ELb7Q3L5GZ6IbYY
	J450Q94vFsYD28Xw3IcGVznIC0Su7yxL/7bZP4aQmXP5UD7Kcrz1Hf/yy0XzfmAlFmb/lSXK6Uz
	douliD0MXsL+U/WpP8v2PlltzzD9LUChBHcbvpVFbPEM/l1QGTdpvCcuP7eQU1uiA==
X-Google-Smtp-Source: AGHT+IGKIblzHMX2hS+MM0jRZzmxZjurMe1R0nV4nFroEV8rUsyXIYFYQPk6YKjxK+HPVDNIWB1Ov/8VP0gjADKih/Y=
X-Received: by 2002:a05:622a:1ba2:b0:4b2:9b79:e700 with SMTP id
 d75a77b69052e-4b29f66a2edmr447701cf.4.1755725129559; Wed, 20 Aug 2025
 14:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730220812.53098-1-pmalani@google.com> <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com> <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
 <aKY0xuegI1S4X2uW@arm.com>
In-Reply-To: <aKY0xuegI1S4X2uW@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 20 Aug 2025 14:25:16 -0700
X-Gm-Features: Ac12FXxpb1aY5VQXHdTOWKo_KQqlEzB9IoelhOZpa1BTea5OXo6aKXyHGg5RsUE
Message-ID: <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Beata Michalska <beata.michalska@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Beata,

On Wed, 20 Aug 2025 at 13:49, Beata Michalska <beata.michalska@arm.com> wro=
te:
>
> Kinda working on that one.

OK. I'm eager to see what the solution is!

> >
> > Outside of that, I can't think of another mitigation beyond adding dela=
y to make
> > the time deltas not matter so much.
> I'm not entirely sure what 'so much' means in this context.
> How one would quantify whether the added delay is actually mitigating the=
 issue?
>

I alluded to it in the commit description, but here is the my basic
numerical analysis:
The effective timestamps for the 4 readings right now are:
Timestamp t0: del0
Timestamp t0 + m: ref0
(Time delay X us)
Timestamp t1: del1
Timestamp t1 + n: ref1

Timestamp t1 =3D t0 + m + X

The perf calculation is:
Per =3D del1 - del0 / ref1 - ref0
      =3D Del_counter_diff_over_time(t1 - t0) /
ref_counter_diff_over_time(t1 + n - (t0 + m))
      =3D Del_counter_diff_over time(t0 + m + X - t0) /
ref_counter_diff_over_time((t0 + m + X + n - t0 - m)
      =3D Del_counter_diff_over_time(m + X) / ref_counter_diff_over_time(n =
+ X)

If X >> (m,n) this becomes:
      =3D Del_counter_diff_over_time(X) / ref_counter_diff_over_time(X)
which is what the actual calculation is supposed to be.

if X ~ (m, N) (which is what the case is right now), the calculation
becomes erratic.

> >
> > Perhaps ARM should introduce a "snapshot" feature which takes the snaps=
hot
> > of the AMU counters on a register write; IAC that's outside the scope
> What do you mean by register write ?

I mean that we should have a snapshot register:
SYS_AMEVCNTR0_SNAPSHOT_EL0

writing to this will save the current values of SYS_AMEVCNTR0_CORE_EL0 and
SYS_AMEVCNTR0_CONST_EL0 into two shadow registers (say
SYS_AMEVCNTR0_CORE_SNAPSHOT_EL0
and SYS_AMEVCNTR0_CONST_SNAPSHOT_EL0)

That way the OS specifics in how the registers are read don't matter.

Of course, I'm not a H/W architect so this proposal is very rough, but hope=
fully
helps illustrate my idea.

> > of this discussion.
> >
> > Could you kindly explain why adding the udelay here is discouraged?
>
> Would you mind clarifying how the specific value of 200 =C2=B5s was deter=
mined?
> Was it carefully derived from measurements across multiple platforms and
> workloads, or simply observed to =E2=80=9Cwork=E2=80=9D on one relatively=
 stable setup?
>
> Understanding the basis for choosing that delay will help put the discuss=
ion
> into the right context.

TBH, I just experimented with values on our system and observed the reading=
s of
cores running stress-ng. I tried 100us and that still gave variability
(values greater than
the theoretical max frequency). It's possible that the "optimal value"
is somewhere
between these two.

There have been other observations on this topic [1], that suggest
that even 100us
improves the error rate significantly from what it is with 2us.

BR,

-Prashant

[1] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputi=
ng.com/

