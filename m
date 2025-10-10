Return-Path: <linux-kernel+bounces-848731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C38BCE727
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE6314F1288
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA40302148;
	Fri, 10 Oct 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="l2raaEEq"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D222F6171
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126850; cv=none; b=nyCwgA3PZvmGHUqmE18HLes7xonrYOgj0bXa22Q/Je5Xrizb7RXuGM7Se5AVI4qrLJBcobY/uoEIOZ8YBh+2PCXKfmBQ0nD8wvYcV+CVDalpSfn1gK/j/FbItFstMgdoVkWdhxqDZJFJG6JU36AqYnhysKxU8Fo1hnO9rMSNrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126850; c=relaxed/simple;
	bh=yRUjUuUXNBLsIN1szrFomtxYw/WYo3wHfGbwO0TlmkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDh4P49Rrrzh8HmPevfJpsTI4o3GJqgdv2soAnGm1os43B779e0CbP37k3XY8hm4F9XIZtORZj2it8HRgippWs+vibvAEGzobeJq1O/7/eYung0uh+TkPseKQiL4fpWn0AIB3TTplx8MVgUk+wKqb6w7NKh6Er3GteJSn+ZubGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=l2raaEEq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=sXtr63u17hNsb6FiIpfCvPf15KtfGYlPLgI+MFIT+c8=; b=l2raaEEqeEl6EphL
	CkMZh3dEiisioiZXtVuUW37f/tunF6SwnBL4J6xQpZ14g7wvTbrN6Gjk9I++q3pvkjOxjRGy9DMK2
	VRPQXPTSaYOD1jit2q4HS1XglRswcDTlgRV8yAYaXUVDEkBqKzHFszL/M5pQHu0v7EEziGvv6tt99
	xAYCOWXyTSVEFISkQqIsH+KPA90V/DUmmKnngoo7ROBU44U7Izi1YvPVyQLcG3h1PjHlZyMtrzbyM
	gWM4oxVh2hmfDeQ0Lcry6zBsZDgmlhXF9l6HgqAcuXjdz9d1drcEOjQVmdJioITjMV7EMIa+eaK9T
	ahvBcYUv05wsgFguOQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1v7JOW-00FmK3-2H;
	Fri, 10 Oct 2025 20:07:16 +0000
Date: Fri, 10 Oct 2025 20:07:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>, wcn36xx@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: wcn36xx: Remove unused
 wcn36xx_smd_update_scan_params
Message-ID: <aOlndHPBg-SBZ-zU@gallifrey>
References: <20250619010506.296494-1-linux@treblig.org>
 <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
 <aOfT806hw7l2BeJu@gallifrey>
 <CAFEp6-3tq4FkiBLO20mk2HU1QkbyVMbyutu11v7b8PSyps2Qjw@mail.gmail.com>
 <83b4ff7d-2443-4ba9-8103-77c8dde518f2@oss.qualcomm.com>
 <aOhXV7IdoI0aBT1j@gallifrey>
 <CAFEp6-085_uTZtjpku5ffq9+81OpPcFBJb3jXzeWbzKmQwFy9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-085_uTZtjpku5ffq9+81OpPcFBJb3jXzeWbzKmQwFy9Q@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:06:50 up 166 days,  4:20,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
> Hi Dave,
> 
> On Fri, Oct 10, 2025 at 2:46 AM Dr. David Alan Gilbert
> <linux@treblig.org> wrote:
> >
> > * Jeff Johnson (jeff.johnson@oss.qualcomm.com) wrote:
> > > On 10/9/2025 3:15 PM, Loic Poulain wrote:
> > > > Hi Jeff,
> > > >
> > > > On Thu, Oct 9, 2025 at 5:25 PM Dr. David Alan Gilbert <linux@treblig.org> wrote:
> > > >>
> > > >> * Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
> > > >>> On Thu, Jun 19, 2025 at 3:05 AM <linux@treblig.org> wrote:
> > > >>>>
> > > >>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >>>>
> > > >>>> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> > > >>>> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> > > >>>>
> > > >>>> Remove it.
> > > >>>>
> > > >>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > >>>
> > > >>> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > >>
> > > >> Hi Loic,
> > > >>   Is this getting into a pull somewhere?
> > > >
> > > > Can it be picked for ath10-next?
> > >
> > > This was not on my radar since it wasn't sent to linux-wireless and hence
> > > isn't tracked in patchwork. I just looked at it and it seems the following are
> > > now also unused and could be removed:
> > > struct wcn36xx_hal_update_scan_params_resp
> > > struct wcn36xx_hal_update_scan_params_req_ex
> >
> > Oh, I'm happy to cook a v2 for that if Loic agrees they should go
> > (I know some drivers like to keep struct definitions if they document the hardware)
> 
> The software based scanning never worked very well, so I'm not even
> sure the related structs are correct or complete, so it's ok to remove
> in your v2.

Sure.

> > > Let me know if you want me to take this as-is or wait for a v2. If you send a
> > > v2 please also include linux-wireless so that it is tracked by patchwork.
> >
> > Sure.
> >
> > Note that linux-wireless isn't included in get_maintainer output for this:
> >
> > $ scripts/get_maintainer.pl -f drivers/net/wireless/ath/wcn36xx/smd.c
> > Loic Poulain <loic.poulain@oss.qualcomm.com> (maintainer:QUALCOMM WCN36XX WIRELESS DRIVER)
> > wcn36xx@lists.infradead.org (open list:QUALCOMM WCN36XX WIRELESS DRIVER)
> > linux-kernel@vger.kernel.org (open list)
> > QUALCOMM WCN36XX WIRELESS DRIVER status: Supported
> 
> Indeed, would you mind submitting a fix for the MAINTAINERS file?

No problem.

I'll cook a pair of patches.

Dave

> Regards,
> Loic
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

