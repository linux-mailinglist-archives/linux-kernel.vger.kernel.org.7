Return-Path: <linux-kernel+bounces-733600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD4B076C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E745841B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1129B1A2541;
	Wed, 16 Jul 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKHBQ/bY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F431A0BF1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672071; cv=none; b=oglMoE8ghauBuoCg3ff1lpjdauj++YJ4nZ92Ei0tbF+v4l0YPb/9y/ttf3TR5CR1RAqDCHadvQPpXLCHltSebdry54p2TYse04PXb0OJ7/cFYZsqy27BmfkHz7O9V73GhKSOa87cwm2CQOCQzgQjC5sVCqbtN78FcXMplk22O+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672071; c=relaxed/simple;
	bh=TzH+a8qh72uAAsJFx+foN/9TXpBpMhGJGuaV/QalWz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GohuWkGGnSjodpCC9atIx1KTtxI2itL+vk0wClCIIZLy/5TVZhbf1M4SRqVtnwlSSz1LXz7AxnYrY7gxryKawU9jK75oIOQQxShxM5Ggj1+k16RiaEVVOmxTV5lQCEsRPA55ASujNbA5oQLy4O49ol25TvvKhuTYsWyixk6zOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKHBQ/bY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48B6C4CEF0;
	Wed, 16 Jul 2025 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752672071;
	bh=TzH+a8qh72uAAsJFx+foN/9TXpBpMhGJGuaV/QalWz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKHBQ/bYf4IPxwarE1Ii22wy5O2/6163/XP3QaweEUfmVempcv27UWGUJWKwPqff+
	 LjZETITLi6p9Cya4Mp0FDAyPvV8sthC6Ly/a9uamj1KANJ1R8WiIARCMt417PThtPt
	 F7eMoI0caHsEoIKsdBY+z6HY0dTf4nPjx0Nt4MAE=
Date: Wed, 16 Jul 2025 15:21:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-devel@silabs.com, Alex Elder <elder@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [RFC 2/6] greybus: cpc: add core logic
Message-ID: <2025071645-awkward-spotted-9d25@gregkh>
References: <20250705004036.3828-1-damien.riegel@silabs.com>
 <20250705004036.3828-3-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705004036.3828-3-damien.riegel@silabs.com>

On Fri, Jul 04, 2025 at 08:40:32PM -0400, Damien Riégel wrote:
> This step adds the basic infrastructure in order to use CPC as backend
> in Greybus. The goal of CPC is to add reliablity, by implementing error
> detection and retransmission for links that don't have that capability
> by default.
> 
> When Greybus establishes the connection between two CPorts, CPC will
> create an endpoint for this connection. Greybus messages will then be
> encapsulated in CPC frames, which basically are a custom header +
> Greybus header + Greybus payload.
> 
> As this is still evolving and not the main point of the RFC, the whole
> core is squashed in one big commit, but it will definitely be split into
> more digestible commits as we refine it.
> 
> Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
> ---
>  MAINTAINERS                    |   6 +
>  drivers/greybus/Kconfig        |   2 +
>  drivers/greybus/Makefile       |   2 +
>  drivers/greybus/cpc/Kconfig    |  12 ++
>  drivers/greybus/cpc/Makefile   |   6 +
>  drivers/greybus/cpc/cpc.h      | 135 ++++++++++++++++
>  drivers/greybus/cpc/endpoint.c | 158 +++++++++++++++++++
>  drivers/greybus/cpc/header.c   | 212 +++++++++++++++++++++++++
>  drivers/greybus/cpc/header.h   |  81 ++++++++++
>  drivers/greybus/cpc/host.c     | 113 ++++++++++++++
>  drivers/greybus/cpc/protocol.c | 274 +++++++++++++++++++++++++++++++++
>  11 files changed, 1001 insertions(+)

I like the idea, but you are going to have to break this up into smaller
pieces in order to get us to be able to review it well, sorry.

thanks

greg k-h

