Return-Path: <linux-kernel+bounces-718618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB383AFA3C4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C93189BF8E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2181E834E;
	Sun,  6 Jul 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RUrbEVef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD42E36F7;
	Sun,  6 Jul 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751791893; cv=none; b=CaYTY3DRYLMDTn2ZTmIRQpBs1bKtsWVUnHncxKmBpI8aaLLe3L5dARAIliV8ntER6TzDxMTS2gZEkkgP/znmzh5SNJM46k50gxLWtJgxLbkoB67DcyIBM+VkogK3oeTLLR74+1ZSpWcAKHzSpadepzAO3YZKLXZsbi0aaCh5FJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751791893; c=relaxed/simple;
	bh=W3rnyZsCWU+x73RFUfENRzzAPaXOdPt6EiXuGzMBw5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi9xXMD+II0+cZWGIzPSA39SJ/me8eKk7YPGkke8HuIb4Pgc+temXiAt+v5MPk2zlGtyp4hAoflegfEXikUGiYSd4N1woyz7WgupJ4Iq62oGH97KX85ysmNCxn3CpCHzNO4Hrtn8GkTH5F6b0ZF29uYSgKzZFyTwqI5opMPVBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RUrbEVef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A917C4CEED;
	Sun,  6 Jul 2025 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751791892;
	bh=W3rnyZsCWU+x73RFUfENRzzAPaXOdPt6EiXuGzMBw5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUrbEVef3oROIABRKJkKNxoouHKarNEO/lVYCfoIX6AOBI4PYfhRkJW9RB/fOZW2o
	 63ZfhN0r6o6+81qwo8tMiPxNb4b8cTCHvlX+JbJtwq13gdmAz1Z6q7jJJxdjIB0Vdv
	 AM17U+o4w5bDtNLGveVcgY4w7m9MmNOqQWC8Q7I4=
Date: Sun, 6 Jul 2025 10:51:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/8] char: misc: Move drivers/misc/misc_minor_kunit.c
 to drivers/char/
Message-ID: <2025070611-granite-unheated-ea3f@gregkh>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-1-b48986112d6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rfc_miscdev-v4-1-b48986112d6a@oss.qualcomm.com>

On Fri, Jul 04, 2025 at 09:25:59PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> drivers/misc/misc_minor_kunit.c is to test APIs defined in
> drivers/char/misc.c, but is not in the same directory as the later.
> 
> Move misc_minor_kunit.c to drivers/char/.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/char/Makefile                     | 1 +
>  drivers/{misc => char}/misc_minor_kunit.c | 0
>  drivers/misc/Makefile                     | 1 -
>  3 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index e9b360cdc99a7fee9c70eabcffe9caf763552aa2..7d10d92edcedbff5957d6c5c3426aa9400c94e43 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -6,6 +6,7 @@
>  obj-y				+= mem.o random.o
>  obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
>  obj-y				+= misc.o
> +obj-$(CONFIG_TEST_MISC_MINOR)   += misc_minor_kunit.o

No tab?  Why not?

thanks,

greg k-h

