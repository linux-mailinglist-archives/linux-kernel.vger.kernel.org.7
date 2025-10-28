Return-Path: <linux-kernel+bounces-873335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0243C13B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 540DB352AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354B2F39A6;
	Tue, 28 Oct 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eb7ykjuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40392D6608;
	Tue, 28 Oct 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642339; cv=none; b=TI/PqpwEhTw07tv1ejhUr6gbaQ+IGzRWXjXh9h6QzNKdgz94xlgYDC+OJ3iQatWAI7gd7JhFfr+IXp75e2RCD18UJ2V2auvTFdeddpxRgj3gE8tTYYtJ65I8lFqGdufNWO4t3bDJVEXcsCKG8T9CfdrKWRUD5rWwqrxnMmdnUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642339; c=relaxed/simple;
	bh=91347eR0jKMluBgIJxMyND7Cz2mdhKw2+DLCeZdMUsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A51qPmrE9cPVcvRtsmN5PoZ1GUT8UbleveCYj2j5ZrvaqTOq0eQNJY7pLlfzjySp8HtPtskQZUpOux2WwMmKm/BiwhG24as7l80dYneIw2T4ZZJtqDQ6wU4cJydeNAaZdPUSQHykpyzhVsoNn43lLM8amcNCmGX8DbtiE/0Akew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eb7ykjuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC88C4CEE7;
	Tue, 28 Oct 2025 09:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761642339;
	bh=91347eR0jKMluBgIJxMyND7Cz2mdhKw2+DLCeZdMUsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eb7ykjuhBw4L2qqc2T0kls5uQElWCTY8tUHXAPJ7tNAt1otMn4He2eEmpzgKKiVAL
	 VIF2MpKI7SuPKjH5P11OlAouYxLxTrRYtHLCIN4X6mBCA5BXCY4pugL9sTt9r4tgQX
	 gLxxxfg1sivQCWTbBHgLM1xN8fdcsSDUjcKtWDL4=
Date: Tue, 28 Oct 2025 09:46:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Manish Nagar <manish.nagar@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: Fix race condition between concurrent
 dwc3_remove_requests() call paths
Message-ID: <2025102850-existing-divorcee-3db3@gregkh>
References: <20251028080553.618304-1-manish.nagar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028080553.618304-1-manish.nagar@oss.qualcomm.com>

On Tue, Oct 28, 2025 at 01:35:53PM +0530, Manish Nagar wrote:
> This patch addresses a race condition caused by unsynchronized
> execution of multiple call paths invoking `dwc3_remove_requests()`,
> leading to premature freeing of USB requests and subsequent crashes.
> 
> Three distinct execution paths interact with `dwc3_remove_requests()`:
> Path 1:
> Triggered via `dwc3_gadget_reset_interrupt()` during USB reset
> handling. The call stack includes:
> - `dwc3_ep0_reset_state()`
> - `dwc3_ep0_stall_and_restart()`
> - `dwc3_ep0_out_start()`
> - `dwc3_remove_requests()`
> - `dwc3_gadget_del_and_unmap_request()`
> 
> Path 2:
> Also initiated from `dwc3_gadget_reset_interrupt()`, but through
> `dwc3_stop_active_transfers()`. The call stack includes:
> - `dwc3_stop_active_transfers()`
> - `dwc3_remove_requests()`
> - `dwc3_gadget_del_and_unmap_request()`
> 
> Path 3:
> Occurs independently during `adb root` execution, which triggers
> USB function unbind and bind operations. The sequence includes:
> - `gserial_disconnect()`
> - `usb_ep_disable()`
> - `dwc3_gadget_ep_disable()`
> - `dwc3_remove_requests()` with `-ESHUTDOWN` status
> 
> Path 3 operates asynchronously and lacks synchronization with Paths
> 1 and 2. When Path 3 completes, it disables endpoints and frees 'out'
> requests. If Paths 1 or 2 are still processing these requests,
> accessing freed memory leads to a crash due to use-after-free conditions.
> 
> To prevent this race condition, `usb_ep_disable()` should be made
> synchronous. Specifically:
> - Issue an `ENDXFER` command to stop the endpoint.
> - Ensure all pending USB requests are returned to the function driver
>   via `dwc3_gadget_giveback()` before freeing.
> 
> Since `gserial_disconnect` calls `usb_ep_disable()` first, modifying
> `ep_disable()` to invoke the `complete()` callback for gser USB
> requests ensures safe deallocation.
> 
> Additionally, the driver already includes the `dwc->ep0_in_setup`
> completion mechanism, which is triggered upon returning to the
> SETUP stage. This can be leveraged to coordinate and synchronize
> the cleanup process effectively.
> 
> Signed-off-by: Manish Nagar <manish.nagar@oss.qualcomm.com>
> ---
>  drivers/usb/dwc3/gadget.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

What commit id does this fix?

