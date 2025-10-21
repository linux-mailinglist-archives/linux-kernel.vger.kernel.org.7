Return-Path: <linux-kernel+bounces-863328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D4BF7916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 772AE346912
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090203451B3;
	Tue, 21 Oct 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="re3yaQ7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CA330D3D;
	Tue, 21 Oct 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062573; cv=none; b=TZSf7jkTgpvVVHhkWnWOj0kKm4mrfI2JOdQ3GYbd8TB37pQ1drXVRqGCf49ozBI+2M3De9k3FHrD0uKivQYC19Bqp6BOTjiNvjSpscu15M/EgffRTH9ZSq2yAFMHwHb92zq6wdTg4/D7DTpgLEnO9bURw2csJEoHSjvGHTiBKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062573; c=relaxed/simple;
	bh=RN+xlzuSwV5Gi4/RsAUYxVegWRCsuaR+Gqa7ha8Fuho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua5pMB8AqjdweNSghVzDlyS7hu+a3jtgQKxguC6kRCPbp5xZ8i/KABF1xbu1W6tPk/SRSdofYocYKY0rZWFYft+mDTwJ/L32p9+ra7RZV72niMhfC3bvcatLmhFEcsuDQv6p4mVDZqMGDCSUscaTzkWCP1pbyRfDOlwAeXFgLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=re3yaQ7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D46C4CEF5;
	Tue, 21 Oct 2025 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761062572;
	bh=RN+xlzuSwV5Gi4/RsAUYxVegWRCsuaR+Gqa7ha8Fuho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=re3yaQ7FXhbwlwEfaTIdmRra46d2G+MHFnpiwvWDg1YKmshp5Gh2571N9b8hxrEbF
	 oSwzfCh8BUjjX/QqiwjS5XI9wVB7LlIWF8pxbotDLp2Tzz/AvEe7w0SzavaH2uCWbs
	 j4CMJAQahl/9fXUr0Q2m/lkK4aSJXcJQKzdqaFwQ=
Date: Tue, 21 Oct 2025 18:02:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Olle Lukowski <olle@lukowski.dev>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: most: video: replace BUG_ON() with
 proper check
Message-ID: <2025102127-polio-opossum-f40b@gregkh>
References: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
 <20251021-staging-most-warn-v2-3-cd51e1e717f6@lukowski.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-staging-most-warn-v2-3-cd51e1e717f6@lukowski.dev>

On Tue, Oct 21, 2025 at 04:09:30PM +0300, Olle Lukowski wrote:
> Replace a BUG_ON() call with a proper check to prevent an unnecessary
> kernel panic.
> 
> Signed-off-by: Olle Lukowski <olle@lukowski.dev>
> ---
>  drivers/staging/most/video/video.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index 32f71d9a9..3a7ee2791 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -575,7 +575,8 @@ static void __exit comp_exit(void)
>  
>  	most_deregister_configfs_subsys(&comp);
>  	most_deregister_component(&comp);
> -	BUG_ON(!list_empty(&video_devices));
> +	if (!list_empty(&video_devices))
> +		pr_err("video_devices list not empty during exit\n");

Is this possible to ever have happen?

thanks,

greg k-h

