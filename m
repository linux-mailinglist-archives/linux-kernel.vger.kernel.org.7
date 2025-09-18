Return-Path: <linux-kernel+bounces-794358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF31B3E08B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3E61A811C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8FA30FC1F;
	Mon,  1 Sep 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3kw5ZHy"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB982494F8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723469; cv=none; b=G7ew1Q7+RxsdNlj4+VeOSVFpv36edGCvZXk8x/YM1NJ5oGP6hhFZRruRQx2zC0t0UcMypy1iLJAYXIGSdHaSDIoHy2g+AJV+j3+KWFZbRkhKwY1HCZjx75GJeGH5LB6YqolQCUUvZJSC/qUK0KA/h8PlweaUpjx+pl1Fj++dSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723469; c=relaxed/simple;
	bh=6THE98mcDom9w0YncY2cuBO0AEoX8fSOu4k2kwNBuxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCQF9vvFAMgeHeag3Z+1Rwz3POQLcUNJYY/AiJ3dtQBBYsZZCcbxsc928g/7Sx7S7dtzAD9OOK6gOyDKwMapah+XkQ05LWFn3pCa8S8MzwJK48eAqXFOjZ9oihzvMMCxe5gjmCHLQ+jdDonYKDWfCsZXI/bNGIyYtO9JRVbPFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3kw5ZHy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Sep 2025 12:44:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756723455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S4fuRk+bvbyu3AGCXqWWILKtUl2HbqJIAPTs34e4wg=;
	b=h3kw5ZHyQ6ph/2Enddeqos4frNf3RhMiFacv4NTFlgzHayIdK79JES6w5APQtac8+iGVRw
	5wb1DrMnIVTYbqFPyUApEMYCzqgrqTKVYzXcx4QT/ofN+6gsBuf9QVXE+NZHIAHY+iKDUQ
	LW0hLe3LcpS/VcLo/XSux9RlQHKXelU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Richard Leitner <richard.leitner@linux.dev>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 03/11] Documentation: uAPI: media: add
 V4L2_CID_FLASH_DURATION
Message-ID: <rcgche43hzctpxbe2xt2cfksjbtyntc6ef26wptgkygcdlg5ga@sdhkkcpdfaek>
References: <20250716-ov9282-flash-strobe-v6-0-934f12aeff33@linux.dev>
 <20250716-ov9282-flash-strobe-v6-3-934f12aeff33@linux.dev>
 <aKv3uUXf87im8ajX@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKv3uUXf87im8ajX@kekkonen.localdomain>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 25, 2025 at 08:42:17AM +0300, Sakari Ailus wrote:
> Hi Richard,
> 
> Thanks for the update (and for the ping!).
> 
> On Wed, Jul 16, 2025 at 11:06:53AM +0200, Richard Leitner wrote:
> > Add the new strobe_duration control to v4l uAPI documentation.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> > ---
> >  Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
> > index d22c5efb806a183a3ad67ec3e6550b002a51659a..03a58ef94be7c870f55d5a9bb09503995dbfb402 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
> > @@ -186,3 +186,8 @@ Flash Control IDs
> >      charged before strobing. LED flashes often require a cooldown period
> >      after strobe during which another strobe will not be possible. This
> >      is a read-only control.
> > +
> > +``V4L2_CID_FLASH_DURATION (integer)``
> > +    Duration the flash should be on when the flash LED is in flash mode
> > +    (V4L2_FLASH_LED_MODE_FLASH). The unit should be microseconds (�s)
> > +    if possible.
> > 
> 
> I think we should add this is related to the hardware strobe.
> 
> How about:
> 
> ``V4L2_CID_FLASH_DURATION (integer)``
> 
>     Duration of the flash strobe from the strobe source, typically a camera
>     sensor. Controlling the flash LED strobe length this way requires that the
>     flash LED driver's :ref:`flash LED mode <v4l2-cid-flash-led-mode>` is set
>     to ``V4L2_FLASH_LED_MODE_FLASH`` and :ref:`strobe source
>     <v4l2-cid-strobe-source>` is set to ``V4L2_FLASH_STROBE_SOURCE_EXTERNAL``.
>     The unit should be microseconds (�s) if possible.
> 
> This requires of course the appropriate labels.
> 
> I also wonder whether we should use 0,1 �s or even ns for the unit.

Thanks for the pointer.

I did a quick internet search and the shortest flash duration of
speedlights/studio strobes I found was Profoto D2 with 1/63000 sec ~> 15.9�s.
So I IMHO we are fine with 1�s resolution here.

regards;rl

> 
> -- 
> Kind regards,
> 
> Sakari Ailus

