Return-Path: <linux-kernel+bounces-723274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7095AFE52F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F6716C27A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F9288C1E;
	Wed,  9 Jul 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euS3oVCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612E27FD72;
	Wed,  9 Jul 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055621; cv=none; b=mHgP3996nGwwV2L3Z/la5OZPsMm+dcoFtPic8aNSq5GO4iPz0+9WLBOjUVrj3qEVVi7tpb8bqMyNPYsGGESSfJ4rrwG8Ac0QOBxEH5XmWGznoCdbStNRogf4IjkZbTlsHykAKWFYkTLuQLj/R6idpPxhz+VcKl25SsOPdG7v7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055621; c=relaxed/simple;
	bh=aj5GWlIdlYL9xg/nY5anso++f0e3szkPgL2qAgC7f1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueAWC57NRjfi8+UZ02nag+SXVxGbPcgM3Ihydc4ITUakUi1wwutAoBZVWPFvlF+4gJOP5DkaduDk6sEAnLSzpS9rMzJgRfmbWWQiqusLjMoQpZmTppHASLUFZjDlq/F2sRz2vZzH1IuHIRG7oFavtmwjbw/DEOW9ApEwyqFdcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euS3oVCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB881C4CEEF;
	Wed,  9 Jul 2025 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752055620;
	bh=aj5GWlIdlYL9xg/nY5anso++f0e3szkPgL2qAgC7f1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euS3oVCsWsVrj0UZZc02oiJqlcI0mXrS8v+FLpR48l7k+uvf6XtfPN2RrZAftI5mK
	 okKy1h+HigfnVfJxwK/eMPtKy6P3mS2Z3gCgw+W3hDsEb0UMmwR+MgyYXFGs8gla4F
	 GvY5m+7SBOhux+y3T8lr39ncZQHUEkKttZL/bAwU=
Date: Wed, 9 Jul 2025 12:06:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
	valentina.manea.m@gmail.com, i@zenithal.me,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	zhouzongmin@kylinos.cn
Subject: Re: [PATCH v2] usbip: convert to use faux_device
Message-ID: <2025070949-activist-mammal-b806@gregkh>
References: <9d95bb75-586c-48dc-9e34-432cc13fd99f@163.com>
 <2025062004-navy-emboss-4743@gregkh>
 <2e0bbc5a-e74a-4fb5-884c-686dbaf99caf@linuxfoundation.org>
 <48ab511e-2847-4daa-98de-a234b8584b78@163.com>
 <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>

On Wed, Jul 09, 2025 at 05:07:24PM +0800, Zongmin Zhou wrote:
> > > In fact, I've experimented with adding PM hooks to the faux bus,
> > > and found that faux bus devices then behave identically to platform
> > > bus devices during suspend/resume.
> > > See the attachment.
> > > 
> > 
> > Thanks for checking this scenario. No surprises here.
> Another part of my purpose in doing this is that the vhci-hcd driver seems
> should still retain suspend/resume hooks. Therefore, the faux bus should
> add corresponding hooks to allow the driver to call its own pm functions.
> Though currently don't know how to fix this problem yet.

I have no problem with adding the pm functions to the faux bus, BUT it
needs to make sense as to why they would be needed at all as this is not
a "real" device or bus that should need to do anything when
suspend/resume happens.

thanks,

greg k-h

