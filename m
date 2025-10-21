Return-Path: <linux-kernel+bounces-863006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EFDBF6C64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DD348765D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B733710C;
	Tue, 21 Oct 2025 13:28:52 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD4335083
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053332; cv=none; b=WS72V3VdoxMoTICWyEuun+O3n6zYZ387hVSJFViSkHJDlnYl64v+dHLaEzv+l+96jU0UThxLbrcKtOib9BL3SXgsyRS+V6ahUMHUcMkOQ/r8PEjXvxJpd8lQbPg5aCQyTchAU+MBUhhyvkRGlzPD3nfz9aV7ue8zj2zjch2oD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053332; c=relaxed/simple;
	bh=RQwS0fuOoAkZ4Bs1IOOQqMEfIMm1iFcY5Luv08QraSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkqSV3mrsIOTWJeW7EV0ojA9xrQL9fyifAkICVqILafUxatmpdsw5+wBvr7O5IeQUtqPBiWN+4bZ5XAW3Bk0SJuwiFUkzGVIPzKgujjwleGp0dyuCNL2tMipicSb68u8LRU/dEPBdcwgIwEYfO4z8R0ysKipi/Bj7c1yUuKVcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a0d17db499so5177922137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053330; x=1761658130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foZkbBKrkpzKqOb0SdfF8T3/ui75q1xL0TwtV3s3sfo=;
        b=Jfe/F9NfoyTF8APTYCkv7ncWnDkrkzC6glmjlMzUXpCZqxSRf50yYeIFmRwWJsXSqB
         nKHts7TuZzi55phvFGJRt9QFDYrGOYKoguHqxJ3fGgfsm4jtW5W/6nzqd6Gb2GjG/+AQ
         90SY8lfAjv4M4IGRDX7LbC1ERt1q63oqvZo21TPz2kifKqzhicXobEUS88GAe+2cKTrg
         mRdhcpLORUE7BgbKdRjfe4zyGy3ui9LPGl3qPsyM5H9s9hINfveW2+fFwFPKxD6VVOTI
         WBNnVS7Y14OrJLZFiVDcpYmCUvwGatRjPf/ARmM+DnkxJxHetyAJUSy22BzDIH9Ce3nj
         lwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhnAT2BsG+mnLVsfNYiYGEZ4yei9Vum8aKHmjmr6DXXw8gHmhGbPn994mIdeBu95KSCA/fsZLK66ji0+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHSEliN1KWuw5TIk/7mZnRLT1OqtkfyhAi2fC3JDRs6/ZYkV5s
	A3lf9OXP+L13KTq+Bp8LjNKfqaQAE5KTg0TRkSUICJS8NPWGRH7vWQx9GeEpOkwQ
X-Gm-Gg: ASbGncuh9XAQ3GumcB0YXSGpwoDbMvy5rnLdaGxEJcIbND/9mT/EK746PPSdmaeZeqc
	nWUBmAHlylLTdcEJw8LH8UO1YsU1GGNswWkkwb+7pDTae6qZNkf5oTlV4djfvKWkIucn87Ypx4O
	VtrSjyU2jEOmP8T/arhu/ISb6YKHRiaT0fHC2EbZ8qf6Y+fA3wqFK211uMeWFlZ6PtvR1zNgld5
	jo4uXAJ+FNO1+3349b1VdjQnF3FZxLcijqC6SLH87kUKiVaIpgmyAXq078KFMUcQ0MQtENMgIb5
	om5cZYF1KuD6JcTTR/L6eIC12ewY5k8QpEd1dA9VTpwqCY3BmZwdJSl4a4/bGMT47X7DpanPN38
	qtGJPzzMsz6G2fx82a0D5hr9Q0ub/EwkoJGI8OW9QDm17Y4EGV8UPtfsEGV2FBZDko1gaGQ+ef4
	r6/2uItAO8cTY21ss0U0hItNEkS/cO3884A29Y+CKqp4ShuhUn
X-Google-Smtp-Source: AGHT+IHQIY6uvf9GKfvmMT73lE1E6Wqu+1iuBkc2RxZNZeSyRqh2C6zd0ypbN79u0MEl7ncENyEAAg==
X-Received: by 2002:a05:6102:162c:b0:5d5:f6ae:38e9 with SMTP id ada2fe7eead31-5d7dd6f5af7mr5447442137.42.1761053329735;
        Tue, 21 Oct 2025 06:28:49 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c2794e4sm3537256137.13.2025.10.21.06.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:28:49 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5a0d17db499so5177890137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFi5KlXjd9G5m4tiMYJ/rNzBuGS6Kg44eiwIh5NI1iWKTn2hOyQi0gtiVrWuQcpUJUdhBkgcLMT7+UCVQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5be:57a1:3eda with SMTP id
 ada2fe7eead31-5d7dd555917mr6009011137.2.1761053328121; Tue, 21 Oct 2025
 06:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014105348.93705-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251014105348.93705-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 15:28:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzuRhD-r=gSzm2FDDsAOr+Xu1fWyN7ky-U0NoJWXY=qw@mail.gmail.com>
X-Gm-Features: AS18NWDraC2r8a9GHqVGQXFDsek2PQJQgzVHv7PR4XYgaOZDcSUVJXOIem5AU9A
Message-ID: <CAMuHMdVzuRhD-r=gSzm2FDDsAOr+Xu1fWyN7ky-U0NoJWXY=qw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: cpg-mssr: Add read-back and delay handling
 for RZ/T2H MSTP
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 12:54, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On the RZ/T2H SoC, a specific sequence is required when releasing a
> module from the module stop state (i.e. when clearing the corresponding
> bit in the MSTPCRm register to '0'). After writing to the MSTPCRm
> register, a read-back of the same register must be performed, followed
> by at least seven dummy reads of any register within the IP block that
> is being released.
>
> To avoid mapping device registers for this purpose, a short delay is
> introduced after the read-back to ensure proper hardware stabilization
> before the module becomes accessible.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

