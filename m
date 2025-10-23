Return-Path: <linux-kernel+bounces-866684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7DC006EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E93B735336C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D8309EF4;
	Thu, 23 Oct 2025 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYuCDIfG"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CD302773
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214744; cv=none; b=kL21sxWdpiDQYsxpqo+FKwbJk6SHX3Fhojylw59TdwM8N49Z3lbRG+Ku+lZ+tN42Tfyg0HQgWHuYYajdKOgHAvVC3T9zNzReF+XLCBLFhiT1B5LswLNx+W9jm6LZd36fvbHE2cVOFM1X7V0fUy3xGR0lLOJy4SrtSjxkin+kldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214744; c=relaxed/simple;
	bh=a1BeWYtfc8iIuGaES/OhW8TI3qadjfvgm0OZbqp61vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBv+uY1ESw1uFGB05JFFT0zO0TLWGHJYLEJ2+xGKle05DgaOayA0mqa2LnDTtTErj/epQLWkttb1t/DeBzqyX8FFU6M8NmB6BfcN+Te/FX+Hd+Ibpp06FQoc6+rOwITEfKCocgoTI27p+Fpsr3xPNuF4wjglSWfWKi8tFN9UcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYuCDIfG; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87c103928ffso5864666d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761214742; x=1761819542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj+Kif4dfrKe9mwz38YrsgAu4gm6A5BRFb4/J3K2e94=;
        b=nYuCDIfG3povgXiZvoKLcYsWc0eNtRd9eUCmpZcHxlrNosLieTfFfLTaATze5jfzYt
         zOLEJ45EVMDbENJnikTlE7Yffs7X8zj0N8HuPfULNotzpfUsOlPfTWQahlWMxgVRt+F+
         K7l4cOGqeeXESijAkJg5mzdLybo0F82WBq+ldzRXfSuwUeYw6+w4doLRplpUaTtvyeyF
         DkLRpssPPFoItcKTeaGG2lID9LvLVgWm58Zuswx4OYtVCX4GrZ2gZ6L/dRVm5OvcbfXt
         UUxR8hZi+BZGKUzbxAnI9zYxstEZSvshrHFN//ggJcHsuwX2kHormZm7Wr5wrs1ddX3O
         kpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214742; x=1761819542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jj+Kif4dfrKe9mwz38YrsgAu4gm6A5BRFb4/J3K2e94=;
        b=vGlzsNVYx0h2nqoyrlXBQIYps14fYscQT5LJDRmQWTfz6mfIupz891+NmTL5yZijag
         5QY+C6gU6XSk78taYdxftticWur42Zzj209qUqub+inK6xwWJUzokwVNoYthbbWVzvol
         zNo6d+olt6psMPKY+VopBr5HVN69vDCuzPQ+sMg6wSK44pUDHTG633W8uXBPKhseyk9i
         c9GSOiUymhMt/hJaEeia+KEbOY1t1mhbj0DEDzYo+gleE65kVDsrAR//ybRasgc5t8Ln
         lCIJRX3+p1ZdnDsRoOMby3j/q6GEFf7PDnkByBUtGRYp8+kgYtMwkeQctZ5PXU9hTWhA
         B1hA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQ+8l35Szjlt4+4nwhcWxbad3/CeUUfKnAj1vcl3ebJVc2b+9ojkibX21RtG3gQ+ozy/pxLeaHZ4fJSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9U9oJLtXyCB7ZdDP1g5aIZfY63qkXvMC2Klb1TpC+4ZDdu6Mf
	clfItwEBpC+827Fqdi+rZX0pS1kR1OIZECahqX5b8vJmrw/JQd4MarsfZwoxxGw1Dyl9sRY+AIK
	XIhld7lBxTsifxbWc+GYCbFfAueztLnBfaMbEwp/NbQ==
X-Gm-Gg: ASbGnctGU2Jg+ZjrgmvC171ghr4pSzCvOFgm9uE+ITIEpj9ZzUo85ZRatC4pIWk6Xgj
	MFukdpGY+C1c4hw2rXDIx9dbivGcbfHt4DqOO/K7uaK6AoG5lpd16GaSiqluwuVCDHl8u/cGTBD
	nbna5MaOwGyeH6mmxFBts1P7XC51RIyYXMZZfJruz83igesyQvt7I6PanpgE8xCGVy2dUaLlHFN
	PaReE54cwRbLOU9fSuKz4BltqPJMFpHt4lqmWcowEMmFva4e4Q/VDyUUa56Hc+lYEd6icGBTRRK
	TM9vR020mSKfKFbDrg==
X-Google-Smtp-Source: AGHT+IHNhmQID8BxdTuPqUD1UOIaCU7OEog3sKm0kstXbUtDfJdGdBhlg02NR752jpqHk1Bz3E77Jj7bDJWs5M5CGgM=
X-Received: by 2002:a05:6214:2423:b0:87c:29c4:4bec with SMTP id
 6a1803df08f44-87c29c46f93mr338397966d6.54.1761214741816; Thu, 23 Oct 2025
 03:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021234520.3355-1-mike.leach@linaro.org> <20251021234520.3355-2-mike.leach@linaro.org>
 <20251022092958.GQ281971@e132581.arm.com> <CAJ9a7Vi+Oq3Zma0Cs+w8m0kRE0pG6ax3=26EQK=u7d=vQfNFQw@mail.gmail.com>
 <20251022140409.GR281971@e132581.arm.com>
In-Reply-To: <20251022140409.GR281971@e132581.arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 23 Oct 2025 11:18:50 +0100
X-Gm-Features: AS18NWCeiUa4aE_71Sz4zTfIuX-f8RyEZqLdNWyWeqNAXjkOZBf7qdkAOeOtddc
Message-ID: <CAJ9a7VggKoYdELcWTXxOg6-78TK2NAEE9uNo6cgpmx0x=0cwsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] coresight: fix issue where coresight component has no claimtags
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo

On Wed, 22 Oct 2025 at 15:04, Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Mike,
>
> On Wed, Oct 22, 2025 at 01:35:46PM +0100, Mike Leach wrote:
>
> [...]
>
> > > - We can add a new flag ("bool claim_impl" in the struct csdev_access),
> > >   by default the field will be zero.
> > >
> >
> > I considered a bool - but the correct place for this would be
> > coresight_device - where we keep all the information about the
> > hardware features.
>
> Maybe coresight_device is suitable. But this might require to update
> furthermore for claim function arguments (e.g., need to pass "csdev"
> rather than "csdev_access").
>
> > > - The drivers support claim tags call coresight_clear_self_claim_tag()
> > >   in probe (see __catu_probe() as an example), we can call a new
> > >   function coresight_init_claim_tag() to replace it, this function sets
> > >   "claim_impl" properly and clear the tag if supported.
> > >
> >
> > I considered moving this initialisation to the common coresight code
> > where we create the coresight_device.
>
> Seems to me, this is dangerous. If a module is not CoreSight compliant
> and claim registers are absent, when access we will get unknown values
> or even cause serious result (external abort or bus lockup).
>

Currently all our drivers assume claim registers are compliant - so
this makes no functional difference to the current situation.

If the hardware is non-compliant, and is bound to the current drivers,
then there will be an access to the registers that could cause the
same issues.

There is little sense in having a call in individual drivers to init
claim tags which are regarded as common management structure.
Any coresight component with no claim tags must still either have
registers indicating no claim tags or as per the specification
unimplemented register locations have to be  RAZ/WI - which amounts to
the same thing.





> [...]
>
> > > > +/*
> > > > + * Coresight specification defines a maximum of 8 claim tag bits.
> > > > + * The precise number is implementation defined, and may be obtained by
> > > > + * reading the CLAIMSET register.
> > > > + */
> > > > +#define CORESIGHT_CLAIM_BITS_MAX_MASK        GENMASK(7, 0)
> > > > +#define CORESIGHT_CLAIM_SELF_HOSTED_BIT      BIT(1)
> > >
> > > Now we only care about the self-host bit. Can reuse existed macros ?
> > >
> >
> > I feel that drivers should be written to match the specification - the
> > macros above are a correct mask value per specification and the
> > correct bitfield comparison for the MSBit of the protocol.
> >
> > The ones below are a protocol masks field, and a specific protocol
> > value that is used in value rather than bit comparisons in the
> > claimtag code. I felt it clearer to differentiate between the uses
> > when reading the code.
>
> How about change CORESIGHT_CLAIM_EXTERNAL and
> CORESIGHT_CLAIM_SELF_HOSTED to MSBit ?
>

The checking code for the protocol does a value compare on the pair of
bits, not individual bit checks.

Regards


Mike


> Thanks,
> Leo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

