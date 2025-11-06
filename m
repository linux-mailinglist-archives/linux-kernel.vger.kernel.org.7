Return-Path: <linux-kernel+bounces-887838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD0C3931C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F16B4EA151
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6B2D8764;
	Thu,  6 Nov 2025 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WS8ClH90"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428716132F;
	Thu,  6 Nov 2025 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408536; cv=none; b=jqEgiPda7s1HTc6jxdV3yxicVo5M7nXn136Pl/3GyLHq9WxwhnKkxqBp6TNMlxhyIeigO0JBH2Gc+Nj0+a+IRmaxYZce5bdvsvJ5dus8Ho65OqEHX+m5kleS1Xo2I68fFG16PRIpnYX+Eq9XV0fJq21e2pIVas5qUbgW+ZixR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408536; c=relaxed/simple;
	bh=yOxciQ52Nro4GYMTi0USAatN4CblGaoWe8CkmCPHO8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpulrAAPIOoqCXDLGjR7TO4xMBHnb4ZQR+BOeK/AWrjnwKuwX2rzxsz7u9Y7IVdkhA3Y8f8c03VvGVQs5CEJqel++bMOaPGiG0x7JsAU6I04t54tP7RdJRmcIF8uCEWOA/47cFDNjovmR8vOJcjpu3s0MGzZj8SQhnGjAZHY9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WS8ClH90; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=F75mzR8twH/mSVbUSPi+Z2WCD89OpV0qBy++5+MrAjw=; b=WS8ClH90Z7OnH7GaK72fb3/K6Q
	KVaJXtsR2kI+NfNC7APyVazcYofTU8cgHhXIqHhIFvkiqP/CEb1Vhe93834+Hoy1NF7giM9B53Agu
	U8ByumKppcufZCbh0+Q8MoUodQIYs8uP3QIstwGcFCAwj03K7zJD7SpAmxr9Obcl45B/jnIGYwkzr
	N4TB3iA3gscm1A6/NV9XaViaU4pt8A8E/Uoa15WYxDuAdmbQ3gLo7efkX7L4lAr6t8IHSEnrD9Sji
	iRxykxKdA6oCorRrsLcpI0PZYgcl4NpCmmMjktdct3mqDC2DX8qSqYRxBVxX/DUyEhUGfdoaoewT7
	CK2R1oqQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGsy6-0000000EuSA-0b80;
	Thu, 06 Nov 2025 05:55:34 +0000
Message-ID: <8766fc64-f7d5-4443-8646-604f98a6d26f@infradead.org>
Date: Wed, 5 Nov 2025 21:55:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: parport-lowlevel: Separate function
 listing code blocks
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-actions@lists.infradead.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251105124947.45048-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251105124947.45048-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 4:49 AM, Bagas Sanjaya wrote:
> Commit be9d0411f1608a ("parport-lowlevel.txt: standardize document
> format") reSTify parport interface documentation but forgets to properly
> mark function listing code blocks up. As such, these are rendered as
> long-running normal paragraph instead.
> 
> Fix them by adding missing separator between the code block marker and
> the listing.
> 
> Fixes: be9d0411f1608a ("parport-lowlevel.txt: standardize document format")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/parport-lowlevel.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/driver-api/parport-lowlevel.rst b/Documentation/driver-api/parport-lowlevel.rst
> index 0633d70ffda7fa..a907e279f509b4 100644
> --- a/Documentation/driver-api/parport-lowlevel.rst
> +++ b/Documentation/driver-api/parport-lowlevel.rst
> @@ -7,6 +7,7 @@ PARPORT interface documentation
>  Described here are the following functions:
>  
>  Global functions::
> +
>    parport_register_driver
>    parport_unregister_driver
>    parport_enumerate
> @@ -34,6 +35,7 @@ Global functions::
>  Port functions (can be overridden by low-level drivers):
>  
>    SPP::
> +
>      port->ops->read_data
>      port->ops->write_data
>      port->ops->read_status
> @@ -46,17 +48,20 @@ Port functions (can be overridden by low-level drivers):
>      port->ops->data_reverse
>  
>    EPP::
> +
>      port->ops->epp_write_data
>      port->ops->epp_read_data
>      port->ops->epp_write_addr
>      port->ops->epp_read_addr
>  
>    ECP::
> +
>      port->ops->ecp_write_data
>      port->ops->ecp_read_data
>      port->ops->ecp_write_addr
>  
>    Other::
> +
>      port->ops->nibble_read_data
>      port->ops->byte_read_data
>      port->ops->compat_write_data
> 
> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f

-- 
~Randy

