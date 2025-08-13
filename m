Return-Path: <linux-kernel+bounces-766778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42986B24AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D195A78F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39A2ECD2F;
	Wed, 13 Aug 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmI0TM+L"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBB2EACFB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092651; cv=none; b=BZmgJllX2+xfRm5CVC5fcEDe8cc4NKPnGQpvBGzYhaFx0VpUjYZwLG4Z1Euph/3FZ50wdYCgPLIwszjeQ8+C3SrQ7btwMnSoLjcVf6Q4WsMiDuZ/gE+KQY+HbcNuscXpxHl3DkPzZVSbDVQAYOzNGvWoYjR6DTmke7CscKR1Dww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092651; c=relaxed/simple;
	bh=pHojtpD3YB3bImqUFSr8KZ9T2OCJ8IHdeXOjUzwksWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDNxJh0dujAO9NR7KbyjJkRiGxQ9jh57jR9qHBVGph8r6/ZKnvY9Zks2zeUmPZx9KwrNwAi2CGmlkg9mMDDf7wEiBGStqxXi49cVz+GqT4SCDTjS/MFXpsfixaHHToGGXMOnOLm0TIs+BZOaRTlz/ZuIg+i3NCzAm98QFgEwdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmI0TM+L; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ca7436450so2068755fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092649; x=1755697449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eihVYJrWZXZh50n0+ltviNDHEcxJdrJFasVcbGTuMaM=;
        b=UmI0TM+LryQ18vaonvGnmaUUUfgrK+nuO1Lhso/Ch3ka0+7cIqkVh9q1m39A3bKnG8
         +PlZ3rD0d5nvmv2KANAdT71OFKxHUb9vrjBEoyOoVnv85aIoVVInZ8bn7mFtF+g2LdLA
         C5RGrGgUmw6yhjMf4HHulMK94a2zoUeT1obfO7S7Asc9qDOvRap+gTrZTRdNzOFEFAYB
         TbSFnNPtV4YoGwQvl4CLs3xmaWwFcyNmSlnoYatF4hc+bjfe6MwkFVYEo+wuXxFzSaI2
         eWX0Q/MhCB+6XSyTdnhz8113QOvDp2kM5MLv9AeH5izABWNNToNRCLhW63h/x+aFNHh2
         lzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092649; x=1755697449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eihVYJrWZXZh50n0+ltviNDHEcxJdrJFasVcbGTuMaM=;
        b=ump8akelqHaOSN/i1iMfoZ1nsxh7TaApBFnzVYrKsIlProLLOYc0AmYviMl8zxjLkr
         pJGtZ+CuInc2An7zeevvAWYry5vVgqLAG9OxIRO3mmyhxvVEAkVS3mghbi294ftUh8uG
         0HzAkhhKnLbI2koRQjcFWPhR9nuMqoRZHybkcz8GPj3vRS8DrSM7mi4Zy5ugwqocHKmr
         jkzyoMjbkGxFlQ5ib99SRk+KSa9q0ARWNIjf3YtR3nkVo3Ki2GDS1cmoFZF7CFefv5qO
         EYeBeepWpMeYuzPNTC7ofAROjOeSS7M50Dn+Y0L9UFX5QU5t22xo48KsTDPPATjiX1z2
         rulQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJHc89M+4PmmRjwflNzu9gRlTJ7OLctHxXWiXy9WSXnIFaoeiV2KdTHjHGC+r9HRmEtSJ3VnkYGaOynr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCy74KBbLZHtEDq/3gRbhjFdwMoVkojz02MzM6O7erjVcmGNfL
	iI33yoXmQwUgAbICRVuY7WvFnJijGubv71q3NCdAnbtMeXJ6/5klycW108/fJ9elIYLiNyJcYJ6
	On5vfcKOidpKJxm77bwWdqxXQlSEYRigVT07P4d/EgTeNqujuUb9/6qE=
X-Gm-Gg: ASbGncvUkbHgsOhPEJBMAHlYgxsM5KCoRY3B9q2+t5AOZtRFiZdUJU19MOB48wC8zk3
	4WOMjfXeOlTvyfrynhex8QrVZ9DJlQQvUWw/BH3HRJtO467WMQQjPNS2j3vYsAIzclpJjP6RhrI
	J/bAuzZVCFt74IZ9rs6qG4ceNq1VJwrAAEPs+yDGqkSEquvx3xOxajzOLTJNxECvwtBe1xH1D+M
	hZi5LNQSH4BjK8IbcA=
X-Google-Smtp-Source: AGHT+IFU/NdbN7AcOZEv17USCBNw7GfCExUxIp81La73W0v9orSy0kbUcXLAKbnNYawjG6YyllhAALem09uD1POoEws=
X-Received: by 2002:a05:6870:9a1c:b0:2cc:3e39:7352 with SMTP id
 586e51a60fabf-30cb5bf9975mr1878664fac.18.1755092648901; Wed, 13 Aug 2025
 06:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801235541.14050-1-ebiggers@kernel.org> <aJmKDyD4weX9bR0U@sumit-X1>
In-Reply-To: <aJmKDyD4weX9bR0U@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 15:43:57 +0200
X-Gm-Features: Ac12FXw5rXcIObB1VY8YLwwvPYahf_MM_W0QzWG6bpFq_kd5MWctpI_dBq2BBok
Message-ID: <CAHUa44H1V0qR7omO8KpNxaW_bkXZAbaka=8r-zp+f6vdYs6fQQ@mail.gmail.com>
Subject: Re: [PATCH] tee: Use SHA-1 library instead of crypto_shash
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, op-tee@lists.trustedfirmware.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:13=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Fri, Aug 01, 2025 at 04:55:41PM -0700, Eric Biggers wrote:
> > Use the SHA-1 library functions instead of crypto_shash.  This is
> > simpler and faster.
> >
> > Change uuid_v5() to return void, since it can no longer fail.
> >
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >
> > Note: this patch depends on the SHA-1 library functions that were merge=
d
> > in v6.17-rc1.
> >
> >  drivers/tee/Kconfig    |  3 +--
> >  drivers/tee/tee_core.c | 55 +++++++-----------------------------------
> >  2 files changed, 10 insertions(+), 48 deletions(-)
>
> Nice cleanup, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Thanks,
Jens

