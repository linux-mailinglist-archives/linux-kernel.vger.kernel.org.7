Return-Path: <linux-kernel+bounces-793140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88204B3CF2C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA294E1FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791F2DF3DA;
	Sat, 30 Aug 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sKyQ16DW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532F2DF3D9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583493; cv=none; b=sb078WazgTRNmHScLAIvvcGxW498sRDJvqUPDnecgonTGAEpbtQpnt0dBZ/ZPRiTo0t7Hl2icD3yIESoXYjy4ElAQg4sN4r/mGtrJKYl3N3/AwcHZSLFe5QaXp/eZbMkBwaXAqCMEG3DDxjmGxSJCs/bIRAoMf5hpw2sLgqyabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583493; c=relaxed/simple;
	bh=zv5YaPzqC3Q4Eg1Pl/dZPS9JfeNag02J+mjC/0Xdx+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqyDPx8YppH5BjF/bGyo4o7g3wDKqVbBlTBgntv3obHvZpl6+kljFdKfneQa+NUOEs8Z7xJYPYZq/GzHDNvzL/tJzUz2TPINA2iCq8AgcghnQlxNYePlPOoOxhlNPjPrxVbHXHvLRApfRzwRvn+860rtgo4DOpt/xyMCV2LDTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sKyQ16DW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f720ffe34so567330e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756583490; x=1757188290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv5YaPzqC3Q4Eg1Pl/dZPS9JfeNag02J+mjC/0Xdx+8=;
        b=sKyQ16DWB/y/48kZvGMZW2Gj44Z7EnX9PqvUA+oImf0AXAcZbv5zbQQVDDFkdM4FAU
         rXWVisKElwY6yv6rRe23FDgxfKn0NkvA+BZOQg15LdT4H0XsxpNg2+kIFBu/TVkXAJ1P
         1+YlHWUGDxSdyzGZUQuXWRIdDxKiDD7BQW8zla6CUvG62/pr2YhPLI/EMtVDgZOQ85BJ
         idIIClCdh1Q7cbO4MtADc1h3DCghNpqnvY6Pz6mCI5DkF/82de15vcD/WUfvWQ84nwvS
         ytM8KzLxwIfv1qBF+dfH0BLn/4iRNsd22Z8cJLGWErrP62RmYxBSOA5LPFGr+ATWoTEk
         wrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583490; x=1757188290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv5YaPzqC3Q4Eg1Pl/dZPS9JfeNag02J+mjC/0Xdx+8=;
        b=eNA9HvUjFnSH8aLFaoDAwuUiN7pbHpOUYHtHyzLzcfgvmqR/jZyv2oqFI1j6DcUS7t
         dNM607Su009zTwpTAAOmdHq9hRoF3vlFD+SuuUOTuiVgqxHWVrucYeCEtp4zEI8z4K2K
         UUnIPiHffIqNtDaq8EbwZOVF6pXNefSbx06VM7yww4JlX7NKRG0SZEb6CtEhzEeCjBpI
         sY6Ja7JcNBZGpjJTFE8S79D/Lp7xrzJtpNzQF6Js1fc6vG38UoSiTJmpvGeu2UWQAvlQ
         tELxv3zn4s4vIQVTi8ha1mN5ZoLGDwQldzBQnlb9IAL3dr+wnUxmMBVUep4M+aZ3X7G6
         expg==
X-Forwarded-Encrypted: i=1; AJvYcCVI+mKJd94BWk29EkKy4/10Yf/obTStq2sfNAMdEvNAOtpCSbClSUCGjo0q+GyXRjZ9BJimHcgNgxiASmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSyB3HfNEF6jcp2pFe7LZ1KavCB6Gyr0vqUqbZVtuJ7/aA37G
	25oA5v3CnFpbEvTjuy49doaUUzqK1p7fKsc5YX7GXZuku7LoqcK4ppRuB8wyTrBHL1xC9hBGSIv
	5e3E+dYrT9orQYN8TJQgmnH10B96LYKOjSwnEJWFu7Q==
X-Gm-Gg: ASbGncvUW0ym70y9rnPjJi2yws3jAJWu2Uo/+n77bMPktH6I72ZF047zAJgXyq4v5b9
	yc8+BlhHl5+cgj/Hye/L8nNeS2B7SxyA3N6zxLmT8J6mhjM3p6MsY73wR/Tvk3F7BrU+6vVpJ9u
	aK33XDfn3KyaZ0QJdwSIpKxbuJ/+7rkT7+TcKfmTNl2yO0h81J4w5FJEf49QD6eRCdsrMlbOort
	36mRYa/+2SOvbzyIB2W8YdzjVWTBtbluNITvWth9A3WXmdXog==
X-Google-Smtp-Source: AGHT+IHQUwwu34vgeZphW9VRaLBgPvPzIFcJJeErIWV2xc9g4g/MPBPhfaGbLPPRq/dIAxP0j9S4AWNKXDRSvv6YX2g=
X-Received: by 2002:a05:6512:6812:b0:55f:563e:f16f with SMTP id
 2adb3069b0e04-55f709b52a5mr577475e87.21.1756583490203; Sat, 30 Aug 2025
 12:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827175842.3697418-1-lkml@antheas.dev>
In-Reply-To: <20250827175842.3697418-1-lkml@antheas.dev>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 30 Aug 2025 21:51:19 +0200
X-Gm-Features: Ac12FXy0Nl4CmsqKiiwHV9VDpEUWs4Srsi2V0nq4DWPNXB6KMNEBW8bxC3QMlqg
Message-ID: <CAMRc=MdQY4mmfAPA2SorkjCdjpx7DSwF5rRUvnRPb9G1o5aaLw@mail.gmail.com>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 8:00=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
> touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---

Andy, should I take it directly through the GPIO tree?

Bart

