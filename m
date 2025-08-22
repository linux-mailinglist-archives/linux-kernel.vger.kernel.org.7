Return-Path: <linux-kernel+bounces-781619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53407B3147A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E434E6665
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188A26B764;
	Fri, 22 Aug 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShkGEimb"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248B2E8B7F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856749; cv=none; b=p+XYCLXSUfvvdvFbKRxGP0sRjzVOYR0nE1pDuauqujjqROE4vlwljn8LA0tKI5PgAA/DC5d3OsfK2XY6xd9yv0Lx+MUchPRu0tqfRw+XeeZ5lGh2CakGpEdnHvXJ5VKbxd3sNnS0pzVLtiho81pjsda3EvzrthyLZvaGNrVbma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856749; c=relaxed/simple;
	bh=7WEzRGVljcpFgpg5kYtiRuG6GnKMyevCXLfY3vki8nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOTD6N0OfYxMpXlgBU0EqdBObFG9jNtafp4+TZmP3PGUQ0/nys9rF6j8iNriw9i7MJKGk6+JlszeRvuCK4CkJhDiM1lLuYVNgH5zz3HhW+0Wdg3S0rL1VrOgiECxBSbY4hAggKnbE8y6VN8t5ixtgvgdxlpLKRh8KG6YXADK5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShkGEimb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60504db9so15279347b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755856747; x=1756461547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4jzcaBapb+6lT57he/oxZQhjVy95ULktosVCVAZaO2s=;
        b=ShkGEimbB6WTDwfaOIsjNTt3VPdnCBTn0Wk9MzSqERkfim0wxeQAdMvVfhJAjfy+Zd
         Smax5Iv5WJeXbIcEAASoNuBVuhPtydXJHB3V4VCKqUmYL4RZrptLV5MNkpOskR6OvAi9
         sflmH3AMRtOFXlkHNthZrb+ZGBwXILfRDMkCmnruqeeYbBB5qhtOUBYAQotuS5Bta+T9
         SovXRnG3Rpfxob8KdxqLl9tR0kiLpwgDE+LhDBiT0KjxnTdC02frTJ7G4vR5teqK1bFp
         XVYVWCbcKKJjyN6fJ2K3teSRelOchrHJAO3XVdmZ6mcBdNifq8qa8NFcImbnXiFwZRal
         AD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856747; x=1756461547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jzcaBapb+6lT57he/oxZQhjVy95ULktosVCVAZaO2s=;
        b=Y4bZmxip1LYuN5sJBi9Ilb4uwYnlgr7YSucyVGXRmilMUNvWsVqtTYcvOJkzY1dPZg
         caBDJdaZkyjjXt4KX96fh8W+MDc7E3KZl5zrnUCKw3kA6V5QZkTzX6tZQsvscqtLx9Jd
         zl0mdQQtUxQTd2Q441qnDw1/iR50hmEt7TG1/i/eLDN126Ra/ydNm//CuMepOZVzbB8C
         uZfxuJZUYA4pyYVeIbcHNaPLaGlQY/6Z2aFyfNj7yg7ekPOJzzaex0QqU+2gU4N/eAJr
         isFa+3kgooWhx7zAIceZ+RXG/VO/3xDQulCkYlMqYeOObYCRJO12KKpn84GR88hKOpzw
         NaJQ==
X-Gm-Message-State: AOJu0YxgwqwHlkn02DqVUVMC5bKX2WcRCwumLDwb+0lgXoOkpQrKCHIa
	fV5xkdu02Bm2dAuXa+lERwnWV6jXUT0CIylWk2EA3q4d05V6tmyqiKh01g1+MZ5kvu0TR1wBJ1E
	ceev67PhEambKROAbVkmoZ1a8KFq0JZU6Yp1irTI+nw==
X-Gm-Gg: ASbGnctpNQb4zpvg3sE4BbMP9EOxbX1rrDYPHh4oHunA9BL8jRbRa80gjabAuEpZgZQ
	fgdIvSiC72BNocZWmxyl+mNHsmuBmUtUoO0MJ1607wCqvzlFzYa3CJ4C3dpYB4QRVzkgc7cvWF0
	rx4coDEgs3PwFW2lxuF3Ij9eQEcLal9iEZbn90R+BrhT52sFtbVw0Rc11ZXBCIevu3hUgHkMJ5/
	loaCmjr
X-Google-Smtp-Source: AGHT+IGB9RjTkkD7B2b1TNcFgf/SbdNxy4Un5NVzcbV0bGgOMYvHf6W1mefgrwFYH3AHHfmz4nw0AMYxpykQ3SJwTgw=
X-Received: by 2002:a05:690c:9c05:b0:71b:66e5:9b54 with SMTP id
 00721157ae682-71fdc3d087fmr22061587b3.28.1755856747069; Fri, 22 Aug 2025
 02:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-29-david@redhat.com>
In-Reply-To: <20250821200701.1329277-29-david@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 11:58:31 +0200
X-Gm-Features: Ac12FXxyJ-t2LbDQilDuu2ZIZImx4clXac153FHlc5EW2k5KLO2D2OEzTjtN-RU
Message-ID: <CAPDyKFrvsyB-1Gs5jW92o2RAs6i0dF6sPxGr7us5QZymFcdQdQ@mail.gmail.com>
Subject: Re: [PATCH RFC 28/35] mmc: drop nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, 
	Lars Persson <lars.persson@axis.com>, linux-mmc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Thu, 21 Aug 2025 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lars Persson <lars.persson@axis.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/mmc/host/tifm_sd.c    | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index ac636efd911d3..f1ede2b39b505 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -191,7 +191,7 @@ static void tifm_sd_transfer_data(struct tifm_sd *host)
>                 }
>                 off = sg[host->sg_pos].offset + host->block_pos;
>
> -               pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
> +               pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
>                 p_off = offset_in_page(off);
>                 p_cnt = PAGE_SIZE - p_off;
>                 p_cnt = min(p_cnt, cnt);
> @@ -240,7 +240,7 @@ static void tifm_sd_bounce_block(struct tifm_sd *host, struct mmc_data *r_data)
>                 }
>                 off = sg[host->sg_pos].offset + host->block_pos;
>
> -               pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
> +               pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
>                 p_off = offset_in_page(off);
>                 p_cnt = PAGE_SIZE - p_off;
>                 p_cnt = min(p_cnt, cnt);
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 85b49c07918b3..3bccf800339ba 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -323,7 +323,7 @@ static void usdhi6_blk_bounce(struct usdhi6_host *host,
>
>         host->head_pg.page      = host->pg.page;
>         host->head_pg.mapped    = host->pg.mapped;
> -       host->pg.page           = nth_page(host->pg.page, 1);
> +       host->pg.page           = host->pg.page + 1;
>         host->pg.mapped         = kmap(host->pg.page);
>
>         host->blk_page = host->bounce_buf;
> @@ -503,7 +503,7 @@ static void usdhi6_sg_advance(struct usdhi6_host *host)
>         /* We cannot get here after crossing a page border */
>
>         /* Next page in the same SG */
> -       host->pg.page = nth_page(sg_page(host->sg), host->page_idx);
> +       host->pg.page = sg_page(host->sg) + host->page_idx;
>         host->pg.mapped = kmap(host->pg.page);
>         host->blk_page = host->pg.mapped;
>
> --
> 2.50.1
>

