Return-Path: <linux-kernel+bounces-840284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C1BB406E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9762E421E96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2F3112D6;
	Thu,  2 Oct 2025 13:26:30 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C282EBDC2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411590; cv=none; b=ZFO/MYjXzkohxZ5SCIdOEqhB/i25xogSULMCmiYw8feXGrHSuwx6pXczbZLvGX524SO5xFFQq9Plpl/YL8383B7hYskBhVJOJTaRS2KFGwMGB9iyUA43hXANuKqdZEsbppEzlQHH61g1rstmVhkDlThE+jzZkOqzCPAX6eeUjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411590; c=relaxed/simple;
	bh=UA6tTZXqaCOK2NigC5FAobaKNdJkRhWjZa2mAx2vxXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UW7AWo0MmBcmLhavIbGzj/RPFbwLN0ApvMf8bL2jRi5J+uCNe3owAXEKi9QoSQOc3m1IBZJZKuOsK1ztWL+l6wk+4qlUaN5TEkJUL8OZT4Y1PKj7sR4K78uArrkdAz51zhIFHNRiedzfheSWOLeNk558fBMam/WQ0uouTYYU5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-64990f4dba2so632556eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411587; x=1760016387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3dE+UYXSAYSMrP4rWfQs9LXTI5k4tbEHLzxqaY9yVY=;
        b=PvFssa5ntXFtva9oNc/GW5HxyKUbZx/tR1zPIz1YORZpa9LBxc5QQj+58wzfP4HXmZ
         JDPeJ+pcyCeTy8LP/JfVEbB1ew6Pc7oCJKkF+V7LGJX7y+hxXeYXcaDXp7ANSzaQVSR3
         j6bgB+koL3azhhGv8z7JWaNL5QTjpc0NGz4/t6jRLHJ97GQHh5BmItEZkjIqwqdalgjw
         pFcHOGhqnK1v+e71327RUVgw4S0b4Hk36xu0ex2NNtGZKZ1x01mzs3OhnOnEOznGFMu4
         bJ7vZYi7OatlUkdlUa0NELc40qO84sxDEKe3i6k02flBUE1ITWHEEI+mqGsqQ2ysyF+y
         YV5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3rPNPEjXQZbOsKcf6ka4wl8BEGf5VjC1rQUMNwjeFYGqrQ2n/nF/dUTW1S0UG6G4xGaccGlRU2MNO37A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJOa7rz+lDT0aegoAwRuryoZPQGUgzxTNE9HCuxqe2bK8czWl
	IaCECjT2WGPadB/i4AJzCUCvJLzub+w00lryiOrxmcSyDGp4eeqZwMqJf7IV5daQQkg=
X-Gm-Gg: ASbGnctugPp3GX0TN65/t7N4WOWalpk6vNbNLjKP/ni1OIvfkCb+0Mssvq4y78SkN5L
	zEHKHZ5vN9xHTA3eG9sWflZ0x00ZQjg3Ad0Jj7NMvIqqgv7ClFRQMx/UCrRKa30gOXwvrNGlz9L
	q17x2NgbxtbcAfWqvH1MhqgsQjXj/YU47K/IS+j7jIfu+sB5YP9HniRPVpeHkJWljOK5fax8MqK
	nKhRWbWvLQh0e/eFycZw3N45OrunQr0n3rH2U6oyjPrHG9YIksYdGRljcyx951e2f7zlY4fSnEI
	BdN1xg9WGksQVrHSdrTv1Q/xcvsIJOivL8IRLKhJNV303Psbx0sfaTqZPSnjTnQnIfrNj0gdydz
	R2Y1iCqqkTv4VehhK5RSa+kK9jLuL0jdvleJh3bS5u71yAuqUnOyp2C9SHsusX6+oMaygZf4Ssu
	5CEhJvJ1vLiIRZiORFxcY=
X-Google-Smtp-Source: AGHT+IH1ULF0n2u8o17l6l0NaogJUw9VmF+72Q31hZA/ePGukPz7Rpsel5af9remoZjCw7cjG3MOJQ==
X-Received: by 2002:a05:6808:4f51:b0:43f:1889:d486 with SMTP id 5614622812f47-43fb158cb3bmr1809352b6e.11.1759411587169;
        Thu, 02 Oct 2025 06:26:27 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43fb255cd24sm466722b6e.15.2025.10.02.06.26.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:26:26 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7b3e2a51678so670510a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:26:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3C0Fd9KFSzq9dtIGnY7owicOuamzUqT8DhDpx0NWCh2tFV0xyp53H+IJl2w96g2hfbdGiQkJY+z4H8a4=@vger.kernel.org
X-Received: by 2002:a05:6122:e017:10b0:54a:76f6:99e6 with SMTP id
 71dfb90a1353d-5523c01a219mr1048867e0c.2.1759409829773; Thu, 02 Oct 2025
 05:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXA0fWwO_5bBud5FE-Kwp-7zU_rb9rVPcuZojaNJT=tkA@mail.gmail.com>
X-Gm-Features: AS18NWCCYsMv_0f38WPVlVfiPUyz1ABU_-4NHROasZoc_Eb-IAFzQ63J2o9bB7g
Message-ID: <CAMuHMdXA0fWwO_5bBud5FE-Kwp-7zU_rb9rVPcuZojaNJT=tkA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: Kconfig: Drop ARCH_R7S72100/ARCH_RZG2L dependency
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 14:47, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ DMA controller is used across multiple Renesas SoCs, not only
> RZ/A1 (R7S72100) and RZ/G2L. Limiting the build to these SoCs prevents
> enabling the driver on newer platforms such as RZ/V2H(P) and RZ/V2N.
>
> Replace the ARCH_R7S72100 || ARCH_RZG2L dependency with ARCH_RENESAS so
> the driver can be built for all Renesas SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

