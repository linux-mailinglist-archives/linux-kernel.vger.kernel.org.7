Return-Path: <linux-kernel+bounces-830093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686AAB98B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD3819C78D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC228314A;
	Wed, 24 Sep 2025 08:03:10 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC761281370
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700990; cv=none; b=mAk28ldlw84W/elqObjHEWm5tQv4DwnBcAHLnwLsqArkMr60d+QSSthoQpHoe+wuvDCVFfBQfL1FIyG8RrqG9jJZdScpQUXlV5QHmdLcANIdDn1qst75EP54LGfleSWkkmIA6RMLFW7HPXzr480tbtl5KS/KCAqZQHhJsaQ52nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700990; c=relaxed/simple;
	bh=OcHtj4Ufk8ypmuZRK5EQN7WQ7NBHtAGlR0tqW0SRk3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJbdnFsH9jVqz1fvd0fnsjLaKLSJVcQTBhgwjMeh1WOrEn9Hl7FQny4/aDiK0E0406FeKfUEMqQzTfjSLMqjTi1l/dXQEM9/mfLuWcCEbcW5nvAeuKoUGlKeLubmXstGc3LyR2Z9GKQwb/gMgfEUZvgp9aZIBuXQzu6kaszZSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5a392946c4aso1650781137.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700987; x=1759305787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG/1vYGs3+fuqywYG6UuJwna6J76UW6FbhxCIwoVdYk=;
        b=eU/dhAYsLHH2Ub7XY5jHS7hYXOLpz1danKblaD7k/LIstNcw5+QomCwMJGcdVQSo0M
         ukU8tGvJXnQrs/a4yRpO8ChkaFQ5+9NuusSFxOaGG37Nvrlikh6EuPngBC/Rt9C1nAIc
         bvps3M00KSa9cBqZ/fftZMgtaRLKdIX97DH+TzDWzAWgGnqtzSrrmwbAMUernFCmo15S
         OW9ZlWad3g2vsO9Kx96effeomUWcXJ/Zpe/k6C4TMDsvSgbwQ2d4zPQuEuqqtZqjBxuN
         nTOmN0hnPeU32CNJbl86Gv0ikAG+OtBH+aovmIsp4fblmSvLnaK1i+s4ln0liqAs6DAu
         15SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSOYZtHg3aViXHroWaMHkUQHCXKcfPFk6iVyMJqOQLEwTre8ylky8A1Kpn9Za5i1nu2g68RbXxPsMY4NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJyrOnADPhYONHcSudrQladPreUM8vN3XCcsfwJ8JdtffPvtd
	J/J3U7anpfD4hmGitEAAIC6IuZZoAuVAnTSRg2NweauZIQNkPQTkTOEI3hZnA5BH
X-Gm-Gg: ASbGncsWv69EzsU1Ovct25RY1n/WERI9C2IBLiPfVsFYPmC59QX0dCn3rt3ITkT3D+b
	OrK2vYww5P6vodLChlvSwl7JcB9jrc50EyEwl+FJBqfuIaEwHhy5kJnkztxf6ymqT7kcETxZFo5
	7s+NIWYH3d5nIrI2LQpgHbFvtyy/611rTaQSiV8Y1IANSfQGoBllYCCUkSgzO1go2OyRAU3WM+d
	5yxxRZfIPCsHDXQylWCcLmUvtzPBKmCOe/mhSLrqP7ShSrETgPd/zJapC3UAMGvPbEDSzFEE6hi
	5cV60JY+eS3WG0hyWZwsxApCm2AOJAD0tOMMKvRq8M1SBmnh8yUZK1CD0+melnXpOZ48BNqUL6t
	cbmQD6mWwHFeEF2SgBR/kjyesJnrRNXY8dxn9uiBDpr7gMdK/WN6FTWyOjA4M
X-Google-Smtp-Source: AGHT+IFne6d0YmITSpj8F1OqpAmzR5AL1Ri29kj6dn2CYVfy0YYqW2B9q3lSwi7DSzn32NeajwSLMw==
X-Received: by 2002:a05:6102:5815:b0:555:ef1e:49bb with SMTP id ada2fe7eead31-5a5785b97c6mr1642964137.21.1758700987432;
        Wed, 24 Sep 2025 01:03:07 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-57a1b3d226csm4631116137.16.2025.09.24.01.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 01:03:07 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5a392946c4aso1650763137.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM9rKU4q8utyoIulOOPhvujojGvawTnNWZsmzStw4PkDRvUElw9Hgbw3xQtPhEUeIHcBZvUcXuSbHEkDY=@vger.kernel.org
X-Received: by 2002:a05:6102:6890:b0:52a:ef9a:cbef with SMTP id
 ada2fe7eead31-5a57a2e5015mr1830757137.35.1758700986150; Wed, 24 Sep 2025
 01:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758181109.git.thehajime@gmail.com> <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
 <m28qib8g1r.wl-thehajime@gmail.com> <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
 <m27bxu949d.wl-thehajime@gmail.com> <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
 <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net> <m2zfak7mnd.wl-thehajime@gmail.com>
In-Reply-To: <m2zfak7mnd.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 10:02:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-417mPdhx8VzD5HK+OBzR6wOwgve7TQVaDB=B1ACQhQ@mail.gmail.com>
X-Gm-Features: AS18NWDjzUUYN1IH_NRSUgt7ztz7YMlPE3cxQjph-t1F9aMXgPt3FYPP6cpRC98
Message-ID: <CAMuHMdW-417mPdhx8VzD5HK+OBzR6wOwgve7TQVaDB=B1ACQhQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, 
	ricarkol@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, 
	arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

Hi Hajime,

On Wed, 24 Sept 2025 at 01:51, Hajime Tazaki <thehajime@gmail.com> wrote:
> On Wed, 24 Sep 2025 02:13:47 +0900,
> Johannes Berg wrote:
> > On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
> > > > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> > > > so we cannot select it when CONFIG_MMU=n.
> > >
> > > That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
> > > Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
> > > dependency, perhaps it should be reverted, iff you are willing to take
> > > care of the casual breakage?
> >
> > Why though? UML with PCI can't really be a functional thing, only a
> > testing thing, and testing PCI on !MMU when that is actually impossible
> > in non-simulation is pointless?
>
> currently nommu UML doesn't come with using PCI except building under
> kunit (ARCH=um), but I have in my mind to use it under !MMU
> environment, so would be an option in the future.
>
> and this series doesn't include PCI w/ !MMU.
>
> so, I would propose the modification to revert the MMU dependency when
> time has come.
>
> btw, what do you mean by "hard" dependency in this context, Geert ?

I mean the PCI core does not really require an MMU, and PCI in-se
should work without it (e.g. on Coldfire MCF54xx).  Arnd added the
dependency to avoid having to deal with future build regressions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

