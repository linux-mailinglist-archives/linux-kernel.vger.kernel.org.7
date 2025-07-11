Return-Path: <linux-kernel+bounces-727446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A99B01A51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155F57BB534
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05271288CB4;
	Fri, 11 Jul 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhGJlgEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFD23BCE4;
	Fri, 11 Jul 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232135; cv=none; b=TGmEdTiOTo55Zx+G4/dxWWRUa+Tk6Dwbbi763qJg5lSXsyM0wwq+mH3jeRVbygzKiRfAObfHzGkCzDdZQmO2hhRgb2fOABKcgtJjwQIkGLD2ghOU54JbMEVIe/dRrGlMQJJtKYbQMYkSdf6nnhEdlI6pOlnqZyqIVFUzNCvnwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232135; c=relaxed/simple;
	bh=TDN+T+hglSgNZf2pGI4s9wBC2hO6w1KpI4bWHUFubig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u04Arqo5yqWTOsiq+FHi8EIRMIk7u3IeYdQksSiU3N25vqjgTNp0qtBfhkuubtYI5sJrQ9z2bjuaeWK61QJc5P33O+muVEERCVeSlEiFDydrqZzSwaTNiUvRE5VlLq5UlfpUNrooj3PBB1oiqR9MNFWOtRf3yrrVdcAHd5dMy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhGJlgEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59682C4CEED;
	Fri, 11 Jul 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752232134;
	bh=TDN+T+hglSgNZf2pGI4s9wBC2hO6w1KpI4bWHUFubig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhGJlgEnL2ZQIa5gszVZyRvUJaCtSJf02nt38+cPSUPu1bffckzgLMCsMkvw+vKsh
	 vBQLWqm4vS4rVldjmxhbf9iydvJFqb91pkrVb/++BkMCUa9y3EF49klnJdFC87nimQ
	 ElE4OPN2cIusgxcJ/fG9lH/ZjWsqkBEdLTV/Ozt4=
Date: Fri, 11 Jul 2025 13:08:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kannappan R <r.kannappan@intel.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pawel Laszczak <pawell@cadence.com>, Ma Ke <make_ruc2021@163.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Support for usb authentication
Message-ID: <2025071131-granular-twelve-ba5f@gregkh>
References: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>

On Fri, Jul 11, 2025 at 10:41:21AM +0200, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> We have been working on the implementation of the USB authentication
> protocol in the kernel.
> 
> You can find our work here https://github.com/ANSSI-FR/usb_authentication.
> 
> It is still work in progress but we would like to start discussions
> about the implementation design and its possible integration to the
> Linux kernel.
> 
> Best regards,
> 
> Nicolas and Luc
> 
> ---
> USB peripheral authentication
> =============================
> 
> USB peripherals are an important attack vector in personal computers and
> pose a risk to the cyber security of companies and organizations.
> 
> The USB foundation has published a standard to allow the authentication
> of USB peripherals ([1] and [2]). It defines a mechanism for the host to
> request credentials and issue an authentication challenge to USB-2 or
> USB-3 peripherals, either upon connection or later during the use of the
> peripheral.
> 
> We currently envision the following use cases for USB authentication:
> 
> - company networks where computers and peripherals can be privately
>   controlled and administered;
> - USB cleaning or decontamination stations;
> - individuals who want to prevent unauthorized device plug-in into their
>   machine.
> 
> The implementation of this feature will obviously necessitate efforts
> from both the kernel community and peripherals vendors. We believe that
> providing an implementation of the host side of the protocol in the
> Linux kernel will encourage constructors to include this feature in
> their devices. On the other hand, we are working on implementing
> reference code for embedded devices, notably for Zephyr OS.

What about Linux as a device (i.e. the USB gadget system?)

If we have support for that here, then we can test both sides at the
same time on the same machine, making all of this much easier to
validate it works.  Have you considered doing that work first instead of
doing it in zephyr in a totally different source tree where it makes it
very hard, if not impossible, for us to test this code ourselves?

thanks,

greg k-h

