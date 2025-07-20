Return-Path: <linux-kernel+bounces-738145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D1B0B500
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BFC17B930
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A31F3D56;
	Sun, 20 Jul 2025 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2f6QC3O0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAA17A31C;
	Sun, 20 Jul 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008560; cv=none; b=jsqdtks8Iqam4YCO1k+lQCcIo86/xtXL+aQJcf3kzZRT/PUF6W4Bb2h1qewmQO+jvtU0+0FFyrzAPhXDxIoS28rgGWyf1reIRMCKbRH9KzHOv9oPj+PGAdmI5EOYdelAzACiJ0WuCyr7HWfWmUyZrv6gqaTnvg9dP9+Phrt2Vj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008560; c=relaxed/simple;
	bh=oWfQ0t8g6pwFrGDutGDrgyICU6WkEo5kSzmlGkscpOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f20zuZgw1sxE/DOLw5ym0PWqbwj5eKWLaZ3WBcfROTtn9gN7E5rvgToQUrVSYIIISrbVzEindmhw65WanrfRd/uvugAiekd/9uD19k9No9Didqn/VSKtES7TvDRwvFrdJWRcfGk6qrGZpKa7QqS1RxFBDDhsDVjqyXzMX/ta2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2f6QC3O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5270CC4CEE7;
	Sun, 20 Jul 2025 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753008559;
	bh=oWfQ0t8g6pwFrGDutGDrgyICU6WkEo5kSzmlGkscpOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2f6QC3O08VsJkgpOzjqIaxwmfNX3blvMtkfs1V8G7/lzY+jMTIeThgRCQ0Eeiuip8
	 M9c/N3QLN3DQb9dsBS87/EM11DCL1mFzyA1ia0q2DlQVkOGsANYjeOSP8eBRJs98mP
	 5bZSrpAjaWYcMLG8Lqa/Hq8fVKZvRIEsi3HvaODM=
Date: Sun, 20 Jul 2025 12:49:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 6.16-rc6
Message-ID: <2025072005-ditzy-magnesium-5cdb@gregkh>
References: <aHzI4aFr-UNU6dZX@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHzI4aFr-UNU6dZX@kroah.com>

On Sun, Jul 20, 2025 at 12:45:53PM +0200, Greg KH wrote:
> The following changes since commit 3c2bd251d2039ce2778c35ced5ef47b3a379f5df:
> 
>   Merge tag 'usb-6.16-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2025-07-04 09:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.16-rc6
> 
> for you to fetch changes up to 2521106fc732b0b75fd3555c689b1ed1d29d273c:
> 
>   usb: hub: Don't try to recover devices lost during warm reset. (2025-07-16 09:48:11 +0200)
> 
> ----------------------------------------------------------------
> USB / Thunderbolt fixes for 6.16-rc6

Wow, I'm off by a -rc number, -rc6 was last week, all of these pull
requests are for -rc7, sorry about that.

Time for more coffee...

greg k-h

