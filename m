Return-Path: <linux-kernel+bounces-735956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64681B095D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCB71C28075
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27FF22541B;
	Thu, 17 Jul 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnX2EUUW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05A21ABAE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784845; cv=none; b=BFDVZlhvCxB7EguT5x/0MgLv9v7DZ+dlQHSpXeAISVuvI4oedpenadipEqxEVQ3QeHGeU6aJVIB6Rsgtp5xmPef38u4j/JDhv6YDlIX1BZElpjRApT4TJnQdY7Vn0fLCtQNhIkM6GuLPu8ddMqdxWmhbewa+Xi7LA2diLI9RVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784845; c=relaxed/simple;
	bh=jZor5q3K0/bsJTdrHWOpluj1LrLymYYt+jOUF1gOH7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmvVMFrsh7bnJU5ium769swAO5khXrfgzZurX+WJ+bYGXmasqpUQC1Ftfv3VNqPft0PB206uQgbh9xt3Hc/h5Px2vYYDOkDQcuWnvmzwAg8pJnDnGyEaGMBavXvQt/b10vEVXeo2IuYfxRkiRgZl70zvIGjnJksTwNHISUe3nRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnX2EUUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752784842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZjoWkxShr/7VQUS74dCt1tHBZf9kwLb3D0DOEFdq6A=;
	b=XnX2EUUWqeuJprgWeflslf++loA5Bb+EUcvasYDA890oihMDGCuQyhC0TAL/r6TcUfdlgD
	4Lsflokjs/2XgWbE1RXQrPrLk3hKPO8R4FoYKqZ4gRsqLIUxJ3wEuXI1VdfDv2n5EWrLqV
	wKYJUYorrlDbEwPUCtXM/EpCGkMpC7k=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-YdSegNoQNsaPRWS3kiEYoQ-1; Thu, 17 Jul 2025 16:40:41 -0400
X-MC-Unique: YdSegNoQNsaPRWS3kiEYoQ-1
X-Mimecast-MFC-AGG-ID: YdSegNoQNsaPRWS3kiEYoQ_1752784840
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3df57df1eb3so2029115ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784840; x=1753389640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZjoWkxShr/7VQUS74dCt1tHBZf9kwLb3D0DOEFdq6A=;
        b=oZgKNOYCLlmQE6WDm78yXGJ9q3hbZrEYQAUpOfADGsgX81Y93SQA5hN7aqT9Df24Uu
         gmUSYKrWA97DB1328fc/pRSPfnAvKVSKlBjnWAbmu7f8RKXW3OkXnFNJrhuui8hRpuMP
         DDWGtHcbozmqYtO/1dx4h6sVZHgsU+14ofdOIfh1sE/aY6Ajgc/KXDT+imbySzf1S9h/
         9s10TBWJiBlhNhJ9vdPi4IxWPkh/kx7Hlq3GHi3q6l2DGzFbKHgOCBz4BxxfKyZEv7ep
         JPe/JnIWmt2xQGeQWuZBHymW2YuLSSuolGHKu/Ex60p1ciQTfc+AYf0jR0bfhLK+u+9C
         txWg==
X-Forwarded-Encrypted: i=1; AJvYcCXUiOkAjSx6uTG+eRfgVNnyAeoEwSDzRy44cTnU3H7qcVZdkjWNdDjwE5VCi6t1jpyTrEdwDmMAyAfhXNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnoQJC+1NPxIQMGEGaT7L27xsAiSfPHcnUburbQfkJVmcue1T
	/lOFrXam0auSEp4QYY/KQSW/EomC9lfHKwH+wObJdxJSMQObJF0Nh2FtmrnYb1pgVs5o8Vyey+U
	KSPTrB6cEtQal6l79/H8OmSlC35eZ7QBtxOAdBdD4G24gMrMBJLJneuGf7fcjdk3B7w==
X-Gm-Gg: ASbGnctSo7QwhDNZ3jE7FSRocZZ0YxuAUXfxxpm/z0qKpiImLIjtAntrI7GVTP3oidV
	SScf5uZeeX+dq+Mx+I9bY/UGyqbaKUoK02tcOxbPUMrEOxMy99Y51iga1FPsxD52Vgb+CXpHKr0
	qr6D9Ctpvd3KhtsMl4URDcV94uIgGyj5ihI8+qb+pxYc18p5mpq3ld03QcfbDLahb8x+Fwf+Mgx
	yg360dx0bs/yXWdbJ6DbelJQBW8waoA2lpF9GcT1HUEFWxsgDsGLCkEADV0mOaNuuZ1GzURQ8lM
	SlITonCWIpz7so0LX0Uwdxb4VTA30LSl3DjRWhEn/IM=
X-Received: by 2002:a05:6e02:1885:b0:3e2:9368:6e78 with SMTP id e9e14a558f8ab-3e293686ff0mr7323105ab.2.1752784839979;
        Thu, 17 Jul 2025 13:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Z+kXG/E/krCKoHN+cxCfsidjfMUmWqZhhhMjcQZuuXqC70a+/LRfIILiYRAxdr/OWMrdOg==
X-Received: by 2002:a05:6e02:1885:b0:3e2:9368:6e78 with SMTP id e9e14a558f8ab-3e293686ff0mr7323005ab.2.1752784839493;
        Thu, 17 Jul 2025 13:40:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24613447asm53566505ab.17.2025.07.17.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:40:38 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:40:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
Message-ID: <20250717144037.08e88ab6.alex.williamson@redhat.com>
In-Reply-To: <20250717133358.1541e5df.alex.williamson@redhat.com>
References: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
	<20250717133358.1541e5df.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:33:58 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 16 Jul 2025 08:49:04 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > CDX_BUS driver uses msi_setup_device_data() which is selected by
> > GENERIC_MSI_IRQ, thus compile testing without the latter failed:
> > 
> >   /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
> >   build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_device_data'
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Closes: https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org/
> > Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/cdx/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > index 1f1e360507d7..3af41f51cf38 100644
> > --- a/drivers/cdx/Kconfig
> > +++ b/drivers/cdx/Kconfig
> > @@ -8,6 +8,7 @@
> >  config CDX_BUS
> >  	bool "CDX Bus driver"
> >  	depends on OF && ARM64 || COMPILE_TEST
> > +	select GENERIC_MSI_IRQ
> >  	help
> >  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
> >  	  exposes Fabric devices which uses composable DMA IP to the  
> 
> This looks incomplete to me.  The Makefile has:
> 
> ifdef CONFIG_GENERIC_MSI_IRQ
> obj-$(CONFIG_CDX_BUS) += cdx_msi.o
> endif
> 
> The call to msi_setup_device_data(), the conditional inclusion of
> cdx_msi.o, and cdx_msi.c itself were added in 0e439ba38e61 ("cdx: add
> MSI support for CDX bus").  That's the source of the issue, not the
> Kconfig update to build under COMPILE_TEST, but also the Makefile
> should be updated to statically include cdx_msi.o.  Thanks,

Also, we may not be philosophically aligned on this, but if CDX_BUS
selects GENERIC_MSI_IRQ and CDX_CONTROLLER depends on CDX_BUS, then the
select of the same under CDX_CONTROLLER becomes redundant.

Independent of that there are also some ifdefs in cdx_bus.h that would
become invalid if the entire CDX_BUS depends on GENERIC_MSI_IRQ.  It
really kinda looks like CDX_BUS expects a use case that doesn't depend
on GENERIC_MSI_IRQ and I wonder if the right answer isn't just:

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 092306ca2541..3d50f8cd9c0b 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -310,7 +310,7 @@ static int cdx_probe(struct device *dev)
 	 * Setup MSI device data so that generic MSI alloc/free can
 	 * be used by the device driver.
 	 */
-	if (cdx->msi_domain) {
+	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
 		error = msi_setup_device_data(&cdx_dev->dev);
 		if (error)
 			return error;
@@ -833,7 +833,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
 		     cdx_dev->dev_num);
 
-	if (cdx->msi_domain) {
+	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
 		cdx_dev->num_msi = dev_params->num_msi;
 		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
 	}

Then I suppose vfio-cdx would also have the option to either
select/depend on GENERIC_MSI_IRQ or perhaps get away with stubbing
vfio_cdx_set_irqs_ioctl and vfio_cdx_irqs_cleanup and conditionally
building intr.o, depending on if there's a use case without MSI.
Thanks,

Alex


