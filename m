Return-Path: <linux-kernel+bounces-743601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114EBB100B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B92D3A4E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29B4212D67;
	Thu, 24 Jul 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+9x8XVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253522747B;
	Thu, 24 Jul 2025 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339012; cv=none; b=DYe71ro37jmgmXmfoX7T7rVlq9mD3SJeabUpaibt3BRf0nafHdo/GihMi1RR3V7jJd9sNWrwAqVDWH/PzLHwLvhGENtrCSn7MMQXM9FABGDcQQnSYFy2FhBcWzZYMRoKhhT+P9AR4I4BBKWbBKK7kxgM0tjJWifvSYggTuyGZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339012; c=relaxed/simple;
	bh=M++MJT1ygfbfaSq/5tSlNeDY2uZt6rt+SgZd7m8OW/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXLEBm/9hnmVysOLwhuqVM5CFvtTMMsAE1+MdM88QarPE0WXPZrJ9ukiHyFm3cnp4DCn255JQO9ioBZRDIyWf4qZ5J96vJRCVzEFdueWu7Nvi4XxNtTrOnK4AdAOuOluB9M4aq0y2DfW6hfTc3DzR1B5uvWcttr5may3azhwx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+9x8XVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C03BC4CEED;
	Thu, 24 Jul 2025 06:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753339011;
	bh=M++MJT1ygfbfaSq/5tSlNeDY2uZt6rt+SgZd7m8OW/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+9x8XVzkuakpvSTEfwM7cdutbBmvG+wFLSoOLBlT35EYtzJSZlxwcaBlOItSovFJ
	 aEMRgHqnxYNpC1LgBfWlrj26dwfDK+3Ex4jMQFC1s/qbCy0Gw/ThwuQmDNx0guHqd2
	 SjTOscq6Au6XOxhqsJbyXwmF3mnWpod5nBywhtYI=
Date: Thu, 24 Jul 2025 08:36:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, WeitaoWang@zhaoxin.com,
	wwt8723@163.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] usb:xhci:Fix slot_id resource race conflict
Message-ID: <2025072425-sixtyfold-curling-88ff@gregkh>
References: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>

On Thu, Jul 24, 2025 at 08:40:12PM +0800, Weitao Wang wrote:
> @@ -4085,10 +4086,11 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  	for (i = 0; i < 31; i++)
>  		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
>  	virt_dev->udev = NULL;
> -	xhci_disable_slot(xhci, udev->slot_id);
> +	ret = xhci_disable_slot(xhci, udev->slot_id);
>  
>  	spin_lock_irqsave(&xhci->lock, flags);
> -	xhci_free_virt_device(xhci, udev->slot_id);
> +	if (ret)
> +		xhci_free_virt_device(xhci, udev->slot_id);
>  	spin_unlock_irqrestore(&xhci->lock, flags);

Shouldn't you lock/unlock only if ret is set?

thanks,

greg k-h

