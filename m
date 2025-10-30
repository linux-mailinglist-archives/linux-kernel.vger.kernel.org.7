Return-Path: <linux-kernel+bounces-877728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFFC1EDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D3644E784B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC0338598;
	Thu, 30 Oct 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVPMdLhU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CED337BB8;
	Thu, 30 Oct 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811064; cv=none; b=UolyztHNac65o9b8YLLdORLFbEPhIYuoy0/84EPsNviVIFCx8Pyyhdzc5YzB9P4aPeyI1e5pMgz9Sn0RfBy8WFnWtFfhrjItjD5E+Nsz8s6vs1z9veWjt7fr3bdWwkth/gfJC3yDu6YiLfJwQike08wPzFhKZ4QlsLpLIvI9XIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811064; c=relaxed/simple;
	bh=Gbox8rdWGZ1D44utOerJFDJX1Ra41eaNoAS7VxhH3Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwMvBwERIzgHgGBrV4nE3Xyi0M5oQYSCM4PCNttP/V5phtYFmjAPQu8nnnFgGqQ3wWXXrohWaZxoI6Ta9I8NTZjbyiBTeKmQqClwBt+uHz9oyVja3pSKcrVwyZMWc8qklEN0JWtxs/3eHr0iRFidebv4iXJAfkAPpOYEUKLofCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVPMdLhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7919C4CEF1;
	Thu, 30 Oct 2025 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761811064;
	bh=Gbox8rdWGZ1D44utOerJFDJX1Ra41eaNoAS7VxhH3Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVPMdLhUbGJKktYokhEWTsad8YjDF/vFbc2Sfjwk/uT2nM4EGosKgZzWYosA+tE0E
	 8Hzkp5Z0FfSNR40j/e23NH1PWXaykP7Y79netiPfK6t0M4LcfkjYKIIxdVyh4YSIt0
	 6XKVNEw6g+3aR8U9JEn/3ewBGDmb19aYkdySAQOjPtRHFXVHFVHsiNzKiedSLjz9iP
	 9L7haZq9egk4u9WYW1uupjiI+gQA8a+uMqASSgGkpN/+rWsYnhpnjk2VUAp3XLNTvr
	 iJfFESaDnlVZbVMuN0VJ/RI6ZzfW5rhb4AOnpJvh+JGcX0j6CoqTG/abejMOHLjL3I
	 /XS1rlglAe4Xg==
Date: Thu, 30 Oct 2025 08:57:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Message-ID: <20251030-pastoral-discerning-goldfish-e8f3bb@kuoka>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
 <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>

On Thu, Oct 30, 2025 at 11:30:09AM +0800, Khairul Anuar Romli wrote:
> Add the compatible property value so we can reuse Intel Stratix10
> Service Layer driver on Intel Agilex5 SoC platform.
> 
> This addition is an initial Agilex5 service layer driver enablement that
> will involve adding IOMMU changes in the future.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Add driver compatible for Agilex5-svc
> ---
>  drivers/firmware/stratix10-svc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index e3f990d888d7..afc6c8b43e98 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1117,6 +1117,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
>  static const struct of_device_id stratix10_svc_drv_match[] = {
>  	{.compatible = "intel,stratix10-svc"},
>  	{.compatible = "intel,agilex-svc"},
> +	{.compatible = "intel,agilex5-svc"},

So device is fully compatible - drop this change and express
compatibility in the bindings (see writing bindings, writing schema or
slides from my last OSSE talk).

Best regards,
Krzysztof


