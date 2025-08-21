Return-Path: <linux-kernel+bounces-779682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4106B2F739
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA6F686DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E27D2DE6FB;
	Thu, 21 Aug 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCGwqeU5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA142DE6F2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777139; cv=none; b=Hu08sRvFTaDgndJwbZb4vrIY579ZlL5JS9k0Dp0EqFmismc2c5TadLCNZ3NddUNMfrmaB0wP+tA0n8VhVhyoOME4tIEj+WWjNxIYyMA81r16jveVOhuLmf6sTOo/IXkU+sAWbqlPqKjyKHfDJh61HfW276WUaTNn0SBSUCpmtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777139; c=relaxed/simple;
	bh=1HfvgkKViBDBmpYljJpo0E9vtsQUhTJ9vwqBCEaAPZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMn5WSUzYPK2PAal0S4RR9IV9OF1N+iuL8ufDnKtIDu3cALWNhtc8GimNLiloRp2YXY+nr42ITcwTF69v+++UPh2oWjALmaJyZz635WITzMVgLyrMpALKKpSk0yJyAHSMvBA9n8yZSejlEYIb0trTRh1/NkbFl3iMorI50kWr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCGwqeU5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-333f92d682bso7588351fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755777136; x=1756381936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HfvgkKViBDBmpYljJpo0E9vtsQUhTJ9vwqBCEaAPZ4=;
        b=UCGwqeU5t1LakJHmSvOrQse5imuLR96fw5i6jBiJ8aSZsV5UfDUgxWhnDUd67XXE83
         new2c11eEQNra+3JhGPan7E8GboCddGqXUEST0VgrgpOJdf/a4sBOueLqb3Oxd8NI+IR
         2CrmxMHs0Jci3N2MsQ5R5klnydqfR4UjQMZKkSbLIdhxuiCpDvYhc3TR5UDbKCllfGdl
         uBElR99Qc1roTCmJo2dPDiQxbff6ZjO4ECpGwgU8JOocvTtuT5cskR7D/CwP2XY9NANJ
         WG8pYufjZBby/fxpGgI5L0nd29HEyWfUMgf1iFkcJtyvE+6bPyJNou58D4Z1tt/tCtSw
         kZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777136; x=1756381936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HfvgkKViBDBmpYljJpo0E9vtsQUhTJ9vwqBCEaAPZ4=;
        b=CYMs00zfitPk4g7lCpOR8pbDVh4ryYDw0tt0HrB2C/f92kG3cC397ENk8rvvTOwy7y
         4VNSZLntwOoZrJU9D0mBK3etxS2ptukUwn/Q7If+pgFMxIlz3GH9nKcJoYWyIuk0aj4N
         4pF5cefODCZRBHSqfq83TTSkL8qoBuvRuymxstIlp96TMATi3shkcuL9qrqvMfZ4sJ5H
         kMBcaDzyBtRLVRhS6S63dBgiVx7p+G978a7obvRq7jG6KNlOsbywRoCzJ00hcEa7Z3Rw
         WCQPxU2iOh4nucoKl61MX/4Qa3GU2hcxmxH6IfUJH6bbgQLyezE7w3DwU1gxqtFwBSUL
         pr0w==
X-Forwarded-Encrypted: i=1; AJvYcCV95O+WMWFUeXjD/q30uG5pE90OzJYKbbapqzxyeW9TtKE/RzMkWHcz6hBXBq+YhhPMjnHAL6eEOIA4uts=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHInhuJy8qIKIXtLv8ONjsGaR0gRNgSzK/2Vbbs0E4BNylthk
	J5eUQvZYQn8HC1mm9JxEjc87M+0a5OxdY8+EnEfIhN8SyFwKxIhvl2GMhKSWZ7RsnKu3RcdKfs7
	6EPVqnBuN+B+A6EolFSafcvV8NTC43m0Iltb/pWXTYA==
X-Gm-Gg: ASbGncvHwiDGAq5G2O41gjKWdNIv3pGmFCx+qmBmqvsqAcKsahwWacYyuRSL0RtTu0/
	pMVdd7RJMp9gMDn5HQQ4CiGNkVBRIfTBQAsI22HYupaGhIzwbFloBvbmAINO8xvFjsaYPuiFfIv
	sHXN7IeUXkSdfXKcKoluVoXFpCI37rlMe9AwvmwfZpNkRJIb7OeIiGQELmJUjUH4+0H028yIO3j
	ggKpkQ=
X-Google-Smtp-Source: AGHT+IE7DsV+WQk14KSKY0ALtymqoUNW021ikvEa1U5yioRxACQmRRzQMDDiUa3zI76UT8Ua7qd03ScrDSQ9aaYIYQI=
X-Received: by 2002:a05:651c:235a:10b0:32c:bc69:e926 with SMTP id
 38308e7fff4ca-33549e3a7e2mr4759881fa.7.1755777135941; Thu, 21 Aug 2025
 04:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820154037.22228-1-jszhang@kernel.org> <20250820154037.22228-6-jszhang@kernel.org>
In-Reply-To: <20250820154037.22228-6-jszhang@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 13:52:05 +0200
X-Gm-Features: Ac12FXyaf06rfmzUvXDVHS6gsoqtOPyc_OHXCIqFKQWuBvT2rlmZGUdGjdqba8o
Message-ID: <CACRpkdYQLqDxh=zqrZ+wK_Ky2wD5AUoVLmCV_JDfmaqJC4Yzqg@mail.gmail.com>
Subject: Re: [PATCH 05/16] gpio: pl061: Use modern PM macros
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Michael Buesch <m@bues.ch>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
	Srinivas Neeli <srinivas.neeli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:58=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:

> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
>
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
>
> The pl061_context_save_regs structure is always embedded into struct
> pl061 to simplify code, so this brings a tiny 8 bytes memory overhead
> for !CONFIG_PM_SLEP.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Hm true, 8 bytes is not a big deal.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

