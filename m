Return-Path: <linux-kernel+bounces-844965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F28BC329A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E861892084
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067E29B237;
	Wed,  8 Oct 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnIqH4cc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE0205E25
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759890003; cv=none; b=FUVbc4k6MmEa/YTRyFdnAQs/6L9MfYnmCmuRWkgueLubYxIjefsoHo58KHiURIw2ZAhPQPLjwaT9zloUYScc+wD0tE68VGDoa2o8iYY6HpNgVW10b3Tlck038T2mjjEP6Jl2At+ciDILQfGqw3ri2U7CQMk+JA8VxId4tSOB3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759890003; c=relaxed/simple;
	bh=YCxQqeUyFhTrHt15C9RFmiynERMtcxKYfJ7HLF7B2xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUEFBLrX2I0X/kw9aGuS/sh9AXQiGU7BbYrX5r09uvoop0scJgSgoGrygq3WCBQQ9jmxJh0m5PyOV2W5qiQWjjsFyEtDje5O1vf9XkeJ1Q2yTrxWgeUjoyL7Qbra1u9ucpB/ff8P36zB3xhCYSTGfnKSZctiy2KI4xmR0WKKeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnIqH4cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E951C113D0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759890003;
	bh=YCxQqeUyFhTrHt15C9RFmiynERMtcxKYfJ7HLF7B2xM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FnIqH4ccSanW/Wp1LRtkqe+nd8kUwBmtOYgk2Cta+xbfl7r151a00fPr776E6CxiC
	 kqEKWFnPgVB+u0/FXeI8tcWmTEZ7qbnLdSydn7NrXhtlTPj/nGgmyNVW1REVTXnjhl
	 kuDkkELxzMWesz4PaLQ4wYHc07g618yMJFJsamh5q/IIB3Rlz8jwZhfllCjvRv3KSF
	 sQ1PpP69D18EBv+pldBxl2JKz1yNCfTVvMp9BNZIbBjbFFokn9x2je88vn69+eTiMN
	 Ob3msLcQvko1n2qi7ucaA07vS8nx6bRMs9Q1OrJukaW9TfR1mNaE0EX/1K/zEJSmhK
	 kQ00elWaFOR7A==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f0308469a4so3947394f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 19:20:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR09X4lskoOB+R+LJCBbdFEfEInZd89JBSrSo0sH1RkftDihvOBWTSwG2vTftnGjQ2WH33XXcRjtswN1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqtDWH1t6NtDVq9Tlr7iq2SLj+eeSS7uzHFAc4PL+Z+SElusD
	iz7gPy02Co3o/Vtg4IyEhaG7TteCKSy3J4AnJSfA+MDxypVupgcbqFb8cd6mvQunmeccsjgfP/U
	sysZ8B5ToNb2nO2lXTZtadYuUHwOtYjo=
X-Google-Smtp-Source: AGHT+IE49Ut3K0iDJkRwoaA4pG+jQRbjMeKF3N1ZvxV56NRURvyQRm+OalScdRWTDPzbXy9freMthjrU3URoDPoL6dY=
X-Received: by 2002:a05:6000:2410:b0:3da:e7d7:f1e0 with SMTP id
 ffacd0b85a97d-4266e7c61c6mr807123f8f.27.1759890001781; Tue, 07 Oct 2025
 19:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
In-Reply-To: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 8 Oct 2025 10:19:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTgbXgVcLeC9eJ2+Rf-+5Zq0tysEV5coZVai1mw+NZCuw@mail.gmail.com>
X-Gm-Features: AS18NWA9kNLOnkhi6ozusphJKXdIh54LkYxnWdkc3Fqr_o4LAL9qKkGMioXiEeg
Message-ID: <CAJF2gTTgbXgVcLeC9eJ2+Rf-+5Zq0tysEV5coZVai1mw+NZCuw@mail.gmail.com>
Subject: Re: [PATCH] csky: abiv2: Adapt to new folio flags field
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-csky@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 8:13=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Recent changes require the raw folio flags to be accessed via ".f".
> The merge commit introducing this change adapted most architecture code
> but forgot the csky abiv2.
>
> Fixes: 53fbef56e07d ("mm: introduce memdesc_flags_t")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/csky/abiv2/inc/abi/cacheflush.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/a=
bi/cacheflush.h
> index 6513ac5d257888fbd41385c9263305dfefd18de6..da51a0f02391f7d391ce26a2b=
11ca82b8c0b6755 100644
> --- a/arch/csky/abiv2/inc/abi/cacheflush.h
> +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> @@ -20,8 +20,8 @@
>
>  static inline void flush_dcache_folio(struct folio *folio)
>  {
> -       if (test_bit(PG_dcache_clean, &folio->flags))
> -               clear_bit(PG_dcache_clean, &folio->flags);
> +       if (test_bit(PG_dcache_clean, &folio->flags.f))
> +               clear_bit(PG_dcache_clean, &folio->flags.f);
>  }
>  #define flush_dcache_folio flush_dcache_folio
>
>
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251006-csky-folio-flags-1376908acbea
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>
LGTM!

Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

