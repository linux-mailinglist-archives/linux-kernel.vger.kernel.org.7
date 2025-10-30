Return-Path: <linux-kernel+bounces-878545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D9C20F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E1114E8E10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D13644B0;
	Thu, 30 Oct 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="odw0elaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2C238C0F;
	Thu, 30 Oct 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838465; cv=none; b=Thce54Xf05OLtOlCzMCXPr1S557Nikdt9VGnuyRVVSfVDANlJcdMWC48R4Z8FeROZrCiwL7mVX+exkrscDmW1ziK2P/MZDd6zY4kIoitEQzTjNM8zx7YQapJf6xqnZN8vg13XLxkxk+EvvMO/SY11x4rvKiWF1nM0rdyWA2T6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838465; c=relaxed/simple;
	bh=kgsVePG1TDxPoCEnHRNZviyXsOn86/lu7qyI5hHRx8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJkDTx+GJar5bMYfV9v4wMxJQY1WQ/YXWtEe8xc4HlNUHuozrBMnJaWSEM83DBq6h5wQTq0MgDFBoQzHPazINVD6WyrmELRv7RUrssmUD79XHR8V+Fx9zNi0iiBZeHpgFebwZwJFyCj6D2jguB8ZwP3UiXZ3+onYGnEyotBQ/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=odw0elaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B1CC4CEF1;
	Thu, 30 Oct 2025 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761838465;
	bh=kgsVePG1TDxPoCEnHRNZviyXsOn86/lu7qyI5hHRx8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odw0elaPMR4clHhHnr4spCjpZ4KKvaMHxn+ZIlx9e8emLqD5aBZtvy8sGkVkt+DNP
	 ZkiqdlIdt0UUIqbfdeIX6e4c6epE+35BLoZiRa0lCySqTKqxrt/2haytT+t4xHqYNa
	 foOclgJ6upZB1mJmJ2T/SqWdkLhcryjiDGtKJqko=
Date: Thu, 30 Oct 2025 16:34:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: f_loopback: Use auto-cleanup for
 usb_request
Message-ID: <2025103059-suitable-mulberry-45e0@gregkh>
References: <20251030-auto-cleanup-v1-0-db30584fadfd@google.com>
 <20251030-auto-cleanup-v1-2-db30584fadfd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-auto-cleanup-v1-2-db30584fadfd@google.com>

On Thu, Oct 30, 2025 at 11:14:20PM +0800, Kuen-Han Tsai wrote:
> Refactor f_loopback.c to use auto-cleanup mechanism for usb_request
> allocations in alloc_requests().
> 
> The shared buffer between in_req and out_req is handled by nullifying
> in_req->buf before returning on usb_ep_queue failure, ensuring the
> buffer is only freed once by the out_req cleanup.

Same here, it's tricky stuff, and you are only saving 4 lines of code?

Not really worth it I would think.

thanks,

greg k-h

