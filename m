Return-Path: <linux-kernel+bounces-788318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87165B382C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B7417F7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010CB307AFD;
	Wed, 27 Aug 2025 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DEPAr+pG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE971A0711
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298783; cv=none; b=OY9nodyh7Op9pyR4r1DLUdVmcZftyd6BPlqVYys9LOLsyvpLMNjWAnfo9brdBPD+AZrGZasBfPKWV2lvYiQF3BZ/tWhPngb3ZBJjLrgivKgX6UQBtlKxt68+OJGH+EZtXTps9xB9S6Mh2EMgxUXHgD5YyajSnSEWRpKuXrwm0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298783; c=relaxed/simple;
	bh=nnSCxw1iZ1Q7cRVjXpqsgv65+CCdynSW8nKFaPIbcp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Utn1enz6+N3hn7okJ3WfOL/7WqzB354eNk0zcXPQI2zY4QHBo+LAtXF5iusX1S4miFSw0/voB7MbnvQv+XikPmSeC4v30YYh8P9MBC1Rkjnxs0EOmS3wk9UkZIz8LGi1Oy5WaECNiigbvHQ7+BtHFyhWln0ANuHmBxJ1jSv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DEPAr+pG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [213.244.170.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7EAE12093;
	Wed, 27 Aug 2025 14:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756298716;
	bh=nnSCxw1iZ1Q7cRVjXpqsgv65+CCdynSW8nKFaPIbcp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEPAr+pGbD0maywrSdDOecgUU2QsS5iWefrUOxYnPfRKZzQXF55DXNttn04Twsdk0
	 GTujJ1IYF9BCcvnU3P3u5KS7XVlCB3BOL+6PDc3o6JyO4azTKeCC4hW1rpz2pVuppa
	 Oi+0eQ5WdBrOvAiapimJEvpqtNmNsA3y3jGycXeo=
Date: Wed, 27 Aug 2025 14:45:57 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 2/5] staging: vc04_services: Cleanup formatting TODO entry
Message-ID: <20250827124557.GG5650@pendragon.ideasonboard.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-2-5052a0d81c42@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827-vchiq-destage-v1-2-5052a0d81c42@ideasonboard.com>

On Wed, Aug 27, 2025 at 11:54:09AM +0530, Jai Luthra wrote:
> The code indentation for the vchiq interface driver is not so bad
> anymore [1], so drop it from the TODO.
> 
> Link: https://lore.kernel.org/all/20241013112128.397249-1-umang.jain@ideasonboard.com/ [1]

Adding '[1]' at the end doesn't seem to be standard practice and may
break automatic parsing. I'd drop that and reword the commit message
accordingly.

> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/staging/vc04_services/interface/TODO | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
> index f6f24600aa86240fba77169f62f3e657e42727c3..6e5f27db88ba8e533ee1fabc3091771d8efe66a2 100644
> --- a/drivers/staging/vc04_services/interface/TODO
> +++ b/drivers/staging/vc04_services/interface/TODO
> @@ -20,9 +20,3 @@ some of the ones we want:
>  
>  A short top-down description of this driver's architecture (function of
>  kthreads, userspace, limitations) could be very helpful for reviewers.
> -
> -* Reformat core code with more sane indentations
> -
> -The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
> -indentation deep making it very unpleasant to read. This is specially relevant
> -in the character driver ioctl code and in the core thread functions.

-- 
Regards,

Laurent Pinchart

