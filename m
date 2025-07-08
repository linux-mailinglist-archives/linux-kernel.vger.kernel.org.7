Return-Path: <linux-kernel+bounces-721942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7605AFCFBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E4E16AF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C802E1C6B;
	Tue,  8 Jul 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbe5h42h"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02B2DCF7B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989920; cv=none; b=ANIYelbpZfxBtueyIN+v+qBeBDcast4f93m4DCWrQtiv+smU16IYAaIsqfbxsRQaAd8ALU6fHrR++28/U4XrKPG2V7fXIF4inUPIB68a5mXimnhWcZNn9oTd6xI6GMRK5+40vtR2SpQ76RI5ZxRXQVnbAJ7JYtXzkEkhWv1RFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989920; c=relaxed/simple;
	bh=voeyQ0MDCj/Z+MBpJSQMfnqdjg3SDuJuOUlR1jBdKNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmAR8L0qxeIs/f1an5pIOYaR8RmmlME13vHC0WD1nDYPDiW9BohcCatheJZPKovEQsqj6X7z2ytXny0Wq9om7rejQrioRT1GGiij7IbDnmpZgB+fC5FmCJP6ZlNqVb8IIuLetUc/VtTRR65lpJUIq+A8JdRyjwNCSuMDdUtcw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbe5h42h; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ef8df09ce9so2791910fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751989918; x=1752594718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRbXwJ4vnB/zDj0rM1xWnMPZ+mVdznTRW5M3IQISchU=;
        b=tbe5h42hreuvgJ0PBzHdhelwDCFouy/8kUlmW5IhWDoD6FBRomYu4y2Zm/5A1N9Duu
         QJTy1ahshvNWm6ad1+TFsgbt/eEsdm2BJi4EVnnGSv20WZJEik12VmP67CW8kmtejPt8
         EqYLd9MwbQko4370izUtUU7TyAwVgFn1tXrK+aLJ7u1rMGT36O5ENYernScdDhf4ixA5
         HaKFqHOMMyj51yBbe+JMEANt5O+JBSsogi34Re8/ZOzXi3XPwSf0WHb+nFRbR6iAnN+O
         iqD51VEwAD9ENALlfH5zB+4OzCOKGaA/sV4tWSKvMNoCs2W72gV8350LwgB6/L9PMq6/
         DoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989918; x=1752594718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRbXwJ4vnB/zDj0rM1xWnMPZ+mVdznTRW5M3IQISchU=;
        b=qLPEmY9lq6fs+N64s94yvDjPyhUn8kTptmrx2EzO5/CtgMdeASQWXN6j6rNuGmZWYT
         4v/gG5j8vwmQgrj/g30U1TfapNXRDyBwKIu6s6BmWQEAvW+2XZeoHZGFR2uNZr3NjoFi
         kEk0ymQfMckwDUJlFKT5trib+PPGQ3/CWaG3BX5RGiBpEIZHBA6Wm004XDmVcMQKqw0A
         FegySt49EsTkVHdyDd8wSVhK1yF76pQOp7HUeohhafSaK707dMe4+hOJPUAntWKUiZKA
         b00d1d9KG0m5X1Lds7dy6FT5Y4dCIb8J2H/239wEhyR8EtTMEEfvo9KlXVNLyKwxN+H8
         FjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGHhMDSmG5BagbcOOUVTg64OZRXVWG/Zy5QK7JoN/SMUn6UGIuVhdjfePu1MuvYPmYDK+puENSRuoNRCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYHkYfaW2z5D/VUO3TldRMQM8i3hRT9flCZLCOS1UWdsdUe1D
	9ByIDz4CYUCNL7CTVNBIPhDLBlwcll8MLKwzj6iE3lkn4b/RhwTCo3Av+W3vbeqXTiDH/uXST+l
	QTL890SUkBQp2idnXTJZetZ1/p8w2LLWxzn9Vbeu3N1Y00EL9zvx2
X-Gm-Gg: ASbGncseYy4u9JvZGnBYSGqjCgwMlPeaJBbJXlftQgTIc7WSmEuM1wgkArado9eftwX
	ILqcaFCR3uRQ3NlmAZYw7ZJ9VyJrSFHBgCXZUvc/ryU0mREF2E9FiuvDGV8GT+yuxI2pmEAqwVX
	9y3ZpK9AV/XHks+6aqbuNvjtj5/hpz1Xn0X2LlP5D+hgaM
X-Google-Smtp-Source: AGHT+IGayKsL09US/aG4BWXfDqvwdj7IbiR5yylTrdq3b4SPkY53vMlQ75BaToWu3g2R7Y7GTXTocA55aVVbeeWQnIw=
X-Received: by 2002:a05:6870:85cd:b0:2ea:7101:7dc1 with SMTP id
 586e51a60fabf-2f796d387ddmr13310705fac.33.1751989916214; Tue, 08 Jul 2025
 08:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-gs101-cpuidle-v3-1-0200452dfe60@linaro.org>
 <91a9d4dbe5504c493856ef81b30d98e7da925ac0.camel@linaro.org> <232267bf-d226-43df-bd4f-5977706176a2@kernel.org>
In-Reply-To: <232267bf-d226-43df-bd4f-5977706176a2@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 8 Jul 2025 16:51:43 +0100
X-Gm-Features: Ac12FXyQtnEeVlAK_PBT_PKHrE4fR7brNoVWCLA4QssHna082hO6RsgDRrOaQo8
Message-ID: <CADrjBPp5ndaEs=s-bZOyYnH21r=b2BoROC7+zV=dH_O2Pwxvmw@mail.gmail.com>
Subject: Re: [PATCH v3] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	William Mcvicker <willmcvicker@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, 3 Jul 2025 at 11:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 03/07/2025 12:12, Andr=C3=A9 Draszik wrote:
> > Thanks Pete for your patch!
> >
> > On Fri, 2025-06-27 at 14:08 +0100, Peter Griffin wrote:
> >> Register cpu pm notifiers for gs101 which call the
> >> gs101_cpu_pmu_online/offline callbacks which in turn program the ACPM
> >> hint. This is required to actually enter the C2 idle state.
> >>
> >> A couple of corner cases are handled, namely when the system is reboot=
ing
> >> or suspending we ignore the request. Additionally the request is ignor=
ed if
> >> the CPU is in CPU hot plug. Some common code is refactored so that it =
can
> >> be called from both the CPU hot plug callback and CPU PM notifier taki=
ng
> >> into account that CPU PM notifiers are called with IRQs disabled where=
as
> >> CPU hotplug callbacks aren't.
> >>
> >> Note: this patch has a runtime dependency on adding 'local-timer-stop'=
 dt
> >> property to the CPU nodes. This informs the time framework to switch t=
o a
> >> broadcast timer as the local timer will be shutdown. Without that DT
> >> property specified the system hangs in early boot with this patch appl=
ied.
> >>
> >> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >
> > With this applied, I see the following during boot:
> >
> > [    1.841304][    T0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    1.841422][    T0] [ BUG: Invalid wait context ]
> > [    1.841550][    T0] 6.16.0-rc4-next-20250702+ #54 Tainted: G     U  =
        T
> > [    1.841727][    T0] -----------------------------
> > [    1.841844][    T0] swapper/0/0 is trying to lock:
> > [    1.841965][    T0] ffff000800ee84b8 (&pmu_context->cpupm_lock){....=
}-{3:3}
> > [    1.842001][    T0] , at: gs101_cpu_pm_notify_callback+0x48/0x100
> > [    1.842309][    T0] other info that might help us debug this:
> > [    1.842613][    T0] context-{5:5}
> > [    1.842987][    T0] 1 lock held by swapper/0/0:
> > [    1.843442][    T0]  #0:
> > [    1.843859][    T0] ffffafe9d8f1f100
> > [    1.844282][    T0]  (
> > [    1.844618][    T0] cpu_pm_notifier.lock
> > [    1.844980][    T0] ){....}-{2:2}, at: cpu_pm_enter+0x30/0x88
> > [    1.845340][    T0] stack backtrace:
> > [    1.845855][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G =
    U          T   6.16.0-rc4-next-20250702+ #54 PREEMPT
> > [    1.845878][    T0] Tainted: [U]=3DUSER, [T]=3DRANDSTRUCT
> > [    1.845884][    T0] Hardware name: Oriole (DT)
> > [    1.845897][    T0] Call trace:
> > [    1.845909][    T0]  show_stack+0x24/0x38 (C)
> > [    1.845934][    T0]  dump_stack_lvl+0x40/0xc0
> > [    1.845949][    T0]  dump_stack+0x18/0x24
> > [    1.845956][    T0]  __lock_acquire+0xc68/0xd90
> > [    1.845976][    T0]  lock_acquire+0x14c/0x2b8
> > [    1.845985][    T0]  _raw_spin_lock+0x54/0x78
> > [    1.846011][    T0]  gs101_cpu_pm_notify_callback+0x48/0x100
> > [    1.846021][    T0]  notifier_call_chain+0xb0/0x198
> > [    1.846046][    T0]  raw_notifier_call_chain_robust+0x50/0xb0
> > [    1.846053][    T0]  cpu_pm_enter+0x4c/0x88
> > [    1.846063][    T0]  psci_enter_idle_state+0x2c/0x70
> > [    1.846078][    T0]  cpuidle_enter_state+0x14c/0x4c0
> > [    1.846097][    T0]  cpuidle_enter+0x44/0x68
> > [    1.846121][    T0]  do_idle+0x1f0/0x2a8
> > [    1.846142][    T0]  cpu_startup_entry+0x40/0x50
> > [    1.846152][    T0]  rest_init+0x1c4/0x1d0
> > [    1.846161][    T0]  start_kernel+0x358/0x438
> > [    1.846181][    T0]  __primary_switched+0x88/0x98
>
> Thanks for the report. Probably such code should be always tested with
> lock debugging options enabled, e.g.:
> https://github.com/krzk/tools/blob/master/linux/build.sh#L845

Thanks for the tip, I will do it for future versions.

Peter

