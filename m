Return-Path: <linux-kernel+bounces-762745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E2B20A88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43EB7B41DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5F2DC33B;
	Mon, 11 Aug 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USVlZdbn"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792D1C27
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919528; cv=none; b=rYyUaBfeoeH3DWQe9jc4/PGIe9AKkE/AHHmX+2+tXBEf51H5gZIwhGnfrIPNGztg92CYqm5YE4MPNCNpaDSYmyNaojPvUAPoSuFJDuuMVWNHFCUv3W/0X/j4z7w+ZXok6kTyutWC+x85fssV9LWxcPDxLhrZOmr7iWELL5WdLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919528; c=relaxed/simple;
	bh=pjXFp6aj8CW1PKGAs2uPvFhL9pWIQG8A0O44FY3yZ1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeYONm+BQUK3+eLPlfyW+F+1Ewwl0yi4y/0pHKMr3uJCxqyFoa81kCVSnJxFfej7ms0SiEFeLCQ6uASCqSUHEKVr0xIm5H8YMSlW+aOkFtrNxt3f9gHLAsdZ0sdHO1N6WqNhwnrpr3cvORa+lcEndXJc92pjY6eIFCzc7pFJg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USVlZdbn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7886bee77so3294980f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754919524; x=1755524324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBCgH1jXbD8cQk7vL0lpvlc3a5C92LMaThlyJ1yPJn8=;
        b=USVlZdbn51LotLurhkplaUapl5K5tRf3f//LQH38+P8rrRUZv5yNJlkhnyDFQLQLiB
         lrKTqMirNqqRaC+m+0YaFdo3Dfmc/vpIpBXE4y5BDXbqfZ920N35VONX65BDI4PYXKv8
         +B78DpVNfzkmwptrmqyBq2AwjqwvsxreaaL6hqL0o2S9SrvjJn6WKfWTXQqnBuqBs38A
         Qqh99YVWvOGKILplucyHoRauBe+7a9dHPQx+ld0ehxb8YCMCW+Iwdl9wY7LKofR2yLFF
         ADSqRz5kUGVjZvQv9R8NLnVlqwoIZvdwM3rxXe4v4P6xJ15juYmcdTGnbeo/fR5BMHhK
         XFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919524; x=1755524324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBCgH1jXbD8cQk7vL0lpvlc3a5C92LMaThlyJ1yPJn8=;
        b=omxkkIiLE3GpjdP1u+dpwNHyEhGI0+l1yIGo51/Q5JUWLKcDEC8BfO9cgCXdtwjQ8r
         MQHluPH6h1khkH2bl2ywGGdzIdjnGBBLhznOYz8MsJfKyinKhhyO2vQB3cmZlGMDf5sg
         /zbobo4zRDVsg82XYup7w58oQKdtPV7/O0asukGS/8NwZX9/Kjegx5zY4m8R0Yg0PwgX
         ySO9uxO4iaIRpJhaCtsnchvZJNANbbKe8wDItevHIgk8rcQYSD1CEB/0QgrZAim6CPVf
         5a7LDZjlzF+r44Vmpnrv4GDuV7X/8ZSRgxF6yWaTiK8VtCj0kL5/TeUJIVPVfbF6uIL1
         23IA==
X-Forwarded-Encrypted: i=1; AJvYcCWr1Q3WNRZk9XkQt/zHcMWDpVMqPUZTW9CfKxL2gBIl4ielAC84uI86H/pAWPCBYYpi2ag0VmToFGASBLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYrOx4UFaWBVLurzBBgvc5jkDxE2VpngcEy3qCoRw4LxW5wTH
	GtRT9wftGeaSC6L1efZEynnKpRdQLByLoxNAmSiB3m04show98ssrJokuA4oldTawdb7ld241H2
	cR1ZIZmDpZKPNcnlODqjyd4B1GPikl/k=
X-Gm-Gg: ASbGncvQaQ/UMBaR0eehrBieuF7qExIj36HeIFGzoiKVIdy6hafuseQuQeYhtm251pb
	6zB0S1ZRGRisNL84G8waQ8COy6LSgLR8GLX/e/6nSeY5wWH5NOUN0qKah6Pf1R7gA8fyyU5LM6r
	jZOytNJDcS24rUuoePQuC+OZ7rPasd4kmRw+0YMuRa8Ag9lIDKAFhxiLrV2Z6grcGnxVxMpPevo
	Mahnz+U6ukUQoDM
X-Google-Smtp-Source: AGHT+IGxUMxKS3K7mls/h9vXG26wkyVH1sxQQWEW7+ny6/XvX40fc1DRmX5UXk1P2ba82JVPojlxTCApE8OfHIL95wg=
X-Received: by 2002:a5d:5889:0:b0:3b7:90f3:cd8a with SMTP id
 ffacd0b85a97d-3b900b83c9bmr10624691f8f.49.1754919523921; Mon, 11 Aug 2025
 06:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811034257.154862-1-zhao.xichao@vivo.com>
In-Reply-To: <20250811034257.154862-1-zhao.xichao@vivo.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 11 Aug 2025 15:38:30 +0200
X-Gm-Features: Ac12FXx7kQl8MpZMBlEL69UNklwxkty7tb561BkfRgxFfLERdIDidFrWBBBiqgk
Message-ID: <CA+fCnZf8XVydjMNRfR3JDeE=3i_0p+w0gTP8ep43LVU8k2Tsxw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unnecessary pointer variables
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ryabinin.a.a@gmail.com, akpm@linux-foundation.org, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:43=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> Simplify the code to enhance readability and maintain a consistent
> coding style.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  mm/kasan/init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ced6b29fcf76..e5810134813c 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -266,11 +266,9 @@ int __ref kasan_populate_early_shadow(const void *sh=
adow_start,
>                 }
>
>                 if (pgd_none(*pgd)) {
> -                       p4d_t *p;
>
>                         if (slab_is_available()) {
> -                               p =3D p4d_alloc(&init_mm, pgd, addr);
> -                               if (!p)
> +                               if (!p4d_alloc(&init_mm, pgd, addr))
>                                         return -ENOMEM;
>                         } else {
>                                 pgd_populate(&init_mm, pgd,
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

