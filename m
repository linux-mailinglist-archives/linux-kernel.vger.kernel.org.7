Return-Path: <linux-kernel+bounces-892854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EBC45F39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0244F4E02A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4712FF64C;
	Mon, 10 Nov 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCO4GAp2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2F225762;
	Mon, 10 Nov 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770931; cv=none; b=fKTObqI95lVqn9F5Dj/bpyJEcFGuME4QiGyeGI4b2O5U5Fai/wtVdb7yLCFO5bMpYC/giy4cF0kQK9YSXlLcgDaxWP0UOktyQq7l8er8ihND6ghoudwOezIAi+RRBC9rw9+wEcpQv8KOsxDbS68ws6j59ae+sGguT3fnhzOflIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770931; c=relaxed/simple;
	bh=APQ9Z60y8s3YqJHhBPGNva8ePZrrpH1EJJVpKfxSw9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qafJpKtOoGUsxzW9IvbCrBPu6DELWgfe+Nqua62+cAnkkCkVs1S1bG0HYcWuQh7JeLeZjnixEzIzpeBLWcplmrTU/ALpLWvY5FTrdjZlriusw+2IFVh2ji9no8p5l8rp2YP8IPZZt+g8ecvjXvdDWCnla+h92PytTXyisnPcgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCO4GAp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF9AC4CEF5;
	Mon, 10 Nov 2025 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762770930;
	bh=APQ9Z60y8s3YqJHhBPGNva8ePZrrpH1EJJVpKfxSw9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCO4GAp2VT1HxKj1NrIj7x3vvEr4A5K+tu7X/+uFg3a5/nsl89/goq++K4dBENP49
	 v44/ZxBYYxufNEttvH8ankUTtmhAOp/o5BtcVA6Is9OGeCesEYKAoBKn7L2V83H1gL
	 nzKMb9sEWhk9zXla1s2zO7nnf7YivHLDPkB8CVyXmlaSfRPpA5tRuA0ZgzUnhB0hh5
	 UkIXPMnefdR7Ra8xq6UNW7MoA5CqB/tNlLEzVk4p/VfpCho8bbpDduyKk/bN+lBsMp
	 WAQ11QM5C95A//86nanqUwGAki49swL+fhbbcMr4GbyE9HOcksp7OV/R/3kRODlzma
	 pdfaut6uJYCJQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPFC-0000000012J-1wai;
	Mon, 10 Nov 2025 11:35:31 +0100
Date: Mon, 10 Nov 2025 11:35:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] staging: Remove build of gpib drivers from Makefile
Message-ID: <aRG_8iBPtHjpvzxu@hovoldconsulting.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
 <20251110102507.1445-3-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110102507.1445-3-dpenkler@gmail.com>

On Mon, Nov 10, 2025 at 11:24:58AM +0100, Dave Penkler wrote:
> Once the gpib drivers have moved out of staging/ the build
> rule for the gpib drivers in staging is no longer required.
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/staging/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index e681e403509c..f5b8876aa536 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -13,4 +13,3 @@ obj-$(CONFIG_MOST)		+= most/
>  obj-$(CONFIG_GREYBUS)		+= greybus/
>  obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
>  obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
> -obj-$(CONFIG_GPIB)	 	+= gpib/

Just fold this into whatever patch is removing the last gpib staging
bits.

Johan

