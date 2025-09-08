Return-Path: <linux-kernel+bounces-805942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC8B48FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC516EF32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF91E5B64;
	Mon,  8 Sep 2025 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cnOvDi8f"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275E30AD19
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338554; cv=none; b=Yx+atDCFb3w9nDiqBjLxcv1DnaH5RphFMCaQ++meh8LQCBmSglRk2sirzRBuH+Ba85p30NXzlP6tI4nS9d3Su4UbYiEzbQXGTHsXS/o3Qab2hFkci6EjWkUni0GH+6QgHuLSnPl+a66qLhfPTOpWRtkyFSGTxYsfcvoRyN1iNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338554; c=relaxed/simple;
	bh=QlTLqNc89PFy/lYlep+bGSoF2OH8UGwJuVCbEjw9SEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clX9roSaWRHI2N627XUG8ewgOQ0I3CEaBaJkzb6D77O4eGMY6lYSxZvSYwnOBTtC8Dh8DgopDTqCkKlpLDStxHxSJosDd2u1kOeWPAWv07IEl62xReRJ/DbkigFsik15Tsrq70ew7z3na/pK/C2gNIOvX/a77eVlCbz8uM/I8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cnOvDi8f; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-134-76-nat.elisa-mobile.fi [85.76.134.76])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 6184499F;
	Mon,  8 Sep 2025 15:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757338478;
	bh=QlTLqNc89PFy/lYlep+bGSoF2OH8UGwJuVCbEjw9SEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnOvDi8fmOn4iFEW/0psuE1Hvib/uu/MIpR99Ok+ntP+dESabK64/nYulQ29GaTVO
	 eLBiUgS92dxt8O8F3Ind4Y/H0NZWkTTjz4F04V8tnyd7PqFzIAa7K0mduG65MfbRrS
	 lKz01QWIlnQtxUez1GfFxr9ua9SIEt4pkhxRMh1Y=
Date: Mon, 8 Sep 2025 15:35:27 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH v2 0/5] staging: Destage VCHIQ interface and MMAL
Message-ID: <20250908133527.GE26062@pendragon.ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
 <aL5uKTiEYZP68xLd@stanley.mountain>
 <175733014607.8095.7451233410776368088@freya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <175733014607.8095.7451233410776368088@freya>

On Mon, Sep 08, 2025 at 04:45:46PM +0530, Jai Luthra wrote:
> Quoting Dan Carpenter (2025-09-08 11:18:25)
> > It's really hard to review the code when it's just sigle line like
> > this:
> > 
> > >  .../raspberrypi/vchiq-interface}/vchiq_arm.c       |    9 +-
> > 
> > It's also a head ache to do a cat -n filename and then copy and paste
> > it into an email message...  I thought there was a trick to make the
> > diff show up in the email?
> > 
> 
> I am not sure how to configure b4 to give the full file path instead of
> shortening it after the first file in a list.
> 
> Does git-format-patch already have some option? I can use that to ease
> reviews till b4 adds support for this feature.

--stat=-1 should help. I don't know if -1 happens to work or is the
official way to remove the limit. --stat=65535 should be big enough too
:-)

> Or did I misunderstand your problem?

-- 
Regards,

Laurent Pinchart

