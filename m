Return-Path: <linux-kernel+bounces-863326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDBBF7910
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936683B6373
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D203451B5;
	Tue, 21 Oct 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbD6kg6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088C3446CF;
	Tue, 21 Oct 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062543; cv=none; b=shLBjYcZITkclAYFyJrYifziijDTjnPFWFVJhad/jLIbc07T+MXrctHSd9D07I0WbQ8W99oJL5q/Hclp8+NiVLGzdZwEysRIKNmMiDWK94nIRJLr9wUGo4tUXVgFc8Rps/YnyqiKkVe4zf/QL7TYkuUQ+xF1+SF1yQbEwsk7kDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062543; c=relaxed/simple;
	bh=P+RznSpBWRdr/Wlu6he4/KMoMQItfGKiQ752hnJNb/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol1PKTuybHW3P+kWxXKdhcnasu7W7cZKnSkxAsQfy4vgYNYonj3eGW10m7BfTb03P0u8ZccOeGIqQVrxKETOyCPe33setU9enjmWDyFg3vfX3ZL1git14KFncfSBZTjRCAqPz19G9O486ntzlhrw2rbqRx4gsBl7qwwmtuFlobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbD6kg6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A3C4CEF1;
	Tue, 21 Oct 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761062542;
	bh=P+RznSpBWRdr/Wlu6he4/KMoMQItfGKiQ752hnJNb/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbD6kg6hLcoZvgzNxQtrDdlbOIKwnHfHmXS5Pb9WiJ6mow4aewkOuCtKt5H/ioUXj
	 zFsKXt/8imt+95CY4ejCDvu9VxV1X2sV4dJAu7/LgYl7txsfKgLg7y5+7N+S26j4P9
	 flh+VX/arOuNFNdql8GgZ/dgjx6jLvl77/SK3FRE=
Date: Tue, 21 Oct 2025 18:02:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Olle Lukowski <olle@lukowski.dev>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: most: dim2: replace BUG_ON() with proper
 checks and error returns
Message-ID: <2025102108-smartness-rework-238c@gregkh>
References: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
 <20251021-staging-most-warn-v2-2-cd51e1e717f6@lukowski.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-staging-most-warn-v2-2-cd51e1e717f6@lukowski.dev>

On Tue, Oct 21, 2025 at 04:09:29PM +0300, Olle Lukowski wrote:
> Replace BUG_ON() calls with proper checks to prevent unnecessary kernel
> panics. Return appropriate error codes (-EINVAL or -EFAULT) instead of
> crashing the system.
> 
> Signed-off-by: Olle Lukowski <olle@lukowski.dev>
> ---
>  drivers/staging/most/dim2/dim2.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> index dad2abe6c..d0832704b 100644
> --- a/drivers/staging/most/dim2/dim2.c
> +++ b/drivers/staging/most/dim2/dim2.c
> @@ -166,8 +166,10 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
>  	unsigned long flags;
>  	struct dim_ch_state st;
>  
> -	BUG_ON(!hdm_ch);
> -	BUG_ON(!hdm_ch->is_initialized);
> +	if (!hdm_ch)
> +		return -EINVAL;
> +	if (!hdm_ch->is_initialized)
> +		return -EINVAL;

Can these things ever actually happen?  In looking at the code, I don't
see how that could be, do you?

Let's not check for things that are impossible to ever hit.

Same with the other changes in this series, please verify that these are
actually possible to happen.  If not, then just remove the check.

>  	spin_lock_irqsave(&dim_lock, flags);
>  	if (list_empty(head)) {
> @@ -188,7 +190,11 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
>  		return -EAGAIN;
>  	}
>  
> -	BUG_ON(mbo->bus_address == 0);
> +	if (mbo->bus_address == 0) {
> +		spin_unlock_irqrestore(&dim_lock, flags);
> +		return -EFAULT;

You need to do more than just that here :(

Please be very careful on error paths to properly clean up everything.

thanks,

greg k-h

