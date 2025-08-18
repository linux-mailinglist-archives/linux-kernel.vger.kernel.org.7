Return-Path: <linux-kernel+bounces-773959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E48B2ACE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CE01B261D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580525CC4D;
	Mon, 18 Aug 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVj9yUO3"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447E25B687
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531149; cv=none; b=nJjZCbLzN/DU+5jQokHCtyLvlFUfCZtaVrERNl6taGrbCLFGdQXqwO4x+eSBlUiZV5cgw3r58UdwiMi90WwCeX8QDMFYkbi5V2efr+CXQUXPonla4lMLi6DHCDXL7XIA51XV/KYRR24dwGiRRZRurPwYEt857f3Z0rGDBPPW7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531149; c=relaxed/simple;
	bh=icHVjjRqRhE4oRabHZs6Zl5XfsDtmtpgy2tt3jycgLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENOwpkfy5B36Ur9tAkxPIjOE/X/NweO3La+HRtyDMIVBgdkFszjYrzXRAW7o+9U33cEtKyJ7hE8JxOqgMrfEQ0jFid6ziZhi4XqZBLdXehA/tPjxTOAqzVJrNpGYxlnHz7daJ2G5+/s4VOpy67vaSUrV5z/ys7Ny7cbV7avot64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVj9yUO3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f7ebc44dso38654431fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755531146; x=1756135946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icHVjjRqRhE4oRabHZs6Zl5XfsDtmtpgy2tt3jycgLc=;
        b=cVj9yUO3/YBoYVQlOI/0T9GXa74iZCsKgxi5pjY6xptA17iKOYJuA1F4fAMZsCln4j
         DyEhag0TlpExgZOh+hTcNlNPuUQVwC+fFGu/UsYy/SIZjLM4uu5EFqMJ9HrEHAlk7Z+I
         KDJ6ofGtsPCpFWYxuX0EofVIv7samzfy9Nnamlw9AtCilekIyBbXh9SHZsTTyOoE5nuT
         0fi7QFIw+Y5BmESCSkpqVmrx4rTEi1g0bcLdbTLdgSIhnJFV1yS+yRE7mbTV/mc+xjxp
         0bTg9bDP+fUGMzfeInRUKhHeY58lWnOlkkBLTpRaF1ZtwvmjRJBI3M7wDQzJkxeuir6b
         dKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531146; x=1756135946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icHVjjRqRhE4oRabHZs6Zl5XfsDtmtpgy2tt3jycgLc=;
        b=LWqMOZ+yfNruBPMWmyjXzFS30q+huj9XxZAr1v7L+LxFXgvZZ4Z1K0HiZM6RtopInA
         3QHEtu/vl5Vw1Qm37XmS5YQkzEjD59kvOjQb/5XcP342b4jbR0pTgCv9kZLsL1BzeGu4
         j+JphDamYrzHBv1mtprYerSZWbfOVuNr4uP+vt8idgcCrczv2qg/CH3fuq9PqvyMIkaf
         JPYPCIU8fggSN3+jtjr5VMh8xAFLUPpNez14vYDnbfw1gxCfBnijXULLyOkJhj0vHMR2
         OigV9uxaiPvvh7HtZXF/aQ8EpL/DEzx/O5GoP99KI6lV84bKJXACtKhPjLkdXAHJvV24
         WT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL/mesjixIDee2owblJRpesgE9K1P7vB2ITCyOHHSJ2nwygpletdwibZ4xOZeapxnhTiessEobyGvfBtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRler6KwoR9LrIu7AoZb48Tukk2eBOckYFRjSkdv2bIlWnm1u5
	w95YatiJ0KiQBI+gRkPi3VIZn2m+Zs9csTodSZiCYGI2ljc546vGzmmu4My3IboJcWworwz9Sh8
	RnHbhZiqkva+MKXn5ZUq8ap5qDy4aUJolAk8q5+69+A==
X-Gm-Gg: ASbGncut8ImxImv/hdQ6DcDiKJNBu5P5fzlhvEG1YlgUjF8ljoIol0JtLc/SwafPpR0
	ZvfI5e7yseM4y8GGG+coVWuZ9sZgyGjT26ZQUPiuPyYvep83cOXmldwphXheSx9X95PNGHtY48Q
	/ZkHhe4iBBUweUxtWav4JPUSLYBosAKqNtDOcvHKUeHQpxx/l7Q2nZJkiaCDIIuhoVJ/QMyOQZH
	DLB9k7U4dbE
X-Google-Smtp-Source: AGHT+IF2orySIXmfTMPdBSc4u2RQ20PPwC0pgvdtHB2BTHUvv++2TxJJ8Foeb7eufqZD9BSVyHFIxOKmcreERDkEtzg=
X-Received: by 2002:a05:651c:2c6:b0:335:2d26:1408 with SMTP id
 38308e7fff4ca-3352d261634mr832931fa.21.1755531145800; Mon, 18 Aug 2025
 08:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813081139.93201-1-christian.bruel@foss.st.com>
In-Reply-To: <20250813081139.93201-1-christian.bruel@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:32:14 +0200
X-Gm-Features: Ac12FXx0vB3mITr0yHkMZRFX2ygTlke86KCizQFy_D1MbML6oINtiohhGdzjiEU
Message-ID: <CACRpkdZGaMf1m9UK7ai3KLJBSJtWJagzMMa6icMxEL04w7fkMA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add pinctrl_pm_select_init_state helper function
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: corbet@lwn.net, bhelgaas@google.com, mani@kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:13=E2=80=AFAM Christian Bruel
<christian.bruel@foss.st.com> wrote:

> Some platforms need to set the pinctrl to an initial state during
> pm_resume, just like during probe. To achieve this, the missing function
> pinctrl_pm_select_init_state() is added to the list of already existing
> pinctrl PM helper functions.
>
> This allows a driver to use the pinctrl init and default states in the
> pm_runtime platform resume handlers, just as in probe.
>
> Additionally the missing documentation describing these pinctrl standard
> states used during probe has been added.
>
> This fixes a build issue for the STM32MP25 PCIe staged in the pcie tree,
> id 5a972a01e24b

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bj=C3=B6rn: Just apply this to the PCI tree.

Yours,
Linus Walleij

