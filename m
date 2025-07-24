Return-Path: <linux-kernel+bounces-744194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE898B10951
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4C4168E26
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11822750EF;
	Thu, 24 Jul 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaN7MlZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2623D291
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357035; cv=none; b=M0tpHubTT2zHzz35LmdViYhy+nTcycf/P0f9NBDiksR2qlzcrzBRB2I3FvQbTRsD3Gtf8UCFCCxKCN/Ztj0WsCE6sutELlmpLnaLS56Q8p5c9uqhW2HYyhYeaxpTsyXbt2EVD0Gks9aLe+wScv2Mg4CKOU6T44kidRdt9AkQTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357035; c=relaxed/simple;
	bh=0vwcLDs25+aKjY8qa1rOAxbgBVI2bfhtVr6US5L7qe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHKZLv+vb/DJGkgRWvBz9Jp7Sx/lBFCL0PehIKn8aEpzbBiednQDxHXKzi1eylHCuO7mcQRb90UupJ79MKiFDegWinyisqQ25Y8oqHymGA+VA2vfGLORZfMQ9AHrwT9bS1ZYqGMmG1RXGTFW2fB0tWjDjNKDm4ZHuylVSatNrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaN7MlZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4BCC4CEED;
	Thu, 24 Jul 2025 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753357034;
	bh=0vwcLDs25+aKjY8qa1rOAxbgBVI2bfhtVr6US5L7qe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zaN7MlZohFhYM6OJLqafY9WmKlkTIFfntnXmY0vnPgAfssawQ8QnzK3WiT4YMmrcq
	 3XVM6A4LIdp7wt2PnoFTjvBR3zOG6xpIyAc3SPuzLuNl+xrdmb6XIYrFG62aLvw2P2
	 o8nLi8udO5F2i0+OMXZQ2f6ENX9iM4jJhtKiQgto=
Date: Thu, 24 Jul 2025 13:37:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Liya Huang <1425075683@qq.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/faux: Remove unnecessary match callback
Message-ID: <2025072450-stony-spearhead-03f0@gregkh>
References: <tencent_5782606120514CBCC9339FD79EBC411FB607@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5782606120514CBCC9339FD79EBC411FB607@qq.com>

On Thu, Jul 24, 2025 at 06:37:23PM +0800, Liya Huang wrote:
> The faux_match() function always returns 1, indicating a successful match.
> The driver core function driver_match_device() already handles this case
> by defaulting to 1 if the bus->match callback is NULL.
> 
> The implementation in driver_match_device() is:
>   return drv->bus->match ? drv->bus->match(dev, drv) : 1;
> 
> Therefore, the faux_match() callback is redundant and can be removed to
> simplify the code, with no change in functionality.
> 
> ---
> drivers/base/faux: Remove unnecessary match callback
> 
> The faux_match() function always returns 1, indicating a successful match.
> The driver core function driver_match_device() already handles this case
> by defaulting to 1 if the bus->match callback is NULL.
> 
> The implementation in driver_match_device() is:
>   return drv->bus->match ? drv->bus->match(dev, drv) : 1;
> 
> Therefore, the faux_match() callback is redundant and can be removed to
> simplify the code, with no change in functionality.

Why is the changelog text here twice?  How did git send-email get this
wrong?

confused,

greg k-h

