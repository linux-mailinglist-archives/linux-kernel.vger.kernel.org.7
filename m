Return-Path: <linux-kernel+bounces-770614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B4B27D17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706BC7B09F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215262DCF76;
	Fri, 15 Aug 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBg5CEFA"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EF23AE62
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250102; cv=none; b=cJYjr7X/XZIX5GmXgwoV9VieXBT0SHfJfCaqDOBb71qMYx3b+kco8iws0zyO5XdG2xrejnAJjXX8hg6XUpqWpAQCcZ3281YOSeqUjL/p64N/wWCTEFTdTMSz3GlE1qdXjc3wMGhxU+nxIP+qplvvyXWvDIKR23YMmv6lLlHGRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250102; c=relaxed/simple;
	bh=6I4Pw5TKCEn45FRljArRCZNRwHouHU6aAxDu9EhSjp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmS1Ee2WMFaDFIwiiNVWbywrjh0GjIle0RF4YKsS2D5897nOGeaKxzOIOcfzhQQO7a9LrY6k5vPJ6JtM3bvOPeNKXHPvN6QNFw7bizN8L0jQLX4cuJA/zjDymatKZtntAOQp1xS5M7WRaXhT5q3cZov2WzaFCZZVp6JYPol3fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBg5CEFA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-890190f424dso414830241.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755250099; x=1755854899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SY7azga38AC43eZjntbDfbz5wsWadF20d4ruCI9wCA=;
        b=NBg5CEFAG+4URNJN+FDPndmdxEgr0ohZyVmVpCbK5noVOU/7PMvZji1qa5ERGdsxWY
         TY2a1GLs9L0USD7BjcJNJhvueLqepXbYieUHCHjexrLfqF7O+pDobUOBNe75lE2jd15x
         IlTqeaNF43j962UWHu0jxOwod/Zu6qnac7E/UgCOB0jvIFKcX6zAh7VT5Vuz9Wpg/n45
         qYOCYaiKuSs15wqd54Sr9PT7w9sV6YHdw3nc7wyf1fcSawBzD08GCy56Q4cDqxqEv1hp
         H6wlY+cWp4q8gbIbDuW1SdZS5iyX3ahud5qDMgUMnaRC9KV0tHz1sCUKBHQdc85dBaXF
         GpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250099; x=1755854899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SY7azga38AC43eZjntbDfbz5wsWadF20d4ruCI9wCA=;
        b=GmGOmiANeK6LsXy9JhA26leaX61gBbtTKR6Sp5kZb1iapxhNHsseu+SECSDUb9Yi1C
         lol+/935eOiT40Ugq6qJccIqiIirlFFnf1zpjtKTjT06pJL9gVOVyvj3xwS7m2cBYD4h
         lCET1AEsSWs5BU/tiRp/DBO1LOI2/h31miLR5Q+j5a/W0iYWQHGZtfAcMk+gklzVTb44
         oOf+13hIVBmVlwWYf+6dUE0UpNZtTIUPrZr2W44YpdvUzG3+WnAk3fDezfQtrJbluDfG
         Ksfp70TafBGwuYsMP+p4agYeofm7bONDwYcH5YmgJo8QnEQwS7uudVc8eWSBoXtSyEUO
         iKUA==
X-Forwarded-Encrypted: i=1; AJvYcCX4y4yriBzcR0UO65x8u7GI9hcp3f4PyT+7nP8Ddv7wMPe1pZANvkN4c5KLlEZnHj+5DqLqMaBAOzb8Mp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IVMPB2AD6pKoTN17IMf9ydXr2V8rVjnaLSiNA4Zt6+1eqae+
	/x/Wez0dnJ/S4P74Y1OlBFSnQbXAXM/V3zssQLDXojF9oN5PmRYTBgu38gh+6rMuROLl5UgF+of
	PovcfriA3ByDrcP5Fo4wSiUdeOEmMt1A=
X-Gm-Gg: ASbGnctA83SGzxPaxLGnwgM4FKQPZ2/eySjSqbWA/pbWvn0E9D98yeA5+hM3rUi779t
	HQoljbENNgPeGaekv0PPWrKn4q39xBeDuMwtc8UcVOrXwDI5TSzv5isMCnlRbwEu0BS05c9AUgQ
	3KnQbCS2dDaRaKO7AWw4WLVXQnokOPDoRc4sJXYivKFbVfjceRXufWwt0RSXKXDPL/Izdo/VqKJ
	j2ny3P10QpFs6ckUA==
X-Google-Smtp-Source: AGHT+IEd+wm+bh9KCXhSmKE1cbEYe2ZPm9PghWfDPTdgqVBPQgaBFpz8p76BbDZ59z4Ye+T6iYDiZeJiISz9ZVH+xcQ=
X-Received: by 2002:a05:6102:6ca:b0:4fc:f151:a644 with SMTP id
 ada2fe7eead31-5126d6ee4d9mr290509137.27.1755250098654; Fri, 15 Aug 2025
 02:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814133527.2679261-1-xiaqinxin@huawei.com> <20250814133527.2679261-3-xiaqinxin@huawei.com>
In-Reply-To: <20250814133527.2679261-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Aug 2025 21:28:07 +1200
X-Gm-Features: Ac12FXzJySFZzD0VqbkNo0-i0HU2BPy8np5Y3JRuhFI1t8rLawDpyVRcmqeICtQ
Message-ID: <CAGsJ_4zM5Qcr88Z+Rs_XwFcEJ_x+tZMUXycxDTHE+vCsydQYdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add myself and Barry to
 dma_map_benchmark maintainers
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:35=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Since Chenxiang has left HiSilicon, Barry and I will jointly
> maintain this module.
>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5f17a58ffee..21e623b53a7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7219,10 +7219,11 @@ F:      include/linux/dmaengine.h
>  F:     include/linux/of_dma.h
>
>  DMA MAPPING BENCHMARK
> -M:     Xiang Chen <chenxiang66@hisilicon.com>
> +M:     Barry Song <baohua@kernel.org>
> +M:     Qinxin Xia <xiaqinxin@huawei.com>
>  L:     iommu@lists.linux.dev
>  F:     kernel/dma/map_benchmark.c
> -F:     tools/testing/selftests/dma/
> +F:     tools/dma/

That seems a bit odd =E2=80=94 this change should have been included in the
previous patch. Alternatively, you could submit the maintainer change
before moving the `tools/dma` folder. In short, this diff belongs with
the folder move.

These two patches appear unrelated. Should they be a single series
rather than two separate patches?


>
>  DMA MAPPING HELPERS
>  M:     Marek Szyprowski <m.szyprowski@samsung.com>
> --
> 2.33.0
>

Thanks
Barry

