Return-Path: <linux-kernel+bounces-842730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C1BBD696
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF018929AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6A2652A6;
	Mon,  6 Oct 2025 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfhYAq9E"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF8405F7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741757; cv=none; b=l/mtnSASdkqg8Nxyw0q2v/v/uS6JtuuuAsSzFvy1WbDpGHISBAbEQZcpHjTMaapvI8TXJgo/0rWhUsenqXc0x5Ql8ic1lENjUgsXXbMEzk8h8JhtNaG3hkPnkWlZ8FKCFdAjHs+wi1BvKNOelnCvyKBGfr6olH6D4zJy+4o6IaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741757; c=relaxed/simple;
	bh=YUML59aU/N3+IbVvbU/UOdKZI3EV60PQbP6/evD74E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXr9mwyM0g/OMlimoMbKOr9grtb02PZ3Lmk3AAiPkI1UrOP0XWHQB0IH6E8YzkPt8iBtmYEbt4Uvbwc6Mdy8AcjfP4ddlP8UKli6+A8QMvGh31qZIbiwqNZSdTZbOkV26Nhv/dD+tDKdsc7rFh3Mcw1TQLNq8w1+9T3o2l+hd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfhYAq9E; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-362acd22c78so44291221fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759741753; x=1760346553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsBznNRluYQ7XuvPEjh0UKcnKpWDk6R9qa4Tp3O4MNE=;
        b=jfhYAq9E3u5E83TByg1dhbbqEhesDPLoXiQCuaCLHLi8287LudI6vTh3A9XYZuDt47
         RKCrLFVCQe3b7j+xfyltX0ogCkZcFEybopo2MXgoYz2WUBKCadbG/K0toJHUn7kpTtni
         IscJQ68inR01E7bLAEnH4Od0pR++k4AVwpdNVe+piMAbT2vZJUXSuV5wbEYspwDbDQR0
         AimawTEtcr1Wesi5wPsbOZUtXFRjwoS6r1Ye0O93gLIFu1NEk4gYqAr3EM0c91tK2bv1
         MP0rmf2Kwhb59+YcoIfTS/EF48XwUBqTCT6FXPeI9JOVhoy27gm1WrfkldN+4ANMe7Bn
         bP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759741753; x=1760346553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsBznNRluYQ7XuvPEjh0UKcnKpWDk6R9qa4Tp3O4MNE=;
        b=iUhhvlC2EPyCCVrb77reo404DZKZ6ntqT3ukicsjqTQ69nOFbA8s9ASnYyKUWdcM2f
         D+6MSwJXnINS3qCusO375khUh33ny2U6afzHnmLqqOY2jGqd6GpL9viZ/choP8Z/eLXv
         KNHXDdDB940ugtCH+YeCBWrRTwRGf/p+WbCUZyqdJ72UhjOHXT6SkaV8y109E65XU1n5
         KeKQ6O42oXglDF6ItIivW4/edCQbUsPtpu9AI5LGfig2UhKalZukSut53N5a098WSVX2
         PwzU2gGq1sykTua8LhVyfTGmkfsHWe3VRgmCd/qKSLoGdf9J4tFmPOM/raelhA1Gk63R
         +l1Q==
X-Gm-Message-State: AOJu0Yziy4NdaOATOweyZSFEgHZrFub5UVnlt7nzjHHw0wty2QYZkwe5
	Z8eu8tFa56xAXi3hRliGnfJ8L1TbhAAS1uJhYa0MDKdNUAEkC7229YrsAfOSLdAiDbRMMGdYabD
	joYZW3GMu3csbtGzVTudIPJh8jdVcsQOftJ8HRqs58gfdHoEJhm+CpXA=
X-Gm-Gg: ASbGncv9QNZO/iIGvamFyFwgN5fiFVf/PhHSpLptezIBzZRj6AhBcpc4K+1+0J3S3CW
	W7hno+uoVmHZrth3jOXamtFr+H1n3q4Uag7a8DtfhrIlQWe6fxuAW5N1WNBEFbpX2HazUGbSPJi
	OhlZlEAbo39yM/THZ4Op3NnQ2hbJlL/y3XX2ueTPuNToVVlSnEfn7ypRZvQU5iv4LwyZHaIiYx7
	tXHzGXGqX5YZeA3TEF5b1luE1kPymPwdHQOdwm9aS54Hw==
X-Google-Smtp-Source: AGHT+IGlucg01F+gb3JV6UjaZGrg0qXUJn2hTGyuFhNh31irV0HP9JR68bNyp4NxLCV5GwGDBXfCTDqBJRwt7Mkau9Q=
X-Received: by 2002:a2e:b888:0:b0:36c:7a86:1a96 with SMTP id
 38308e7fff4ca-374c37956d3mr29939701fa.24.1759741753468; Mon, 06 Oct 2025
 02:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003195036.3935245-1-mstrodl@csh.rit.edu>
In-Reply-To: <20251003195036.3935245-1-mstrodl@csh.rit.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 Oct 2025 11:09:02 +0200
X-Gm-Features: AS18NWDqVOHajWvTpaoMD2IvfKZq9S42szEEmT-kwKD0sXmmuanfWWpIkK5NWH0
Message-ID: <CACRpkdZpFvzu+UFkQjCLO20P0V=QOY6dC9O15LP3LJx6NuifWA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] gpio: mpsse: add support for bryx brik
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: linux-kernel@vger.kernel.org, tzungbi@kernel.org, dan.carpenter@linaro.org, 
	brgl@bgdev.pl, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mary,

thanks for your patches!

On Fri, Oct 3, 2025 at 9:50=E2=80=AFPM Mary Strodl <mstrodl@csh.rit.edu> wr=
ote:

> The locking changes probably should be backported even though the actual
> device isn't hotpluggable. If this isn't the right avenue for introducing
> those fixes and it should be sent as a separate patch first, let me know
> and it can be structured that way instead.

It's fine.

If it doesn't have real-world regressions right now it can just be
applied for next, if it has implications on deployed systems, they
should be tagged for stable@vger.kernel.org.

If you have some idea about that it will help Bartosz to choose
whether this goes into fixes or stable when he applies it.

> Mary Strodl (4):
>   gpio: mpsse: propagate error from direction_input
>   gpio: mpsse: ensure worker is torn down
>   gpio: mpsse: add quirk support
>   gpio: mpsse: support bryx radio interface kit

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

