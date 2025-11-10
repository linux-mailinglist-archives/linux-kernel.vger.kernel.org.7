Return-Path: <linux-kernel+bounces-892856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC7C45F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E8F1883230
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED558301474;
	Mon, 10 Nov 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgZvgEp2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516572FFDFA;
	Mon, 10 Nov 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770965; cv=none; b=OVatbVesSoINv/ZiPiKjwQvt1cyPYAErF4He9YYIB00tbOYK+WWvYU6jDsaRmcW6Atqgde68s62+W8OoHm4hUoYpbggLKw/6OyK9NRMxQca0eh/d2SCIG26KsKpelXClTXp6onzR+HVkLGov6jN4jKZWp4GbUcr1A14IZOfn+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770965; c=relaxed/simple;
	bh=oVvMsotVgJ8fLnT1PNq+SF5qQAbCTphuBRN/mJCO1Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTLgusI7yBzJoajE7JW83jSksJnKNpOG+4qov/8LJOl5+QlAM8lDyTlyB/haoFFengF9LQ6STh8Ebas/OUf6Q3xm/vAm12gXyqG8qARy3/iHN0IgXz2rwSItM8jH3DfRVnnm0PZq9xdk3BsNAPvsMMIn5xfxkzr4mjT411XhSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgZvgEp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2362C4CEFB;
	Mon, 10 Nov 2025 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762770963;
	bh=oVvMsotVgJ8fLnT1PNq+SF5qQAbCTphuBRN/mJCO1Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgZvgEp2tbvY2NtbGlGqmOyuI5ghaENGdDQU8f5Uwcf7fg6BUqSdNH/MeXdY1t1lc
	 l2HzMa3I6Y+2dMsyDRn5iO+++XakPlamh8a4FpnIDapgSRQ8pSWgfgiSHup9IE2wRv
	 hNOb79iHFo/wMmB5NpVohZFjsQ29f5vMSwE6Vg5jImqtPxe80hfuF16+0V0P+oXBEW
	 ngDlpLnYZd6P5RiVSP+PuKxtTUYIhoxu5Z6myuPNar7LSedJ5Xm1WhMCe0woZpWxP9
	 N3Eo02s+iW+VQC/jZCo+Kk2wAvb+MklzED8i+87OUIGFjvnHXxBsNymS4OFpHimfmW
	 RRhk3vwy3uvZg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPFj-0000000012s-3UJA;
	Mon, 10 Nov 2025 11:36:03 +0100
Date: Mon, 10 Nov 2025 11:36:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] gpib: Add gpib Kconfig option
Message-ID: <aRHAE_zC7ldGxUzc@hovoldconsulting.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
 <20251110102507.1445-11-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110102507.1445-11-dpenkler@gmail.com>

On Mon, Nov 10, 2025 at 11:25:06AM +0100, Dave Penkler wrote:
> As part of destaging the gpib drivers we need to add the sourcing
> of the gpib Kconfig file to the main drivers Kconfig file. It has
> been added just after the Kconfig for the comedi drivers as they
> are most related to the gpib drivers.
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4915a63866b0..01602581b880 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -161,6 +161,8 @@ source "drivers/greybus/Kconfig"
>  
>  source "drivers/comedi/Kconfig"
>  
> +source "drivers/gpib/Kconfig"

And fold this into the commit adding the Kconfig.

Joha

