Return-Path: <linux-kernel+bounces-893005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E6C46519
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7ACC4EB229
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F5309F00;
	Mon, 10 Nov 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPRxS6hL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647653093D8;
	Mon, 10 Nov 2025 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774663; cv=none; b=NQ56jV9qFXCar945pN2k1oi0uZYUHj8eRZ/Jeq+5dpSuRzOlI5j1KXwSNJdnTlZWmj2qJtkwWTlIJaGKy49aQZ3ciN9W5x3bABZP+ojrpqP/EjeHwC9kHKA8YZYhzOC7asi6VdRDHuZsRPygMPkWrGPck4RI1er/KVJ3tXF8dUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774663; c=relaxed/simple;
	bh=wTOljCtRVk0XF6JloAuO1RDSpFR6RFzVu+QrUSpgZzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NplI8T6csC85oR2vE/HqgNxWOjdF193C9I3UMppFETBEjOGImWtXxmyWRbKmViElp1bt8zPrxx8yj+Iw6SMVXHoZfn7bfneaesEd5ek8GLLqWYsZSCDScr7AJsAS7UMXCYIaswm/Qpaho93JfDe59ddkDfjOgakdSiEGUmEksN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPRxS6hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEE7C19421;
	Mon, 10 Nov 2025 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762774663;
	bh=wTOljCtRVk0XF6JloAuO1RDSpFR6RFzVu+QrUSpgZzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPRxS6hLaxCg/K+x7Rp50PkC/QsN+PsBIYsABurANVgs8YWB1pEzQq6is1GFJO0Zk
	 bX7yDdIrPvTAIKlABlhTt24uYhGKdvlqGejSKA5yxEMGOmiV4Q5wGK823zYonDTrSa
	 mn+lRU7D9mR7QIrbtX/QrxPm8Fjjyc3zJlyDClq/HZzYu8Zh6b83HrjxKDjUCxXe2o
	 xH9r5bHS5hO/ttT2Wz03LeprM6kRLLZwrhjXqYYufbN4kL+qGa4s6VCbmNxymDdZzd
	 vRuj4gv4SaPxFMhpQzdTfsSZEdmELTLA1DQl/xsdPN6um76DY5xV91j+MfChhZCwrR
	 r1id/TWNsws+g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIQDO-000000001M6-325M;
	Mon, 10 Nov 2025 12:37:43 +0100
Date: Mon, 10 Nov 2025 12:37:42 +0100
From: Johan Hovold <johan@kernel.org>
To: Vanillan Wang <vanillanwang@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: option: add support for the Rolling
 RW101R-GL modules.
Message-ID: <aRHOhpBErPwzXRhG@hovoldconsulting.com>
References: <20251110042041.13873-1-vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110042041.13873-1-vanillanwang@163.com>

On Mon, Nov 10, 2025 at 12:20:41PM +0800, Vanillan Wang wrote:
> - VID:PID 33f8:0301, RW101R-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)

> - VID:PID 33f8:01a8, RW101R-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)

> - VID:PID 33f8:0302, RW101R-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)

> - VID:PID 33f8:01a9, RW101R-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)

> Signed-off-by: Vanillan Wang <vanillanwang@163.com>
> ---
> Changelog:
> v3:
> - Modify the commit summary.
> - Keep the entries sorted by VID/PID.

The entries you add below are still not sorted by PID.

I fixed it up this time when applying, but please try to maintain the
sort order in your future patches.

>  	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
>  	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0301, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a8, 0xff),			/* Rolling RW101R-GL (laptop MBIM) */
> +	  .driver_info = RSVD(4) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0302, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a9, 0xff),			/* Rolling RW101R-GL (laptop MBIM) */
> +	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */

Johan

