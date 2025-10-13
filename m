Return-Path: <linux-kernel+bounces-851520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD5BD6A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 431CB4F5AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD430FF09;
	Mon, 13 Oct 2025 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xsu2N3bR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7330F81F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394866; cv=none; b=KVAHLqeeTOPCDjFVs1BVlawYKmxnoIIEMaJmOh0IEk9Di7OF3XFSiy9FOG74J0TQybbI5INRB9opFxRwI3x9yp1mWWAq1ZS21oYXPmu8Lgy+c9e6WQ9hGdq4sgIRbrZV1B/1ZR3SDWRnaUiCu+ueaYIqzZUgUQO8ie3lbqMt5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394866; c=relaxed/simple;
	bh=UpuAxADbv7GA++YfwZct97abHEvsfJGjTfg+N9P5LSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5t4KoB0ti6oYHSzdlNDa6bhdfi82z7cYEH1OEb+IbuCQwhk+Fe7Bs+Do0F+y3fMcNmE326VDxgSPFhcnfO3MGpNUCjd7UF1lc4LLctqlcIADe6TBfTpTbCq2wSorE1hD+DMK/yyAFlt26kLyNOMXxf7PHN/XPfqV3rvhf4YKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xsu2N3bR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f898fso65550675ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760394859; x=1760999659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwbGv4J28a1dG4lLmSXG6e+W+t/2iTnwMsiuMvjryc0=;
        b=Xsu2N3bRzic08PArIaedhsGebbkn7SG8s3Ei7IebWaugI4rbtFa2om0zHvmgH1m6LR
         ATCR6mWdfzPYCTzaprdpPFgOWOmBs6c9AHPKNPQl0sMwvOZpf3SIVgRrLTd8meGrkUMi
         44hfReYwVJ8qFwIpllysMq7uAxTXj2DGzw1lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394859; x=1760999659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwbGv4J28a1dG4lLmSXG6e+W+t/2iTnwMsiuMvjryc0=;
        b=vMGxIRFuGaAqvajqd4B+5PooudRPUENzJu18P3LhYsEgEwitXdb/vvGtfxJO7iAeDu
         2meDfkJGLG2nfWCfr8t3FQQk/hLUEUDNUZsCR3S8BrpCo0wFy5VgtkcWzyIkTS6iYFNH
         Rx3qxkhq5VJ04oT00qp8nQ/lzXh9H2oZKDG4CjcEPdch14L+R9dTWFWiwFWsakQzmtV+
         QI4eWAYmZTddAo1R6oS3bYhpeNu5ib/x/Xcs4R13WJKwNWpU0hL5RMoK6tzOeQq8xdls
         1CqsP6eAKp6+ojCY2YDBnuzmzGWQmJ7QfzVZaEkAat7REqCJMVt6du+nPRuoOwPtXnMu
         e1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXCubIlCG0MmRdN1AETZQWXxRkODpAeGOZkC79PAnYJbiEbeFTJTqy4SOd98H8a7xesQ25McU07Jb7xH88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5HlJ5R/nEouZMjUmcHj7a0Z4WV9X3R1YTPFoaMwOhrPxg7QG
	/FesCCTGCZdLCfHEzIRxvnMAjvGCmd5kZmWJ/LEaEqIbz6/vugkkSLjZnQaczyClWWDnQ6TIuxO
	M610=
X-Gm-Gg: ASbGncuq0RXSeJSL49cXmkHltLCTYM/sKqn7o2XOgIX0IvpJaKwsYua1kl2JToFZ7iw
	63UU3PRsPSR7JVDks2+pqqJQtMYTXJmVNROpcp0YIycAnDG44p0RSagXkT1TYv4dnxx94XcJlyg
	QBOu9VvijlVNJfqhbKpYgSYU3V/NsxsW3C3sIKei6isiuLVvn1iGTqdhtdxxF6nPcS0NlZmnu4N
	j9OUeTEZTqCcNyTuSXu3eARL6sq+uVNY2vEwxLSRgfmMeTdouPRYYVQQp8FkigUwKgGneJ+axKC
	3rEc4U0vzEsTkekahFOQXye/oPMRXYJu3z5vda4Kl7OiP1o7JvH7MCcwAL5w0aK8fo5kO/P3r2f
	BadhXF/4sHW0Pv5AlNaV5rT7bDSFaS+H1faeShjyfc7pc48T1Zs/caKWk8zpOvy9KMfL6s2nPS9
	Bk5o3K43x28rChucc7cQNT+tsi1w==
X-Google-Smtp-Source: AGHT+IHuTZoIGWGmbfd+kzIUL2Q3A7/EeV+zjtaTyAnZzxOob0uNWdNY75z++9TirvIpDB46DzkaSw==
X-Received: by 2002:a17:902:d58f:b0:290:2735:7285 with SMTP id d9443c01a7336-2902735728emr288080695ad.47.1760394859285;
        Mon, 13 Oct 2025 15:34:19 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f89972sm142652375ad.112.2025.10.13.15.34.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:34:19 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so5924322a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:34:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURr9RBaV2wAX4UnKMCHiWC+roJBJpo09vhTET7dCGz0ugGEpPXOmlW28qwRUXzAemz1K1iBJFK6svvKdI=@vger.kernel.org
X-Received: by 2002:a17:903:11cf:b0:269:63ea:6d4e with SMTP id
 d9443c01a7336-290272c1aa5mr269142435ad.37.1760394855700; Mon, 13 Oct 2025
 15:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009032838.63060-1-cuiyunhui@bytedance.com> <20251009032838.63060-2-cuiyunhui@bytedance.com>
In-Reply-To: <20251009032838.63060-2-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Oct 2025 15:34:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcgDFk-Ad8nhOYK8Ay_8==3JRxaZ=8j3SHCa2rTKJCTA@mail.gmail.com>
X-Gm-Features: AS18NWDRlpKOc8vUNSnX7EzUSo2l7O6rFyMCga60WeZRtc9k0KplotG4eFs760Y
Message-ID: <CAD=FV=VcgDFk-Ad8nhOYK8Ay_8==3JRxaZ=8j3SHCa2rTKJCTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] watchdog: move arm64 watchdog_hld into common code
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 8, 2025 at 8:29=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Move the contents of arch/arm64/watchdog_hld.c to kernel/watchdog_perf.c
> to create a generic implementation that can be reused by other arch,
> such as RISC-V.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/Kconfig               |  2 +
>  arch/arm64/kernel/Makefile       |  1 -
>  arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
>  drivers/perf/arm_pmu.c           | 10 +++-
>  include/linux/perf/arm_pmu.h     |  2 -
>  kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
>  lib/Kconfig.debug                |  8 +++
>  7 files changed, 102 insertions(+), 98 deletions(-)
>  delete mode 100644 arch/arm64/kernel/watchdog_hld.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5438ff4772ce..4759e4969c4a6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -231,6 +231,8 @@ config ARM64
>         select HAVE_GCC_PLUGINS
>         select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
>                 HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +       select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF &&=
 \
> +       CPU_FREQ

nit: the line limit is generally accepted to be ~100 characters now.
It would be nice not to wrap. If you really need to wrap, indent like
the wrapping above.

In any case, this seems like a reasonable thing to do to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

