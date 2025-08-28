Return-Path: <linux-kernel+bounces-789186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271ADB3920B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9657AD2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B63002AF;
	Thu, 28 Aug 2025 02:59:22 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B96271453
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349961; cv=none; b=qea6CtgChsuiw2HfSFD3maeSfGX41wUtygLxgrr/arunjw7Gu0hiHy4yyxR10XvZjkpMWqHB1W/MiR9hzdpAlHFgQaPLRd2QBylM6P4lzOUXaF1P5H6VtRMKfbZNb2TnQzOUpKOH/cgPGsQYjeP1npTM86LQ206wCRzwsYMhxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349961; c=relaxed/simple;
	bh=geOKLfB21hUl8cX2mkx9LwJO8FFlkOY6KM/rnzAVpaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHgMKPK4QuprXMWGb8hDWWz3vTMec7Y2mejbAESZgPibv9i267x++NGEi17i5/zJ01GyaQ0wU6r1GFdGzlXjyP9G5t1NdYvzSxaR75O+1CRYTJP2aP8stYZG+Q7e6Ce+U7Lt/63fjaN4ds4KgJz39kiUrw2IZkjrw2lDmaKdgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so532122a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349958; x=1756954758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpKCLLWQN5UvJoV+eBAMVrPx3wPOuNvj43v4OMEG1XI=;
        b=SULlSxtbNNo2v9JdW3RnxBTQ5dgNEuerXV/t+y39krnESDSbhu0QVRzmIHJACVKLi8
         UzF/+xYveu3Mv2SL+OfGp1rg88+O3L6OryWJxbZmc2GxRZcRoYUFdumk53Pb0c/ixPrO
         mt2Muk/ZKVst0y8tL41m0sWqW5R/p9NiAPlcuNuZiUyMx4ZMxQjaLslHvUeWTo0r/u40
         SuoC9gpICaihNJVbvwvoduDyNNnZwTuTaYKnrZE6bndH9EoXzOloZ9YZNcao6FTGwjii
         XjRIt3vitEJ2e8HuN2t4hBBmfr4y1T8GNiOROrtyFEkwOw4Y3lXSDlTFsF12msur3OF1
         KfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLEbnsyXWsqo32+Q+2hGZgrqWMpg6S3Ba+GcGQHALIJ5USPny/6OJst4cus/hgsW4kmDJsA3eNJo2PNq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/z45SXsvRzgD8dwMXit4p4ycgEW7G4zmIvgvsXTlRGzN2IBdO
	TFUH2xJp38VURSTLdc4ZwuIAnEjhhxDnr/WX/UEsAhgneakvaWrCAGM/R8tqFHwHUVs=
X-Gm-Gg: ASbGncty2A5tvdFvDBrKwx1E9y9iaNIQ0hYn6C1rJMFTIpryZSdlefsQufYhGYnyRub
	gn6ITrbS8vYehAAJDZWfRw/69f/EUQuHyFihQb3p55lp1rHwSKLJVoRSO/EwW9P+P7eKDe9F+rd
	2HLRgWn7v8iNwkkoyn6uGhuxtqYXhMxroKgBHro0M3WYRJsskdDzlV2678MrPdonjY0Zu5lP34d
	wW3CjyABQR9XyDtnbH2wNrF6rnmW0xVMwZsomu8/xIeZWt69KyZAhkGp/ns4z+BJP5GtHwB0Dyk
	sit7I470tgCUwo3DWIHYH0y1gOjpFwzN/sb2P1nJ6Pg/d6DV7B9VD3P5osbtlW3gtu07xnbXNO1
	ugA1fXL75BHxUi/LuWJjPd+X1jQX8EIGIoWIG6dHP8VwhjfV3ZLYNRvTYLB/V8nIDfGMXmW/AIk
	dVQPCIKshv
X-Google-Smtp-Source: AGHT+IHI5jIpB5SSsXeGv5D3KcYhqo2mvR0QtPj+SIv3zGSJb5yojYvbQEbASKIyHvtFaQ7b2WokFg==
X-Received: by 2002:a05:6402:23c1:b0:61a:9385:c795 with SMTP id 4fb4d7f45d1cf-61c1b90afcemr17498869a12.38.1756349957681;
        Wed, 27 Aug 2025 19:59:17 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cd8ce1cdfsm335266a12.39.2025.08.27.19.59.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 19:59:17 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afeee20b7c0so3199066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULRmIOaX96eMm+e8fg5Rd3erFDaD/E6d+8HLnFmmTPnK52p/yc5WcGY7QtykaMByUCmzja6LK3jPBbG54=@vger.kernel.org
X-Received: by 2002:a17:907:2d0f:b0:ae0:d1f3:f7f4 with SMTP id
 a640c23a62f3a-afe28fd46aamr1873427666b.13.1756349956549; Wed, 27 Aug 2025
 19:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
In-Reply-To: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 27 Aug 2025 22:58:39 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_mgErxSHk_OaBCwzNXwPcwNsAQuAutAUNdJK2AU88w8Q@mail.gmail.com>
X-Gm-Features: Ac12FXyrolpUKa4Qy_Ohl39WRoR9hhvgyebGLIK4Y-M15o_j00lBGu62bGVkdGY
Message-ID: <CAEg-Je_mgErxSHk_OaBCwzNXwPcwNsAQuAutAUNdJK2AU88w8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/apple-dart: Four level page table support
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:16=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> The DART instances found in T602x based SoCs (Apple's M2 Pro/Max/Ultra)
> indicate an IAS of 42 bit. This results in alloc_io_pgtable_ops()
> failing as io-pgtable-dart supports at most 36-bit IAS.
> The t8110 DART design supports 4-level page tables. Implement support
> for this in io-pgtable-dart and mark DART stream with more than 36-bit
> IAS as 4-level page tables.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - simplified 4 page table level use in apple_dart_hw_enable_translation()
> - use "iommu/{apple,io-pgtable}-dart:" as commit subject prefix
> - added Sven's Rb:
> - Link to v1: https://lore.kernel.org/r/20250814-apple-dart-4levels-v1-0-=
db2214a78c08@jannau.net
>
> ---
> Hector Martin (3):
>       iommu/apple-dart: Make the hw register fields u32s
>       iommu/io-pgtable-dart: Add 4-level page table support
>       iommu/apple-dart: Add 4-level page table support
>
>  drivers/iommu/apple-dart.c      |  50 +++++++++-----
>  drivers/iommu/io-pgtable-dart.c | 143 ++++++++++++++++++++++++----------=
------
>  include/linux/io-pgtable.h      |   1 +
>  3 files changed, 121 insertions(+), 73 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250811-apple-dart-4levels-8f9ae8ac1347
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

