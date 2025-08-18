Return-Path: <linux-kernel+bounces-773421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A950B29FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154C15E61A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232B31578C;
	Mon, 18 Aug 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6w5U/dM"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138C315772
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514545; cv=none; b=Gaa5b0SW4hV1Qb1mLFMGFExLwdydtSAX9ndVU3q/InGse875WryP6Yy2D650/O9tB0jS/NsgK5baVtAjk4IyAH/7k1PKGwyknIBW+WkdINPk8ag3X+2LcxztOBUwlbBeLe5iaDf3CwlTsFGQBTc5b2YLjz8/vOktymgeHEVZ610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514545; c=relaxed/simple;
	bh=ppnDq69zMI7mDQ33wGt7XulquHNwOWW1uIV3gpereYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D289JWEOe+qTa1eDDFv2p16wmfLjUY6up1LyhoZ8cj86HwfhPf67XGMT3Nw2L20+luvj/CD8Iq+f29MuQc0+dxqrXZh4Kp9tBD9SHB78d5eH9f5yN/yYldlwWmUr+0FVMG6wYwdB79GLo11pHA1+IfGr8R+PVVKhitjnUYSgfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6w5U/dM; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e934a3fa4f1so985001276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514542; x=1756119342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UhCrBwM9JcxpOSa/4xq9lZhOpZ+tVZm/Xuce59lSt+g=;
        b=c6w5U/dMOwp6eUQ+RYuMtYGnW95iDI1UktF87AiPkdIHw/N17mkDUiSHIbbomDMetM
         h+aBCdOI29A9b8udTj+UQMboUrkuHeTPvdLabV5fHPAnfTqeXNqFUGrK0cA3+F/1WAp8
         zOQGgvBfpwAxswTsDm9i1XgZhjlceoVJmsynDAwQ5FzmnF6W0bCSdbB0EmG/tyc2VVgd
         8VZb1nHy8hgZ1Jq0YY2cfbGRU5VWpiiOzUuZagYPzPnnz562tci7UALNLfPCAJxTfONU
         t8w1SAt7014E2irmleJHww6kfD4bhohVnOV8myDucEWD+4zDm5g5HL+tTMe2ygOf9JnL
         Zcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514542; x=1756119342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhCrBwM9JcxpOSa/4xq9lZhOpZ+tVZm/Xuce59lSt+g=;
        b=eOtClYE9+E5M8GxrV8siJcFCb2j8LillVQ+vuTmrqptqGnYmoq36JUVYm/o2OpBJcv
         veAUbwbLUKbnuvQ3rG5eaEaPD7Qp/JMQpbL0qI7WQhmw9UFcpuTQRtCfSfraN35xctRS
         53bXwXtSNUjCoA9BnHBUXsDBQS/95Vb8gM7qT4OcyHj2hJlSNY3R4RxBrU6t9kt/6NCc
         p2Sq5wQYBcU6cqqbcsnrFEWwSkdkI1zz2eK66KKDmStifsSzOdbb0yGE+2B97AUSFZo5
         EEciMNpkeOci8uQdfeKe1A4hnXZIEwMSE3FY8tED0WJ5M2uvVsez81doyJbSSjRgSB5G
         YLyw==
X-Forwarded-Encrypted: i=1; AJvYcCVbcVG1KIPruJAQSo5SQ1oT6aV7yfhxA7ylbVFZZ/Ez/ZPnGwMxS0a2DJWVQ0LDt94rlFkmvbr0mQWKJS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmoo8rG+u8z3fmgAuq3/M3I/7FPRtNmkroeI5TeTa37r721RPr
	j6DGLFyq3BD3suZX+8P6dKbzPJG4zxY7PX/k7BjHdA3IVz/qxB7FcxGCnZDdf4nXyh7fyr+rQCa
	0A7adOOH7BIgyEKT/c1ac8X6sI/cPc3Rt0B4o9Fs3+w==
X-Gm-Gg: ASbGncuxer/aRRBJ9ige7aOML5WSuHfpLZdnX38GlPzKuNILpMbT0m03zsGUrn4ULCa
	Jg7pOLfFgErFRaFPCD+xWE4+G2RSqnGAj+/Zju0sTg1Z3UKhGkMhIV66Hf+BoCU5DmsO4NOM0L5
	PZyQXtcMMG7ivG2AWPRvaHUI5zCRcGT5j7tWR6ftOQRlGvc8Bryr7qC6A/ZGo7sM9FWlfFfhOtp
	UpNs7jp
X-Google-Smtp-Source: AGHT+IGcvIj9TS8Vl2BODrUjbR0NXELcK/e2QeiUPAqKdd0mRCJPGizzZIo7+kpzZ5YZatld9/+/FIYtIUALm0/XKNQ=
X-Received: by 2002:a05:690c:74c8:b0:71b:f500:70c0 with SMTP id
 00721157ae682-71e6d9f2fe0mr141448187b3.6.1755514542321; Mon, 18 Aug 2025
 03:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730164618.233117-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250730164618.233117-1-biju.das.jz@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:06 +0200
X-Gm-Features: Ac12FXwUVZVP7DONXSC3nSG_-caOjBeAMUiQ2J8yKD5tdq7x2qJhlD5k1yH482I
Message-ID: <CAPDyKFp4HDMqPd3ie3R61EFWGGhLUE+f6mKHdZa5surfrd3jbQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Enable 64-bit polling mode for R-Car Gen3 and
 RZ/G2+ family
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 18:46, Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128
> bit it fallback to PIO mode. In such cases, 64-bit access is much more
> efficient than the current 16-bit.
>
> v2->v3:
>  * Added header file linux/io.h
>  * Replaced io{read,write}64_rep->{read,write}sq to fix the build error
>    reported by the bot.
> RFT->v2:
>  * Collected tags
>  * Fixed the build error reported by the bot.
>
> Biju Das (2):
>   mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
>   mmc: renesas_sdhi: Enable 64-bit polling mode
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
>  drivers/mmc/host/tmio_mmc.h                   | 15 +++++++++
>  drivers/mmc/host/tmio_mmc_core.c              | 33 +++++++++++++++++++
>  include/linux/platform_data/tmio.h            |  3 ++
>  4 files changed, 53 insertions(+), 1 deletion(-)
>

The series applied for next, thanks!

Kind regards
Uffe

