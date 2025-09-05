Return-Path: <linux-kernel+bounces-803310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15BB45D55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BE5A31E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A132FB08F;
	Fri,  5 Sep 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M+LuUK4k"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9723D7F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088019; cv=none; b=Dit65dZiK8EqJuTlYByb2EMJxymfN8Wlebp53ERexVripSsLmh3rQvKyEtq9+upUEEXMyZ0cEyTgbiz5KW2pTsyH4sXMIPrttXDEhmlR8MiE4AunS6sbbLn2MycKfTHrWEbeZJaTy7buvjNmqMY2Ld0FeHVupfnsJa0qkMA0RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088019; c=relaxed/simple;
	bh=yLGh2aJpg58ctmF2vT1+UHKl02h0pwM1dxLsuAV+Xxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njs5NxyEXZHk2x0DHi7p7PpaBnFw+fBesyMdVXCU7rkOd0q4DRhXTW1Mdx3peOikkmSntN/qsaXTbmh7TbrivxgNsLM7j5+AH3jaof/GELwsdE342NmZC6CgXAInNUvTGCR5B2qcWvL0K6i+MBxOF2Yh9QnQsx3n1pO3Fo2y28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M+LuUK4k; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336b5c44a5bso27971251fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757088016; x=1757692816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bjDj52snoHgFyrFquY5QitOrzAfGlc1oN1n4B4vVa0=;
        b=M+LuUK4k9F5RMP1NeGYmvJa6pXH9GjaUM/eRfrIVVBaxAf43h2N/lKUQ8uVeghAzjk
         RczPkZpAzAflaq2hlSirbNmUV0NVDmTCVzfa9VeDRn5NTJmeBr5xiQoejyWdS1+h2eSg
         NfhknZVmH5jvHNpXYR9gX2ZIwm30xFFUpczQOkQiaktNRxijTydYSJJiULKrdUyjkooM
         e0ugfpaXdLd+S+fATdM3+PTeiv2kye3+PueGFhmuC4rb+tTYE3WdtJhVD7xQxmxDzPjo
         v/ehBjRcQ+xDmwD/fkCYfBIizVRxUfG5yPZl0Jm6knei7oR4KfeW7A0TYna2mULZmefc
         3+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088016; x=1757692816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bjDj52snoHgFyrFquY5QitOrzAfGlc1oN1n4B4vVa0=;
        b=JHRrQ5iyHHznr5/GQqI6xzqJDG8TRoehn8yr3isfeChVWGddqM5t3rISEZXAGgNra3
         TLgFfXv8NPywK0eUE9ErTJ0+Fp63sudMbJb4gUnBkxv6szW6sVlY/5wRYPYQoJb+gy3A
         4NSFwhk37TUoNgrwb4EGxVBdsJehgSLn2CmujpOkREq635rHZkoErCnEZ+Qams1MVDF5
         cQkEiag8jRfPTDNslVdhToBTzuLSuKomsgEg4MxEcpNJ16e3/8x/8T1+H8tiujEUzoxs
         /NLhUj+GGghToK5GZRYZZayLC3Ca9VQkwlDhCOvVU4vEg++cwxVzMIrk+5lDhGC+1pvn
         0p4Q==
X-Gm-Message-State: AOJu0YyNs2s0darMWwgOXfX31KkN8QInqsBfYm/S3Auzae1ItXf5Oz7y
	lZUHLFlAjKRVrdbS7lRPVU7EFUpqfuf6WKEx9d/cGfcWW7XsL9gHmKngXRsWHjUlOSOc9PRy8hv
	umkCF/c6kjWQYgJtsY/1JTpDNTrVZeY15isf5u3zt0g==
X-Gm-Gg: ASbGnctYBhX1rwek4J0FIfrIWxXsnOCQK8dpOQ75UiOrM1qCof+CjpCm6FHF0zFio3l
	P/MXB0S4R7H7SfjuUYu8iOO9NwQ0epFHA2wmoldpT/rlVrQQPLkal+T6y0tvu6wqOkeJTCvTy0h
	bkv4Ift74oybtHy490Z/vwV1iSyOHWtIOImYCwITJRAdsCD2v40BFtOK0f2eScTgJHIA+Tszshl
	neMaiv25oojmIntRgKhtGoNOJ6ZlKSt6pLrfbBT
X-Google-Smtp-Source: AGHT+IFWFllRqBJJC6vj9q5oW2+TpaBpQXiG5fJTfZV9kG0qNYRFPhtQblzR/7c8dDPGGPhKPRaGmeg605DhjF/ltOQ=
X-Received: by 2002:a2e:8a94:0:b0:336:ba9b:6472 with SMTP id
 38308e7fff4ca-3381e4da426mr13054441fa.5.1757088015869; Fri, 05 Sep 2025
 09:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091016.109428-1-marco.crivellari@suse.com>
 <20250905091016.109428-3-marco.crivellari@suse.com> <54446af3-9ca5-4932-a3fd-e44185751dda@sirena.org.uk>
In-Reply-To: <54446af3-9ca5-4932-a3fd-e44185751dda@sirena.org.uk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Sep 2025 18:00:04 +0200
X-Gm-Features: Ac12FXxBafT2_R1XPvXrTWyAtuMqsPHuT7Yz0bI48thuJ2QWyDc4k9UPqdjAzhI
Message-ID: <CAAofZF4XEFXWQEqeKJ3aTjPRuu5RgOEYRLX4Aeq=RGh7gnLGTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: replace use of system_wq with system_percpu_wq
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Mark,

The above change is just a 1:1 conversion.
system_wq is a per-cpu wq, so we only converted the name with the new one.
system_wq is still present in the code, for a few release cycles.

If the users don't care to be per-cpu, system_dfl_wq (the new unbound
wq) can be used instead.

This is just the first step of the conversion.

Thanks!


On Fri, Sep 5, 2025 at 12:54=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Sep 05, 2025 at 11:10:16AM +0200, Marco Crivellari wrote:
>
> > +++ b/sound/soc/codecs/aw88081.c
> > @@ -779,7 +779,7 @@ static void aw88081_start(struct aw88081 *aw88081, =
bool sync_start)
> >       if (sync_start =3D=3D AW88081_SYNC_START)
> >               aw88081_start_pa(aw88081);
> >       else
> > -             queue_delayed_work(system_wq,
> > +             queue_delayed_work(system_percpu_wq,
> >                       &aw88081->start_work,
> >                       AW88081_START_WORK_DELAY_MS);
> >  }
>
> I can't tell why you're putting all these onto the percpu workqeue, I
> would be astonished if any of the users cared.



--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

