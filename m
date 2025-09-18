Return-Path: <linux-kernel+bounces-772081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CEB28E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684071C23FED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235632F39A6;
	Sat, 16 Aug 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="qfNZaje+"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A72F0691;
	Sat, 16 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355427; cv=none; b=JDVrtPJW1VZ9j/etyxkGUKcsC0rzB2sxY6nrodCCYegKEEoDwdYEHlrI+4q2owQAfB1OJT800u7B8YJZqapWnj6mFRPehEZsCkpQDhzmmmN+Z/l48E8qqOeS+UrRNqzYelIDxDf/KNAMN38nSCUdDgZe2TaIVI2000C7BY9Aqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355427; c=relaxed/simple;
	bh=MdN9n3zp6VDlQbSpZGpbiSRanxrr7rEMOcrss5ISq/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ5PSemKp75IzK2o5ngTOi/USNGD0czXuPMxdn/DqfKBAEHHigTsIL637PJkydl2ulLpbGYizlNv28enxf6+rnZc2O+OPuTZvgGQ03LlwEAd0ubomNc3YZNti+cuRgMYKbNQKrgQ8G37BBfhJEQYAoSVxTBO1nsjndYoTdKBSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=qfNZaje+; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355416;
	bh=MdN9n3zp6VDlQbSpZGpbiSRanxrr7rEMOcrss5ISq/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfNZaje+1WQ0uDaZJ+wffrKxi2aNn2mfgLDz33PMx908uhnEiOHIArwOl5jgc0m+v
	 Wt9rAXjyq2wqaTCMg0SkJRUAbY2uT0iu0Pjg+joSHUIV/lz8D9I+cncB6l6037QEZZ
	 SZL+fStiAG5+Vjk6Q7oqNA+t9glmMKLoFeB4bX9wOjEAt0XZGRfOZlky770TRocEu9
	 /cPiUId+nwXy9bPfIhv/HCMBuQfuOok/7MpUJ7TIPg8755XE5pFgsH/C5H6uFLJwsr
	 SSD7oBmejuNP+y+0f/jKkX9bMIVueEF18KemW4ShEPS8He9MiEtKOp+N4L/ED5FbW9
	 v0rSVLJkMIusg==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 5CDCE20074D;
	Sat, 16 Aug 2025 14:43:36 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id C50BCA00A7; Sat, 16 Aug 2025 16:42:51 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:42:51 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] pcmcia: remove PCCARD_IODYN
Message-ID: <aKCY6-qXsMRD5q_x@shine.dominikbrodowski.net>
References: <20250630093256.175212-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630093256.175212-1-lukas.bulwahn@redhat.com>

Applied to pcmcia-next.

Thanks,
	Dominik

Am Mon, Jun 30, 2025 at 11:32:56AM +0200 schrieb Lukas Bulwahn:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> The config PCCARD_IODYN was last used in the config option PCMCIA_M8XX with
> its m8xx_pcmcia driver. This driver was removed with commit 39eb56da2b53
> ("pcmcia: Remove m8xx_pcmcia driver"), included in v3.17, back in 2014.
> Since then, the config PCCARD_IODYN is unused. Remove the config option,
> the corresponding file included with this config and the corresponding
> definition in the pcmcia header file.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  drivers/pcmcia/Kconfig      |   3 -
>  drivers/pcmcia/Makefile     |   1 -
>  drivers/pcmcia/rsrc_iodyn.c | 168 ------------------------------------
>  include/pcmcia/ss.h         |   8 +-
>  4 files changed, 1 insertion(+), 179 deletions(-)
>  delete mode 100644 drivers/pcmcia/rsrc_iodyn.c
> 
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index dddb235dd020..660a95805524 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -250,7 +250,4 @@ config ELECTRA_CF
>  config PCCARD_NONSTATIC
>  	bool
>  
> -config PCCARD_IODYN
> -	bool
> -
>  endif	# PCCARD
> diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> index c9d51b150682..d16a0317ce43 100644
> --- a/drivers/pcmcia/Makefile
> +++ b/drivers/pcmcia/Makefile
> @@ -12,7 +12,6 @@ obj-$(CONFIG_PCMCIA)				+= pcmcia.o
>  
>  pcmcia_rsrc-y					+= rsrc_mgr.o
>  pcmcia_rsrc-$(CONFIG_PCCARD_NONSTATIC)		+= rsrc_nonstatic.o
> -pcmcia_rsrc-$(CONFIG_PCCARD_IODYN)		+= rsrc_iodyn.o
>  obj-$(CONFIG_PCCARD)				+= pcmcia_rsrc.o
>  
>  
> diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
> deleted file mode 100644
> index b04b16496b0c..000000000000
> --- a/drivers/pcmcia/rsrc_iodyn.c
> +++ /dev/null
> @@ -1,168 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * rsrc_iodyn.c -- Resource management routines for MEM-static sockets.
> - *
> - * The initial developer of the original code is David A. Hinds
> - * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
> - * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
> - *
> - * (C) 1999		David A. Hinds
> - */
> -
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -
> -#include <pcmcia/ss.h>
> -#include <pcmcia/cistpl.h>
> -#include "cs_internal.h"
> -
> -
> -struct pcmcia_align_data {
> -	unsigned long	mask;
> -	unsigned long	offset;
> -};
> -
> -static resource_size_t pcmcia_align(void *align_data,
> -				const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	struct pcmcia_align_data *data = align_data;
> -	resource_size_t start;
> -
> -	start = (res->start & ~data->mask) + data->offset;
> -	if (start < res->start)
> -		start += data->mask + 1;
> -
> -#ifdef CONFIG_X86
> -	if (res->flags & IORESOURCE_IO) {
> -		if (start & 0x300)
> -			start = (start + 0x3ff) & ~0x3ff;
> -	}
> -#endif
> -
> -#ifdef CONFIG_M68K
> -	if (res->flags & IORESOURCE_IO) {
> -		if ((res->start + size - 1) >= 1024)
> -			start = res->end;
> -	}
> -#endif
> -
> -	return start;
> -}
> -
> -
> -static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
> -					unsigned long base, int num,
> -					unsigned long align)
> -{
> -	struct resource *res = pcmcia_make_resource(0, num, IORESOURCE_IO,
> -						dev_name(&s->dev));
> -	struct pcmcia_align_data data;
> -	unsigned long min = base;
> -	int ret;
> -
> -	data.mask = align - 1;
> -	data.offset = base & data.mask;
> -
> -#ifdef CONFIG_PCI
> -	if (s->cb_dev) {
> -		ret = pci_bus_alloc_resource(s->cb_dev->bus, res, num, 1,
> -					     min, 0, pcmcia_align, &data);
> -	} else
> -#endif
> -		ret = allocate_resource(&ioport_resource, res, num, min, ~0UL,
> -					1, pcmcia_align, &data);
> -
> -	if (ret != 0) {
> -		kfree(res);
> -		res = NULL;
> -	}
> -	return res;
> -}
> -
> -static int iodyn_find_io(struct pcmcia_socket *s, unsigned int attr,
> -			unsigned int *base, unsigned int num,
> -			unsigned int align, struct resource **parent)
> -{
> -	int i, ret = 0;
> -
> -	/* Check for an already-allocated window that must conflict with
> -	 * what was asked for.  It is a hack because it does not catch all
> -	 * potential conflicts, just the most obvious ones.
> -	 */
> -	for (i = 0; i < MAX_IO_WIN; i++) {
> -		if (!s->io[i].res)
> -			continue;
> -
> -		if (!*base)
> -			continue;
> -
> -		if ((s->io[i].res->start & (align-1)) == *base)
> -			return -EBUSY;
> -	}
> -
> -	for (i = 0; i < MAX_IO_WIN; i++) {
> -		struct resource *res = s->io[i].res;
> -		unsigned int try;
> -
> -		if (res && (res->flags & IORESOURCE_BITS) !=
> -			(attr & IORESOURCE_BITS))
> -			continue;
> -
> -		if (!res) {
> -			if (align == 0)
> -				align = 0x10000;
> -
> -			res = s->io[i].res = __iodyn_find_io_region(s, *base,
> -								num, align);
> -			if (!res)
> -				return -EINVAL;
> -
> -			*base = res->start;
> -			s->io[i].res->flags =
> -				((res->flags & ~IORESOURCE_BITS) |
> -					(attr & IORESOURCE_BITS));
> -			s->io[i].InUse = num;
> -			*parent = res;
> -			return 0;
> -		}
> -
> -		/* Try to extend top of window */
> -		try = res->end + 1;
> -		if ((*base == 0) || (*base == try)) {
> -			if (adjust_resource(s->io[i].res, res->start,
> -					    resource_size(res) + num))
> -				continue;
> -			*base = try;
> -			s->io[i].InUse += num;
> -			*parent = res;
> -			return 0;
> -		}
> -
> -		/* Try to extend bottom of window */
> -		try = res->start - num;
> -		if ((*base == 0) || (*base == try)) {
> -			if (adjust_resource(s->io[i].res,
> -					    res->start - num,
> -					    resource_size(res) + num))
> -				continue;
> -			*base = try;
> -			s->io[i].InUse += num;
> -			*parent = res;
> -			return 0;
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -
> -struct pccard_resource_ops pccard_iodyn_ops = {
> -	.validate_mem = NULL,
> -	.find_io = iodyn_find_io,
> -	.find_mem = NULL,
> -	.init = static_init,
> -	.exit = NULL,
> -};
> -EXPORT_SYMBOL(pccard_iodyn_ops);
> diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
> index 7cf7dbbfa131..89aed99bfeae 100644
> --- a/include/pcmcia/ss.h
> +++ b/include/pcmcia/ss.h
> @@ -227,12 +227,8 @@ struct pcmcia_socket {
>  
>  
>  /* socket drivers must define the resource operations type they use. There
> - * are three options:
> + * are two options:
>   * - pccard_static_ops		iomem and ioport areas are assigned statically
> - * - pccard_iodyn_ops		iomem areas is assigned statically, ioport
> - *				areas dynamically
> - *				If this option is selected, use
> - *				"select PCCARD_IODYN" in Kconfig.
>   * - pccard_nonstatic_ops	iomem and ioport areas are assigned dynamically.
>   *				If this option is selected, use
>   *				"select PCCARD_NONSTATIC" in Kconfig.
> @@ -240,13 +236,11 @@ struct pcmcia_socket {
>   */
>  extern struct pccard_resource_ops pccard_static_ops;
>  #if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
> -extern struct pccard_resource_ops pccard_iodyn_ops;
>  extern struct pccard_resource_ops pccard_nonstatic_ops;
>  #else
>  /* If PCMCIA is not used, but only CARDBUS, these functions are not used
>   * at all. Therefore, do not use the large (240K!) rsrc_nonstatic module
>   */
> -#define pccard_iodyn_ops pccard_static_ops
>  #define pccard_nonstatic_ops pccard_static_ops
>  #endif
>  
> -- 
> 2.50.0
> 
> 

