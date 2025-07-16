Return-Path: <linux-kernel+bounces-733598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD9B076C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443F43A71AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360E1A3167;
	Wed, 16 Jul 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2A+4VlVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D019D89B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672021; cv=none; b=Bg+TimYoGIRzVz/oZz8kKqnkdGOMl9EZ5sIg/NFieP/5NTAD0WqfpBVkpg4hD9qOnn0zwtW8zOrn08v6RYsPFWTHKnfZVeIFv1Mj8DGFbE/cVuN+ExkLZiye/RHd5k0D+G6bVsbXpBQMDikqGL5ZUGWBuCmzfcPLxTsC104mE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672021; c=relaxed/simple;
	bh=DTtA1e73pK5YvYw6cEcPxn73u1AvhrWuciWj2jpkaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNjFNKWJfCdmdDHpRNd5RpnFDcg0ixDPEsqa4PL0pZvLZVhobk9Pexly/izDifXEer+QEXqwFXKlhgJ/uC0wUi25fn8UQdbaWL/TefCUzoYbxKBPFUVQS1MCOQaesz7jG97yCB//wHfvUVH3xboy4EoDqtxRae857Ipicd4ahiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2A+4VlVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D15C4CEF0;
	Wed, 16 Jul 2025 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752672019;
	bh=DTtA1e73pK5YvYw6cEcPxn73u1AvhrWuciWj2jpkaOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2A+4VlVMrRMQyNIHfN7+ewP5vB4iefES5I953EUAy5FufPi/LvT49aaIT8z0lzFh7
	 fchve6zI7ddeM0d4ZaDQELybD32aIRWoPu5VSC8kZRU/1AheJsEJcCn8oubzgTmOTi
	 NFQHeFqn9suvJzBdNpKBNbyNQE785vwW9Q+7vwgU=
Date: Wed, 16 Jul 2025 15:20:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-devel@silabs.com, Alex Elder <elder@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [RFC 1/6] greybus: move host controller drivers comment in
 Makefile
Message-ID: <2025071604-plus-spoiled-3d39@gregkh>
References: <20250705004036.3828-1-damien.riegel@silabs.com>
 <20250705004036.3828-2-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705004036.3828-2-damien.riegel@silabs.com>

On Fri, Jul 04, 2025 at 08:40:31PM -0400, Damien Riégel wrote:
> gb-beagleplay is also a Greybus host controller driver, so move comment
> accordingly.
> 
> Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
> ---
>  drivers/greybus/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
> index d986e94f889..c3564ad151f 100644
> --- a/drivers/greybus/Makefile
> +++ b/drivers/greybus/Makefile
> @@ -18,9 +18,9 @@ obj-$(CONFIG_GREYBUS)		+= greybus.o
>  # needed for trace events
>  ccflags-y += -I$(src)
>  
> +# Greybus Host controller drivers
>  obj-$(CONFIG_GREYBUS_BEAGLEPLAY)	+= gb-beagleplay.o
>  

The blank line should be dropped here too, right?

thanks,

greg k-h

