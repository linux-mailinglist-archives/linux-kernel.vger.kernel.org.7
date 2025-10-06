Return-Path: <linux-kernel+bounces-842769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDBBBD851
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C2B3B9E28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2042116E7;
	Mon,  6 Oct 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OI4fnkCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9920E029
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744442; cv=none; b=NcwutPL8DApjwkUw1KCZphU9vP42Lsai1/c/cpfE+RNXzWp8s1yrBktFEaNYsZ+9rwvksOPaLaYelJr7JaR/ffrsJpQd3zZ42kaYh3cS8GNG8nSQ5soYsKOpitq5bKTmkB0beEXz3ShImdrFFRLFDGJx4qJq56bsMfloBFOkowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744442; c=relaxed/simple;
	bh=mNEWSXxj2zHBwUiwtyBz49JKGFOAt9cDd66jiisBbwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXTZGvpAB3yISIVHtmGykFc5Kx2zAUcda/VwCQhHONGbSvZXz/8aSLQsdVbtblmnOaETSt/kOFb+HASYG21y4b1/mWSocXeEaUxPzAH+RXh1iN0Zqy0WL54eX1Ieav2QUhcIPXsvT7057gbOIlOpkMDlNQ9HCc1xXXmgK6fjQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OI4fnkCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64958C4CEF5;
	Mon,  6 Oct 2025 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744441;
	bh=mNEWSXxj2zHBwUiwtyBz49JKGFOAt9cDd66jiisBbwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OI4fnkCW+YXaIBwuEBjG2UnPHHqgGB6OuczCAItcjjz9364vJDe6dEXkZ2JhnmFV+
	 Dok6QGxhxZ+zJXOth1cT60St8aOEbljwH7PNG7ZqzZbhwRn08JEL4sanY/q706vqFA
	 tC18U9T9rJEweb+o1aVCM/1bemjgnMQy+ktUa2GQ=
Date: Mon, 6 Oct 2025 11:53:59 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in
 add_tuning_control
Message-ID: <2025100643-tarot-gender-4430@gregkh>
References: <2025091142-CVE-2025-39751-c340@gregkh>
 <f24f4524894417954b9de4ccec69c2e17aae3d5f.camel@oracle.com>
 <2025100646-strategy-spindle-ae8a@gregkh>
 <b12d18b040c39eb361c0f5aabf290236e3d0da66.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12d18b040c39eb361c0f5aabf290236e3d0da66.camel@oracle.com>

On Mon, Oct 06, 2025 at 09:19:42AM +0000, Siddh Raman Pant wrote:
> On Mon, Oct 06 2025 at 13:44:23 +0530, gregkh@linuxfoundation.org
> wrote:
> > On Mon, Oct 06, 2025 at 07:07:00AM +0000, Siddh Raman Pant wrote:
> > > On Thu, 11 Sep 2025 18:52:52 +0200, Greg Kroah-Hartman wrote:
> > > > ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
> > > > 
> > > > The 'sprintf' call in 'add_tuning_control' may exceed the 44-byte
> > > > buffer if either string argument is too long. This triggers a compiler
> > > > warning.
> > > > Replaced 'sprintf' with 'snprintf' to limit string lengths to prevent
> > > > overflow.
> > > > 
> > > > The Linux kernel CVE team has assigned CVE-2025-39751 to this issue.
> > > 
> > > While the change is good for defensive reasons, there isn't actually
> > > any buffer overflow as it is to "fix".
> > > 
> > > The largest string possible is "Wedge Angle Playback Volume", whose
> > > length is less than 44.
> > 
> > Thanks for the info.  What was the compiler warning about then if it
> > could detect just how big the string would always be as these are static
> > values?
> 
> Probably a false positive.
> 
> GCC docs does say:
> 
> 	-Wformat-overflow
> 	-Wformat-overflow=level
> 
> 	    Warn about calls to formatted input/output functions such 
> 	    as sprintf and vsprintf that might overflow the
> destination
> 	    buffer. When the exact number of bytes written by a format
> 	    directive cannot be determined at compile-time it is
> 	    estimated based on heuristics that depend on the level
> 	    argument and on optimization. While enabling optimization 
> 	    will in most cases improve the accuracy of the warning, it
> 	    may also result in false positives.

I can't seem to duplicate this warning on a newer version of gcc than
the original test used:
	https://lore.kernel.org/oe-kbuild-all/202506100642.95jpuMY1-lkp@intel.com/

But that value of "767" is very specific, which feels odd to me.

> > Should this CVE be rejected?
> 
> Yes.

Ok, will do, but this still seems odd, you should patch your kernel just
to be safe :)

thanks,

greg k-h

