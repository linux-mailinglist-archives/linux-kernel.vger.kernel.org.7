Return-Path: <linux-kernel+bounces-744759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5CB11090
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2DE5882C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8AF2EBDF5;
	Thu, 24 Jul 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia/n22HQ"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B52EB5D1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379866; cv=none; b=QRVdtdLwgBuifmWc40Nkiy/d1i0mSXnh2/WEWPMj6gua/j6pNmocfHA2sO7wfy6LYc/1pxPodMQjEY4yuf/G1Dw9pOMJEISjRIemJ4dghMmLovqrTXcVaG3XsS/IFxeYa+lbeFeov0SH3RzPLXSKP35WFxiTD/byiq0X4pvZsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379866; c=relaxed/simple;
	bh=sAvbEdu6tyR7YWYvjUUOb8ahCP8/eyDCdpGxnthD93I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAothjHMxguGCzVkzTESfOIiAL8NjcPoW9h+DtV74WDknWmCOsjqL3MbFuEjn8glmM31x5QMRrPAVGzhi7PK9HxSlIsbU8c8qtboH4mn6IUWuvUrOouALtUoXCHxDb+aY3qTPMdXWkXh37ig6P3yF6BUvJggDtnOw4MEfhAE3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia/n22HQ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ffa81b41d7so693986fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753379864; x=1753984664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyd0m6/llDOLqTKGKBUszI5BSryEijFnil6SKX904AM=;
        b=Ia/n22HQGr+xrn+xwvN9u+G4d+UwtlbmmgBrPVLFf6OsYt/vKcKoziSSjU/P+Z4Ik4
         QQYzY3K88d+hr73XIcC0jUBDq4KG9FuyvLD6haaO6q1kmKpT/fUZgeynSqdrojEgikjR
         XMLxya2BG8/v8XwzpM8ftufBdS24NV5hftUKre4N68A83vhU/XrWs+FpaIMX1hlWaT73
         3KLgw8412kTR6l4nSoN6KZJlG0iHyaLihGILb7ymz23O26ZfOT/aMMuMZ1dSPRNzUS8X
         2hEgbYGEJgnFWD67gs+OAj3/pOs6YNrROSErlbpFrA0KbE3bt22hxQapWx33iVmFi4DV
         zTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379864; x=1753984664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyd0m6/llDOLqTKGKBUszI5BSryEijFnil6SKX904AM=;
        b=A2MCqv+It+5MdULwNTVak9NpwTtCM37DMQzwuyB3PBE5h7KqN6UMv9pC4MN8bTwnt/
         qfotfeHP25/kJHvOlHH3+jlMRpEXFLJz/IMEFue7+t1Ed2LgmxdkJyYCwZZsy7PQCKs8
         udJkXaS4BiU7RyhCGhMuAyS5rjefHa4zksv8ND4vjq4voIiU+946dF4iRZInzgawjcjQ
         +dx1sRYqIS5Ztzut62f7WU8LNBnQtyqF8geGKpSLZ/CBVKwPuqnmt0L0jq3BL5k7TV9y
         QiK5ptRgODPngz8sJ6XEvdW4ROdBQHOPyErs5c1r+Zf8LT4fYNK9pZelug/TPt8A+7Eb
         cUQA==
X-Forwarded-Encrypted: i=1; AJvYcCWPpMvfIHwvRb4O1cMjv7qjgPs2U5LynJu6fd+MAAB5wsZp8onTdDxg9cYhJ+95Teq+kt9BnTbOePf5UTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoVd4OJsLlLLvDvV/pL9R82KsaZ5fzqgAhAnh7QXt0T/So7RP
	WtPc9Txc0KBaxUeqaFmJPQUJHKBT3IqiKIN+9H9OGkUAzlDbuvUABbyTJdc9/R0cyIzzRaETQNT
	etgxCihFyuWwv0SzzTmouO5eUaTU/EoY=
X-Gm-Gg: ASbGncteLbZVyf8SreGRf0441nfMX18AquUAttnvuWDePEPHTWXgUvBhQi4xInd4MwK
	nDXNAXuh07Vuk7sM7Pm0KUjuSoYb3GyH+3wPMvgkRj+RofS5+GWLJcj5yC54DpiNuvDj+nUFJk4
	+kyQZrt4FHEd1Bvq6g7iVICw9S2OvPIiESyzB1dK8Jc9v5IDLs0oEPKivvzm8EzxSTTxOtntk7L
	qFQ+xXRBw==
X-Google-Smtp-Source: AGHT+IG3/GyCL+VU5AJJltRsP0Tqqxq0Yjumuw9YfIJLpjiZLw0Gf28GIuEQWGeaaejWHUNBndHaOx9Y7PVaKw3h+ig=
X-Received: by 2002:a05:6871:56c2:b0:2ff:b276:97f5 with SMTP id
 586e51a60fabf-306c6ec5c4emr6012951fac.5.1753379864254; Thu, 24 Jul 2025
 10:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724172603.18701-1-suchitkarunakaran@gmail.com> <aIJxVDBXyFgrz8AV@shell.armlinux.org.uk>
In-Reply-To: <aIJxVDBXyFgrz8AV@shell.armlinux.org.uk>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Thu, 24 Jul 2025 23:27:33 +0530
X-Gm-Features: Ac12FXx7y99oCagbZGmHtRkYJYdYeVHvbVt_84oh7Yoa7X7XzSgt_3Uy39Ssjzw
Message-ID: <CAO9wTFitMEzPXNqrMs7U=+M3jAghZtO1iXYbw5YBL1bwpB_Ecg@mail.gmail.com>
Subject: Re: [PATCH] arm: allow single CPU configuration by adjusting NR_CPUS
 range and defaults
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: ardb@kernel.org, linus.walleij@linaro.org, ebiggers@google.com, 
	nathan@kernel.org, lumag@kernel.org, dave@vasilevsky.ca, 
	ruanjinjie@huawei.com, kees@kernel.org, liuyuntao12@huawei.com, 
	linux-arm-kernel@lists.infradead.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 at 23:16, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jul 24, 2025 at 10:56:03PM +0530, Suchit Karunakaran wrote:
> > Previously, the NR_CPUS config for ARM required a minimum of 2 CPUs.
> > This patch changes the minimum NR_CPUS to 1 when SMP is not enabled,
> > sets range to exactly 1 if !SMP, allowing only a single CPU setting and
> > adds conditional defaults:
> >     - default to 1 if SMP is disabled (uniprocessor)
> >     - default to 4 if SMP is enabled (multiprocessor)
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>
> This hasn't been tested. NR_CPUS depends on SMP, so if SMP is not
> enabled, then NR_CPUS doesn't exist in the configuration. Therefore,
> providing a default for !SMP is meaningless.
>

Oops, I think I misunderstood the intent of commit
278d1ed65e25d80af7c3a112d707b3f70516ddb4(cpumask: make CONFIG_NR_CPUS
always valid). And sorry for not testing it, I wasn't exactly sure how
to test it. Could you please point out the issues so I can fix them
properly? I appreciate your patience. I=E2=80=99m still learning my way aro=
und
kernel development and trying to improve. Thanks!

