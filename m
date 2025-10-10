Return-Path: <linux-kernel+bounces-847623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D3BCB4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF113C18F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B117BB21;
	Fri, 10 Oct 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Y6ZrgD2B"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4434BA58
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760057189; cv=none; b=jiac+xhsz4EMlDA4f/Iw9m8jlI4QVTHTCAbUsP8qE0NTtUIl1Xm+ChmU9EbOy5xRudj4TMnxrxCGo8SC3kHNvFFve4xMtuK4JKwYyvj/wBiRAChqkoLV3X7cmQoO8U/IDzlL06XcR5QiSr/EK9gMqNlIQjEHbh/ScrYfXOiJzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760057189; c=relaxed/simple;
	bh=JG4uRBasNBrQvm5z6M/bQH1ErsDDrtroNhq1hSHj/Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CanVS8mw5dmeiZPVp4zKWCeLziHHIhBEyrudSiwdZBV5diBgGhqyj3+TkpGg9Fw6U5bM3Vsf9z1dcS3BWhcuJ6/HFz0wkHTeFtZnj/9q1MenQdBWhv9uzEykxU4wWeHaL1M2pcYgPvXDy9tDjpmIGSrIc2dG3RFC2jDU2IchZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Y6ZrgD2B; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=3pVfKKhBgGhX0v6ra9O/qOFXXSLOCc46ccudL8iVlA4=; b=Y6ZrgD2BojKEA6zg
	errHrNJUSqW6GhnVe6FRWP0EmoThrful3b/Lc26/V1EYAEJfpiBMXhevfysHsqfXweuj36/3zzwlK
	aC8yClYNKfmpldgbcDPN0kKEbVCdDwaSoTFsCJUZDO44hG1LOS38IN1IkvKUplXAX+kdrgApvhCCa
	lYVEkhWQyrccMDLkwIvP230YPHYgmvF+aqpRgTrWezDbDWiznYRp2nEl7YZ3+vUAzObWD8I3omzJq
	5nRCW1cK+tnKpG9toFfoph9RRhoOOJdFJ5zPJ9uJBwkW4HSh83a9ccccvW8Ab1oqI/uh7O0Gw/3w4
	8HBSQ9JBIojYsMnZ/g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1v71Gx-00FcQw-2S;
	Fri, 10 Oct 2025 00:46:15 +0000
Date: Fri, 10 Oct 2025 00:46:15 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>, wcn36xx@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: wcn36xx: Remove unused
 wcn36xx_smd_update_scan_params
Message-ID: <aOhXV7IdoI0aBT1j@gallifrey>
References: <20250619010506.296494-1-linux@treblig.org>
 <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
 <aOfT806hw7l2BeJu@gallifrey>
 <CAFEp6-3tq4FkiBLO20mk2HU1QkbyVMbyutu11v7b8PSyps2Qjw@mail.gmail.com>
 <83b4ff7d-2443-4ba9-8103-77c8dde518f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b4ff7d-2443-4ba9-8103-77c8dde518f2@oss.qualcomm.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:44:28 up 165 days,  8:58,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jeff Johnson (jeff.johnson@oss.qualcomm.com) wrote:
> On 10/9/2025 3:15 PM, Loic Poulain wrote:
> > Hi Jeff,
> > 
> > On Thu, Oct 9, 2025 at 5:25 PM Dr. David Alan Gilbert <linux@treblig.org> wrote:
> >>
> >> * Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
> >>> On Thu, Jun 19, 2025 at 3:05 AM <linux@treblig.org> wrote:
> >>>>
> >>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>>>
> >>>> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> >>>> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> >>>>
> >>>> Remove it.
> >>>>
> >>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >>>
> >>> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>
> >> Hi Loic,
> >>   Is this getting into a pull somewhere?
> > 
> > Can it be picked for ath10-next?
> 
> This was not on my radar since it wasn't sent to linux-wireless and hence
> isn't tracked in patchwork. I just looked at it and it seems the following are
> now also unused and could be removed:
> struct wcn36xx_hal_update_scan_params_resp
> struct wcn36xx_hal_update_scan_params_req_ex

Oh, I'm happy to cook a v2 for that if Loic agrees they should go
(I know some drivers like to keep struct definitions if they document the hardware)

> Let me know if you want me to take this as-is or wait for a v2. If you send a
> v2 please also include linux-wireless so that it is tracked by patchwork.

Sure.

Note that linux-wireless isn't included in get_maintainer output for this:

$ scripts/get_maintainer.pl -f drivers/net/wireless/ath/wcn36xx/smd.c
Loic Poulain <loic.poulain@oss.qualcomm.com> (maintainer:QUALCOMM WCN36XX WIRELESS DRIVER)
wcn36xx@lists.infradead.org (open list:QUALCOMM WCN36XX WIRELESS DRIVER)
linux-kernel@vger.kernel.org (open list)
QUALCOMM WCN36XX WIRELESS DRIVER status: Supported

Dave

> /jeff
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

