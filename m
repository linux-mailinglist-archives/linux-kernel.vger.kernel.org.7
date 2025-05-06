Return-Path: <linux-kernel+bounces-635616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15514AABFE9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B027BCF50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F326989A;
	Tue,  6 May 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjMo+lJx"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5932136358
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524282; cv=none; b=kc+r8vEk4oWfda+28yt0ZOnxYYLRHXfuXDpZQZg69VgGkMpZE0UxD6WykCW3FOk7R61N079BAClE70bTrzJeEV7nRDel5K+9JnJviivoZUb7kpWftZ/MdJme2ujfXH98MJHstUaHBctpyxRg/LNWeqmPqE4wUZPjzEKkhfZKnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524282; c=relaxed/simple;
	bh=td4KxZJj9ZC3lfXVR+NV6kF/R+poHYOhA0qBFY0XCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOpvPG3T83nICtywDNe7qcIih0u45MAA4pp32knef844GJdCM1CsZFnTGZfa4MyIPv5Kymx/ftReD6h/wWP6zvcI7QD7zoU7Ln2zzVjEVEt7OJxgrd4jZiLz2ldtI+pQjbWA4wh/o1j/rThiBYaJQbanZeCeqyvWB8jqB1fUOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjMo+lJx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 11:37:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746524278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfsYpFsr9RNeBOeKfu7LBceF449mTxPSBw5DxWmK0vU=;
	b=kjMo+lJxglyW+HW6SVJc9/Qgl7puu+4gNLdj9xSsU+k8J5oz/cCKpCuNLRg3gFfNVRoIlk
	DXFSLPynfZN/Q8AzbRBy9xKmlN0czDA0QC/m7yRShUgMi1r4VI78J3ye5PG+qxRparfFhj
	UUuTRyhSBg7BI4Evi9GOpioG8bYxSdI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Richard Leitner <richard.leitner@linux.dev>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 8/9] media: i2c: ov9282: add strobe_duration v4l2
 control
Message-ID: <33ocihn7niukhio2b4zpw6sh224q6p6lmrsfvpsca6bzbzddzm@m5dzx4uponxq>
References: <20250429-ov9282-flash-strobe-v3-0-2105ce179952@linux.dev>
 <20250429-ov9282-flash-strobe-v3-8-2105ce179952@linux.dev>
 <aBHe-55_U3bYTXyG@kekkonen.localdomain>
 <t7lnqmhufsyf5ygfkfyllvxpm4h2qdxotgi2lcfoxlhxjpejjd@mf2poxik2zje>
 <aBP0Lioy6Qi0Iw66@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBP0Lioy6Qi0Iw66@kekkonen.localdomain>
X-Migadu-Flow: FLOW_OUT

On Thu, May 01, 2025 at 10:22:38PM +0000, Sakari Ailus wrote:
> Hi Richard,
> 
> On Wed, Apr 30, 2025 at 11:09:30AM +0200, Richard Leitner wrote:
> > Hi Sakari,
> > 
> > thanks for the review!
> 
> You're welcome.
> 
> > > > +	v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops, V4L2_CID_FLASH_DURATION,
> > > 
> > > Should the number of controls in the handler be updated?
> > 
> > What do you mean by "number of controls in the handler" exactly? Which
> > handler?
> 
> A number of buckets allocated in control handler's initialisation is based
> on the number of controls given to the init function. You should update
> that number when adding controls.

Ah, now I got it. :-)

Thanks for the clarification. Will fix that in v4 for all newly added
controls!

regards;rl

> 
> -- 
> Regards,
> 
> Sakari Ailus

