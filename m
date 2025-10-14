Return-Path: <linux-kernel+bounces-852905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA23BDA31F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D63418A3999
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06692BD582;
	Tue, 14 Oct 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHTJ9c+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5A1547D2;
	Tue, 14 Oct 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454055; cv=none; b=C//GIWEPCHFsXtBcmeZv/N8x+/mDO+YcaWLKAZfN5r7OQBAY8A0AOw6bcr/fBRgHhWp3pcKMboDXvgAhFkuNhBNHvyRQyRtPwVa/vPAWbXBbjq0Fl4wfHxVBdjXsvzDr7FZR7URhiWGss+heDrPdN+y4MdQl80B8iEWYrIM1Xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454055; c=relaxed/simple;
	bh=JiLVAZjuKxjAkdjB3EzNCIEKoAyAn3Z05PU7boK8ZS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR2HrIUhakg2w66AZLJvEiANQ2voAOAy4mGRIBQP8nXbthauyUQTTRDHZhadaEG/HbaKuY4fVI+E30t1njWxONC2WI6yeOo88GSzpBDD1StbuLt996isaO7L7eQQt5V82z6jtqicFYd3LSMzLV+uX6Ql1Jht4U3xp27UU2Iex5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHTJ9c+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DAAC4CEE7;
	Tue, 14 Oct 2025 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760454054;
	bh=JiLVAZjuKxjAkdjB3EzNCIEKoAyAn3Z05PU7boK8ZS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHTJ9c+LIhXAJTPpT62tkeZn/DzI3XvVdkpvP7Mt/ht6zMje3oqlGecJnOIjfG1YX
	 uV3i1888wT7zL1tRPiFTIXKoU0Hsh5Qyt5nEj/z91z0uo6R4pamrnKy5DqHTnuc0gb
	 2xC2RtdXLHo+axFKYa6N0+1Q5SOAZJGEKPiKASxM28fy4ZpjMIAXjGKXzfe0h99sUb
	 W9IzyMA61emcZHQqCpVWVROIJGkACyyd8GRiWQayqXYgN4APNV9o8tfMBzSc+xPKyG
	 OJIyu96Y6NDbUuXTjFIXNTdq+3rHUe/Jl638bs5PV2ZdEpN0mU+1nK35g08JzxL7tu
	 Q+0h61myMcSWg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8gWD-000000004Oc-23Qv;
	Tue, 14 Oct 2025 17:00:54 +0200
Date: Tue, 14 Oct 2025 17:00:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Vanillan Wang <vanillanwang@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Update the USB option driver for the Rolling
 RW101R-GL modules.
Message-ID: <aO5lpfmgGPGnbnvW@hovoldconsulting.com>
References: <20250928092823.31658-1-vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928092823.31658-1-vanillanwang@163.com>

On Sun, Sep 28, 2025 at 05:28:23PM +0800, Vanillan Wang wrote:
> - VID:PID 33f8:0301, RW101R-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)

> Signed-off-by: Vanillan Wang <vanillanwang@163.com>
> ---

Thanks for the update, looks mostly good, but please use a succinct
commit summary (Subject) with the common prefix ("USB: serial: option:
add ...").

Also remember to include a short changelog here under the --- line when
respinning.

>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index fc869b7f803f..98571e6b30da 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2417,6 +2417,12 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(5) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
>  	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0301, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0302, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a8, 0xff),			/* Rolling RW101R-GL (laptop MBIM) */
> +	  .driver_info = RSVD(4) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a9, 0xff),			/* Rolling RW101R-GL (laptop MBIM) */
> +	  .driver_info = RSVD(4) },

And try to keep the entries sorted by VID/PID.

>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },

Johan

