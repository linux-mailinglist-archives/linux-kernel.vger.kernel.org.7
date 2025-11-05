Return-Path: <linux-kernel+bounces-886609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C0C36121
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A4D4648E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D309322A1F;
	Wed,  5 Nov 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5uHEOJd"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8E236A73
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352941; cv=none; b=YNZ1affoNcqUIh9P3TQz1J2DzZamFAYCR/xEXVjnAMSX61Fy+DyS39qsGR4vCPZnrFgB/TstwZwiWr8+3Gj6uQ+E8xOILYCU21NKFb7TcqM4LiwTg43IGRFuE1iqlbZ3OI9LEPKSsHISF6Lr03jS2Jd97L6k6fkhk+6bCBk0/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352941; c=relaxed/simple;
	bh=DIY06MvOCGoCT/rWszU3PDIj/hKNjUGtl5CqDJ6p3iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUaelUvtlr2TBZ/EujTaw+eEM8EozTZ/mA0QSUM+jZkYqh7u5hUKBFL6+FTmLTNKcynD/8SpcIQy7Xr/I+uMmq04mhUzPch9asblZfNYxRE1vwtaClSvtviHYB2+J33BnYxkVu3B0NRDt8zkx+uO8j+uiTEVkLIOHE0ry4ug3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5uHEOJd; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 22:28:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762352936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMTOVzEcNogHh5J3cMU2LTE6K/THsHJRQJ4BYB50pjI=;
	b=G5uHEOJdRHS3YT6NMWyMuDv9724N7V54/Ln4ncGNcZ2oEaS+6t0jgsTuBSVMiqzuGrBssJ
	cyHJzw/vvSnIqhanQnBJ5Dov5sO1OFUyuLddF3uZloCSbEnFaa8N/BJavlE6LT412HAzFK
	e1/oGvPys8dliZuV5bXhijMKHU7dei4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Encrow Thorne <jyc0019@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] reset: fix BIT macro reference
Message-ID: <aQteoBKKmqQ_zWBg@troy-wujie14pro-arch>
References: <20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 05, 2025 at 09:35:02PM +0800, Encrow Thorne wrote:
> RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> include bits.h or bitops.h. 
I believe bits.h is enough.
>
> This causes compilation errors when
> including reset.h standalone.
> 
> Include bits.h to make reset.h self-contained.
> 
Please remove below commit message when you send real patch.
And I think you can send real patch now.
> This patch is sent as RFC to discuss whether including bits.h in
> reset.h is appropriate.
> 
> Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> ---
>  include/linux/reset.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 840d75d172f6..d3102eef085e 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -5,6 +5,7 @@
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/bits.h>
with keep sort as what Philipp said:
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
>  
>  struct device;
>  struct device_node;
> 
> ---
> base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> change-id: 20251105-rfc-reset-include-bits-4ec72344d1a3
> 
> Best regards,
> -- 
> Encrow Thorne <jyc0019@gmail.com>
> 

