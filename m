Return-Path: <linux-kernel+bounces-741920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290DB0EAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6131892516
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F326C393;
	Wed, 23 Jul 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmhwZQYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32026B766
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252164; cv=none; b=BwE0dv4QG6Ti6+eB9rIoXMMbtpUyVyOL0MQi9sGGpW42si55Y9PK8J6M0PRge/5pkKsCihN8OzQV/2+pp6e/iIv7HnY7OTeEtTqt/4Apr5xR7vqXWofn9+2PkGKU5PSCPCxE+hrEYbA3ep751wjuBNZghbeLxIzybWMNbUa7jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252164; c=relaxed/simple;
	bh=5gkq94doQ00SzuYxMJqkHDx78kXSpSVXgPHoOnd1P70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ68x+6Ra2MOb/sXEL0zl73d+ICBLLZpR19nfevBNi8KX+khkuGyKOK9xd2ZSJD5R41/gpeFitHb9zX8SuRKBXW0hMMSV+0GpIxVf0TfDtas8ROa6urJpa/tTUtn1Pt8hGnW/4M+hXdZ3aOlrScv2O0F1ctHHyU6a5lByMjWnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmhwZQYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF9C4CEE7;
	Wed, 23 Jul 2025 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753252164;
	bh=5gkq94doQ00SzuYxMJqkHDx78kXSpSVXgPHoOnd1P70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vmhwZQYdpJ1h5NIig+kYFOzJdsSgXR/yX7AMOsW86CZBfZtgfVQwxeWvjBlC72zOj
	 yUGfwYC/t1rEOwk2/ktdejDvpfoUGcX3jR8DNIiIreWSNYWwgj688R21PrPKuD2wnh
	 hykamoP5li0g3NJ3TFALwjsFg+bQx9GNsIV32VbQ=
Date: Wed, 23 Jul 2025 08:29:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -resend] misc: ti_fpc202: Switch to of_fwnode_handle()
Message-ID: <2025072358-limpness-yoga-df3f@gregkh>
References: <20250723053516.1796097-1-jirislaby@kernel.org>
 <aIB345FIxUqpWWio@shikoro>
 <d58715df-b767-44d0-9f26-50c3458df27a@kernel.org>
 <aIB-Fq9Wd1Eh-TZC@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIB-Fq9Wd1Eh-TZC@shikoro>

On Wed, Jul 23, 2025 at 08:15:50AM +0200, Wolfram Sang wrote:
> 
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Well, who is supposed to pick this up? I thought you.
> > 
> > But given you marked it as such -- Greg?
> 
> Technically, yes, Greg. I took the driver together with the I2C ATR
> feature because it was its first user. But other than that, it doesn't
> belong to the I2C realm. That being said, I can pick this patch to help
> removing the deprecated function if Greg doesn't pick it in the next
> days.

I can grab it later today, not a problem,

greg k-h

