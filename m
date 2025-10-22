Return-Path: <linux-kernel+bounces-864928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AFEBFBE19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEF15507D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809353446A3;
	Wed, 22 Oct 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcIiqUjl"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487D33C52C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136560; cv=none; b=FYppsW95elTWDYEuteSYXsZxacILyPAWwZjCu9XO3cnCnfVH6V3gP8K9oNt0RHkG76RElJ6vY77cvOzdXYNNHtU6qul6U8JJgOJoRhpfNmhCMEUNJbi3t2EUg1/ZcF2rGexOmo9OqvTXbCIqesZJbrKOLNe5/hEDHbwkbEbW2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136560; c=relaxed/simple;
	bh=jYM/UDrTozp6klLJnF4w3Rr+6N5MsYZF5es3U5y2FB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGnOV2ef66nUVUHOTrnIQBL82e38wMdV4wHlPrUymPcynaeOf2uCw7l/aME5qs3x2dLgJkOZrYfmAsyRR6jMtSyAEO1lZBCr+ElSHHYLChVBSr8qsP21lzqerzPU3Sw1TShsw1FRt+SjpbjZrOpWjpqHq8Oix46nyf9N1VjpCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jcIiqUjl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-879b99b7ca8so92796636d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761136557; x=1761741357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QEqNt/+ao/gTJBdF0+NXGKTXYzKL+8Jvqheq+IJLDJE=;
        b=jcIiqUjlfkFxVDfGFonCdD3lrRrmO7yYtQ3x5T+0YN4cWjYInqZob/+1WwIP51imst
         YYA9LrLo/BmxnuWEa1eQx7hG52/Jsbg8ILho3OQjUdp7djBYbGWexSg+PqxwQLSeUY9F
         Y7oln0mBvRp7hm9ngZXEd4jixvGYZjtGKZa4XUH44l7CuD7uhbFjEZfdkTIBR0oqFPMF
         GKpSZhQ4l8EoKFMtjXLbUPzUJccsETBGuvcW84XtgUql1coMmZ26ycbNjG/STBCQSGp0
         pnGpbVzjI4KusEsOronNoam9PlK3oPUI2LsDk06J56L1ZPT+83c6tEUKMPQ0XCquH7iF
         LRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136557; x=1761741357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEqNt/+ao/gTJBdF0+NXGKTXYzKL+8Jvqheq+IJLDJE=;
        b=V+KCBIb34vk11sgYHON/YrLuH7p8c85myVV8TXvHGof8kYz+tUPnQmOqvVHe8uDsI1
         nYl2oNweB0U91y2g6qFd0s6pdqolErAEINAURqrr2CxioyAAmM6EMocL3yeri7c8flsg
         yo9Smk6f3pnMdGeuNjzrzDXGNRFoV+lm3JwfIO0vurqONCvHwGFNrf8T3Kf/8CY6oYs1
         hyQdpmbt2h70b3ss8wGGJKWEMSznNNmtYfohSrL4SOH1oucehmK5evOz0u7rByz0a2dD
         udzbYmZlp35m0K09U9iWuQ/C4JCkzzet3J5Kqlj2cRUmcXgFo5lX3zBybG0wahvz1CcN
         djFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpflqoJ3jo+Bk11D49kmpxG8Hiug3KdVeXyULFmp/O6ZFrJooF2oJLqZP+OCHIPy/kbEDGwnMBDJ32ITs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMg4M+KMDwGwQqApYzAHcQJZzwnmRhWysXnTHXh3BUdteNJ3sd
	Cc5vcVnHZ54zn8iezLCyPlDTETkyXhVw8DEO9ajIz6BKbWE+KWldBa+B0Q6HNEYZLHPeRLfNRuh
	VlPd0qpZuAzwBjr9He5pLoioRgjxHcQYTB72JQ99g5w==
X-Gm-Gg: ASbGnctRbHFtH1oVq4twSCaBK/jhr8Px6zk+S2fe1Ixue2MUDKR2V6yhWjgJG3OTsB9
	kmssa8pxoM1K+b+VitaD8G4YL+RgluvtPCm2/Go0ciK963UVPHw8ibLR8hxZXVhtLHPT7rA/PEt
	pigzWgMCuh0yMIiu92xCAjxwNy84kuKBf5uXYyxn7obVwYHKfGLwoyGHDoC/PCQ0C+MIefQdVCM
	nhOEKR8hAg+v5fvR3v4G4UFXtgBdAYqiesNBz8iXiO7H2kocah982ybsz0dkA8Zs77Ni/KEe2qS
	pUJ7zcZC6v8xTbWMIHYSOzUZpG0F
X-Google-Smtp-Source: AGHT+IH7JGEMGpygwX6/uhEgxtQ7L6U5hDBowTCRaOx0iT0Qi0sOgs5c5C19JMyMWTGH62mvocMghuMDJSwmqlWfDhA=
X-Received: by 2002:a05:6214:8006:b0:7cd:91ff:6215 with SMTP id
 6a1803df08f44-87c20824c74mr226324176d6.61.1761136557306; Wed, 22 Oct 2025
 05:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021234520.3355-1-mike.leach@linaro.org> <20251021234520.3355-2-mike.leach@linaro.org>
 <20251022092958.GQ281971@e132581.arm.com>
In-Reply-To: <20251022092958.GQ281971@e132581.arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 22 Oct 2025 13:35:46 +0100
X-Gm-Features: AS18NWBuh7X2EdT2ACmWcHMWER71d1F1K6PHqDwZ8lOLPAaG8TyZVWGaJ3MvXUc
Message-ID: <CAJ9a7Vi+Oq3Zma0Cs+w8m0kRE0pG6ax3=26EQK=u7d=vQfNFQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] coresight: fix issue where coresight component has no claimtags
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo

On Wed, 22 Oct 2025 at 10:30, Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:45:20AM +0100, Mike Leach wrote:
>
> [...]
>
> > +/*
> > + * Reading CLIAMSET returns  a bitfield representing the number of claim tags
> > + * implemented from bit 0 to bit nTag-1, valid bits set to 1.
> > + *
> > + * Claim protocol requires 2 bits so test for highest bit required,
> > + * bit 1 -  CORESIGHT_CLAIM_SELF_HOSTED_BIT
> > + *
> > + * return true if sufficient claim tags implemented for protocol
> > + */
> > +static bool coresight_claim_tags_implemented_unlocked(struct csdev_access *csa)
> > +{
> > +     u32 claim_bits_impl = FIELD_GET(CORESIGHT_CLAIM_BITS_MAX_MASK,
> > +                      csdev_access_relaxed_read32(csa, CORESIGHT_CLAIMSET));
> > +     return ((claim_bits_impl & CORESIGHT_CLAIM_SELF_HOSTED_BIT) != 0);
> > +}
> > +
>
> The logic looks good to me.
>
> Can we improve a bit with a cached flag to avoid every time checking the
> CLAIMSET, we can read it only once at init time instead.
>

When I considered how often we use the claim tags - compared to all
the other programming of devices, a single extra read did not seem
excessive.

> - We can add a new flag ("bool claim_impl" in the struct csdev_access),
>   by default the field will be zero.
>

I considered a bool - but the correct place for this would be
coresight_device - where we keep all the information about the
hardware features.

> - The drivers support claim tags call coresight_clear_self_claim_tag()
>   in probe (see __catu_probe() as an example), we can call a new
>   function coresight_init_claim_tag() to replace it, this function sets
>   "claim_impl" properly and clear the tag if supported.
>

I considered moving this initialisation to the common coresight code
where we create the coresight_device. Certainly with the new check for
number of claim tags it is safe for all devices, and there would
appear to be no reason to do it as early as it appears in some of the
drivers. However that would be a larger change.

> - Afterwards, simply check the "claim_impl" flag.


>
> [...]
>
> > +/*
> > + * Coresight specification defines a maximum of 8 claim tag bits.
> > + * The precise number is implementation defined, and may be obtained by
> > + * reading the CLAIMSET register.
> > + */
> > +#define CORESIGHT_CLAIM_BITS_MAX_MASK        GENMASK(7, 0)
> > +#define CORESIGHT_CLAIM_SELF_HOSTED_BIT      BIT(1)
>
> Now we only care about the self-host bit. Can reuse existed macros ?
>

I feel that drivers should be written to match the specification - the
macros above are a correct mask value per specification and the
correct bitfield comparison for the MSBit of the protocol.

The ones below are a protocol masks field, and a specific protocol
value that is used in value rather than bit comparisons in the
claimtag code. I felt it clearer to differentiate between the uses
when reading the code.

>   CORESIGHT_CLAIM_MASK
>   CORESIGHT_CLAIM_SELF_HOSTED
>
> I don't mind if extend CORESIGHT_CLAIM_MASK to 8 bits and even remove
> CORESIGHT_CLAIM_INVALID (as it cannot cover other invalid values). Or we
> can defer the extension as needed later.
>

The invalid value is used to as a value comparison to check for a race
condition with both protocol bits set.

Thanks

Mike


> Thanks,
> Leo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

