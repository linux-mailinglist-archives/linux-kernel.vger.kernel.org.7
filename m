Return-Path: <linux-kernel+bounces-723263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE5AFE522
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2609E3A700C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AD289807;
	Wed,  9 Jul 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0QOb/7s"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB816289813
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055485; cv=none; b=G4JE33e0NUh5/GswA47InsAXAceOqvVkhDzc4syz3lFZowjM6QY9NATeMjK+JF41m8WxTcdWEcQQpwWzvB5NS++Frb2n2HW+Ec4y5lSAEz0FSyvwp39IdknxvPRN1qxsxG7+eNLkLJkKIszPdzd1OMUpllFPqdE54OrrOmfJfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055485; c=relaxed/simple;
	bh=/8y/nNdfDj5bopu6125/NYN6hTKvH5RpqCgiIhx/xy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIMmlW82FoOeqYjpS7akgzuFuGssYWqFHpOax6+DSpwGGGElSzbWNDEfk09r3a07HBfFHs5s+2NXMROaOZK7ASZAtuM2JkZK129atzIkTwQR0pLeYOfzDaK87C3vA/2BXhMEJu3emPHjA9Zkp9QFSMNO+IpYN3MJ/L2vqv3+ZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k0QOb/7s; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ef461b9daeso3880336fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752055483; x=1752660283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+bfGFW4DtSQcr5Yecq9KqtEiX+ZRp1VJeXV6fP2IcE=;
        b=k0QOb/7styAjG16KLGACW84roeJbMF4KWZSbZlLam/t5KukaAXzLubbjTSJ66pyC/z
         lxBuFGPKsbbgdiFb9kjnUFv7nMhcwel/PwuxNanw57yiO5R2fDybQQdJYlaUkwgXn2Tw
         Qo2OXYqZH/0krP9bX07baXXeLHtJJtEhOIO4EAdKPIS2oT3XXbA3HFLAH72GQQpiOgju
         T5+WeRACKO44CEtnA0QsNlw1QK6GTInXAbLYTiTzykrw35LvxVPN5ZSIPM9WByT/UjBo
         1BC57ugXwQ5WjUEGxN9KN0tKsvem+akHQJIOE62XRS506tIpymK/DYTZpjFIe4hgpMh6
         b41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055483; x=1752660283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+bfGFW4DtSQcr5Yecq9KqtEiX+ZRp1VJeXV6fP2IcE=;
        b=M5DBGwySdz2uro+zMujcFxS5NS3vr08l8JYg7tRHDCEx+gMzy1aAg4DxcwQAtwnEvz
         y+/91t4lUOPLBLFmi1p/7b6aR15lNmqbzgXZanLfdPSv5iLQOGh5LIbthJ++cTkvzQxa
         S9JkbccJq72BCw3uKzDKjER0gvXPzwHzM7a9MR1ZkCC5fZSxd8BJKz2ZakcCMa2285xB
         9AiZ48RmUFgSdzIjR4nlAF55KqH7aZitWXYh6XpmLm2qXsKQ6sF2SAM2by8wsECuAHqO
         JI4vsTO4CUUK5aOHNkpExTiRNcNBaDPjQySlaYtpdtC9OuqbhNwlOj5W/XSociVaNMxl
         eNWg==
X-Forwarded-Encrypted: i=1; AJvYcCXM/W9lYPkKOzum7TLsFxJ2wdJdivIFSa45o2TpU9QXyxfrmF2DS0VFiEaevqKZ/y3hXprzw092oYBAzzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxndp7LibgwBjfdoXA0x6pqR/zgt+XV9GBr+kWjv+Mogcr0Ds9E
	fSL6iQy/Ss05FTfjVpOSjp+NhKgt0bqimXY0zvH4EXPs4b15EWaNWacgKHsMLJoMLRNDdpzfVcT
	MlgS3kR1jXjJ+s/FEOoDTPdl7nk4olwR5DiN6fLltKQ==
X-Gm-Gg: ASbGncszJ547Qi4NGFVwqxyZdMrG+x/L5VPpmrgC0FdEvnFdlEijaP7eWisPlX/Zd7n
	QiKmu9swCNDKSCizOn3SY8cwBFhebhDkDz52m0EkfJR4coQTrJX5StMTTqqAjHJ4fI2CWo4rvIF
	ArwB6ifngQty5oi7oqCMiZqD1LGdwGFrR6K2lhu2FDoqY=
X-Google-Smtp-Source: AGHT+IGY95z19tqvWhEI5fgWA6R8T6/UqcM++P6QZAW4xt2CGrUQgdZq9RwXXFtbhIUTeJDCM/NWWKWEDhJ2ZJDsq3w=
X-Received: by 2002:a05:6870:46a4:b0:2b7:f58d:6dcf with SMTP id
 586e51a60fabf-2fef870ac82mr1083901fac.18.1752055482714; Wed, 09 Jul 2025
 03:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-gs101-cpuidle-v3-1-0200452dfe60@linaro.org> <53a214b4039872ce7584a2ae6e688fcef0c86d7e.camel@linaro.org>
In-Reply-To: <53a214b4039872ce7584a2ae6e688fcef0c86d7e.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 9 Jul 2025 11:04:29 +0100
X-Gm-Features: Ac12FXy1nHjPc0ZtUVknu5DhgpF7CNwmS2WMX0Qx_tI6AsiwGCLjhVVgixkJAf0
Message-ID: <CADrjBPrPcYZPFuRqwm0OkFU+CQtinFUtNXHzt+MQpEy=Q-Xnww@mail.gmail.com>
Subject: Re: [PATCH v3] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, William Mcvicker <willmcvicker@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review feedback!

On Thu, 3 Jul 2025 at 12:01, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> More small comments. Sorry for the drip feed, just trying to understand
> things...
>
> On Fri, 2025-06-27 at 14:08 +0100, Peter Griffin wrote:
> > [...]
> >
> > +static int gs101_cpu_pm_notify_callback(struct notifier_block *self,
> > +                                     unsigned long action, void *v)
> > +{
> > +     switch (action) {
> > +     case CPU_PM_ENTER:
> > +             /*
> > +              * Ignore CPU_PM_ENTER event in reboot or
> > +              * suspend sequence.
> > +              */
> > +
> > +             if (atomic_read(&pmu_context->sys_suspended) ||
> > +                 atomic_read(&pmu_context->sys_rebooting))
> > +                     return NOTIFY_OK;
> > +
> > +             return gs101_cpu_pmu_offline();
> > +
> > +             break;
>
> break is not needed after return, and generally there should be an empty
> line before the next case statement.

Will fix
>
> > +     case CPU_PM_EXIT:
>
> Should this also handle CPU_PM_ENTER_FAILED in the same way to bring
> the CPU back up in case of failures?

I choose not to do that, mainly because the downstream production
drivers don't handle CPU_PM_ENTER_FAILED, and without access to the
firmware code it is hard to reason about.

Logically it seems like we would want to do the same code as
CPU_PM_EXIT with a CPU_PM_ENTER_FAILED, but I've never seen
CPU_PM_FAILED so far in my debugging.

>
> > +
> > +             if (atomic_read(&pmu_context->sys_rebooting))
> > +                     return NOTIFY_OK;
> > +
> > +             return gs101_cpu_pmu_online();
> > +
> > +             break;
>
> No break needed.

Will fix

Thanks.

Peter

