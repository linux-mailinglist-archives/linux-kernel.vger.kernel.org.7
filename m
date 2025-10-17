Return-Path: <linux-kernel+bounces-857834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B76BE8089
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A00E4EA81D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F8313523;
	Fri, 17 Oct 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TdYYJFWB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E6313270
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696227; cv=none; b=ZC/krVWoA/DtK8z194cNMImsv9fmvwqmDrg0vetp5g//h+iMAivik7Zn1/5da+g4um1neJyrhsihzWXL2/nn9yfzkI4Hg5/fgHPCHO+XR+rliFps4RBMKadbBKl/Us4X+3No9rGbsonfZKgEHn7PUlCiqziajuGQRzJYWR9H+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696227; c=relaxed/simple;
	bh=kjl4ttTH7mf9R32gzLYGA8/6Y+kS2fnJQOWcBKhszkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmrngUddYfn+BQVCdYW1ZLTuCCHJVlHzSJuUvZyy9o5FJ9Nh2SmUdoEsOrPh7xHQfoAu1nGEGBdcYCf2+wnwfZw3lWHV2+2dBwzBzNDSyhYVjqK7nc+6lJZiGtARY0Q1fiFgQF540jRFkzH7U+Df777WRn596D1maBerpoPdW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TdYYJFWB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57f1b88354eso2024590e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760696224; x=1761301024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjl4ttTH7mf9R32gzLYGA8/6Y+kS2fnJQOWcBKhszkQ=;
        b=TdYYJFWBgR6zxASn6disEU5Zn/G8Go9oVaD0hFxtMXkgiysqM5f1t/9CjGOIPF8Bdx
         6EN8JEkNfKLWZ7f1re6ZWKUFNIwtQ94FKHD+G12yuASMHR05FeTUs7U48RaXKkXogygC
         P4emS+VzC6yJQ+XohQXW9mscKbc02KjVxVy0livn3ZcZo3vnKXAYdL+qISdivb4wUFut
         KPHLgyOflXjtm/+PAjnJ9rlakDdUX2x+LtF8UYbR4l5DEVK6QTqM9zGAqlYLXqfSPeuV
         xG3K6KiRcPMFLbX9dNFoBIFLXuTua3j8QFo/6yT8h1cMR0teXqOiDW7GzNx+43JiMrRM
         VhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696224; x=1761301024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjl4ttTH7mf9R32gzLYGA8/6Y+kS2fnJQOWcBKhszkQ=;
        b=VlTENOioMj6OqCKUPPJEKQ+ugfRKtG0hARHeikVEdMebhks7GCa7gzSQPT2zZ0R9F7
         Hj2whShDqMSewP8wR3s6H/Afh8rcXGRxSf5GkpiAvHF+Hd9BLGFTQDm4CtuwjT1fMRye
         tP1oX0rxHrD772/ki8CpGQWHDIJDSCNjdrAaQuh4Jfo3aVHxJWtCMsyefQN/0R1PrHdg
         2KfCuzO0yUsjrqapOflejctKKECJTlRZpy97h5DSdrGmEVsvf3qBQ+yhvxjF/PS53c2B
         LuhXvBbPsjUFtKBe9rkn5U5C1OUwtW6DkGM1ErcNHI0KNANvNNFvJCnN39SnbQ8J0ZKJ
         dEtA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ8goI2nYpXx9Il3N1j+rsoO2BL8RbwolxEM4AQqKa8yWT1JJ13o9jLmw/E363ZNGYGOLB7MqcOgkj18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUNmKiQsSEY1MXXoY3VaV15G1HYB0CIxfvbBFmMXAbbbSScd7
	IrVDeP224ULAFsfe0cjYLINIw1fNuXkqkt8Ep47yANVHsUlM/pYiPCBCj/XTlU0EHdDxGSRaea5
	dKhD38M9wCyRo3SxXMLrVfVK0Wzw1Z2lsBTZUkZqENA/XTpvYTC8aJ3s=
X-Gm-Gg: ASbGncvvEOToA09lUwi/ZJk5Mnt9F6vx3FLaUKf+Fl8pBhHWNsKj2nbsSfF/rgobBFo
	E9tJEb2XHDmnbdQsjMBd3vvFlrMH++goGveTkbn48b6+bPoUYtwlx/gZbx6QF/K0fte0uGM0xoR
	q6S87yZUXGOwvzgGz7pXJExhMhS7zbgWdPuu7KncNFz76Q7ht/gk1+MX8RViFyo3OgwkeL90mYr
	VMbEBy26LPKFMY4tpsSUwv86oszlxtZ/YEXEuhojxfr7KEoiTs9hiPGMZhfyFUYQchkJ7VmWGJj
	ZjrboB9db4VSpvb7
X-Google-Smtp-Source: AGHT+IFb5texgdvZxKT2zW5oquozJ797AN63wKHy3b9LDVsQ1OxcyWyj+SIaMVrmskHSbiN0SZxwE2rKGHAZHN2+i6c=
X-Received: by 2002:a05:6512:63d9:b0:591:d860:413b with SMTP id
 2adb3069b0e04-591d86042c1mr780177e87.28.1760696223659; Fri, 17 Oct 2025
 03:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <20251015205919.12678-6-wsa+renesas@sang-engineering.com> <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
 <aPEAx8ZGHBcWZKJF@shikoro>
In-Reply-To: <aPEAx8ZGHBcWZKJF@shikoro>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 12:16:52 +0200
X-Gm-Features: AS18NWBV_gOes0wy7mHl9bZewgimv-j1-2NrfbKup0xQtjfDtypktWhvdD9A6GA
Message-ID: <CAMRc=McsbAirEYjoo455mbKU495VEvPmMEqBmZCq2hw113YHOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if possible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:28=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Geert,
>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thank you!
>
> > This does mean RESET_GPIO will never be modular anymore, while it could
> > still work as a module (the reset core creates the platform device,
> > which can be probed later), albeit in a non-intuitive way.
>
> Interesting topic. In fact, I think we should make RESET_GPIO bool. I
> think the fallback mechanism of the core should work without any module
> loading infrastructure. It should be there whenever possible.
>

You have not said *why*. How is this different from any other device
whose driver is only loaded when actually needed?

Bartosz

