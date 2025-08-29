Return-Path: <linux-kernel+bounces-792152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71BAB3C0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7825620FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C473277B4;
	Fri, 29 Aug 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fDvC81Ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794261917ED;
	Fri, 29 Aug 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485205; cv=none; b=Wh4zriOpSju2GBBVr5XgUWdO9pZFhYYerL/Loz7PibyJ7JkifTTy/O146XkrI6fCClxE1MEtMjijVLIe8h9LXhwAW+dkzsG2HMe7qayrStT34L3t/r4W5OjqA88T5UT+RWFuNBZCoUDZdGWYP4SIZWJ0AXSw33EI/csQPTHdlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485205; c=relaxed/simple;
	bh=jgKCSrHUv6K524VE1l0gFO14QqQhak8oamgEm7Ome3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4TBnTysFkSb0utOEBubz/WzIwzz5tyo28l506rg7jvwsnSCDIVBRO2P7037aCWxkiHlojIQ4l0i/ysq/EnnletuAWp9AdVXiUQ4OjARQLKQlfOACSu4Ov1FqQE7NiIkOiU7wKUk7tPSA7qX6r+neOPClVe70+MS5mjklkh8CTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fDvC81Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94756C4CEF0;
	Fri, 29 Aug 2025 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756485205;
	bh=jgKCSrHUv6K524VE1l0gFO14QqQhak8oamgEm7Ome3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDvC81EdV68n1C2rjUnPP0FGw7Ro+eO2SKfgVaNU53F46YJnPfz0uHojZ+hM+b912
	 e5UuCgDEslujPigKXynTswZGejWJnsPnogn5b0CztVhjZEiU32X5SVpODA01DxqLRB
	 PRJO47xgWBLI1QdBK6gSSadZmivfOJMw86AuxagM=
Date: Fri, 29 Aug 2025 18:33:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] USB/IP VHCI suspend fix and driver cleanup
Message-ID: <2025082941-frenzied-chaos-890c@gregkh>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
 <2025072637-corny-careless-8523@gregkh>
 <3dd94c4f-0971-4744-91e1-3a5474e1576c@collabora.com>
 <5b39ce10-9845-4429-95bb-18b03513cdaf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b39ce10-9845-4429-95bb-18b03513cdaf@collabora.com>

On Wed, Aug 27, 2025 at 12:14:15PM +0300, Cristian Ciocaltea wrote:
> On 7/28/25 12:41 PM, Cristian Ciocaltea wrote:
> > Hi Greg,
> > 
> > On 7/26/25 9:43 AM, Greg Kroah-Hartman wrote:
> >> On Sat, Jul 26, 2025 at 01:08:02AM +0300, Cristian Ciocaltea wrote:
> >>> The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
> >>> prevent entering system suspend when at least one remote device is
> >>> attached to the virtual USB root hub.
> >>>
> >>> However, in some cases, the detection logic for active USB/IP
> >>> connections doesn't seem to work reliably, e.g. when all devices
> >>> attached to the virtual hub have been already suspended.  This will
> >>> normally lead to a broken suspend state, with unrecoverable resume.
> >>>
> >>> The first patch of the series provides a workaround to ensure the
> >>> virtually attached devices do not enter suspend.  Note this is currently
> >>> limited to the client side (vhci_hcd) only, since the server side
> >>> (usbip_host) doesn't implement system suspend prevention.
> >>>
> >>> Additionally, during the investigation I noticed and fixed a bunch of
> >>> coding style issues, hence the subsequent patches contain all the
> >>> changes needed to make checkpatch happy for the entire driver.
> >>
> >> You are doing two major things here, fixing suspend, and cleaning up
> >> checkpatch issues.  Please make that two different patch sets as those
> >> are not logical things to put together at all.  Work on the suspend
> >> issue first, and after that is all done and working, then consider
> >> checkpatch cleanups, those are not that important overall :)
> > 
> > Yeah, the cleanup part ended up larger than initially anticipated, but I
> > don't really expect further changes on the fixup side.  I can handle the
> > split if another revision would be still required, or would you like me to
> > do this regardless?  I've just made a quick test moving the first patch to
> > the end of the series and it didn't cause any conflicts, hence there won't 
> > be any dependencies between the two patch sets.
> 
> This continues to apply cleanly on recent linux-next, hence I'm not sure if
> there's still a need to resend as two separate patch sets.

As I no longer have any of these in my review queue, yes, you are going
to have to resend whatever you want us to accept :)

thanks,

greg k-h

