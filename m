Return-Path: <linux-kernel+bounces-875814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79756C19DED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D18D1CC2A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60D23D7D4;
	Wed, 29 Oct 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="KUgcSda7"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B25253F39
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734678; cv=none; b=kqXyPfq6LZcjE0Gg/2xyL/zDc7cyvKcExphKZVZNzFIAv0a2L6Brzl7fiBytPRkgmN9d3ywdpyOFggJmorrWgR27po3tqiB4p5c1rYPRFk9zyySVpL9L4JAc8mtVIEE2/iI7x7caR7CgT1Xh+XUGrw9k10ndGtPnQwXB458Wi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734678; c=relaxed/simple;
	bh=sOHeG5cN49D0DcSt5Q19c6bG/mpse29l2rxIUgCAzPg=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5PWNoclI9Yn2mXT49VTuiuD/gLpyIZMhj0Dprrxg9CjRvC/iTMSPHMC1Byq2Of4Dwh3740JR5z9fKn/T64ET1XBeC5gwXP4N6q7aJJZftUm+ZkHanjItlDnoL7POtK14z0r9+dXdH2ZStvfv40I6OPYcFX3yDfLo7xL5JJricU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=KUgcSda7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CE043F718
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761734668;
	bh=V0fXLNytZLyk2YPIXYe5tFjfSCJQtOqgtquMldsZjLo=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KUgcSda7v8ckgKnlwX9382aM/M4AwCpZkYN7AlgOc5zO6rVlN/29GlcpsFDoikQEq
	 KSWHEprUvHcXOCA0iGafq35f6WwmK6I5lvDQIKBOK2p/+EmyWJq3ZU0qBQls7diJgo
	 4W11pM88PXX82NoVAGdVBN4QfmAfg2V3BLFtAUG4u7pi4F+h20RlynB8QXWpzuIFFX
	 Ex+6w1eOmL+POsGJBUwyhJ/yotZLAoTdDLZ9pbTB7IbeF4ULL/njQTD/2DWNQ0Jodk
	 s2ehjJ/Q+74xg6CysG3rHSlC+Zvtl3VoyV2WV+5tp/5vJ1yicfq4R83Pn7+G/YZvDJ
	 4iSjCmNKqebQg1GjW//rFJktyCWG09kWXL1aote32Tegh88iKvHEGr9ZcG7eDRaH13
	 WoaOUIRjeYx/wit51zLcUcxiFZz3WgCOXiJswTux5zDyGKBkgM/6bW6tfmMXPhtX55
	 WUIaw5+tvHRrrJZFBOIZR/kmiVQzTEIK0UvUz33z6oRt+dye+KiY+5aWzRHfXDxSW9
	 jIg19AWcckUZo6r1Ev4YEydCMuKQ0wvIC6exOcXrro9TwGX+nogeFqgJ/6UO3gdg9f
	 ycwOcwoTsuXXtVgJyVIOqZQs5bJfc9HaJ3nZ/dR2u90FrpWlh9qEWKfkpGmTjKSjuO
	 9snxsj0fa9zIVC3LEAgWG4nw=
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5db34e16abfso3026840137.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734667; x=1762339467;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0fXLNytZLyk2YPIXYe5tFjfSCJQtOqgtquMldsZjLo=;
        b=IB6TKc4ul4u2Ni5RVWBCXcRbe2i/QLOTkCyh3P7+DGormrczGqD5cb8+l5HIU4kmLI
         trkIqhUWotA3L3RrCdgvZ9fROdO9DPNmcPyTdednldhnHEUSn9F4Et1ivNwpn8WuyZ/j
         3aBX70oAAKL3DKFXa0mN/jrjx0ZmsmLO2ItIxQuynsBtbZrgDWKGXKs/W4TWqDLiNeFt
         txgA5JQRE3NMGhTKYVvPgopmyA/ZESqrLre71GfuuwvyD4nZdWhRh1wfISTQFGUf/+Ti
         yrraVqHaDdrPhfejsHAc5jzDcOB5SgvldeG19BnSj+MZf+XZ4M5TxQtiInVI/UDU/7F0
         60Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWel0sJXYvqfnVw6BFruhiZ10IheKipDp9EvwSXTwYmHweakHuIXiF4Q6mk1+OMH66mYqYThdJi4JsiLVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0+uWSbSaM/zvin/3tFtQriVnks+BxFs4PPUrg3Kk7llctl3j
	dZFPJlyl1lztvPGfM8prfXbl6pljmaHalH5YMrAns433PFKTHG7v+xLEZZ/DD0YX6rBp9QXJCmJ
	j7ifOeKVcgm+v85joGep9z6Lvb5bnqCB7hlgB+5lz0l5XEQUbnhWwYB4/eKlbo+i0Qm+cS2vcH3
	ZGgvShdxDDDETvq/XuD2zu/7UQyGsFBXofpdbCfhDvo+PWlh8Nvv/vb37M
X-Gm-Gg: ASbGncuCWeR+cSkv2RUJUZHmXoahJRIVrB3WpAp6YuVzusULMDos0Ll1fwMpZwgeim7
	i3rkEH93Re8tezkoDrRBGqGNyQ5fjIaoXsd/UbbktpaWxpt69a50mlT95pIbURtmGtbz2rzJt+X
	peWp0hMHyRCY2xoYYc6tPy3CyaU6G8TDlynzNb5d0+eUB0ykfwtvQCdaOmSnghfyhkRJ6YOnWPb
	2woWJ90wl6G
X-Received: by 2002:a05:6102:dca:b0:520:a44f:3dd6 with SMTP id ada2fe7eead31-5db905b1c78mr499488137.8.1761734667203;
        Wed, 29 Oct 2025 03:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrvsaT17GcF11Y07yPaEH3PHInbBmPpeRxqjkwSa39c9aiOCgJ/LnnUPj2EbAtqZSoycaQDJmuoIVdQyPt07Q=
X-Received: by 2002:a05:6102:dca:b0:520:a44f:3dd6 with SMTP id
 ada2fe7eead31-5db905b1c78mr499483137.8.1761734666843; Wed, 29 Oct 2025
 03:44:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Oct 2025 03:44:26 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Oct 2025 03:44:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251029094429.553842-2-jiangfeng@kylinos.cn>
References: <20251029094429.553842-1-jiangfeng@kylinos.cn> <20251029094429.553842-2-jiangfeng@kylinos.cn>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 29 Oct 2025 03:44:26 -0700
X-Gm-Features: AWmQ_bl7oCY_kQJcWc7-dqRtKvoOuAPTtTsC7TvWy7sH2sDNjauX7GaF92P7jqM
Message-ID: <CAJM55Z8c5fy4Gy+6JRy_p4=4sbMuGbKyNMQB4cwUdNLcFjgLEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Remove redundant judgment for the default
 build target
To: Feng Jiang <jiangfeng@kylinos.cn>, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	masahiroy@kernel.org, nicolas.schier@linux.dev, palmer@dabbelt.com, 
	pjw@kernel.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Feng Jiang (2025-10-29 10:44:29)
> The value of KBUILD_IMAGE is derived from $(boot-image-y),
> so there's no need for redundant checks before this.
>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>  arch/riscv/Makefile | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 3998d4036f15..4c6de57f65ef 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -134,21 +134,6 @@ endif
>  CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
>
>  # Default target when executing plain make
> -boot           := arch/riscv/boot
> -ifeq ($(CONFIG_XIP_KERNEL),y)
> -KBUILD_IMAGE := $(boot)/xipImage
> -else
> -ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
> -KBUILD_IMAGE := $(boot)/loader.bin
> -else
> -ifeq ($(CONFIG_EFI_ZBOOT),)
> -KBUILD_IMAGE   := $(boot)/Image.gz
> -else
> -KBUILD_IMAGE := $(boot)/vmlinuz.efi
> -endif
> -endif
> -endif
> -

I think this might be a leftover from a faulty merge. The original patchset
removed this part, so

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>  boot                                   := arch/riscv/boot
>  boot-image-y                           := Image
>  boot-image-$(CONFIG_KERNEL_BZIP2)      := Image.bz2
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

