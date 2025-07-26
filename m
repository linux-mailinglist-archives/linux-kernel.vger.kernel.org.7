Return-Path: <linux-kernel+bounces-746640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F89B12943
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6851C826F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493A207A18;
	Sat, 26 Jul 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ds2lYKMM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE3184E;
	Sat, 26 Jul 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753512200; cv=none; b=PXocz/Gy1aU6tjTLetqNE0GN+O1NHXmrx+ZsYGg6wpq8tlhgPBgDgoZU5f/Fo8BAudFE22C81f9O5pH47/Sqvi3GXyHt9PcukmHJ3HGZnwbpa/SZKOpi5zN+DZUi9EHx7dvhTAmBHo9j7sfbYlvm5aAcg9YnrHUpilmQ4SJSrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753512200; c=relaxed/simple;
	bh=3sMAVGLrptoKObKgXkaOBeVptyNkPArrNkwOO3zLKFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzY0jnvJv6sE2by5r1oImY7uhK5KV9oOOel4O7FN8FBJkgaOzTSKDy1VghpomNSec8icOA0Tl0t8uR41J0n35TMstW3jWNODgfCig+pI6ScsxvPf4buKt5GprUb/BYNfJFDb6BqmhhfR0TYZ8h8TT81GDpRJ3rKYFISUa3PTbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ds2lYKMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7275C4CEED;
	Sat, 26 Jul 2025 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753512199;
	bh=3sMAVGLrptoKObKgXkaOBeVptyNkPArrNkwOO3zLKFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ds2lYKMMo4jlA1VmH2P2RugyknUME2VCaX7+UICoWB+N32hGs+aR5+9nolESnBCBD
	 nqH87L/tgYY8mWsRgfMsTM/jv5HxXI6UPtiuvoA6FrJgs4FHkqe8FxT/LmZc7mh9S/
	 qyPJCq2xZr5Pv0CWZ84ypYmRJmCf0QQ8F9EUo4vY=
Date: Sat, 26 Jul 2025 08:43:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] USB/IP VHCI suspend fix and driver cleanup
Message-ID: <2025072637-corny-careless-8523@gregkh>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>

On Sat, Jul 26, 2025 at 01:08:02AM +0300, Cristian Ciocaltea wrote:
> The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
> prevent entering system suspend when at least one remote device is
> attached to the virtual USB root hub.
> 
> However, in some cases, the detection logic for active USB/IP
> connections doesn't seem to work reliably, e.g. when all devices
> attached to the virtual hub have been already suspended.  This will
> normally lead to a broken suspend state, with unrecoverable resume.
> 
> The first patch of the series provides a workaround to ensure the
> virtually attached devices do not enter suspend.  Note this is currently
> limited to the client side (vhci_hcd) only, since the server side
> (usbip_host) doesn't implement system suspend prevention.
> 
> Additionally, during the investigation I noticed and fixed a bunch of
> coding style issues, hence the subsequent patches contain all the
> changes needed to make checkpatch happy for the entire driver.

You are doing two major things here, fixing suspend, and cleaning up
checkpatch issues.  Please make that two different patch sets as those
are not logical things to put together at all.  Work on the suspend
issue first, and after that is all done and working, then consider
checkpatch cleanups, those are not that important overall :)

thanks,

greg k-h

