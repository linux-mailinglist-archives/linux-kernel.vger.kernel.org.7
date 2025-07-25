Return-Path: <linux-kernel+bounces-745270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53BB11783
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30765658FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C6C23F429;
	Fri, 25 Jul 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0WlskxWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5A3594E;
	Fri, 25 Jul 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418641; cv=none; b=VWb55FCUv41rgpFri7lCrvyBU2ZtFFDOYcI0sPHoVgOXrNCEBphsCTgKttnX6WMJ98v1SQJA3ksE5rjgn0mJPNAI/qDDJRABTfPWwH3sXfWlT4+QrUcea73W9B/4BMko+ozb/QWPMQCxzwuNY7WAHO1/uVztg8RokQfdrJ3tCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418641; c=relaxed/simple;
	bh=+AylLebw4hX9XXAsTOwIIKEOdKO1HxWGdQXbi5btDA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRl6QlQCcvPGLlGORbxLhewC+2aQPs0ncFxb9zFoTAPAFl4QnzKQkxjE6PFZ4rWGFukMIWpPVDDH4n9QS0drriJFSstdsBM0Gc1sHSfFrBcGCrTbun5iJbLYBB9VLoBmDAaWj0h0Tb2JdfMsd2/gbWjo8ylnD+7Q3NiUZ6o8NYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0WlskxWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A52C4CEE7;
	Fri, 25 Jul 2025 04:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753418640;
	bh=+AylLebw4hX9XXAsTOwIIKEOdKO1HxWGdQXbi5btDA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0WlskxWt3WfOESd++SMsVHmxiQ0XKNykhvcja/PF6OHyem8wFZripvv9qn5NCvBAl
	 8S/SwxjPGFv/IISSdpmqpOkXonz9XQ8fy+bSSexzPt/5Dn7utdzbGdqKo6VrgXAqZ8
	 1Awyn/u8fo4C0WtzKz93FM5i+0nTaSVXMyp3jGJ0=
Date: Fri, 25 Jul 2025 06:43:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Su Hui <suhui@nfschina.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: print xhci->xhc_state when queue_command
 failed
Message-ID: <2025072530-stimulate-gush-6820@gregkh>
References: <20250725031308.1355371-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725031308.1355371-1-suhui@nfschina.com>

On Fri, Jul 25, 2025 at 11:13:09AM +0800, Su Hui wrote:
> When encounters some errors like these:
> xhci_hcd 0000:4a:00.2: xHCI dying or halted, can't queue_command
> xhci_hcd 0000:4a:00.2: FIXME: allocate a command ring segment
> usb usb5-port6: couldn't allocate usb_device
> 
> It's hard to know whether xhc_state is dying or halted. So it's better
> to print xhc_state's value which can help locate the resaon of the bug.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/usb/host/xhci-ring.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 94c9c9271658..a1a628e849c0 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -4372,7 +4372,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
>  
>  	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
>  		(xhci->xhc_state & XHCI_STATE_HALTED)) {
> -		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
> +		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: %u\n",
> +			 xhci->xhc_state);

Don't you want to see this value in hex?

thanks,

greg k-h

