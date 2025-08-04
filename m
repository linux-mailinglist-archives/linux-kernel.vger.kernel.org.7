Return-Path: <linux-kernel+bounces-755511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FCB1A738
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B7C3BDBEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530B2853FD;
	Mon,  4 Aug 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYTuhLIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22513C8FF;
	Mon,  4 Aug 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325807; cv=none; b=aZdsOTsw4ykPOFXf0p5cUp08vb8n0BDZaKBDWoysyklA6kJD/mKHMkPmP4BFn5CKXBN9Z8DavLP3d2PyLllBBGHrUFH8JMCnyMHiGoLRu1ZFgxwluoyQKOHIKBWwIZyZUlow9l0be4/J7HnRZ7PYld9rmQSVmLSxz7jStCZbgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325807; c=relaxed/simple;
	bh=GBsD2ehHu6t6UZvGTGVxIzFuZQmwG1Fufu/2qr3VL/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSj7typaXw/wkwwB4qnwzBa4JU8oiDWoUiuKadqvUqXrzfNjHR3XzCoCW+1QcoVRYjY/nGw5LbfMe/7c/AH5BmxuqIgWkqXBc20V3aE4CMF9GmhhPbW4tiyhggBTPxs1UevCMB5CJZIhDvPT80UxMZx94L49UuR/WSoh9nfphLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYTuhLIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A487DC4CEE7;
	Mon,  4 Aug 2025 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754325807;
	bh=GBsD2ehHu6t6UZvGTGVxIzFuZQmwG1Fufu/2qr3VL/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYTuhLIh1rk3C6QMw3S2/A0qY1jXIPhk2sKH8+HTOllYkQtRugugaijZ9mDJrjSKG
	 RO+JHXTv5JGa+Umgc3CnMbPWCttgttWFNJUI5XKyCxafaADVm/dM+jv7gg8v08TQVN
	 vOho0gQsyyMmz7g5GCsSBmsUgDHP3OihmsbhUhuk=
Date: Mon, 4 Aug 2025 17:43:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: dwc3: Ignore late xferNotReady event to prevent
 halt timeout
Message-ID: <2025080456-grip-thwarting-2424@gregkh>
References: <20250804080809.1700691-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804080809.1700691-1-khtsai@google.com>

On Mon, Aug 04, 2025 at 04:08:05PM +0800, Kuen-Han Tsai wrote:
> During a device-initiated disconnect, an xferNotReady event for an ISOC
> IN endpoint can be received after the End Transfer command has already
> completed.
> 
> This late event incorrectly triggers a new Start Transfer, which
> prevents the controller from halting and results in a DSTS.DEVCTRLHLT
> bit polling timeout.
> 
> Ignore the late xferNotReady event if the controller is already in a
> disconnected state.
> 
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
> Tracing:
> 
> # Stop active transfers by sending End Transfer commands
>  android.hardwar-913     [004] d..1.  6172.855517: dwc3_gadget_ep_cmd: ep1out: cmd 'End Transfer' [20d08] params 00000000 00000000 00000000 --> status: Successful
>  android.hardwar-913     [004] dn.1.  6172.855734: dwc3_gadget_ep_cmd: ep1in: cmd 'End Transfer' [40d08] params 00000000 00000000 00000000 --> status: Successful
>  ...
> # Recieve an xferNotReady event on an ISOC IN endpoint
>     irq/991-dwc3-29741   [000] D..1.  6172.856166: dwc3_event: event (35d010c6): ep1in: Transfer Not Ready [000035d0] (Not Active)
>     irq/991-dwc3-29741   [000] D..1.  6172.856190: dwc3_gadget_ep_cmd: ep1in: cmd 'Start Transfer' [35d60406] params 00000000 ffffb620 00000000 --> status: Successful
>  android.hardwar-913     [004] dn.1.  6172.868130: dwc3_gadget_ep_cmd: ep2in: cmd 'End Transfer' [30d08] params 00000000 00000000 00000000 --> status: Timed Out
>  ...
> # Start polling DSTS.DEVCTRLHLT
>  android.hardwar-913     [000] .....  6172.869253: dwc3_gadget_run_stop: start polling DWC3_DSTS_DEVCTRLHLT
>  ...
> # HALT timeout and show the endpoint status for debugging
>  android.hardwar-913     [004] .....  6177.479946: dwc3_gadget_run_stop: finish polling DWC3_DSTS_DEVCTRLHLT, is_on=0, reg=0
>  android.hardwar-913     [004] .....  6177.479957: dwc3_gadget_ep_status: ep1out: mps 1024/2765 streams 16 burst 5 ring 64/56 flags E:swbp:>
>  android.hardwar-913     [004] .....  6177.479958: dwc3_gadget_ep_status: ep1in: mps 1024/1024 streams 16 burst 2 ring 21/64 flags E:swBp:<
>  android.hardwar-913     [004] .....  6177.479959: dwc3_gadget_ep_status: ep2out: mps 1024/2765 streams 16 burst 5 ring 56/48 flags e:swbp:>
> 
> ---
>  drivers/usb/dwc3/gadget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Why is this RFC?  What needs to happen to make it an actual submission
that you wish to have applied?

thanks,

greg k-h

