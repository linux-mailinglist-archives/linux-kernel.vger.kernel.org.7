Return-Path: <linux-kernel+bounces-845720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE40BC5EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 330C94EB162
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1229CB4D;
	Wed,  8 Oct 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYTqT7nQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D117A30A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939343; cv=none; b=qa4FpKtOSq9i2WkWox1d5//S0Eop0D3PgaC8cUYg8UfHK2PjxDizbbfrmsqM1F/OI3IcL1pg4b6gkfeXXH1wgh/RByMnWLH8W/if2uTbAuNw08IMvumM+TaUl8ZVhEP+RJuhv5wPLYphXtmY4pGsdyOWun5F+dfkapSc3xRsg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939343; c=relaxed/simple;
	bh=YMas2myWwPlmTfqOYwizXKxICsM8g5LB7bmAgSvuJ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3FeOWv9u/lC2bwXiFOHBhc7bwPQIwe43HwMhTTxRlguuP+sd0HZ+YIIF3H2LnY3aAURxS5SPjjNcWYCjAjL/dTkqu4BwEwIphEoF7pLEgjsm1dePMu5bYgY+EjYEfvuhu32aIiGVVomg/9H1291SfNSagCd40oimye/j7I099E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYTqT7nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D732DC4CEE7;
	Wed,  8 Oct 2025 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759939341;
	bh=YMas2myWwPlmTfqOYwizXKxICsM8g5LB7bmAgSvuJ7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYTqT7nQ77sNpHPZJGXyJzffVuKGMw2+DJnTd+yHuwle37VDvJOW0FqkpT+8AT3Ba
	 ZO+rnDrALroEl7pLnzNv4Q0jr28MNL9zWoyp+0OR1kGucsOkqmfMgZAOf8HC6cJDXQ
	 rC4PEdGJME4r3tCZRbVjKgBsNO3fEPkAXKyg+NHxjZb3Jp+A+yILsti4GPycRYx+WM
	 OUklC1ssYpLtI0NRC7BcolI75sixQmx3LpKF2UdosIaLbMf5FbV8rTiKpE2Rbrer3F
	 6HqZP2lHFfPFzIWN+qA+E4TpNHTPagPZ3EvaE5TEOrKfYxRa8rRqXOuSds0hce8z77
	 nOQ2blLfLrCtg==
Date: Wed, 8 Oct 2025 17:02:18 +0100
From: Lee Jones <lee@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: altera-sysmgr: enable compile testing
Message-ID: <20251008160218.GB8757@google.com>
References: <20250925150504.24955-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925150504.24955-1-johan@kernel.org>

On Thu, 25 Sep 2025, Johan Hovold wrote:

> Nothing seems to prevent this driver from being compile tested so allow
> that.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mfd/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c1b58181f79..aa950b0cfda3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -45,7 +45,8 @@ config MFD_ALTERA_A10SR
>  
>  config MFD_ALTERA_SYSMGR
>  	bool "Altera SOCFPGA System Manager"
> -	depends on ARCH_INTEL_SOCFPGA && OF
> +	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
> +	depends on OF
>  	select MFD_SYSCON
>  	help
>  	  Select this to get System Manager support for all Altera branded

Applied, thanks

-- 
Lee Jones [李琼斯]

