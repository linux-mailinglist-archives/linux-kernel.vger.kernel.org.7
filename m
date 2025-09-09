Return-Path: <linux-kernel+bounces-807223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963FAB4A1C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750674E79EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA62FF65B;
	Tue,  9 Sep 2025 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDX+y5LW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388C259CB9;
	Tue,  9 Sep 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397843; cv=none; b=oXkGH1ORiRYxuMHXUltd4D8M4i3EuE+sqA+uJvyaedDotjQv7JhAUBTmsTPcNvWbnLYC26/d/tV6+m9CbnG/PvMN+bJRD53SK2EJBdOWRc/v9Ep1coX8XmJ/EMkj8SsCITQH3ORkegaSXLAtBUZTHS6IOKn+2agWQaUlvDzpl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397843; c=relaxed/simple;
	bh=vxPgH8dME8jIAcqVK3SPdIPD0VaJknxbQyeDreJox24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1Sq4ZDouwg+tW3xmwUbRyhr18RZkrKirBsCmI7AVNejVRBWYpJ5lBkVZ9g37/lwZCzqRVOr/rSUxYDT/6e3F92lCbbGw3LP3JpGFwyl/J+I8f4ougpqUGhwJzUSfBp27NCITj3aLnj5Dsmto9GRBGhMSaueyessskXEHsYcT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDX+y5LW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF75C4CEF5;
	Tue,  9 Sep 2025 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757397841;
	bh=vxPgH8dME8jIAcqVK3SPdIPD0VaJknxbQyeDreJox24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDX+y5LWX+tl2/WnFJFGub6gpMCG1s0yZrvqJE5nixbLDjYWRkzTq+4W0acOTa6U4
	 mP6/kA9i0Ou/lOcBI7VBIb1G7nrWUeE3QsqPpOiSSwhfEHPW6oJTOM+oqy4rMRVt09
	 1ENz4jb76ph0/dJI1yoVrbrEruhenFdA5LDMH2eI=
Date: Tue, 9 Sep 2025 08:03:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Forest Crossman <cyrozap@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] usb: mon: Increase BUFF_MAX to support modern higher-speed
 devices
Message-ID: <2025090921-oxidizing-legend-16ea@gregkh>
References: <CAO3ALPzdUkmMr0YMrODLeDSLZqNCkWcAP8NumuPHLjNJ8wC1kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3ALPzdUkmMr0YMrODLeDSLZqNCkWcAP8NumuPHLjNJ8wC1kQ@mail.gmail.com>

On Mon, Sep 08, 2025 at 11:50:00PM -0500, Forest Crossman wrote:
> Hello,
> 
> The usbmon binary interface currently truncates captures for large
> transfers from higher-speed USB devices. This is caused by the
> BUFF_MAX limit in drivers/usb/mon/mon_bin.c, which has not been
> updated since the usbmon binary interface was first introduced in
> 2006. A single event capture is limited to one-fifth of the total
> buffer size, capping URB captures at 240 KiB each.
> 
> I discovered this limitation while developing a Wireshark protocol
> dissector [1], where truncated captures made it impossible for the
> dissector to defragment and reassemble the protocol packets (an
> example of this truncation can be seen in frame 1580 of this capture
> file [2]). Others in the community have also encountered this hard
> limit when working with modern devices that use transfers of several
> hundred kilobytes or more [3].
> 
> The original comment for BUFF_MAX based its calculation on a saturated
> 480 Mbit/s bus. Applying the same logic to a USB 3.2 Gen 2×2 20 Gbit/s
> bus (~2500 MB/s over a 20ms window) indicates a required buffer size
> of at least 50 MB.
> 
> I propose increasing BUFF_MAX to 64 MiB. Making this change would
> enable usbmon to better support capturing the USB traffic of modern
> higher-speed devices, enabling users and developers to debug and
> reverse engineer their USB devices while running unmodified distro
> kernels. This change would not affect the default buffer size, as a
> larger buffer is only allocated when explicitly requested via the
> MON_IOCT_RING_SIZE ioctl.
> 
> This proposal follows the same rationale as the original calculation,
> but with updates for modern hardware.
> 
> I would appreciate any feedback on this approach before I prepare a patch.

I would suggest trying it out and seeing if it will work properly.  CPU
speeds are faster now, so a larger buffer will probably be just fine,
but I think the original goal here was that the majority of the "real"
information was in the beginning of the urb (protocol stuff, not
data), so the end of the urb wasn't all that necessary to see if the
buffer was too big.  And, as you point out, 480 Mbit was the speeds
then, we didn't think that USB would ever be boosted to go this fast :)

thanks,

greg k-h

