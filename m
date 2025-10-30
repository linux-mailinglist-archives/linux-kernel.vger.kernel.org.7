Return-Path: <linux-kernel+bounces-878513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A7C20DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B97DB4EC42E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBDB329C60;
	Thu, 30 Oct 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MC3krj1k"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13031329C57
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837208; cv=none; b=kg5Aajp+vZNOPKEo0ZQ1NiGouEUXPY+H0fu4yBEh0M888gKykO46mkBsbVP0sE5aEP1iwx1HLlvawS7PGBG/zTRBIKhpRMRxBXj68ayGAjVWgjoqgnr7IqPl5cqxbBq60DOIMeTxPYypR6JT6gXdvWfEZYXzeaBySQG5CJw9/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837208; c=relaxed/simple;
	bh=4LZvzW9Kh+P42auNNJ0YzK0VaO1s27OYFzOhbaTw/iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUPm/SyMtqeTlSrb1OCT2vi4SjwuZaktO8+O+R9KVgwSvOd1xKRlppDLOXKdjLApbNLljn9gUo0syWIAjCX4X9eLGOlsIPmZ+tp4OQgq9MWsT5KgPmp6uRzSBra0oJCmurMLKPLAm6Va+Y5mTlWwN2OTsfVpi3mMQihc8XfFguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MC3krj1k; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78356c816fdso16445327b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761837206; x=1762442006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4COQfU/3sWCyd46/b/oPZJ7AhRt72nzQkq06aF3DpQ4=;
        b=MC3krj1ksF7SfBaU9zscMdxwAvVG5rZU4U2Ps9E4tsOJ98shLETDmsZosy/UNviwXO
         mztR6OGnJgIjp4uQT2TxrNggcy1OAQE0unntSBAGmgnGZjVczoUG2ddqO561HDaGEut0
         RwSVIVay5yG8pQwbiLc9clOM03JNQjrhJyQK4AAsD1bDHwlhVSCDkSCTicvMZ1vPrhel
         4vasECfUZBAt5IVGtwJ/Rrn3QIUl9sK3jeWI+MuT5LPN50Gy6Qkezkzz9YfSkPxRcEMw
         whp44erlKUl2cc3R96GjKxozOplgh4EjAPDs3REX4rcgLumC9f6C+vvRGmeGEoTaqdqL
         qJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837206; x=1762442006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4COQfU/3sWCyd46/b/oPZJ7AhRt72nzQkq06aF3DpQ4=;
        b=FwHlQKAEQbWkE9rbfhHDA5l6loNCtQTL6NM1tAPS+M6FQxNFr7robO8CnhsZ5qhyzF
         9eqJBzh4eDf78I8OOD2EOYt8LkBRlCJl52ssR9Oz2ugJRMWp4jerRNlS8eymkwALxvFo
         KdImx2HHP2Zc0cMkmhNZirIhULtzbMwEGBOPhcvRrP6gqIy8QR6tXJyGJ0icrwvVr5th
         ZC4b2mj2jgKCZkxySY8G5Qhv2b6f0vSnY7m8MyOQbskIwT+gbHX7j2wGFsvEnTKQhijK
         O+PtFTY2dczsoT+2tGk5vXYjN+1dQ7P4uV7hkGWYIfB6z442NOxn3SGXbGbvOMA1b0hx
         ZuPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJBKlk31Wv30AIbKlIuIR5vhMP2L7VUHGzw0xhfSVFQVVqV4s7dDK5uLzZY5YUv7F/PLf5NOD/rkv6VAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkVUd73fpSVA7kwX6Hn/mEPd7HhHpQIzmIr8GzNy8oLDvVVQ8
	ti40CDZbW7yXN2BHtPlwdx06RsTAsxONaOFBHmInlsO7uETNckkX1sxxgcFdtmF3BjNpdD/4AeZ
	9YRa4ZSTTeildCLoTT//jDVStD/0h1yJs4Cg4byRJ5Q==
X-Gm-Gg: ASbGncv+Nw3osmud4o9sZDDvFDhRSFHaiH/jIprRsiyJBi1XrqW6eFZnbXxO8v1Y3PQ
	dAqBkYIH7d9kYj9dX2KYYxxD6wWx00BWeJnE+qN/JImjajXsvHDxdzsYaGRAlvcXNdApRxP7idp
	+fF9q7IFI9cWibvUHPLY33peWlzrECFkGujX93ewQdTG4+XqtRJPMw6QnHOHG+FTqcdY3xWEHYB
	2SB9xnUGo/DeI14wilr/hnYf1G+Cn69zJUmSH/xTWMtaQSVavv96hDReW51R0zxHQlYm2If
X-Google-Smtp-Source: AGHT+IEgl+53+xVIpNx265m6xqVaVzDLYtfsMuYpDq/HyQpNXpcYzvl86YayDl9WX2cRTzUBgfmVHWp/0OwN+1Uhe6s=
X-Received: by 2002:a05:690c:504a:b0:780:f9f7:1c4b with SMTP id
 00721157ae682-786390d3f7bmr29250837b3.33.1761837205781; Thu, 30 Oct 2025
 08:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
 <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
 <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
 <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
 <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com> <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 16:12:49 +0100
X-Gm-Features: AWmQ_blf0zyNKfrORMoqLZv73Dd3HNaOv_nSPiu2DZwurZLSwec8TwHbzKR5H2g
Message-ID: <CAPDyKFpBHZ758khTGhidcyYCwy7dDtkabJ4trg4K16BhWEpUYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 15:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 1:44=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 30 Oct 2025 at 13:29, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansso=
n@linaro.org> wrote:
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > >         - Limit the new QoS to CPUs  and make some correspond=
ing renaming of the
> > > > > > >         functions along with name of the device node for user=
 space.
> > > > > > >         - Make sure we deal with the failure/error path corre=
ctly when there are
> > > > > > >         no state available for s2idle.
> > > > > > >         - Add documentation.
> > > > > > >
> > > > > > > Some platforms supports multiple low-power states for CPUs th=
at can be used
> > > > > > > when entering system-wide suspend and s2idle in particular. C=
urrently we are
> > > > > > > always selecting the deepest possible state for the CPUs, whi=
ch can break the
> > > > > > > system-wakeup latency constraint that may be required for som=
e use-cases.
> > > > > > >
> > > > > > > Therefore, this series suggests to introduce a new interface =
for user-space,
> > > > > > > allowing us to specify the CPU system-wakeup QoS limit. The Q=
oS limit is then
> > > > > > > taken into account when selecting a suitable low-power state =
for s2idle.
> > > > > >
> > > > > > Last time we discussed this I said I would like the new limit t=
o be
> > > > > > taken into account by regular "runtime" cpuidle because the "s2=
idle"
> > > > > > limit should not be less that the "runtime" limit (or at least =
it
> > > > > > would be illogical if that happened).
> > > > >
> > > > > Yes, we discussed this, but that was also before we concluded to =
add a
> > > > > new file for user-space to operate on after all.
> > > > >
> > > > > To me, it looks unnecessarily limiting to not allow them to be
> > > > > orthogonal,
> > > >
> > > > So what's the use case in which it makes sense to have a lower late=
ncy
> > > > limit for s2idle than for runtime?
> >
> > Honestly, I don't know, but I just wanted to keep things more flexible.
> >
> > > >
> > > > > but I am not insisting that it needs to be like this. I
> > > > > was just thinking that we do not necessarily have to care about t=
he
> > > > > same use-case in runtime as in the system-suspend state. Moreover=
,
> > > > > nothing would prevent user-space from applying the same constrain=
t to
> > > > > both of them, if that is needed.
> > > > >
> > > > > >
> > > > > > It looks like that could be implemented by making
> > > > > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limi=
t()
> > > > > > into account, couldn't it?
> > > > >
> > > > > Right, but I am not sure we want that. See above.
> > > >
> > > > I do or I need to be convinced that this is a bad idea.
> > >
> > > And there is a specific reason why I want that.
> > >
> > > Namely, say somebody wants to set the same limit for both s2idle and
> > > "runtime" cpuidle.  If the s2idle limit did not affect "runtime", the=
y
> > > would need to open two device special files and write the same value
> > > to both of them.  Otherwise, they just need to use the s2idle limit
> > > and it will work for "runtime" automatically.
> >
> > Right. User-space would need to open two files instead of one, but is
> > that really a problem?
>
> It is potentially confusing and error-prone.
>
> > What if user-space doesn't want to affect the runtime state-selection,
> > but cares only about a use-case that requires a cpu-wakeup constraint
> > when resuming from s2idle.
>
> Well, I'm not sure if this use case exists at all, which is key here.
> If it doesn't exist, why make provisions for it?

Well, because it's not possible to change afterwards as it becomes ABI.

It would be silly having to add yet another file for userspace, down
the road, if it turns out to be needed.

Kind regards
Uffe

