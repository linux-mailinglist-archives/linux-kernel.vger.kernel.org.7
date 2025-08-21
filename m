Return-Path: <linux-kernel+bounces-779005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4240B2EDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A3CA237B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4C32C11FA;
	Thu, 21 Aug 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZiG6NJqd"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4D42A8C;
	Thu, 21 Aug 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755458; cv=none; b=Ectkr+r0vo9UdLjsNoe1OTQwrLcSlLnQHYYKiLCmVT5hyt6qgBiaowv0FxPoFksmtd9Cxo02/HZ8idRsPSubzuk0hsUEAXu2xpcyuYSGEcYdpeJIz4z2qAclIIFEuck90GPD2u/LRteYBJMSMH4w8tdxWH1BeyVBxACacuN4M4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755458; c=relaxed/simple;
	bh=6MeHPAoS6P1rXHVAEvpb+8/X3A0Q1FEWiq4fcqDxlYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPKiuHbTqIbEp66EtFT7dTTNSFFvqb9jhxi8xRyw6TMRMjEx1eiTtpCs9am/NvQEKYtmVwXSyHzWhF8na7PPxC2TFhQEFOVahbyjRY1QZV1sScSct4GsqHWTxtANPB5jzhyjfFvVjMvxFqHUHDH46KvLEUA6znQXEi9yeBbq3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZiG6NJqd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IpUasE57HCQQtMjI01o7gP4bPg0/Wv7FtnAxVylR1C0=; b=ZiG6NJqdAXM+U2h9p74FoikH5F
	v6YWtOrnkKfI4K/S0Dl6mrmHM2cKCsTIjumTSSMxaIne3IbGwcDP+IqxwEczRsJpSAj2Wbpvh9KSL
	1MJrJr2vIujJj46gprh/OrnYunNZhnlufEQJfOAR25HPrn7ChInN7WF3pIbZGmb552JME8PM2pxFa
	76F6NHvpf/ywci3ZfNvggTAqMxqzfPIdqRsKHzkN7PsrTO8wfPlnCt2XLGUIsX2AGy0CnF+QK/x85
	roIGWGV1RZdM5bgmIUCX1bAB1UZyAHgWqXPw9luzDuw1RNnEma8tEiBPBVpDjMQgz8qj82GT4pbvW
	VF6CHPPA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoyCN-0000000FuFf-2RIX;
	Thu, 21 Aug 2025 05:50:55 +0000
Message-ID: <554d2bf2-3941-4d3c-8cec-11209ced908c@infradead.org>
Date: Wed, 20 Aug 2025 22:50:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix typo in RAID arrays documentation
To: Vivek Alurkar <primalkenja@gmail.com>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250821051622.8341-2-primalkenja@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250821051622.8341-2-primalkenja@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 10:16 PM, Vivek Alurkar wrote:
> Changed "write-throuth" to "write-through".
> 
> Signed-off-by: Vivek Alurkar <primalkenja@gmail.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes since v1:
> 	-Changed '"write-through" and "write-back"' to
> 	'"write-through" or "write-back"' as suggested by Randy Dunlap.
> 
>  Documentation/admin-guide/md.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
> index 4ff2cc291d18..04668272c0ee 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -758,7 +758,7 @@ These currently include:
>  
>    journal_mode (currently raid5 only)
>        The cache mode for raid5. raid5 could include an extra disk for
> -      caching. The mode can be "write-throuth" and "write-back". The
> +      caching. The mode can be "write-through" or "write-back". The
>        default is "write-through".
>  
>    ppl_write_hint

-- 
~Randy

