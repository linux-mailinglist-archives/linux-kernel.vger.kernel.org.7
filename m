Return-Path: <linux-kernel+bounces-852049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C19BD80A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AABA18A5C71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101930EF81;
	Tue, 14 Oct 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="heivPxpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D602BDC0B;
	Tue, 14 Oct 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428647; cv=none; b=rVc9glgEZ4cE6LJMaiwIY/r/fOzyFlWyzCuxMroe9Rbnvtk+US+R6AapUck61YMsKZEOGqqOztBx6EE/73CrIapotyYoKc8UrzUpa+1ACPyw7s1fXQVnQO0pkssaddFRoU5NT/hplb/VbdemmQfCZJvV4lAfCngPlIRhyxJHZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428647; c=relaxed/simple;
	bh=oZ/9m4wEpTISmrZAs2nItOaXU4KZEMVkakvOo1X8eJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt3gnd6GXA5sayyFdWTivg99xyupBEzDg7FB19cjabqTxTPEUAUnERoFchZFxSQhXAenl8eCaWqM99ikHu2bKmE/3jCC9lIIyyfMMMWI9QQky19hRucNkdAGYyIwMLwzJ0BwzN0PmK2z8T47C9zj2rFcHCL+JlgNX19wmPAi3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=heivPxpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9F2C4CEE7;
	Tue, 14 Oct 2025 07:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760428647;
	bh=oZ/9m4wEpTISmrZAs2nItOaXU4KZEMVkakvOo1X8eJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heivPxpUWm7Sujci8gcJdJCeNaCIQ9n469SA1M+JR/UCNh/Vgh8z1HchjQrUs5HDX
	 X9NtDIGeVD9HyW/SEJZI9/YyU6tXY9KKUkXsdZpCM4hHWMpNM4dYg42nxPPNH/vs58
	 eGlWckZxT9tI//bUh3OvZfj8G+/ag/HAB5kYm1KY=
Date: Tue, 14 Oct 2025 09:57:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: core: Add tracepoints for device allocation and
 state changes
Message-ID: <2025101446-starved-brownnose-e9ed@gregkh>
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
 <20251013-usbcore-tracing-v1-2-b885a3121b09@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-usbcore-tracing-v1-2-b885a3121b09@google.com>

On Mon, Oct 13, 2025 at 10:01:23AM +0800, Kuen-Han Tsai wrote:
> Introduce new tracepoints to the USB core to improve debuggability of
> USB device lifecycle events.
> 
> The following tracepoints are added:
> 
> - usb_alloc_dev: Triggered when a new USB device structure is allocated,
> providing insights into early device setup.
> - usb_set_device_state: Triggered when the USB device state changes,
> allowing observation of the device's state transitions.
> 
> These tracepoints capture detailed information about the USB device,
> including its name, speed, state, bus current value, and authorized
> flag. This will aid developers in diagnosing issues related to device
> enumeration within the USB subsystem.
> 
> Examples:
>  usb_alloc_dev: usb 1-1 speed 0 state 1 0mA [authorized]

If you are going to change the state to be a string, can you also change
the speed to be a string as well?  That will help out with people
wondering what is going on with the speed of the device a lot.

thanks,

greg k-h

