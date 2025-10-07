Return-Path: <linux-kernel+bounces-843637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6834BBFE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0DB3C11E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305781E5718;
	Tue,  7 Oct 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="X7/3C8PH"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057B19E7F7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759798990; cv=none; b=QkchsvJiaAbBlYHSBW1ZSfNDHT8o6dKBMFt7oF4sjg7Kg09eRfP/YYfodVG0geBNW0lp3E/jrG65W0TMMjZsVMxa9z46hbzPVL38ZJnBIJcGkBUzOt+xVSsr4Aw7DSqq6V6/jAWDKd2ekis2aazdA4py1BRAqJKR7OJxtMqYdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759798990; c=relaxed/simple;
	bh=eBIOQd4QaXOsZ3ZFa/G0uBWNq68iI+2RMm0FI9CBzIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5R9gSr0PC9jhWIB+0/fEGsJfv6tvR3TgDgKlOQsGNlANd6kY++GmvLzNFK3mwnMHDemGllh49aV5Xmz7Hr4KzL3I/a2dnzhWcF5oEtwJbEW8zVpKAwdDYR7pEWFY6oYdfMz6sVtRcOLbz1yE/dTxLp/umMWx2gvjd3B1tqtohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=X7/3C8PH; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-637dc2292cfso6221098d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1759798987; x=1760403787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBIOQd4QaXOsZ3ZFa/G0uBWNq68iI+2RMm0FI9CBzIs=;
        b=X7/3C8PHnUzlDkgsLtvRE8Zse10Stue/QfUkqVEzZK9pRdxqbXzGEcEWoRbHPT2zek
         +bumE00nX++XU0dh0mV9nnAtVKizLCHXdGmDaX/taSVGr5WZaCtHwg1cO7YFn0Wj+f4V
         6U4NauhAr/XkLItJm6zZfbrw4ChTKnZn6pfwgzH1UbZrZy6NPlT+YeHumiwRf/Vl6Gtc
         K6aEECpICnj480KHHWH+hxG2dvKZbB6TxQP1POzJbuOB5V1m0lp+hB7uu7AfQ5a2rqix
         06W/iTcdL4y+a8G9DeJI8O3CWmdbtnYhGEhZZcUXfO/nI+tCrv4OBcJjzU1fsQWOHlH6
         Cylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759798987; x=1760403787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBIOQd4QaXOsZ3ZFa/G0uBWNq68iI+2RMm0FI9CBzIs=;
        b=FIUiNqV47ZC/QeBsmpMIZllQokvdGcGlO7RoKXt2cFoamOSw29/nRaQcY7lod9HT/U
         Vd0l9o9ZmG2HXBgSHmF5r0y5pmIHaLawTnj+KiopZQTtckX9trbTyJ7iwMVlrRk7LOO3
         rCTthRLxnWXXSOPXspkOUKRTc6DX8QxgLZ9X1JufsE8uGb62yeci5s5bIjkDx7rO3d8O
         2Yf54985ZOGe+axh4aj7/h826qroD+hxLWW0R5vWwjLWUUELGGZKGMA1hEebRey8FzDP
         1yy2ySs4eLPJ7CMWI8uHASHpFq1liNTo76IDa3AAN01Okq7znt89Q3Qk7S+ZxqvYeJEJ
         b7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVY83+Qe16SVxBmxxu/k6nYyJYCnszlVB3jcc8oXv6RSXM9j2LYQ+XkpvvUaH026f+UNXSo1xqO8AJ/tYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5CaaDDpGMN3Tqq1bsquk4CzRPoNrfGEFL48XW/2wGpcFMPvt
	xUD0o+d3L3Jl62wYs/KlfCYZR+wr3L/khPjE1bcqYG/NDh+UOWmdwhWIt1dxRRacNhl2zLZUciB
	sWIXFBMj+dWOgWRTleQ8DEBnCKpEbcwitsaE3sOnssg==
X-Gm-Gg: ASbGnct9rNRECZmAZaDfPlNJf4cjJUTZe0KSPv69un6aoiYHDAJTUvl1ZGVNQrY4Nta
	fDjbiZDvE2z9vQMWaddzUqut1WFfvtoKIoTOo9AAFPiykgKJba/zAKY2hiJj2HveRGL1h3WIgiQ
	CKjG8tk4UG0K0b3uBb85XRvFvgIG71fc9Me7qGvbdQYWJCD251qr4WMHO9kuOEB+tjtVvTv60bz
	C6siSPWkJFutNURsxZfGzZwOSdHWCw=
X-Google-Smtp-Source: AGHT+IHPqXX/Ku++G51JKZF3VapXuzBNkhQUq1V5rRTsgDMDDHFMevDekfr/eOl8a0tgu7pm4weDxaifuaPSOIzI9qE=
X-Received: by 2002:a05:690c:6e8e:b0:772:3578:2ec5 with SMTP id
 00721157ae682-77f942c2c16mr273915407b3.0.1759798987633; Mon, 06 Oct 2025
 18:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
In-Reply-To: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
From: Joel Stanley <jms@tenstorrent.com>
Date: Tue, 7 Oct 2025 11:32:51 +1030
X-Gm-Features: AS18NWBn3AFicAlvLl3lNmePYkN8YXI8pNMvhAKDlltC4-SqQFZLgr1SznNw2gc
Message-ID: <CAM3sHeA2HUpcFJ7LOw1XfjJjLA+A5KsnqFoHe03bv1wHJ_zoMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] RISC-V: Add support for Tenstorrent Blackhole SoC
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>, 
	Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>, 
	Anirudh Srinivasan <asrinivasan@tenstorrent.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Drew Fustini <dfustini@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 07:51, Drew Fustini <fustini@kernel.org> wrote:
>
> Enable support for the Tenstorrent Blackhole SoC in the Blackhole P100
> and P150 PCIe cards [1]. The Blackhole SoC contains four RISC-V CPU
> tiles consisting of 4x SiFive X280 cores. Each tile is capable of
> running an instance of Linux.

Nice work Drew!

for the series:

Reviewed-by: Joel Stanley <joel@oss@tenstorrent.com>

Cheers,

Joel

