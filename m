Return-Path: <linux-kernel+bounces-781618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5283B314A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28750726DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4912877E9;
	Fri, 22 Aug 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdO6xxJ5"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0D1BFE00
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856745; cv=none; b=AqZ4s2XhDy1uPruwa/a2r43ez+9t+FLBrdc3h9g6QBXs/s0/qddwoKeDYnSV7oy2OB19tZpx8oXdvdtoHoamkAjRPULNugqrrQ/0Qz2L7eEiiei+lZ+n7vAPIoWytPp+WTcpulgPvmrKQ54mZ3g8F8S08X1cdTbDj/LhuOw2MS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856745; c=relaxed/simple;
	bh=O3/7A6Wz95KhbbQsG2Mm37l0Wb0s91jJ7cABoe2MIkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAddG3d8O3xGNrkZEKCH4GFsaPyhkxkZ8cIj57lAsUxAAmB8SlESSSeSVGt4DyzR+vYU4LTvTOsqHSDb4dQhtn8HBQps+19poE6vVI3HUrnEhhCM4zuG61wUbRJsHmECVVzCWrtLahD5oV6I5fIR+q9Lp9rRkFrU8uemL1IXjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdO6xxJ5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6059fb47so15732397b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755856742; x=1756461542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MupVyM5V8S7xfEuqt+V4G4FxecFOk8NDMM0guvbljvg=;
        b=hdO6xxJ5ooaju0JRSsZ6fWy8jJjtB82L38LcvJaWk2Crbg0484+KDnbNQFaPIkk/tW
         5i+9rV27M527Qkzoqs4NiIV2rsuCcENTUjBQnALQ8jDEXo6jIZajTQNZR3zG4389GsRU
         QSrNTVi8nBlDJDaqnPwalG+UOXAdMgF/K0bEqet8E6pSWfZiatP9cT5SMfp1h//6Ku0Q
         pN33mIBeQ08laY7f22nuz4TnCHwuxWcgd1BdG6yCzKSKl97cFYk0iPq+Nl3jaGZ/R3ut
         fJewn/hzaB2qXCXZkBQN0nsT9VlucliQE7S9vzt7d4Hzup8AzzlOOf2jqxaJVXHbmnDy
         IU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856742; x=1756461542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MupVyM5V8S7xfEuqt+V4G4FxecFOk8NDMM0guvbljvg=;
        b=pBGsLRsvK6E7eE65q+jwnmuSjmv7o257IrMH63Jov7lAS1nWR98l/iJhEIMwrf1eB9
         C2Z/FqweVs77CuQ+2Qxkzg2iIINq2rQiwWzQTnyfiPOrEOUtZ3iDlY8rsjG5uEDIRT27
         221F5hHUBlSFeSqkRsCvAVf2HUunWaz8fdE9HhRpZEsWMj6nvv007GkfiUfNGpBJnEaD
         NqcRDMnglmmLGS+AmwOnec82Cf6Zm86WEy9TiteQUISuMlFIAaSxqt3dJe2CAz8ufXv4
         zlKej6becmlU0Vw4IehPIG5hPKNUEJ/dj5sbdiK976FBHJeROrQLdaxn7q+SdnKcbDhf
         96YQ==
X-Gm-Message-State: AOJu0Yymj1VlhnlCoOb4d5GYqrgbazjT8rns/iWpBpgDdua7HCTTT7PN
	Afq3SBhKA0tuiphEcZXojMzTna4j6Q5VDY/DMp8aJDnFpNt6A96xUdelsoZ9PynPG1uMzV0YeER
	x76XwBgdj3zA+d8ZBY1dCVEOMWCYhAKSH3C8L8cxZqA==
X-Gm-Gg: ASbGncsNlnYLysTuvSYVHuvhwnHi2wXjtmvp6SBvgKb7Em3ZN4k7gOEoGX555PnbLmP
	w9O6Q5lveXKKjxCkaqZuVggCN1/BDlAyFGdyyX57nwrwjyq0u66wlZZbTEpZiwWjP46KvoA2WyJ
	pQBaQtrX0hXm1rDzZDoFAVPV6Pt9Ontzbv3FB+sq1TuuBHItU+iRBjbrliR0OuMVjJlOjRAB8CO
	wxyQUdM
X-Google-Smtp-Source: AGHT+IGW1UTX6fQaw19toVL97OISC/Ry0Xp6bS03YAWQ8SWHpLi2Fv4YjzcA1kwnxqqHARhMhn919UITNadOtX73TGY=
X-Received: by 2002:a05:690c:7006:b0:71a:1bbf:bc04 with SMTP id
 00721157ae682-71fdc30ae9fmr27985117b3.19.1755856742203; Fri, 22 Aug 2025
 02:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-28-david@redhat.com>
In-Reply-To: <20250821200701.1329277-28-david@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 11:58:26 +0200
X-Gm-Features: Ac12FXy5YAgos3FlxeTAUjV_qUtOvnPUJMl5UU6P6i8dKRZPvTVLextRAtA1LQY
Message-ID: <CAPDyKFrMR2bfnra1hWiLwqTqt7AFgALHzYCn+35PqU_wq+GhBA@mail.gmail.com>
Subject: Re: [PATCH RFC 27/35] memstick: drop nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Thu, 21 Aug 2025 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe



> ---
>  drivers/memstick/host/jmb38x_ms.c | 3 +--
>  drivers/memstick/host/tifm_ms.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index cddddb3a5a27f..c5e71d39ffd51 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -317,8 +317,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
>                 unsigned int p_off;
>
>                 if (host->req->long_data) {
> -                       pg = nth_page(sg_page(&host->req->sg),
> -                                     off >> PAGE_SHIFT);
> +                       pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
>                         p_off = offset_in_page(off);
>                         p_cnt = PAGE_SIZE - p_off;
>                         p_cnt = min(p_cnt, length);
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index db7f3a088fb09..0d64184ca10a9 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -201,8 +201,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
>                 unsigned int p_off;
>
>                 if (host->req->long_data) {
> -                       pg = nth_page(sg_page(&host->req->sg),
> -                                     off >> PAGE_SHIFT);
> +                       pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
>                         p_off = offset_in_page(off);
>                         p_cnt = PAGE_SIZE - p_off;
>                         p_cnt = min(p_cnt, length);
> --
> 2.50.1
>

