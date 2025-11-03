Return-Path: <linux-kernel+bounces-882272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A8C2A097
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95F94E57A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2813502BE;
	Mon,  3 Nov 2025 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0dP7XKP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7013AF2;
	Mon,  3 Nov 2025 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762145921; cv=none; b=bQoDkKzlDb+2Ug5p2TYenYBB+tAnc8Wy+blZV170LifpE+oUa51YjU3roanoKE2pcyGWGD8FBNb/+lnD81AGUs1AgEyju1ZbSdRSaosgz9m5rS8RbNmxaum0x+QsDnT64Ba+fVdRlWmZeyJEOV5yAVWYDMegDDmQ/viOeCwRc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762145921; c=relaxed/simple;
	bh=6x4wUFLc/erBfs/B+lktnOw07egLt1U4rr2lYQQy/gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbd7KxbUrE8xQrnQRvuRe/GaFBJm4js7Xjo+KkIU2f6vqLJBrHOI999MBXaY0JC0q7cJ4+MERgO+yeiGinmORfPieD3+OOavTk+fQu1+CfBsVucYGLC2MfvyHPqvOGhi23k6I+4FanXbW1l4/j4K9r1wYj8mW+c2C+GVh9u3XU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U0dP7XKP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wnxQ24g3Vg9Pz8AWmeQla0qn3RxqNL/lM/sSFrPZ6sk=; b=U0dP7XKP0BF/CvrM2zOp/xsCa/
	XXzyOTB4n60eVZZs8m3b4b5S+Z0xz8ALcKPqlvqoQEKnJvGTCcSHlyzFGIGNZHmurAdVRdblc8Lf8
	i27Gx6umjLh4FFVo94RbLOp0rUJ7GuuYJchCcycyaZPB1HgVTc+d3abjcA+0suWcgu+h6N+7/YrSE
	PlV9ss1ryHyGdB/gq33hpX0+DRGH6mop7pV0CIaXf0yhkMQf7ZhRqXg2mxugWuTfUVKsatzmCroqb
	lCxg6xEcdD09sCg05Lh3RBnnbcSPrDx+Fds7QzajUSg1+ktxpQc68xkzaOBsE/rORINm9809aGrUN
	+JEj9EQw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFmeH-00000009Cpj-31UU;
	Mon, 03 Nov 2025 04:58:33 +0000
Message-ID: <e95704fd-68fa-4093-835c-ca220a9c3f5d@infradead.org>
Date: Sun, 2 Nov 2025 20:58:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: uacce: Add explicit title
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Accelerators <linux-accelerators@lists.ozlabs.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251103025950.23159-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251103025950.23159-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 6:59 PM, Bagas Sanjaya wrote:
> Uacce docs' sections are listed in misc-devices toctree instead due to
> lack of explicit docs title. Add it to clean up the toctree.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/misc-devices/uacce.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
> index 1db412e9b1a380..2ca539b7d6c799 100644
> --- a/Documentation/misc-devices/uacce.rst
> +++ b/Documentation/misc-devices/uacce.rst
> @@ -1,7 +1,10 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -Introduction of Uacce
> ----------------------
> +Uacce (Unified/User-space-acess-intended Accelerator Framework)

                             access ?

> +===============================================================
> +
> +Introduction
> +------------
>  
>  Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>  provide Shared Virtual Addressing (SVA) between accelerators and processes.
> 
> base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980

-- 
~Randy


