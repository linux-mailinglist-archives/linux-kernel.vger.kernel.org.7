Return-Path: <linux-kernel+bounces-823262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0BB85F59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5236188B4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE63112B3;
	Thu, 18 Sep 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jnpukQS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBA21B905
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212389; cv=none; b=H8FbnoHtcJTuoyPwVdo/yW3AECqEYViORA0f7gdaCaaDkTqRH34g5AnO1FhL+CUGkvqIT77DRvk+EVGYVCGc7cjkHzvDu6H3kjZb+EbGos79ns1DeMUd9mGnaDv9W5LI4pq97VplDbqOybxJaHBZpGg1BR3gyE+iUbXQZdz4w5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212389; c=relaxed/simple;
	bh=/Bp4ayrRI8DCfRd7XTDaDzrA4t4torLE5+3IaHn/8PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gskzJ8beStsKHZVsRtgN+bFHDoqKgKxsu+ezCMJI3b+gyjain8ezFMmIBGmyezeKK4FCdl7XImtjTOGHuzLv/67dd/vENMj+CBIDV6QJ+d/g32DIefOgdO0WQroXnQIVaEu9b02VGk/rCIupu6YryF7FtLtouv58sc8M/ATQbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jnpukQS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94223C4CEE7;
	Thu, 18 Sep 2025 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758212389;
	bh=/Bp4ayrRI8DCfRd7XTDaDzrA4t4torLE5+3IaHn/8PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnpukQS51J4MYt0Wcat87Vh/X9PimHXG8pf0rXYEekNeImXxN/4kKsRRdZQo2RHJa
	 8Mee5HOoMypPugX2YINMABeW2ETswBaoAZTT3BhBkkRD/5HgkTqlFPaUk6S3VW5o3B
	 mQ4SkbGOjub4VUsqodTzS1HBhQ3VJ1C9n78NGGuE=
Date: Thu, 18 Sep 2025 18:19:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: cell: make spu_subsys const
Message-ID: <2025091830-deeply-crave-728d@gregkh>
References: <20250918141633.339803-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918141633.339803-1-abarnas@google.com>

On Thu, Sep 18, 2025 at 02:16:33PM +0000, Adrian Barnaś wrote:
> Because driver core can properly handle constant struct bus_type,
> move the spu_subsys to be a constant structure as well, placing it into
> read-only memory which can not be modified at runtime.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  arch/powerpc/platforms/cell/spu_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
> index 2c07387201d0..733b512992c0 100644
> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -464,7 +464,7 @@ void spu_init_channels(struct spu *spu)
>  }
>  EXPORT_SYMBOL_GPL(spu_init_channels);
>  
> -static struct bus_type spu_subsys = {
> +static const struct bus_type spu_subsys = {
>  	.name = "spu",
>  	.dev_name = "spu",
>  };
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

