Return-Path: <linux-kernel+bounces-866775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C496AC009E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EF83AF2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2903043D6;
	Thu, 23 Oct 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAeQ2LB/"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2130B512
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217402; cv=none; b=Q7XZhpZ+rl6XllzNMEWXu5rALkdKJaBGX6ks9UTRA+Pm64zkrjThUq65rOqt9+zgVmrcMJXzmaQHbXQxZW5+mnmuukdunCjBv+fmkGr83gwX7P9hRoZtDjJD6Z2Nl7Jx4Wu9rcSOsVAhxn4PKAmtKK/kQRTrVHDJsRAyiPnmZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217402; c=relaxed/simple;
	bh=kZC25qsbl3ZVQMpGsECPr9boGkQRtJp0QxMV+MmWYb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk6nDpQ0Z4ngrF8ba/zs3vRjP6L3LULkZbYN9qxJapiWYKOnhmW3NAdtymA44oSsEuYcVWOS0SpdLrotlXTcM/Sr/hvjjrdMJ0h7HaCjfIL/sbZNDF78OEFJakjpqMSlBtpQvFEw6wJHFJY8+wRve0mva7W34z/gdPjuFrDXtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAeQ2LB/; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87eed34f767so6840456d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761217398; x=1761822198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd6nofyQmPMP1EYX1KtqHfLYsYPHKu5g4d0IvVjy8gc=;
        b=XAeQ2LB/plTtuaKpuaoYD37O6LJp05yYET6uljCHh/INJCxa7FN7z7Mi/KlYgQUkYH
         h0WEB4Be6zKjyBNgIQE80bJ69XqARreG0FETL10PvWbYrqmRXupFQ3IIAiIZrngb8XkA
         BYs1K118/jV4sKDnG6XG6CLegx6kGtqW7Jg29rBOKfOCRv9y8LTlAAJBB8mX9PZCdRnp
         sX4La4WujrJkuQYanTjm00meoERkNWIkNCUtrzSTAG2htgvP9bd3+jrd20lHnAIs0fuq
         FO9jbaeSRjzMVjmoBZOS4A0Syc753/R7SkO+7Jl364W98ZOAs3Hqxa5p5UWCPIydlABr
         chnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217398; x=1761822198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qd6nofyQmPMP1EYX1KtqHfLYsYPHKu5g4d0IvVjy8gc=;
        b=SCu4qCjfKH7tTNJcJMf+UYpa7vo0++NU5CbXN1sh2Y4nbn54jnE1bDuDYFgOlOJzvu
         9uF1qeepXmGh8vCgw+/6dJJzvYPlLFbEirXlovjHVhtAzMXfGB/U9CRxozvlkwzPnyHT
         qL0PfvdwB0FHYhJM/x0w8rW2l/D+shp5c4DLFttW3OEUGlJ2n6DvWZRJFZ78Gv5l2I6j
         wcyeJZmrI9xx4AsQtsx1ye5lbOU5CbvOfivNG1R+5sjHZxWvGB4nIjbOn44zdL8CJThy
         GMcBwwRSyT9tUUohgEyOKUrYHuRl7ugLMBSCte3DAX3ECVP2VJvyVBBxuW/GefNPDb5a
         +I7g==
X-Forwarded-Encrypted: i=1; AJvYcCXkUItXxKCUNx3WrAE72yQmmGccGWefVuPpufdpfCtnFrUbN+GDqManM9wbJRqoxx/331p8g2zSiCFeye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBys/WT8Lb8kUatdefLdQ7euL8l0d+iXmAHo3QMWvvoPLQI2pl
	4mb/6TensJetVMnu3EAjKFBLJIf/0Y7hUr35GYce5sbgfPvlsm8Z/h42VRzbo785ZSo3LQPrLJ7
	LUuHGZGynVtxA6GMlTP1MprsSF/akZUghIF/5XWYQvQ==
X-Gm-Gg: ASbGncsYGlAPUPQR8sLri3HodRapAIHXaBruMfzRgVGPEABpNyTZt/TStaB8VKhnXhC
	ZRGdO6VL2euDClspam0ZhCAGrb8x+Z/FSntNqTu4pe9CY6BYkk5KIvpR3EK8Dmnks9AMP/VOAkI
	zaU80faAkoIH9fpcW4EuNR/U25PZpUnXfEz+ALecMucEq0obUxtafJMo0arr/9TVC8mTMH6bajd
	jIi/sEXNfwLvA6wGlqF5JlGiqQhGH5h3leYPOAEn/gJduLLDtYlMEgdOmCWxh7rbixq2JHbZymh
	6rChpYy2XLoQAcg3bw==
X-Google-Smtp-Source: AGHT+IHV9d7J3zGQsRNaBSZt8a244UoDZu83S8deEkcVFH8GGHgsbHEZ4VO1/ZD/vLF8Q+yv1sgVyCSVLM3mfuxSpHM=
X-Received: by 2002:ad4:5cc1:0:b0:7f1:62a9:ea2f with SMTP id
 6a1803df08f44-87c207f3275mr297371716d6.52.1761217398006; Thu, 23 Oct 2025
 04:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021234520.3355-1-mike.leach@linaro.org> <20251021234520.3355-2-mike.leach@linaro.org>
 <20251022092958.GQ281971@e132581.arm.com> <CAJ9a7Vi+Oq3Zma0Cs+w8m0kRE0pG6ax3=26EQK=u7d=vQfNFQw@mail.gmail.com>
 <20251022140409.GR281971@e132581.arm.com> <CAJ9a7VggKoYdELcWTXxOg6-78TK2NAEE9uNo6cgpmx0x=0cwsQ@mail.gmail.com>
In-Reply-To: <CAJ9a7VggKoYdELcWTXxOg6-78TK2NAEE9uNo6cgpmx0x=0cwsQ@mail.gmail.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 23 Oct 2025 12:03:07 +0100
X-Gm-Features: AS18NWAtH5-3VwKbfi7bV4TtaV6PbrywDXGyOVNivd7Gv9MyDy--XlUXOaIQ5_0
Message-ID: <CAJ9a7VgOPgvzRmGg_a_W_LgFNVXBoxBH62XZar53s0W5c=4pvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] coresight: fix issue where coresight component has no claimtags
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo

On Thu, 23 Oct 2025 at 11:18, Mike Leach <mike.leach@linaro.org> wrote:
>
> Hi Leo
>
> On Wed, 22 Oct 2025 at 15:04, Leo Yan <leo.yan@arm.com> wrote:
> >
> > Hi Mike,
> >
> > On Wed, Oct 22, 2025 at 01:35:46PM +0100, Mike Leach wrote:
> >
> > [...]
> >
> > > > - We can add a new flag ("bool claim_impl" in the struct csdev_access),
> > > >   by default the field will be zero.
> > > >
> > >
> > > I considered a bool - but the correct place for this would be
> > > coresight_device - where we keep all the information about the
> > > hardware features.
> >
> > Maybe coresight_device is suitable. But this might require to update
> > furthermore for claim function arguments (e.g., need to pass "csdev"
> > rather than "csdev_access").
> >
> > > > - The drivers support claim tags call coresight_clear_self_claim_tag()
> > > >   in probe (see __catu_probe() as an example), we can call a new
> > > >   function coresight_init_claim_tag() to replace it, this function sets
> > > >   "claim_impl" properly and clear the tag if supported.
> > > >
> > >
> > > I considered moving this initialisation to the common coresight code
> > > where we create the coresight_device.
> >
> > Seems to me, this is dangerous. If a module is not CoreSight compliant
> > and claim registers are absent, when access we will get unknown values
> > or even cause serious result (external abort or bus lockup).
> >
>
> Currently all our drivers assume claim registers are compliant - so
> this makes no functional difference to the current situation.
>
> If the hardware is non-compliant, and is bound to the current drivers,
> then there will be an access to the registers that could cause the
> same issues.
>
> There is little sense in having a call in individual drivers to init
> claim tags which are regarded as common management structure.
> Any coresight component with no claim tags must still either have
> registers indicating no claim tags or as per the specification
> unimplemented register locations have to be  RAZ/WI - which amounts to
> the same thing.
>
>

Having re-visited this - the cpu bound ETMs use a smp call before
creating the coresight_device so it would be impractical to move this
into the common code or use csdev parameters to make the checks.

The only time we claim  / disclaim is during enable / disable device
when we are writing many 10s of registers anyway. It does not seem too
much of  a performance hit to add one additional read per enable

Regards

Mike

>
>
>
> > [...]
> >
> > > > > +/*
> > > > > + * Coresight specification defines a maximum of 8 claim tag bits.
> > > > > + * The precise number is implementation defined, and may be obtained by
> > > > > + * reading the CLAIMSET register.
> > > > > + */
> > > > > +#define CORESIGHT_CLAIM_BITS_MAX_MASK        GENMASK(7, 0)
> > > > > +#define CORESIGHT_CLAIM_SELF_HOSTED_BIT      BIT(1)
> > > >
> > > > Now we only care about the self-host bit. Can reuse existed macros ?
> > > >
> > >
> > > I feel that drivers should be written to match the specification - the
> > > macros above are a correct mask value per specification and the
> > > correct bitfield comparison for the MSBit of the protocol.
> > >
> > > The ones below are a protocol masks field, and a specific protocol
> > > value that is used in value rather than bit comparisons in the
> > > claimtag code. I felt it clearer to differentiate between the uses
> > > when reading the code.
> >
> > How about change CORESIGHT_CLAIM_EXTERNAL and
> > CORESIGHT_CLAIM_SELF_HOSTED to MSBit ?
> >
>
> The checking code for the protocol does a value compare on the pair of
> bits, not individual bit checks.
>
> Regards
>
>
> Mike
>
>
> > Thanks,
> > Leo
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

