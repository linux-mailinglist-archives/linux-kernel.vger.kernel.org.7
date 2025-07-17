Return-Path: <linux-kernel+bounces-735903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EFB09505
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277525A1F14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80A2F6FBA;
	Thu, 17 Jul 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxtAkz/Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586FCA4B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780848; cv=none; b=Tfz68UpGGIbX7JQcbk0ev41l3OEXsx43/6FldpHDC8ZhThKdteeqoMZxJiS+Jot63OQzJWDbMq2FllsSXYvD+fxWBCBxfEerCPdNhZC6c69/Qbkqwb6qOQysxm8mBIqUdXBSzT7G+SUMDEG4EyKd7UXCTCHaD0pReZFwKO8KTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780848; c=relaxed/simple;
	bh=nddkejTkQbhdtNiwie2EjwSNY7WrQ/jLQHkOGnnHa88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdfU0W/wSc4VLI2GdAry99ZhmZjNEIdIaZqh49JCSZFQWZD0iVlS9c8EcxzhxE1EURxjI1y077QL1AwJG7JB8cPYz4aFglKXcKA120z++HAvghbjzVWZ7cIh4RuPg9oLD0ICDxKvbp/W+CLdv39yA8+Uv/KkohSaCkJON2ubLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxtAkz/Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752780844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fp4WGQlZoIQ4aSS3SrbReMyDkTNigIw2l/ddrnupts=;
	b=LxtAkz/ZywkKyE2iJnS3MhoWA+8xeBPs7+QBa3YuwY3covcx0K1zD/p+C5jJgzyFeBnbji
	ATLWVgHMLLI6v0k1YzKvxEJ+E686p4r5PlPY1fOewcjf3iNOhACD1KnnmJhuS2yjNUFlPx
	i0xpV2Klrs6pjTw9zpMaxsSWopms220=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-soVFusZ_Nw-ndv_Rh5CStg-1; Thu, 17 Jul 2025 15:34:03 -0400
X-MC-Unique: soVFusZ_Nw-ndv_Rh5CStg-1
X-Mimecast-MFC-AGG-ID: soVFusZ_Nw-ndv_Rh5CStg_1752780842
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8769aa1f0c7so16669339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780842; x=1753385642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fp4WGQlZoIQ4aSS3SrbReMyDkTNigIw2l/ddrnupts=;
        b=gPDBkLzJbLL4U+AVgvGqqz5kpSRwPSY3od9DyxK/mLCSSZzIC8GceN6e4KM+e/q5CB
         lp9Oli5Ed6xN0Tp6TCnQpl5UEdaOhXLZLHCTFiLEhKJErkmTFVVvbHVMB1vh2SjgtFya
         SeZx3XmKOJrQMmN8BENQTPF7RCEhT4YM7pd9qFXorbICypHsh2sY8OENvnhHH6+WYACd
         vNvHsj2m1jMePZo7ZPIdwkoXlIATL61/uNjpK83Tdq3f2vRtj+v1Yadv0D7V96xZ9peP
         /DSU6PjqOKImeY346Nddvqh6bLL+lhvcpw8yGUPIyO1m4lJ81CsMvixAMjaOO8pSH0e3
         UHBw==
X-Forwarded-Encrypted: i=1; AJvYcCVe1C8x3F/+SGv8MRM1lxnCQTLOVgLNfg5zUiefWq5NwFy9V+pmsHVZRZ6w6spPjoWjE7W5jO9JkaGnpZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMPhuxBHkgcWZ5kxGCrSYiE75LRyOp3Cmrh6HhJHNR/PWHzqW
	9G/PeDqLSelxZTDzXLhZWVtpxCGCom+SX/vLlTGyearHEsAObxopKX137LHa4pcOMc+eXQ0EJQL
	vmaXxtFgulLjvVaNmomyrCqWDQX/1VGJU+jFbFRLSY/zLUaEYRLvkQh4ZPQWF7T1g5g==
X-Gm-Gg: ASbGncuc+RWUg03PfGqB10aYBDGIrHJp+fNDIbZDMaAJKuQ9svWAQvaM6oG9DbGSXR5
	L/TrwOejiwq+wWG7KfBSjffxT1AR1CXmPDO7PEkjMVPoYWTcHFoNVY2iqJMUZ7u/ugIfwrvd/LN
	/yt3MFbVZuTbwfnDjl+hh/rIOvKDMPqRSlzUsVqoTIxGVGQx+EEwuJGbHyzBx9h3A/nqmW/mWkH
	KQRLfSfURZFq5Ng0ACJeYWsXrgEAvqb/ioGjjMw74knGKwLyOwoz5lAU5akKerCXf4d+HzLUQgB
	mN3oOjiGlKAZIr2GRfnfnQOsaaL0vdlIle/V1RTbbtk=
X-Received: by 2002:a05:6602:179d:b0:879:c6de:4ee1 with SMTP id ca18e2360f4ac-879c6de52c3mr179459739f.0.1752780842019;
        Thu, 17 Jul 2025 12:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGcPUAFlcPxlxYVfmFPVPkZyaIiTp1WBDbVKplXnle4fNBGWomfejbSdHQCNplCxa2xcDo0Q==
X-Received: by 2002:a05:6602:179d:b0:879:c6de:4ee1 with SMTP id ca18e2360f4ac-879c6de52c3mr179458639f.0.1752780841510;
        Thu, 17 Jul 2025 12:34:01 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055653244fsm3692989173.21.2025.07.17.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:34:00 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:33:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
Message-ID: <20250717133358.1541e5df.alex.williamson@redhat.com>
In-Reply-To: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
References: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 08:49:04 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> CDX_BUS driver uses msi_setup_device_data() which is selected by
> GENERIC_MSI_IRQ, thus compile testing without the latter failed:
> 
>   /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
>   build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_device_data'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org/
> Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cdx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> index 1f1e360507d7..3af41f51cf38 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -8,6 +8,7 @@
>  config CDX_BUS
>  	bool "CDX Bus driver"
>  	depends on OF && ARM64 || COMPILE_TEST
> +	select GENERIC_MSI_IRQ
>  	help
>  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>  	  exposes Fabric devices which uses composable DMA IP to the

This looks incomplete to me.  The Makefile has:

ifdef CONFIG_GENERIC_MSI_IRQ
obj-$(CONFIG_CDX_BUS) += cdx_msi.o
endif

The call to msi_setup_device_data(), the conditional inclusion of
cdx_msi.o, and cdx_msi.c itself were added in 0e439ba38e61 ("cdx: add
MSI support for CDX bus").  That's the source of the issue, not the
Kconfig update to build under COMPILE_TEST, but also the Makefile
should be updated to statically include cdx_msi.o.  Thanks,

Alex


