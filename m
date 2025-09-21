Return-Path: <linux-kernel+bounces-826000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F1B8D4B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CC117BCCA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D029E101;
	Sun, 21 Sep 2025 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b50WMB1L"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449119CC37;
	Sun, 21 Sep 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427740; cv=none; b=YMvooGHFcW7APR1QXhEVPhqy8VmMRI7aO5DxPB4gEKHqFe+6+lmHX+VEg6TCRXjWCuTmw07N7R39wRreXsHjUYzMMIMhMYdzyhbfbBAS/BywoJOqbGTKPFd3oKryJa6JcSe9rjiPnWTbTufgp1kDMIFynJflL00/H1OrCFU8S/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427740; c=relaxed/simple;
	bh=8qVVlZfhmnjxv6QE5aeW2E/isvEhuskf2mkEt8x69wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQovCDdiMC8fxIQulQkSC3hRpohz2j1PbN+CPOUNocGp1AoGBjZTGkPfVBgCccwpU8QvJMUWkf41Yjxr4pjk3gFZxpD4gUMHolFmaP9QsGqjtQeimMvt3PPma5p3/UKWkFDIvDMbNdhktOupKGIZF6cyd3RhSHhr90lhKDRv7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b50WMB1L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VksaqJGdjzMhlLjKPHSM10/o9OsUOF4Mq5NDrlabej0=; b=b50WMB1L//3bi+ioD+U700kVdw
	Dp2claeyHiJwoTHZTSExIXYQNEOX3ZMS4wKtlibrW3AD90usdDs2Y5G/uzRR+XRGJ6XtLGYOg+F6Y
	QeoQvXCwgpPlKK7jDCPvVqGZowY1Jej2BYUaEeMhFAvL4dgiOpFxWqZQ2MFPYDVpAFVw83sJvIqBq
	96xy6jfLFkxdQwcfwi75rdnZPs7TzpombOz3isfV8qL/mYcSMGSgN+2Fcv01k4M7V007otSTjSCb4
	5LD+HzDNtSXKe+YsPqn5yTP06EHlI7jEz5TcAakyy5pZFl9VNz0EW22hoqfKN9Bf5eJNYuiHDLEXV
	VR0GxXeQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0BNh-00000006VSD-2RN5;
	Sun, 21 Sep 2025 04:08:57 +0000
Message-ID: <222d551c-fb01-4a8c-9b83-daef019b6795@infradead.org>
Date: Sat, 20 Sep 2025 21:08:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Documentation: fb: Retitle driver docs
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Framebuffer <linux-fbdev@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Bernie Thompson <bernie@plugable.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>
References: <20250919003640.14867-1-bagasdotme@gmail.com>
 <20250919003640.14867-3-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250919003640.14867-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
I would change a couple of the headings, but otherwise
looks good.


On 9/18/25 5:36 PM, Bagas Sanjaya wrote:
> Many framebuffer driver docs are copied from vesafb docs as their
> template, including "What is <driver name>" title. Such title
> implies the introductory section, however, and not the whole docs.
> 
> Retitle them.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/fb/aty128fb.rst | 8 +++-----
>  Documentation/fb/efifb.rst    | 6 +++---
>  Documentation/fb/gxfb.rst     | 8 +++-----
>  Documentation/fb/lxfb.rst     | 9 +++------
>  Documentation/fb/matroxfb.rst | 9 +++------
>  Documentation/fb/pvr2fb.rst   | 6 +++---
>  Documentation/fb/sa1100fb.rst | 9 +++------
>  Documentation/fb/sisfb.rst    | 6 +++---
>  Documentation/fb/sm712fb.rst  | 6 +++---
>  Documentation/fb/tgafb.rst    | 6 +++---
>  Documentation/fb/udlfb.rst    | 6 +++---
>  Documentation/fb/vesafb.rst   | 6 +++---
>  12 files changed, 36 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/fb/aty128fb.rst b/Documentation/fb/aty128fb.rst
> index 3f107718f933fc..0da8070a552165 100644
> --- a/Documentation/fb/aty128fb.rst
> +++ b/Documentation/fb/aty128fb.rst
> @@ -1,8 +1,6 @@
> -=================
> -What is aty128fb?
> -=================
> -
> -.. [This file is cloned from VesaFB/matroxfb]
> +=========================================
> +aty128fb - ATI Rage128 framebuffer driver
> +=========================================
>  
>  This is a driver for a graphic framebuffer for ATI Rage128 based devices
>  on Intel and PPC boxes.
> diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
> index 6badff64756f49..3d4aab406dee0a 100644
> --- a/Documentation/fb/efifb.rst
> +++ b/Documentation/fb/efifb.rst
> @@ -1,6 +1,6 @@
> -==============
> -What is efifb?
> -==============
> +===================================
> +efifb - Generic EFI platform driver
> +===================================
>  
>  This is a generic EFI platform driver for systems with UEFI firmware. The
>  system must be booted via the EFI stub for this to be usable. efifb supports
> diff --git a/Documentation/fb/gxfb.rst b/Documentation/fb/gxfb.rst
> index 5738709bccbbf3..3fda485606bdc1 100644
> --- a/Documentation/fb/gxfb.rst
> +++ b/Documentation/fb/gxfb.rst
> @@ -1,8 +1,6 @@
> -=============
> -What is gxfb?
> -=============
> -
> -.. [This file is cloned from VesaFB/aty128fb]
> +=======================================
> +gxfb - AMD Geode GX2 framebuffer driver
> +=======================================
>  
>  This is a graphics framebuffer driver for AMD Geode GX2 based processors.
>  
> diff --git a/Documentation/fb/lxfb.rst b/Documentation/fb/lxfb.rst
> index 863e6b98fbae55..0a176ab376e30e 100644
> --- a/Documentation/fb/lxfb.rst
> +++ b/Documentation/fb/lxfb.rst
> @@ -1,9 +1,6 @@
> -=============
> -What is lxfb?
> -=============
> -
> -.. [This file is cloned from VesaFB/aty128fb]
> -
> +======================================
> +lxfb - AMD Geode LX framebuffer driver
> +======================================
>  
>  This is a graphics framebuffer driver for AMD Geode LX based processors.
>  
> diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
> index 6158c49c857148..34cafaa00bab19 100644
> --- a/Documentation/fb/matroxfb.rst
> +++ b/Documentation/fb/matroxfb.rst
> @@ -1,9 +1,6 @@
> -=================
> -What is matroxfb?
> -=================
> -
> -.. [This file is cloned from VesaFB. Thanks go to Gerd Knorr]
> -
> +==================================
> +matroxfb driver for Matrox devices
> +==================================

Add a '-' after matroxfb

>  
>  This is a driver for a graphic framebuffer for Matrox devices on
>  Alpha, Intel and PPC boxes.
> diff --git a/Documentation/fb/pvr2fb.rst b/Documentation/fb/pvr2fb.rst
> index fcf2c21c8fcfeb..315ce085a5855b 100644
> --- a/Documentation/fb/pvr2fb.rst
> +++ b/Documentation/fb/pvr2fb.rst
> @@ -1,6 +1,6 @@
> -===============
> -What is pvr2fb?
> -===============
> +===============================================
> +pvr2fb - PowerVR 2 graphics frame buffer driver
> +===============================================
>  
>  This is a driver for PowerVR 2 based graphics frame buffers, such as the
>  one found in the Dreamcast.
> diff --git a/Documentation/fb/sa1100fb.rst b/Documentation/fb/sa1100fb.rst
> index 67e2650e017d12..c5ca019b361a94 100644
> --- a/Documentation/fb/sa1100fb.rst
> +++ b/Documentation/fb/sa1100fb.rst
> @@ -1,9 +1,6 @@
> -=================
> -What is sa1100fb?
> -=================
> -
> -.. [This file is cloned from VesaFB/matroxfb]
> -
> +=================================================
> +sa1100fb - SA-1100 LCD graphic framebuffer driver
> +=================================================
>  
>  This is a driver for a graphic framebuffer for the SA-1100 LCD
>  controller.
> diff --git a/Documentation/fb/sisfb.rst b/Documentation/fb/sisfb.rst
> index 8f4e502ea12ea7..9982f5ee05601b 100644
> --- a/Documentation/fb/sisfb.rst
> +++ b/Documentation/fb/sisfb.rst
> @@ -1,6 +1,6 @@
> -==============
> -What is sisfb?
> -==============
> +=====================================
> +sisfb - SiS framebuffer device driver
> +=====================================
>  
>  sisfb is a framebuffer device driver for SiS (Silicon Integrated Systems)
>  graphics chips. Supported are:
> diff --git a/Documentation/fb/sm712fb.rst b/Documentation/fb/sm712fb.rst
> index 8e000f80b5bc6d..abbc6efae25f46 100644
> --- a/Documentation/fb/sm712fb.rst
> +++ b/Documentation/fb/sm712fb.rst
> @@ -1,6 +1,6 @@
> -================
> -What is sm712fb?
> -================
> +==========================================================
> +sm712fb - Silicon Motion SM712 graphics framebuffer driver
> +==========================================================
>  
>  This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
>  
> diff --git a/Documentation/fb/tgafb.rst b/Documentation/fb/tgafb.rst
> index 0c50d2134aa433..f0944da1ea5ef1 100644
> --- a/Documentation/fb/tgafb.rst
> +++ b/Documentation/fb/tgafb.rst
> @@ -1,6 +1,6 @@
> -==============
> -What is tgafb?
> -==============
> +=======================================
> +tgafb - TGA graphics framebuffer driver
> +=======================================
>  
>  This is a driver for DECChip 21030 based graphics framebuffers, a.k.a. TGA
>  cards, which are usually found in older Digital Alpha systems. The
> diff --git a/Documentation/fb/udlfb.rst b/Documentation/fb/udlfb.rst
> index 99cfbb7a192238..9e75ac6b07c36a 100644
> --- a/Documentation/fb/udlfb.rst
> +++ b/Documentation/fb/udlfb.rst
> @@ -1,6 +1,6 @@
> -==============
> -What is udlfb?
> -==============
> +==================================
> +udlfb - DisplayLink USB 2.0 driver
> +==================================
>  
>  This is a driver for DisplayLink USB 2.0 era graphics chips.
>  
> diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
> index f890a4f5623b45..5ffb35efd4538a 100644
> --- a/Documentation/fb/vesafb.rst
> +++ b/Documentation/fb/vesafb.rst
> @@ -1,6 +1,6 @@
> -===============
> -What is vesafb?
> -===============
> +===========================================
> +Generic graphic framebuffer driver (vesafb)
> +===========================================

vesafb - Generic graphic framebuffer driver

>  
>  This is a generic driver for a graphic framebuffer on intel boxes.
>  


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

