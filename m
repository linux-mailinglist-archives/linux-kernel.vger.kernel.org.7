Return-Path: <linux-kernel+bounces-693748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2BAE0306
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C05D1767A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7812264BF;
	Thu, 19 Jun 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2I9HYtg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2A220689;
	Thu, 19 Jun 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330916; cv=none; b=TReOixv5LJDOXVsFqBhC120xgEA5fvC0LbEbqwJuennv2WgYB1uDtrLd2J1DPeA3LtPX9uAUu9oOzfLyUJy/UhNparnYTPDjfBwtVnFxi/gf+o1N3lZ4ghTRsAw9XFoSZc5diM6fVrb0Br5hKMTZvwy1g/TrRy7Z18FY4ApuYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330916; c=relaxed/simple;
	bh=G4PuVtw9eL98kAfTasPeLhLnGyKu5ZonvAj3cQMPhBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0T38K4TgrCme2zrYy6/ebctNz8/xqm5XQteEeK3Nwo8RZvZX5rn3e+qxTjz04wW+xtUK1nxLTu2g/VYASFZ9sCPGcs3l+tOV18nBbpvW7TNOW7a65oqEh7eAearMomZPsqIuFBN58krOAV/eZXJSwZU7d+f8VUNq/jwoaQYUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2I9HYtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D60C4CEEF;
	Thu, 19 Jun 2025 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750330915;
	bh=G4PuVtw9eL98kAfTasPeLhLnGyKu5ZonvAj3cQMPhBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2I9HYtglYnIx2N/AKoJOTUlVNF8JntyC6tR0IIzbI+Fm3tCEjsMEpmZZlv7OTkpK
	 AbXkhHEsMCH39xMf3J7agHIBF6axLV0iR5BcTEcMjYxnxct9Z8cjqhPhkjqNQZ2Uve
	 oyw5j8Qr8vBp/4FFtEJB1kzBugA9aKsccsczCW60=
Date: Thu, 19 Jun 2025 13:01:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	zhouzongmin@kylinos.cn
Subject: Re: [PATCH v2] usbip: convert to use faux_device
Message-ID: <2025061926-paycheck-footnote-a2b8@gregkh>
References: <2a327b520760271471717fff9b222cdc34967489.1746662386.git.zhouzongmin@kylinos.cn>
 <20250604065410.76069-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604065410.76069-1-min_halo@163.com>

On Wed, Jun 04, 2025 at 02:54:10PM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> The vhci driver does not need to create a platform device,
> it only did so because it was simple to do that in order to
> get a place in sysfs to hang some device-specific attributes.
> Now the faux device interface is more appropriate,change it
> over to use the faux bus instead.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
> Changes in v2:
> - don't change faux create api,just call probe on vhci_hcd_init.
> 
>  drivers/usb/usbip/vhci.h             |  4 +-
>  drivers/usb/usbip/vhci_hcd.c         | 86 +++++++++++-----------------
>  drivers/usb/usbip/vhci_sysfs.c       | 68 +++++++++++-----------
>  tools/usb/usbip/libsrc/vhci_driver.h |  2 +-
>  4 files changed, 72 insertions(+), 88 deletions(-)

I get the following build errors from this patch:

drivers/usb/usbip/vhci_hcd.c:1462:12: error: ‘vhci_hcd_resume’ defined but not used [-Werror=unused-function]
 1462 | static int vhci_hcd_resume(struct faux_device *fdev)
      |            ^~~~~~~~~~~~~~~
drivers/usb/usbip/vhci_hcd.c:1418:12: error: ‘vhci_hcd_suspend’ defined but not used [-Werror=unused-function]
 1418 | static int vhci_hcd_suspend(struct faux_device *fdev, pm_message_t state)
      |            ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Are you sure you tested this?

thanks,

greg k-h

