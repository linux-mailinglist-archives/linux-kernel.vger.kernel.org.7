Return-Path: <linux-kernel+bounces-844474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF342BC2038
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A236C1883433
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072272E62C5;
	Tue,  7 Oct 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUr1OLHD"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93A28F5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852860; cv=none; b=nKtUJrtxElIBBkay5X4TFyaXpmLL1Qluap8ChRp6jhkPX+XF/bne0cw5X7f0484foFkf5PZ70BB5fr1fEFNPjcSfy8cc5wo2nDkkvaKKq1PyvUK4wI7zO81EfSYZ8opqt6O5Y+iU2t9aankqXUV+JzlfobEqt3eRLxjOLeEq9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852860; c=relaxed/simple;
	bh=UhgytRLOyS3hCQk4EtSBmoNYOwXz+DZcc8HqVtr80gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oysxRtcTi+JmVhjz6sok4geoNzeBTqdmX7BsgrkO4PJQ6eBwwlmnadsudC4RwNtW8233sxgtFwSjxt7QrGptJ06GRPF9e6M1KtXcN8+/iLRfV1Hm5z0EJZrvfaUKEBQiFc6Lufp8kjJ25+uhL4cqP3QlnNH3ZG5E0ERxe+l3cTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUr1OLHD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5ca0345de8so149451a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759852858; x=1760457658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhgytRLOyS3hCQk4EtSBmoNYOwXz+DZcc8HqVtr80gY=;
        b=KUr1OLHDxZQh2kyBrwkYl7EIsITy+4NY8BSFIIw+2h0P+t7bzh85WX6HEvhlmtWUkp
         f6AHxdNtVtTCMZioqFZZn0hancobF/CZA9JlOetMTQ1cyflL1DGXeNk8sLWlKAGmdtex
         Sjna77AAaoa0ymwRknoaOlvVN8tr1r0jkVGygDMRV93agM6SjaJWFjcD+Ti5tUQm2pKe
         gF8wP+2t2O6BaGE7ADaDbdrnd2cwprOhe0xAttfENoOqk6YvP7st4mHHazpQ9f3iRhZz
         X22r+oe79+FFpnAFSyTkGu6hDLxnf9jNvSsMuoPdbdwdzTSqBqPlOFpHkdKF5vMcvlNr
         AJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852858; x=1760457658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhgytRLOyS3hCQk4EtSBmoNYOwXz+DZcc8HqVtr80gY=;
        b=bLUM+xjfVrbunPX5OFHFJ2x2SS3hHVJzPREh2Hr8bEZYgVjvDbqsC/YfPEMQGAp9LA
         sYr9tT8b1k89QIiYfWaFehhQcVyz+o8hjb+gJ7R2tI7kuZweaiCxoAPAOH04lmGHOkMG
         GFcNGsIKp3iVcEIGQIOyIwO/zJMFI1rvHFB5tuFAZLhFX8E/y7Ras1JzYcmBuybMMOZk
         hSgWdDytowQQS9ntfOrIp2qYkK5XDx26tKeD0GtITOjXNfUqMD0dXcJ+G0HPaCxAF6+E
         d1f2jBNbW6rwjINJtReULcLw1DfmXj7q2vJGILLdPi1xvyGSyNRG7K0yRdxW5dNd9sxY
         2BRA==
X-Forwarded-Encrypted: i=1; AJvYcCWEiJs7D0ZD8Buy+xzp4z923t4kCwIBPvFwYtzyLngh40crj9PnIvvpxHA4KKuj2JaZ37b0NBbPGEU3INY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlPNemYrjcmM/n5ms4a50Ro5yjYCvF+d3ni7MDGKrA5reANGs
	oscBDzgF/ClORcrgzfuNHMoQqcqT64RHpBRZPv06y7dA4uM58sD7u6dohwl2fYJNaon3/6LXgNG
	i1up7MNL+idsKfSzBVGyBG6We0JmRUjg=
X-Gm-Gg: ASbGncsHKkz9RfJ80htE1egrctnKYAxZz6MDPInVKa2HSXP/gTsmDuKnWkEifRWwHdR
	eHUuAIqgRdqEBorvIQ8g7lutcH04sV4r9aJPF0LqWuWzNJP9m6XNabKsm9QAThuACG0WjokvBMn
	sd6Uu4Jxo2146cyD9sAPL+LFxRCircNSaAAIDMfXqtF5QMsXYLB3X6A8mHkIk2FcI1ZY8eAtuuy
	qRRvyrwZRX+10LC41kZsbPIykbGEVt+3AHHSlNi1NEgMCyKz9qaM2Y8DoyDkuo08jz9h6OHlV9+
	yGt++yg9fCbGkeAm3NH5FJiNEQh7iO3mLHMN/KAXkkq9lsM0gQ==
X-Google-Smtp-Source: AGHT+IH4tGyYQPMhvTVVU0c9hxyO/+PMT0ig3tMkWfv4p1jOmswuGw3PFIIMVsTxE8zFxZcdZBMRyhhFxtXbwI9dROs=
X-Received: by 2002:a17:902:fb8b:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2902743ae8fmr1174585ad.6.1759852858237; Tue, 07 Oct 2025
 09:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-kbuild-hostprogs-werror-fix-v1-1-23cf1ffced5c@kernel.org>
In-Reply-To: <20251006-kbuild-hostprogs-werror-fix-v1-1-23cf1ffced5c@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 18:00:44 +0200
X-Gm-Features: AS18NWBgTA_EOmTTrmWAwfTi1AYG4D_BAJXLgkioAaiDXiK3SxQfHsilJf-oWcg
Message-ID: <CANiq72kZjOwSerDEM517uEVffGYzUhm2Pb+1z=7hboJKuQwBMw@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=e
 for hostprogs
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Askar Safin <safinaskar@gmail.com>, Sam James <sam@gentoo.org>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit 27758d8c2583 ("kbuild: enable -Werror for hostprogs")
> unconditionally enabled -Werror for the compiler, assembler, and linker
> when building the host programs, as the build footprint of the host
> programs is small (thus risk of build failures from warnings are low)
> and that stage of the build may not have Kconfig values (thus
> CONFIG_WERROR could not be used as a precondition).
>
> While turning warnings into errors unconditionally happens in a few
> places within the kernel, it can be disruptive to people who may be
> building with newer compilers, such as while doing a bisect. While it is
> possible to avoid this behavior by passing HOSTCFLAGS=3D-w or
> HOSTCFLAGS=3D-Wno-error, it may not be the most intuitive for regular
> users not intimately familiar with Kbuild.
>
> Avoid being disruptive to the entire build by depending on the explicit
> opt-in of CONFIG_WERROR or W=3De to enable -Werror and the like while
> building the host programs. While this means there is a small portion of
> the build that does not have -Werror enabled (namely scripts/kconfig/*
> and scripts/basic/fixdep), it is better than not having it altogether.
>
> Fixes: 27758d8c2583 ("kbuild: enable -Werror for hostprogs")
> Link: https://lore.kernel.org/20251005011100.1035272-1-safinaskar@gmail.c=
om/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

