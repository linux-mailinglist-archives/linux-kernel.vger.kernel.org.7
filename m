Return-Path: <linux-kernel+bounces-897532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E347C5350C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585875040AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F295285C84;
	Wed, 12 Nov 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I1Vrt1SM"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B084208994
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960524; cv=none; b=KxfgN3Cp2B+g/J4t6xR1H38ZVv0kdYlrJ1cqlXYXBAAL8zIH4Oj/kGlXK7WeeOZyyHRu9XAqyNxEwnM/pANQcnAFUaVGELQJmBkv3cx3jV+I0gNIGc0Binuo+N0ig7xX3q5HV8xaClhMHhonwEig9SUbq7BhL1AyDSzDAIBxyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960524; c=relaxed/simple;
	bh=28dFYNuVIQJheFGurh7BY6VRu4ay3hJfZehab/xmtV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXyrtoNPJ7PNKKJRkn49TggHGOgpY7q7nxu0rXHEqhITvORUntcKCjgA3MQuq34soQoDR7eo+vAUqafyvtyK1/tJaF2hwZ93JfbXkr4Apx9qQtvnJkdtsSM03eQyV1a9d9a163v/ZFAKbDSK4FwoyWnPKsiwR14d+8FwkgMH30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I1Vrt1SM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37b935df7bfso6640891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762960520; x=1763565320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri/ZVcRon5527BZYDSq9t8W61fbqFxJd5kz+yYZCkTc=;
        b=I1Vrt1SMX41pRqnEZxyAmfrVaPSZdmZ2SBZq3BuUQfXwChK6kayvV9WPGRqqfoGNin
         xib0PAOR+LkTh3BllSJ+let6OIWtn0wWpw8OpzLifzeI9getB4wePKugGwrSZENvLkDA
         +52BxLq/AKoXuJGOeLXSEb1Q/J4As1JcOZyZunJr1gIwUMXt0zzSnGpKHfAfsJO2Y8wt
         kViSv8HTD1zJUtyI26KU0dKmcFBsQ0qZskwA//E/rC1EYawELkeyDj8PA8gUfJqj2kl9
         i3jRbwqF3pvQLr9V+y7wIsTXCgbbnqV/cxSuIhWszprGpzIsfHPdScsY6QQONdYTtdq+
         6Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960520; x=1763565320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ri/ZVcRon5527BZYDSq9t8W61fbqFxJd5kz+yYZCkTc=;
        b=quuMaFMfN5Fr6tNBnSyQnvbKZDCYSy+B8cgYFIKbYLnDi09hsAt+Dz+h5AhQOv9u4S
         vhMMV4GUiHJ7qWoDq9NFGMeCHo+/XzgxcA65gPmMPrJaACe2Uxm2yzjsDJWeijQP/nLz
         NHJIFP4EpNr6gYvMlIyeUCjIe6+DWQT0+Re2W7WTpwSUyFoNWw9puzxrwprsrsCC/BlU
         48fvOitCunwIgD+qKX121nOU3ETCqaYEkiYLeR78ETJGEVZcmYnPLQDJuXv4kjfmgIu3
         w76AFRsQEIJWZzhzUiQcfwxEWuVvVzVBJgUgC6OVi2j6tHZJys/svTrUbS0NZHDkS8eF
         WnRw==
X-Gm-Message-State: AOJu0YygiU0UOHKzNHxCD1mwF4g7AHV3zi7AqVt0MfEYiRlbNWIqGwjh
	YliMmf/jRElSQUeGjn+2MSs8ubkwazqObeWPZv/tXVYN3bRTFGll6DiYMJBS/3rd8fx+webb0uw
	CM7EUYJN6JBAzIudBTYYq6FNyfiK5f+YTLvlBBMIGRA==
X-Gm-Gg: ASbGncstT/3+TYcF5dgEpwFbjKNmOIl3muZ2j3ArjE54wRdhN7zwviPQXvxzQfvVJmW
	R5F2BZ9C1WjA2hFb6XhaBiSRbYszAXv2JZou8hWn30047WT0PsBQoDr2kk8NUULaKOUXFf17rEf
	L1U6T7u7M4WCngd6WglHIc/OarBMIJfYb9FUlHhZmogWmrbwxtm9Wdt0FcjYgmSUHDUdTRvcO/W
	AMsv98wyVLP3hoyoVN3iS9chFC2tt5K+6IkvKd4dNbrf7iYDDudLB9dsdhEWvU71tvn6ij8VSS7
	qSeNYKs6WnIz9bgEiA==
X-Google-Smtp-Source: AGHT+IFKYSSch4fPt+g5RPN08wbBkKjCkuaYqxQRrfosrWpJ/NYUxrVn8U2lZsr2e57SqfOwDgbo5HtLBWQdmoKwcA4=
X-Received: by 2002:a2e:9546:0:b0:37a:4d6a:313b with SMTP id
 38308e7fff4ca-37b8c2f07d3mr9745571fa.17.1762960520351; Wed, 12 Nov 2025
 07:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107132149.177327-1-marco.crivellari@suse.com> <aRShDB8g0hG7JcWX@hovoldconsulting.com>
In-Reply-To: <aRShDB8g0hG7JcWX@hovoldconsulting.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 16:15:09 +0100
X-Gm-Features: AWmQ_bmlVDaNPmJ0_OHRP79Nso_s5tvPDt3ATIV98YucP1U9lSl6pQMabVyIr4o
Message-ID: <CAAofZF7nYkJwW=e-iS0p+9eRVMNR9Pmf8kKLR560tgg5nqfaEA@mail.gmail.com>
Subject: Re: [PATCH] drivers/greybus: add WQ_PERCPU to alloc_workqueue users
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 12, 2025 at 4:00=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Please use just
>
>         greybus:
>
> as prefix.

I will do it, thanks. I think I saw a couple of commits with that
prefix, so I used
it. I could have looked better.

>
> On Fri, Nov 07, 2025 at 02:21:49PM +0100, Marco Crivellari wrote:
> > Currently if a user enqueues a work item using schedule_delayed_work() =
the
> > used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies t=
o
> > schedule_work() that is using system_wq and queue_work(), that makes us=
e
> > again of WORK_CPU_UNBOUND.
> > This lack of consistency cannot be addressed without refactoring the AP=
I.
>
> Apart from the naming of the WORK_CPU_UNBOUND macro I don't see the
> inconsistency here. We queue on the local CPU as documented (unless the
> CPU is not in the wq_unbound cpumask for unbound workqueues).
>
> Note sure how explicitly marking percpu workqueues is going to change
> this either so this paragraph doesn't seem relevant for the change at
> hand.

That part is there only to give more context, but I can remove it from the =
log.
I can start directly mentioning the changes in the workqueue API.

> Fair enough, the default is about to be changed.

For now we're only making explicit if a workqueue is per-cpu or not.
But yes, in the future, this will change.

> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>
> With an updated commit message you can add my:
>
> Reviewed-by: Johan Hovold <johan@kernel.org>

I will send the v2 changing the log and adding your tag.

Thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

