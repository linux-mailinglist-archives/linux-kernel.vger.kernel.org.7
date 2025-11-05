Return-Path: <linux-kernel+bounces-886900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D85C36C65
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2119501574
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598733F8D7;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NYR5ZJXt"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92233F379
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359566; cv=none; b=UvB3R9aV3h/DWgv9JUz27rUyB0gqYQznVIasG0OfxytGAfZf7iIgf+uDMbEbyAYk3UvQWOQvVFvG+KsdEdk9ajmVJrR1upWbqLO4493/cXW8ycNwQibVOOKuUZ2/FRWzvHzvEFBs0+CzmldbdRRhq6Q7nVIp/kx5/8qzHmGz9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359566; c=relaxed/simple;
	bh=irZw9lEvhlSauHptp3RWLZIFsb73pve1wewxFx4TGkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1rm+n+uWqgKf3pDYiXTlM0knTChHbH5YHHFA7earpwVpW5of9FDEw1c1rJSKtOGHbrayz1P7qBW4+VKpKB9orXCUdWue7NI3WVmWgm6v08AT3/bp14Jp7LjVGF7ARdWzTN10W3E/gBvSkwgarnyDfP6W5N6VdKhYVhTFjZaFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NYR5ZJXt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Nov 2025 00:19:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762359561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wAhKTUbeTU/vU1N7oluJHOfaV5XLmJGycuKHQz7Th0M=;
	b=NYR5ZJXtfQHvKI6nmB0Jry4bmlKIh+WJkyXzcgXaK0mo8CYnwrObsKt+GAQyh86lEs8dXN
	D7a84VuxPeeAjsKxPJV7vmedSVl2hB/Z1jOYykCA76QxpiBht0ZlyBQ4ZCpcONfr7qSoh3
	/xr3jc41fW4+zEOSbERP5eOdOAcTdDs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Encrow Thorne <jyc0019@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] reset: fix BIT macro reference
Message-ID: <aQt5AAj1DPv4L_ri@troy-wujie14pro-arch>
References: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 05, 2025 at 11:40:12PM +0800, Encrow Thorne wrote:
> RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> include bits.h or bitops.h. This causes compilation errors when
> including reset.h standalone.
> 
> Include bits.h to make reset.h self-contained.
> 
> Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com
What's that?

    - Troy
> ---
>  include/linux/reset.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 840d75d172f6..44f9e3415f92 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_RESET_H_
>  #define _LINUX_RESET_H_
>  
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> 
> ---
> base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> change-id: 20251105-rfc-reset-include-bits-4ec72344d1a3
> 
> Best regards,
> -- 
> Encrow Thorne <jyc0019@gmail.com>
> 

