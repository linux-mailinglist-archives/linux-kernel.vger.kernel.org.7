Return-Path: <linux-kernel+bounces-823264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93799B85F31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4210D3A95B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72EC31354A;
	Thu, 18 Sep 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SUvHGaiw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1C2459FF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212402; cv=none; b=JVstu+pD6pbDtViozbwC+s0fstVMHwK/Dpxln6NYoy1tire/J04ThXm5Y/Lq3lw7c0qJMnahJIOz4dwODa9hENKoz3W+GtJuMnSQW6eEAvVx30GpKyYL+xoQwgEMqn5/eCuT3kKEo9KgGX9KhDnr0DipgdVvvjCEJX8H/brbuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212402; c=relaxed/simple;
	bh=rWbu+wWA6tpH6VL8qq9bPzeJY5GUFS6Wv0lv92/531M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swxoPfL/D3QSQFSXnIHIjNXSF/r5Tl5IavunfrkKFFpYNsKbLeanZCaqGGFMtH4Gl0VkZqQd9Wg1Tufp3GlCL6oiSLOIsGI01MCp6Pno4YPSdo8f/0bnAOfrCOT6iUoEBRTecdzJzOyi7vNpBfc/n/Q6T0LiFkos7aqUtaaNyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SUvHGaiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E43C4CEE7;
	Thu, 18 Sep 2025 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758212401;
	bh=rWbu+wWA6tpH6VL8qq9bPzeJY5GUFS6Wv0lv92/531M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUvHGaiwEwA7wsVjSuIZojPeblDUUhp9dbjvr7BYUE8yWCip/PEUhPeHoxfE7K+J2
	 3r1nkPDOA26PJmoJj3S68xbdPDPuoqp9z/JyGMlSsVtkMbKs96SnhhnFq/ab3+nd2m
	 JxAUoA/i06SiAX76QMRCLMeWwnZCDDpijWT8h1EI=
Date: Thu, 18 Sep 2025 18:19:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwtracing: intel_th: make intel_th_bus const
Message-ID: <2025091853-unethical-figurine-f8d6@gregkh>
References: <20250918133937.268948-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918133937.268948-1-abarnas@google.com>

On Thu, Sep 18, 2025 at 01:39:37PM +0000, Adrian Barnaś wrote:
> Because driver core can properly handle constant struct bus_type,
> move the intel_th_bus to be a constant structure as well, placing it into
> read-only memory which can not be modified at runtime.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  drivers/hwtracing/intel_th/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
> index 47d9e6c3bac0..ba7c8b184cbc 100644
> --- a/drivers/hwtracing/intel_th/core.c
> +++ b/drivers/hwtracing/intel_th/core.c
> @@ -166,7 +166,7 @@ static void intel_th_remove(struct device *dev)
>  	pm_runtime_enable(dev);
>  }
>  
> -static struct bus_type intel_th_bus = {
> +static const struct bus_type intel_th_bus = {
>  	.name		= "intel_th",
>  	.match		= intel_th_match,
>  	.probe		= intel_th_probe,
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


