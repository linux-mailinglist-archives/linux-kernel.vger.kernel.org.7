Return-Path: <linux-kernel+bounces-893332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A1C4717B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D58B4EC248
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FAD312810;
	Mon, 10 Nov 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qrALZeZ/"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CF3128A9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783530; cv=none; b=TiMLXXlkJDRvarXZYOjWeA2RwDri2RfzbXIAi1WbM1ruapLopDLgfAX9/p6tbtH+9yEeTWMLthLc+QYyj2GlQMZnwjSPE8H/z7M8EvH+L+p8H8r6M2GjrZncNAoZFUTwNQyDKZwVvwBLSL5q9qBxOLeOYxA0JClFiIBu/DZ4+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783530; c=relaxed/simple;
	bh=4lxmm+lgRQjIfLVIYInSfHfLWmcWDjHs3sG41MlBR3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8vhShClojsxjAIyRf/y9P7ejOxfG6fqvtqQn3NvsYKQhfYFTWJmloPb7ljV6jVu7oS3HcV7RtlIznXbRoou/S0xaVifXXYmGL6vc57/J03x2NhocVqJvnIOiM/gnnX3SlkR2/+ulPT9pjjgVre6PEpNNR6Agp6frDEetE/LQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qrALZeZ/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 017594E41608;
	Mon, 10 Nov 2025 14:05:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAB14606F5;
	Mon, 10 Nov 2025 14:05:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3C301037190C;
	Mon, 10 Nov 2025 15:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762783526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8bvgcbmQrlbU9zNXHtKlCDmLWbL4n0mBYK/Rt0bKDcM=;
	b=qrALZeZ/n2F96C4f9Y9HKndLzqY9mcU9jY9MN6sly7HUpp4qm6OInByymE4l7EYrq87QkR
	IMQZk0+XuV567em4Whc9rW47GG3LppMmLbAXHLXr3+XkpjJx4sxMb7UYjeDztvO+7eiMir
	RNzG0fyNRH1c60kzd53Sh8p5JGUlxw6QB4BUB0sDfY6rrgxkTNTQ4Oaq2smkRMzImx/g2I
	PciIuCaoj8Bh+0l9TzJar4MYud1j+Dr3LQbT1qSxDTA3phfzlDrL+Cq/L1l96nTixRW5Ub
	ukTuBvbY9QA0pqx/qcHASPVomLsFdAy3dTeVpUTcsT95v9fSu5DQqJIsGI6/7Q==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>, =?utf-8?Q?Th?=
 =?utf-8?Q?=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MIPS: Fix HOTPLUG_PARALLEL dependency
In-Reply-To: <20251027-mips_paralell_hotplug-v1-1-01b6cd13ee85@bootlin.com>
References: <20251027-mips_paralell_hotplug-v1-1-01b6cd13ee85@bootlin.com>
Date: Mon, 10 Nov 2025 15:05:23 +0100
Message-ID: <87v7jirnj0.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Thomas,

> With MIPS, it is possible to have SMP enabled without HOTPLUG_CPU
> selected. However, in kernel/cpu.c, some code that uses
> HOTPLUG_PARALLEL also requires HOTPLUG_CPU to be selected. Therefore,
> we should fix the HOTPLUG_PARALLEL dependency to depend on
> HOTPLUG_CPU, not just SMP.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510270120.21wA1aX1-lkp@i=
ntel.com/
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Do you have any comments about this fix?

Regards,

Gregory

> ---
>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e8683f58fd3e2..b88b97139fa8e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -658,7 +658,7 @@ config EYEQ
>  	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
>  	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USE_OF
> -	select HOTPLUG_PARALLEL if SMP
> +	select HOTPLUG_PARALLEL if HOTPLUG_CPU
>  	help
>  	  Select this to build a kernel supporting EyeQ SoC from Mobileye.
>=20=20
>
> ---
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> change-id: 20251027-mips_paralell_hotplug-e9ae2b1fa126
>
> Best regards,
> --=20
> Gr=C3=A9gory CLEMENT, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

